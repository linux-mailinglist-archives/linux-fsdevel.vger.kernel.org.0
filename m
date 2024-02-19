Return-Path: <linux-fsdevel+bounces-12036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC95E85A964
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 17:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998BB2864A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5C74439F;
	Mon, 19 Feb 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MNs0ogeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2D41C85;
	Mon, 19 Feb 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361684; cv=none; b=bB8qfuk6wBRrgi3pkfD6pQGZZQQxPP9xaznbBBFCOJLwhC5nfehsSdSCUWbDzcKh+5icRuAzEUcCKL0JDAuDxeGC4PWnbQi0ZTwWsYZRuyRKTLj1fzCJ/ng96pwTr7NlhExjXl9/19xMZlelRN1rnSjr2K5tpyvpuT2lL2dk2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361684; c=relaxed/simple;
	bh=yUPZofgi/Cbwfp1xWRriBGvlPuQtbUzrKZZm9vexYGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKOzj4+8JTyZ+6CErTOVTWwmzbuCGbJHYAAmRHSFd7G+PVD5YbKVsCahBrHWv5utbNm1zNuprpaMvYL+Ubj7fO6NK3wMAEjd0n+aMQNNHCZzsFRyhFMDjl2g40e3GNEinnQ5wrCka0kvcZ7R1R2ornThUzMn4v5tRFPwFiyuZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MNs0ogeY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UA0zSdCdoiDx17eLepIKHTwRQfmJAAj0B1OmftPBvCU=; b=MNs0ogeYPKq6Yi9e17KE7p1o6e
	OQmhpcZfUdN4S4+BiPeDrIXGHbp44yPum7VvcN2pFaaDeyEMEHqAn0FPMueYb8xKg7k70SmydLgUT
	OxbrLY14FJ+RIwEoKA6e3QiV1PiBEOkG3kuE4N5OxPfSX05zT4yLUndGSMjg+SgIMvPaa2fFMTh0v
	a9WfgD75aZNwQduy7mKkHwaQt8h5pmAasQ2/8fkMk3JKv1vfW0VmfABgS8MITOxx/kOHZp2Cr1lWd
	7VEnP+MQoCxzox2HFsm3A6livQMnK0/n0EBpP9nHcKYyE8fVfajzB+OUTvTUHugP42X06B35kAZ0+
	RFCHNPAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc6ud-0000000DIpA-3H5r;
	Mon, 19 Feb 2024 16:54:39 +0000
Date: Mon, 19 Feb 2024 16:54:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Daniil Dulov <d.dulov@aladdin.ru>, linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] afs: Increase buffer size in
 afs_update_volume_status()
Message-ID: <ZdOHz_wlks58QulB@casper.infradead.org>
References: <20240219143906.138346-1-dhowells@redhat.com>
 <20240219143906.138346-3-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219143906.138346-3-dhowells@redhat.com>

On Mon, Feb 19, 2024 at 02:39:03PM +0000, David Howells wrote:
> From: Daniil Dulov <d.dulov@aladdin.ru>
> 
> The max length of volume->vid value is 20 characters.
> So increase idbuf[] size up to 24 to avoid overflow.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [DH: Actually, it's 20 + NUL, so increase it to 24 and use snprintf()]
> 
> Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Link: https://lore.kernel.org/r/20240211150442.3416-1-d.dulov@aladdin.ru/ # v1
> Link: https://lore.kernel.org/r/20240212083347.10742-1-d.dulov@aladdin.ru/ # v2

Tag it for stable?

