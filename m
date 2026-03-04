Return-Path: <linux-fsdevel+bounces-79351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBo/LNYrqGkgpQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 13:55:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D951FFE61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 13:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 442083028360
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056B8223DFB;
	Wed,  4 Mar 2026 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXJ5tALs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182D73463;
	Wed,  4 Mar 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628930; cv=none; b=YN+ht1BpU5FAb2+S7R7heu0GWpCIiZcqbIL+5GLoT6a/x5S+gp6aehXkgomWIUIxKGOR/CL4o1x44qGdzaSwafdPbq5RWssGa7PGfG2LxeWnOSAcKHWAd1G3nFK/+qJR+OVHIz61p3Wr2y+lonu7DorNrbXFQv/gFh1dbWIHckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628930; c=relaxed/simple;
	bh=YOVUcvbe65ZJpd4Sa/Gyz3S1wnefhK4mWrP5HMD2COs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2X7vIzeuec8PMGVUQzQRUux0svI3q3aKFPCLIQavPPjRsQOVrmb+wE04QVNxl4EmmjZ5YtIutJr8mHXGX+otOU+1HgHOkBEQAWcU/9HW78tRWoS7LTjiwvmCn9OeJzaFYDzcFeSNXqH3frk0ozBKg3qj5zECrfzUvNiODjflv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXJ5tALs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17ACC19423;
	Wed,  4 Mar 2026 12:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772628930;
	bh=YOVUcvbe65ZJpd4Sa/Gyz3S1wnefhK4mWrP5HMD2COs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sXJ5tALsZ3x+Xm8IRWMMkdygQLA/rJbgtfXgLxP5e79JNZxC1bITeYuabK/RzE1Nh
	 bhWGnOkCOdDPttDDSCP36m/lnqK05MwEJURAtHv8KeRvCIK3CFPV8lnQn6hMcxAYUx
	 0/gWHfjp/TNahdP9yDw/ZBMLVn4CMyFUPfXcwnT89dEM3x29orr58m3pQYKvIJNgFh
	 xHKrmO8frvKRU8hlUrRZt4KecverAwoHXSr4Sf/pligM0Bd/X5/VuJ0y6jRdbD5xSw
	 fhbLQo4KQ632nxvSOa6IpSftyx4aUDfoMt926sT1fOObQVz4ygu+GbjkWS6x3SASzA
	 uphtRWGOcqyrg==
Date: Wed, 4 Mar 2026 13:55:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: support file system generated / verified integrity information v4
Message-ID: <20260304-sattel-filigran-aa002d3e3983@brauner>
References: <20260223132021.292832-1-hch@lst.de>
 <20260302-legehennen-musizieren-08d0e3caa674@brauner>
 <aaWVQ3g6vsDB4GvQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaWVQ3g6vsDB4GvQ@infradead.org>
X-Rspamd-Queue-Id: 18D951FFE61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79351-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 05:48:51AM -0800, Christoph Hellwig wrote:
> On Mon, Mar 02, 2026 at 11:11:22AM +0100, Christian Brauner wrote:
> > Applied to the vfs-7.1.verity branch of the vfs/vfs.git tree.
> > Patches in the vfs-7.1.verity branch should appear in linux-next soon.
> 
> Note that the branch name matters much, but this is a different (and
> older) use of integrity compare to fsverity/dm-verity.

Yeah, I know it was mainly named for the related xfs work I had expected
to require some infrastructure work. I'll rename this to
vfs-7.1-integrity which is a bit more generic.

