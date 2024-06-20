Return-Path: <linux-fsdevel+bounces-22036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8729113B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 22:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623651C221A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1377E0E8;
	Thu, 20 Jun 2024 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ALJdfkXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CA73D3B8;
	Thu, 20 Jun 2024 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916618; cv=none; b=OcLXR+gDKLZ1vwHCwveoZNxneJAsHnlHaZkoo2r8ERzTFcVeJH2Dmd7HjeVzS36YnAsMPk1I3kJpJsciMCprfYJRbw6xh5kc7mO7nK1D/lmeQ5tUgOXGVdbALe1bjivgImBeqMx8H4XCAT/K9tIKAlwknkROlGoAnT5S5SgUPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916618; c=relaxed/simple;
	bh=AvGVFTfgQ8CQv1Ova9G8llKmivCTuZfd3jl734L9bIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TggXoK4Q1dS4G3j/kMm6dHRd116TfXOEA7c3wU2lS8eT7kg3f2NhKJCr1RejTTc1SCpkExX2thyxAYWu/EK/lLsVIbDRI7dnXIONTA4ZHvgwTRbaOOyYGX6454Ge4ysiG3CSI5SENOQycLhjztzZqjiEOGysKknDz5R9nRNeyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ALJdfkXV; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8A5F214C2DD;
	Thu, 20 Jun 2024 22:50:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1718916615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLVCmMswFYW/yptkreRA4q0clrbQSOEC9H3udI4LuGU=;
	b=ALJdfkXV4jYbTnxVURz9T/eVwi75e+Jpzd/NnEdNtowVW0EPginJ+UR6WjORHnH38deSjd
	uJwnIU9Cj7KamD9RuKu8/mGuiDvl4zepXXeiSbVTriN0efe9Ugz46seuDEdUL9p7r7KRLr
	P7bpbNTjSYBxjIuPaVX1MWKzMKecMwktnyLawuNoID0Mbc/ddEMnIWkpd3XG+6pyYH418a
	3W/N9t5Qfs/oTZaI9U3i3KvnPFWdkdWReTPrI5Iv2PcSTYiBLmAJf7px1y70cBjtciXJPK
	i5woghwPVaymjTFrWRyF7a/0NAHSSLe6Bk1rVFeZVi+wKnfbRR0RGgGH6UokHw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 39921304;
	Thu, 20 Jun 2024 20:50:04 +0000 (UTC)
Date: Fri, 21 Jun 2024 05:49:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 06/17] 9p: Enable multipage folios
Message-ID: <ZnSV7TmLpmucb8el@codewreck.org>
References: <20240620173137.610345-1-dhowells@redhat.com>
 <20240620173137.610345-7-dhowells@redhat.com>
 <ZnSSaeLo8dY7cu3W@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnSSaeLo8dY7cu3W@codewreck.org>

Dominique Martinet wrote on Fri, Jun 21, 2024 at 05:34:49AM +0900:
> David Howells wrote on Thu, Jun 20, 2024 at 06:31:24PM +0100:
> > Enable support for multipage folios on the 9P filesystem.  This is all
> > handled through netfslib and is already enabled on AFS and CIFS also.
> 
> Since this is fairly unrelated to the other patches let's take this
> through the 9p tree as well - I'll run some quick tests to verify writes
> go from 4k to something larger

(huh, my memory is rotten, we were already aggregating writes at some
point without this. Oh, well, at least it doesn't seem to blow up)

> and it doesn't blow up immediately and push it out for 6.11

Queued for -next.

-- 
Dominique Martinet | Asmadeus

