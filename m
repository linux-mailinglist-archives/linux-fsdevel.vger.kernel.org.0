Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE7512519F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 20:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLRTPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 14:15:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30307 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727484AbfLRTPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576696550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BI86kbjNK5OIjHooEHH2J/tEyhoDO3I49BPUrOkTzBA=;
        b=hj+D3s+DHJqHQSGnjuveGDkhVw46BPjrbm7fOQ/+bmccpiFtOzcg/nLdZFTqYtiAxFmIFa
        9AHYQOdKzRTCnxr42cit0JDWmeDdS5/fjdKkWMox5zYcH9jC+vz09iiyE3wOsRaEayhUql
        x1K7d+SDvywe/4wRYGvw7BYAuW0SvU4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-n2-Br28FP96lIbB9Q8Ho2w-1; Wed, 18 Dec 2019 14:15:48 -0500
X-MC-Unique: n2-Br28FP96lIbB9Q8Ho2w-1
Received: by mail-ot1-f70.google.com with SMTP id v4so1639142otp.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 11:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BI86kbjNK5OIjHooEHH2J/tEyhoDO3I49BPUrOkTzBA=;
        b=sLaQ+AuKWoM0DfFLXoFt8RLmXkt9QTHlVSAgwzanqE53uYQLqFG9/XlUd7RNiyWN8B
         FbMov0APbpFinGimb/y5hPK0K0X7HZA8+IuKpFYp/SOrFCv5aMw3f8StrAZfFw4AipX6
         Y6yQGvUgY3Z8Yt9uQjJo6UuPFAP1Mf7LL7uEH/MadulRT3lOSmzZ5EE7eWCbP2EMSldP
         AO4k9v6Iy8IbKNHjXPo1uKbUlq+mzDxE5yFNxj8Oymdst7QNqhWp5ry49q6uDIYz0AxI
         +KP2RKX9ZtBAaSCYY/riApbLDeLAudB5Z9kL8AflUHu9AgRqXPCu1a/QfB+md8RPiflK
         xdtQ==
X-Gm-Message-State: APjAAAUMDQYnYD/gW5djHBL1B7bzu9mwqGepyEyAc3D0o1nOvc9WeIjO
        3jm0QN5ESl9zOkITEcjVPJrOftnn0tKPA+/Mkzmh9VIjWx4XtKJPqOwDhIxQGesrTqGDQ7dMr7o
        WrCj51Hy8iNEc8uDENHewg2EUCQSJpOQNai2B17k6Gg==
X-Received: by 2002:aca:dd43:: with SMTP id u64mr1215575oig.101.1576696547953;
        Wed, 18 Dec 2019 11:15:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoq1DKGgFPtnMGhoAJMtcbciDkEMQytNX8AvkNkVK8lsW2C3r+w7lObZV7/fv72rv4hWG2JYKDz2uChLbujCg=
X-Received: by 2002:aca:dd43:: with SMTP id u64mr1215556oig.101.1576696547536;
 Wed, 18 Dec 2019 11:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20191218130935.32402-1-agruenba@redhat.com> <20191218185216.GA7497@magnolia>
