Return-Path: <linux-fsdevel+bounces-78003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cClnGB/JnGkwKQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:39:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC1C17DA43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09A6E30612AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 21:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959773793B5;
	Mon, 23 Feb 2026 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEenlYOE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7AE378D9B;
	Mon, 23 Feb 2026 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882767; cv=none; b=uo+v486dwy0DUCyURcehdHvOEnItwVnI2j081MejhnOWBqv7k5nKlHmeHkMPJx5YuZ6gKM142JO8rzVllUmXxnke6go+Upr+fGgp85hyu59UiQoWDM2QRBbWV/xu9Qrk1Xzx7Iv4kEH/CcCO803iR6s880jtjYe6m10ZIUi7D7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882767; c=relaxed/simple;
	bh=7IYocus/c97LefvuOSkz3YYbOBRXPqXCIPlewr/+U7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifjLRXa8lRcg0NQ5YHS9rbe3LvWrcjRbtFsJJW4opoHBEQcfW6vhvCvcyArJGZ2x8wDaYmmW81SmkIiogaOZQPL8LuX/aF+s66dtHXxNFSlir3V81rU5RNYAmMDTrlPhAS4ZoGoQpaJJXwE2Ttbjq0RaRBaD31bpp5slAmYxXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEenlYOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F240FC116C6;
	Mon, 23 Feb 2026 21:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771882766;
	bh=7IYocus/c97LefvuOSkz3YYbOBRXPqXCIPlewr/+U7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JEenlYOEUOjxItVtETyj1PwFIJHWWtVhZsnE/gu/5UOQa9X1VD/UJNhpf7tAIEb9c
	 Z7GY7IMSh8vym+DsnzrIVlFVbNyQUShWVJLtzPtrfFJLwZahZugKamUWSsMEAtGMcE
	 3zEmMfi4uKE9HnmlAMA8x1TU84cIwRw/0BCzcTMgPmOKc/v1Q7UP2g64D1SypqO5LP
	 BSZZ0wTfaf7wqeATlBMwVnPbomhaER53FXjSazzBWIDv10rs4EmjYheRrmBGGOxrg9
	 iGzxGtS2icxMknRSWr5Th23qKHLHG+A6D3ZZnCdCr/1KsbjzaUc6oClisuHGVs0Z8o
	 VA7FVwo11ZA8w==
Date: Mon, 23 Feb 2026 22:39:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: pidfd && O_RDWR
Message-ID: <20260223-ziemlich-gemalt-0900475140e5@brauner>
References: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
 <20260223-work-pidfs-autoreap-v4-2-e393c08c09d1@kernel.org>
 <aZx2dlV9tJaL5gDG@redhat.com>
 <aZx3ctUf-ZyF-Krc@redhat.com>
 <aZyI6Aht747CTLiC@redhat.com>
 <aZyonv349Qy92yNA@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZyonv349Qy92yNA@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78003-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFC1C17DA43
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 08:21:02PM +0100, Oleg Nesterov wrote:
> On 02/23, Oleg Nesterov wrote:
> >
> > pidfd_prepare() does pidfs_alloc_file(pid, flags | O_RDWR) and "| O_RDWR"
> > makes no sense because pidfs_alloc_file() itself does
> >
> > 	flags |= O_RDWR;
> >
> > I was going to send the trivial cleanup, but why a pidfs file needs
> > O_RDWR/FMODE_WRITE ?
> >
> > Actually the same question about some anon_inode_getfile_fmode(O_RDWR)
> > users, for example signalfd.c.
> 
> perhaps an accidental legacy from 628ff7c1d8d8 ("anonfd: Allow making anon
> files read-only") ?

It was always a possibility that we would support some form of
write-like operation eventually. And we have support for setting trusted
extended attributes on pidfds for some time now (trusted xattrs require
global cap_sys_admin).

