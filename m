Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465DDB7322
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 08:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbfISGXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 02:23:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45058 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbfISGXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 02:23:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id u12so1090796pls.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 23:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bbcPk9uYw9R4h2L8SWtfwcPKm5cXyC/KqR1GSRo5joY=;
        b=0f204Ll9fuDmUrlh1yWrPDhUHNybXDJE9rbyMRprGGDDaOCArt1ES4rtstVXcAB/Ws
         FsxXIDZ/Y+HAowZc0AT1Qz4ugoeSP6s+czkxQCEc/z95b7AtdkNXZokevKpRuIyzjt1g
         TfQYqcB6i4vYRFIgtaBCs3GChAhXIUmBt0rEUN9kEm0Hy0i7rWuMYjiuu82ywrUsqVlT
         fnt7U7P+lpNwyigqUBJVzkWACEQ+yBg68bQHGmrgDqsaEvnaSJ8bz+wy7lexzeh+ViWK
         //ssqxNCc9f9QwdYlZAOTFYVMU2/FbyYE+KM24AH+UzH3tKdkL4/FzPMqBXxggpCaCrn
         4nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bbcPk9uYw9R4h2L8SWtfwcPKm5cXyC/KqR1GSRo5joY=;
        b=U+cM144aCbtibWzulTjgv6DQsewB7cHgFQkK97LjSemkjts+NcE39JpLdSQzD7Jjg1
         Vqb78rEtC2u8fffED0RidH0U+PiU/y1x99cdXdVY+RQJJhepmrCqpSLDrWwa7dbnzw2P
         9oOMsWYT4sCbhQl1cpFzSTgwnevCoai5Qb4dyhScTGDilja99//f6p6D/V0wnm+Bwmqh
         hO72SCAV/usYjMkfwffPqfsycLmi+m/Hgs1Klt+aAPPkMijHPaKCo7A5W4QspAdbz17D
         plVc2UccX9RZhTLV5Cxrzl6dvyEvWlZP3YgdVKnvw0OjO61dJ8siiqmC8d9pSAkovs9b
         37eg==
X-Gm-Message-State: APjAAAUlZ7WaZxo/OQBzwBGQLapFLNKYZWC31a58a6rcW4mzuRjsyUAX
        KUL/6c13XXHVnwZoJAGGW7Bi1Q==
X-Google-Smtp-Source: APXvYqxim8OsQrDPliwBYc/8p6wYQwrsqqpi/9MaXjYwINS6Fn9WAWlDLcCV6SqhOtr1Gg2GdQBYIg==
X-Received: by 2002:a17:902:8686:: with SMTP id g6mr8207852plo.175.1568874200781;
        Wed, 18 Sep 2019 23:23:20 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id y4sm3852757pjn.19.2019.09.18.23.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 23:23:20 -0700 (PDT)
Date:   Wed, 18 Sep 2019 23:23:20 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: add ioctl for directly writing compressed data
Message-ID: <20190919062320.GB105652@vader>
References: <cover.1567623877.git.osandov@fb.com>
 <8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com>
 <CAL3q7H6fxfPiNycFrd=OW_jv_kDSU1OyGE+Zgz1hYXdzUKd-3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6fxfPiNycFrd=OW_jv_kDSU1OyGE+Zgz1hYXdzUKd-3g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 10, 2019 at 12:39:28PM +0100, Filipe Manana wrote:
