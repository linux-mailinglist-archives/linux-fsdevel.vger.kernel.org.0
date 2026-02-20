Return-Path: <linux-fsdevel+bounces-77794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJNALrJ5mGlrJAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:11:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C1F168C7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C67D30276A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796931D390;
	Fri, 20 Feb 2026 15:11:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D824A069
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771600301; cv=none; b=sdkk3fXZZ+OfiLCUS8nxBsGr3m0uEFBEK5i8kORMicEMguFZbEHo49+jYSySXc7n4S002aoANk0lUYU/9j4nUhy9KVy/p5vlwWZLoG6pIW0OsmmhQqWxhw4pyV/jsIK00KuSIzi1MExK1aOzbobHn/Mub5Ey3iQbbZXU+S3NaBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771600301; c=relaxed/simple;
	bh=MqYe3L0pEYQqL/fKsT+5NtczRVRifL42O/KKut4uNKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hutUVk5k2Ia13W00S13CJjD8FUrBNiwOaKD9QAtd6LL3xtPkTCTkvNrivcQtjNM+7kh78uZajyGKzDkWD7JdbycRMSHjqyqOT7ayR7xQVKAWM6TV8CzVpGP11GTSHtIGhFCvRtOb3G8NaFFlC68t5IJ+SGbqbBZNdc78nAOMQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DC2B168B05; Fri, 20 Feb 2026 16:11:37 +0100 (CET)
Date: Fri, 20 Feb 2026 16:11:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Keith Busch <kbusch@kernel.org>, jack@suse.cz, amir73il@gmail.com
Subject: Re: [LSF/MM/BPF TOPIC] FDP file I/O via write-streams
Message-ID: <20260220151137.GB14064@lst.de>
References: <CGME20260220110725epcas5p41a6ae8751fee9782f338cbd66dd2700d@epcas5p4.samsung.com> <83f2e586-75d8-44a3-8427-ea6165f1dff9@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f2e586-75d8-44a3-8427-ea6165f1dff9@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77794-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kernel.org,lst.de,suse.cz,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46C1F168C7A
X-Rspamd-Action: no action

I think you'll get much better traction if you don't tie a high-level
feature to the buzzword of yesteryear as one possible implementation.


