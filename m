Return-Path: <linux-fsdevel+bounces-77344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN2GFecjlGnXAAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:16:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A566A149D3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24CE13011BED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 08:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C44E2DC764;
	Tue, 17 Feb 2026 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWPKIGgF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF233993;
	Tue, 17 Feb 2026 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316183; cv=none; b=AzSoeqiKrAsrrPuZNohzjbsGldhchfI6SnsSb+GBfhCYa5rD5QBasL5lBrzxInq+78M5sJIH99R7ACrmjgamlNiIEdXZnJfILiF+pqgLhM3iaxNl183BnITBp6r+mYIfZppi/XpbliGzFPtQ1IEGxqzGXWDLJhWpTaa1a1KaoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316183; c=relaxed/simple;
	bh=FrFBFXX4chEe2yDjZZSRJqlFEyAv0qFo8BMEAIEockw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPCpchCNYlgIHl/YgNxIY1G/7hWYFI3css2wMmJmxpAbPcTOKp7KB4Fs6EJF2bHU9PH31aApqovDN+fRwZzbvEKRxhPQMlXBb/TSh/FMhgu+piqw/Cn0jP4ao2m2UHwaSwlND09EN1qhwvg3OLa5z4PGfTQzuyGxKvhojr9gJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWPKIGgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C876C4CEF7;
	Tue, 17 Feb 2026 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771316183;
	bh=FrFBFXX4chEe2yDjZZSRJqlFEyAv0qFo8BMEAIEockw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWPKIGgF9BVEFAhCDceqvFN0a8dtDcqVw9Rb7WRfZCSL7kcHk8rCFEgvKHIzCdP0V
	 6vp4MtidOD/hdI++rhbH+humCZfRUrRdduLx7WAt5TbW93LeCu3R7y20bl4cCXf9EN
	 AycXl0f+vDxaHwXAA2oBNUddm1EEmtZE6nuzpHRIzE6DxXFiPsx3fiVUJt9M8cchwb
	 J+1jHkSzR4ZB7lyy7PdK2svdgmXduawv2dcR/53oR9BB4s5PLXQWtGJAxBAfEwH1tL
	 jQ1ViChU6jcPjp+JTyyPumLpoOOsueGWFtpXO1HBFhgtwvQoMugw8fjAO6JyL4wCCL
	 sybozBfi8o7hQ==
Date: Tue, 17 Feb 2026 09:16:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] pidfd: add CLONE_AUTOREAP
Message-ID: <20260217-ruder-mietvertrag-1f48c75ea965@brauner>
References: <20260216-work-pidfs-autoreap-v1-0-e63f663008f2@kernel.org>
 <CAHk-=wj8Jp-JZRQsLaOGCWYb_qjsnHZUsdSfRpkwJOsjJozfGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj8Jp-JZRQsLaOGCWYb_qjsnHZUsdSfRpkwJOsjJozfGQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77344-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A566A149D3E
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 07:25:48AM -0800, Linus Torvalds wrote:
> On Mon, 16 Feb 2026 at 05:49, Christian Brauner <brauner@kernel.org> wrote:
> >
> > CLONE_AUTOREAP requires CLONE_PIDFD because the process will never be
> > visible to wait().
> 
> This seems an unnecessary and counter-productive limitation.
> 
> The very *traditional* unix way to do auto-reaping is to fork twice,
> and have the "middle" parent just exit.
> 
> That makes the final child be re-parented to init, and it is invisible
> to wait() - all very much on purpose.
> 
> This was (perhaps still is?) very commonly used for starting up
> background daemons (together with disassociating from the tty etc).
> 
> So I don't mind th enew flag, but I think the restriction is
> unnecessary and not logical. Sometimes you simply don't *want*
> processes visible to wait - or care about a pidfd.

I'm completely fine removing that restriction and supporting autoreap
without pidfd.

