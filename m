Return-Path: <linux-fsdevel+bounces-37474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6489F2BE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 09:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7101616E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 08:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2C20010A;
	Mon, 16 Dec 2024 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2fiaeDgl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F9D1FFC68;
	Mon, 16 Dec 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337685; cv=none; b=RA8xPa97xjBAm4eCUMla1mSqUft0IuMlM7JKKUyV4fkaS3A0HecFrthpFgB422HrA9JZSQRoRcIrw30CPaUVGhA75BJznfRcu3z6Csc5pkp1jom8lSanH6M/lORySLTU7cSi0oTwl+E9vNTR8eRupBR9OLBtlpNFTHuFjhXtZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337685; c=relaxed/simple;
	bh=xl1rDn+F0eLGmHB47TDSI4NS49V4eSPBEvs8FW1LsMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGFfSyQKHvaWh8cQ1xl131nHTScsktGITVslGw6Oqgi9YPsJpoO64SvnahLs+MszqqzdYMiMGwmyjixxtZWn4NMx94Cx2gj1NN0GOdB31HWdscXHV+dYDqTw4rJJ+O0+GRjvFMUYfai/V9KLlkPrHo0WzhseMfWP8mwlF7VCvUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2fiaeDgl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jjWgVLfbwHLKJTX/qoIXpYAffeReOjn5bgfUy2Y1MPw=; b=2fiaeDgleW1vW39/fYA+6qZp9D
	4MBdD9TzYcyJKNKTU9BwNIwtoBfGasLLQjTyB6BSPHO4bEFcAPpIuKucTGG2bf5jDeshPv6R1j/ar
	ou6d4kZO1g+CptI82Bmb4xOQHTI4YRCAWEA5V90xMl/J2Gf1diK+yA1CqUoD52ZuLVP6oFn34QQhH
	/pVLAgKWZhfB8UqQZ9m1Cr6O6SGATz4MGKQLQ0DWzePgCMf/gE0ZdvRvSE+2gZhevVrPhktJKRDRS
	IrD/HRr2XENExbzHd7sHOtov2UlWMk3+m5Ive0MsynETzdMrmTTgMHgb1CTktDXQzeyVjTdxTF0sy
	rBopI04A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tN6SO-00000009OX1-3488;
	Mon, 16 Dec 2024 08:28:00 +0000
Date: Mon, 16 Dec 2024 00:28:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 1/3] include/linux.h: use linux/magic.h to get
 XFS_SUPER_MAGIC
Message-ID: <Z1_kkCNX9dL0hwPf@infradead.org>
References: <cover.1734253505.git.ojaswin@linux.ibm.com>
 <713c4e61358b95bbdf95daca094abc73a230e52f.1734253505.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713c4e61358b95bbdf95daca094abc73a230e52f.1734253505.git.ojaswin@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Dec 15, 2024 at 02:47:15PM +0530, Ojaswin Mujoo wrote:
> -	return (statfsbuf.f_type == 0x58465342);	/* XFSB */
> +	return (statfsbuf.f_type == XFS_SUPER_MAGIC);

Might be worth dropping the superfluous braces here while you're at it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


