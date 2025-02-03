Return-Path: <linux-fsdevel+bounces-40565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358C1A2538B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EB03A4741
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB211FAC4B;
	Mon,  3 Feb 2025 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yZWM63HM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED461F91C5;
	Mon,  3 Feb 2025 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570009; cv=none; b=bAn+A39xc+AD1lY6dBmomQyHYOsMvYmbil7DQHbph1vM6etUSkKZdSVB3KiWJgQ8U56iU9TMV9sKz1Z7tcxztfzw0fnQnrjT6HHEJiEJ8Ndoge8Qx6kgYamAqwv6Uo10Zll2ZQjKW5EjZkQbQjEY86/+PCGrHBfQQfZRRp0k5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570009; c=relaxed/simple;
	bh=9f6Ab6tq2/THWPNFqctaV85Q+DUkFgaVBJK6UYBOMrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3zbgd73iJFfquqyUfawn8aB5RFc/D9bPMKlIqNZAqqzRpWdX8osOManRrTLj2DMdp5GDka3y/O0rk3kDSY6YeqVL5m/zUt9p4q7014uI4Q+MPmwjs5rRropcT3mJ1xUfMgv9swv7cDBuoW670Cc8+39jjHqOPRRCfCyeL8LTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yZWM63HM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r1r6plQaRoAy1Nxbdg0BWrNM7QAkG9cm/NIMqGIem9Y=; b=yZWM63HMplkQd9jjGoEVajgvTU
	wk8XerzMhuuMUkMYuQFTrHN2AqJnjAdGFrJyqqHip67hvx3XcNfqMIheNLk4Y+So9JSf3CBMhoTZy
	PT4r+CCYZiuEUUR9m80LQ18o+Hccuv9YrCjM/PAaC+I6wUmVYQcoPO2GqDO8vWfMrYBfqU8PIq5j9
	8T8iu5JGjnyT+bzTbobALbTCdOVWui2CkTLCc6Dw5Fd6nLE07M3osVSuvUc9kbG+i3pdTGC7RhxxK
	H5NA2DFwsybhY4mmSg5fDtNVeBqP/ANf9VBd/x79Wy8GXn8qCIx6G9Qvi/7oBse1sUkc90Vs2MpHa
	WlLeJ+2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1terTh-0000000ElsK-1hgZ;
	Mon, 03 Feb 2025 08:06:45 +0000
Date: Mon, 3 Feb 2025 00:06:45 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6B5FdXwhXs76B5H@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 03, 2025 at 08:04:42AM +0000, Johannes Thumshirn wrote:
> Well for the WAF part, it'll save us 32 Bytes per FS sector (typically 
> 4k) in the btrfs case, that's ~0.8% of the space.

It saves you from the cascading btree updates.  With nocow this could
actually allow btrfs to write with WAF=1 for pure overwrites.  But even
with data cow it will reduce a lot of churn, especially for O_SYNC
writes.


