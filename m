Return-Path: <linux-fsdevel+bounces-79248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIEDOTb5pmk7bgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:07:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FC91F20A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 16:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78C1C305B7EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1088447F2CC;
	Tue,  3 Mar 2026 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lK742Vwb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4837B024
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550026; cv=none; b=ihIT0oxL5hOrgL/cfmh9mRBH1UwitNn7qSfD6ISFFEmvPz0ctPn0fGRkoTrewYcpfAPFNTG7cI5NZr7/J9g+N9Q7FYioGQ6iUkWSIfw+a9sMaWeomIABOqkIPP22jBLby6V5YYF+E3TKuKmdxBbsmn4+T1ifiHyBftJvMVqy+eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550026; c=relaxed/simple;
	bh=Zq6qc07TNNM9SXexlADopG/SfpnnDjJNi9OE99tP7m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCokfwy+nNkwBuT2KNexOr5PrIUTQlBxaFPozmMxirKoTnt1jrjGK7FY883/Ubam7Wo7pyiaN009uEAnINOh4FvWQXaqKaW/NG2u2iakpyKGzUlbN6gc32WUv8T7ELMuwC0E2cCBJFQL4fk5IRZ5i8wOaNue+aSywp5o61YhvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lK742Vwb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UocHEni3/4kdD2iaE8QnBZ0MDguWpGfeX2+s8hR5X9U=; b=lK742VwbLoO7XuSYh2F+XgwptB
	Y9rI9/nfYoS/osAx8s7vqitU8HGcaYgNq7W1LNQOEOjfgJSU4hGdJs7zf6vDLz81N5AW/53zjKklK
	sCH0SJ3R9pj/nVBUgE7gyfrPD9fMaxWOu5yg2aTfCywqEAR2yEbtD94IybKd//2nW7I8cQMNtIFYb
	izt8GeEa6U8Km3uKHqWxp2Tl7q9ejYBF6Oj15P1VqlGZTsGiUDGR2Jt2qnHX9/9Hd387PIRArHOTa
	xbHUG1pp0kG4QkIVli30Wey5PN8KT+aMMhEF+vDnZpgRc8bOclqN1CM9q8xphfkkuYETJ0uvk1IXT
	w3Ac2zsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxRET-0000000FNLM-2VJP;
	Tue, 03 Mar 2026 15:00:21 +0000
Date: Tue, 3 Mar 2026 07:00:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] fsnotify hooks consolidation
Message-ID: <aab3haz7W4ZqTT-3@infradead.org>
References: <20260302183741.1308767-1-amir73il@gmail.com>
 <cf1cb14e9b74bfd5ca5bfcaf4d6a820ee2d4324b.camel@kernel.org>
 <CAOQ4uxhWZBrcPXRtP5Vq3GcPZpZ3LkHD9D5A6LtfaqnJFeC+mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhWZBrcPXRtP5Vq3GcPZpZ3LkHD9D5A6LtfaqnJFeC+mg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 59FC91F20A2
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
	TAGGED_FROM(0.00)[bounces-79248-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 02:18:47PM +0100, Amir Goldstein wrote:
> > simple_done_creating_notify() is a better name?
> 
> I will go with simple_end_creating_notify() because what it does is:

Shouldn't the notify case be the default one and the nonotify one
stand out with a prefix like _nonotify?  I.e., steer people to the
more useful one by default.


