Return-Path: <linux-fsdevel+bounces-40695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE651A26B30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 06:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A053E1883216
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 05:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794FC19E83E;
	Tue,  4 Feb 2025 05:00:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6832A1CF;
	Tue,  4 Feb 2025 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738645234; cv=none; b=UnwVq027Eut9DNHWdhf4SVU4k2RWG+E686abznihvx/HCOBEoQA6+KK8cU3b8WkgHaK2moOJRyqb+IC7h31DMI1CASJ3/MJ4S2hU1BYL+t77nXNYqcndmWFUtkhMEX6MMcB5s4AhWGVdmG0Qebges9rvoabDYwbVTgsUtvNg3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738645234; c=relaxed/simple;
	bh=g+L+5q7NWigNCwUlM43VpZ+ukkZrwSNgi9fq4/8jA00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNm0mgFxYhSiqGKoLeGL19ewIA6AZzg/OHDbKYXbJxLM8e/MYbyU3s1youjNX/e+joBTKQ2/UZLrc2Ilq4dbw8TF2thqwVi3ftwFhwV4DBxqYWyIlFyYIW6Tp2vvlxoOhkTmPopYp7ThvDMbCj800X7hezq0sP61TEibnVXGJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3901968AFE; Tue,  4 Feb 2025 06:00:25 +0100 (CET)
Date: Tue, 4 Feb 2025 06:00:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 7/7] xfs: implement block-metadata based data checksums
Message-ID: <20250204050025.GE28103@lst.de>
References: <20250203094322.1809766-1-hch@lst.de> <20250203094322.1809766-8-hch@lst.de> <20250203222031.GB134507@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203222031.GB134507@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 03, 2025 at 02:20:31PM -0800, Darrick J. Wong wrote:
> On Mon, Feb 03, 2025 at 10:43:11AM +0100, Christoph Hellwig wrote:
> > This is a quick hack to demonstrate how data checksumming can be
> > implemented when it can be stored in the out of line metadata for each
> > logical block.  It builds on top of the previous PI infrastructure
> > and instead of generating/verifying protection information it simply
> > generates and verifies a crc32c checksum and stores it in the non-PI
> 
> PI can do crc32c now?  I thought it could only do that old crc16 from
> like 15 years ago and crc64?

NVMe has a protection information format with a crc32c, but it's not
supported by Linux yet.

> If we try to throw crc32c at a device,
> won't it then reject the "incorrect" checksums?  Or is there some other
> magic in here where it works and I'm just too out of date to know?

This patch implements XFS-level data checksums on devices that implement
non-PI metadata, that is the device allows to store extra data with the
LBA, but doesn't actually interpret and verify it іn any way.

> The crc32c generation and validation looks decent though we're
> definitely going to want an inode flag so that we're not stuck with
> stable page writes.

Yeah, support the NOCOW flag, have a sb flag to enable the checksums,
maybe even a field about what checksum to use, yodda, yodda.


