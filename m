Return-Path: <linux-fsdevel+bounces-76123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aID1DXiIgWmzGwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 06:32:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE798D4BCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 06:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78BAF3041D50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 05:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40BB36681F;
	Tue,  3 Feb 2026 05:32:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACB366546
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096753; cv=none; b=JFcQIEV/9GmE5DB4zD5/QQH8jwK5U7Gs8vAPtdohsrotr/gjH1IYEXLYzIiLF5MEbTfGYXEvB14KiDkD+UyU1beT2OkR1d1b8ui26uIt9ZjR3zqyDWagAo7kshK0r9DYhzUVRZbhgf9WhjoBtpA1mK/fk/ozU6F4lizDfJYhTWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096753; c=relaxed/simple;
	bh=fs/NRSNAuw7Zu4gJ1VEptU0JD85IwsG2goAuMKdkTnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6U3mqTB48LPQ/eI+BXpEMX02k8AeYkUWNASCwoBWHbAxReA6M2nqypJmSBx7F7DMI/6TA/9CSLRV3LWkxLnmHJjRXg5x+kZv9yG2eRc4SgqWpAH/ngZoaQw7cItKsEDwxrxFMMQvvfl1XEDqbuw9F9rHl71MHg1r7imcUj8LaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88D1568AFE; Tue,  3 Feb 2026 06:32:28 +0100 (CET)
Date: Tue, 3 Feb 2026 06:32:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] fsverity: add missing fsverity_free_info()
Message-ID: <20260203053228.GB15956@lst.de>
References: <20260202214306.153492-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202214306.153492-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76123-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: BE798D4BCB
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 01:43:06PM -0800, Eric Biggers wrote:
> If fsverity_set_info() fails, we need to call fsverity_free_info().
> 
> Fixes: ada3a1a48d5a ("fsverity: use a hashtable to find the fsverity_info")
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Looks good.  It might make sense to fold into the offending patch to help
with bisectability, though.


