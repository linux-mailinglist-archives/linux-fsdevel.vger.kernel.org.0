Return-Path: <linux-fsdevel+bounces-78376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJsfA2AEn2mZYgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 15:17:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEC219894B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 15:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D24713057E98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F163B961D;
	Wed, 25 Feb 2026 14:16:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5C2288C3F;
	Wed, 25 Feb 2026 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029004; cv=none; b=or5tpjCrjed+7l1BuhBEkNOHiTO7woPhhlJ89OfZfWEnyR8+32f9KiBps/7KAQgI8CbYVrkRqjo5d3SHxE0FGNp22gpxZ8DQ2u9wIgXHmVLDxQ4sL9FBRjb5/eT3z+jo0M2fRoUWVsT2hhHHMQJbIrb0X9tT5U6Zj+Yeq0fE8Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029004; c=relaxed/simple;
	bh=67Y/eQf9Mv1ECigVJ7DGKEdMWEnkGupQ3A/1Sqz4/UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN7SWlYZuPmpsEMxoWbjmSFWSLF3CYvnWqemnwnUGOJKaQHnbX9IF/e1GXkPmsKrxq5T/aJ73GcB4TV2FKICJCI9QGMmLLcrPgunfWoLquT4SpC8MKE/i0BwiHuecSz6Tbf+VcYxIULZmwnCmrQE8pckWQCUMWTQ40NCR1Jc5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5901968B05; Wed, 25 Feb 2026 15:16:40 +0100 (CET)
Date: Wed, 25 Feb 2026 15:16:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, miklos@szeredi.hu,
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: allow NULL swap info bdev when activating
 swapfile
Message-ID: <20260225141639.GB2732@lst.de>
References: <177188733433.3935463.11119081161286211234.stgit@frogsfrogsfrogs> <177188733484.3935463.443855246947996750.stgit@frogsfrogsfrogs> <20260224140118.GB9516@lst.de> <20260224192653.GC13829@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224192653.GC13829@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-78376-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 8EEC219894B
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:26:53AM -0800, Darrick J. Wong wrote:
> > That sounds pretty sketchy.  How do you make sure that is safe vs
> > memory reclaim deadlocks?  Does someone really need this feature?
> 
> Err, which part is sketchy, specifically?  This patch that adjusts stuff
> in fs/iomap/, or the (much later) patch to fuse-iomap?

The concept of swapping to fuse.

> Obviously this means that the fuse server is granting a longterm layout
> lease to the kernel swapfile code, so it should reply to
> fuse_iomap_begin with a error code if it doesn't want to do that.
> 
> I don't know that anyone really needs this feature, but pre-iomap
> fuse2fs supports swapfiles, as does any other fuse server that
> implements bmap.

Eww, I didn't know people were already trying to support swap to fuse.

