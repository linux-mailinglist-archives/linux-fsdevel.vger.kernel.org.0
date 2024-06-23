Return-Path: <linux-fsdevel+bounces-22199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A968291383D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 08:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C801C21240
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 06:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867620332;
	Sun, 23 Jun 2024 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R993nS54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3458C11;
	Sun, 23 Jun 2024 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719122468; cv=none; b=PTUmBY1dmoLJkNH7hTLa1xsNk4SjKRW6WTh4luJOhglupT9Y5dXtDWj7Xkn5ID0Sw6296myI4wjOyEAcByhk8Lb9CT7ND/3Lu691qA49c2wYGnj2/h2QSe1P2AX91DLPMfxtFZCKDKZIKLSIvmgt/VmieXQ65eQ/rSgRoDdIeMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719122468; c=relaxed/simple;
	bh=7tBYjcPASrEA9EIwWbdTX/mLPmfYmGFhdjPrPv9CTiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQ1+YiKUYDt22Lm5MDnfhUOjUdDxsDQF6eh55HOL7G3Yojxq4svKd9adIrMLSdYjNTQ+L+CLHOLZaQwEaAQZ12nkH61i1AmuBGTxsV3HfvxoXD0daye5blAmYFKX+k/lZWwUWoz0qRvq5i3vI/21ybb2Fa6RqMjV5iebl0IohUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R993nS54; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79baa4e8531so326304185a.2;
        Sat, 22 Jun 2024 23:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719122465; x=1719727265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=639B1VhzkVRiQ3egX05fSRdoRLJZKUd3UI9/6wfJ8lw=;
        b=R993nS54gBQpPnXksw45EdyenrtLPYB3PmH6lO7ye4DAWTstO2fNdwaDSKS50tzZMG
         G2SRAG/e3ADXA7/Uw+En4WEJ66dhxJhNIQj/C4JFGQrSAOCyC7DuzK8jFHCvSxJNXG6B
         hy7TfF/cBCwJorUHscfJETTmJufxf8caMyMvMZF2ywAWqKTcSRj0h6JDausIwcfrDElH
         0jbik2TCCgi+eBaq4zVfXb4vbviX2AEWlrCriSPCj4jSeejjaDCweHM96sJ15UPln9M7
         YNc5PUDAZ3RrdecTx7vsdqVzU/yIpirvYSExFO00Q5l8q6oiR5vCeiR/dXK0W35XcUln
         txmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719122465; x=1719727265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=639B1VhzkVRiQ3egX05fSRdoRLJZKUd3UI9/6wfJ8lw=;
        b=R6r8PO9gl32YCX79nMEJ4J4RZYcyICnnjMd9X8xtXAZt+8gC+BrTUfQPg/RSZubuzm
         77TSRNtq8DBd8p+a8aW7TrrjaB2lY+Y/WP9xbf4eSD995/uQSQMigMRpdH85AbevF6F+
         B3gz6UbxmkkDzL8zRj8DDspihdEac6GCkBkSQRIUsw6R2cPByZRlRutf86ccIL1ncH9/
         pnN322M9Dq2JLFSY5TKb4GIpg/VPrV+CPcZsZODs0BuATu/Glw1v1YumsFv1sCzCqU5m
         FdOaKbDXukPSySg/aZ9fwDMewmzKSm5s/W5Te2fMF2Z+wve+iDof5FaczqaPX1uuqHFE
         GsOA==
X-Forwarded-Encrypted: i=1; AJvYcCVajQzy9Hbni0oxBpL2+OOM9ET+/fAjwYME5PfBc+rJF7nxjOuazS+nlkyWZXHMY4Kx0wsjDJoBysiuriAY+Z4GGPlf/T0Wbr6OP1PvJVa4JcdYEP8Kqz4fTP9jWmsSsjh8kxFBs+ZjdL71MwpcUEeFOCuRiyFTUxxNSzDeDsvhB2vqzwjKstF/UnkEPBnDA83PfMDq1tZVzcYwo3jGlFAqx5AI0hZYArDj7uEVFCmG84oGMYiqabRRc7scJoXm03f7w7XjjQKmY+s1rz3yZ+sxNWoLx61WR6fj/RUJ1ddX+oPW9plU8FPW8N6KoqP5e5VjuxvA5w==
X-Gm-Message-State: AOJu0YyBC/us2QSiJofjJQ16RCW7Jk0Es7RtiShpUz1F5UZdlRFUhfhN
	+lmnymsOwfAmr+0pqBhbPzXxambXIU6iILsCdC86bwcsoATc33cOarFvSQFnoF0IYrNmyaQ24AS
	R9beyfGGncsFCOdoWeLOi5B3hlGE=
X-Google-Smtp-Source: AGHT+IHcXR+ehU+k0C/NmM/DLF8W1FSfgc1FOoi+9SruG7tbvTjl8bMu8+dVhBmSjLDe3SkqoqwwTUGvFNLK0f3vidI=
X-Received: by 2002:ad4:5228:0:b0:6b4:f644:9d87 with SMTP id
 6a1803df08f44-6b53debf738mr17899726d6.21.1719122465581; Sat, 22 Jun 2024
 23:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621022959.9124-1-laoar.shao@gmail.com> <20240621022959.9124-7-laoar.shao@gmail.com>
 <ZnWGsw4d9aq5mY0S@casper.infradead.org> <CALOAHbC0ta-g2pcWqsL6sVVigthedN04y8_tH-cS9TuDGEBsEg@mail.gmail.com>
 <ZneSWDgijj3r0MMC@casper.infradead.org>
In-Reply-To: <ZneSWDgijj3r0MMC@casper.infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 23 Jun 2024 14:00:29 +0800
Message-ID: <CALOAHbDvyBn=yUABT4G6Egne48cQqHDM7bvuBeKFmbSA5fhg4A@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
To: Matthew Wilcox <willy@infradead.org>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	akpm@linux-foundation.org, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 11:11=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Sun, Jun 23, 2024 at 10:29:30AM +0800, Yafang Shao wrote:
> > On Fri, Jun 21, 2024 at 9:57=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Fri, Jun 21, 2024 at 10:29:54AM +0800, Yafang Shao wrote:
> > > > +++ b/mm/internal.h
> > >
> > > Why are you putting __kstrndup in a header file when it's only used
> > > in util.c?
> >
> > I want to make it always inlined. However, it is not recommended to
> > define an inline function in a .c file, right ?
>
> I'm not aware of any such recommendation.  Better than putting it in
> a .h file that everybody has to look at but nobody uses.

Understood.
Will change it.

--=20
Regards
Yafang

