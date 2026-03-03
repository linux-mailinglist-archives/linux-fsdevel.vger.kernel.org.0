Return-Path: <linux-fsdevel+bounces-79252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PmcGWr6pmk7bgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:12:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D51F2287
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C80503009F11
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9AE480339;
	Tue,  3 Mar 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VwOsEgIi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B247F2DB
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550441; cv=none; b=clQWPpxa3BYQm+/qo61GAgexEr7wB5HOJuAEnO7v2+dooKwMv/HWK3IXWIcs3Ua59t9GyMd8YudR0J4uKYcLiXdHAu1t4Uw58UODpP2HAeiZfKG9/mBvE5SRSl/VUC2gZbqUq/0CdpLp3bm6QJPNCwYOQfDky4RkPh45BJ4XOaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550441; c=relaxed/simple;
	bh=lzPn4cfBkrmbOOOcRRejsUh+Sa7Ipj1cB6cQZ1y3XWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRhBYoeLJ1F+TOm4yWmHx8K4orhmOo8LuOoSYNc2fmb+WQHxiNDWRFRw07ShDyeVUtbVfRawJKQw4uPgzBt5qycfKNJb+z4sRUW2AhrhrchuaIM+AQF0YAijc0UONgNJmep6FLc+gwKd2+p/qWdLeTosDxXTVmVfTmgKogKddGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VwOsEgIi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h2qnHi3bJerVPwQVZ6hbGzGI3s9cl6brHsLSnBWPABw=; b=VwOsEgIiw8JNmvnGbC9RUZ+9Vr
	97afeU09O8cx9on7LMAqSgnqlMyypOwb9oM4nfn32gtvR7bsPpNBx88MCM4RbZ0k+PHSt+9LcSI8S
	tZtPLEs5wducEvx0PgSnFS9AFD1fGA7rnA5Gzyqri82zF5GjqAgFWky1n/ZvnolBhhKv3LlRMYcgX
	1JWvq+kBk5HhWVS68B8jWRAUtHMjrj3NIiRqF4huedKn5ug248oSWAMKepNr7yGJEftboqAYV13Z8
	ZjmWEzp7ZCcozevEOHRb5XxTkVfrqaT8ST+d2bPVd3guswTXJLpmfIiTf1x8CzXz/I8EO1uT3nxux
	2pI7+tDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxRLA-0000000FNqG-3RX8;
	Tue, 03 Mar 2026 15:07:16 +0000
Date: Tue, 3 Mar 2026 07:07:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] fsnotify hooks consolidation
Message-ID: <aab5JKLZWR-sR1cy@infradead.org>
References: <20260302183741.1308767-1-amir73il@gmail.com>
 <cf1cb14e9b74bfd5ca5bfcaf4d6a820ee2d4324b.camel@kernel.org>
 <CAOQ4uxhWZBrcPXRtP5Vq3GcPZpZ3LkHD9D5A6LtfaqnJFeC+mg@mail.gmail.com>
 <aab3haz7W4ZqTT-3@infradead.org>
 <CAOQ4uxhZHnSDJbLwvymJqkqKe5XhQG_W-HSNi7MnhChvuyK4vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhZHnSDJbLwvymJqkqKe5XhQG_W-HSNi7MnhChvuyK4vA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 871D51F2287
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79252-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 04:05:09PM +0100, Amir Goldstein wrote:
> It may sound like that, but in reality, it is quite hard to differentiate
> in pseduo fs code between creations that are auto initialized
> at mount time and creations that are user triggerred.
> 
> Only the user triggerred ones should be notified and also we only
> have a handful of pseduo fs who opted in so far, so I think in this case
> staying with opt in is the right way, but open to hear what folks think.

Then maybe encode that in the name with _user and _kernel postfix, and
also document it very well?


