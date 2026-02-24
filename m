Return-Path: <linux-fsdevel+bounces-78233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGQQLZJznWmAQAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:46:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D795F184E5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F482303D4FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C641E36D4FB;
	Tue, 24 Feb 2026 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0nWSWjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728136C593
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926194; cv=none; b=hvvvazNsHRvLDx0gT0kSAJI7g3dRaJXhhGTfj96zmKhOSDwGXl5OmTcYiw30/9JAh36ho1jBxElypgF7l08/dgBbtnSCbOQvEqejOl7XfO55Dt48OppENGO/WojsUoqVqlgD9+EHk+h5DGFNUKGD84lMIBv4N/RI7uPvyibpP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926194; c=relaxed/simple;
	bh=VbSSEvqYaIRsDaq6BXt//7gJ4j08UhZh1G8iYfMmN7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIEooYCMZ6fWYUveHdE3OAqnhNpSOJ2jtFIFkGa9iwxS3UfRvnQ/IYbb8xUBUsBZUhO0O+bnM05O99iF/uQj9lllKCZf2dJSQwrZLgpumj5fvANlyoeyRsQw0MOv62Mliy4incahrriJ+iKP2NOEVQ1zs169JkIPtDJTDexQykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0nWSWjG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483a2338616so33886485e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771926191; x=1772530991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWa3PZrQfAyHU/Z5llWO4iuXhqNdy8SPoogWplvEUCw=;
        b=b0nWSWjGuDR0ursGxRMFd07ibqI+X30Q4rgeBwvqS+LG1Cy0xpnOIDsglUkqzHOjoJ
         xdVLyVYQhWDNaVU34GKmti7U+JB5QeTdXKDPTPx7N0ZNp+Wk6TUHh+fLTAbIT5hgbzKr
         HtYVn9bmT4Rz/1q1Us/Ft5lvhQVhTaSFec+gQljxh6jbdAxAqZWa9mDD6XRUIVIsggw9
         wQGFXSzTssRu93zW5O1Q2ggDaFIxPf9s3EghX+mzQkTLmp4rDN6yBCqJx1iTLhI7Yaud
         Fvf0fD0hE52jRcpppBHf/KArfR/9lNiKlT8jpSx4TutvSycF03IneY6OlBKck6BsSwab
         ZN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771926191; x=1772530991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IWa3PZrQfAyHU/Z5llWO4iuXhqNdy8SPoogWplvEUCw=;
        b=bev6APlGhEuP3Q/bPmXs77z4GDEM44yex+oa1Nd/sgZIN7D6i/eEjySnayenunPNAh
         sa7JWKwBLajtCWQ+vPKTnCiXglati3OMT2hoOXL5v/oNjzSu1gaP1MusDy3+Okn0+5gc
         bSRWqa6Yed/5ZWg6SkfgOp8AeuQmeWO8SHg28emDKniI38FOD9nvOyTBPiYnknDnOXJm
         X0JUNwmVi6YjtUST4wU7oT50s2850yDkRtLETtJqAzkeHx/Bg/AcapBNuOVeajZGPwRH
         4ODrGtIH4UsMXvUva75QYHfppeNy604OVMVW15uT1LzpVtF8hw2RovDb2mLzKL87ZxzP
         u27Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwEynUoKyPbXIE0q1g/vE29JPjzndvxGKqoIak5AS6rs3wobYGwAtq+pwyZOo2yjOXCfr2NC8awstsZQyo@vger.kernel.org
X-Gm-Message-State: AOJu0YzzaWYkU6kzQIVf/YF8Aq42gsDYUD1yPwbG4CRscKwh42kZTJt5
	vDXW+k52gJJIMIw1PPlExV5hsL6FXwT9cwoxUK7CROcuXxGcIT96SDkJ
X-Gm-Gg: AZuq6aLykSLiCyOkqZJ4NtpVnFhkbukNqkgh0NoxQRBxA5tDOGl1bIL0vvXNnLeLhun
	6+A8+UdBGrv75SHdDiO8YLjj+MB6Zaxwo+cjebKDn9rRm4tAS5BZ7YHFV6g0kqhoJBaDWT+GRA7
	ORx1GpsTZxPKKrcSpQlmqAFrvFlyddWAdFYz1VIM1gYTeSi9xZ6pXwun8lNrhEjiFcWNPWNyLUK
	c/Uqbm1tDfVOD4V1wVV9QBupl3us0Y5+edsoCmm8NDg9RYJw5jalfa90hDYzCzq/HArc5PTPwij
	LADyEEeUAAsf8EQ+hpfgUona6h/MWhP/ISSResUW2geMB7hwoadOQu07a851QtvTqhV8ttCmYdt
	imLpseBy5sFtbgy46KllNDkHR0826sVuPtFFjnVIfF0lYnNDub63YKWzpmG9uRVaKgmTsrQ9cSl
	DlnJKYPKqAnkdzET2Tw16u34usp21mJD82yWxW+c56UdYPX+vxvytQaSo7PdNw4VOU
X-Received: by 2002:a05:600c:548e:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-483a95643b3mr201212155e9.0.1771926191065;
        Tue, 24 Feb 2026 01:43:11 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b81986cdsm29112075e9.0.2026.02.24.01.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:43:10 -0800 (PST)
Date: Tue, 24 Feb 2026 09:43:09 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: pidfd && O_RDWR
Message-ID: <20260224094309.591e7db1@pumpkin>
In-Reply-To: <20260223-ziemlich-gemalt-0900475140e5@brauner>
References: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
	<20260223-work-pidfs-autoreap-v4-2-e393c08c09d1@kernel.org>
	<aZx2dlV9tJaL5gDG@redhat.com>
	<aZx3ctUf-ZyF-Krc@redhat.com>
	<aZyI6Aht747CTLiC@redhat.com>
	<aZyonv349Qy92yNA@redhat.com>
	<20260223-ziemlich-gemalt-0900475140e5@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78233-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D795F184E5B
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 22:39:22 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Mon, Feb 23, 2026 at 08:21:02PM +0100, Oleg Nesterov wrote:
> > On 02/23, Oleg Nesterov wrote:  
> > >
> > > pidfd_prepare() does pidfs_alloc_file(pid, flags | O_RDWR) and "| O_RDWR"
> > > makes no sense because pidfs_alloc_file() itself does
> > >
> > > 	flags |= O_RDWR;
> > >
> > > I was going to send the trivial cleanup, but why a pidfs file needs
> > > O_RDWR/FMODE_WRITE ?
> > >
> > > Actually the same question about some anon_inode_getfile_fmode(O_RDWR)
> > > users, for example signalfd.c.  
> > 
> > perhaps an accidental legacy from 628ff7c1d8d8 ("anonfd: Allow making anon
> > files read-only") ?  
> 
> It was always a possibility that we would support some form of
> write-like operation eventually. And we have support for setting trusted
> extended attributes on pidfds for some time now (trusted xattrs require
> global cap_sys_admin).
> 

Isn't 'sending a signal' a write-like operation?

	David

