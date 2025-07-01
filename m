Return-Path: <linux-fsdevel+bounces-53417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B961AEEE6C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972203AE229
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 06:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E02246781;
	Tue,  1 Jul 2025 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4yNK6icE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBDB18DB27;
	Tue,  1 Jul 2025 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751350482; cv=none; b=KxJnkOJB1LELQ/G0RX2W9XM18VXhH8GdBAyJ/DS/z6Y0xEMp7U6sQA1XzNAjm+CHYn4xcq2mz+QCii46+X9ozLy71w8WqheNAvMVM0difRTOCc0mmLXD8DNGrEOTeUFOMoXwBKw11Q/zYtkfVlJ5QKxsiwXs1il5Yl3wftrVrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751350482; c=relaxed/simple;
	bh=fqfk3sXOy2ZiAiWY0+FRDfTGbWwX9D3PpPCPMIMtOHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ6HjfZUfosqt8th3ffIdWDlGXWaZfDNgUWb2rUwbN9YcTbvrRmlDVy9iIUz/i2ZFiU6FrQlV/eUhgKh0pPv/pjzVjtiGeZdZoEVoTJEJINV+2q+3rdhKrBt/2lJ+Pfkx9kfeC41A9Bi17Splu6qYcGPOQodDuVC1GJECHHrWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4yNK6icE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Gc4XjL5EuHDBKQZc9KZENAeMq/+oahftr2cmxvLnjwM=; b=4yNK6icE3icj78/Z5jgTDYUpNZ
	meqAdykMclbXUAmXPnY+taEuo2ZBnGs9S4rc8tWo9NDv/JAYb+IpTYoam3IlaOB2HQ4bI+qEhbkFP
	T7QytErxPpYn6NNBbTV0uQBICPSml8TxczM2ZDaQ5ZidDNmdfUTAImRmgO9vfWilrWbtZfPw6OXC5
	jMlllO3P5VHyohh43d/0d5kCphJMmDdnLRyzUxRqADd615zFAqtUAdQEnZArzXNSxxbC8axUva4qe
	D1Qw3Ya4FUZAiXqT4tZGtXE2PBpToDkZ0XpOCMvezR8GbkeOWQWqE21tVg2ghzmrIt58SfPRGBmOV
	86K6NqhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWUGM-000000047X1-0DQk;
	Tue, 01 Jul 2025 06:14:38 +0000
Date: Mon, 30 Jun 2025 23:14:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <aGN8zsyYEArKr0DV@infradead.org>
References: <cover.1751347436.git.wqu@suse.com>
 <6164b8c708b6606c640c066fbc42f8ca9838c24b.1751347436.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6164b8c708b6606c640c066fbc42f8ca9838c24b.1751347436.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 01, 2025 at 03:02:34PM +0930, Qu Wenruo wrote:
> To allow those multi-device filesystems to be integrated to use
> fs_holder_ops:
> 
> - Rename shutdown() call back to remove_bdev()
>   To better describe when the call back is called.

What is renamed back here?

> -static void exfat_shutdown(struct super_block *sb)
> +static void exfat_shutdown(struct super_block *sb, struct block_device *bdev)
>  {
>  	exfat_force_shutdown(sb, EXFAT_GOING_DOWN_NOSYNC);
>  }
> @@ -202,7 +202,7 @@ static const struct super_operations exfat_sops = {
>  	.put_super	= exfat_put_super,
>  	.statfs		= exfat_statfs,
>  	.show_options	= exfat_show_options,
> -	.shutdown	= exfat_shutdown,
> +	.remove_bdev	= exfat_shutdown,

Please also rename the function so that they match the method name.


