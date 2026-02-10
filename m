Return-Path: <linux-fsdevel+bounces-76805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIZzDrWgimniMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 04:06:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5369116A8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 04:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A66F0302D94A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 03:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3A92DAFA4;
	Tue, 10 Feb 2026 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sq2/u5u/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47D278165
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692785; cv=pass; b=q+quISaRnsctS89ZwkRp6HpWqAE3BRyJLPoxJbgcRwdDz1AL7k0uT52/+gS7ft78VUUXboypQSHeGrWiqM/FuAU7K9IaIjC7sNB8Qn8nDZoCDPMoc9ZI/SwwmMwsnnWWjuX2ABY00x2iplPkQkdY/45MgI9NkKCuHjBfI8b621g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692785; c=relaxed/simple;
	bh=zs2JbvSIqeHpuWlBVpOIszGZrAjqw0xVXh8hmXatvrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1yEO32Bj3WNqRJS8jMp/klAcINJ3ti2kPke8ElkGxU9na0XgFUmbB8SkvNyz6CgDQpxRYTmQhnPoQWR2n/xGc4RzFaYRVnQV+sxhg+5CvEsdzSX3t7EN6cUAEnqS8d3SWMFYDjpecBZp7wQCftymmO1EVyM5W8BbxfW3zMNZo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sq2/u5u/; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-502acd495feso42944791cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 19:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770692783; cv=none;
        d=google.com; s=arc-20240605;
        b=WptcrYcHt2BrKBMO6pZ3d7wafNoUhhNNezb060J1MgPWDwj6wQ6Ww41I8dUvSjeu6o
         OPLFBrICCS0LQFCIEA3ltIVTvcHPr/2oWvUlcQ830RJl2bgXDEtJ1GvLRSrHI+hH8fo8
         RIW547NZI/OlE8FbcqlFnzpRMKKJ8kfbE+lgHAZDUImRJQ792z8iSU6CkUEKH0fLdweQ
         jblw4UOHOMsL66ibcGHUbvep6BBCzEETnzCjsdpbynHKygrTqI8/V4JjEJpoAh2JcAyH
         FC+lUp7AgxdN4yc30sIQXUWLF8vkA05ELwdZyRVVxEcryTmbbjRF2mSL9nrsxFwi7nex
         B5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zs2JbvSIqeHpuWlBVpOIszGZrAjqw0xVXh8hmXatvrY=;
        fh=WyoatJVPo8B2ZTllaTIzUDnjDpf4RXWEuPj9WwrlHHw=;
        b=aCRVrcsGGFO/HeKaAK5G9fnFnSBjXgL2kk8NTFVSYPZjsH2WbTnbtTNLGNmez6B5m2
         tIBZfJE9NgTxhnf2tNOm0fdaqxZyvoS1jo9kTkdCsHnrDo26Xh+lWki8OXgsw8m957Iv
         02mlCbYUv5TTqN60w2y5X28x7PRN+AClQ3ZQW8A7FL5GWdrlLQW+0oGmLh0UFD+ye8x1
         XkiH5ykHzZ2xvyJC+zVa21nSsUAgPd9xxtjQEAEsjSbcdrfz6x/CRFOKU1s4A3aS7D8u
         Gl36XK7MG4RyIHPUkieOGkwuRtveqY44ArY9zGPJAGsCHo4cWzvb9e/vll5Ix3rnlRVk
         XMSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770692783; x=1771297583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs2JbvSIqeHpuWlBVpOIszGZrAjqw0xVXh8hmXatvrY=;
        b=Sq2/u5u/SR/Y3824UlkyKTDn+fQMmZNgxgCqKi7VEJUlJxBIWfL2h3MfPOxAHaCznI
         Z9AqS97gM7JwczGyrW6JlQOrsgSF7NbhOgwLrMp2iEDzX2Z51hxjehkO+olidzs1zL9j
         CpdIEhoilog5c2O0D7j+MgjwRxMkZR3GQ9RkIEzL5Ie8PHNPFqsYP/+P3fPgM/9ZSyXd
         ObuA26UsSUbJxaYsEcswwhVd3OEflgyMwUxZovKQvircRAnLx/1XF8w4JfaCIo9J4r2+
         s5PVxWVoB3jN+fO/H7pEcVZgqO2Sx+r5uemkXuwcUAMwrfv3rS/CtZ2SkS98fRUWpaof
         Mq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770692783; x=1771297583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zs2JbvSIqeHpuWlBVpOIszGZrAjqw0xVXh8hmXatvrY=;
        b=QJrnNSVV3pFtyb48B1gEngPgRjq/hjRtefxpLFgM6xT3oHUQQL9BCNdscoEyhlSTiF
         GFllJu/dClUWcRr5GaqnN6Ip5ULGRzAgd6hLXxa7oPNxCEYQPPLGWRWVHVrRh8YY60gM
         2Xt6b2YTilSADqpETFbe0DJ6P9sNtyl4D2hPzc5jOK3oV+J/32BoMKlTHCkvu7Ula1ud
         LsvR7bnYhpX4lull5hjG0XmiGgrmVUYPm1EXEo/qtWjekV8Y+/OrjLXXxnJF6juz6Vkw
         ZrCIuLl0h5jM2e/FqsqSHskIrswJ+A8pHEwYb8aW/aQg8ghh4XWWoiJjyqwoamAHCgCh
         r4ew==
