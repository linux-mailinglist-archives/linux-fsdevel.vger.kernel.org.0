Return-Path: <linux-fsdevel+bounces-26598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A5695A961
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B08B0B21EA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FA1BA4B;
	Thu, 22 Aug 2024 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BL9kQJFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C379C2;
	Thu, 22 Aug 2024 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289230; cv=none; b=ZZFBVLxD94bwI5SxKxDPwI+u9Sxl46bwRPxIfsu98E3JRcXUd9FRTGQsH+J2VhAtwP+29MH5lT6+lvoOYw9EgMC8fTsM2QO2iZhv2xi+bcvRgFwULoEGTHUF84+noGlxwyXtM8HMCrhAhVTnAiUEjU/iGo9ShACsx9gi0W+5H/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289230; c=relaxed/simple;
	bh=vZxKPDpq5DvbVbWSJfOPq6M50fu8vloHEW6y3g/twfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuCw1sqL6OL+6MVyidrz3ld9IOI5mKjrZAqv2qen5mDEYaOEx4a363C+BsHmFBRgjJpG9VnSJLBCfdiQO1XNFvtbLnAmMoFaHkbiYUvtveR7XH7L/cupnbsMIUTjUDNQuS3omqN4SH1ecjBCLCSzp1Y5aMNMOtrvnq+7rgTQ0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BL9kQJFc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HlGw7ZwNFGz+UQNa18MYFzhGEuRQCC/73wjOyCj5Tgw=; b=BL9kQJFcSDNFH3M+pr+GlYB2rV
	yJbrCQ8QBQW8DY1IEiblCoNX9qrPDV+M0EFR6c9HzCUwux+WISbsHmp3FEKn1Lw9G21dTtH/R1YMQ
	c5/Ve20NiNKEA1Z8YkvpqOqsjWpCxsMRIh+75E3/HpoLCKpC/i8Iymd2GcEZGHypNyfz+5Lkw2Ych
	JpAeTWg8PhsTO/61dDYckc+Q64YCLGvNPNo0LHtkGsZXH/GeHYakcJvvea/dNCLtvk2bu2zva0/FB
	fA9GJwU+O3GtX/3znwe01h2lcMXUmTGyjJNs3FaE8I+xijHyYJj7IY7h0yx2TinkOM+lI23fM6l8g
	GlcYmoJw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgwOX-00000003wf2-3BSs;
	Thu, 22 Aug 2024 01:13:45 +0000
Date: Thu, 22 Aug 2024 02:13:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, brauner@kernel.org,
	tytso@mit.edu, linux-ext4@vger.kernel.org, jack@suse.cz,
	adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com,
	shreeya.patel@collabora.com
Subject: Re: [PATCH 1/2] fs/dcache: introduce d_alloc_parallel_check_existing
Message-ID: <20240822011345.GS504335@ZenIV>
References: <20240705062621.630604-1-eugen.hristev@collabora.com>
 <20240705062621.630604-2-eugen.hristev@collabora.com>
 <87zfp7rltx.fsf@mailhost.krisman.be>
 <2df894de-8fa9-40c2-ba2c-f9ae65520656@collabora.com>
 <87jzg9wjeo.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzg9wjeo.fsf@mailhost.krisman.be>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 21, 2024 at 07:22:39PM -0400, Gabriel Krisman Bertazi wrote:

> Would it be acceptable to just change the dentry->d_name here in a new
> flavor of d_add_ci used only by these filesystems? We are inside the
> creation path, so the dentry has never been hashed.  Concurrent lookups
> will be stuck in d_wait_lookup() until we are done and will never become
> invalid after the change because the lookup was already done
> case-insensitively, so they all match the same dentry, per-definition,
> and we know there is no other matching dentries in the directory.  We'd
> only need to be careful not to expose partial names to concurrent
> parallel lookups.

*Ow*

->d_name stability rules are already convoluted as hell; that would make
them even more painful.

What locking are you going to use there?

