Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4087CB49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 19:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfGaR7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 13:59:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfGaR7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SFbQnaoqsadI4zyK9FmZVb5jRGBvcMhtkf9xAvnYNi0=; b=aAVijrZ1LE/V5A1EQp4VZOkJM
        ohKRVqFkOOvbCn7csYPUyuYkpmOfxJ3MV0Is8wwvxFqh7Fs0TkJT6uMH51byCzcUZSbXTgqabZKTJ
        riUU+p7elN67dDAFSpeLVY6pOmWJbb2+bEKUbST3ls7qbj8AFNJ3xs5KYln9zmwP1pXyoghgZH+VK
        7NMQXTsEQG0TlgK6aNSp0h7O3rO2anqBNE2bnMoPlrSy7/O+MdQLi/QhGoUbg7I62V7l8FUSETVKQ
        WpFYlO/3KY/y4WTIAwbTRJXEaAAJoH/9iI0cKTeeV1+hUhy4WMpntPNj78/Z+xsf1gPn0M86snBjr
        q4sn+qwDQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hsssh-0006Re-8U; Wed, 31 Jul 2019 17:59:19 +0000
Date:   Wed, 31 Jul 2019 10:59:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC 0/2] iomap & xfs support for large pages
Message-ID: <20190731175919.GF4700@bombadil.infradead.org>
References: <20190731171734.21601-1-willy@infradead.org>
 <CAPhsuW66e=7g+rPhi3NU8jQRGqQEz0oQ5XJerg6ds=oxMz8U1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW66e=7g+rPhi3NU8jQRGqQEz0oQ5XJerg6ds=oxMz8U1g@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 10:50:40AM -0700, Song Liu wrote:
> On Wed, Jul 31, 2019 at 10:17 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >
> > Christoph sent me a patch a few months ago called "XFS THP wip".
> > I've redone it based on current linus tree, plus the page_size() /
> > compound_nr() / page_shift() patches currently found in -mm.  I fixed
> > the logic bugs that I noticed in his patch and may have introduced some
> > of my own.  I have only compile tested this code.
> 
> Would Bill's set work on XFS with this set?

If there are no bugs in his code or mine ;-)

It'd also need to be wired up; something like this:

+++ b/fs/xfs/xfs_file.c
@@ -1131,6 +1131,8 @@ __xfs_filemap_fault(
        } else {
                if (write_fault)
                        ret = iomap_page_mkwrite(vmf, &xfs_iomap_ops);
+               else if (pe_size)
+                       ret = filemap_huge_fault(vmf, pe_size);
                else
                        ret = filemap_fault(vmf);
        }
@@ -1156,9 +1158,6 @@ xfs_filemap_huge_fault(
        struct vm_fault         *vmf,
        enum page_entry_size    pe_size)
 {
-       if (!IS_DAX(file_inode(vmf->vma->vm_file)))
-               return VM_FAULT_FALLBACK;
-
        /* DAX can shortcut the normal fault path on write faults! */
        return __xfs_filemap_fault(vmf, pe_size,
                        (vmf->flags & FAULT_FLAG_WRITE));

(untested)

