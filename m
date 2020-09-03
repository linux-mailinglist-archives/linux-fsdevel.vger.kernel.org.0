Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB6E25BB69
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 09:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgICHLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 03:11:49 -0400
Received: from verein.lst.de ([213.95.11.211]:36619 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgICHLt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:11:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0164568BEB; Thu,  3 Sep 2020 09:11:44 +0200 (CEST)
Date:   Thu, 3 Sep 2020 09:11:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/10] powerpc: remove address space overrides using
 set_fs()
Message-ID: <20200903071144.GA19247@lst.de>
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-11-hch@lst.de> <8974838a-a0b1-1806-4a3a-e983deda67ca@csgroup.eu> <20200902123646.GA31184@lst.de> <d78cb4be-48a9-a7c5-d9d1-d04d2a02b4c6@csgroup.eu> <CAHk-=wiDCcxuHgENo3UtdFi2QW9B7yXvNpG5CtF=A6bc6PTTgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiDCcxuHgENo3UtdFi2QW9B7yXvNpG5CtF=A6bc6PTTgA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:02:22AM -0700, Linus Torvalds wrote:
> I don't see why this change would make any difference.

Me neither, but while looking at a different project I did spot places
that actually do an access_ok with len 0, that's why I wanted him to
try.

That being said: Christophe are these number stables?  Do you get
similar numbers with multiple runs?

> And btw, why do the 32-bit and 64-bit checks even differ? It's not
> like the extra (single) instruction should even matter. I think the
> main reason is that the simpler 64-bit case could stay as a macro
> (because it only uses "addr" and "size" once), but honestly, that
> "simplification" doesn't help when you then need to have that #ifdef
> for the 32-bit case and an inline function anyway.

I'll have to leave that to the powerpc folks.  The intent was to not
change the behavior (and I even fucked that up for the the size == 0
case).

> However, I suspect a bigger reason for the actual performance
> degradation would be the patch that makes things use "write_iter()"
> for writing, even when a simpler "write()" exists.

Except that we do not actually have such a patch.  For normal user
writes we only use ->write_iter if ->write is not present.  But what
shows up in the profile is that /dev/zero only has a read_iter op and
not a normal read.  I've added a patch below that implements a normal
read which might help a tad with this workload, but should not be part
of a regression.

Also Christophe:  can you bisect which patch starts this?  Is it really
this last patch in the series?

---
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index abd4ffdc8cdebc..1dc99ab158457a 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -726,6 +726,27 @@ static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter)
 	return written;
 }
 
+static ssize_t read_zero(struct file *file, char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	size_t cleared = 0;
+
+	while (count) {
+		size_t chunk = min_t(size_t, count, PAGE_SIZE);
+
+		if (clear_user(buf + cleared, chunk))
+			return cleared ? cleared : -EFAULT;
+		cleared += chunk;
+		count -= chunk;
+
+		if (signal_pending(current))
+			return cleared ? cleared : -ERESTARTSYS;
+		cond_resched();
+	}
+
+	return cleared;
+}
+
 static int mmap_zero(struct file *file, struct vm_area_struct *vma)
 {
 #ifndef CONFIG_MMU
@@ -921,6 +942,7 @@ static const struct file_operations zero_fops = {
 	.llseek		= zero_lseek,
 	.write		= write_zero,
 	.read_iter	= read_iter_zero,
+	.read		= read_zero,
 	.write_iter	= write_iter_zero,
 	.mmap		= mmap_zero,
 	.get_unmapped_area = get_unmapped_area_zero,
