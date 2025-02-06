Return-Path: <linux-fsdevel+bounces-41022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDD2A2A0B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA7D3A51E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E924C22578E;
	Thu,  6 Feb 2025 06:05:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7DD2248B3;
	Thu,  6 Feb 2025 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821921; cv=none; b=nwi7jccWBdBXBzam+w/1enlMv183rvSId7W3OVpGRold69qE/8X7VFAfetN2QKlqZskhQoBC2X8dWnnR2DT73Chiu2lfLFdwBSIGreOWsoyq6OHZzaR8/VLylCe5Ahce6PlxlejCXsLVDmaH5HYaUsbtsPCtLEzPtGO6bwxFb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821921; c=relaxed/simple;
	bh=K40fgf6vT+MkNS3MY4xP/5/BnBMVuZT8K7WQGFRezXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOI9+oNsk8d1DQK5hRHQxqE+YJxf1ee8TN3jHbN2UF4geiskSw5qmIxQsxozE/pLGzYYn/ya2YQWRWR1YSYTbmscsXsmMlRAthr9jwvWeSmKgsoet/LfiLBU31HFX4+gEIax0ciy2geJ7Mi/795KZK6hcusyKJ84TCyxGQfx+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 766F568C4E; Thu,  6 Feb 2025 07:05:11 +0100 (CET)
Date: Thu, 6 Feb 2025 07:05:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 7/7] xfs: implement block-metadata based data checksums
Message-ID: <20250206060511.GA2660@lst.de>
References: <20250203094322.1809766-1-hch@lst.de> <20250203094322.1809766-8-hch@lst.de> <20250203222031.GB134507@frogsfrogsfrogs> <20250204050025.GE28103@lst.de> <20250204183651.GA21791@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204183651.GA21791@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 04, 2025 at 10:36:51AM -0800, Darrick J. Wong wrote:
> > > The crc32c generation and validation looks decent though we're
> > > definitely going to want an inode flag so that we're not stuck with
> > > stable page writes.
> > 
> > Yeah, support the NOCOW flag, have a sb flag to enable the checksums,
> > maybe even a field about what checksum to use, yodda, yodda.
> 
> Why do we need nocow?  Won't the block contents and the PI data get
> written in an untorn fashion?

I mean to say NODATASUM, not NOCOW.  Sorry for the confusion that
this caused.


