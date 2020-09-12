Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1456626782D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 08:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgILGT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 02:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgILGTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 02:19:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D41C061573;
        Fri, 11 Sep 2020 23:19:25 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b6so13344051iof.6;
        Fri, 11 Sep 2020 23:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWUUdByFvtqb1glreh6Bs2mDpnkxfWc+Wt1JUPVGjnk=;
        b=oeRCKcxXBk+ojLrRlwIdT3VESa294A5UXZF4bv+munDBcqKQw8iEd1t+/7K8ouFph0
         rQyy8ekphcTE3vjeYDn7BG5mWubXgm4IT4aNf3a4x9s5EVh9BStZPNw1DBTgFRKAgVTj
         vCedXQa5w8KuAnyx6OSAjFDtfDfYEWhdpPhx923FHm29ohE1utAiJAZQ/1nZ9b917Vem
         wqIoU3oP7v7MinNN50b0n0FNseDccrMs1IM8p70+mOkKsJ3/pRWsfbUDp4HQqoSoCKDo
         bvQeDXU5Q4Ls5jDabFolMZQG+2pOFLqQ1IdB1bl/mBMRHOFJPfF4aSycwsSSody+CKp/
         wdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWUUdByFvtqb1glreh6Bs2mDpnkxfWc+Wt1JUPVGjnk=;
        b=EWwvhLZ8AVJVxiDYUsYMyq1F+genR91EcWPAs56l6jN1hU0k32VjfT00VRePUAJE6Q
         2xvW1T3birg1iVKhUSXFgvpgpckwuIz0JQ1KC/3HgTPpswG1TOQwIo0whwqmXTAkcIa5
         UYVP+Z60KZ66K9y1xrGt42bL+1HIW8cEMGyh4ylnChopo1bmq+lffK2THdXKSq1gkkYF
         lpKTiGYlHUvIP+866+10XrCyDH7kTakbx620f0sdhGTzrLrOvnZGGF951TPzome9BczK
         EXAWR/dzJ9Vt9IC1KuTfx1rgx51D/+LkxpQJnp+wC3+wTMiql8m6Nafapp7fFmuN6UlP
         c+tw==
X-Gm-Message-State: AOAM530dm69ShM5ShCUUMN8k+Lu9AZ9sXcaFTaK9JJrLxvQOYMuFwRNX
        JbW0tu6+6AJ0blqQITipNmcdJMkdrVuIm54V260=
X-Google-Smtp-Source: ABdhPJwJ++P1wFa8xAYXha0p/f9NmOdh5QtDmdi2cIbl3aMXW1zuAUNjHk5PNBxI8lAoW3lZaC9GGWhxDbVOKw7wuEk=
X-Received: by 2002:a05:6602:2e81:: with SMTP id m1mr4459738iow.64.1599891562643;
 Fri, 11 Sep 2020 23:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200623052059.1893966-1-david@fromorbit.com>
In-Reply-To: <20200623052059.1893966-1-david@fromorbit.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Sep 2020 09:19:11 +0300
Message-ID: <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
Subject: More filesystem need this fix (xfs: use MMAPLOCK around filemap_map_pages())
To:     Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Qiuyang Sun <sunqiuyang@huawei.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 8:21 AM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> The page faultround path ->map_pages is implemented in XFS via
> filemap_map_pages(). This function checks that pages found in page
> cache lookups have not raced with truncate based invalidation by
> checking page->mapping is correct and page->index is within EOF.
>
> However, we've known for a long time that this is not sufficient to
> protect against races with invalidations done by operations that do
> not change EOF. e.g. hole punching and other fallocate() based
> direct extent manipulations. The way we protect against these
> races is we wrap the page fault operations in a XFS_MMAPLOCK_SHARED
> lock so they serialise against fallocate and truncate before calling
> into the filemap function that processes the fault.
>
> Do the same for XFS's ->map_pages implementation to close this
> potential data corruption issue.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 7b05f8fd7b3d..4b185a907432 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1266,10 +1266,23 @@ xfs_filemap_pfn_mkwrite(
>         return __xfs_filemap_fault(vmf, PE_SIZE_PTE, true);
>  }
>
> +static void
> +xfs_filemap_map_pages(
> +       struct vm_fault         *vmf,
> +       pgoff_t                 start_pgoff,
> +       pgoff_t                 end_pgoff)
> +{
> +       struct inode            *inode = file_inode(vmf->vma->vm_file);
> +
> +       xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> +       filemap_map_pages(vmf, start_pgoff, end_pgoff);
> +       xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> +}
> +
>  static const struct vm_operations_struct xfs_file_vm_ops = {
>         .fault          = xfs_filemap_fault,
>         .huge_fault     = xfs_filemap_huge_fault,
> -       .map_pages      = filemap_map_pages,
> +       .map_pages      = xfs_filemap_map_pages,
>         .page_mkwrite   = xfs_filemap_page_mkwrite,
>         .pfn_mkwrite    = xfs_filemap_pfn_mkwrite,
>  };
> --
> 2.26.2.761.g0e0b3e54be
>

It appears that ext4, f2fs, gfs2, orangefs, zonefs also need this fix

zonefs does not support hole punching, so it may not need to use
mmap_sem at all.

It is interesting to look at how this bug came to be duplicated in so
many filesystems, because there are lessons to be learned.

Commit f1820361f83d ("mm: implement ->map_pages for page cache")
added to ->map_pages() operation and its commit message said:

"...It should be safe to use filemap_map_pages() for ->map_pages() if
    filesystem use filemap_fault() for ->fault()."

At the time, all of the aforementioned filesystems used filemap_fault()
for ->fault().

But since then, ext4, xfs, f2fs and just recently gfs2 have added a filesystem
->fault() operation.

orangefs has added vm_operations since and zonefs was added since,
probably copying the mmap_sem handling from ext4. Both have a filesystem
->fault() operation.

It was surprising for me to see that some of the filesystem developers
signed on the added ->fault() operations are not strangers to mm. The
recent gfs2 change was even reviewed by an established mm developer
[1].

So what can we learn from this case study? How could we fix the interface to
avoid repeating the same mistake in the future?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20200703113801.GD25523@casper.infradead.org/
