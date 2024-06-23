Return-Path: <linux-fsdevel+bounces-22192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 042B7913758
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 04:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD90A1F22655
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 02:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D82BC121;
	Sun, 23 Jun 2024 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd3obNJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DAF3201;
	Sun, 23 Jun 2024 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719109612; cv=none; b=uzH/sk7quF2C/0HggNvDHLw5Dh611n0zjuPsIF8ZW4v/kVkzdBv4BVN0Jjc8TzTGJ7MeKtiLpSXbQJXyyvv/Ts4rE6EYbLB8DtjhpQ5rKdT/wiVH/RG5Own2gvq470EJutgv6slVmW/t07MsgQjcAAfv9MmDH7aI/6wl5v9az4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719109612; c=relaxed/simple;
	bh=k3fQs37Okn7+VGwF/h20dWOy71NEFBoK+N7m9s8/J9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6po5+W7zSOdVT67WO4pU2oU6FYrfitjAmkUTFJD+CVO+dUpMEK2z9CGRIPFhx4kbItDyxJ7ptlo5EeDawcWHgfAzhzg6X83Bs68FAvQk6yeemoEsOOZeMpyJaRroDmowxLpEy0XdWjyTGCVrTBKaeVNQTiL1nG/ermqoQ12Zj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd3obNJB; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6aedd5167d1so13950786d6.1;
        Sat, 22 Jun 2024 19:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719109609; x=1719714409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+LPiISOoLYsJFxCwMt3f7g5PbGNmTkGzNcNw2ao++w=;
        b=Wd3obNJBfLTLGbCswO4NZNivvgp9CBG7IsaHAPvPxws4uH7JAa57HWIuj4VP2azzt2
         WB19icDB+4WNCEeH+iH6SoT1m7fI8dRsfhCznUkq86jrLYguaNEMwIamMC92MBIVHiPN
         tJjNpY/5MUTDt33a6QD5iUsp6YybLQ6anNzHeSWqsdltt13XDwRs8xL+85GIEsfj6Xuo
         727ZLAoK8eJIzyeY7SBf0AYQzpf2sV/JYZTsW/zV44pVfEMDTAAyna4DEonfNEnP5UKJ
         1L94nWXQzi1WuplqjnwlY5pcc5J+PMiA6UOuJA/MOHq+k8d8n+xaUmVY4JmXPeXCFWL3
         2W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719109609; x=1719714409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+LPiISOoLYsJFxCwMt3f7g5PbGNmTkGzNcNw2ao++w=;
        b=WwFEkYENVHyOqnSspAzjzYBTuzZTkT7vmgDPkdSvyh0G3wVyhgSrP0J3+1Tdcnf8pP
         orLInHv0ps7D1cHQ/V5fe/fcJTH2uGG1RGc67jHM6tFn0QqYGe2Qk7+bgzY8CTWHkUE/
         Lzd9g26N+iik30uxVYRzhsmWbf659ex28WrH3IHgfulgjR5U5g7DvTykgw3vey+96HlO
         CC/5URQzhNHYLsVU9c9/a+ZazHopYfh/HRYNNpjU9yICovc3IqNM44XVhQa7dKivDll0
         BOKdjm+7EBWkS82PDU9vqhBVMwTCFtKUGclBsiWadz/OYm12RKDiXvhNOQvNkaPVH2SV
         e3vw==
X-Forwarded-Encrypted: i=1; AJvYcCW+79M5vbSY/EZfoMvp2eJwozcfx4xgFyOjViqjC5DvEUN9FyFno0gQHLjLbrGnIcNp7i7QBBj7QXlQg7+H3amhqeMOFb8ZWbh64FdXitPpnA0THWc0Nl04jxf3bolul0oS4NGd7KYS9KJ1UF5cH0OfO3BKccxE72d9j51zo+u3sUEKBPQP6Q64X1l3hLX9qICaBCx7HuGTANjZAT9STyMBIsoaPnUhMB6726MgvmQyAKYpGqjcewREBC2RbLNt4QuMF1Zkab71ZblD0xAnDWmZyw/jJNeCyqfeRVZA19KNlF/C19/SX65du17r13vkCdlJMbMgTA==
X-Gm-Message-State: AOJu0YypuxnjnCoh+azX8s7VnLkcIN2NCxq5ryR41dHibXDVpDyRZ5e+
	xmxT/mK54DlLQi0qpjv4b0N+2ieqaEiFXqTCY3Rjk9+zJlKY0LNkKVygRhU3+2lA2POg5UFf//a
	tVeddPec19D2Z96Re/wmtdpw3K6A=
