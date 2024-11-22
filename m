Return-Path: <linux-fsdevel+bounces-35594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6204F9D6275
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 17:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C8D160E32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A381DED6A;
	Fri, 22 Nov 2024 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yt+MKB4k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBAD13635E
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293636; cv=none; b=eHjus2qLMJZVBHxDycifkHRoyWVkEoUtzW5hcTGwEKmc4PRIE3+8nXVVx0N9Gng3duGNyvOGZOaIYQJeaiaTpBZq1oas0QrZSHd9WGSQOiEt2vYJCvHD3Tk7QYxJVa3T4ilANQS9xm+O7r97Tb7XLxTifPecPElKGUeuDP1XWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293636; c=relaxed/simple;
	bh=LzqHRuhwIs88FJeWm5uKb66gEvl7JIUXYTG9qjMzoiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjIM3m1NCbBBMeKGA3fpEUTggucb1HIU+RUvgAtMIm9I0EEd94AHesx3oQOSlJHMDyrS2OKiEofarZK5jhEHnTN2GLoE0TVg3uXRo64Ts5P7zBWEozF2RQNfVkgMZ1FuZ5A6JhYythNoAVgaCPMqXfpO8t2WT61fIeEoUnf6wGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yt+MKB4k; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KCw1aA9StGmcky/CH+1Kc7N12DxLBe6rYdFIRUDqP+Q=; b=Yt+MKB4kL1XZ7lIyE9Ai5Tpjak
	4yrvy9nkKRDV2O4c/VLhVlKJrljAybFlSutsrqYeyxUbFq54nMQdKL//R4Uvx9iOGenwi4f6BvyDX
	Hzb0uDdgb0TM92/p7G6vwTpqQv2Mbxad3MFJsQzxx55/iwbpI5OoAv/kgg6vXyZHKTV5hxVBKONZm
	wfgTVfJ6VRMMPSfYLFKwkUH+dacxwpNzDyJV1oVVaFjgEoK9c5CXUVkWRtPk6ZMgVj4xq86V+CHln
	8KzBWFIvpMIT3koLHfRLW3sUgvTLBSivB1I6e1UeLX7o76SiklheDVTGNyLBAl/3w6dY4VULlchbE
	r0WX3urA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEWhr-000000081Ws-11kG;
	Fri, 22 Nov 2024 16:40:31 +0000
Date: Fri, 22 Nov 2024 16:40:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: require FMODE_WRITE for F_SET_RW_HINT
Message-ID: <Z0Cz_xG2Dy9g0nvj@casper.infradead.org>
References: <20241122122931.90408-1-hch@lst.de>
 <20241122122931.90408-3-hch@lst.de>
 <20241122125342.vmmjokiilvnuifuf@quack3>
 <20241122161547.GA7787@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122161547.GA7787@lst.de>

On Fri, Nov 22, 2024 at 05:15:47PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 22, 2024 at 01:53:42PM +0100, Jan Kara wrote:
> > Here I'm not so sure. Firstly, since you are an owner this doesn't add any
> > additional practical restriction. Secondly, you are not changing anything
> > on disk, just IO hints in memory... Thirdly, we generally don't require
> > writeable fd even to do file attribute changes (like with fchmod, fchown,
> > etc.).  So although the check makes some sense, it seems to be mostly
> > inconsistent with how we treat similar stuff.
> 
> As I said I'm not quite convince either, so just doing the first one
> is probably fine.

We do require FMODE_WRITE to do a dedupe, which isn't exactly the same
but is similar in concept (we're not changing the content of the file;
we're changing how it's laid out on storage).  So I think it's reasonable
to require FMODE_WRITE to set the write hints.