X-Forwarded-Encrypted: i=1; AJvYcCWRX/B2zPGFaiK1jY2SRXn9OztJjdTuQQo6N+gil3+Ax1wo9FVYX2S0XfLBVhGsCCNtZ3V5wxNLB0VV1wwz@vger.kernel.org
X-Gm-Message-State: AOJu0YwzcMefPp9vc/Avbp/NNSUsVL/Zz7xslCEn7A/8un5NJibgGsIE
	F3AkJKaZNeuGLSeJPbAlFwVqkrLkYqggaAaY5+hoSu0VhaYQdjvaG5Ehox4QpwNd4XB4aY/zqyI
	ZII7D/TxC6K7lJkrMjI3KWzeznhkkw1k=
X-Gm-Gg: AZuq6aIZDxci+T9sgCJUK1KewqzWVf5Ki8YMRG4sh9d3uOUImJfjD1xc6PRD5opb/Mm
	zx3p6VcxZ+kThREqrT6Rc4FxSk2zKDfZedBtpHXKa6qnf5Ph47ojBq2OH4sLxR+tl0JVW/y+zLS
	f5M4jrzh3qcmuFuWP26PX6X5Vyif49vnViDTcYtCWiM2BWhJr8W4a96mmC96iGqHn6sDnr1YyUp
	uevx87rak9qyo1YwStJo0ViBAizawb0YeBH6zyDFu1ojPqeE4RhS4qEbRSm3gzZ5l09Vut0yqkx
	9Z4JTg==
X-Received: by 2002:ac8:5e4f:0:b0:4ff:c5f7:ece1 with SMTP id
 d75a77b69052e-506399957bbmr161017941cf.68.1770692783468; Mon, 09 Feb 2026
 19:06:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
 <CAGsJ_4wgG6-FvDbLw4De0r_vPO1fTH_69A2VyntabmS6H5ZM8Q@mail.gmail.com> <83e395c84c9bfa52f1abccf12ff6d39547d6bede.camel@ibm.com>
In-Reply-To: <83e395c84c9bfa52f1abccf12ff6d39547d6bede.camel@ibm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 10 Feb 2026 11:06:12 +0800
X-Gm-Features: AZwV_QhTXOQjAfDYIo7_EqjytxWr7_a25J4WmOIDz0_JDW-Suw5MsajhD5JzpZg
Message-ID: <CAGsJ_4wymvTimJrKoq1=PRmX6BMwKp9pRH62cQ_a06Avms-0XQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Machine Learning (ML) library in Linux kernel
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76805-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5369116A8D
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 6:07=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> Hi Barry,
>
> On Mon, 2026-02-09 at 18:25 +0800, Barry Song wrote:
> > On Sat, Feb 7, 2026 at 3:40=E2=80=AFAM Viacheslav Dubeyko <Slava.Dubeyk=
o@ibm.com> wrote:
> > >
> > > Hello,
> > >
> > [...]
> > >
> > > The continuous learning model can be adopted during training phase.
> > > It implies that kernel subsystem can receive ML model recommendations
> > > even during training phase. ML model proxy on kernel side can estimat=
e
> > > the current kernel subsystem state, tries to apply the ML model
> > > recommendations, and estimate the efficiency of applied recommendatio=
ns.
> > > Generally speaking, ML model proxy on kernel side can consider severa=
l
> > > modes of interaction with ML model recommendations: (1) emergency mod=
e,
> > > (2) learning mode, (3) collaboration mode, (4) recommendation mode.
> > > The emergency mode is the mode when kernel subsystem is in critical s=
tate
> > > and it is required to work as efficient as possible without capabilit=
y of
> > > involving the ML model recommendations (for example, ML model
> > > recommendations are completely inadequate or load is very high).
> > > The learning mode implies that kernel subsystem can try to apply
> > > the ML model recommendations for some operations with the goal of
> > > estimation the maturity of ML model. Also, ML model proxy can degrade
> > > the mode to learning state if ML model recommendations becomes ineffi=
cient.
> > > The collaboration mode has the goal of using ML recommendations in
> > > 50% of operations with the goal of achieving mature state of ML model=
.
> > > And, finally, ML model proxy can convert kernel subsystem in recommen=
dation
> > > mode if ML model is mature enough and efficiency of applying
> > > the ML recommendations is higher than using human-made algorithms.
> >
> > Hi Slava,
> >
> > Do we have any concrete examples where an ML-based proxy,
> > together with its userspace ML agent, has demonstrated
> > measurable performance improvements over well-designed,
> > human-crafted kernel algorithms?
> >
> > Such examples could be in scheduling, filesystem I/O, or memory
> > reclamation and readahead. I think having a real, data-backed
> > example would be much more helpful for this discussion than
> > reasoning about an abstract framework without a concrete use
> > case.
> >
>
> This patchset [1] is the first step of declaring the ML library API with =
the
> goal of discussing it. As the next step, I am considering of using ML lib=
rary
> API for implementing two real-life use-cases: (1) GC subsystem of LFS fil=
e
> systems (NILFS2, F2FS, SSDFS), (2) ML-based DAMON approach. I see multipl=
e
> potential real-life use-cases of ML library. But let me start from these =
two
> ones and, then, we will able to extend the approach for other use-cases. =
The
> goal of this talk is to hear the opinion of the community and to elaborat=
e the
> proper vision of ML library architecture.

I=E2=80=99m very interested in your real-world use case.
If you have any early-stage prototype code that demonstrates the full
flow from user space to kernel space=E2=80=94including both the kernel ML p=
roxy
and the user-space ML agent (for example, for filesystem garbage
collection)=E2=80=94I=E2=80=99d be glad to take a look if you=E2=80=99re ab=
le to share it.

Thanks
Barry

