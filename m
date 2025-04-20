Return-Path: <linux-fsdevel+bounces-46730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D502CA946BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 06:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013FF3B104A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 04:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ADD153836;
	Sun, 20 Apr 2025 04:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rVSruxHk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4D2B661
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Apr 2025 04:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745124551; cv=none; b=jz5EW3i6oi8+AvsXK0v4Ee0OvsD313oXp5l9qXCN+c4+3HUC0HdATiY2XFg3CJF86Bjt1pM/orJyhf8J7JJ2D/XFGEerKrkgRJ4qWmWeD9zvKn1RYzawr+uOqSoOT76M3jouuYsl2zbsSRnkroEujguuHpdaaiPR++yLV8xh97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745124551; c=relaxed/simple;
	bh=nqdO7E8nvI+AxwsFejPF1siu6nOWwyGBJ0IgJx0L+w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvqDtpSetzvTtrc5/TA2gRkVgbbBHdEMPt57JcT5bPFDyrGqsnyYKqCApocX/Uvt8VlyY2ThnS7hm98wjfmb2PBC5jgsRrj4lvgSZtPv5H52A96YB265nU+bQdPRJ+eIno4hDtaucZTiFLH1n2U8Qq8VaSdmHjVHLY9p+TNGWiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rVSruxHk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XO2KH4TBaFb4G5zVklyeR6FtP4nzJpMBFJFILLwrvis=; b=rVSruxHkwOQnZeyEXz12WiOrS4
	3HxGayrwPSr1yweNFPubskGgsPaHusEHXgl8YEShZK++6Lpy2vdvK0sJjXebWnWLR001v5I16P0jI
	kWDB/YRXyonx5dWEQv9w8ze3kLnrQ63pUcY9Z+nO4x2WyT6D3/9l0k5B70exSTxMqqqs2QE+L0e7a
	gC7alOretxKnqGh4NUhAOOAZUPTtjosse8hnFred38w/ozzd0nuQ7RaiNVZA8X0KmGdGY53GXgntR
	FSBdkLqxeQwizMzyXm7JR7ATSitjnVJBotx7zbjo64LNvUMXliP3Oi9N5yG58HWwJSx8pgaXSa0VH
	zmlNl9VA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6Mc5-0000000BSf0-4BxU;
	Sun, 20 Apr 2025 04:49:06 +0000
Date: Sun, 20 Apr 2025 05:49:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Ian Kent <raven@themaw.net>
Subject: Re: bad things when too many negative dentries in a directory
Message-ID: <20250420044905.GR2023217@ZenIV>
References: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 11, 2025 at 11:40:28AM +0200, Miklos Szeredi wrote:

> Except for shrink_dcache_parent() I don't see any uses.  And it's also
> a question whether shrinking negative dentries is useful or not.

One-word answer: umount.

