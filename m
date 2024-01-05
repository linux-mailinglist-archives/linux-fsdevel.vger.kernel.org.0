Return-Path: <linux-fsdevel+bounces-7494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC1825C5A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 23:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96801C23AC9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 22:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50E631739;
	Fri,  5 Jan 2024 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1IwPm2M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6E225D3;
	Fri,  5 Jan 2024 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so24884e87.0;
        Fri, 05 Jan 2024 14:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704492427; x=1705097227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWsveyTOHuX8GqJmXn3UhogbRyO+/xi3/LHv2audUfc=;
        b=G1IwPm2MwSKTDuxsmf/n8R2GoNef1Ecek6L2k4T7PtsEe9zRyDKTF2gv9kZRbr6pAr
         ZeFkAFjef4ANm0LNUNjGBIcGqKiL5d4J3vbtQ4WAMDzlfE6ucL9g4oCRjhcQIBvXFYtx
         ovPaj+QhGURPt7xxJzYxdCdGijkErsi51grVZmcx0zt3HXtcKwaosvLg0jGepJOfbHVk
         ILKkp3By1izlwQeevVZEvpujikmBf/VCkw+ux7dzkFp4aIP6fSQvEAcHPQJcLKCGMQtJ
         DeypJROrT4eYR5zUjdlVLfzSTt29Geky/fj7pIHvooJwCcJXEdd0IDH6rCrGAM/BdXcA
         0NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704492427; x=1705097227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWsveyTOHuX8GqJmXn3UhogbRyO+/xi3/LHv2audUfc=;
        b=aOC4cg4H8pidDrAupw3mI33F24TDqY5FxHwb5rZ9U/Pg2RGs9swQyaZbmtmEBrnFSh
         IIkKShcHecNeNQnSVpCDbJF9scdTVl4wpCYiAjj7YL9PraCBuQxOrqW2ARbeDEjAd+bU
         H7TRyrS83aQfQ2DdXM1c8cSgg11d3kHZ6XlNuSNRLShrfQmW9edQA9GJSMKCxH4NbiJ7
         B6GhJNCfsYJwhoNhWyn5SHoGyXqe5dRkllg4rM5KoN0vNGF1VRUqGTcOe3fc+PxaZ18L
         +FgA/42P1TP21Z1jrHX7C7IaX9cvqBOScHLdCNRyUsx9u7U/zrXwq0DHqGOysp0CWIGW
         3+SA==
X-Gm-Message-State: AOJu0Yw4+gdKRtMSrnnik56/Z80yPMuCUgEBetEkJA3u4ma4pMYEYSvH
	YoZCMa3f5YRj4ukp/Dda0ZnH2OVAlihlVAll2N8=
X-Google-Smtp-Source: AGHT+IEN8ItuhMT4a7g59C9SznWvPE56MH8njukNjquQED/59yeZ6jyB/GXJ7K5Kt1vYfasatZsyxooasyo1Zvn+myw=
X-Received: by 2002:a05:6512:1042:b0:50e:8eff:3982 with SMTP id
 c2-20020a056512104200b0050e8eff3982mr41178lfb.83.1704492427253; Fri, 05 Jan
 2024 14:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>
 <ZZhncYtRDp/pI+Aa@casper.infradead.org> <CAHk-=wi_DdgW73uVCRHsNNm6-J0+JZOas92ybNsCoEfcWac3xw@mail.gmail.com>
In-Reply-To: <CAHk-=wi_DdgW73uVCRHsNNm6-J0+JZOas92ybNsCoEfcWac3xw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Jan 2024 14:06:55 -0800
Message-ID: <CAEf4BzYXm4ua+S+xgrKaXFak8c3-t35B8DASbsHb78GQZhkWzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 12:46=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Fri, 5 Jan 2024 at 12:32, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > I can't tell from the description whether there are going to be a lot o=
f
> > these.  If there are, it might make sense to create a slab cache for
> > them rather than get them from the general-purpose kmalloc caches.
>
> I suspect it's a "count on the fingers of your hand" thing, and having
> a slab cache would be more overhead than you'd ever win.

Yes, you suspect right. It will be mostly one BPF token instance per
application, and even then only if the application is running within a
container that has BPF token set up (through BPF FS instance). So
yeah, slab cache seems like an overkill.

>
>            Linus

