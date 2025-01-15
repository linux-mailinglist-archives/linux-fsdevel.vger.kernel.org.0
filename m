Return-Path: <linux-fsdevel+bounces-39303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDDEA126DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 16:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BEA188713E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD6114600C;
	Wed, 15 Jan 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SJa0jRTp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86474148314;
	Wed, 15 Jan 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953569; cv=none; b=GshxltjKMqNR8/ld5N/1X74yPnwY6K5OMSus+nEg/dMuRvROedEuo8r2CzlwNtYIZlK7h4qBdJkoG3dq7FiNMjDoZQsavNkHliGaYXyiqprq1nvMIniW/+wJZtejQd3vfWofuclg+TWLeOLWMRmFCS/+EVVtDzXkAiTvV7Hoq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953569; c=relaxed/simple;
	bh=fS/+8PTxfzKGzpeSiSEf0M4Lc5v4WLS/2swkcSztKEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiIe++ddAqug6ANLLQuraKvdZ85L9BjBVYz8AZqTmCIa7HeA4rCn3vkdoB357QrLdguZ3a8C4stxcmYacmsWWihdgMdDT8YEieJP57k0G5cf2rxJsxQux1Df2UXyS5Y62TnzPXrgCcmnYM9Te+1Uw22J3VOmK8dWWLCCvosIDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SJa0jRTp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sw7AwLjGYCLfUzN3yggRfXx5hCWfQG6x7l3lxngdIks=; b=SJa0jRTpc21wfGuKAM9Rf4apzN
	nYMAMkNgGxIqPXR1V380/NYHRUqmkN8+TV0AtIrzyCFJ9JePMQj8u7tGqzVc6IDszY5S84fBW1hEz
	T7s71povMTPDJ3LmOwti8FNyZ1S+o1VfVyPqckWNETD0ytiZJ3No4+NyhIyTuLKjA4mYr/tYU9iwf
	ZRvA0A6YFeS7bWKe/HXfcilGGcFY8Y9YjtKAcu2dkeLmp6AFRkYO+0WjxGQqnGr8NG9LoC6WrlPom
	hNIkTaxCmU4v/sppfQAodUg10M3Rd2snfpYIIaO1ur0g3sCjnSLFwe6kneLVoJlaT+XJy2lUD91b3
	0rsL30vw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tY4y3-0000000F6yS-2Q0o;
	Wed, 15 Jan 2025 15:06:03 +0000
Date: Wed, 15 Jan 2025 15:06:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
Message-ID: <Z4fO2_WZEO39jupG@casper.infradead.org>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>

On Tue, Jan 14, 2025 at 04:38:03PM -0500, Anna Schumaker wrote:
> I've seen a few requests for implementing the NFS v4.2 WRITE_SAME [1] operation over the last few months [2][3] to accelerate writing patterns of data on the server, so it's been in the back of my mind for a future project. I'll need to write some code somewhere so NFS & NFSD can handle this request. I could keep any implementation internal to NFS / NFSD, but I'd like to find out if local filesystems would find this sort of feature useful and if I should put it in the VFS instead.

I think we need more information.  I read over the [2] and [3] threads
and the spec.  It _seems like_ the intent in the spec is to expose the
underlying SCSI WRITE SAME command over NFS, but at least one other
response in this thread has been to design an all-singing, all-dancing
superset that can write arbitrary sized blocks to arbitrary locations
in every file on every filesystem, and I think we're going to design
ourselves into an awful implementation if we do that.

Can we confirm with the people who actually want to use this that all
they really want is to be able to do WRITE SAME as if they were on a
local disc, and then we can implement that in a matter of weeks instead
of taking a trip via Uranus.

