Return-Path: <linux-fsdevel+bounces-38471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5AA02FB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 19:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E18D47A1819
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4C1DE8AB;
	Mon,  6 Jan 2025 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G5/7lZ5L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3A3597E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736188001; cv=none; b=Ngk4qaMgtjQQANgHj4PnrWzoP+nMbm5jztNqxVTvUMUi2WQi9GzptNVt+i+WdqtWnQwJvJQ9C4h8ktXcbKmfg4anXtJROtVlKuUMoVBk9aDTCFxayQlrNkDv2UzKUyIldueImDIHjZNYMeDaFpiA3nd4UHCqqh8IOTu9+em84FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736188001; c=relaxed/simple;
	bh=FdEgHcUa+TyS5MxqxyLdnmrglOiO19/eomjh4RmrGzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzOQGXM1OshkvXRfOoqsRkVOJASY94/c1riQbym0AwYs99sYNZbIdUYyZAxOfoVDgNZ9cf/z2his1u24LnJFnkNAkDoZ74WFzLEcDVta6BUU9zDbvPNxktoZ4X+4RCDx7soLsf62KHuVI8sNIXiRkMAsGOTJVYAzSONxbdhDjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G5/7lZ5L; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71e15e75717so1328399a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 10:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736187999; x=1736792799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXrSRS1etO43ivLqxy6UM/j2BEkIv6LJbbDAsPExvN0=;
        b=G5/7lZ5LA5XhdlUw9M0jvAnnaxA31Nw1nYPGCJpQnpNHwTn/mu2BAves9tADx54wWZ
         D7ulTUKHlLCZmeYjq4g3wLSEwhCRCtKq3hDjr5unLxqZKO6ZbikNwxy+OByOxHw9C6lR
         6IZ916oXzc5fj5laELIzUBVkOdofSPV0h0wPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736187999; x=1736792799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXrSRS1etO43ivLqxy6UM/j2BEkIv6LJbbDAsPExvN0=;
        b=JSBwcOzEy7EaHeFH/gmMexr1evxRawIKQOWHl3WnGa6Yqj0gnvtFO2TCpslNjXfUrJ
         g8S72YrpT0EQK5082L8z+HU5jkm91p4Bfc2XbFsMbCG6VOZGiQxtL3q4TCX8JhqRs67U
         cddLRB34/GnRbpNp3Iol3E1n8iWsViGt6pKxXr04I+Etkot9YKUsrOyuJ6swYKh+RsH3
         Fmig7mpkICCRnxXhGmxQ6LHM7quq5mdcOZMsJTYiUv886CDHmmRS3/GA1DRD3GMQGjyA
         Y+JeDZg1f1mmht3CWAeHiElw2UvusXrCk+AL/DzB28GoDv473wSnUwRbcozBLku1CsOm
         Ri+w==
X-Forwarded-Encrypted: i=1; AJvYcCUlXeYQ2iHvVqNwUjjY2gNz5p8MZ2j43QRYp2pipa5nC3U17m6t1kprPojnmOT9Ufmy6Ax3FXEUOAS4KaMd@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmJ+OaNqFjLV33oADdh9quGL4z1k2b9/ll2cG/azYAvEvSzY+
	2VgBdL6qRBcES9F2F4BO/P0H+LhK9B2CrqDFJ8PZq2A55jpt3GEDEjZa1VHnMqWta5DlN0uYg1+
	wfnNxmgRiTuT2U9WNj37rxYGb5hTkQGc4n6+V
X-Gm-Gg: ASbGncsof5yx1LPtIRq3Qva8T//CsRG3AUf0FxPoVJVuv01EmXC8R+PiUtLSwcPZj/p
	673rm1Ock03Vb5ruuSuNhi6ZfZYkwLkPFuuxgVBnmtZU5lt9dVzwRnAqAJ6R53FSgOL0=
X-Google-Smtp-Source: AGHT+IE8p82py8jxmMvLIqhmZwO1SpWspYcZlaaDlXjw86T5QXXTzLjS0dO5FcxogIabP7CFgtlSJ6PXzCt14gK+9qc=
X-Received: by 2002:a05:6871:a105:b0:287:2cbc:6c9 with SMTP id
 586e51a60fabf-2a7fb17c51bmr12092971fac.8.1736187998596; Mon, 06 Jan 2025
 10:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com> <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
In-Reply-To: <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 6 Jan 2025 10:26:27 -0800
Message-ID: <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
To: Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Kees because this is related to W^X memfd and security.

On Fri, Jan 3, 2025 at 7:14=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Dec 6, 2024 at 7:19=E2=80=AFPM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> > > +             if (is_exec_sealed(seals)) {
> >
> > Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's execut=
ion?
> > I've not tested this scenario so don't know if we somehow disallow this=
 in
> > another way but note on write checks we only care about shared mappings=
.
> >
> > I mean one could argue that a MAP_PRIVATE situation is the same as copy=
ing
> > the data into an anon buffer and doing what you want with it, here you
> > could argue the same...
> >
> > So probably we should only care about VM_SHARED?
>
> FWIW I think it doesn't make sense to distinguish between
> shared/private mappings here - in the scenario described in the cover
> letter, it wouldn't matter that much to an attacker whether the
> mapping is shared or private (as long as the VMA contents haven't been
> CoWed already).
+1 on this.
The concept of blocking this for only shared mapping is questionable.

> But you're also right that in the scenario described,
> an attacker might also be able to create a writable+executable anon
> VMA and copy into that, or map another memfd that hasn't been sealed,
> or stuff like that. We can block such things - but not by only
> providing sealing operations on individual memfds. I think this
> instead requires policy that applies at the process level, either
> using system-wide SELinux policy or using process sandboxing APIs.
>

