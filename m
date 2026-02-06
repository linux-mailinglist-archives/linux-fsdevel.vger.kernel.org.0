Return-Path: <linux-fsdevel+bounces-76542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COTaJEOHhWmdDAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:16:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF42FA982
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FCB7301FA6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 06:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDF42EB87D;
	Fri,  6 Feb 2026 06:16:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1E49659;
	Fri,  6 Feb 2026 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770358583; cv=none; b=qCx5SHiz9yhQa5azfuvSYBW8A0v2eFRGuNYPUrc++VpsDY3frYTcLlcmZZ8o3SEL140e35sslfJDh1FoIagSttRlea+huh4/HD26o/9ezrEGRcCzffVe50YJdvFDF9MPnopH7YxcUeK6mGZB/+ZYWsOPSLcFjB61HWs4gqfwXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770358583; c=relaxed/simple;
	bh=8PQdEOmHbCSQyT+ysDwPoF2uH5YyPYG9BZGQCZUWhyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsGXUWK1nfnSfqpw5/WwHwe20Uh0knRnDeDKSerdWg8+mRusirXt0wbWg1c+MnJP34ifidxaHv1OeP62YKKTRj3cZsdIERWW7iVrMsvr6ISds5ILYX8xVM1kJIcirJZFwcwOk5Q51f0DEMy/dxT5Tjet0WBeE5g4q1sM8D/xj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E855768D0F; Fri,  6 Feb 2026 07:16:17 +0100 (CET)
Date: Fri, 6 Feb 2026 07:16:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
Message-ID: <20260206061617.GA25655@lst.de>
References: <20260205202929.879846-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205202929.879846-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76542-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FF42FA982
X-Rspamd-Action: no action

Most of this is over my head (but I'll still try to come up with good
comments if I can find some time to learn/relearn the lease code), but
one thing I noticed is that this mixes up VFS and nfsd code.  You
probably want to split this into a core infrastructure and a nfsd patch.


