Return-Path: <linux-fsdevel+bounces-26887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A2F95C871
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 10:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DDC2814B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA601494C8;
	Fri, 23 Aug 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpezJZnB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C37346D;
	Fri, 23 Aug 2024 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403239; cv=none; b=Stz+/DyPletvMTChRA2Y3qLDES6bpXYH1zZX0G5f800KkH63Pxzh03Ncg848esrCKIltLE//bjmZSrjppEuyA9G5ROoM88gapEeUe/YX6vRqzupttZ2AArG4XuWqg8MUum/LRgzrfsh2gi3EbEWPQwHF284fJBuxREqpZvLoAII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403239; c=relaxed/simple;
	bh=v388rCkByQcA3BufXfhMLwx3l6eOp0ZoEY9FvvTCXhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxOIfq3KnjugV1/xQhO+nUD6MQdDBMLCRTC3iSnMcExBnsNqyHOapAa3zSDzyl8y0gCeNiL94BEdcUCLNJ70Rp9UNWQhYspxO634FTO9szboQybvm8XB0nVWewsYO5U/WRu20zPZ9Q5qmNqSU6PUF5bwDM2N5wJAXCW1LOLEh6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpezJZnB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5334832fb94so394162e87.0;
        Fri, 23 Aug 2024 01:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724403235; x=1725008035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkiJZpeu/V+ZtV4u24y8u9UhBVHpkdPru9mzD8iIr24=;
        b=cpezJZnBY8o8nQALpoYM6dJISnReFgtJrDkPtestnRyLm9USWAoSwF+Njl5Io4ki+r
         zIVULOqZ9bRMZ4FSj7qpawLF0F7i28csb3XI7gKyQNPifdABaU5+KUF5oAIouh1Mv37b
         mROTb8K7KFqrWVsVwQyFuCEJU/0boZd6ThHjtl5PZgVVsZn3bNV3nyY5cnjsIqUtfqzA
         dl5xCPd3NDc1BPQO9BQxSfUghqPu/KdLtJRZ3N8Q4JCNj83leDABYYeY3h/VZLsOURU9
         uRcFVHYeXeEL5P3IkMzOIdNkz8T6UmX09eBdwoWj9tCnXNw3UpGYEIqvv9k2M48cx8cH
         Iq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403235; x=1725008035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkiJZpeu/V+ZtV4u24y8u9UhBVHpkdPru9mzD8iIr24=;
        b=BD5hmPxBhMTLQgOjnUdfGgwkZ6dUIxNj5Dj9Vzp5fQhJMeTu84SvR4b8CnAeHjBvtV
         pj7mNngsugCrMKTjRbd/9rer39ht7wXcj8qG8yklW3/BxyzQLhnzas0DeaRZOOK47Lnd
         vY62u6nVkoHguDJcp16JKG+ayJ3iByRbiWl3KAj544Y4mHewZTGtMplHs6a1ZOQfqzIY
         +Ydcj4zN5zTxVKmZxHcwDNeb5ji1Llnw1ApjNaTZYrTbosMaJ+bmKXZdX6riSKHXY/UD
         08HGtnYu9NEI6TPb7nK/a7Msi7WJiCnqptHlr1ti8kQyX+h2tJAOfqYh/2oykBJ5yoqv
         JvKw==
X-Forwarded-Encrypted: i=1; AJvYcCVFJJnYzbrH9lkki+HRxLA4Vdpi3gRG/ppMvQZB9uR4u4+tBHOBohIsl1cMe3kZlxVUs944HWTfOiGl@vger.kernel.org, AJvYcCW2E1kKDrkwNuH3QrIH2NhU4JxrI5CzXciTggta+QzYmh+WBkvyudTNGIpt/BAlXhHoyIBss5X3Hv4gbuC6Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfKWgvw2GHc1GXzblGzXo6+TiMP+46hu51quMl3+Q71BJIo2Ak
	VIinWsePi4m9dfjm88P5/hlvaG6Qi0RvnCgP2nA3OAvnXbRyEh6S3OOT5WgLsSrR+UL4B4S7VGf
	kB9cmZkyVrYpLGZBQi3ICOqFFsEo=
X-Google-Smtp-Source: AGHT+IFYIBkQcsJ4IxMOFSb7i4CUTqn/9qHTCEorNvDYTHOfczegJZmZ7YQYtN1kFYTq6lbaUvxGi0ba7MXN4m1qny0=
X-Received: by 2002:a05:6512:ea6:b0:52f:cfba:403c with SMTP id
 2adb3069b0e04-5343877b4c0mr654763e87.3.1724403234402; Fri, 23 Aug 2024
 01:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823082237.713543-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240823082237.713543-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 23 Aug 2024 16:53:43 +0800
