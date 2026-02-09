Return-Path: <linux-fsdevel+bounces-76683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFX4L8p1iWlm9gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 06:51:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A57B10BE29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 06:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3203300515B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 05:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5972741C0;
	Mon,  9 Feb 2026 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TGdXwc9K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F72222B2
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770616200; cv=none; b=h6hdHsxA9J6tubdzCLUgPmJ4vSPjlq4wDnuhWVA9lMjLqJ0yMULLvbrfSTkjFIZMnv8V+IF2RSpo3qrrwQN8QcpIKAWLDOfqrCQ407BJ4oEklB4yh+8ff+Kegfu5MihMcUi3s7Oh+ZBsGmYcINAWbk36XL7VX7Yu9O44qaUmsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770616200; c=relaxed/simple;
	bh=zvbERxRIICWBxzW2Xv1Wp9+Xoc641ebErcKf7kqmly4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dK4LiWkyPRN5bjlnTPau6fFQPynRizgTyEEo6Dbgfb7TITl8PnLwlCVf/m9Qqi2Iw3zEJyCs+bqt17RYSFVfZzjql7Fzn3meqlKMfOmLLlsXbnUQpqUOEEyDAR35rtG2RqsX+6OnE1c+qtuUrxcyvnnn4ysNpGBNpoyqNegrUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TGdXwc9K; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-658cc45847cso5946588a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Feb 2026 21:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1770616198; x=1771220998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cKq5xRR4e9Yx6vJj96EqeBan5WGrdOP5Cs3dzQ9+flc=;
        b=TGdXwc9KYO5xVzLWkF/jboEdOi1B4YGXmW6TIH0sBI3VOono2eHHyL05nft6l0IbTk
         DoAVrn6h4U1Vfk/2+ux+Ii2cGVrNjIww8tsYoX+pYMJjeMAosX/uEFNMRwVo37NsPwUc
         1WSUbVB0C5dNjd18rEKAXCGUEhsUPVQqjbEk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770616198; x=1771220998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKq5xRR4e9Yx6vJj96EqeBan5WGrdOP5Cs3dzQ9+flc=;
        b=fITgYWrpRbVcy6OhA1c5pQYB0KB7YDuDABwd/nhenTOG7i+5kgKBR8+yMfUh3hVbHA
         v4utOYxz/UJea6P4eRnoLffuDGmcSIjmlxiQ9A+P0kbtW2oX/QnQcvBow/Qmn1UNM7L3
         htGKGYg2+/aVOzVl0GMgKnuWEzwdguOgtIqJl/BR/1Pc4O6T0zre8EQgKA0bCupuBVgA
         HO6A2F9b8DyQlJg+JWBo309RJGWFS+iZdnt8jGLCBcIgqObrPpI5BgrtuM5+I2zxRjiL
         /zAeP7/OzoknjIOfTrEXQ0M2wfzYmHM/LLTWgMUToCYsDNSOsV2DH1oHBJdK49IjTUZp
         A8hQ==
X-Gm-Message-State: AOJu0YyqmyxZaKeCV4zdgA5XqGtqTs/ieTsAY6YkYaMstDSMwNdOrLmC
	Z2+IG1D2wbDsrN0nGB9Jx881jU1549H4oVG6z0YEymHMUN7RdHAEk4DQuNUwPBvesZho9FZQ4I0
	/9VupDbM=
X-Gm-Gg: AZuq6aIwzVoIb/vWt6RFzvjZVcBQ+VAI4uCFxa9NS5/duW/SptT/b76Yf/8DWweAu6q
	uEpO+bdMVCTTtB+WHRh5nhFJvm2SoK9EtmNuGw0+3kiYO2dTRZRa1JL6rzl4cMkHBmcz+hB9jyF
	5ce+Wk1Yc+yKzvtpVz34a171ktOKGea4g+q3Q5rJJ+CGgUSIxLCQBuiOJIN5by5KfArPlQbUtCw
	+NYji6snfOqx9aRRs6aWly07X7lxLeGf57fyRVAUxd2VrqM91pFm0b766xpm/kbl4BLr30aigjf
	Ltvk6t/4kwo8TAilE1lpIayj93OgpMx7iCgz1+BjYtsP1s8Wj5YfdUXfmcZibd/FTnhYeKoSMmI
	cpvRpUKZ1rdnixwTkN76sU2V+7i2qC0P534qCDZJ7cYtUT2jnBzIRkyu8n7kmCd2PEkMQ8rM+t2
	izjv4V0uRDIymIe7x9nJxCHA06T6h5NmzNHNjPLuDjrOzjhKXSad5Y+XCMo7QrZHX0HfYKA7Y=
X-Received: by 2002:a05:6402:2103:b0:64d:1a0f:694b with SMTP id 4fb4d7f45d1cf-6598412bb6fmr4764375a12.10.1770616198379;
        Sun, 08 Feb 2026 21:49:58 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65983eb67e2sm2500254a12.13.2026.02.08.21.49.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 21:49:57 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b884ad1026cso611264466b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Feb 2026 21:49:57 -0800 (PST)
X-Received: by 2002:a17:907:9413:b0:b7a:2ba7:197e with SMTP id
 a640c23a62f3a-b8edf25c528mr512379266b.29.1770616197201; Sun, 08 Feb 2026
 21:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209003437.GF3183987@ZenIV>
In-Reply-To: <20260209003437.GF3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 8 Feb 2026 21:49:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=whoVEhWbBJK9SiA0XoUbyurn9gN8O0gUAne88a4gXDLyQ@mail.gmail.com>
X-Gm-Features: AZwV_QixpikWBJ4nDRPLGV9yEyPx_ZhzFZxN7fvv-EDUmxsROYMsqMMuVs1L_0c
Message-ID: <CAHk-=whoVEhWbBJK9SiA0XoUbyurn9gN8O0gUAne88a4gXDLyQ@mail.gmail.com>
Subject: Re: [RFC] pivot_root(2) races
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <christian@brauner.io>, 
	Jan Kara <jack@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, 
	Werner Almesberger <werner@almesberger.net>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76683-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.org.uk:email]
X-Rspamd-Queue-Id: 1A57B10BE29
X-Rspamd-Action: no action

On Sun, 8 Feb 2026 at 16:32, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         AFAICS, the original rationale had been about the kernel threads
> that would otherwise keep the old root busy.

I don't think it was even about just kernel threads, it was about the
fact that pivot_root was done early, but after other user space things
could have been started.

Of course, now it's used much more widely than the original "handle
initial root switching in user space"

>         Unfortunately, the way it's been done (all the way since the
> original posting) is racy.  If pivot_root() is called while another
> thread is in the middle of fork(), it will not see the fs_struct of
> the child to be.

I think that what is much more serious than races is the *non*racy behavior.

Maybe I'm missing something, but it looks like anybody can just switch
things around for _other_ namespaces if they have CAP_SYS_ADMIN in
_their_ namespace. It's just using may_mount()", which i sabout the
permission to modify the locall namespace.

I probably am missing something, and just took a very quick look, and
am missing some check for "only change processes we have permission to
change".

         Linus

