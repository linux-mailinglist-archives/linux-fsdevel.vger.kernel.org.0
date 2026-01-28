Return-Path: <linux-fsdevel+bounces-75699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJEMHdu2eWlHygEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 08:12:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 788CD9D994
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 08:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB4E73006921
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 07:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FD8325714;
	Wed, 28 Jan 2026 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUubFZEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA02E8B6B
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769584338; cv=none; b=By6xHm48NRh8qFaIyJKJir6f7bRJZtoT2xnA1fhEIMrRx47TFw8bkPyoIE3u6Z+DuaR19vrJmtwhlpQs1cvGhca+pLvqOyXGmRMCdjBv0g/KAyQhe6nNi4Ya5OZxD1v1hbALg4ISYxvVQEYY7jONTVelZ7yd5XRpSiBfnxUveg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769584338; c=relaxed/simple;
	bh=muLONNMstIKkJHu3WR3lD+z5+kctvlw9FA4jPF2gKFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnLlbSxU/Cs7Pcpk+8/BlqcuHZZ9670wLD1+JwdgJjLndaXv3VGOvlg409HZP/uIHw+Fu26+MyKNQTcEgUUY3MWoKHjmc9rGrFp+0igEG6JUZT/xe9VU/KPCw+ZtgWXLt5/nudtAj2aocip06W0EZrR+2WFPRqrlDuvJh3zjCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUubFZEc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48049955f7fso56053435e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 23:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769584336; x=1770189136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yupyqgTinsJTxzanc9/JLcyGpyZKwhADJIofZzWDenQ=;
        b=nUubFZEcRO9REn7fXjU76vNhLMOxJFcF/TNcylEiK/OWT/nibxUCF4C2insVTDrG6F
         4VZ5iJC6lf4Ffe4vJ57TK3tENSDZTaWzjUOVz40I+hcTT6qHH+OvoMIGt3fdva0XpYCf
         3Hh4JhBZAx8GpqunmxVi0ooaqViSWjcLoZpNc+5Htj3GmuAEdlMdSM4+M50na/yy2mrf
         MbL+0oTANQmb+Ob1BaOJMQysjT1eig5Q0/yOWFHy4wGkbiYqjtqf0OMA2juvYMqzejtj
         swdT5vDgbbGredL+BQE50G/xI1GNVyqZOieqANZDVIltUNHxanBhWIoLD2SNVmGovCqt
         dNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769584336; x=1770189136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yupyqgTinsJTxzanc9/JLcyGpyZKwhADJIofZzWDenQ=;
        b=hToVsaSQ3p0O/AAMKCFjXoLnSe8OE0GMmbJNg0zS20SdyvVFfefA9gCW9fogVjYUjX
         tfAmo6Mxx6x8aK+DToxVxDOPeW/EXoVaAmr5uU835jbncRycjG0p5u6lO+Wqujo9N4Tm
         Lrv4O+XFUC0kJWFXQ7o5kHOhzNxBKSSu552WbSq13BcKA/Ad0UV1JMRIdTXRpYKZL+Tt
         CH4fqp24mI6Oj6rgPC5Af57OwclaSfQ6P4wGMnSusXY1HfXga4VdxYcTmvjrn8jXIL22
         2LZFq7hyaw2q0N8L6YjX7V7sU4eiYEzsw95U2dXka5/TbY/0pysOR5cn7JEnQZ15k1P1
         qKfw==
X-Forwarded-Encrypted: i=1; AJvYcCV+t6PIkWEnGMXoCO00VxEh84XqWOYmhm7qOlHuj22pbQ0lb7okxAy2sCyuB1L/AxWZnZLhEJW6s1h7R6Q4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo9Krcuu0SMJKmktnxwNzyTwhshLRxaubSp+qe8kaetmRPZdPN
	zW/APP3BUcqmXaRxbieESe9/rYFzO00bUMDZQ+I9PY5plRuiUtTBSpBp
