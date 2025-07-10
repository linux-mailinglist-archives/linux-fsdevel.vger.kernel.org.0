Return-Path: <linux-fsdevel+bounces-54552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 211FDB00EAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 00:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A501CA5FAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 22:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4407429AB0F;
	Thu, 10 Jul 2025 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="StRPxd05"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27A2356D2
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186381; cv=none; b=MiBlznZtqCH/M6zg+mDwkmGoAbOKztgbDeGM5MaTDy5Gh7V3xO+SaGwbMXNxYQ/5BZotpJ+or8bkxzBi9NyxPJ9BtxzYkrC+D3hAd0eocYSEIhqwEMLH4jAvgaEC6DPhIloUuDv9AzmlQAySEAX1eFzVcddIQVBT7Z+dCi6uuhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186381; c=relaxed/simple;
	bh=YqpjZ02EXRIMU5pcqhwVS8ZJW0wMCv1Ac0R2tWcZrrY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tv4gs3cksS/N/xPI/ZTrij2ElYufKO2QsBqFNi0vSiDzfWUw1KZMeJL8TgSHGSGgfJF9fxEec9TcMDdcbJhRRjwkyaUtJcRB9VaPcla0iMgBi6wao5/8FeWnahByNAKRGj1HKZHnbivmeqqK85gX/MSVO4UQ7v1CSsYFBxoAn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=StRPxd05; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e1d8c2dc2so14749607b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 15:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1752186377; x=1752791177; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1NbXJSJrB9tQQ1nmsgMIzQCr4BM4s3Km5sKzzmAynyQ=;
        b=StRPxd05Fxe7414Sl1vQmsMCx7D4rpoCLZpbtX6W6Igc7NosJ8SJIQ2A7Opx4fiZvg
         qge5LDiAUWa2ynXYA3trSGbXiIH8KH4jCDwR962z2vGBuuOzUP2UTu65CceFaIgywj61
         CcaOQUUzF8DTDkNP7FPvZBwDJkc1Yu9rfVfRpc94jt3I6nQJuSYxTqv6K/55NnytZlOG
         ZIuy7AvbO31HR3SU0wlsMgX7z0GuegPEHxlM9wgB7SAdAaiaVaQnHENeNm9+lKcSpL2e
         0BkrEYJBZg+VD7t72cv2FfN1v11McsDss0lAAEc0jQg1KmKR5OOIzhkzEz6iy0grQXGg
         0oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752186377; x=1752791177;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NbXJSJrB9tQQ1nmsgMIzQCr4BM4s3Km5sKzzmAynyQ=;
        b=HIP4FPljRf/R4NOsTahBdrmc//5fNcRZ/e0i8vOlP9m1ODHxO7UIeewu9Smae/6yy4
         pxRLPPjL0/3FTx20PqePac00I0TuvLiiQIM74UONhTiNPIjLVf6sZ060tDljv626JDzQ
         ft9SF9m/8HeCakMoT0oTd0CfAUesmEUXfbx2C0FzE7lGc7RNorj/Wh/5udYgebFLo+Ae
         TfNCucbdMa3mUawY/Kp5IZJzYVM4mumU8bSYeKGLhq1INy1czzIyNXei8ku8GZrxufjo
         CzrD5xf+eFlOzpW7wY9uk6VzvcgZ1oBbXBfKS+PDnZoNPH/gV3QHOyy1upyGJkoqA3gh
         IvKw==
X-Forwarded-Encrypted: i=1; AJvYcCVwwAFsI4+EMl+s38kmsFEw9HMIuf4f3EdmMVwkXlolMHcj9AgeX0DvaKrlbYnCDSMle0SFl9eyioYGCPlh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2I1spivr3LeI7tXqmcwaUKmOwfdx1cHj6XayDxTsQS5LJptTn
	HZVPav8etj4OJQA61EK7r3+mUwa/rJJYKGCZuPqvvI1RXBeYsVidG8x9B0n9x5gxs/goaC+O598
	frMEJ+88=
X-Gm-Gg: ASbGncsJAcBZAcwLN9CbA8YVSkM5kUyfDlxZQED58x7gKldcn2Uma/ZXyX67JKw2IsX
	oB0cihRcYHXgG07GrlIbGjQfC0bCrL7Qx6wZZxebo0a2pOXr+tnxH3Kf2r8Fq8RnrqAIXtG+xqn
	8zkyheHn+vsFraHsih92aRMDvLvKhctoZcHps3JJSj6t7APkUwfJC3C5E3eHH7J2RWlkYgORQH/
	1/BZTcADI0NSkFOyXmDHO09noTodR0E3tCs4sxipZp8lmqbf1LU93nBSa4+AhXH1il4I8qvxjeL
	+OW740O9vXHpXjp7IgY8VQsB2/764tNd3uq4xzsQ1lRCmuRIrGg4UurEHVY4BAtV3NsDKagplZn
	N98WjH04DGK0l+xLqBaeCIKOget3md2BuTg==
X-Google-Smtp-Source: AGHT+IGpu/nUrimZVFf8rwag5+iI4XoUOusV/K2hls5H3w4pilTfQhf46EQAUizFE2Oz7qSjFV736g==
X-Received: by 2002:a05:690c:6e0c:b0:712:c55c:4e5e with SMTP id 00721157ae682-717d7a0e9d6mr12428197b3.18.1752186376984;
        Thu, 10 Jul 2025 15:26:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9e89:c5b3:9b71:4f51? ([2600:1700:6476:1430:9e89:c5b3:9b71:4f51])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61b4c37sm4929587b3.66.2025.07.10.15.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:26:16 -0700 (PDT)
Message-ID: <d5e60b7dec44f3fd2443c77c6a2b5a45cd5b8540.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs/hfsplus: rework debug output subsystem
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org, 
	frank.li@vivo.com, Johannes.Thumshirn@wdc.com
