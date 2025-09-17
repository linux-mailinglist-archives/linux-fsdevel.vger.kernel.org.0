Return-Path: <linux-fsdevel+bounces-61978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E69B81388
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F79466E8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87552D3233;
	Wed, 17 Sep 2025 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Oro0T/QP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57127CCEE
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131165; cv=none; b=AM5LYY7csTPWp/e0REpAV4jXz3ElWM0eTvIt8k0hwZ71XEyGWB9fnVsoMjxUZpkpP/ei3gWjJdTPNflvUujxAeU0Bb5/HOyZBdR8hikgCTRbAuXU2JY2vLPAea18anJsa5t0pcyueNtps1cvwz9iDoNpEUy8IuDH8loQfisHRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131165; c=relaxed/simple;
	bh=MR6dRqJ7PxDkikTIp9AgOMz22+I/THybgF6t/HiO3Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEFky+oSwGCZ6CGkhisRrJKVaA4uXoUm8YgF/fHLb7IWW4B143mB7cN0iQbaA7bWoZyO6Tbp/SKbmqjucnQRM47Wb1TLy3nIHsbq+W2JzJL+DdSGNqnqpPS4fG89I0qx4LIoUuZcW32y9ZKzzlg7on1xC+4lQuCux3ZN1ZobsHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Oro0T/QP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qWEafQRZOQcfKHZnKEAtDQpixTQz3J6i8aCeqW4R458=; b=Oro0T/QP6Hw02v5QMWU1XSYhjR
	ZZYE8cnRbquLtMSFS1MhnPSRoJTj50XI+hCU3xCp/G+M0OieTgN908AgLOefzXpfQbLCEnVsfNCd1
	Comz4qojLmkmFFufDfjjKc3qqhcbiqlQ3MT027yZH1t49BN+IVTbf7CbxcRiMhzZL7FySxZBt8nCP
	NtQTK6wsZvuaiKRVt2Ulb2lEb8K15SiqhbaI/6LC4PelNRRKxVlea78LhaxDCrdFTVwIdjYKqKXIL
	tbVZ73QMG+irPxi09OJJTxqCFbsdlvVqR4ZbhcnP4P3CrYOZfJrSN11pgTABicXpcQxf4c2aBxfmh
	ttsA6tgg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uywEA-000000053VM-3j7t;
	Wed, 17 Sep 2025 17:45:58 +0000
Date: Wed, 17 Sep 2025 18:45:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	NeilBrown <neil@brown.name>
Subject: Re: [PATCH] fuse: prevent exchange/revalidate races
Message-ID: <20250917174558.GA1196114@ZenIV>
References: <20250917153031.371581-1-mszeredi@redhat.com>
 <20250917153655.GU39973@ZenIV>
 <CAJfpegsZT4X5sZUyNd9An-LxQQAV=T1AEPUYQJUUX4bZzUwJUg@mail.gmail.com>
 <20250917164148.GV39973@ZenIV>
 <CAJfpegvYJD8UUuukNY7oj7-PSu48y6hXn+iV9iHzrO4fdgWXQw@mail.gmail.com>
 <20250917174350.GW39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917174350.GW39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 06:43:50PM +0100, Al Viro wrote:
> On Wed, Sep 17, 2025 at 07:27:25PM +0200, Miklos Szeredi wrote:
> > On Wed, 17 Sept 2025 at 18:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Wed, Sep 17, 2025 at 05:42:18PM +0200, Miklos Szeredi wrote:
> > > > > ... and if the call of ->d_revalidate() had been with parent locked, you've
> > > > > just got a deadlock in that case.
> > > >
> > > > Why?
> > >
> > > Because the locking order on directories is "ancestors first"; you are trying
> > > to grab an inode that is also a directory and might be anywhere in the tree
> > > by that point - that's precisely what you are trying to check, isn't it?
> > 
> > But if parent is locked, it must not have been renamed, hence
> > parent-child relationship holds.
> 
> Not if parent is held shared.

Note that lookup will reparent a subdirectory just fine - exclusive lock on
that directory's parent would make it fail, but shared one is not a problem.

