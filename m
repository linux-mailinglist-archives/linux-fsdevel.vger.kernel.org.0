Return-Path: <linux-fsdevel+bounces-55175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EABB07803
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 16:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637EA7B3C55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175FF2494F5;
	Wed, 16 Jul 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cbcc5COI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9323A23E320
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676072; cv=none; b=lxAHnJ9jAw0zvrqDOZPv8oax2b3D8Db9KTnU1I04Ilp6wnjcS97kSMGKchSrRAmR8jV6RcZt4sxexuTxXeUMnKe6VbBOnswBksmoH1aXNd1gjtuul9CMm4ym12C4qUDkQNW+oRyDeXnRWt4djQpSK6ZF9tjKC5s01EdJ+92/Hyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676072; c=relaxed/simple;
	bh=cyZO4jBm4kaYmq8XRr10614mGEMaunG47DfNgPoj3+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkxL1MvvVZ6r2NcexK3I2q6Tln+iqI7TQbyv2bIDEJOoTUCAsbxkmXok5XoWOVwbRqPR4hRXWfQ2RW//aae5OV9bcP4dFQ0bRBdXKjrTpd75utFaCz8nbPPlhBcV3DhsWTzcP/rBQD1qgKLGRSjPY75idzBuSAiXRUp/TRgzsqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cbcc5COI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso12667a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752676069; x=1753280869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyZO4jBm4kaYmq8XRr10614mGEMaunG47DfNgPoj3+Q=;
        b=Cbcc5COISwvDVxOLl2AuIR9A6AyZG2Z4LZn1srBY4TVHfbnWZWo9reKS78+V9jnTfJ
         sbKtqU+btoKu7OLT31JTSgVh5pl5uUIklF0Q+d9aRDTf25UtcjcrWG//qXKmUyQmsVAD
         EuyPdZY2Pv4p1lSNH/1X3A0Q2tXrZkSgUg9dsc3vUtqPf/erHqTSpuJe7UjS662T4L8n
         6WEED7J38WkkBDmBCAYpMLICuV8BLjV+GeuWMfPX+Lc1yxbs9Xnp0TU+EJ4CdD/BL1CJ
         wiRpCd02sLyRFj9C8RTvxNap6S8qL9OJb3cgxj651P7ZHQPU2WUP5shHEOkBbxnU28zG
         gZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676069; x=1753280869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyZO4jBm4kaYmq8XRr10614mGEMaunG47DfNgPoj3+Q=;
        b=Suaod9cyfBMXO/27/u7gV9x8lqsny8RKjdJo7Ime/0jPLkYNQ1tyGU8pTJLb+8/4Pw
         MuS/8wvRMAHPELqWBDASLVH01+lv3z75EGk4jkPbjh42io+x0jOoncLRQFZhLPL6RXhw
         tbWbs0Jy/fgeG0Ebd7NndTeG4HN2vHGjhI126HTA31sW2eBQu1P4pOh+RWvajtukhCGm
         5Dnll78s2L7vyBttsrmojDmJmQTwZzuDAoHPgjh5aq5abMhGkypRKQDB8L4pKLacHJ12
         1C1MULmizzlEAMTHPPBaUKOz3mFrQPAHkFXv9nu6iXZvf0gwQtgej6uLmyRM7L2SJVjk
         T8uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8cSUABnbLKbkiC1uhCNlq7ajxGQFVN8gfZftg4bM0On4IEdRK15Oe5B8jG03jh3belcP882t+6DaDcsGG@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvREIXBNgRvvYxqreBgJ6108gMuQZxuKf6FDjR18ks8kcLRBV
	VrmQc7eqyhPEhKRj6kIARosT0DpyTIwhogqQaTk8StgGkjnDu3X5OCBnN1GxTJ5BdTFIvaMWSGX
	i98vjrIFV+zWZtogaDMLyXJGeaoJAWshkaT7y3EHQ
X-Gm-Gg: ASbGncs8nuWx8o1Qzg/6MWDlJbvQE8ozfCQ4vnmCB04rc098Hs4FXWkn5pIxsicwCOg
	1S5meOleKzp20hp4+MoOuo88aCkPoHA6of5JI/I0V45hVFFq4jeDM5g6cMnj8GAPZxcsFjrSLrv
	KBEOqKNNwUnrNMTAY0zMz4pA6a9Nn0mSmGXZpaogtaTaL/xCjSjCo89LWzs5S2Yc/dtPsO+OP1Q
	v3wVfYGUda6jVotLkjvMDsDClKGNoSByQsi
X-Google-Smtp-Source: AGHT+IFtn2Jt43sGdMrRnFbMM4zR7ZvvUOW5aRjpbxzkLX62FzMlCaPlKzcAzbgKN34QMkxqDCHX/orQFd9yCAvuWCQ=
X-Received: by 2002:aa7:c14c:0:b0:611:e30b:5707 with SMTP id
 4fb4d7f45d1cf-6128dc01d52mr57489a12.7.1752676068588; Wed, 16 Jul 2025
 07:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f60a932f-71c0-448f-9434-547caa630b72@suse.cz> <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
 <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz> <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz> <CAJuCfpH8zsboafV1UWufYhbVXN-yKgMOKm=vr2vBYAPNmPtrvw@mail.gmail.com>
 <07de1e8c-9319-49b8-8e86-97ea0d18142b@lucifer.local> <eb432785-e916-4714-a1e3-4ea5218cfa76@suse.cz>
In-Reply-To: <eb432785-e916-4714-a1e3-4ea5218cfa76@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 07:27:35 -0700
X-Gm-Features: Ac12FXzkQUKbjHWly2XAM-75FxXxF7P_PGAXAyUAeeE-cM1Ys06wCiWNzG6_w_w
Message-ID: <CAJuCfpFohprJEshKXX9awPdwJhRNU1995suvwegXHpiYWO-ONA@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	akpm@linux-foundation.org, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:07=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/16/25 16:00, Lorenzo Stoakes wrote:
> > On Tue, Jul 15, 2025 at 01:13:36PM -0700, Suren Baghdasaryan wrote:
> >> Huh, I completely failed to consider this. In hindsight it is quite
> >> obvious... Thanks Vlastimil, I owe you a beer or two.
> >
> > FYI - Vlasta prefers the 'starobrno' brand of beer, he says he can't ge=
t
> > enough :)
>
> FYI - Lorenzo is a notorious liar :)

A search for starobrno in Tokyo provides a couple of suggestions:
- Pilsen Alley in Ginza focuses on Czech Pilsner beer, and while they
feature Pilsner Urquell, they might also carry other Czech brands.
- Cerveza Japan ShibuyaAXSH, a casual restaurant specializing in
Spanish paella, also offers an extensive selection of imported craft
beers from various countries, including the Czech Republic.

