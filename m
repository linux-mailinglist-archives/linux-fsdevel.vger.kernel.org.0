Return-Path: <linux-fsdevel+bounces-46271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D260A86066
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC331B61A3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EC718B47E;
	Fri, 11 Apr 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0+Wn/h9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335212AF11
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381251; cv=none; b=TOdFKkEStyUnju5FCUU2Zof1qSjePYnktULtcBXHI+hhIdHVySryCPHdUAKakBTTw2/uay/gArJWyUfQ+/amx274GybVYPg34VmjWQ1G3D3U2xBJBhvVw6CIog81OcZDZ2Km/alCCHxSGFnR3Ptk9XN7GU75VNmVzs2cWoNYEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381251; c=relaxed/simple;
	bh=0sSLM8Gl1SSfcycmM/UtlknnQ4e+BUVsux/kF0SISqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuqPqgeZ33dKLqKrMcFcmnAG1l9bHad0mzHPU5RbVvwSycDaTECWpSyv132Ft3b0nUj0T6FnSBf0l0/Mo8+4EQINhTUDP0KidzxHYn34+S322KGvV9DuHlMUw9cr2JwtN/fgVbQSb8mx7n2BlydiN+NrddGXHMYjWkki017XNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0+Wn/h9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744381246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GP8/HtUHIEVDUJEVLPkaBWTUMFy21m2j5eMBYPZlbWY=;
	b=a0+Wn/h9hA2oGK1SHRqcpbUuOGI8FScF0cyW5hSYRe1E3R5mLJuF+DG6C07XxMs8AoHyzH
	CgSZGOY33HoJJE6j+nKEvFWlO5TV1/11LIRZpnXkSKX7bPUFA2O8i4PYsT12EUEg51tuIK
	NOzlsKdDHTaiqqDuytCxoUSEfX6Oq+Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-8WU4JSEkNkO4-GLP4utSNQ-1; Fri, 11 Apr 2025 10:20:44 -0400
X-MC-Unique: 8WU4JSEkNkO4-GLP4utSNQ-1
X-Mimecast-MFC-AGG-ID: 8WU4JSEkNkO4-GLP4utSNQ_1744381244
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5e2a31f75so595541785a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 07:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744381244; x=1744986044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP8/HtUHIEVDUJEVLPkaBWTUMFy21m2j5eMBYPZlbWY=;
        b=A2ElXEMWTbHeMBhfQDa1B7KY7268Bi/3cD/w+a3ctkillBnB5ShnWELQolw+mYfF4h
         UPzoTc+4InsQ3/5E46JD8fVJznSWlaL2B2cPDjBvtAdYOwCiva0orKS4SYdsz36S28i/
         3i7WM2YqHypLG6u0uxqfuaO8Up+SksQaYF4yvgqGKj2EizcZZJLPRgbiOYMRkd/4IS/p
         8agnnWWgF1YkGaI+fVtl3g6Xx6LCDjSZomqWn0OPmQ8gRo4OEQfdZYpdGFSuC/QHTfg1
         VkGQWSZijWvBWxFiAc9VvLeS6SGkCvssVUITtyS1sgVb12be6XTmwF6ZZwJ2BeuIBUkJ
         KB3g==
X-Gm-Message-State: AOJu0Yx2Q9AGu8lSIoeKdzNK/T6Jkrb4owXVkmaxKnirHtV7U0JuxRxs
	6npF5ioVd7jQWLcUTClDvTaXz7jZ2ncsuFxSnkAdLDcCsxNtWcQIWvX04Yy5TTIygYSWXl4HoV1
	XqPkwdLCKnOoNUQsvrrzI4D8NCC53ZwTPzhYMq3bqo4nB+1TIxKBbvopsmzrKDlBj7h8o+8WR9m
	Jqh6UuzplYFv4tJIaVZ1tFddpFWmXQZhuHypCisQ==
X-Gm-Gg: ASbGnctSiblBV8oKgNcYe4K0kUbpDVAI8IGAPJfymklJfP9OUsfw9uGOMEqW8FKEyjG
	ilP0GgjyuiLDOPDZRkixvXAqPvd6aqQ8a0sFY/GPzRcka7vycI1Da1FakMxBSCdgLMXU7
X-Received: by 2002:a05:620a:4555:b0:7c3:d5a4:3df3 with SMTP id af79cd13be357-7c7af0e4069mr446714385a.34.1744381244180;
        Fri, 11 Apr 2025 07:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE87/SkmJqkCTFo3ondJGkFj0c7IjvtrQht+ufW53KKYYwMMEMEB+bhas8EXXkb6Qb8MJd6901LxjVSU8qgMcU=
X-Received: by 2002:a05:620a:4555:b0:7c3:d5a4:3df3 with SMTP id
 af79cd13be357-7c7af0e4069mr446710485a.34.1744381243833; Fri, 11 Apr 2025
 07:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cad2f042b886bf0ced3d8e3aff120ec5e0125d61.1744297468.git.jstancek@redhat.com>
 <20250411-umlegen-herauf-508fe182fffa@brauner>
In-Reply-To: <20250411-umlegen-herauf-508fe182fffa@brauner>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 11 Apr 2025 16:20:27 +0200
X-Gm-Features: ATxdqUFDVkes1gAHo_3pSyiyrwIAhhZcJcFcsj7AiggBUI7bmKdbRteKcHOEm_c
Message-ID: <CAASaF6yT=YbDfnwczWSEiEkn+evkWCPF0_MmO3OKCEmuFOG32w@mail.gmail.com>
Subject: Re: [PATCH] fs: use namespace_{lock,unlock} in dissolve_on_fput()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 4:09=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Apr 10, 2025 at 05:05:42PM +0200, Jan Stancek wrote:
> > In commit b73ec10a4587 ("fs: add fastpath for dissolve_on_fput()"),
> > the namespace_{lock,unlock} has been replaced with scoped_guard
> > using the namespace_sem. This however now also skips processing of
> > 'unmounted' list in namespace_unlock(), and mount is not (immediately)
> > cleaned up.
>
> Thank you for spotting and fixing this! My bad.
>
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 14935a0500a2..ee1fdb3baee0 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -1830,6 +1830,8 @@ static inline void namespace_lock(void)
> >       down_write(&namespace_sem);
> >  }
> >
> > +DEFINE_GUARD(namespace_locked, struct rw_semaphore *, namespace_lock()=
, namespace_unlock())
>
> I'll call that namespace_lock instead if you don't mind.

I don't mind - I used "locked" because it's easier to grep for, when
it has distinct name.

Regards,
Jan