In-Reply-To: <20191218185216.GA7497@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 18 Dec 2019 20:15:36 +0100
Message-ID: <CAHc6FU7vuiN4iCB3TthLaow+7c41UUS0MYEeiJ5b1iPStT=+sA@mail.gmail.com>
Subject: Re: [PATCH v3] fs: Fix page_mkwrite off-by-one errors
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 7:55 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> On Wed, Dec 18, 2019 at 02:09:35PM +0100, Andreas Gruenbacher wrote:
> > Hi Darrick,
> >
> > can this fix go in via the xfs tree?
>
> Er, I'd rather not touch five other filesystems via the XFS tree.
> However, a more immediate problem that I think I see is...
>
> > Thanks,
> > Andreas
> >
> > --
> >
> > The check in block_page_mkwrite that is meant to determine whether an
> > offset is within the inode size is off by one.  This bug has been copied
> > into iomap_page_mkwrite and several filesystems (ubifs, ext4, f2fs,
> > ceph).
> >
> > Fix that by introducing a new page_mkwrite_check_truncate helper that
> > checks for truncate and computes the bytes in the page up to EOF.  Use
> > the helper in the above mentioned filesystems.
> >
> > In addition, use the new helper in btrfs as well.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > Acked-by: David Sterba <dsterba@suse.com> (btrfs part)
> > Acked-by: Richard Weinberger <richard@nod.at> (ubifs part)
> > ---
> >  fs/btrfs/inode.c        | 15 ++++-----------
> >  fs/buffer.c             | 16 +++-------------
> >  fs/ceph/addr.c          |  2 +-
> >  fs/ext4/inode.c         | 14 ++++----------
> >  fs/f2fs/file.c          | 19 +++++++------------
> >  fs/iomap/buffered-io.c  | 18 +++++-------------
> >  fs/ubifs/file.c         |  3 +--
> >  include/linux/pagemap.h | 28 ++++++++++++++++++++++++++++
> >  8 files changed, 53 insertions(+), 62 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 56032c518b26..86c6fcd8139d 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -9016,13 +9016,11 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
> >       ret = VM_FAULT_NOPAGE; /* make the VM retry the fault */
> >  again:
> >       lock_page(page);
> > -     size = i_size_read(inode);
> >
> > -     if ((page->mapping != inode->i_mapping) ||
> > -         (page_start >= size)) {
> > -             /* page got truncated out from underneath us */
> > +     ret2 = page_mkwrite_check_truncate(page, inode);
> > +     if (ret2 < 0)
> >               goto out_unlock;
>
> ...here we try to return -EFAULT as vm_fault_t.  Notice how btrfs returns
> VM_FAULT_* values directly and never calls block_page_mkwrite_return?  I
> know dsterba acked this, but I cannot see how this is correct?

Well, page_mkwrite_check_truncate can only fail with -EFAULT, in which
case btrfs_page_mkwrite will return VM_FAULT_NOPAGE. It would be
cleaner not to discard page_mkwrite_check_truncate's return value
though.

> > -     }
> > +     zero_start = ret2;
> >       wait_on_page_writeback(page);
> >
> >       lock_extent_bits(io_tree, page_start, page_end, &cached_state);
> > @@ -9043,6 +9041,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
> >               goto again;
> >       }
> >
> > +     size = i_size_read(inode);
> >       if (page->index == ((size - 1) >> PAGE_SHIFT)) {
> >               reserved_space = round_up(size - page_start,
> >                                         fs_info->sectorsize);
> > @@ -9075,12 +9074,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
> >       }
> >       ret2 = 0;
> >
> > -     /* page is wholly or partially inside EOF */
> > -     if (page_start + PAGE_SIZE > size)
> > -             zero_start = offset_in_page(size);
> > -     else
> > -             zero_start = PAGE_SIZE;
> > -
> >       if (zero_start != PAGE_SIZE) {
> >               kaddr = kmap(page);
> >               memset(kaddr + zero_start, 0, PAGE_SIZE - zero_start);
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index d8c7242426bb..53aabde57ca7 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -2499,23 +2499,13 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
> >       struct page *page = vmf->page;
> >       struct inode *inode = file_inode(vma->vm_file);
> >       unsigned long end;
> > -     loff_t size;
> >       int ret;
> >
> >       lock_page(page);
> > -     size = i_size_read(inode);
> > -     if ((page->mapping != inode->i_mapping) ||
> > -         (page_offset(page) > size)) {
> > -             /* We overload EFAULT to mean page got truncated */
> > -             ret = -EFAULT;
> > +     ret = page_mkwrite_check_truncate(page, inode);
> > +     if (ret < 0)
> >               goto out_unlock;
> > -     }
> > -
> > -     /* page is wholly or partially inside EOF */
> > -     if (((page->index + 1) << PAGE_SHIFT) > size)
> > -             end = size & ~PAGE_MASK;
> > -     else
> > -             end = PAGE_SIZE;
> > +     end = ret;
> >
> >       ret = __block_write_begin(page, 0, end, get_block);
> >       if (!ret)
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 7ab616601141..ef958aa4adb4 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1575,7 +1575,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
> >       do {
> >               lock_page(page);
> >
> > -             if ((off > size) || (page->mapping != inode->i_mapping)) {
> > +             if (page_mkwrite_check_truncate(page, inode) < 0) {
> >                       unlock_page(page);
> >                       ret = VM_FAULT_NOPAGE;
> >                       break;
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 28f28de0c1b6..51ab1d2cac80 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5871,7 +5871,6 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
> >  {
> >       struct vm_area_struct *vma = vmf->vma;
> >       struct page *page = vmf->page;
> > -     loff_t size;
> >       unsigned long len;
> >       int err;
> >       vm_fault_t ret;
> > @@ -5907,18 +5906,13 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
> >       }
> >
> >       lock_page(page);
> > -     size = i_size_read(inode);
> > -     /* Page got truncated from under us? */
> > -     if (page->mapping != mapping || page_offset(page) > size) {
> > +     err = page_mkwrite_check_truncate(page, inode);
> > +     if (err < 0) {
> >               unlock_page(page);
> > -             ret = VM_FAULT_NOPAGE;
> > -             goto out;
> > +             goto out_ret;
> >       }
> > +     len = err;
> >
> > -     if (page->index == size >> PAGE_SHIFT)
> > -             len = size & ~PAGE_MASK;
> > -     else
> > -             len = PAGE_SIZE;
> >       /*
> >        * Return if we have all the buffers mapped. This avoids the need to do
> >        * journal_start/journal_stop which can block and take a long time
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 85af112e868d..0e77b2e6f873 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -51,7 +51,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
> >       struct inode *inode = file_inode(vmf->vma->vm_file);
> >       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >       struct dnode_of_data dn = { .node_changed = false };
> > -     int err;
> > +     int offset, err;
> >
> >       if (unlikely(f2fs_cp_error(sbi))) {
> >               err = -EIO;
> > @@ -70,13 +70,14 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
> >       file_update_time(vmf->vma->vm_file);
> >       down_read(&F2FS_I(inode)->i_mmap_sem);
> >       lock_page(page);
> > -     if (unlikely(page->mapping != inode->i_mapping ||
> > -                     page_offset(page) > i_size_read(inode) ||
> > -                     !PageUptodate(page))) {
> > +     err = -EFAULT;
> > +     if (likely(PageUptodate(page)))
> > +             err = page_mkwrite_check_truncate(page, inode);
> > +     if (unlikely(err < 0)) {
> >               unlock_page(page);
> > -             err = -EFAULT;
> >               goto out_sem;
> >       }
> > +     offset = err;
> >
> >       /* block allocation */
> >       __do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
> > @@ -101,14 +102,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
> >       if (PageMappedToDisk(page))
> >               goto out_sem;
> >
> > -     /* page is wholly or partially inside EOF */
> > -     if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
> > -                                             i_size_read(inode)) {
> > -             loff_t offset;
> > -
> > -             offset = i_size_read(inode) & ~PAGE_MASK;
> > +     if (offset != PAGE_SIZE)
> >               zero_user_segment(page, offset, PAGE_SIZE);
> > -     }
> >       set_page_dirty(page);
> >       if (!PageUptodate(page))
> >               SetPageUptodate(page);
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index d33c7bc5ee92..1aaf157fd6e9 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1062,24 +1062,16 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
> >       struct page *page = vmf->page;
> >       struct inode *inode = file_inode(vmf->vma->vm_file);
> >       unsigned long length;
> > -     loff_t offset, size;
> > +     loff_t offset;
> >       ssize_t ret;
> >
> >       lock_page(page);
> > -     size = i_size_read(inode);
> > -     offset = page_offset(page);
> > -     if (page->mapping != inode->i_mapping || offset > size) {
> > -             /* We overload EFAULT to mean page got truncated */
> > -             ret = -EFAULT;
> > +     ret = page_mkwrite_check_truncate(page, inode);
> > +     if (ret < 0)
> >               goto out_unlock;
> > -     }
> > -
> > -     /* page is wholly or partially inside EOF */
> > -     if (offset > size - PAGE_SIZE)
> > -             length = offset_in_page(size);
> > -     else
> > -             length = PAGE_SIZE;
> > +     length = ret;
> >
> > +     offset = page_offset(page);
> >       while (length > 0) {
> >               ret = iomap_apply(inode, offset, length,
> >                               IOMAP_WRITE | IOMAP_FAULT, ops, page,
> > diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> > index cd52585c8f4f..91f7a1f2db0d 100644
> > --- a/fs/ubifs/file.c
> > +++ b/fs/ubifs/file.c
> > @@ -1563,8 +1563,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
> >       }
> >
> >       lock_page(page);
> > -     if (unlikely(page->mapping != inode->i_mapping ||
> > -                  page_offset(page) > i_size_read(inode))) {
> > +     if (unlikely(page_mkwrite_check_truncate(page, inode) < 0)) {
> >               /* Page got truncated out from underneath us */
> >               goto sigbus;
> >       }
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 37a4d9e32cd3..ccb14b6a16b5 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -636,4 +636,32 @@ static inline unsigned long dir_pages(struct inode *inode)
> >                              PAGE_SHIFT;
> >  }
> >
> > +/**
> > + * page_mkwrite_check_truncate - check if page was truncated
> > + * @page: the page to check
> > + * @inode: the inode to check the page against
> > + *
> > + * Returns the number of bytes in the page up to EOF,
> > + * or -EFAULT if the page was truncated.
> > + */
> > +static inline int page_mkwrite_check_truncate(struct page *page,
> > +                                           struct inode *inode)
> > +{
> > +     loff_t size = i_size_read(inode);
> > +     pgoff_t index = size >> PAGE_SHIFT;
> > +     int offset = offset_in_page(size);
> > +
> > +     if (page->mapping != inode->i_mapping)
> > +             return -EFAULT;
> > +
> > +     /* page is wholly inside EOF */
> > +     if (page->index < index)
> > +             return PAGE_SIZE;
> > +     /* page is wholly past EOF */
> > +     if (page->index > index || !offset)
> > +             return -EFAULT;
> > +     /* page is partially inside EOF */
> > +     return offset;
> > +}
> > +
> >  #endif /* _LINUX_PAGEMAP_H */
> > --
> > 2.20.1
> >
>

