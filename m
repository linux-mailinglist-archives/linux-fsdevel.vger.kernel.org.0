Return-Path: <linux-fsdevel+bounces-1612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F207DC4B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 04:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329D1B20EBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 03:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7037C46B7;
	Tue, 31 Oct 2023 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I2tmxS7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159AA54
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 03:02:57 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB06FC1
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:02:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9d2d8343dc4so322528666b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698721371; x=1699326171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kj2rwmZ/mneMTTl9ChMduk9PV284b4OmfB6artfaa5E=;
        b=I2tmxS7zSyo9J8yfHlyMlD1gZIU9rPq73kZ9NMLfhAyp/OuVdFwMe4WPamTUv1/RTU
         XsPtqxp5Hcev+QukQCUpe+/Ct77EABgxj2y2CpXFYMlOPMlAKZ9QvEhP3pHw+u6s82M+
         3zWboirgV/QC8Y6SsN6NLohIziXDMic7fNC88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698721371; x=1699326171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kj2rwmZ/mneMTTl9ChMduk9PV284b4OmfB6artfaa5E=;
        b=KyvE6cyi+02swY4NM8Sb5z3FnK2U/15S157yzLJTmeCsE3lnGZ8UD36U1yw3a5e+Pd
         eBGUVCwaKCZ2eycTsNbTmcNbF41hDthPU/t//XR7ZBch5X/GZgi181tDPabkgAoaerF7
         bejtZBu3MZkb7we9Icm1tRdbvaausQObWipou2CIzkbZ3leFtEAcekpZj5dHwnB51EPO
         DuzHkP0IPgRU98yW2VDbHKHjnIQQegvMNHzAYGd/lX2EboRMyWkgH3ehyGa6YS65v4xj
         0Nsi3pva0Dz7TmkTQ303KeGO9o4zBjaJeEvXGuCmgbwKIbo+DgSfBSBEVYgkVQdGJnFD
         InQg==
X-Gm-Message-State: AOJu0YxD0PkJCFbQhnnh68NMYLRBW1N6AGKSlTFUI7gE0TjeD0ndGpqC
	7CKdrcsLw9sT9QXmtwN1PEz6srdBBtZJPbuTuRnGGmnm
X-Google-Smtp-Source: AGHT+IErbmXOJPN+TrmOBQPwwzYlEBMU0oYwFUFb1WY8IMiUlu5X/0KT/s7GcFgITC4+0BOpSdcj2Q==
X-Received: by 2002:a17:907:2d29:b0:9be:7dd3:40ab with SMTP id gs41-20020a1709072d2900b009be7dd340abmr9396117ejc.2.1698721370732;
        Mon, 30 Oct 2023 20:02:50 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id l6-20020a1709060e0600b009cc1227f443sm198431eji.104.2023.10.30.20.02.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 20:02:50 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9d2d8343dc4so322525766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:02:50 -0700 (PDT)
X-Received: by 2002:a17:907:934c:b0:9c4:eefa:b6aa with SMTP id
 bv12-20020a170907934c00b009c4eefab6aamr9428518ejc.42.1698721369756; Mon, 30
 Oct 2023 20:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030003759.GW800259@ZenIV> <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com> <67ded994-b001-4e9b-e2c9-530e201096d5@linux.alibaba.com>
In-Reply-To: <67ded994-b001-4e9b-e2c9-530e201096d5@linux.alibaba.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Oct 2023 17:02:32 -1000
X-Gmail-Original-Message-ID: <CAHk-=whCga8BeQnJ3ZBh_Hfm9ctba_wpF444LpwRybVNMzO6Dw@mail.gmail.com>
Message-ID: <CAHk-=whCga8BeQnJ3ZBh_Hfm9ctba_wpF444LpwRybVNMzO6Dw@mail.gmail.com>
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Oct 2023 at 16:25, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> >
> > [ Looks around. Oh. Except we have lockref_put_return() in fs/erofs/
> > too, and that looks completely bogus, since it doesn't check the
> > return value! ]
>
>   74 struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
>   75                                                struct erofs_workgroup *grp)
>   76 {
>   77         struct erofs_sb_info *const sbi = EROFS_SB(sb);
>   78         struct erofs_workgroup *pre;
>   79
>   80         /*
>   81          * Bump up before making this visible to others for the XArray in order
>   82          * to avoid potential UAF without serialized by xa_lock.
>   83          */
>   84         lockref_get(&grp->lockref);
>   85
>   86 repeat:
>   87         xa_lock(&sbi->managed_pslots);
>   88         pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
>   89                            NULL, grp, GFP_NOFS);
>   90         if (pre) {
>   91                 if (xa_is_err(pre)) {
>   92                         pre = ERR_PTR(xa_err(pre));
>   93                 } else if (!erofs_workgroup_get(pre)) {
>   94                         /* try to legitimize the current in-tree one */
>   95                         xa_unlock(&sbi->managed_pslots);
>   96                         cond_resched();
>   97                         goto repeat;
>   98                 }
>   99                 lockref_put_return(&grp->lockref);
>
> This line it just decreases the reference count just bumpped up at the
> line 84 (and it will always succeed).

You have two possible scenarios:

 - it doesn't always succeed, because somebody else has the lock on
the grp->lockref right now, or because lockref doesn't do any
optimized cases at all

 - nobody else can access grp->lockref at the same time, so the lock
is pointless, so you shouldn't be using lockref in the first place,
and certainly not lockref_put_return

IOW, I don't see how lockref_put_return() could possibly *ever* be the
right thing to do.

The thing is, lockref_put_return() is fundamentally designed to be
something that can fail.

In  fact, in some situations it will *always* fail. Check this out:

#define USE_CMPXCHG_LOCKREF \
        (IS_ENABLED(CONFIG_ARCH_USE_CMPXCHG_LOCKREF) && \
         IS_ENABLED(CONFIG_SMP) && SPINLOCK_SIZE <= 4)
...
#if USE_CMPXCHG_LOCKREF
...
#else

#define CMPXCHG_LOOP(CODE, SUCCESS) do { } while (0)

#endif
...
int lockref_put_return(struct lockref *lockref)
{
        CMPXCHG_LOOP(
                new.count--;
                if (old.count <= 0)
                        return -1;
        ,
                return new.count;
        );
        return -1;
}

look, if USE_CMPXCHG_LOCKREF is false (on UP, or if spinlock are big
because of spinlock debugging, or whatever), lockref_put_return() will
*always* fail, expecting the caller to deal with that failure.

So doing a lockref_put_return() without dealing with the failure case
is FUNDAMENTALLY BROKEN.

Yes, it's an odd function. It's a function that is literally designed
for that dcache use-case, where we have a fast-path and a slow path,
and the "lockref_put_return() fails" is the slow-path that needs to
take the spinlock and do it carefully.

You *cannot* use that function without failure handling. Really.

                     Linus

