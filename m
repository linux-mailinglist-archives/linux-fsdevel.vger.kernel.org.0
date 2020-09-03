Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3226A25C5EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgICP5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 11:57:02 -0400
Received: from verein.lst.de ([213.95.11.211]:38410 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbgICP4s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:56:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 953B667357; Thu,  3 Sep 2020 17:56:44 +0200 (CEST)
Date:   Thu, 3 Sep 2020 17:56:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 14/14] powerpc: remove address space overrides using
 set_fs()
Message-ID: <20200903155644.GA23521@lst.de>
References: <20200903142242.925828-1-hch@lst.de> <20200903142242.925828-15-hch@lst.de> <e7d2d231-5658-a4d3-0495-2af62f34aa34@csgroup.eu> <20200903154909.GA23023@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200903154909.GA23023@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 03, 2020 at 05:49:09PM +0200, Christoph Hellwig wrote:
> On Thu, Sep 03, 2020 at 05:43:25PM +0200, Christophe Leroy wrote:
> >
> >
> > Le 03/09/2020 à 16:22, Christoph Hellwig a écrit :
> >> Stop providing the possibility to override the address space using
> >> set_fs() now that there is no need for that any more.
> >>
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >> ---
> >
> >
> >>   -static inline int __access_ok(unsigned long addr, unsigned long size,
> >> -			mm_segment_t seg)
> >> +static inline bool __access_ok(unsigned long addr, unsigned long size)
> >>   {
> >> -	if (addr > seg.seg)
> >> -		return 0;
> >> -	return (size == 0 || size - 1 <= seg.seg - addr);
> >> +	if (addr >= TASK_SIZE_MAX)
> >> +		return false;
> >> +	return size == 0 || size <= TASK_SIZE_MAX - addr;
> >>   }
> >
> > You don't need to test size == 0 anymore. It used to be necessary because 
> > of the 'size - 1', as size is unsigned.
> >
> > Now you can directly do
> >
> > 	return size <= TASK_SIZE_MAX - addr;
> >
> > If size is 0, this will always be true (because you already know that addr 
> > is not >= TASK_SIZE_MAX
> 
> True.  What do you think of Linus' comment about always using the
> ppc32 version on ppc64 as well with this?

i.e. something like this folded in:

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 5363f7fc6dd06c..be070254e50943 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -11,26 +11,14 @@
 #ifdef __powerpc64__
 /* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
 #define TASK_SIZE_MAX		TASK_SIZE_USER64
-
-/*
- * This check is sufficient because there is a large enough gap between user
- * addresses and the kernel addresses.
- */
-static inline bool __access_ok(unsigned long addr, unsigned long size)
-{
-	return addr < TASK_SIZE_MAX && size < TASK_SIZE_MAX;
-}
-
 #else
 #define TASK_SIZE_MAX		TASK_SIZE
+#endif
 
 static inline bool __access_ok(unsigned long addr, unsigned long size)
 {
-	if (addr >= TASK_SIZE_MAX)
-		return false;
-	return size == 0 || size <= TASK_SIZE_MAX - addr;
+	return addr < TASK_SIZE_MAX && size <= TASK_SIZE_MAX - addr;
 }
-#endif /* __powerpc64__ */
 
 #define access_ok(addr, size)		\
 	(__chk_user_ptr(addr),		\
