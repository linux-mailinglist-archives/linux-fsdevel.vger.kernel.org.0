Return-Path: <linux-fsdevel+bounces-75294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPFWOH+Fc2kDxAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:28:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC51770B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E80CD30090B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4A1328B46;
	Fri, 23 Jan 2026 14:28:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB5913B5AE;
	Fri, 23 Jan 2026 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178490; cv=none; b=puqJtHYB/0vJmHaeTnW2x9/QUGTaPBrDuInMC6g/jaNQhoE+zpcQe+faHLjORBOPKpTiu4K9XnbA7O/DrllB0qjpxz/Ty+A0J0wQ3nTlxZFLlKHpesgDGfPXKkby+vlWAFaDZ0ydCZZG1w5QYv+r1jmBurXWdAGjgmaD/V4NVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178490; c=relaxed/simple;
	bh=w5N6FEqV+2TE2TNNg+dkdmK0HAxfCvoJKGBm9cMbqTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jINgvHpdfLG6VRy8svB1Q4KvLxELBbDGcP/I2SX/hy2LDspRShplcixiJePdwwZGVQ6hifOa0j4qFAt0yUJq06ik9r35R80Z8rSi5x5EJ1HsRL4hnk5Tyvkq6PgfmKEEEmBgQ1//ulHnDv8xMefLAL7pkk85xE/zhWQy8swq/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 835EE227AAE; Fri, 23 Jan 2026 15:28:06 +0100 (CET)
Date: Fri, 23 Jan 2026 15:28:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: do not allow exporting of special kernel
 filesystems
Message-ID: <20260123142806.GA26225@lst.de>
References: <20260122141942.660948-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122141942.660948-1-amir73il@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75294-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EC51770B7
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 03:19:42PM +0100, Amir Goldstein wrote:
> Most of the stakeholders approved the approach in v1 [1] and
> only comments were regarding lack of documentation for the new
> incomapatible methods.
> 
> I did my best to add minimal documentation to express the fact
> that those methods are not compatible with nfsd and remote filesystem
> export in general.
> 
> Further documentations regarding the new uses of export_operations
> beyond their original use for nfs export is outside the scope of this
> patch and frankly, outside the reach of my documentation skills...

As last time I'd be happy to help write documentation, but even
after looking at the methods, their documentations and the commits
adding them I do not understand them.  So getting an explanation
from Christian would be really helpful to move forward here.

Note that you and Jan reviewed those patches, so I'd hope you two
know at least a little about the use case as well.

Btw, the nsfs ->open method seems identical to the default.


>   * permission:
> + *    Allow filesystems to specify a custom permission function for the
> + *    open_by_handle_at(2) syscall instead of the default CAP_DAC_READ_SEARCH
> + *    check. This custom permission function is not respected by nfsd.

may_decode_fh actually does a lot more things if the capable check
fails. (btw, shouldn't that use (ns_)capable_noaudit to not generate
audit messages?).


