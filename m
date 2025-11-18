Return-Path: <linux-fsdevel+bounces-68823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CFDC67312
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 04:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4D994E4E45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 03:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F172316191;
	Tue, 18 Nov 2025 03:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FWq9X/6R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF422D23A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438110; cv=none; b=lqOATREg9TMBq+Mi18iHSjyo/BOSJK3muW0Mw8JrOwo1NZz3cJexoe+5ul+7IVSi+E3fkz/xHZPf/0JOiKIDtcDAU8jfQLPZHhnGIWZy0QdxGahcNCPCzN2pqzfwnjVQw4TIXBqOBwyMqkP2/Or5WgrN5waZi2xzDv8aCEE5/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438110; c=relaxed/simple;
	bh=GJQXAYpVXf9WIODL6aAeQUdinB0yRoRp5YgQ/TK1Wps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yjzqgh2e6brjFowjBsnL/rX8bKWm4SDBUFlXjaj3ExMCswZfBg1k1emFEPPE82cDSactwRfJlA2jDLUf+hIxqsLipqqJcVIqLumHWQ3reZDRO39blIAD0pUQuSH1eNwhrcMCn2WQ8nyUb+0orMiVIIW2qFfJALmublzUGD2WAMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FWq9X/6R; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so1203564a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 19:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763438106; x=1764042906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=skgPOZZQd9xc8fmG59fpZy24V3xOREPCSLrN+c1B0bM=;
        b=FWq9X/6R+JY9PBAjJenHvh8+hVE9S3ytgRdX7L0XnZ/GOmHbh5RoiSASwRPRDmRwu+
         8F9AiOyhwUwkmb1/EQs21bnF8moYR4OoCgxIrrhbryBoSxNpNWwUgIrJdSJhBVY8t6ge
         62BFYy8gK7fwnHpG0v+nROjhgF5kZGYNLyCZjX2vlE7ZbFoEFYHdvK/D03s/EHoRQPv9
         DzfW4kEkpqLEWApA9j+Vv5JNEnDse09V9CHnbCPzHfm5sckQ2o9j4a7GddA6Ko9I8hf/
         sya+uLeGoZ2f8qT4bgAzVkqWnR+Xi0N2oO5tuoB2TS1q8REgxdQVGLFpzM5dTjIGQdE1
         s6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763438106; x=1764042906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skgPOZZQd9xc8fmG59fpZy24V3xOREPCSLrN+c1B0bM=;
        b=GAUW4/s7Aa7nb3S34JbB3qG6er1H++hf0WSdN9LM/SINEmtAKtGl+O+U1OErhyBC5b
         niv2EEcJmG+7ryHTjdwGAWPxzVLWZYIoeY5awf/bPEAg/CxwLbks/smPrwXIM4geTq7r
         uOfhkHXH9UxxT4XXE3cf8O6Ph2jiHNw4ugCkVVo+SvMly4H+gtSo4Gp0PeSWjxogf0Lc
         +kq5Q/bddnMN7kNrCthYb0uGI+hE8+lmPWx9guIz/3sWKBT2FdkquXl16x0HScIjlX9u
         XEu6v6xl9tRezQ+YyPRFgaEUkYlaHMgA5TZ+JMwmRlbonTCFG4uvQwizVNN9fiLWb4TZ
         ZfkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGdiXl0Bf4hI/PyUqZgqhBL/WsHNep905kfyk6sMKTcjOFY6PHwKMCMWwWchFNEzffyOuYz6kxnqzpRuAx@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+NIVYo4vYvxL0Xe+ZaY3EX5p+7XTbhHHPO/m1WaKEjAGJw7G
	XeZ38MxETMk1wDx6Cy7uBSE+1q19yan6Wz/JruK9GZUBdg25rQ5CmqElg/KJyEC3rpqg+ggrUWB
	8OaeHL2tmgCaAFpwI9/wncbg6nK/Xt5c34SSW/j7M2A==
