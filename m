Return-Path: <linux-fsdevel+bounces-40563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B27F0A25360
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3BA1884363
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14BD1F9AAB;
	Mon,  3 Feb 2025 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ogNYcWA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B31E7C34;
	Mon,  3 Feb 2025 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569385; cv=none; b=h3JwpSL3d6f4egXzWgxR7LExlLfqM3f9QaOpxhOoD2Q7ZRGuJf+covofk/qddetq+/4Vacq8I7F4XUyUTd3LYFVMdPdTPO5bqqewi+W7skFcH3CfEE8sbNX391SUkeHFicRAmdNtQ5rdRzcFIDXydNUDo8Hit3mxTJAoA3opXGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569385; c=relaxed/simple;
	bh=iLo7DqCMi6S7QUwSo+VGI1yy1vlxvQz2FpVoVfvRVYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj9/XAiK6JD+5mzqrafyaN/i5yP8MlIlCQ51cFCTd62MWvnkR2lv7+AojPvg7Zrickuii3rTFkFf4NB/3+mrkCcreQiNIxH7wPARRHTV+YXBzWlXL35rnfu9bNdBSgwCxqzKb5tjUuKQHVE+VpTk8s7sbAnrMyo7/5ymziUWabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ogNYcWA/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CrgzaWZ/tPhAkGKAFhEvCOUqqCHUAPjXx5lytuB1HZ8=; b=ogNYcWA/us8D8GEIq9Umhbi5b4
	35llUTLepU5uBYn9hbgshdQ1K9t5n7Joi/S7HfGLuZh3qcAeHInN2es3pug44DppTmv0YP6cWQDsx
	UfqMUsmPVilqth+F7YwWfy9fRJ3QllEE9xhFLRKvgL4ps17yVaVri/kTTxnsPC/VmJLWHNrXqWwCQ
	ZO8RYKiuC5rhh/sYsEwkyFM0jvOSYp2M/0ZWhKI565ESW9YVzchEKcGMGnIKVv8D4qp0OocyOdfPZ
	+gW3+SQg7ibFQK9sFjX+j7O+CNcxytNnqu+WIkj/Crm0ICvEj6yUAG91mutc37DdqvY6pHeasz5SY
	oQdKiRSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1terJa-0000000Ekdu-3nD2;
	Mon, 03 Feb 2025 07:56:18 +0000
Date: Sun, 2 Feb 2025 23:56:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6B2oq_aAaeL9rBE@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 03, 2025 at 07:47:53AM +0000, Johannes Thumshirn wrote:
> The thing I don't like with the current RFC patchset is, it breaks 
> scrub, repair and device error statistics. It nothing that can't be 
> solved though. But as of now it just doesn't make any sense at all to 
> me. We at least need the FS to look at the BLK_STS_PROTECTION return and 
> handle accordingly in scrub, read repair and statistics.
> 
> And that's only for feature parity. I'd also like to see some 
> performance numbers and numbers of reduced WAF, if this is really worth 
> the hassle.

If we can store checksums in metadata / extended LBA that will help
WAF a lot, and also performance becaue you only need one write
instead of two dependent writes, and also just one read.

The checksums in the current PI formats (minus the new ones in NVMe)
aren't that good as Martin pointed out, but the biggest issue really
is that you need hardware that does support metadata or PI.  SATA
doesn't support it at all.  For NVMe PI support is generally a feature
that is supported by gold plated fully featured enterprise devices
but not the cheaper tiers.  I've heard some talks of customers asking
for plain non-PI metadata in certain cheaper tiers, but not much of
that has actually materialized yet.  If we ever get at least non-PI
metadata support on cheap NVMe drives the idea of storing checksums
there would become very, very useful.

FYI, I'll post my hacky XFS data checksumming code to show how relatively
simple using the out of band metadata is for file system based
checksumming.

