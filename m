Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4545A26B7AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgIPA1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgIOOH6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:07:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6835C061353;
        Tue, 15 Sep 2020 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QQCg8wThFn26iWjkLyQ1p1ZuQ6QQ5ZhJ4G2t+9AEEWg=; b=EAJrOVAfkyS7EnI/93mYMhdXbq
        930pI+nqX3TusVRoKiooSZ5E1XWHK/5GNadBq6AAOiiFcItkNRP54OVJiIurFd89UC2V8hGAlT5qs
        tmBO3/28DHpk/P/csSJy96/NJ6eRLqoUrUZpLQJmVWWOQ5nmIm0A4uMvXolRCZPYAa+Q2IYG/zsmn
        jFe79PEkiZdCGSkpsTMq0V7DsLvaPFWFtrYdRMNuFJsDYtaQKPiVU4O/MqVbl89/0bML50U/QIVAZ
        azXhK0gbTm0/pFqDSLZU67Rj1XzfUfEououZlect8GfHSU5Oypj5IUqwF6diyGZkWO5wLBg6LAanA
        Jcos6MiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIBO2-0003js-2e; Tue, 15 Sep 2020 13:52:46 +0000
Date:   Tue, 15 Sep 2020 14:52:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Kernel Benchmarking
Message-ID: <20200915135246.GG5449@casper.infradead.org>
References: <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com>
 <20200912143704.GB6583@casper.infradead.org>
 <803672c0-7c57-9d25-ffb4-cde891eac4d3@MichaelLarabel.com>
 <20200915033210.GA5449@casper.infradead.org>
 <20200915103938.GL4863@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915103938.GL4863@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 12:39:38PM +0200, Jan Kara wrote:
> Hi Matthew!
> 
> On Tue 15-09-20 04:32:10, Matthew Wilcox wrote:
> > On Sat, Sep 12, 2020 at 09:44:15AM -0500, Michael Larabel wrote:
> > > Interesting, I'll fire up some cross-filesystem benchmarks with those tests
> > > today and report back shortly with the difference.
> > 
> > If you have time, perhaps you'd like to try this patch.  It tries to
> > handle page faults locklessly when possible, which should be the case
> > where you're seeing page lock contention.  I've tried to be fairly
> > conservative in this patch; reducing page lock acquisition should be
> > possible in more cases.
> 
> So I'd be somewhat uneasy with this optimization. The thing is that e.g.
> page migration relies on page lock protecting page from being mapped? How
> does your patch handle that? I'm also not sure if the rmap code is really
> ready for new page reverse mapping being added without holding page lock...

I admit to not even having looked at the page migration code.  This
patch was really to demonstrate that it's _possible_ to do page faults
without taking the page lock.

It's possible to expand the ClearPageUptodate page validity protocol
beyond mm/truncate.c, of course.  We can find all necessary places to
change by grepping for 'page_mapped'.  Some places (eg the invalidate2
path) can't safely ClearPageUptodate before their existing call to
unmap_mapping_pages(), and those places will have to add a second
test-and-call.

It seems to me the page_add_file_rmap() is fine with being called
without the page lock, unless the page is compound.  So we could
make sure not to use this new protocol for THPs ...

+++ b/mm/filemap.c
@@ -2604,7 +2604,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 
        if (fpin)
                goto out_retry;
-       if (likely(PageUptodate(page))) {
+       if (likely(PageUptodate(page) && !PageTransHuge(page))) {
                ret |= VM_FAULT_UPTODATE;
                goto uptodate;
        }
diff --git a/mm/memory.c b/mm/memory.c
index 53c8ef2bb38b..6981e8738df4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3460,6 +3460,9 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
                return VM_FAULT_HWPOISON;
        }
 
+       /* rmap needs THP pages to be locked in case it's mlocked */
+       VM_BUG_ON((ret & VM_FAULT_UPTODATE) && PageTransHuge(page));
+
        return ret;
 }


