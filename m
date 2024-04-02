Return-Path: <linux-fsdevel+bounces-15886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3380D895777
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 16:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647E11C22AD9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD34012C52C;
	Tue,  2 Apr 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dm0a6go9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C18662E;
	Tue,  2 Apr 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069352; cv=none; b=S6Wl7GklBYotSeibPQzSbtcdss6qW/vi9yAa58D1XKdGosVrblSSW9cKAY2+EoCEkDa7Zp5pGPYeAlJVpGTHqHlqH2EX01ytD9oHtIIkyRKRAuj1MgRt1TZQ2DFqTUtTweZugzt2DPoIpYMEejHPBnswTBSW/e+mtVTxzp4Ztqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069352; c=relaxed/simple;
	bh=JAxoc87P16PDhGWdLO0TNAOBSGeN9QTM6g13jC6CC20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvIgJDpIvB35v3ONyDRFfcn/qcvp+uws7+Z5ETR0TdO2nEqEL0k1S2g+DMgqUgoadMrRCjCUYyoZ+L3ciJcDr/zjMRxwtBQauItpq1MEfGDK/TPD6A5Q/6SR1Sa+giDtABjFyUR4RMSsmzxTGR8Vo4q75eEJKNtEOG/4BW7/Kew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dm0a6go9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jjW5IPu4pLtxcmVb8J59xaXG6ylbJ/zfz4A/SNdIOuA=; b=dm0a6go9xoxTykButNFZSyF4U0
	lVrem8uSPFvSrdtubEsPGTGEzeeWKAO1OIEP4+3BUDgJopzISw3yCxn3s+MvQAlq7m4INfuMDpxqZ
	wgDWH7Iy3iCWmrBVkO0CRmv1mwSXQVhyflm7+pUyTtfGl/Kjn38S4DSyuYgYGDIkjABQdopUI29oW
	Kqz7Z8fcocLQbrMqeIpIZgxHxoL5kIMMaDQk3f0gKv5GzXiTjMxaJaTNIUW9pnx4dvdBlf4W8HdZy
	vSc0oIZ3cH5enlXMvntHZhYdEJQCMPtnN/sOmglSS1iOhb/EeDbBNZd3yyY0CjjbhnryWKbT+45Ca
	XPw6jknA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrfRl-0000000BgU0-2rRl;
	Tue, 02 Apr 2024 14:49:09 +0000
Date: Tue, 2 Apr 2024 07:49:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: allow FUSE drivers to declare themselves free
 from outside changes
Message-ID: <Zgwa5apja6gdQNwx@infradead.org>
References: <20240402-setlease-v2-1-b098a5f9295d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-setlease-v2-1-b098a5f9295d@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 02, 2024 at 09:10:59AM -0400, Jeff Layton wrote:
> Traditionally, we've allowed people to set leases on FUSE inodes.  Some
> FUSE drivers are effectively local filesystems and should be fine with
> kernel-internal lease support. Others are backed by a network server
> that may have multiple clients, or may be backed by something non-file
> like entirely. On those, we don't want to allow leases.
> 
> Have the filesytem driver to set a fuse_conn flag to indicate whether
> the inodes are subject to outside changes, not done via kernel APIs.  If
> the flag is unset (the default), then setlease attempts will fail with
> -EINVAL, indicating that leases aren't supported on that inode.

So while this polarity is how we should be doing it, doesn't it risk
breaking all the local fuse file systems?  I.e. shouldn't the flag be
inverse to maximize backwards compatibility?


