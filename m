Return-Path: <linux-fsdevel+bounces-72629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1D7CFE808
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 16:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AC693075D21
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E8334EEF4;
	Wed,  7 Jan 2026 14:42:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9B34EEE4;
	Wed,  7 Jan 2026 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796969; cv=none; b=T7N7V3xhMXAmbh7/b59Tr2bozwYPEpzaUp1F8AInIDZEuzVT/7I0RaHgwx8d+/0Q5ozjtCiOrgZXi6Rxoh99PV642bFcY5AIzMbO6Rbb0/cmPm3rbSCDYOKy8wJgPfR/v5sLIT3QWbx6684Y5KtSajzWysnmk5Lv+a50bCHpsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796969; c=relaxed/simple;
	bh=wRs4USqx7rN8UYOzDPvD2kIjKDSMUicsyF1pc7rfvSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWTA8xNOBHwXUUiH3y7DJdlAFp1sdEOi7WNons8WOQpXkBaD/kPxD6xTiYyLbJ20e4OryyUeIJlo90Y6MJDiPZ1syfKflS5l1s3YAWLCRTfRmgbo4xLW6OVipQlk87lzoEgDK9SYxuz6wThMz7xavYa5CDG6Hlak7/su5C5Bh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 45DFD227AAA; Wed,  7 Jan 2026 15:42:44 +0100 (CET)
Date: Wed, 7 Jan 2026 15:42:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] NFSD: Add aggressive write throttling control
Message-ID: <20260107144243.GA15228@lst.de>
References: <20251219141105.1247093-1-cel@kernel.org> <20251219141105.1247093-2-cel@kernel.org> <20260107075501.GA19005@lst.de> <cb269767-688d-46f1-8d82-1fd6dc32e94d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb269767-688d-46f1-8d82-1fd6dc32e94d@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 07, 2026 at 09:36:39AM -0500, Chuck Lever wrote:
> > What makes NFSD so special here vs say a userspace process with a bunch
> > of threads?  Also what is the actual problem we're trying to solve?
> 
> The problem, as I see it, is that the system is not providing enough
> backpressure to slow down noisy clients, allowing them to overwhelm
> the server's memory with UNSTABLE WRITE traffic.
> 
> This is the same issue, IMO, that Mike's direct I/O is attempting to
> address. Our implementation of UNSTABLE WRITE is a denial-of-service
> vector.

But how is this different from Samba or a userspace NFS server?