X-Gm-Gg: ASbGncuyVQQUmfV1tEP23zm8Ts0WtCmroqgIFMX94wv3F/aK8qA6wrpfCH5TeA8MUAT
	Gc2ju6V4cPEs03xTtnCZoUFEZEim45X5vP1SV8Tplhp61UIezz2Z7X05+IODT8JdWJRssjBXwu2
	WITdMJ8omTyr2/uWMaPsLF9lCamBv/sCgDRw0sT5oshjhLy/WqU+/euLMv8qu8A15q/wpIdtFPR
	PAokPVsDi+lYYSPPk8em3cD0TU9dxYPxMcwGR3Bx7jMcIpJb1zvxMoBz06RzDZ5ohxUXnEGlEZA
	13M=
X-Google-Smtp-Source: AGHT+IGpZOWjW5LZWKY0Iok3QDFR7NYQQcE+w3n/xTVgTcedHnVbwsy/RegtbkWq0MjsVKCBcc+Ff3JZMy+ys8CEjC0=
X-Received: by 2002:a05:6402:5056:b0:640:ebca:e66f with SMTP id
 4fb4d7f45d1cf-64350ec0198mr11607004a12.34.1763438105963; Mon, 17 Nov 2025
 19:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-9-pasha.tatashin@soleen.com> <aRrtRfJaaIHw5DZN@kernel.org>
In-Reply-To: <aRrtRfJaaIHw5DZN@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 22:54:29 -0500
X-Gm-Features: AWmQ_bkZQMN1UOxORLYbivUdr8-ENGLbMFsVRw8DEyZxpK5fJGoXi0eN_5cEvNg
Message-ID: <CA+CK2bBxVNRkJ-8Qv1AzfHEwpxnc4fSxdzKCL_7ku0TMd6Rjow@mail.gmail.com>
Subject: Re: [PATCH v6 08/20] liveupdate: luo_flb: Introduce
 File-Lifecycle-Bound global state
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> The concept makes sense to me, but it's hard to review the implementation
> without an actual user.

There are three users: we will have HugeTLB support that is going to
be posted as RFC in a few weeks. Also, in two weeks we are going to
have an updated VFIO and IOMMU series posted both using FLBs. In the
mean time, this series provides an FLB in-kernel test that verifies
that multiple FLBs can be attached to File-Handlers, and the basic
interfaces are working.


> > +struct liveupdate_flb {
> > +     const struct liveupdate_flb_ops *ops;
> > +     const char compatible[LIVEUPDATE_FLB_COMPAT_LENGTH];
> > +     struct list_head list;
> > +     void *internal;
>
> Can't list be a part of internal?

Yes, I moved it inside internal, and also, I removed
liveupdate_init_flb function (do that automatically now), and use the
__private as you suggested earlier, and also removed the kmalloc() for
the internal data, so FLBs can be safely used early in boot.

> And don't we usually call this .private rather than .internal?

Renamed.

>
> >  };
> >
> >  #ifdef CONFIG_LIVEUPDATE
> > @@ -111,6 +187,17 @@ int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> >  int liveupdate_get_token_outgoing(struct liveupdate_session *s,
> >                                 struct file *file, u64 *tokenp);
> >
> > +/* Before using FLB for the first time it should be initialized */
> > +int liveupdate_init_flb(struct liveupdate_flb *flb);
> > +
> > +int liveupdate_register_flb(struct liveupdate_file_handler *h,
> > +                         struct liveupdate_flb *flb);
>
> While these are obvious ...
>
> > +
> > +int liveupdate_flb_incoming_locked(struct liveupdate_flb *flb, void **objp);
> > +void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb, void *obj);
> > +int liveupdate_flb_outgoing_locked(struct liveupdate_flb *flb, void **objp);
> > +void liveupdate_flb_outgoing_unlock(struct liveupdate_flb *flb, void *obj);
> > +
>
> ... it's not very clear what these APIs are for and how they are going to be
> used.

Global resource that is accessible either while a file is getting
preserved or anytime during boot.

