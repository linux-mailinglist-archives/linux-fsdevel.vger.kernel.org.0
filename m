Return-Path: <linux-fsdevel+bounces-69057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC08C6D8FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 866E12D729
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9E0333437;
	Wed, 19 Nov 2025 09:03:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE806332ED3;
	Wed, 19 Nov 2025 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543022; cv=none; b=RY2PxUQSWnPyqu//9Vkw9FoHyBBR4ribao+G4ESJntF3O5fO7TiTSAnjBKPyAWrms0m6L7wYK1oBynF7S+uzw/qHW9988fgkgS8OZ3jklPyjYZ8ylkZjiTlToq2Bue3pSmZ4G45yvdKds2+brdrrRqBYlHBPkVCQKYzKDnBJQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543022; c=relaxed/simple;
	bh=xWTsceOLcm5alMX7P+IpSRBOivCIAs3CfpJmkO28e9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tynFSJTVS6I7zbZ2FBBbV/Q6+yvZEeRRs28MMnGWgmAOrKHsBlel0YDrbfvW3omSOaw7vd8krb+GGQJ1ML83mqSp7aQJF+ThttRjdOK9VyBxwFSIfLVaFleCUFaR4kKQEA1b+AgTRqQFYAzZY5u5gktbsKB9871YFwGYbhdllS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 571276732A; Wed, 19 Nov 2025 10:03:36 +0100 (CET)
Date: Wed, 19 Nov 2025 10:03:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] fs: unexport ioctl_getflags
Message-ID: <20251119090336.GC24598@lst.de>
References: <20251118070941.2368011-1-hch@lst.de> <20251119-frist-vertragen-22e1d099b118@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-frist-vertragen-22e1d099b118@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 19, 2025 at 09:45:46AM +0100, Christian Brauner wrote:
> On Tue, Nov 18, 2025 at 08:09:41AM +0100, Christoph Hellwig wrote:
> > No modular users, nor should there be any for a dispatcher like this.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> Ideally we'd be able to catch unnecessary exports automatically.
> Which would also be nice because it would mean that we could enforce
> automatic removal of unused exports. I'm pretty sure we have a bunch of
> them without realizing it.

The problem with that is that it is so configuration dependent.

Also there are occasional cases where we add exports in one merge window
for the users to appear in the next one to reduce cross-subsystem
dependencies, so we'd nee to do this manually.

Maybe just having CONFIG_TRIM_UNUSED_KSYMS outout the unused symbols
in a log file and manually looking over that for various allmodconfigs
might be a good start.