Cc: Slava.Dubeyko@ibm.com
Date: Thu, 10 Jul 2025 15:26:14 -0700
In-Reply-To: <20250710221600.109153-1-slava@dubeyko.com>
References: <20250710221600.109153-1-slava@dubeyko.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-10 at 15:16 -0700, Viacheslav Dubeyko wrote:
> Currently, HFS/HFS+ has very obsolete and inconvenient
> debug output subsystem. Also, the code is duplicated
> in HFS and HFS+ driver. This patch introduces
> linux/hfs_common.h for gathering common declarations,
> inline functions, and common short methods. Currently,
> this file contains only hfs_dbg() function that
> employs pr_debug() with the goal to print a debug-level
> messages conditionally.
>=20
> So, now, it is possible to enable the debug output
> by means of:
>=20
> echo 'file extent.c +p' > /proc/dynamic_debug/control
> echo 'func hfsplus_evict_inode +p' > /proc/dynamic_debug/control
>=20
> And debug output looks like this:
>=20
> hfs: pid 5831:fs/hfs/catalog.c:228 hfs_cat_delete(): delete_cat:
> m00,48
> hfs: pid 5831:fs/hfs/extent.c:484 hfs_file_truncate(): truncate: 48,
> 409600 -> 0
> hfs: pid 5831:fs/hfs/extent.c:212 hfs_dump_extent():
> hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():=C2=A0 78:4
> hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():=C2=A0 0:0
> hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():=C2=A0 0:0
>=20
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org
> cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> ---
> =C2=A0fs/hfs/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0fs/hfs/bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0fs/hfs/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 28 ++++++++++++++--------------
> =C2=A0fs/hfs/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++----
> =C2=A0fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/hfs/catalog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A0fs/hfs/extent.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 18 +++++++++---------
> =C2=A0fs/hfs/hfs_fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 33 +--------------------------------
> =C2=A0fs/hfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0fs/hfsplus/attributes.c=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++----
> =C2=A0fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 4 ++--
> =C2=A0fs/hfsplus/bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 =
+++++-----
> =C2=A0fs/hfsplus/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 28 ++++++++++++++--------------
> =C2=A0fs/hfsplus/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 10 +++++-----
> =C2=A0fs/hfsplus/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 4 ++--
> =C2=A0fs/hfsplus/catalog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 =
+++---
> =C2=A0fs/hfsplus/extents.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 +++++=
+++++++------------
> =C2=A0fs/hfsplus/hfsplus_fs.h=C2=A0=C2=A0=C2=A0 | 35 +-------------------=
---------------
> =C2=A0fs/hfsplus/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 8 ++++----
> =C2=A0fs/hfsplus/xattr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 4 ++--
> =C2=A0include/linux/hfs_common.h | 20 ++++++++++++++++++++
> =C2=A021 files changed, 112 insertions(+), 156 deletions(-)
> =C2=A0create mode 100644 include/linux/hfs_common.h
>=20
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index ef9498a6e88a..d76fdb8d94ee 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -23,7 +23,7 @@ int hfs_find_init(struct hfs_btree *tree, struct
> hfs_find_data *fd)
> =C2=A0		return -ENOMEM;
> =C2=A0	fd->search_key =3D ptr;
> =C2=A0	fd->key =3D ptr + tree->max_key_len + 2;
> -	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
> +	hfs_dbg("tree: %d (%p)\n",
> =C2=A0		tree->cnid, __builtin_return_address(0));
> =C2=A0	switch (tree->cnid) {
> =C2=A0	case HFS_CAT_CNID:
> @@ -45,7 +45,7 @@ void hfs_find_exit(struct hfs_find_data *fd)
> =C2=A0{
> =C2=A0	hfs_bnode_put(fd->bnode);
> =C2=A0	kfree(fd->search_key);
> -	hfs_dbg(BNODE_REFS, "find_exit: %d (%p)\n",
> +	hfs_dbg("tree: %d (%p)\n",
> =C2=A0		fd->tree->cnid, __builtin_return_address(0));
> =C2=A0	mutex_unlock(&fd->tree->tree_lock);
> =C2=A0	fd->tree =3D NULL;
> diff --git a/fs/hfs/bitmap.c b/fs/hfs/bitmap.c
> index 28307bc9ec1e..d946304f8ad4 100644
> --- a/fs/hfs/bitmap.c
> +++ b/fs/hfs/bitmap.c
> @@ -158,7 +158,7 @@ u32 hfs_vbm_search_free(struct super_block *sb,
> u32 goal, u32 *num_bits)
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	hfs_dbg(BITMAP, "alloc_bits: %u,%u\n", pos, *num_bits);
> +	hfs_dbg("alloc_bits: %u,%u\n", pos, *num_bits);
> =C2=A0	HFS_SB(sb)->free_ablocks -=3D *num_bits;
> =C2=A0	hfs_bitmap_dirty(sb);
> =C2=A0out:
> @@ -200,7 +200,7 @@ int hfs_clear_vbm_bits(struct super_block *sb,
> u16 start, u16 count)
> =C2=A0	if (!count)
> =C2=A0		return 0;
> =C2=A0
> -	hfs_dbg(BITMAP, "clear_bits: %u,%u\n", start, count);
> +	hfs_dbg("clear_bits: %u,%u\n", start, count);
> =C2=A0	/* are all of the bits in range? */
> =C2=A0	if ((start + count) > HFS_SB(sb)->fs_ablocks)
> =C2=A0		return -2;
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index cb823a8a6ba9..26611ffd2f11 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -116,7 +116,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node,
> int dst,
> =C2=A0{
> =C2=A0	struct page *src_page, *dst_page;
> =C2=A0
> -	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src, len);
> +	hfs_dbg("copybytes: %u,%u,%u\n", dst, src, len);
> =C2=A0	if (!len)
> =C2=A0		return;
> =C2=A0	src +=3D src_node->page_offset;
> @@ -133,7 +133,7 @@ void hfs_bnode_move(struct hfs_bnode *node, int
> dst, int src, int len)
> =C2=A0	struct page *page;
> =C2=A0	void *ptr;
> =C2=A0
> -	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
> +	hfs_dbg("movebytes: %u,%u,%u\n", dst, src, len);
> =C2=A0	if (!len)
> =C2=A0		return;
> =C2=A0	src +=3D node->page_offset;
> @@ -151,16 +151,16 @@ void hfs_bnode_dump(struct hfs_bnode *node)
> =C2=A0	__be32 cnid;
> =C2=A0	int i, off, key_off;
> =C2=A0
> -	hfs_dbg(BNODE_MOD, "bnode: %d\n", node->this);
> +	hfs_dbg("bnode: %d\n", node->this);
> =C2=A0	hfs_bnode_read(node, &desc, 0, sizeof(desc));
> -	hfs_dbg(BNODE_MOD, "%d, %d, %d, %d, %d\n",
> +	hfs_dbg("%d, %d, %d, %d, %d\n",
> =C2=A0		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
> =C2=A0		desc.type, desc.height, be16_to_cpu(desc.num_recs));
> =C2=A0
> =C2=A0	off =3D node->tree->node_size - 2;
> =C2=A0	for (i =3D be16_to_cpu(desc.num_recs); i >=3D 0; off -=3D 2, i--)
> {
> =C2=A0		key_off =3D hfs_bnode_read_u16(node, off);
> -		hfs_dbg_cont(BNODE_MOD, " %d", key_off);
> +		hfs_dbg(" %d", key_off);
> =C2=A0		if (i && node->type =3D=3D HFS_NODE_INDEX) {
> =C2=A0			int tmp;
> =C2=A0
> @@ -168,18 +168,18 @@ void hfs_bnode_dump(struct hfs_bnode *node)
> =C2=A0				tmp =3D (hfs_bnode_read_u8(node,
> key_off) | 1) + 1;
> =C2=A0			else
> =C2=A0				tmp =3D node->tree->max_key_len + 1;
> -			hfs_dbg_cont(BNODE_MOD, " (%d,%d",
> -				=C2=A0=C2=A0=C2=A0=C2=A0 tmp, hfs_bnode_read_u8(node,
> key_off));
> +			hfs_dbg(" (%d,%d",
> +				tmp, hfs_bnode_read_u8(node,
> key_off));
> =C2=A0			hfs_bnode_read(node, &cnid, key_off + tmp,
> 4);
> -			hfs_dbg_cont(BNODE_MOD, ",%d)",
> be32_to_cpu(cnid));
> +			hfs_dbg(",%d)", be32_to_cpu(cnid));
> =C2=A0		} else if (i && node->type =3D=3D HFS_NODE_LEAF) {
> =C2=A0			int tmp;
> =C2=A0
> =C2=A0			tmp =3D hfs_bnode_read_u8(node, key_off);
> -			hfs_dbg_cont(BNODE_MOD, " (%d)", tmp);
> +			hfs_dbg(" (%d)", tmp);
> =C2=A0		}
> =C2=A0	}
> -	hfs_dbg_cont(BNODE_MOD, "\n");
> +	hfs_dbg("\n");
> =C2=A0}
> =C2=A0
> =C2=A0void hfs_bnode_unlink(struct hfs_bnode *node)
> @@ -269,7 +269,7 @@ static struct hfs_bnode
> *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
> =C2=A0	node->this =3D cnid;
> =C2=A0	set_bit(HFS_BNODE_NEW, &node->flags);
> =C2=A0	atomic_set(&node->refcnt, 1);
> -	hfs_dbg(BNODE_REFS, "new_node(%d:%d): 1\n",
> +	hfs_dbg("bnode(%d:%d): 1\n",
> =C2=A0		node->tree->cnid, node->this);
> =C2=A0	init_waitqueue_head(&node->lock_wq);
> =C2=A0	spin_lock(&tree->hash_lock);
> @@ -309,7 +309,7 @@ void hfs_bnode_unhash(struct hfs_bnode *node)
> =C2=A0{
> =C2=A0	struct hfs_bnode **p;
> =C2=A0
> -	hfs_dbg(BNODE_REFS, "remove_node(%d:%d): %d\n",
> +	hfs_dbg("bnode(%d:%d): %d\n",
> =C2=A0		node->tree->cnid, node->this, atomic_read(&node-
> >refcnt));
> =C2=A0	for (p =3D &node->tree->node_hash[hfs_bnode_hash(node->this)];
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 *p && *p !=3D node; p =3D &(*p)->next_has=
h)
> @@ -454,7 +454,7 @@ void hfs_bnode_get(struct hfs_bnode *node)
> =C2=A0{
> =C2=A0	if (node) {
> =C2=A0		atomic_inc(&node->refcnt);
> -		hfs_dbg(BNODE_REFS, "get_node(%d:%d): %d\n",
> +		hfs_dbg("bnode(%d:%d): %d\n",
> =C2=A0			node->tree->cnid, node->this,
> =C2=A0			atomic_read(&node->refcnt));
> =C2=A0	}
> @@ -467,7 +467,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
> =C2=A0		struct hfs_btree *tree =3D node->tree;
> =C2=A0		int i;
> =C2=A0
> -		hfs_dbg(BNODE_REFS, "put_node(%d:%d): %d\n",
> +		hfs_dbg("bnode(%d:%d): %d\n",
> =C2=A0			node->tree->cnid, node->this,
> =C2=A0			atomic_read(&node->refcnt));
> =C2=A0		BUG_ON(!atomic_read(&node->refcnt));
> diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
> index 896396554bcc..5a296493f1db 100644
> --- a/fs/hfs/brec.c
> +++ b/fs/hfs/brec.c
> @@ -94,7 +94,7 @@ int hfs_brec_insert(struct hfs_find_data *fd, void
> *entry, int entry_len)
> =C2=A0	end_rec_off =3D tree->node_size - (node->num_recs + 1) * 2;
> =C2=A0	end_off =3D hfs_bnode_read_u16(node, end_rec_off);
> =C2=A0	end_rec_off -=3D 2;
> -	hfs_dbg(BNODE_MOD, "insert_rec: %d, %d, %d, %d\n",
> +	hfs_dbg("RECORD: %d, %d, %d, %d\n",
> =C2=A0		rec, size, end_off, end_rec_off);
> =C2=A0	if (size > end_rec_off - end_off) {
> =C2=A0		if (new_node)
> @@ -191,7 +191,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
> =C2=A0		mark_inode_dirty(tree->inode);
> =C2=A0	}
> =C2=A0	hfs_bnode_dump(node);
> -	hfs_dbg(BNODE_MOD, "remove_rec: %d, %d\n",
> +	hfs_dbg("RECORD: %d, %d\n",
> =C2=A0		fd->record, fd->keylength + fd->entrylength);
> =C2=A0	if (!--node->num_recs) {
> =C2=A0		hfs_bnode_unlink(node);
> @@ -242,7 +242,7 @@ static struct hfs_bnode *hfs_bnode_split(struct
> hfs_find_data *fd)
> =C2=A0	if (IS_ERR(new_node))
> =C2=A0		return new_node;
> =C2=A0	hfs_bnode_get(node);
> -	hfs_dbg(BNODE_MOD, "split_nodes: %d - %d - %d\n",
> +	hfs_dbg("NODES: %d - %d - %d\n",
> =C2=A0		node->this, new_node->this, node->next);
> =C2=A0	new_node->next =3D node->next;
> =C2=A0	new_node->prev =3D node->this;
> @@ -378,7 +378,7 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0		newkeylen =3D (hfs_bnode_read_u8(node, 14) | 1) + 1;
> =C2=A0	else
> =C2=A0		fd->keylength =3D newkeylen =3D tree->max_key_len + 1;
> -	hfs_dbg(BNODE_MOD, "update_rec: %d, %d, %d\n",
> +	hfs_dbg("RECORD: %d, %d, %d\n",
> =C2=A0		rec, fd->keylength, newkeylen);
> =C2=A0
> =C2=A0	rec_off =3D tree->node_size - (rec + 2) * 2;
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 2fa4b1f8cc7f..a6bd76ee4d27 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -329,7 +329,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0	u32 nidx;
> =C2=A0	u8 *data, byte, m;
> =C2=A0
> -	hfs_dbg(BNODE_MOD, "btree_free_node: %u\n", node->this);
> +	hfs_dbg("bnode: %u\n", node->this);
> =C2=A0	tree =3D node->tree;
> =C2=A0	nidx =3D node->this;
> =C2=A0	node =3D hfs_bnode_find(tree, 0);
> diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
> index d63880e7d9d6..186e37bb6ea6 100644
> --- a/fs/hfs/catalog.c
> +++ b/fs/hfs/catalog.c
> @@ -87,7 +87,7 @@ int hfs_cat_create(u32 cnid, struct inode *dir,
> const struct qstr *str, struct i
> =C2=A0	int entry_size;
> =C2=A0	int err;
> =C2=A0
> -	hfs_dbg(CAT_MOD, "create_cat: %s,%u(%d)\n",
> +	hfs_dbg("entry: %s,%u(%d)\n",
> =C2=A0		str->name, cnid, inode->i_nlink);
> =C2=A0	if (dir->i_size >=3D HFS_MAX_VALENCE)
> =C2=A0		return -ENOSPC;
> @@ -225,7 +225,7 @@ int hfs_cat_delete(u32 cnid, struct inode *dir,
> const struct qstr *str)
> =C2=A0	struct hfs_readdir_data *rd;
> =C2=A0	int res, type;
> =C2=A0
> -	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name :
> NULL, cnid);
> +	hfs_dbg("entry: %s,%u\n", str ? str->name : NULL, cnid);
> =C2=A0	sb =3D dir->i_sb;
> =C2=A0	res =3D hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
> =C2=A0	if (res)
> @@ -294,7 +294,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir,
> const struct qstr *src_name,
> =C2=A0	int entry_size, type;
> =C2=A0	int err;
> =C2=A0
> -	hfs_dbg(CAT_MOD, "rename_cat: %u - %lu,%s - %lu,%s\n",
> +	hfs_dbg("CNID %u - entry1(%lu,%s) - entry2(%lu,%s)\n",
> =C2=A0		cnid, src_dir->i_ino, src_name->name,
> =C2=A0		dst_dir->i_ino, dst_name->name);
> =C2=A0	sb =3D src_dir->i_sb;
> diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
> index 4a0ce131e233..69f67e5ecaa7 100644
> --- a/fs/hfs/extent.c
> +++ b/fs/hfs/extent.c
> @@ -209,12 +209,12 @@ static void hfs_dump_extent(struct hfs_extent
> *extent)
> =C2=A0{
> =C2=A0	int i;
> =C2=A0
> -	hfs_dbg(EXTENT, "=C2=A0=C2=A0 ");
> +	hfs_dbg("EXTENT:=C2=A0=C2=A0 ");
> =C2=A0	for (i =3D 0; i < 3; i++)
> -		hfs_dbg_cont(EXTENT, " %u:%u",
> -			=C2=A0=C2=A0=C2=A0=C2=A0 be16_to_cpu(extent[i].block),
> -			=C2=A0=C2=A0=C2=A0=C2=A0 be16_to_cpu(extent[i].count));
> -	hfs_dbg_cont(EXTENT, "\n");
> +		hfs_dbg(" %u:%u",
> +			be16_to_cpu(extent[i].block),
> +			be16_to_cpu(extent[i].count));
> +	hfs_dbg("\n");
> =C2=A0}
> =C2=A0
> =C2=A0static int hfs_add_extent(struct hfs_extent *extent, u16 offset,
> @@ -411,10 +411,10 @@ int hfs_extend_file(struct inode *inode)
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> -	hfs_dbg(EXTENT, "extend %lu: %u,%u\n", inode->i_ino, start,
> len);
> +	hfs_dbg("ino %lu: start %u, len %u\n", inode->i_ino, start,
> len);
> =C2=A0	if (HFS_I(inode)->alloc_blocks =3D=3D HFS_I(inode)-
> >first_blocks) {
> =C2=A0		if (!HFS_I(inode)->first_blocks) {
> -			hfs_dbg(EXTENT, "first extents\n");
> +			hfs_dbg("first extents\n");
> =C2=A0			/* no extents yet */
> =C2=A0			HFS_I(inode)->first_extents[0].block =3D
> cpu_to_be16(start);
> =C2=A0			HFS_I(inode)->first_extents[0].count =3D
> cpu_to_be16(len);
> @@ -456,7 +456,7 @@ int hfs_extend_file(struct inode *inode)
> =C2=A0	return res;
> =C2=A0
> =C2=A0insert_extent:
> -	hfs_dbg(EXTENT, "insert new extent\n");
> +	hfs_dbg("insert new extent\n");
> =C2=A0	res =3D hfs_ext_write_extent(inode);
> =C2=A0	if (res)
> =C2=A0		goto out;
> @@ -481,7 +481,7 @@ void hfs_file_truncate(struct inode *inode)
> =C2=A0	u32 size;
> =C2=A0	int res;
> =C2=A0
> -	hfs_dbg(INODE, "truncate: %lu, %Lu -> %Lu\n",
> +	hfs_dbg("ino: %lu, phys_size %llu -> i_size %llu\n",
> =C2=A0		inode->i_ino, (long long)HFS_I(inode)->phys_size,
> =C2=A0		inode->i_size);
> =C2=A0	if (inode->i_size > HFS_I(inode)->phys_size) {
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index a0c7cb0f79fc..bc2d1fee4380 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -9,12 +9,6 @@
> =C2=A0#ifndef _LINUX_HFS_FS_H
> =C2=A0#define _LINUX_HFS_FS_H
> =C2=A0
> -#ifdef pr_fmt
> -#undef pr_fmt
> -#endif
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/mutex.h>
> @@ -24,35 +18,10 @@
> =C2=A0
> =C2=A0#include <asm/byteorder.h>
> =C2=A0#include <linux/uaccess.h>
> +#include <linux/hfs_common.h>
> =C2=A0
> =C2=A0#include "hfs.h"
> =C2=A0
> -#define DBG_BNODE_REFS	0x00000001
> -#define DBG_BNODE_MOD	0x00000002
> -#define DBG_CAT_MOD	0x00000004
> -#define DBG_INODE	0x00000008
> -#define DBG_SUPER	0x00000010
> -#define DBG_EXTENT	0x00000020
> -#define DBG_BITMAP	0x00000040
> -
> -//#define
> DBG_MASK	(DBG_EXTENT|DBG_INODE|DBG_BNODE_MOD|DBG_CAT_MOD|DBG_BITMAP)
> -//#define DBG_MASK	(DBG_BNODE_MOD|DBG_CAT_MOD|DBG_INODE)
> -//#define
> DBG_MASK	(DBG_CAT_MOD|DBG_BNODE_REFS|DBG_INODE|DBG_EXTENT)
> -#define DBG_MASK	(0)
> -
> -#define hfs_dbg(flg, fmt, ...)					\
> -do {								\
> -	if (DBG_##flg & DBG_MASK)				\
> -		printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
> -} while (0)
> -
> -#define hfs_dbg_cont(flg, fmt, ...)				\
> -do {								\
> -	if (DBG_##flg & DBG_MASK)				\
> -		pr_cont(fmt, ##__VA_ARGS__);			\
> -} while (0)
> -
> -
> =C2=A0/*
> =C2=A0 * struct hfs_inode_info
> =C2=A0 *
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index a81ce7a740b9..e5e40d128f28 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -241,7 +241,7 @@ void hfs_delete_inode(struct inode *inode)
> =C2=A0{
> =C2=A0	struct super_block *sb =3D inode->i_sb;
> =C2=A0
> -	hfs_dbg(INODE, "delete_inode: %lu\n", inode->i_ino);
> +	hfs_dbg("ino: %lu\n", inode->i_ino);
> =C2=A0	if (S_ISDIR(inode->i_mode)) {
> =C2=A0		HFS_SB(sb)->folder_count--;
> =C2=A0		if (HFS_I(inode)->cat_key.ParID =3D=3D
> cpu_to_be32(HFS_ROOT_CNID))
> @@ -425,7 +425,7 @@ int hfs_write_inode(struct inode *inode, struct
> writeback_control *wbc)
> =C2=A0	hfs_cat_rec rec;
> =C2=A0	int res;
> =C2=A0
> -	hfs_dbg(INODE, "hfs_write_inode: %lu\n", inode->i_ino);
> +	hfs_dbg("ino: %lu\n", inode->i_ino);
> =C2=A0	res =3D hfs_ext_write_extent(inode);
> =C2=A0	if (res)
> =C2=A0		return res;
> diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
> index eeebe80c6be4..4682d10f51d1 100644
> --- a/fs/hfsplus/attributes.c
> +++ b/fs/hfsplus/attributes.c
> @@ -139,7 +139,7 @@ int hfsplus_find_attr(struct super_block *sb, u32
> cnid,
> =C2=A0{
> =C2=A0	int err =3D 0;
> =C2=A0
> -	hfs_dbg(ATTR_MOD, "find_attr: %s,%d\n", name ? name : NULL,
> cnid);
> +	hfs_dbg("%s,%d\n", name ? name : NULL, cnid);
> =C2=A0
> =C2=A0	if (!HFSPLUS_SB(sb)->attr_tree) {
> =C2=A0		pr_err("attributes file doesn't exist\n");
> @@ -201,7 +201,7 @@ int hfsplus_create_attr(struct inode *inode,
> =C2=A0	int entry_size;
> =C2=A0	int err;
> =C2=A0
> -	hfs_dbg(ATTR_MOD, "create_attr: %s,%ld\n",
> +	hfs_dbg("%s,%ld\n",
> =C2=A0		name ? name : NULL, inode->i_ino);
> =C2=A0
> =C2=A0	if (!HFSPLUS_SB(sb)->attr_tree) {
> @@ -310,7 +310,7 @@ int hfsplus_delete_attr(struct inode *inode,
> const char *name)
> =C2=A0	struct super_block *sb =3D inode->i_sb;
> =C2=A0	struct hfs_find_data fd;
> =C2=A0
> -	hfs_dbg(ATTR_MOD, "delete_attr: %s,%ld\n",
> +	hfs_dbg("%s,%ld\n",
> =C2=A0		name ? name : NULL, inode->i_ino);
> =C2=A0
> =C2=A0	if (!HFSPLUS_SB(sb)->attr_tree) {
> @@ -356,7 +356,7 @@ int hfsplus_delete_all_attrs(struct inode *dir,
> u32 cnid)
> =C2=A0	int err =3D 0;
> =C2=A0	struct hfs_find_data fd;
> =C2=A0
> -	hfs_dbg(ATTR_MOD, "delete_all_attrs: %d\n", cnid);
> +	hfs_dbg("cnid: %d\n", cnid);
> =C2=A0
> =C2=A0	if (!HFSPLUS_SB(dir->i_sb)->attr_tree) {
> =C2=A0		pr_err("attributes file doesn't exist\n");
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index 901e83d65d20..9a8456e08ea5 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -23,7 +23,7 @@ int hfs_find_init(struct hfs_btree *tree, struct
> hfs_find_data *fd)
> =C2=A0		return -ENOMEM;
> =C2=A0	fd->search_key =3D ptr;
> =C2=A0	fd->key =3D ptr + tree->max_key_len + 2;
> -	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
> +	hfs_dbg("find_init: %d (%p)\n",
> =C2=A0		tree->cnid, __builtin_return_address(0));


I've reworked the HFS subsystem but I completely forgot about HFS+ file
system driver. :) It needs to rework the patch again.

Thanks,
Slava.

> =C2=A0	mutex_lock_nested(&tree->tree_lock,
> =C2=A0			hfsplus_btree_lock_class(tree));
> @@ -34,7 +34,7 @@ void hfs_find_exit(struct hfs_find_data *fd)
> =C2=A0{
> =C2=A0	hfs_bnode_put(fd->bnode);
> =C2=A0	kfree(fd->search_key);
> -	hfs_dbg(BNODE_REFS, "find_exit: %d (%p)\n",
> +	hfs_dbg("find_exit: %d (%p)\n",
> =C2=A0		fd->tree->cnid, __builtin_return_address(0));
> =C2=A0	mutex_unlock(&fd->tree->tree_lock);
> =C2=A0	fd->tree =3D NULL;
> diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
> index bd8dcea85588..658a75669afe 100644
> --- a/fs/hfsplus/bitmap.c
> +++ b/fs/hfsplus/bitmap.c
> @@ -31,7 +31,7 @@ int hfsplus_block_allocate(struct super_block *sb,
> u32 size,
> =C2=A0	if (!len)
> =C2=A0		return size;
> =C2=A0
> -	hfs_dbg(BITMAP, "block_allocate: %u,%u,%u\n", size, offset,
> len);
> +	hfs_dbg("block_allocate: %u,%u,%u\n", size, offset, len);
> =C2=A0	mutex_lock(&sbi->alloc_mutex);
> =C2=A0	mapping =3D sbi->alloc_file->i_mapping;
> =C2=A0	page =3D read_mapping_page(mapping, offset / PAGE_CACHE_BITS,
> NULL);
> @@ -90,14 +90,14 @@ int hfsplus_block_allocate(struct super_block
> *sb, u32 size,
> =C2=A0		else
> =C2=A0			end =3D pptr + ((size + 31) & (PAGE_CACHE_BITS
> - 1)) / 32;
> =C2=A0	}
> -	hfs_dbg(BITMAP, "bitmap full\n");
> +	hfs_dbg("bitmap full\n");
> =C2=A0	start =3D size;
> =C2=A0	goto out;
> =C2=A0
> =C2=A0found:
> =C2=A0	start =3D offset + (curr - pptr) * 32 + i;
> =C2=A0	if (start >=3D size) {
> -		hfs_dbg(BITMAP, "bitmap full\n");
> +		hfs_dbg("bitmap full\n");
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0	/* do any partial u32 at the start */
> @@ -155,7 +155,7 @@ int hfsplus_block_allocate(struct super_block
> *sb, u32 size,
> =C2=A0	*max =3D offset + (curr - pptr) * 32 + i - start;
> =C2=A0	sbi->free_blocks -=3D *max;
> =C2=A0	hfsplus_mark_mdb_dirty(sb);
> -	hfs_dbg(BITMAP, "-> %u,%u\n", start, *max);
> +	hfs_dbg("-> %u,%u\n", start, *max);
> =C2=A0out:
> =C2=A0	mutex_unlock(&sbi->alloc_mutex);
> =C2=A0	return start;
> @@ -174,7 +174,7 @@ int hfsplus_block_free(struct super_block *sb,
> u32 offset, u32 count)
> =C2=A0	if (!count)
> =C2=A0		return 0;
> =C2=A0
> -	hfs_dbg(BITMAP, "block_free: %u,%u\n", offset, count);
> +	hfs_dbg("block_free: %u,%u\n", offset, count);
> =C2=A0	/* are all of the bits in range? */
> =C2=A0	if ((offset + count) > sbi->total_blocks)
> =C2=A0		return -ENOENT;
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 079ea80534f7..ff5bbdc197b6 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -130,7 +130,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node,
> int dst,
> =C2=A0	struct page **src_page, **dst_page;
> =C2=A0	int l;
> =C2=A0
> -	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src, len);
> +	hfs_dbg("copybytes: %u,%u,%u\n", dst, src, len);
> =C2=A0	if (!len)
> =C2=A0		return;
> =C2=A0	src +=3D src_node->page_offset;
> @@ -184,7 +184,7 @@ void hfs_bnode_move(struct hfs_bnode *node, int
> dst, int src, int len)
> =C2=A0	void *src_ptr, *dst_ptr;
> =C2=A0	int l;
> =C2=A0
> -	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
> +	hfs_dbg("movebytes: %u,%u,%u\n", dst, src, len);
> =C2=A0	if (!len)
> =C2=A0		return;
> =C2=A0	src +=3D node->page_offset;
> @@ -300,16 +300,16 @@ void hfs_bnode_dump(struct hfs_bnode *node)
> =C2=A0	__be32 cnid;
> =C2=A0	int i, off, key_off;
> =C2=A0
> -	hfs_dbg(BNODE_MOD, "bnode: %d\n", node->this);
> +	hfs_dbg("bnode: %d\n", node->this);
> =C2=A0	hfs_bnode_read(node, &desc, 0, sizeof(desc));
> -	hfs_dbg(BNODE_MOD, "%d, %d, %d, %d, %d\n",
> +	hfs_dbg("%d, %d, %d, %d, %d\n",
> =C2=A0		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
> =C2=A0		desc.type, desc.height, be16_to_cpu(desc.num_recs));
> =C2=A0
> =C2=A0	off =3D node->tree->node_size - 2;
> =C2=A0	for (i =3D be16_to_cpu(desc.num_recs); i >=3D 0; off -=3D 2, i--)
> {
> =C2=A0		key_off =3D hfs_bnode_read_u16(node, off);
> -		hfs_dbg(BNODE_MOD, " %d", key_off);
> +		hfs_dbg(" %d", key_off);
> =C2=A0		if (i && node->type =3D=3D HFS_NODE_INDEX) {
> =C2=A0			int tmp;
> =C2=A0
> @@ -318,17 +318,17 @@ void hfs_bnode_dump(struct hfs_bnode *node)
> =C2=A0				tmp =3D hfs_bnode_read_u16(node,
> key_off) + 2;
> =C2=A0			else
> =C2=A0				tmp =3D node->tree->max_key_len + 2;
> -			hfs_dbg_cont(BNODE_MOD, " (%d", tmp);
> +			hfs_dbg(" (%d", tmp);
> =C2=A0			hfs_bnode_read(node, &cnid, key_off + tmp,
> 4);
> -			hfs_dbg_cont(BNODE_MOD, ",%d)",
> be32_to_cpu(cnid));
> +			hfs_dbg(",%d)", be32_to_cpu(cnid));
> =C2=A0		} else if (i && node->type =3D=3D HFS_NODE_LEAF) {
> =C2=A0			int tmp;
> =C2=A0
> =C2=A0			tmp =3D hfs_bnode_read_u16(node, key_off);
> -			hfs_dbg_cont(BNODE_MOD, " (%d)", tmp);
> +			hfs_dbg(" (%d)", tmp);
> =C2=A0		}
> =C2=A0	}
> -	hfs_dbg_cont(BNODE_MOD, "\n");
> +	hfs_dbg("\n");
> =C2=A0}
> =C2=A0
> =C2=A0void hfs_bnode_unlink(struct hfs_bnode *node)
> @@ -364,7 +364,7 @@ void hfs_bnode_unlink(struct hfs_bnode *node)
> =C2=A0
> =C2=A0	/* move down? */
> =C2=A0	if (!node->prev && !node->next)
> -		hfs_dbg(BNODE_MOD, "hfs_btree_del_level\n");
> +		hfs_dbg("btree delete level\n");
> =C2=A0	if (!node->parent) {
> =C2=A0		tree->root =3D 0;
> =C2=A0		tree->depth =3D 0;
> @@ -419,7 +419,7 @@ static struct hfs_bnode
> *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
> =C2=A0	node->this =3D cnid;
> =C2=A0	set_bit(HFS_BNODE_NEW, &node->flags);
> =C2=A0	atomic_set(&node->refcnt, 1);
> -	hfs_dbg(BNODE_REFS, "new_node(%d:%d): 1\n",
> +	hfs_dbg("new_node(%d:%d): 1\n",
> =C2=A0		node->tree->cnid, node->this);
> =C2=A0	init_waitqueue_head(&node->lock_wq);
> =C2=A0	spin_lock(&tree->hash_lock);
> @@ -459,7 +459,7 @@ void hfs_bnode_unhash(struct hfs_bnode *node)
> =C2=A0{
> =C2=A0	struct hfs_bnode **p;
> =C2=A0
> -	hfs_dbg(BNODE_REFS, "remove_node(%d:%d): %d\n",
> +	hfs_dbg("remove_node(%d:%d): %d\n",
> =C2=A0		node->tree->cnid, node->this, atomic_read(&node-
> >refcnt));
> =C2=A0	for (p =3D &node->tree->node_hash[hfs_bnode_hash(node->this)];
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 *p && *p !=3D node; p =3D &(*p)->next_has=
h)
> @@ -605,7 +605,7 @@ void hfs_bnode_get(struct hfs_bnode *node)
> =C2=A0{
> =C2=A0	if (node) {
> =C2=A0		atomic_inc(&node->refcnt);
> -		hfs_dbg(BNODE_REFS, "get_node(%d:%d): %d\n",
> +		hfs_dbg("get_node(%d:%d): %d\n",
> =C2=A0			node->tree->cnid, node->this,
> =C2=A0			atomic_read(&node->refcnt));
> =C2=A0	}
> @@ -618,7 +618,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
> =C2=A0		struct hfs_btree *tree =3D node->tree;
> =C2=A0		int i;
> =C2=A0
> -		hfs_dbg(BNODE_REFS, "put_node(%d:%d): %d\n",
> +		hfs_dbg("put_node(%d:%d): %d\n",
> =C2=A0			node->tree->cnid, node->this,
> =C2=A0			atomic_read(&node->refcnt));
> =C2=A0		BUG_ON(!atomic_read(&node->refcnt));
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index 1918544a7871..05b385231ea2 100644
> --- a/fs/hfsplus/brec.c
> +++ b/fs/hfsplus/brec.c
> @@ -92,7 +92,7 @@ int hfs_brec_insert(struct hfs_find_data *fd, void
> *entry, int entry_len)
> =C2=A0	end_rec_off =3D tree->node_size - (node->num_recs + 1) * 2;
> =C2=A0	end_off =3D hfs_bnode_read_u16(node, end_rec_off);
> =C2=A0	end_rec_off -=3D 2;
> -	hfs_dbg(BNODE_MOD, "insert_rec: %d, %d, %d, %d\n",
> +	hfs_dbg("insert_rec: %d, %d, %d, %d\n",
> =C2=A0		rec, size, end_off, end_rec_off);
> =C2=A0	if (size > end_rec_off - end_off) {
> =C2=A0		if (new_node)
> @@ -193,7 +193,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
> =C2=A0		mark_inode_dirty(tree->inode);
> =C2=A0	}
> =C2=A0	hfs_bnode_dump(node);
> -	hfs_dbg(BNODE_MOD, "remove_rec: %d, %d\n",
> +	hfs_dbg("remove_rec: %d, %d\n",
> =C2=A0		fd->record, fd->keylength + fd->entrylength);
> =C2=A0	if (!--node->num_recs) {
> =C2=A0		hfs_bnode_unlink(node);
> @@ -246,7 +246,7 @@ static struct hfs_bnode *hfs_bnode_split(struct
> hfs_find_data *fd)
> =C2=A0	if (IS_ERR(new_node))
> =C2=A0		return new_node;
> =C2=A0	hfs_bnode_get(node);
> -	hfs_dbg(BNODE_MOD, "split_nodes: %d - %d - %d\n",
> +	hfs_dbg("split_nodes: %d - %d - %d\n",
> =C2=A0		node->this, new_node->this, node->next);
> =C2=A0	new_node->next =3D node->next;
> =C2=A0	new_node->prev =3D node->this;
> @@ -383,7 +383,7 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0		newkeylen =3D hfs_bnode_read_u16(node, 14) + 2;
> =C2=A0	else
> =C2=A0		fd->keylength =3D newkeylen =3D tree->max_key_len + 2;
> -	hfs_dbg(BNODE_MOD, "update_rec: %d, %d, %d\n",
> +	hfs_dbg("update_rec: %d, %d, %d\n",
> =C2=A0		rec, fd->keylength, newkeylen);
> =C2=A0
> =C2=A0	rec_off =3D tree->node_size - (rec + 2) * 2;
> @@ -395,7 +395,7 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0		end_off =3D hfs_bnode_read_u16(parent, end_rec_off);
> =C2=A0		if (end_rec_off - end_off < diff) {
> =C2=A0
> -			hfs_dbg(BNODE_MOD, "splitting index
> node\n");
> +			hfs_dbg("splitting index node\n");
> =C2=A0			fd->bnode =3D parent;
> =C2=A0			new_node =3D hfs_bnode_split(fd);
> =C2=A0			if (IS_ERR(new_node))
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 9e1732a2b92a..87098cb599bc 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -428,7 +428,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree
> *tree)
> =C2=A0		kunmap_local(data);
> =C2=A0		nidx =3D node->next;
> =C2=A0		if (!nidx) {
> -			hfs_dbg(BNODE_MOD, "create new bmap
> node\n");
> +			hfs_dbg("create new bmap node\n");
> =C2=A0			next_node =3D hfs_bmap_new_bmap(node, idx);
> =C2=A0		} else
> =C2=A0			next_node =3D hfs_bnode_find(tree, nidx);
> @@ -454,7 +454,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0	u32 nidx;
> =C2=A0	u8 *data, byte, m;
> =C2=A0
> -	hfs_dbg(BNODE_MOD, "btree_free_node: %u\n", node->this);
> +	hfs_dbg("btree_free_node: %u\n", node->this);
> =C2=A0	BUG_ON(!node->this);
> =C2=A0	tree =3D node->tree;
> =C2=A0	nidx =3D node->this;
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 1995bafee839..1432ede1bfd5 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -259,7 +259,7 @@ int hfsplus_create_cat(u32 cnid, struct inode
> *dir,
> =C2=A0	int entry_size;
> =C2=A0	int err;
> =C2=A0
> -	hfs_dbg(CAT_MOD, "create_cat: %s,%u(%d)\n",
> +	hfs_dbg("create_cat: %s,%u(%d)\n",
> =C2=A0		str->name, cnid, inode->i_nlink);
> =C2=A0	err =3D hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
> =C2=A0	if (err)
> @@ -336,7 +336,7 @@ int hfsplus_delete_cat(u32 cnid, struct inode
> *dir, const struct qstr *str)
> =C2=A0	int err, off;
> =C2=A0	u16 type;
> =C2=A0
> -	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name :
> NULL, cnid);
> +	hfs_dbg("delete_cat: %s,%u\n", str ? str->name : NULL,
> cnid);
> =C2=A0	err =3D hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
> =C2=A0	if (err)
> =C2=A0		return err;
> @@ -441,7 +441,7 @@ int hfsplus_rename_cat(u32 cnid,
> =C2=A0	int entry_size, type;
> =C2=A0	int err;
> =C2=A0
> -	hfs_dbg(CAT_MOD, "rename_cat: %u - %lu,%s - %lu,%s\n",
> +	hfs_dbg("rename_cat: %u - %lu,%s - %lu,%s\n",
> =C2=A0		cnid, src_dir->i_ino, src_name->name,
> =C2=A0		dst_dir->i_ino, dst_name->name);
> =C2=A0	err =3D hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &src_fd);
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index a6d61685ae79..f56985bfe1db 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -275,7 +275,7 @@ int hfsplus_get_block(struct inode *inode,
> sector_t iblock,
> =C2=A0	mutex_unlock(&hip->extents_lock);
> =C2=A0
> =C2=A0done:
> -	hfs_dbg(EXTENT, "get_block(%lu): %llu - %u\n",
> +	hfs_dbg("get_block(%lu): %llu - %u\n",
> =C2=A0		inode->i_ino, (long long)iblock, dblock);
> =C2=A0
> =C2=A0	mask =3D (1 << sbi->fs_shift) - 1;
> @@ -298,12 +298,12 @@ static void hfsplus_dump_extent(struct
> hfsplus_extent *extent)
> =C2=A0{
> =C2=A0	int i;
> =C2=A0
> -	hfs_dbg(EXTENT, "=C2=A0=C2=A0 ");
> +	hfs_dbg("=C2=A0=C2=A0 ");
> =C2=A0	for (i =3D 0; i < 8; i++)
> -		hfs_dbg_cont(EXTENT, " %u:%u",
> -			=C2=A0=C2=A0=C2=A0=C2=A0 be32_to_cpu(extent[i].start_block),
> -			=C2=A0=C2=A0=C2=A0=C2=A0 be32_to_cpu(extent[i].block_count));
> -	hfs_dbg_cont(EXTENT, "\n");
> +		hfs_dbg(" %u:%u",
> +			be32_to_cpu(extent[i].start_block),
> +			be32_to_cpu(extent[i].block_count));
> +	hfs_dbg("\n");
> =C2=A0}
> =C2=A0
> =C2=A0static int hfsplus_add_extent(struct hfsplus_extent *extent, u32
> offset,
> @@ -363,7 +363,7 @@ static int hfsplus_free_extents(struct
> super_block *sb,
> =C2=A0			err =3D hfsplus_block_free(sb, start, count);
> =C2=A0			if (err) {
> =C2=A0				pr_err("can't free extent\n");
> -				hfs_dbg(EXTENT, " start: %u count:
> %u\n",
> +				hfs_dbg(" start: %u count: %u\n",
> =C2=A0					start, count);
> =C2=A0			}
> =C2=A0			extent->block_count =3D 0;
> @@ -374,7 +374,7 @@ static int hfsplus_free_extents(struct
> super_block *sb,
> =C2=A0			err =3D hfsplus_block_free(sb, start + count,
> block_nr);
> =C2=A0			if (err) {
> =C2=A0				pr_err("can't free extent\n");
> -				hfs_dbg(EXTENT, " start: %u count:
> %u\n",
> +				hfs_dbg(" start: %u count: %u\n",
> =C2=A0					start, count);
> =C2=A0			}
> =C2=A0			extent->block_count =3D cpu_to_be32(count);
> @@ -481,11 +481,11 @@ int hfsplus_file_extend(struct inode *inode,
> bool zeroout)
> =C2=A0			goto out;
> =C2=A0	}
> =C2=A0
> -	hfs_dbg(EXTENT, "extend %lu: %u,%u\n", inode->i_ino, start,
> len);
> +	hfs_dbg("extend %lu: %u,%u\n", inode->i_ino, start, len);
> =C2=A0
> =C2=A0	if (hip->alloc_blocks <=3D hip->first_blocks) {
> =C2=A0		if (!hip->first_blocks) {
> -			hfs_dbg(EXTENT, "first extents\n");
> +			hfs_dbg("first extents\n");
> =C2=A0			/* no extents yet */
> =C2=A0			hip->first_extents[0].start_block =3D
> cpu_to_be32(start);
> =C2=A0			hip->first_extents[0].block_count =3D
> cpu_to_be32(len);
> @@ -524,7 +524,7 @@ int hfsplus_file_extend(struct inode *inode, bool
> zeroout)
> =C2=A0	return res;
> =C2=A0
> =C2=A0insert_extent:
> -	hfs_dbg(EXTENT, "insert new extent\n");
> +	hfs_dbg("insert new extent\n");
> =C2=A0	res =3D hfsplus_ext_write_extent_locked(inode);
> =C2=A0	if (res)
> =C2=A0		goto out;
> @@ -549,7 +549,7 @@ void hfsplus_file_truncate(struct inode *inode)
> =C2=A0	u32 alloc_cnt, blk_cnt, start;
> =C2=A0	int res;
> =C2=A0
> -	hfs_dbg(INODE, "truncate: %lu, %llu -> %llu\n",
> +	hfs_dbg("truncate: %lu, %llu -> %llu\n",
> =C2=A0		inode->i_ino, (long long)hip->phys_size, inode-
> >i_size);
> =C2=A0
> =C2=A0	if (inode->i_size > hip->phys_size) {
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 2f089bff0095..de8c4f0bc808 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -11,47 +11,14 @@
> =C2=A0#ifndef _LINUX_HFSPLUS_FS_H
> =C2=A0#define _LINUX_HFSPLUS_FS_H
> =C2=A0
> -#ifdef pr_fmt
> -#undef pr_fmt
> -#endif
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/mutex.h>
> =C2=A0#include <linux/buffer_head.h>
> =C2=A0#include <linux/blkdev.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/hfs_common.h>
> =C2=A0#include "hfsplus_raw.h"
> =C2=A0
> -#define DBG_BNODE_REFS	0x00000001
> -#define DBG_BNODE_MOD	0x00000002
> -#define DBG_CAT_MOD	0x00000004
> -#define DBG_INODE	0x00000008
> -#define DBG_SUPER	0x00000010
> -#define DBG_EXTENT	0x00000020
> -#define DBG_BITMAP	0x00000040
> -#define DBG_ATTR_MOD	0x00000080
> -
> -#if 0
> -#define DBG_MASK	(DBG_EXTENT|DBG_INODE|DBG_BNODE_MOD)
> -#define DBG_MASK	(DBG_BNODE_MOD|DBG_CAT_MOD|DBG_INODE)
> -#define
> DBG_MASK	(DBG_CAT_MOD|DBG_BNODE_REFS|DBG_INODE|DBG_EXTENT)
> -#endif
> -#define DBG_MASK	(0)
> -
> -#define hfs_dbg(flg, fmt, ...)					\
> -do {								\
> -	if (DBG_##flg & DBG_MASK)				\
> -		printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
> -} while (0)
> -
> -#define hfs_dbg_cont(flg, fmt, ...)				\
> -do {								\
> -	if (DBG_##flg & DBG_MASK)				\
> -		pr_cont(fmt, ##__VA_ARGS__);			\
> -} while (0)
> -
> =C2=A0/* Runtime config options */
> =C2=A0#define HFSPLUS_DEF_CR_TYPE=C2=A0=C2=A0=C2=A0 0x3F3F3F3F=C2=A0 /* '=
????' */
> =C2=A0
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 948b8aaee33e..75ed6f1ae6b4 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -150,7 +150,7 @@ static int hfsplus_write_inode(struct inode
> *inode,
> =C2=A0{
> =C2=A0	int err;
> =C2=A0
> -	hfs_dbg(INODE, "hfsplus_write_inode: %lu\n", inode->i_ino);
> +	hfs_dbg("ino: %lu\n", inode->i_ino);
> =C2=A0
> =C2=A0	err =3D hfsplus_ext_write_extent(inode);
> =C2=A0	if (err)
> @@ -165,7 +165,7 @@ static int hfsplus_write_inode(struct inode
> *inode,
> =C2=A0
> =C2=A0static void hfsplus_evict_inode(struct inode *inode)
> =C2=A0{
> -	hfs_dbg(INODE, "hfsplus_evict_inode: %lu\n", inode->i_ino);
> +	hfs_dbg("ino: %lu\n", inode->i_ino);
> =C2=A0	truncate_inode_pages_final(&inode->i_data);
> =C2=A0	clear_inode(inode);
> =C2=A0	if (HFSPLUS_IS_RSRC(inode)) {
> @@ -184,7 +184,7 @@ static int hfsplus_sync_fs(struct super_block
> *sb, int wait)
> =C2=A0	if (!wait)
> =C2=A0		return 0;
> =C2=A0
> -	hfs_dbg(SUPER, "hfsplus_sync_fs\n");
> +	hfs_dbg("execute sync_fs\n");
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Explicitly write out the special metadata inodes.
> @@ -290,7 +290,7 @@ static void hfsplus_put_super(struct super_block
> *sb)
> =C2=A0{
> =C2=A0	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> =C2=A0
> -	hfs_dbg(SUPER, "hfsplus_put_super\n");
> +	hfs_dbg("execute put super\n");
> =C2=A0
> =C2=A0	cancel_delayed_work_sync(&sbi->sync_work);
> =C2=A0
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 9a1a93e3888b..ae58cc4309eb 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -64,7 +64,7 @@ static void hfsplus_init_header_node(struct inode
> *attr_file,
> =C2=A0	u32 used_bmp_bytes;
> =C2=A0	u64 tmp;
> =C2=A0
> -	hfs_dbg(ATTR_MOD, "init_hdr_attr_file: clump %u, node_size
> %u\n",
> +	hfs_dbg("clump %u, node_size %u\n",
> =C2=A0		clump_size, node_size);
> =C2=A0
> =C2=A0	/* The end of the node contains list of record offsets */
> @@ -132,7 +132,7 @@ static int hfsplus_create_attributes_file(struct
> super_block *sb)
> =C2=A0	struct page *page;
> =C2=A0	int old_state =3D HFSPLUS_EMPTY_ATTR_TREE;
> =C2=A0
> -	hfs_dbg(ATTR_MOD, "create_attr_file: ino %d\n",
> HFSPLUS_ATTR_CNID);
> +	hfs_dbg("ino %d\n", HFSPLUS_ATTR_CNID);
> =C2=A0
> =C2=A0check_attr_tree_state_again:
> =C2=A0	switch (atomic_read(&sbi->attr_tree_state)) {
> diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
> new file mode 100644
> index 000000000000..8838ca2f3d08
> --- /dev/null
> +++ b/include/linux/hfs_common.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * HFS/HFS+ common definitions, inline functions,
> + * and shared functionality.
> + */
> +
> +#ifndef _HFS_COMMON_H_
> +#define _HFS_COMMON_H_
> +
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#define hfs_dbg(fmt,
> ...)							\
> +	pr_debug("pid %d:%s:%d %s(): "
> fmt,					\
> +		 current->pid, __FILE__, __LINE__, __func__,
> ##__VA_ARGS__)	\
> +
> +#endif /* _HFS_COMMON_H_ */