> On Wed, Sep 4, 2019 at 8:14 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > This adds an API for writing compressed data directly to the filesystem.
> > The use case that I have in mind is send/receive: currently, when
> > sending data from one compressed filesystem to another, the sending side
> > decompresses the data and the receiving side recompresses it before
> > writing it out. This is wasteful and can be avoided if we can just send
> > and write compressed extents. The send part will be implemented in a
> > separate series, as this ioctl can stand alone.
> >
> > The interface is essentially pwrite(2) with some extra information:
> >
> > - The input buffer contains the compressed data.
> > - Both the compressed and decompressed sizes of the data are given.
> > - The compression type (zlib, lzo, or zstd) is given.
> >
> > The interface is general enough that it can be extended to encrypted or
> > otherwise encoded extents in the future. A more detailed description,
> > including restrictions and edge cases, is included in
> > include/uapi/linux/btrfs.h.
> >
> > The implementation is similar to direct I/O: we have to flush any
> > ordered extents, invalidate the page cache, and do the io
> > tree/delalloc/extent map/ordered extent dance. From there, we can reuse
> > the compression code with a minor modification to distinguish the new
> > ioctl from writeback.
> >
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/btrfs/compression.c     |   6 +-
> >  fs/btrfs/compression.h     |  14 +--
> >  fs/btrfs/ctree.h           |   6 ++
> >  fs/btrfs/file.c            |  13 ++-
> >  fs/btrfs/inode.c           | 192 ++++++++++++++++++++++++++++++++++++-
> >  fs/btrfs/ioctl.c           |  95 ++++++++++++++++++
> >  include/uapi/linux/btrfs.h |  69 +++++++++++++
> >  7 files changed, 380 insertions(+), 15 deletions(-)
> >
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index b05b361e2062..6632dd8d2e4d 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -276,7 +276,8 @@ static void end_compressed_bio_write(struct bio *bio)
> >                         bio->bi_status == BLK_STS_OK);
> >         cb->compressed_pages[0]->mapping = NULL;
> >
> > -       end_compressed_writeback(inode, cb);
> > +       if (cb->writeback)
> > +               end_compressed_writeback(inode, cb);
> >         /* note, our inode could be gone now */
> >
> >         /*
> > @@ -311,7 +312,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
> >                                  unsigned long compressed_len,
> >                                  struct page **compressed_pages,
> >                                  unsigned long nr_pages,
> > -                                unsigned int write_flags)
> > +                                unsigned int write_flags, bool writeback)
> >  {
> >         struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >         struct bio *bio = NULL;
> > @@ -336,6 +337,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
> >         cb->mirror_num = 0;
> >         cb->compressed_pages = compressed_pages;
> >         cb->compressed_len = compressed_len;
> > +       cb->writeback = writeback;
> >         cb->orig_bio = NULL;
> >         cb->nr_pages = nr_pages;
> >
> > diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> > index 4cb8be9ff88b..5b48eb730362 100644
> > --- a/fs/btrfs/compression.h
> > +++ b/fs/btrfs/compression.h
> > @@ -6,6 +6,7 @@
> >  #ifndef BTRFS_COMPRESSION_H
> >  #define BTRFS_COMPRESSION_H
> >
> > +#include <linux/btrfs.h>
> >  #include <linux/sizes.h>
> >
> >  /*
> > @@ -47,6 +48,9 @@ struct compressed_bio {
> >         /* the compression algorithm for this bio */
> >         int compress_type;
> >
> > +       /* Whether this is a write for writeback. */
> > +       bool writeback;
> > +
> >         /* number of compressed pages in the array */
> >         unsigned long nr_pages;
> >
> > @@ -93,20 +97,12 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
> >                                   unsigned long compressed_len,
> >                                   struct page **compressed_pages,
> >                                   unsigned long nr_pages,
> > -                                 unsigned int write_flags);
> > +                                 unsigned int write_flags, bool writeback);
> >  blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
> >                                  int mirror_num, unsigned long bio_flags);
> >
> >  unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
> >
> > -enum btrfs_compression_type {
> > -       BTRFS_COMPRESS_NONE  = 0,
> > -       BTRFS_COMPRESS_ZLIB  = 1,
> > -       BTRFS_COMPRESS_LZO   = 2,
> > -       BTRFS_COMPRESS_ZSTD  = 3,
> > -       BTRFS_COMPRESS_TYPES = 3,
> > -};
> > -
> >  struct workspace_manager {
> >         const struct btrfs_compress_op *ops;
> >         struct list_head idle_ws;
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 19d669d12ca1..9fae9b3f1f62 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -2905,6 +2905,10 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
> >  int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
> >  void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
> >                                           u64 end, int uptodate);
> > +
> > +ssize_t btrfs_raw_write(struct kiocb *iocb, struct iov_iter *from,
> > +                       struct btrfs_ioctl_raw_pwrite_args *raw);
> > +
> >  extern const struct dentry_operations btrfs_dentry_operations;
> >
> >  /* ioctl.c */
> > @@ -2928,6 +2932,8 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
> >                            struct btrfs_inode *inode);
> >  int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
> >  void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
> > +ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
> > +                           struct btrfs_ioctl_raw_pwrite_args *args);
> >  int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
> >  void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
> >                              int skip_pinned);
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 8fe4eb7e5045..ed23aa65b2d5 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1872,8 +1872,8 @@ static void update_time_for_write(struct inode *inode)
> >                 inode_inc_iversion(inode);
> >  }
> >
> > -static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> > -                                   struct iov_iter *from)
> > +ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
> > +                           struct btrfs_ioctl_raw_pwrite_args *raw)
> >  {
> >         struct file *file = iocb->ki_filp;
> >         struct inode *inode = file_inode(file);
> > @@ -1965,7 +1965,9 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> >         if (sync)
> >                 atomic_inc(&BTRFS_I(inode)->sync_writers);
> >
> > -       if (iocb->ki_flags & IOCB_DIRECT) {
> > +       if (raw) {
> > +               num_written = btrfs_raw_write(iocb, from, raw);
> > +       } else if (iocb->ki_flags & IOCB_DIRECT) {
> >                 num_written = __btrfs_direct_write(iocb, from);
> >         } else {
> >                 num_written = btrfs_buffered_write(iocb, from);
> > @@ -1996,6 +1998,11 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> >         return num_written ? num_written : err;
> >  }
> >
> > +static ssize_t btrfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > +{
> > +       return btrfs_do_write_iter(iocb, from, NULL);
> > +}
> > +
> >  int btrfs_release_file(struct inode *inode, struct file *filp)
> >  {
> >         struct btrfs_file_private *private = filp->private_data;
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index a0546401bc0a..c8eaa1e5bf06 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -865,7 +865,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
> >                                     ins.objectid,
> >                                     ins.offset, async_extent->pages,
> >                                     async_extent->nr_pages,
> > -                                   async_chunk->write_flags)) {
> > +                                   async_chunk->write_flags, true)) {
> >                         struct page *p = async_extent->pages[0];
> >                         const u64 start = async_extent->start;
> >                         const u64 end = start + async_extent->ram_size - 1;
> > @@ -10590,6 +10590,196 @@ void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
> >         }
> >  }
> >
> > +/* Currently, this only supports raw writes of compressed data. */
> > +ssize_t btrfs_raw_write(struct kiocb *iocb, struct iov_iter *from,
> > +                       struct btrfs_ioctl_raw_pwrite_args *raw)
> > +{
> > +       struct file *file = iocb->ki_filp;
> > +       struct inode *inode = file_inode(file);
> > +       struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +       struct btrfs_root *root = BTRFS_I(inode)->root;
> > +       struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> > +       struct extent_changeset *data_reserved = NULL;
> > +       struct extent_state *cached_state = NULL;
> > +       unsigned long nr_pages, i;
> > +       struct page **pages;
> > +       u64 disk_num_bytes, num_bytes;
> > +       u64 start, end;
> > +       struct btrfs_key ins;
> > +       struct extent_map *em;
> > +       ssize_t ret;
> > +
> > +       if (iov_iter_count(from) != raw->num_bytes) {
> > +               /*
> > +                * The write got truncated by generic_write_checks(). We can't
> > +                * do a partial raw write.
> > +                */
> > +               return -EFBIG;
> > +       }
> > +
> > +       /* This should be handled higher up. */
> > +       ASSERT(raw->num_bytes != 0);
> > +
> > +       /* The extent size must be sane. */
> > +       if (raw->num_bytes > BTRFS_MAX_UNCOMPRESSED ||
> > +           raw->disk_num_bytes > BTRFS_MAX_COMPRESSED ||
> > +           raw->disk_num_bytes == 0)
> > +               return -EINVAL;
> 
> For the uncompressed size (num_bytes), even if it's within the limit,
> shouldn't we validate it?
> We can't trust for sure that what the user supplies is actually
> correct. Can't we grab that from the compressed buffer (I suppose at
> least most compression methods encode that in a header or trailer)?
> Without such validation we can end up corrupt data/metadata on disk.
> 
> Thanks.

The user could always spoof the length in the headers, as well. The only
way to really validate the length would be to decompress the data, which
defeats the purpose of this interface.

In any case, I don't think it's a big deal for the length to be invalid.
The decompression code for all three compression types already handles
the case where the data decompresses to less than num_bytes by
zero-filling the remainder of the extent and the case where the data
decompresses to more than num_bytes by truncating the data.

The user can also give us garbage data that doesn't decompress at all.
In my opinion, it's fair to document that if the compressed data is
malformed, the result of reading that data is undefined, as long as we
don't crash or leak disk contents or anything like that.