X-Google-Smtp-Source: AGHT+IFY0Y/UcJS7sknileL2UagN7ReFxrAWEEHMeCw0v9alkFUCpuvgoM4QBmWhVR/dsnO/cQfpgT+sNC6/yK6yero=
X-Received: by 2002:a05:6214:20e2:b0:6b5:24b:f430 with SMTP id
 6a1803df08f44-6b540a91d2emr16144186d6.40.1719109609327; Sat, 22 Jun 2024
 19:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621022959.9124-1-laoar.shao@gmail.com> <20240621022959.9124-7-laoar.shao@gmail.com>
 <20240621135142.GF1098275@kernel.org>
In-Reply-To: <20240621135142.GF1098275@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 23 Jun 2024 10:26:13 +0800
Message-ID: <CALOAHbARduAEv+CQnRuLokrf5NYkM5omhpOuJuDuBhf-daKgxg@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
To: Simon Horman <horms@kernel.org>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	akpm@linux-foundation.org, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 9:51=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Jun 21, 2024 at 10:29:54AM +0800, Yafang Shao wrote:
> > These three functions follow the same pattern. To deduplicate the code,
> > let's introduce a common help __kstrndup().
> >
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Hi Yafang Shao,
>
> Some minor nits from my side.
>
> > ---
> >  mm/internal.h | 24 ++++++++++++++++++++++++
> >  mm/util.c     | 27 ++++-----------------------
> >  2 files changed, 28 insertions(+), 23 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index b2c75b12014e..fd87f685739b 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1521,4 +1521,28 @@ static inline void shrinker_debugfs_remove(struc=
t dentry *debugfs_entry,
> >  void workingset_update_node(struct xa_node *node);
> >  extern struct list_lru shadow_nodes;
> >
> > +/**
> > + * __kstrndup - Create a NUL-terminated string from @s, which might be=
 unterminated.
> > + * @s: The data to stringify
> > + * @len: The size of the data, including the null terminator
> > + * @gfp: the GFP mask used in the kmalloc() call when allocating memor=
y
> > + *
> > + * Return: newly allocated copy of @s with NUL-termination or %NULL in
> > + * case of error
> > + */
> > +static __always_inline char *__kstrndup(const char *s, size_t len, gfp=
_t gfp)
> > +{
> > +     char *buf;
> > +
> > +     buf =3D kmalloc_track_caller(len, gfp);
> > +     if (!buf)
> > +             return NULL;
> > +
> > +     memcpy(buf, s, len);
> > +     /* Ensure the buf is always NUL-terminated, regardless of @s. */
> > +     buf[len - 1] =3D '\0';
> > +     return buf;
> > +}
> > +
> > +
>
> nit: One blank line is enough.

Ah, will change it.

>
> >  #endif       /* __MM_INTERNAL_H */
> > diff --git a/mm/util.c b/mm/util.c
> > index 41c7875572ed..d9135c5fdf7f 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -58,17 +58,8 @@ char *kstrdup(const char *s, gfp_t gfp)
> >       if (!s)
> >               return NULL;
> >
> > -     len =3D strlen(s) + 1;
> > -     buf =3D kmalloc_track_caller(len, gfp);
> > -     if (buf) {
> > -             memcpy(buf, s, len);
> > -             /* During memcpy(), the string might be updated to a new =
value,
> > -              * which could be longer than the string when strlen() is
> > -              * called. Therefore, we need to add a null termimator.
> > -              */
> > -             buf[len - 1] =3D '\0';
> > -     }
> > -     return buf;
>
> nit: The local variable buf is now unused, and should be removed from kst=
rdup().
>      Likewise for kstrndup() and kmemdup_nul()
>
>      Flagged by W=3D1 builds with gcc-13 and clang-18, and Smatch.

I missed that. Thanks for pointing it out.

--=20
Regards
Yafang

