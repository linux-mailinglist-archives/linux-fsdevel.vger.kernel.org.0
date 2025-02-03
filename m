Return-Path: <linux-fsdevel+bounces-40568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEECA25463
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EA218827EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E081FBE87;
	Mon,  3 Feb 2025 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v3BXrXwH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2626AE4;
	Mon,  3 Feb 2025 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738571205; cv=none; b=Y/p6hHeW5sVvn+aIhQN1IJ7LVmpQKQ9wTFtqshbG8ecbdCB+o8ADaynBZC4hm4U5JS+MkGpIpe25Ky1P3dyISkaDA5/0nV2DnrydcIElaFI+FiA3BgWsv4Tti9L3aLw9zto7P4yNSgcvB/6W4/PLpe5mjvX5FxiUjCFZMl8EkRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738571205; c=relaxed/simple;
	bh=+7Fyp9tudIbaV8YM8ljXu+ugadcTEhZuWM2dtKnPV/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3qkEG3Okj2A06H+72+upJvcIHNzimlyNmwFAP5mXo1UxSD2hd+65iEEFK+F/owi7j889fIIPN9yUv86/ndiduCPFXPuIQG4VsC7PzUDtDPXzS+EtPNLKwiP8yEZ5nnnMf5v/mzaOJTFT5ktBIZNohGtpA8h/CQq+EHHyQrUwig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v3BXrXwH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m7jKMxM84+orQT9dx9Z4geGmpukMKUuFd1/RLpB/DCA=; b=v3BXrXwHIxTIX+WvZv85BpcMxo
	j3T4YoLdtmZ50CrM1o23gnWdcd9a4WZZqq7nRTMcHgBbbG+3wagXFF1sUvMhdk5eBU6x7Yop5oB9y
	EQw4/dkPsF0cgCdWgblP+aNsWAAI/nbYGqHyPsSei5L5IpGJtu1Ccsy+/t6KQpfX9DZ7zxSekC2Me
	LrsQQvqX16TwPkgHfZ0hGnDqwl5MaMlIOiEu9SQ6YYssQpvuyv3bKu0sDu4gXRDIMSKMcNaIhksa2
	n93lvI1NRPxdqOS1JCiGqLB+Zll8qrDOySD06IIWb0kXT8aLAijkcGtIEeoODYvjaOlcdOAyH9JPE
	MUTYCZCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1termz-0000000Epjq-1crR;
	Mon, 03 Feb 2025 08:26:41 +0000
Date: Mon, 3 Feb 2025 00:26:41 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@infradead.org" <hch@infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6B9wVAWi0dp7f1E@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 03, 2025 at 06:46:49PM +1030, Qu Wenruo wrote:
> The root cause is the content change during direct IO, and XFS/EXT4 doesn't
> wait for folio writeback before dirtying the folio (if no AS_STABLE_WRITES
> set).
> That's a valid optimization, but that will cause contents change.
> 
> (I know there is the AS_STABLE_WRITES, but I'm not sure if qemu will pass
> that flag to virtio block devices inside the VM)

It doesn't, and even if it did you can force guests to add it.  But it
would be an interesting experiment to support passing it through at
least for virtio-blk.

> And with btrfs' checksum calculation happening before submitting the real
> bio, it means if the contents changed after the csum calculation and before
> bio finished, we will got csum mismatch.

btrfs checksums before submitting the bio.  But that doesn't change the
thing as you still have the same problem.


