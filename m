Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86106350B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 07:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiKWGxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 01:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiKWGx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:53:29 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D71A15A16;
        Tue, 22 Nov 2022 22:53:27 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id i2so16631532vsc.1;
        Tue, 22 Nov 2022 22:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zb+b/kQNpZ1iqoMRAgUR5SFjg/VsZKZLzWh53TxILaY=;
        b=cbA+BA8+j8SetnMRGa68JJNXTTDD8h6MmbwDKtZ5PRWjQOfHGMfAi8tfjuoCxIu7Lf
         g+CnRIhCyD0OX7r/G/0rW24bn41X3H8Z+oIU4Fizh2H23Hsq1afG0qkvKt4eDV5HIHdd
         xHxTwdZTH9V7s5njavuTQ9rfH85INqJoICys2pJ8wdgvYN2p2mqF6InwhYksdfGQm9/K
         WOovykkZP9Bxwqy44D6FYZUqgk3OTwUo6lTAXBiT+6lubDXgw/2tG4lzcd9n4fyWlzPk
         RHWbIb26fA944e3LVY3AzeWzUJ0Lf+XU41mAm5btSf5wgSSVAJjXX9DWDEzQsQIPJ7HC
         YKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zb+b/kQNpZ1iqoMRAgUR5SFjg/VsZKZLzWh53TxILaY=;
        b=DIFgfY1MvZReZpo5smjCFkR32vvdnCHng8vj48I0ToSspuxhbG74Z2DFGUDcn2szcU
         hy8EYJZis5KZoHAseTxzHew+OUMsTrJfQaXXtt/3s997DPCCPu99GHpSs9T0hatbKjpk
         CjKjtqLh+Y/o0OWmpWS83jqRKn80GzObLEAOUixwPgbw8zlgm1aSOyh1K3L2yGBZcJOZ
         AcaS6f/m3L68crmsrkzP2zmvV0InKrtvBPJrQETDF7FoFp/bPuqsWTQ+43WXkudq9IyX
         128Yh5EGQHzqhB5EvXw1I/9MO9fU2WMDZQpypwQ874qbbxZvWwVpCCy+TuNqyosKBqDx
         D2wA==
X-Gm-Message-State: ANoB5plyY0/bcmux4A+dk7sVRqf6a5Z/0kiygrtO0pdXIojoT+jz28hV
        opvAIAry+KZ3CQXlOhpqa3BBsXtGKZSLrKreqLY=
X-Google-Smtp-Source: AA0mqf55Qvs1RVFZgpUB9hHpNmee060lzqmCf3GfjJCl+IAQ8LG2Guwv4fTQaouwtHsAyvEWcII2JptzlFh9ndmXW3Q=
X-Received: by 2002:a67:f60d:0:b0:3b0:6bb1:3168 with SMTP id
 k13-20020a67f60d000000b003b06bb13168mr2537799vso.36.1669186406338; Tue, 22
 Nov 2022 22:53:26 -0800 (PST)
MIME-Version: 1.0
References: <CGME20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c@epcas5p2.samsung.com>
 <20221123055827.26996-1-nj.shetty@samsung.com> <20221123055827.26996-11-nj.shetty@samsung.com>
