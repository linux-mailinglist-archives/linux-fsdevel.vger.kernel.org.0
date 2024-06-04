Return-Path: <linux-fsdevel+bounces-20987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7FC8FBC71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 21:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAB3286A35
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 19:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599A314036F;
	Tue,  4 Jun 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Lldakplg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F2801
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528829; cv=none; b=pbrKQy1FUFombag0B543emF6uDTem3fZAFlAOBAE9cYUBEicLVTpH0C30DKIIxnRPtVeycvCBDr62eUMskL9NmtnHBu6oPOSceVBaf8CONjnUIjRAp3D3Ff2oe3Gqtg6hI6GtZOGto3qeIMsqovwuSrAOF1BJ6TqDiCn5Lki2zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528829; c=relaxed/simple;
	bh=eZ/JxbUx4YHJz6Rto1x504oJQS/ORsQZc2CmWBDIb+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Or5MK3kiW+3Tsdk+sy2NQsDOgvdCudOxm2q/rhYl6M7zD8g5zTFeGw2yKeZ2c0KU5AOaAlnJpE8elauc8t1bv6e7OPoPWi2obZESkVzyOzSAll/mhcioavKCh8DHiyZ2RU8xWj/gYlNJhZXBR2PZY0r9CZS3448W6dWNxHb3K2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Lldakplg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8ifQNFXiuCP8WJicsEJVSugBnZEZ1cTltL7aAzeeklc=; b=Lldakplg9sbiC9O5qqMpjwVUpR
	tySCdfyBS2c0bGSqE+wAxV7D/DntKToNygAp4KHbH0Ikf1d5AZG75UKxTzM9Lqh/RZ212Rfp5tNk7
	4sgfGI/nR3LX/GZvRTxdwrFsNw8VYBCYICW5Ej9S5MtdhiAI8FmsCIWpvqZQxev5tbeqPDIktBJWy
	z1UvxjeAqksE5VZXgE4pXornZtebQdUYa3l02lvBvuwjlb2qyCN3boeIvM7HxtlWhTT3tmTol6F4c
	dOvPRcq8VScC0pDlKbh9CMYmNL8deUSav3MvD4Lsb9SLH+vCX9WlSgKq1eHLIkaSL0Y5TO8kdlOs8
	paGReFJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sEZhn-00E1vy-30;
	Tue, 04 Jun 2024 19:20:24 +0000
Date: Tue, 4 Jun 2024 20:20:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2][RFC] amdkfd CRIU fixes
Message-ID: <20240604192023.GT1629371@ZenIV>
References: <20240604021255.GO1629371@ZenIV>
 <20240604021456.GB3053943@ZenIV>
 <1cd7980e-1cfa-4470-b712-48d9d2658435@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd7980e-1cfa-4470-b712-48d9d2658435@amd.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 04, 2024 at 02:16:00PM -0400, Felix Kuehling wrote:
> 
> On 2024-06-03 22:14, Al Viro wrote:
> > Instead of trying to use close_fd() on failure exits, just have
> > criu_get_prime_handle() store the file reference without inserting
> > it into descriptor table.
> > 
> > Then, once the callers are past the last failure exit, they can go
> > and either insert all those file references into the corresponding
> > slots of descriptor table, or drop all those file references and
> > free the unused descriptors.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Thank you for the patches and the explanation. One minor nit-pick inline.
> With that fixed, this patch is
> 
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> 
> I can apply this patch to amd-staging-drm-next, if you want. See one comment
> inline ...

Fine by me; I think this stuff would be better off in the relevant trees -
it's not as if we realistically could unexport close_fd() this cycle anyway,
more's the pity...  So nothing I've got in my queue has that as a prereq and
it would definitely have better odds of getting tested in your tree.

