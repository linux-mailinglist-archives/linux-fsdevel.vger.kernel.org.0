Return-Path: <linux-fsdevel+bounces-43868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF75A5ED4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004257A330F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E0025FA29;
	Thu, 13 Mar 2025 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rVg1DQEK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747001FC7DF;
	Thu, 13 Mar 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852197; cv=none; b=n+ICXGbaHqa8t0NVgE2mU0rX5ti89kMQ1irry9vX+WJiHsfbHHFn0KsxStAqcMmgg2BQHedf93cjHCpv73wxVRBCvkAlv+DkzKz5k5Onj2Xu+QF92Xs5rRZ1tUITCZbYG9fuvxtWu4A/XnGugSRmPGYlqkfQX/CB1hYx8Pnjr5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852197; c=relaxed/simple;
	bh=qJBrQq+wMWURkJTyU+w6+UJySQVvyy/REz89R90hjN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1GSqiX30Dj8vljdNdn0KJKKeCkSClkseizwAvBnkBaIEagUcbxIRd8S22jeXSuITcAJZrn9Cq3tx4ZuNBH0agSyXroj31LvLqE6aYqlZJqBNZGFxEeWy2QKgDkO8E77cyB7N1j7KwnUZ3Cxp32YT5mjzLzF4NNy4poszftEWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rVg1DQEK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k3Nn6n3g1wXsYRYpnhW/1DaXud78T6FnU7X6TEVVMcQ=; b=rVg1DQEKcPPCyN5HEpNDMiWl7f
	Kgx6n/9Ziw0wrSnavFYGyScW7T+PGFo8yYQmevFCPPy/bEsPxIxWikdh5ShXIYpG/UDE0QwCbLPuQ
	qiMYC/GhmjSiRzDXOdwpgBNWOBybap8X9qjKC+Pr/k4cwlOo0+pdXF7VvsVSwXMRIuC9cRXPiLNSv
	kZqePLKOkxr6UZWzPnJ+TY91o78sjxj8ndsPDLzxpTEQfXBVoajElIKxEVS4zc6W428TfyUBqJJXX
	DCvYL60MH2Ag0lfvAeG+E9TdISAV/LlM0wZmk0fD4am7BQmR7XSzQjLUGEtZ0prhxzCovdM/DMola
	Ch3uauGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdKE-0000000ARCi-3Fkb;
	Thu, 13 Mar 2025 07:49:54 +0000
Date: Thu, 13 Mar 2025 00:49:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH RFC v5 10/10] iomap: Rename ATOMIC flags again
Message-ID: <Z9KOItsOJykGzI-F@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-11-john.g.garry@oracle.com>
 <Z9E0JqQfdL4nPBH-@infradead.org>
 <Z9If-X3Iach3o_l3@dread.disaster.area>
 <85074165-4e56-421d-970b-0963da8de0e2@oracle.com>
 <Z9KC7UHOutY61C5K@infradead.org>
 <3aeb1d0e-6c74-4bfe-914d-22ba4152bc7f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aeb1d0e-6c74-4bfe-914d-22ba4152bc7f@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 13, 2025 at 07:41:11AM +0000, John Garry wrote:
> So how about this (I would re-add the write through comment):

This looks roughly sane.  You'd probably want to turn the
iomap_dio_bio_opflags removal into a prep path, though.

> -     blk_opf_t opflags = REQ_SYNC | REQ_IDLE;

This good lost and should move to the bio_opf declaration now.

> +		    (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev))) {
> +			bio_opf |= REQ_FUA; //reads as well?

REQ_FUA is not defined for reads in Linux  Some of the storage standards
define it for reads, but the semantics are pretty nonsensical.