In-Reply-To: <20221123055827.26996-11-nj.shetty@samsung.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Nov 2022 08:53:14 +0200
Message-ID: <CAOQ4uxhMX9MF0+6DD7NO5QzqDRwESkhiY5f9CB7DXFVa22Za+w@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 23, 2022 at 8:26 AM Nitesh Shetty <nj.shetty@samsung.com> wrote:
>
> copy_file_range is implemented using copy offload,
> copy offloading to device is always enabled.
> To disable copy offloading mount with "no_copy_offload" mount option.
> At present copy offload is only used, if the source and destination files
> are on same block device, otherwise copy file range is completed by
> generic copy file range.
>
> copy file range implemented as following:
>         - write pending writes on the src and dest files
>         - drop page cache for dest file if its conv zone
>         - copy the range using offload
>         - update dest file info
>
> For all failure cases we fallback to generic file copy range
> At present this implementation does not support conv aggregation
>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  fs/zonefs/super.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 179 insertions(+)
>
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index abc9a85106f2..15613433d4ae 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1223,6 +1223,183 @@ static int zonefs_file_release(struct inode *inode, struct file *file)
>         return 0;
>  }
>
> +static int zonefs_is_file_copy_offset_ok(struct inode *src_inode,
> +               struct inode *dst_inode, loff_t src_off, loff_t dst_off,
> +               size_t *len)
> +{
> +       loff_t size, endoff;
> +       struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> +
> +       inode_lock(src_inode);
> +       size = i_size_read(src_inode);
> +       inode_unlock(src_inode);
> +       /* Don't copy beyond source file EOF. */
> +       if (src_off < size) {
> +               if (src_off + *len > size)
> +                       *len = (size - (src_off + *len));
> +       } else
> +               *len = 0;
> +
> +       mutex_lock(&dst_zi->i_truncate_mutex);
> +       if (dst_zi->i_ztype == ZONEFS_ZTYPE_SEQ) {
> +               if (*len > dst_zi->i_max_size - dst_zi->i_wpoffset)
> +                       *len -= dst_zi->i_max_size - dst_zi->i_wpoffset;
> +
> +               if (dst_off != dst_zi->i_wpoffset)
> +                       goto err;
> +       }
> +       mutex_unlock(&dst_zi->i_truncate_mutex);
> +
> +       endoff = dst_off + *len;
> +       inode_lock(dst_inode);
> +       if (endoff > dst_zi->i_max_size ||
> +                       inode_newsize_ok(dst_inode, endoff)) {
> +               inode_unlock(dst_inode);
> +               goto err;
> +       }
> +       inode_unlock(dst_inode);
> +
> +       return 0;
> +err:
> +       mutex_unlock(&dst_zi->i_truncate_mutex);
> +       return -EINVAL;
> +}
> +
> +static ssize_t zonefs_issue_copy(struct zonefs_inode_info *src_zi,
> +               loff_t src_off, struct zonefs_inode_info *dst_zi,
> +               loff_t dst_off, size_t len)
> +{
> +       struct block_device *src_bdev = src_zi->i_vnode.i_sb->s_bdev;
> +       struct block_device *dst_bdev = dst_zi->i_vnode.i_sb->s_bdev;
> +       struct range_entry *rlist = NULL;
> +       int ret = len;
> +
> +       rlist = kmalloc(sizeof(*rlist), GFP_KERNEL);
> +       if (!rlist)
> +               return -ENOMEM;
> +
> +       rlist[0].dst = (dst_zi->i_zsector << SECTOR_SHIFT) + dst_off;
> +       rlist[0].src = (src_zi->i_zsector << SECTOR_SHIFT) + src_off;
> +       rlist[0].len = len;
> +       rlist[0].comp_len = 0;
> +       ret = blkdev_issue_copy(src_bdev, dst_bdev, rlist, 1, NULL, NULL,
> +                       GFP_KERNEL);
> +       if (rlist[0].comp_len > 0)
> +               ret = rlist[0].comp_len;
> +       kfree(rlist);
> +
> +       return ret;
> +}
> +
> +/* Returns length of possible copy, else returns error */
> +static ssize_t zonefs_copy_file_checks(struct file *src_file, loff_t src_off,
> +                                       struct file *dst_file, loff_t dst_off,
> +                                       size_t *len, unsigned int flags)
> +{
> +       struct inode *src_inode = file_inode(src_file);
> +       struct inode *dst_inode = file_inode(dst_file);
> +       struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
> +       struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> +       ssize_t ret;
> +
> +       if (src_inode->i_sb != dst_inode->i_sb)
> +               return -EXDEV;
> +
> +       /* Start by sync'ing the source and destination files for conv zones */
> +       if (src_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> +               ret = file_write_and_wait_range(src_file, src_off,
> +                               (src_off + *len));
> +               if (ret < 0)
> +                       goto io_error;
> +       }
> +       inode_dio_wait(src_inode);
> +
> +       /* Start by sync'ing the source and destination files ifor conv zones */
> +       if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> +               ret = file_write_and_wait_range(dst_file, dst_off,
> +                               (dst_off + *len));
> +               if (ret < 0)
> +                       goto io_error;
> +       }
> +       inode_dio_wait(dst_inode);
> +
> +       /* Drop dst file cached pages for a conv zone*/
> +       if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> +               ret = invalidate_inode_pages2_range(dst_inode->i_mapping,
> +                               dst_off >> PAGE_SHIFT,
> +                               (dst_off + *len) >> PAGE_SHIFT);
> +               if (ret < 0)
> +                       goto io_error;
> +       }
> +
> +       ret = zonefs_is_file_copy_offset_ok(src_inode, dst_inode, src_off,
> +                       dst_off, len);
> +       if (ret < 0)
> +               return ret;
> +
> +       return *len;
> +
> +io_error:
> +       zonefs_io_error(dst_inode, true);
> +       return ret;
> +}
> +
> +static ssize_t zonefs_copy_file(struct file *src_file, loff_t src_off,
> +               struct file *dst_file, loff_t dst_off,
> +               size_t len, unsigned int flags)
> +{
> +       struct inode *src_inode = file_inode(src_file);
> +       struct inode *dst_inode = file_inode(dst_file);
> +       struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
> +       struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> +       ssize_t ret = 0, bytes;
> +
> +       inode_lock(src_inode);
> +       inode_lock(dst_inode);
> +       bytes = zonefs_issue_copy(src_zi, src_off, dst_zi, dst_off, len);
> +       if (bytes < 0)
> +               goto unlock_exit;
> +
> +       ret += bytes;
> +
> +       file_update_time(dst_file);
> +       mutex_lock(&dst_zi->i_truncate_mutex);
> +       zonefs_update_stats(dst_inode, dst_off + bytes);
> +       zonefs_i_size_write(dst_inode, dst_off + bytes);
> +       dst_zi->i_wpoffset += bytes;
> +       mutex_unlock(&dst_zi->i_truncate_mutex);
> +       /* if we still have some bytes left, do splice copy */
> +       if (bytes && (bytes < len)) {
> +               bytes = do_splice_direct(src_file, &src_off, dst_file,
> +                                        &dst_off, len, flags);
> +               if (bytes > 0)
> +                       ret += bytes;
> +       }
> +unlock_exit:
> +       if (ret < 0)
> +               zonefs_io_error(dst_inode, true);
> +       inode_unlock(src_inode);
> +       inode_unlock(dst_inode);
> +       return ret;
> +}
> +
> +static ssize_t zonefs_copy_file_range(struct file *src_file, loff_t src_off,
> +                                     struct file *dst_file, loff_t dst_off,
> +                                     size_t len, unsigned int flags)
> +{
> +       ssize_t ret = -EIO;
> +
> +       ret = zonefs_copy_file_checks(src_file, src_off, dst_file, dst_off,
> +                                    &len, flags);
> +       if (ret > 0)
> +               ret = zonefs_copy_file(src_file, src_off, dst_file, dst_off,
> +                                    len, flags);
> +       else if (ret < 0 && ret == -EXDEV)

First of all, ret < 0 is redundant.

> +               ret = generic_copy_file_range(src_file, src_off, dst_file,
> +                                             dst_off, len, flags);

But more importantly, why do you want to fall back to
do_splice_direct() in zonefs copy_file_range?
How does it serve your patch set or the prospect consumers
of zonefs copy_file_range?

The reason I am asking is because commit 5dae222a5ff0
("vfs: allow copy_file_range to copy across devices")
turned out to be an API mistake that was later reverted by
868f9f2f8e00 ("vfs: fix copy_file_range() regression in cross-fs copies")

It is always better to return EXDEV to userspace which can
always fallback to splice itself, but maybe it has something
smarter to do.

The places where it made sense for kernel to fallback to
direct splice was for network servers server-side-copy, but that
is independent of any specific filesystem copy_file_range()
implementation.

Thanks,
Amir.
