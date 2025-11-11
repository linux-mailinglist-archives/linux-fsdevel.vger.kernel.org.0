Return-Path: <linux-fsdevel+bounces-67897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CFBC4D1AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AD6427FBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFB134B427;
	Tue, 11 Nov 2025 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o6Qzcf2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33734C13D;
	Tue, 11 Nov 2025 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856678; cv=none; b=InebGtYP4p3uK/6cAZDoMmq7jY1SIvfb04urjGaTkwOQFteHxEaaCo8kFbbzsFePi9Dg0l5bQXbUUwTgZ+sHlnLJzfh5MGQHnH8WZ6doRpGUF+XhzD8YQLXUv8WJN3WhxHZGwXNbg/iBT7EVh7b8m/+Qv4I1/EmTYQw4b18Y9Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856678; c=relaxed/simple;
	bh=Pk1+Syz8svjSqWJy4uNJdCuzrao8MNj7/eKcIogq9j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2mXr7ATqNo/7oX3uSLyFt/yhG5mkHIsjkZqJsF40nLyN0cVGCT8h7U87JGyBIz3GB0hnl+xjBRtUdlBYWJkzLC3RssJsUV+ZlPhqY4iruMN2ST85BgPnv9PcF8MsLz2Muo/4a8ePmTBUxQOpeDmXIZOEtZS3D1l521qtTDj7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o6Qzcf2I; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DtPIgSD96T8AdJRouy1+QiaPLo0/0jzawVLRdzPXzUg=; b=o6Qzcf2IXY184EFgFyNAXYdJ2j
	zPlfASULoRIR3wIAa07ItqSlxPujvDEyfYxt4bnH2O0ZoUU50tm/87l2F/Rss3P1kdlJM8FuCb+Hr
	T3I1qmat4ypKxfIZWljmxFZ+JYFILG/hzrSnelNAox9D0IQqF/4gC1Fw1rtD0hh0hJjnfs1NmHDUL
	1R7kveF8XZwN2HikC6u7xo/jfdV3wpCStRjSy4yiZ0zp0kLdG0/zidPUe2dp5eBmfOQg2Rc6LKB4t
	//rpXJD2TP7roP+OhzGke5Bnl7PBAZgy3mauUIt2t3FfLqkAld3dgc30Wp65Dy7dR3MPmygpZDYVu
	ErSGIlmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIlYB-0000000G7mc-0SbN;
	Tue, 11 Nov 2025 10:24:35 +0000
Date: Tue, 11 Nov 2025 10:24:35 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Ian Kent <raven@themaw.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
Message-ID: <20251111102435.GW2441659@ZenIV>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net>
 <20251111-zunahm-endeffekt-c8fb3f90a365@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-zunahm-endeffekt-c8fb3f90a365@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 11, 2025 at 11:19:59AM +0100, Christian Brauner wrote:

> > +	sbi->owner = current->nsproxy->mnt_ns;
> 
> ns_ref_get()
> Can be called directly on the mount namespace.

... and would leak all mounts in the mount tree, unless I'm missing
something subtle.

