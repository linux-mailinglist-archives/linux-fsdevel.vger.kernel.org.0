Return-Path: <linux-fsdevel+bounces-54928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1ADB055C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 11:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68663A5257
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 09:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0CE2D4B67;
	Tue, 15 Jul 2025 09:04:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E39148830;
	Tue, 15 Jul 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570244; cv=none; b=ZfsVebTOYZ+2B6Kf9Rli6FnjyZisi2n03CqaVOsajh/Q12Zd15tL80e6TSOHWtnvecFeqBbvWmRxY5niXEUTkMh5FsYt4VgjLiDMPKLjqbL9ss+9KVF0+AGQKEdTislI59GwNuy5ngK/u2iqLAH/rUwWGw/JqVMt/GvhVHCbuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570244; c=relaxed/simple;
	bh=HybFUc4/dPKNTBKqJlDZckyq4d+dmPdiBzBgjr7/KIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/p4K3HujqPC8HIRzl6qdlQRUNV9CA/N58/KBXaU0IBVblDiGBmuuQ9IRDLDOQuH7UWpP6GSi/s//pM5V8Grgmed9UjzWVGGI5sF5Ssp0zZvp0QHIr8TLxV2z5Dv51mJiCayb8u2SFcGfD1t2R07JWZFz5LxcLjh/WdPl028TMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F22368AFE; Tue, 15 Jul 2025 11:03:58 +0200 (CEST)
Date: Tue, 15 Jul 2025 11:03:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715090357.GA21818@lst.de>
References: <20250714131713.GA8742@lst.de> <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com> <aHULEGt3d0niAz2e@infradead.org> <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com> <20250715060247.GC18349@lst.de> <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 15, 2025 at 09:42:33AM +0100, John Garry wrote:
>> I'm not sure a XFLAG is all that useful.  It's not really a per-file
>> persistent thing.  It's more of a mount option, or better persistent
>> mount-option attr like we did for autofsck.
>
> For all these options, the admin must know that the atomic behaviour of 
> their disk is as advertised - I am not sure how realistic it is.

Well, who else would know it, or rather who else can do the risk
calculation?

I'm not worried about Oracle cloud running data bases on drives written
to their purchase spec and validated by them.

I'm worried about $RANDOMUSER running $APPLICATION here that thing
atomic write APIs are nice (they finally are) and while that works
fine with the software implemenetation and even reasonably high end
consumer devices, they now get the $CHEAPO SSD off Alibab and while
things work fine their entire browinshistory / ledger / movie data
base or whatever is toast and the file system gets blamed.


