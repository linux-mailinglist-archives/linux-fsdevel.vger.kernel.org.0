Return-Path: <linux-fsdevel+bounces-79661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPi8AwI2q2lPbAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:16:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 799402276FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A36513040319
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ECB425CF7;
	Fri,  6 Mar 2026 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sBhsbe/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF0F3368B9;
	Fri,  6 Mar 2026 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828132; cv=none; b=YhrD+b/FxzNj05Rfw7Bq5M9y6DB1OvkHAqJ50nbKZG7KitTlod/jYzKzkfeV6RUHvrXCtFYqRTMGZVY52+9BkCIfMW9+4rnyFqoPrmTTSzB3FtzU6wxWZbNdghL/yfJGE/YZA4cke6ioD+HclhoylVtoFV1TfIfcdAl3taxTr4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828132; c=relaxed/simple;
	bh=AXun7U2GjUr+BGdb5GDBtBrxp5rjVX2GakYwThhVkH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTK5y69KnseSKXABHLp2WQtpgdelzt1diCbQtZi43ZJQXJp/fqQYQOTO6c9E+NTVZBvsXMAQZc5B0lFPQLxmWiVw/0xjJyfEkSzJQmSbCKEWsFkxQZ629xgZn1C1Z+68fCudSJVo4tFGOlvOL/Sefsvip8prxSlHIW7FAEWyIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sBhsbe/F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kqDtRxUnfGVfrmPs+B6wD6LFhV7Vqmyopjf7Cm65ZXU=; b=sBhsbe/FNOqE/9HPmw8kY8dloZ
	D3l7DInSbFxSaRAGRZ5ESjNCK30kpnNJQmpNy3wd8uaJncNSI5SYn5GVyFQhbgef9IvfE+J7x8I8G
	cuP+fHX7rowitDNg++hVYOrVbs14VVSv44OUNdEmldYhWz9/jwbLuy1n3bLwc8KQ0EoXK894aH0h8
	zKF+b7TywvlXPi+nLe51Tyk9qcfLYN8wrn/c7B7tuazL+jq4bfFgo7TUmNSBNQCHwbA0XxC40V59t
	rieSdE4cYACXiuUHwRIGtxm9sozlM2dgZRKVH7ySQjtMS6D2DiwVJOwDPoay2PKrl6rEr2TNPudxE
	f5cE6rDg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyba4-0000000HGPN-1QDp;
	Fri, 06 Mar 2026 20:15:28 +0000
Date: Fri, 6 Mar 2026 20:15:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Josh Law <objecting@objecting.org>, Yi Liu <yi.l.liu@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] lib/idr: fix ida_find_first_range() missing IDs across
 chunk boundaries
Message-ID: <aas14HsY7dj6jTDZ@casper.infradead.org>
References: <20260306200319.2819286-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306200319.2819286-1-objecting@objecting.org>
X-Rspamd-Queue-Id: 799402276FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79661-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.940];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 08:03:19PM +0000, Josh Law wrote:
> ida_find_first_range() only examines the first XArray entry returned by
> xa_find(). If that entry does not contain a set bit at or above the
> requested offset, the function returns -ENOENT without searching
> subsequent entries, even though later chunks may contain allocated IDs
> within the requested range.

Can I trouble you to add a test to lib/test_ida.c to demonstrate the
problem (and that it's fixed, and that it doesn't come back)?

Also this needs a Fixes: line.  I suggest 7fe6b987166b is the commit
it's fixing.  Add Jason and Yi Liu as well as the author and committer
of that patch.