X-Gm-Gg: AZuq6aKzwf8bJNtS2qVZRvLLU3MMYF3Xg9QeGPhWwNUK07VctqmoHEgJ+3iAvYuzLSk
	cGg4lsPD7IFvZbOozuFsAeP5c6gyGyuvWSzyGR6mN9RofmIYnPK7FIk+WEabliGCWxuH0PLkVkM
	659VOWhYTLPglPi0V0MVuTOqXULD2FzcWJBPv++R5EgXLGzTKwjULGvsV9FJwEqfJrWQpKLcZ3T
	RdjT0yPAZDRupeT/fy9IuZeaMjD+PWVefj0e8Rg5V8exah+oss1L86c51kt/Wy8VMhnYt3UwDFR
	NNOEUgWs19prAUH2aiEMmLs5meCTj73tiX5IwhAbJ0eCWGdVx1xvZszZdwlSr4C29wUbQlMzmvn
	GVW7R/5GHwPagD7XCPdOU82KUeqLHTDaxa9rif5AryfK1XJ0vguGrvKME4L4oikG500BfAUxf63
	7V/r4iuHM8wCbcHuj9riE+L8SzoHCM+gmRzAzlChFT6misRbuAy8z5KrTCk5I=
X-Received: by 2002:a05:600c:4746:b0:47e:e9c9:23bc with SMTP id 5b1f17b1804b1-48069c5547amr55469465e9.30.1769584335773;
        Tue, 27 Jan 2026 23:12:15 -0800 (PST)
Received: from f (cst-prg-85-136.cust.vodafone.cz. [46.135.85.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806d98c8desm31914585e9.3.2026.01.27.23.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 23:12:14 -0800 (PST)
Date: Wed, 28 Jan 2026 08:12:07 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
Message-ID: <vhq3osjqs3nn764wrp2lxp66b4dxpb3n5x3dijhe2yr53qfgy3@tfswbjskc3y6>
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com>
 <2026-01-27-awake-stony-flair-patrol-g4abX8@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026-01-27-awake-stony-flair-patrol-g4abX8@cyphar.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75699-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,arndb.de,dilger.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 788CD9D994
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:23:45AM +0100, Aleksa Sarai wrote:
> In my view, this should be an openat2(2)-only API.

fwiw +1 from me, the O_ flag situation is already terrible even without
the validation woes.

I find it most unfortunate the openat2 syscall reuses the O_ namespace.
For my taste it would be best closed for business, with all new flag
additions using a different space.

I can easily see people passing O_WHATEVER to open and openat by blindly
assuming they are supported just based on the name.

that's a side mini-rant, too late to do anything here now

> In addition, I would
> propose that (instead of burning another O_* flag bit for this as a
> special-purpose API just for regular files) you could have a mask of
> which S_IFMT bits should be rejected as a new field in "struct
> open_how". This would let you reject sockets or device inodes but permit
> FIFOs and regular files or directories, for instance. This could even be
> done without a new O_* flag at all (the zero-value how->sfmt_mask would
> allow everything and so would work well with extensible structs), but we
> could add an O2_* flag anyway.

I don't think this works because the vars have overlapping bits:
  #define S_IFBLK  0060000
  #define S_IFDIR  0040000

So you very much can't select what you want off of a bitmask.

At best the field could be used to select the one type you are fine with.

If one was to pursue the idea, some other defines with unique bits would
need to be provided. But even then, semantics should be to only *allow*
the bits you are fine with and reject the rest.

But I'm not at all confident this is worth any effort -- with
O_DIRECTORY already being there and O_REGULAR proposed, is there a use
case which wants something else?

> 
> > +#define ENOTREG		134	/* Not a regular file */
> > +
> 
[..]
> Then to be fair, the existence of ENOTBLK, ENOTDIR, ENOTSOCK, etc. kind
> of justify the existence of ENOTREG too. Unfortunately, you won't be
> able to use ENOTREG if you go with my idea of having mask bits in
> open_how... (And what errno should we use then...? Hm.)
> 

The most useful behavior would indicate what was found (e.g., a pipe).

The easiest way to do it would create errnos for all types (EISDIR
already exists for one), but I can't seriously propose that.

Going the other way, EBADTYPE or something else reusable would be my
idea.

