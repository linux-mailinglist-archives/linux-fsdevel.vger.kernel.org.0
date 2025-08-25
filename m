Return-Path: <linux-fsdevel+bounces-58981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08DB33A9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC0189B2AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B92C325D;
	Mon, 25 Aug 2025 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wjT/BKRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF2518A6A7;
	Mon, 25 Aug 2025 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113493; cv=none; b=e0XXV71kK+jeSoeksdfVGk7GWrmA++P7eUj2rViONOk0EYrPqa1x8Sl89YlpKtXTqPyrbiypV8RwJeCPZFGEFWMYtxYbZMCySeF2xVbt64Z4n1GX4cx738OzlqLAD1A/g2cfuhFzfxUL8RiGlLF4m9wWmFjgDjb/i5mvxEZxp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113493; c=relaxed/simple;
	bh=To7rvQS/35zwdvmVsuLT5NfWZqD2i2awmA4Z7+dYjRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb9rOXatc4J+od2RZgvCDTaEtaEFbKNtXJVly2VP1yqf6C+yN/MdFVQrB02uzoxZiKEGg1t+8D3ibWKVAI1tJ5sOkeDduwmkaF4WPAJX95f9HQuGU9jSVHlQbi77JXm/+BKf6hT5Qfm7GgvL7yazFY0i94UQhLfIzcKrzuLEDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wjT/BKRE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lCCdn0p0Ho8wzROROBqLi0hCMHBjqeHYc8dPEbtNq0A=; b=wjT/BKRENwVqwtrN70AommMDDX
	WCjjIOzXCd/sY743jhuzFcudIdsS/443u52QaqWPmSFcLhirZr/NFhfg7b4gCMRm9+hK+fLT0Wv9X
	jJK3qTxj9V4Pko3MQd0fm+4ufseyiB4HsBXBUJTcXrZiBGRqPSFChk1KyolzJLmk3vMWhR3TuHMjx
	sw/iIyoE7wn39iFhA4NWbwqr5mnvzDA59sAzv5elQx/BSY2q2X7H2i8sFYT46aowNzHH04NhjPMun
	y1a0DFmFk3PnMp4uL5iKjC+AeNul7IaAczwcsRaW0sxYRBnxriKo1qE2zPWh9xzDyWihp/BdDNq+q
	ZLVQupfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTL7-00000007TGP-3ogv;
	Mon, 25 Aug 2025 09:18:09 +0000
Date: Mon, 25 Aug 2025 02:18:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, rajeevm@hpe.com,
	yukuai3@huawei.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] loop: fix zero sized loop for block special file
Message-ID: <aKwqUVmX-yH6_lZy@infradead.org>
References: <20250825062300.2485281-1-yukuai1@huaweicloud.com>
 <aKwlVypJuBtPH_EL@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKwlVypJuBtPH_EL@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 25, 2025 at 04:56:55PM +0800, Ming Lei wrote:
> `stat $BDEV_PATH` never works for getting bdev size, so it looks wrong
> to call vfs_getattr_nosec() with bdev path for retrieving bdev's size.

Exactly.

> So just wondering why not take the following more readable way?
> 
> 	/* vfs_getattr() never works for retrieving bdev size */
> 	if (S_ISBLK(stat.mode)) {
> 		loopsize = i_size_read(file->f_mapping->host);
> 	} else {
>           ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
>           if (ret)
>                   return 0;
>           loopsize = stat.size;
> 	}
> 
> Also the above looks like how application reads file size in case of bdev
> involved.

That's not just more readable, but simply the way to go.  Maybe split
it into a helper for readability, though.

