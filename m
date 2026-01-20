Return-Path: <linux-fsdevel+bounces-74715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJhhDt7zb2m+UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:30:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9514C447
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6675AA5F30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA047885E;
	Tue, 20 Jan 2026 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PfDYkCH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF1C47884B;
	Tue, 20 Jan 2026 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936554; cv=none; b=EHybUfItC/shOT5SZRGIkbXX+R5siXuqVV4xS61rj9xfK30uRxw6HUlyDl1x0VYFCU18z5JROBDxnnR/ZvTtWjD0W0rpbJAFnjUnno0eItnGZ3OeGBoetlfY9qifVic+vDoVwlAM7Ows8d/DK4FV6KyMaeH2OCFwA83u5NXmBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936554; c=relaxed/simple;
	bh=t8z3Rwu7qOd+nhn4EsS5Aj8jJGv7Rw2YMqx/E2B1zZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0ijfCNi2z45DFxb0Ab8rZI2A65LfoDU8lUzVRatZlJqMHiXkkK1x2scoVysnfRlZ9BWd59Bw3yWEmlEMjGXXP0R+AR0apMjtIUnUDwJ7og/tl/42dfxF7eKqR91vtvrk+Mr+COHu9G347ElheCtSjXiDp0hUGta6omqZYAB/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PfDYkCH1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DjMUgMTbUmtrrp7aKjAsaMnjZcwTC03kGRkrVlxFZoY=; b=PfDYkCH1fMpw3iQS78xl3lkl1X
	+UKJO0a1+Zw6GZWasBeoJ66ZHOb/1juI+qpE0DMbQodRCgR4vYJ1MoT9wNaIhxQTK8hN3SYuJEp7t
	6n274mf1jgWeUAp4lI3LMtZTeNuEsdv8WtjMiKvm92kkKxCAMzJHh/UynAMnHyqSDDfjExly6X6yD
	0OqYepr9gvvmTLq7v8mVfgXrEmkDKWBLOf2h6D9dalMtAOReXZcAOyvy5n08AVaio/xjOMQC7o7yu
	4KNmUvQ/48XnKHVw1jIeyvvTsSmSCbGJj4lF0ssx4iXQrEq5xoySsQFD2lDtgwj24BZoj7LZr6vsW
	Bt/LYm4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1viHEB-0000000DMsh-0cwj;
	Tue, 20 Jan 2026 19:17:23 +0000
Date: Tue, 20 Jan 2026 19:17:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Rich Felker <dalias@libc.org>
Cc: Zack Weinberg <zack@owlfolio.org>, Alejandro Colomar <alx@kernel.org>,
	Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20260120191723.GA3183987@ZenIV>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <aW1dE9j91WAte1gf@devuan>
 <60c77e5c-dbab-4cca-8d0d-9857875c73fb@app.fastmail.com>
 <20260120163634.GD6263@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120163634.GD6263@brightrain.aerifal.cx>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74715-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[zeniv.linux.org.uk,none];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.org.uk:dkim]
X-Rspamd-Queue-Id: 9E9514C447
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:36:34AM -0500, Rich Felker wrote:
> On Tue, Jan 20, 2026 at 11:15:15AM -0500, Zack Weinberg wrote:
> > Rich and I have an irreconciliable disagreement on what the semantics of close
> > _should_ be.  I'm not going to do any more work on this until/unless he
> > changes his mind.
> 
> It's been way too long since I read this thread to recall what our
> point of disagreement is or what point glibc might be at in
> reconciling the Linux kernel disagreement with POSIX.

It's not so much disagreement as breakage of internal POSIX decision
process that has lead to POSIX irrelevance in this particular area.

POSIX authority derives from the agreement of actual behaviour of
Unices.  Always had been, witness the amount of underspecified
areas where various vendor implementation had different semantics,
due to exact that reason.

They (or anybody else, really) can argue that such-and-such behaviour
ought to change.  In quite a few cases that has succeeded.  What they
can't do is to force such change by fiat.  Especially not when Linux
and *BSD happen to agree on behaviour that differs from what they
wish it to be.

