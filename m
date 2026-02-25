Return-Path: <linux-fsdevel+bounces-78390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFvgNT42n2nTZQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 18:49:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCF919BC6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 18:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2036F30B19F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F33DA7DA;
	Wed, 25 Feb 2026 17:49:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA362DA775;
	Wed, 25 Feb 2026 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041756; cv=none; b=Hotc3XBuClt6hRhYXaeyr2TYWDwUJcnm3aerO543YZo2YR6IA5OPdzAYZlzOYre8anHrBFUqEvwjGWP5TDRBKRbNfd3nSBM+QlpF/TMxTG01zASEVvYb/APG39LpKHF9I9MHuRivMxzWQrEYwZRIl+EM5ZKK/yQq5mvU4Hrfypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041756; c=relaxed/simple;
	bh=AGDeswC8OzpimRK1pTpQnzizOPPkGeBpZoEw04SdB8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6yjgicWddGcGHwDDm9bwwl3v4XZB1EauH0r/3ETLUUmWZ78iII4Zm4nvi6UNbZ0vNXrq68vBktwemmAfSZ5s2Dr1f5Y0SiQvLf3Ms7BTc19w8mey3iP83MCMqWEg0yLlta4vcQvoZ1uYwv+4l3+peR4In3wpT1fu2sYtLzh8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95F1868CFE; Wed, 25 Feb 2026 18:49:11 +0100 (CET)
Date: Wed, 25 Feb 2026 18:49:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, miklos@szeredi.hu,
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: allow NULL swap info bdev when activating
 swapfile
Message-ID: <20260225174911.GA18988@lst.de>
References: <177188733433.3935463.11119081161286211234.stgit@frogsfrogsfrogs> <177188733484.3935463.443855246947996750.stgit@frogsfrogsfrogs> <20260224140118.GB9516@lst.de> <20260224192653.GC13829@frogsfrogsfrogs> <20260225141639.GB2732@lst.de> <20260225170322.GF13829@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225170322.GF13829@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-78390-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 5DCF919BC6F
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:03:22AM -0800, Darrick J. Wong wrote:
> > > I don't know that anyone really needs this feature, but pre-iomap
> > > fuse2fs supports swapfiles, as does any other fuse server that
> > > implements bmap.
> > 
> > Eww, I didn't know people were already trying to support swap to fuse.
> 
> It was merged in the kernel via commit b2d2272fae1e1d ("[PATCH] fuse:
> add bmap support"), which was 2.6.20.  So people have been using it for
> ~20 years now.  At least it's the mm-managed bio swap path and we're not
> actually upcalling the fuse server to do swapins/swapouts.

Assuming it actually gets used, but yes, it's been there forever.
:(

