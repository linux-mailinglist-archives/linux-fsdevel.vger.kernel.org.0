Return-Path: <linux-fsdevel+bounces-44408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92995A6850F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 07:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE286421FBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 06:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ECE212D8A;
	Wed, 19 Mar 2025 06:29:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E114AD29;
	Wed, 19 Mar 2025 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742365771; cv=none; b=XkbsBnQK2PBa4D2aLxQwXvjIxp09vnpD4GuZBCN6hQfhclL2RUaZ9EQEOSECJEhGUzteSbwgkuE6Q8QRdjhumVXheZ35RXSx0QBcF//K//KJmLnRPvTTJOG8kSgxsnoI8yMbthfezBb8QJNjsc9USY5H9ufK8iPQJ30jj2YqB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742365771; c=relaxed/simple;
	bh=UyuKviAFA1ID+UgkVGwBLaGeS4DFsFUR6v9ertlLBUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgZbymdaqlLMnmkquMr+HnoIHspucA9TiiaYLAXk3EpwAAix2QF6VP9v8G/lwxw9LgUciIc77c4604uerruZrZMZqIqwFTby1rrPQzWprKidC5n5ycaDEk2s48aeNZ9I2e7bWAW28CBtAR9AaUbNrmJouH/tto5NrMNH2NrWiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E20F68BFE; Wed, 19 Mar 2025 07:29:23 +0100 (CET)
Date: Wed, 19 Mar 2025 07:29:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
Message-ID: <20250319062923.GA23686@lst.de>
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-4-hch@lst.de> <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45> <CAGudoHEW=MmNLQSnvZ3MJy0KAnGuKKNGevOccd2LdiuUWcb0Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHEW=MmNLQSnvZ3MJy0KAnGuKKNGevOccd2LdiuUWcb0Yg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 04:51:27PM +0100, Mateusz Guzik wrote:
> fwiw I confirmed clang does *not* have the problem, I don't know about gcc 14.
> 
> Maybe I'll get around to testing it, but first I'm gonna need to carve
> out the custom asm into a standalone testcase.
> 
> Regardless, 13 suffering the problem is imo a good enough reason to
> whack the change.

Reverting a change because a specific compiler generates sligtly worse
code without even showing it has any real life impact feels like I'm
missing something important.


