Return-Path: <linux-fsdevel+bounces-57485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 895B3B220AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1E51AA4BF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 08:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399402E2844;
	Tue, 12 Aug 2025 08:23:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853542E283B;
	Tue, 12 Aug 2025 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987005; cv=none; b=Zc6gn+u+ePASxBhPwoqr+wfqMNbv1e8iXfpoljzx8SLtz/dhA6iF8OQ3qSebc0Y5GNllFvAF+Q9ixUlaOtsdA62peafQNcq9pYqYBv/pPer1uukx/aZroI1ZEpUSi5I1s3AM+pPncxBvdSpAtC+k640MYzRUCmE7z0ShTGFt5q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987005; c=relaxed/simple;
	bh=2KzEGCUEwrPGHD/YB77+JU7mNMn0Ulr3v2K8yrlNPsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT+jkg66TFcEmx+jdIhmtluxoc9tKWWbBDUYgHsksq7yyMK2ie8bsTUlGojzPvb84+jooGoB3t6LSCIcTBsm39ojRCtqc7/7/EI3lSa3kAMvWaPDPHg3bW6N4hDH1s1bVxQ0Ia68OC3W/MPBceR+xl+GaxUv1SCDsGOv/qP3Ifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBF7068AA6; Tue, 12 Aug 2025 10:23:20 +0200 (CEST)
Date: Tue, 12 Aug 2025 10:23:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, brauner@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC PATCH 3/5] fs: add a write stream field to the inode
Message-ID: <20250812082320.GC22212@lst.de>
References: <20250729145135.12463-1-joshi.k@samsung.com> <CGME20250729145337epcas5p42503c4faf59756ac1f3d23423821f73b@epcas5p4.samsung.com> <20250729145135.12463-4-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729145135.12463-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 29, 2025 at 08:21:33PM +0530, Kanchan Joshi wrote:
> Prepare for supporting per-inode write streams.
> Part of the existing 32-bit hole is used for the new field.

Bloating the inode for everyone for this is probably not a good idea.
I.e. you'd probably want this in the file system specific inodes for
file systems that can just do data placement.


