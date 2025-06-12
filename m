Return-Path: <linux-fsdevel+bounces-51412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20009AD6887
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1463B1BC01BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 07:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9FC1FBE83;
	Thu, 12 Jun 2025 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m5M0wbZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66DEAF6;
	Thu, 12 Jun 2025 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712537; cv=none; b=bija9iGQmeNIeNLd+muTf7NR7CeS/DmEBGGM+H2DaWaP5kg6CMocqi0cKP4aJB06v1Nd3c89cZybT3pKuZtlHdmI6ZsIuL9sUJAzlynkaf+5baqrnQMeIrAK7CiXVmUmIDPBorFIof6fzvFxM8MuyseHTwKZfN1IuXPjWavLdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712537; c=relaxed/simple;
	bh=8+9mtJ2NA8PZCC89dCo6YeV6IUAmCtNZZ2bW17drWWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBEUDokY0uRsuKdGiXubJhh1cSkVTfy3pPJOq/EY4FAchjW1dkTugGE3/qe8ZboPmppomBgFgvDWwMcYofUMGD+op5QptPgBJQhtsQO9sA9/XPOQe6LNqRceTIoyvGENkR2rWj/X/+yQX0ntfdwc5VZSe60H/f1TFV3jA+5TW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m5M0wbZj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ewRuv6VvLAYk9prVd3O6RNqayqhZuLPyPyakjWHldQU=; b=m5M0wbZjaiY1T66oREqXYKpAbt
	J/i3DWUBFP7gM9pppIB45sHUTX0D5yP70MQfiabwkGV5xfRzCjkB1QSYvS+ync/BGyKvttsGOcUiG
	uGUuSxAytdP58RsGhXmgRpG8SmSS8hYP6QpcHV9mMpn4y7YcxZtmbTXSFj0L20E5cAFhWLIzIV8Ts
	6yCimxFxtC852VcmPAfbxh9NtybQY/0FXlEK86EzKLC8thKnIdyq5JI1yad37jL04JqkIKir2woIL
	drxGIeCEnRWZXKj1tgZ22KDQ+zCVEz/DvLoWsgMw98D3HWJrFgT7gGQkxMF5OYphJnqrLKkweu8vG
	Cr3JzjeA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPc9w-0000000CPSW-03uj;
	Thu, 12 Jun 2025 07:15:36 +0000
Date: Thu, 12 Jun 2025 00:15:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4/6] fs: introduce RWF_DIRECT to allow using O_DIRECT on
 a per-IO basis
Message-ID: <aEp-lwvJ08CxftBD@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-5-snitzer@kernel.org>
 <aEkpEXIpr8aYNZ4k@infradead.org>
 <8c052438-7dcd-4215-b05c-795227d133d2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c052438-7dcd-4215-b05c-795227d133d2@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 10:17:56AM -0400, Chuck Lever wrote:
> On 6/11/25 2:58 AM, Christoph Hellwig wrote:
> > On Tue, Jun 10, 2025 at 04:57:35PM -0400, Mike Snitzer wrote:
> >> Avoids the need to open code do_iter_readv_writev() purely to request
> >> that a sync iocb make use of IOCB_DIRECT.
> >>
> >> Care was taken to preserve the long-established value for IOCB_DIRECT
> >> (1 << 17) when introducing RWF_DIRECT.
> > 
> > What is the problem with using vfs_iocb_iter_read instead of
> > vfs_iter_read and passing the iocb directly?
> 
> Christoph, are you suggesting that nfsd_iter_read() should always
> call vfs_iocb_iter_read() instead of vfs_iter_read()? That might be
> a nice clean up in general.

Yes.  I don't think it's such a big cleanup because the helper is a
bit lower level.  But IFF we are going down the route of using
direct I/O this will also allow to do asynchronous I/O instead of
blocking the server threads as well.


