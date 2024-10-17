Return-Path: <linux-fsdevel+bounces-32204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB259A25B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 16:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B61C1C24972
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737411DE8BD;
	Thu, 17 Oct 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wKPSXeYZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D251DED50;
	Thu, 17 Oct 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177003; cv=none; b=lMTbzqqsAftGv43SYya5iH1/+4mg34apCizcbasl6yRn36mJfKHoA4fUDi4XUVUw/KFl9JM3V0LqOMNxyGX7aJMe7MMsDN5vbqm5yaGO/tbh03C8gV1bAb0PIS19W8EkptyCPaMq213JMtUaQXIpLNIlrDBcB1hKKeA82yGrG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177003; c=relaxed/simple;
	bh=pkDvb2i0d20PFLp3Rjf0qgjkmuMhOea+f/7Uy9aB2gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1qCiQzpDkQeUw1+IcuJsxLwsCFkKbKJqdLZAwxg9r2nC8G3ZgiGNVfGhnStLEdhUq6mHITWX85vTCLykzFyXz4hOj53+gSp5bcsllVl7pQCj4Efo3a99ewhSw5igQumjJ9lWhNv4hPFVUg2qxthEfBMxudTzMNYq/M/dO8A9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wKPSXeYZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pkDvb2i0d20PFLp3Rjf0qgjkmuMhOea+f/7Uy9aB2gQ=; b=wKPSXeYZdIAVlnORnuwA8PzuGq
	IVvm6rsUMkgWJt7Z99kq7s+mH96o9VE/7LyfEQhfS68EPZ/stjaCVVW5fj1UKFHSTL86SqPigsilx
	UoEE7LAwl+M7rEmAL5vG2PWg1SkV2hvu9YMNRZqHjWtBJPjnA7fQ0Pxp1t6VTNrC2vsxzThp9A8jV
	8P/W/6GgpYs0FgXkrEByMdQhTUow2Ym3WoK2394f3T/Aza4NWzKqBIVsVPyQQFPNvPWQHZzn6fDsm
	OYrBHSmjOAevhbeQcd3vMrVSUaGVoxP4/+8OJhaSmaflznKNNOA/CNANHLiOjt8Da5bJ/vUd1sWlM
	X5jPQStA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Rvc-0000000FBr4-1Zj0;
	Thu, 17 Oct 2024 14:56:40 +0000
Date: Thu, 17 Oct 2024 07:56:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
	audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <ZxElqOWfbRR2FRg-@infradead.org>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241016-mitdenken-bankdaten-afb403982468@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-mitdenken-bankdaten-afb403982468@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 16, 2024 at 04:23:02PM +0200, Christian Brauner wrote:
> And I don't buy that is suddenly rush hour for this. Seemingly no one
> noticed this in the past idk how many years.

Asuming this showed up with the initial import of kernel/audit.c that
would be more than 20 years.