>
> >  #else /* CONFIG_LIVEUPDATE */
>
> ...
>
> > +int liveupdate_register_flb(struct liveupdate_file_handler *h,
> > +                         struct liveupdate_flb *flb)
> > +{
> > +     struct luo_flb_internal *internal = flb->internal;
> > +     struct luo_flb_link *link __free(kfree) = NULL;
> > +     static DEFINE_MUTEX(register_flb_lock);
> > +     struct liveupdate_flb *gflb;
> > +     struct luo_flb_link *iter;
> > +
> > +     if (!liveupdate_enabled())
> > +             return -EOPNOTSUPP;
> > +
> > +     if (WARN_ON(!h || !flb || !internal))
> > +             return -EINVAL;
> > +
> > +     if (WARN_ON(!flb->ops->preserve || !flb->ops->unpreserve ||
> > +                 !flb->ops->retrieve || !flb->ops->finish)) {
> > +             return -EINVAL;
> > +     }
> > +
> > +     /*
> > +      * Once session/files have been deserialized, FLBs cannot be registered,
> > +      * it is too late. Deserialization uses file handlers, and FLB registers
> > +      * to file handlers.
> > +      */
> > +     if (WARN_ON(luo_session_is_deserialized()))
> > +             return -EBUSY;
> > +
> > +     /*
> > +      * File handler must already be registered, as it is initializes the
> > +      * flb_list
> > +      */
> > +     if (WARN_ON(list_empty(&h->list)))
> > +             return -EINVAL;
> > +
> > +     link = kzalloc(sizeof(*link), GFP_KERNEL);
> > +     if (!link)
> > +             return -ENOMEM;
> > +
> > +     guard(mutex)(&register_flb_lock);
> > +
> > +     /* Check that this FLB is not already linked to this file handler */
> > +     list_for_each_entry(iter, &h->flb_list, list) {
> > +             if (iter->flb == flb)
> > +                     return -EEXIST;
> > +     }
> > +
> > +     /* Is this FLB linked to global list ? */
>
> Maybe:
>
>         /*
>          * If this FLB is not linked to global list it's first time the FLB
>          * is registered
>          */

Done


> > +/**
> > + * liveupdate_flb_incoming_unlock - Unlock an incoming FLB object.
> > + * @flb: The FLB definition.
> > + * @obj: The object that was returned by the _locked call (used for validation).
> > + *
> > + * Releases the internal lock acquired by liveupdate_flb_incoming_locked().
> > + */
> > +void liveupdate_flb_incoming_unlock(struct liveupdate_flb *flb, void *obj)
> > +{
> > +     struct luo_flb_internal *internal = flb->internal;
> > +
> > +     lockdep_assert_held(&internal->incoming.lock);
> > +     internal->incoming.obj = obj;
>
> The comment says obj is for validation and here it's assigned to flb.
> Something is off here :)

Thank you for catching stale comment, fixed.

> > +     mutex_unlock(&internal->incoming.lock);
> > +}
> > +
> > +/**
> > + * liveupdate_flb_outgoing_locked - Lock and retrieve the outgoing FLB object.
> > + * @flb:  The FLB definition.
> > + * @objp: Output parameter; will be populated with the live shared object.
> > + *
> > + * Acquires the FLB's internal lock and returns a pointer to its shared live
> > + * object for the outgoing (pre-reboot) path.
> > + *
> > + * This function assumes the object has already been created by the FLB's
> > + * .preserve() callback, which is triggered when the first dependent file
> > + * is preserved.
> > + *
> > + * The caller MUST call liveupdate_flb_outgoing_unlock() to release the lock.
> > + *
> > + * Return: 0 on success, or a negative errno on failure.
> > + */
> > +int liveupdate_flb_outgoing_locked(struct liveupdate_flb *flb, void **objp)
> > +{
> > +     struct luo_flb_internal *internal = flb->internal;
> > +
> > +     if (!liveupdate_enabled())
> > +             return -EOPNOTSUPP;
> > +
> > +     if (WARN_ON(!internal))
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&internal->outgoing.lock);
> > +
> > +     /* The object must exist if any file is being preserved */
> > +     if (WARN_ON_ONCE(!internal->outgoing.obj)) {
> > +             mutex_unlock(&internal->outgoing.lock);
> > +             return -ENOENT;
> > +     }
>
> _incoming_locked() and outgoing_locked() are nearly identical, it seems we
> can have the common part in a
> static liveupdate_flb_locked(struct luo_flb_state *state).
>
> liveupdate_flb_incoming_locked() will be oneline wrapper and
> liveupdate_flb_outgoing_locked() will have this WARN_ON if obj is NULL.

Done

