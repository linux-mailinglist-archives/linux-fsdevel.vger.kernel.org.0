Return-Path: <linux-fsdevel+bounces-40570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D67CA2546A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B09161E90
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD28E1FBCAD;
	Mon,  3 Feb 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XrHj1Q1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C12BD10;
	Mon,  3 Feb 2025 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738571418; cv=none; b=cOmIB98TVEgS6xEGj+xA4iDxaCrU1FT0DTrI6qN7U7masucf2+3lEkMWhsfZaErv//+3qE0XRtDeXdE5fhE3PDCto29PFMSt/2GogfC9U2baEAiONH2Y/cMpXtm39Oknj5mRo4WQuqROt+ejqIwRpkRz/9o+xRIBS7tPJag43L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738571418; c=relaxed/simple;
	bh=3cO4qyclNc033Cj6ZmMnLChbflbiN24MN5QRcDeuegQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqrzQA6DCzdqhjNtvtXlyyiZaOD60lha76RZESXtUCndewQKOkIEjN6vudPzeFwMlSM7EIQwCqOfXjyS2ZJvDq24dASzzJyN6IvCE47IdoZmARh2yGccxACPXFrtuG2WcmWWngJfaoiqpv8e8iCxBBoq8YbnsMq+3Ta4HqX+xbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XrHj1Q1e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GEeRARndOURU601MNaUwqkzgOLPL0RKLmzvNkf3CvH8=; b=XrHj1Q1eHOUdOfUOVDAHT0Q+1d
	QBl8BI1PJ9841YOZjOxYpvq5BaS6vsN2/94VlcjmiVRLDfWKYArcYxscCdLix7kecyROoHpgRdIEJ
	2EpKbYV0YqZP4gk5HwXpWVMSjlRayadY0WswozBUqAtmDHfr2ySZN3OimPJxuAGE9EkGE+iUpTmUv
	gbAIaIHaOpRe/6/LO4ZHVeB19myKg673K2JCzuu9ZMeaSSjnqCMA9rYUHOiGO1ka2yaI7Kl4KpCYY
	Dj+2ShximPp3CRnGgpECevEnrObzSjcB+Oj6zJHZpqX0aQaD/DhB6v8V9n9GJyZc18hb9vOlxcGgg
	Tx5nfBww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1terqQ-0000000EqEQ-1Jdo;
	Mon, 03 Feb 2025 08:30:14 +0000
Date: Mon, 3 Feb 2025 00:30:14 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@infradead.org" <hch@infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6B-luT-CzxyDGft@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <Z6B9uSTQK8s-i9TM@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6B9uSTQK8s-i9TM@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 03, 2025 at 08:26:33AM +0000, Matthew Wilcox wrote:
> so this is a block layer issue if it's not set.

And even if the flag is set direct I/O ignores it.  So while passing
through such a flag through virtio might be useful we need to eventually
sort out the fact that direct I/O doesn't respect it.

Locking up any thread touching memory under direct I/O might be quite
heavy handed, so this means bounce buffering on page fault.  We had
plenty of discussion of this before, but I don't think anyone actually
looked into implementing it.


