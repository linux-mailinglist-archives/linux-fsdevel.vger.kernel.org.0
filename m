Return-Path: <linux-fsdevel+bounces-78268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FB6EjivnWmgQwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:01:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E965A18820D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79AB33020537
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D43C39E177;
	Tue, 24 Feb 2026 14:01:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A4233ADA0;
	Tue, 24 Feb 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941682; cv=none; b=lCqYllf2ab1RnB156G8M+Mot4uU69/Qf3IvsboEjteLsz+fhMhClLYpirJuLb+zy3wRkAr2Rzm0189kTBjQxLqFPAB5Gl/FUF40XD+tA680vfj6tQUXYAhuHto09NZqy3orftDrnZ63mqEugvyfXt9d2iboLOui/GULtj2uWu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941682; c=relaxed/simple;
	bh=sBsOQPpLrZzU5mkoq5b6thjhGKFDFhe9Nt+bbi+6LWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEo5pUNG3XnhsqrosWeJT37nYpfqJKw7QfQ7RFO9nlrRennEM9qeHnj95Q+rLTy/bKgld/gJCvLiAO5J8UUlnQuxiXEFBpDqtHmUhV1OYwixsKqP+AaPC8HPArKvUX+x4oPUVx7ufwZShMH3lsv04jstD82ptwE5g8RQflrrW8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 78C0A68C7B; Tue, 24 Feb 2026 15:01:18 +0100 (CET)
Date: Tue, 24 Feb 2026 15:01:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, bpf@vger.kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: allow NULL swap info bdev when activating
 swapfile
Message-ID: <20260224140118.GB9516@lst.de>
References: <177188733433.3935463.11119081161286211234.stgit@frogsfrogsfrogs> <177188733484.3935463.443855246947996750.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177188733484.3935463.443855246947996750.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-78268-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: E965A18820D
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 03:08:08PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> All current users of the iomap swapfile activation mechanism are block
> device filesystems.  This means that claim_swapfile will set
> swap_info_struct::bdev to inode->i_sb->s_bdev of the swap file.
> 
> However, a subsequent patch to fuse will add iomap infrastructure so
> that fuse servers can be asked to provide file mappings specifically for
> swap files.

That sounds pretty sketchy.  How do you make sure that is safe vs
memory reclaim deadlocks?  Does someone really need this feature?