Message-ID: <CAGWkznG5ZLkmp45hi2AHA3dZyf1tDgRtVQP=JhRdkVj53dpjDw@mail.gmail.com>
Subject: Re: [RFC PATCHv2 1/1] fs: ext4: Don't use CMA for buffer_head
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 4:24=E2=80=AFPM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> cma_alloc() keep failed in our system which thanks to a jh->bh->b_page
> can not be migrated out of CMA area[1] as the jh has one cp_transaction
> pending on it because of j_free > j_max_transaction_buffers[2][3][4][5][6=
].
> We temporarily solve this by launching jbd2_log_do_checkpoint forcefully
> somewhere. Since journal is common mechanism to all JFSs and
> cp_transaction has a little fewer opportunity to be launched, the
> cma_alloc() could be affected under the same scenario. This patch
> would like to have buffer_head of ext4 not use CMA pages when doing
> sb_getblk.
>
> [1]
> crash_arm64_v8.0.4++> kmem -p|grep ffffff808f0aa150(sb->s_bdev->bd_inode-=
>i_mapping)
> fffffffe01a51c00  e9470000 ffffff808f0aa150        3  2 8000000008020 lru=
,private //within CMA area
> fffffffe03d189c0 174627000 ffffff808f0aa150        4  2 2004000000008020 =
lru,private
> fffffffe03d88e00 176238000 ffffff808f0aa150      3f9  2 2008000000008020 =
lru,private
> fffffffe03d88e40 176239000 ffffff808f0aa150        6  2 2008000000008020 =
lru,private
> fffffffe03d88e80 17623a000 ffffff808f0aa150        5  2 2008000000008020 =
lru,private
> fffffffe03d88ec0 17623b000 ffffff808f0aa150        1  2 2008000000008020 =
lru,private
> fffffffe03d88f00 17623c000 ffffff808f0aa150        0  2 2008000000008020 =
lru,private
> fffffffe040e6540 183995000 ffffff808f0aa150      3f4  2 2004000000008020 =
lru,private
>
> [2] page -> buffer_head
> crash_arm64_v8.0.4++> struct page.private fffffffe01a51c00 -x
>       private =3D 0xffffff802fca0c00
>
> [3] buffer_head -> journal_head
> crash_arm64_v8.0.4++> struct buffer_head.b_private 0xffffff802fca0c00
>   b_private =3D 0xffffff8041338e10,
>
> [4] journal_head -> b_cp_transaction
> crash_arm64_v8.0.4++> struct journal_head.b_cp_transaction 0xffffff804133=
8e10 -x
>   b_cp_transaction =3D 0xffffff80410f1900,
>
> [5] transaction_t -> journal
> crash_arm64_v8.0.4++> struct transaction_t.t_journal 0xffffff80410f1900 -=
x
>   t_journal =3D 0xffffff80e70f3000,
>
> [6] j_free & j_max_transaction_buffers
> crash_arm64_v8.0.4++> struct journal_t.j_free,j_max_transaction_buffers 0=
xffffff80e70f3000 -x
>   j_free =3D 0x3f1,
>   j_max_transaction_buffers =3D 0x100,
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: update commit message
> ---
> ---
>  fs/ext4/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 941c1c0d5c6e..4422246851fe 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -869,7 +869,11 @@ struct buffer_head *ext4_getblk(handle_t *handle, st=
ruct inode *inode,
>         if (nowait)
>                 return sb_find_get_block(inode->i_sb, map.m_pblk);
>
> +#ifndef CONFIG_CMA
>         bh =3D sb_getblk(inode->i_sb, map.m_pblk);
> +#else
> +       bh =3D sb_getblk_gfp(inode->i_sb, map.m_pblk, 0);
> +#endif
>         if (unlikely(!bh))
>                 return ERR_PTR(-ENOMEM);
>         if (map.m_flags & EXT4_MAP_NEW) {
> --
> 2.25.1
>
A hint for these, from my understanding, other FSs such as f2fs and
erofs have had the meta data avoid using the CMA area by using
GFP_NOFS/GFP_KERNEL on meta inode.

struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
{
...
        if (ino =3D=3D F2FS_NODE_INO(sbi)) {
                inode->i_mapping->a_ops =3D &f2fs_node_aops;
                mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
        } else if (ino =3D=3D F2FS_META_INO(sbi)) {
                inode->i_mapping->a_ops =3D &f2fs_meta_aops;
                mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);

int erofs_init_managed_cache(struct super_block *sb)
{
        struct inode *const inode =3D new_inode(sb);

        if (!inode)
                return -ENOMEM;

        set_nlink(inode, 1);
        inode->i_size =3D OFFSET_MAX;
        inode->i_mapping->a_ops =3D &z_erofs_cache_aops;
        mapping_set_gfp_mask(inode->i_mapping, GFP_KERNEL);

