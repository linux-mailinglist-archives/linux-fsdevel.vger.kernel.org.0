Return-Path: <linux-fsdevel+bounces-77430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKpqDN7vlGmOJAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:46:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE591519A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9278A3045018
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316BE2882AA;
	Tue, 17 Feb 2026 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc5VcFPT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44681A9F83;
	Tue, 17 Feb 2026 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368410; cv=none; b=pOwqppztSqGpMqsiZd7Tp/s9Nc/LIfO2MD/Ni7sJ1TMEg6dDljKbfERCHPT7y+3rsEG6O7sR7GiFhbIbJrvmpG47q4kZ+MSeQOEp5qt8wFLW959r6kJiaG47DNvqiKX9v/SSAJ8TIg4ovEJlc4TN2mK5K/KPnWRDaXhXkbwZ3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368410; c=relaxed/simple;
	bh=BACigLwvUhA0wYDjJtn3c/Rbvqjdc106zhNLoKO6WjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKFNWVueaGLiAvm5ec1SmQH7YlwwtBZFauePos82zxa38PBtVkMZ5yHW7M+9hm6E4GkQyTWmvOgm3M3kAHqbEa84B9AobiAjAHF2lJ8wUaFoxS2yPr/q4/mGyYkA5uv+OxMgZxPVrQHSS+BV3DbF9IPkNqDdlUsU9gyiQNb+GSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc5VcFPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654FAC4CEF7;
	Tue, 17 Feb 2026 22:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771368410;
	bh=BACigLwvUhA0wYDjJtn3c/Rbvqjdc106zhNLoKO6WjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dc5VcFPTHtDrT4U8Uie2oU4zF+nElLSZ6Fd2A3EUlNXBGv7vOkx5kwOox8HhC9h4l
	 1MWQQFVzFJHAD47z5+5jHB28e1w4BiX/FMVlve3dYHHsEsZs+pXhiZosqYUReAI0gH
	 dRODY4s5BZ9DOkx2mtIwmmKF9SGElQpNFab+NQ6BxwNhWMgLGL8wTNwK0HqxZBcqiK
	 XF/9vrYU/xXXJE2ccEXrcWfkqRaQk2ve3X4fhMHsKlC4nIKNwnGFmYuaXI4XvuchAA
	 sz214wTzl6E98vOSrQ0JLnE3vKBXuT2vXyrTtpHRZwIowBhM1N4ZWBRT0qJ+1+LsOL
	 WZsSnuVtl/9gA==
Date: Tue, 17 Feb 2026 23:46:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/4] pidfd: add CLONE_AUTOREAP and
 CLONE_PIDFD_AUTOKILL
Message-ID: <20260217-chorgesang-neigt-1b032054aefa@brauner>
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77430-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FE591519A6
X-Rspamd-Action: no action

> CLONE_PIDFD_AUTOKILL ties a child's lifetime to the pidfd returned from
> clone3(). When the last reference to the struct file created by clone3()
> is closed the kernel sends SIGKILL to the child.

So this is for me one of the most useful features that I've been
pondering for a long time but always put off. It's usefulness is
intimately tied to the fact that the kill-on-close contract cannot be
flaunted no matter what gets executed (freebsd has the same behavior for
pdfork()).

If the parent says to SIGKILL the child once the fd is closed then it
isn't reset no matter if privileged exec or credential change. This is
in contrast to related mechanisms such as pdeath_signal which gets reset
by all kinds of crap but then can be set again and it's just cumbersome
and not super useful. Not even signal delivery is guaranteed as
permission are checked for that as well.

My ideal model for kill-on-close is to just ruthlessly enforce that the
kernel murders anything once the file is released. But I would really
like to get some thoughts on this.

