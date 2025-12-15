Return-Path: <linux-fsdevel+bounces-71274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F39CBC367
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 02:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BD55300DCB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A363126BE;
	Mon, 15 Dec 2025 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Lffsu/gu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F000126C02;
	Mon, 15 Dec 2025 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765763670; cv=none; b=iUDOWwVRMCIeg4GgaS1G1Q3vSWalVOeUVqqdWW9J09BDszJ2jZQRPUSWDOpl7NKT4R8HBNiwqrLnlTvssPKnKlCWm1uD178+BsbUvgyWXbfplF5T2VNm3nIymA07EwA1j/jn4oFJggGujxTyhuAfs+bJVlogrobY9f2WB59juh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765763670; c=relaxed/simple;
	bh=rxkLXtaNGFecbSIc9zO2vWGIbHJZFJuVFaEHg3Lo4aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObzVgQydZ5Xn+Wtm2swQh4XNMKRMDACz1WRHVV4YPQryIU0qIlkAG/lLEajsV8lGTlFe25maTzRseuo7ruQOcet+vbXGyDTHL6UcIsp5Z7hGApGjz0EzNMj7SIVMCjVX8rM4MqVtxhL0P3x8mAYlAhin8Z99apmbAzURnuSXa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Lffsu/gu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OuULfq2Xag8coD1mfoavAYtIJln8EKeyEFYPvOmoJzs=; b=Lffsu/guHLDrhMZp2dmG9ShXbP
	D0F/qoUa3lGTj+6le1Snpb9Q8dkQsxyuQhfXeuCl2rKOeFDrHR+Ctg/E5NA2lxTWepiCfEru8kGJt
	42tNc+HlXloMCS0NkECjAcW6PfwtjeSFmV4sTyB/zHt31FXr/u4F0InRA1rqTEcHquqxZYZ/Z/oa1
	MsSd2f3youv1ieJ1S37xkppqYAEO/lOoGX2GRayRymR/b65fIo3qh6PJUkAsx7uiuGylpUlshe/1A
	qIFL/56wxipOsXQw0RyjGgh2xVsbXgcQAWC9tVbSqPUHvdvbQQofdeAYJpzHp53lhsUZpxW4SCx5u
	Auslhg2A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vUxng-0000000FH2S-1ul6;
	Mon, 15 Dec 2025 01:55:00 +0000
Date: Mon, 15 Dec 2025 01:55:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] adfs: fix memory leak in sb->s_fs_info
Message-ID: <20251215015500.GM1712166@ZenIV>
References: <20251213233621.151496-2-eraykrdg1@gmail.com>
 <20251215002252.158637-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215002252.158637-2-eraykrdg1@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 15, 2025 at 03:22:52AM +0300, Ahmet Eray Karadag wrote:

> @@ -403,15 +394,9 @@ static int adfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (!sb->s_root) {
>  		adfs_free_map(sb);
>  		adfs_error(sb, "get root inode failed\n");
> -		ret = -EIO;
> -		goto error;
> +		return -EIO;

Double-free again, this time of asb->s_map - adfs_free_map() is called
twice in that case, once here and once in adfs_kill_sb()...

> +static void adfs_kill_sb(struct super_block *sb)
> +{
> +	struct adfs_sb_info *asb = ADFS_SB(sb);
> +
> +	kill_block_super(sb);
> +
> +	adfs_free_map(sb);

... and calling adfs_map_relse(), which calls brelse() after the block
device has been closed.  IOW, unlike freeing the ->s_fs_info this can't
be done after kill_block_super().  And with this one we don't have that
kind of gap - it doesn't exist until adfs_fill_super(), so there's no
leak to be had anyway.  Yes, it would be possible to get rid of more
of cleanup on failure exit there, but it would require expanding
kill_block_super() and inserting adfs_free_map() call before the call
sync_blockdev() in there - more headache than you win in adfs_fill_super(),
IMO.

Leave adfs_free_map() in adfs_put_super() (or make _it_ ->put_super(),
for that matter).

