Return-Path: <linux-fsdevel+bounces-12623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7747E861C6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 20:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150501F2489B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 19:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6CC1448E9;
	Fri, 23 Feb 2024 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpCi4S7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E397143C7D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716414; cv=none; b=ezsKiLyTzljNNWKDwVuXyI6WXNW2CZmTfrg+J0kTL9dYjAyNSyHI95kGTavlDjEsKWfZuNXP2qjX+UCWWfVQzoRdsBq0NvQOfg8KuaIDHxlNq9agCcv7L47A0H/pG72Td9J7jUF+JDiIKjzTvsXflVatP4RP0/TmZ7cEsdz3NK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716414; c=relaxed/simple;
	bh=R6zUV9LQ644WPBwU2nAdaKkCRupl6ITF2pP4ziWZMV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBBSq6NPYEYjThQK3zxT7RlDmtwBA+kH+eiDQCcUSwIPYIM6aH7LrpaHyZJ7HsrW2GoJaxHD+/gF0HmVn3JAwvW2ySpkqnSHDkw1OdGN9QdEbevu48b7Xg7VcTf24Rt46Ipeq0arjixZVOev24UWHRSk0Ox1sen/Vl6VFb15GHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpCi4S7E; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso1353635276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 11:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708716412; x=1709321212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6zUV9LQ644WPBwU2nAdaKkCRupl6ITF2pP4ziWZMV0=;
        b=OpCi4S7EIle74AF4FZHaIEyLZXNxInq/DezUptdf3Dtyp+NkJo+dehUdZWG2qusLIi
         bt8qF0ES+0LRUSPqWcX3BhMdXjaIdmafbMwRL9IPIvSNXVQcek1Jj0OLzR/dzhi+w7to
         dAXnDGoFer1u6qbebk7TeotLVef6+Rz6kG/IIQYYpJYnHAms2nBdwshn2RMbFLixh9yV
         eZZ0uK4Fjh1XP2wbWR9k7FrQhpvdHVp19ivE5SZkX2rlJbmBquB+IxJZ7azGQfDfOpLl
         DtRq+AvFDvwCsisaBmPWMyn88TDIfYFY/bu64HZB+J1w9y9ZRnJSSKlJoV24LCl5T0vH
         ZewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708716412; x=1709321212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6zUV9LQ644WPBwU2nAdaKkCRupl6ITF2pP4ziWZMV0=;
        b=kJvWtET7I9Hb0VZfDnSuBFPLnHFXslcZ4a8oTZpw/ftLo5mNFUNFaGermZ1mfkRr7z
         CW8J6r1tXCkk3NuIX0i3nrhRzK2WUwsT5PXHlFNu8a66DXX3w0Sgzeb4T4p9Xk5mOT+D
         WBKGHg4sM75m6UeywTmTzSdR/eM6JeBWrLAqxpUKKknCTixpmodjgwr/0s3ySpx0cIb7
         Q3wtkqGjLphj+08t0V6dgHnhCrpSz/F2JYNASIq0blGoZJ+KXPkDIYHiSxDen0n7aWIu
         lkadykcVD+WZ3fZgJInmak/TAwuZIgd4yKViHEQGJ+oHDWILLGYEBXS2ubzsSzukxgaQ
         ZxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjKrOOcfyTKvCBH6vBtNIzTJrmpzlBKKOGAUfc/tiE7msBc78KhrmwrtwRH363dadpYArX9dJWJIxJcq3sVY1N4mMtvT+YQ0L/avIgPg==
X-Gm-Message-State: AOJu0Yyofk2xlIMAfXyjlY5CjvK+6sKMCuN9X7Rro4MPOnO9jtPpNj9d
	jAlgUjSNPYCzAsEEX/w/5sOrAZkRXK77LRpBdFE7yF7oV9cRpvXu+mguSESaYlx7P2ZeceDR6ym
	U8cal4X7JYb0Ds8SIct2Myyv2sWiMH4uy3NY4
X-Google-Smtp-Source: AGHT+IE/Pl6hrmaYgXKRMYbWWj3alWqUpkDIYPYsJjZVZ7mPx6TO4HEVqSuGco97bbBAS2NUd8BFNQPQR2paQWXSoCg=
X-Received: by 2002:a25:2653:0:b0:dc6:b088:e742 with SMTP id
 m80-20020a252653000000b00dc6b088e742mr843579ybm.8.1708716411749; Fri, 23 Feb
 2024 11:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-7-surenb@google.com>
 <Zdc6LUWnPOBRmtZH@tiehlicka> <20240222132410.6e1a2599@meshulam.tesarici.cz>
In-Reply-To: <20240222132410.6e1a2599@meshulam.tesarici.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Feb 2024 11:26:40 -0800
Message-ID: <CAJuCfpGNoMa4G3o_us+Pn2wvAKxA2L=7WEif2xHT7tR76Mbw5g@mail.gmail.com>
Subject: Re: [PATCH v4 06/36] mm: enumerate all gfp flags
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:24=E2=80=AFAM 'Petr Tesa=C5=99=C3=ADk' via kernel=
-team
<kernel-team@android.com> wrote:
>
> On Thu, 22 Feb 2024 13:12:29 +0100
> Michal Hocko <mhocko@suse.com> wrote:
>
> > On Wed 21-02-24 11:40:19, Suren Baghdasaryan wrote:
> > > Introduce GFP bits enumeration to let compiler track the number of us=
ed
> > > bits (which depends on the config options) instead of hardcoding them=
.
> > > That simplifies __GFP_BITS_SHIFT calculation.
> > >
> > > Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > I thought I have responded to this patch but obviously not the case.
> > I like this change. Makes sense even without the rest of the series.
> > Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thank you, Michal. I also hope it can be merged without waiting for the
> rest of the series.

Thanks Michal! I can post it separately. With the Ack I don't think it
will delay the rest of the series.
Thanks,
Suren.

>
> Petr T
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

