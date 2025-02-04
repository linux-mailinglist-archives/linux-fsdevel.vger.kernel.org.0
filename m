Return-Path: <linux-fsdevel+bounces-40700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BA5A26B83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 06:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0973A74BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 05:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCF11FF1CE;
	Tue,  4 Feb 2025 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xw/ixOPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E83D158558;
	Tue,  4 Feb 2025 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738648086; cv=none; b=iC/2g2Mxw/pbidTsVvHTYtV4dtQhvY5eslCV2zoSEPW98rfVrqdRpfaUuJ0Ua8YMPMiHIokQJqotmF4NtFAspZqERdDhxtauCjRVIk3D9UNYeYWMER8w5eX2jrj7TlJEOcflIAdtJTj6pqzUv+XuLZFfLgZ84RQTYxuRpFS9Bvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738648086; c=relaxed/simple;
	bh=1qcJuEWlYhdOVNQk8D1T49twEcTNrzd2Jl5XU96g98A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgpE1Nv9tlGIJ604NTH+Qu/ZtqXqgacCZAMyVi24tV8ODJU/K/f4idwkzGj+HHSDPA73Jad4IxmxjYJ0dC/nHRvSX7nL3NYugf6GcfuGH1JBoqebJYL7ZI5obxS4+zVbQ4h9GAyzHPeOV6N86JIfXQ/Q8+0UgEyCxns+MM7hi/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xw/ixOPl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1qcJuEWlYhdOVNQk8D1T49twEcTNrzd2Jl5XU96g98A=; b=Xw/ixOPlobdnt3U6vUyjEZkQJt
	uB6vzgMYbhM93Del2iz9itiE0LMLj+uL8WnERPmkxihAROo5jXEhPPWrlSU+BucZgUn+2MXm41Npo
	e19QKU7xCx8t8OHvLKRtRtIwdryNUtCMSM5VQKsaiQHra3Ou7u7tBcXxkOZo+CKctkQvuoFChzTNt
	mkEuEE5FEM4ZqSCljuNIxb0YWfrOj9PKNF74ulFB5y/ouJt4uA9Z03B6T2pSiU8MfaRZaxh6qt34f
	pw11Kge9pSYv/p+HLU4zw9DUZVPlJ4Xn3qSHSsN6tspCRQqsN1PTa/fYEIFko4SGRd6QDQbq/6a9A
	1uEg5syA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBn0-0000000HIqd-3H2A;
	Tue, 04 Feb 2025 05:48:02 +0000
Date: Mon, 3 Feb 2025 21:48:02 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@infradead.org" <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6GqEt9IrFHxGz_Y@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
 <df9c2b85-612d-4ca3-ad3f-5c2e2467b83f@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9c2b85-612d-4ca3-ad3f-5c2e2467b83f@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 04, 2025 at 09:47:20AM +1030, Qu Wenruo wrote:
> Btrfs already has the way to disable its data checksum. It's the end users'
> choice to determine if they want to trust the hardware.

Yes.

> The only thing that btrfs may want to interact with this hardware csum is
> metadata.
> Doing the double checksum may waste extra writes, thus disabling either the
> metadata csum or the hardware one looks more reasonable.

Note that the most common (and often only supported) PI checksum
algorithm is significantly less strong than the default btrfs checksum
algorithm.


