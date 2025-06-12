Return-Path: <linux-fsdevel+bounces-51419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B66AD6917
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389271BC2EAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 07:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09CB20103A;
	Thu, 12 Jun 2025 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IzlgM9w/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3440113C8E8;
	Thu, 12 Jun 2025 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713536; cv=none; b=MAs4/uWLzdvaHC+T/6l/DaUlA+JVFfLt4yrxgYagImANaWvza8ljsh8pdnSCRCUpTKHwplhWNcGMc0Vt1/Ntz98BSjj1PlM0lYNdtK2O0Bw2TZHJ/Rzm4oHDQS/a/lPT/DCHavHp3I6WQMNMwcFCfDjVpi3hCT9iMvmkYen3RYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713536; c=relaxed/simple;
	bh=iRpzXt3XHxmP5VSnSdCwhOOxms066EN9SgJgV6H2VMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3jmSt3SBJ3hnlqulqjCZefW2x4ccb3mr24idh3Qq8EDBXL5EK1Kr6qhIxbzoxtNs3a9j0i0+XHK8RyaWIW3l3kHslC2zP1V0XRzZOQRn//ocFU3RVIf2x5r/mdRZ99Hf2uqwXGXf6emjU+e/uDEr0TO2BI2twwWQZxvZMgQAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IzlgM9w/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iRpzXt3XHxmP5VSnSdCwhOOxms066EN9SgJgV6H2VMo=; b=IzlgM9w/ZP8N0dP5P1cDAEKH1j
	LaB2SksL1T8g/Z1pEgTRvKrmMI8DnLcOrb/NjecekVW0Qep6kbQGi7eSwqt69m3nuygyfAytbcwlO
	W+GRleJJ73K8owFfayCmKqCoOfDfZBFj9k6cur8YYEOb9hfdJFeJ5RpYxc/kXOhuu1kLinBIcf6Ng
	dfyVJ7rz4bU1pLPSGvTSLONZKNfuJpeOnO1Uzk//jDWz669B6br2+0Dgu8shFBsdhfN2zsfmNFFFj
	KVgTXq/+xEYFfLdsVDSdc9t1UbDfkUYCI2/kZvzRBdzkmMyg3Tw5V3zcdkV7MZcRSdy5Jgba/XFxC
	Z+NwYllA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPcQ2-0000000CSL2-3NrN;
	Thu, 12 Jun 2025 07:32:14 +0000
Date: Thu, 12 Jun 2025 00:32:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue
 O_DIRECT reads and writes
Message-ID: <aEqCfuAvMf8TSzt4@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-6-snitzer@kernel.org>
 <36698c20-599a-4968-a06c-310204474fe8@oracle.com>
 <21a1a0e28349824cc0a2937f719ec38d27089e3b.camel@kernel.org>
 <27bc1d2d-7cc8-449c-9e4c-3a515631fa87@oracle.com>
 <1720744abfdc458bba1980e62d8fd61b06870a6e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720744abfdc458bba1980e62d8fd61b06870a6e.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 11:44:29AM -0400, Jeff Layton wrote:
> XFS, for instance, takes the i_rwsem shared around dio writes and
> exclusive around buffered, so they should exclude each other. If we did
> all the buffered writes as RWF_SYNC, would that prevent corruption?

The big issue is memory mapped I/O, which doesn't take any locks.
I guess you could declare using a nfs exported file locally as a bad
idea, but I know plenty of setups doing it.


