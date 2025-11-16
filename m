Return-Path: <linux-fsdevel+bounces-68613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C88FC61719
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 76FCA290FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C093309DCE;
	Sun, 16 Nov 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fcJFop89"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D42FAC18
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Nov 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763304970; cv=none; b=nzdPpIPWODt8cG4+2x759YkLSKShnz1N6HwxZQZrck5F0nJWp/HFXwWnyQFPAYklMk6dYXMQgZn4oSMmQTJV8nWJDjJN/UoZeZI7OY6cXIpUSG74gF1kTmY+/7Uw8pmiGitFoKFQHNV6QOx60KZrhSzzyHPNoiuJzL7KIYsNr34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763304970; c=relaxed/simple;
	bh=rBf3npL0TguhJ7wrCV0Npvl2SjtmmS/0ePqEurjh7DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1d2AFuH3anrbpdc2UjokHXQKDgpLGM9QwFKvYImAeyZSRucMp2LzUNcVbWiM+7FRbaJGRT/h7Bup4XsUcgozk1PN87nBcJxzF0CkjiNhJM4h3aX6tJ/+cb6bCRFsCqYBw7ofjOnxXuiibazIkH3rDERfNIK5LXrDYhmn8Sv7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fcJFop89; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso6078301a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Nov 2025 06:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763304967; x=1763909767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/CQAuhHNkCADrkQvHG3hd8paJ2zmTnw1jvvtqelozg=;
        b=fcJFop89Tq4g3isdbYw0hz/G5AyjF6vLTQDh4IvlycyrhxuVLx9jkPB2KesW8wLnPa
         PaxH7ka3TlHTBjx18s+JqqU4dpIHPY/3HsXp5bH4By1fJGdUzDVgr0yL4zXmpCzWtBt1
         UJ/qLZ8N1FnrFXO4K1pGQLB5CCsh7LZvqOryeqBpFwrRLUguhE8AQ3t+INokKLu6WXFJ
         +1SvSM8hePfVhr3xqOhOpv+DarI2RaVLjO7MkKqqx2lZPgrguNOSDXJESs2v/7y8GCzi
         epjmYN6hxRRa4QFaV/dllEz5GK3pHYzp82j7h1ktPxGKtlCFVXoDSt3vPVLVBi2ZBTBn
         /gzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763304967; x=1763909767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0/CQAuhHNkCADrkQvHG3hd8paJ2zmTnw1jvvtqelozg=;
        b=ZVos9tMxPZKgN+0C4DgE6+kQaeO9cNimCl1V/YkHMsvXBNeJ0dOJhB0IYpYTYmzkCY
         Q8K+oRyIucMqYDQXRywc7PjF62hcig4DvNRZBPBuvZLpbPUftuqeGcgAxrvf106MjpOM
         cfvVt2Cd1Vq2o2iqDNZHwu/vaGc7Jw2dlU1I3WuGTTTl9fMwa1QjmqI/JGuTk3PBgTRT
         lAdXWMu8aZpU9cTMvHWOb+951wJvCfClrbNlUNYyGJkOTF+AAecBMrtasXGSWEsNZrla
         t1XbiPVmPFtQD03wFlMoiN3oAXWa3TGsUUnJEZdtvLNXxo9gr0hTCuQrlFWuTg9xiB78
         ocDw==
X-Forwarded-Encrypted: i=1; AJvYcCUi4yRBBirmRaf/dHoNvV8n9wJfCC8FltBirf+NIuGaaQS0kN2SXJJNjBDYn3qUYH69VaRKEWDdtYK1jcjR@vger.kernel.org
X-Gm-Message-State: AOJu0YwMo5YP5PWWkM+WorMMfQGaYlPDzhMfEhPcoXuIuF50H/QzFSK/
	yKirhK5kXk0XB5Gg7YObUMW6qYkxdn8Xw2UEz9wYGRDq0V8xQ7Povw5Tsis8qZwPO6Nt7icGkYq
	h6iDi6mjoV7b/rKIoN5lx17nlYF+uN65o6ncD3gScpQ==
X-Gm-Gg: ASbGncsErDQ5DojFeAl06U0TANa+CBGPDBBSXfQZkXR9wtbKWkR4abIAPIHN2zJyqWx
	ERLRX7VlWlKKnNEh0wld6NaNAJLKuC1e4HAxU1XMfl7m9OL2yXoS5eYMhkOvaCrF5UluWeg+Epu
	a4TzW52064OmXa02vCgYzR4/ikxorNF9V2ZBPbMkIlSLAgnhlXoJ4/lnR3bkTed4SHvSHW2eIxQ
	kuT5h1BHeyHL2MhEwXr9AQD8gFP1o3jSwXx8jy3rQALq2T9NkbzWlDvco2Sg8QMvwZ/RMw1DIWe
	dI9bR0q3LQ97Nr4vFV1Nu0Nk5nng
X-Google-Smtp-Source: AGHT+IGNPxKwLz6m1hNQQtO/HUlURpwzye7xb9Bg+A8R04/hYPqwQLHKZYopHY79DJqzQnd0DKSzDXSuqpY0Dvll30c=
X-Received: by 2002:a05:6402:34c6:b0:640:ceef:7e44 with SMTP id
 4fb4d7f45d1cf-64350e9ff14mr9315924a12.28.1763304966695; Sun, 16 Nov 2025
 06:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-3-pasha.tatashin@soleen.com> <aRnG8wDSSAtkEI_z@kernel.org>
In-Reply-To: <aRnG8wDSSAtkEI_z@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 16 Nov 2025 09:55:30 -0500
X-Gm-Features: AWmQ_bmM-aRBqtNYsNPIqAwGT0quxlyXWlezggSpTwsXJzseK1QN4lUsqunxqQU
Message-ID: <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
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
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 7:43=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 15, 2025 at 06:33:48PM -0500, Pasha Tatashin wrote:
> > Integrate the LUO with the KHO framework to enable passing LUO state
> > across a kexec reboot.
> >
> > When LUO is transitioned to a "prepared" state, it tells KHO to
> > finalize, so all memory segments that were added to KHO preservation
> > list are getting preserved. After "Prepared" state no new segments
> > can be preserved. If LUO is canceled, it also tells KHO to cancel the
> > serialization, and therefore, later LUO can go back into the prepared
> > state.
> >
> > This patch introduces the following changes:
> > - During the KHO finalization phase allocate FDT blob.
>
> This happens much earlier, isn't it?

It is, this commit log needs to be updated, it still talks about
prepare/cancel, where they are since v5 replaced with
preserve/unfreeze.

>
> > - Populate this FDT with a LUO compatibility string ("luo-v1").
> >
> > LUO now depends on `CONFIG_KEXEC_HANDOVER`. The core state transition
> > logic (`luo_do_*_calls`) remains unimplemented in this patch.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/liveupdate/abi/luo.h |  54 ++++++++++
> >  kernel/liveupdate/luo_core.c       | 153 ++++++++++++++++++++++++++++-
> >  2 files changed, 206 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/liveupdate/abi/luo.h
> >
> > diff --git a/include/linux/liveupdate/abi/luo.h b/include/linux/liveupd=
ate/abi/luo.h
> > new file mode 100644
> > index 000000000000..9483a294287f
> > --- /dev/null
> > +++ b/include/linux/liveupdate/abi/luo.h
> > @@ -0,0 +1,54 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (c) 2025, Google LLC.
> > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > + */
> > +
> > +/**
> > + * DOC: Live Update Orchestrator ABI
> > + *
> > + * This header defines the stable Application Binary Interface used by=
 the
> > + * Live Update Orchestrator to pass state from a pre-update kernel to =
a
> > + * post-update kernel. The ABI is built upon the Kexec HandOver framew=
ork
> > + * and uses a Flattened Device Tree to describe the preserved data.
> > + *
> > + * This interface is a contract. Any modification to the FDT structure=
, node
> > + * properties, compatible strings, or the layout of the `__packed` ser=
ialization
> > + * structures defined here constitutes a breaking change. Such changes=
 require
> > + * incrementing the version number in the relevant `_COMPATIBLE` strin=
g to
> > + * prevent a new kernel from misinterpreting data from an old kernel.
>
> I'd add a sentence that stresses that ABI changes are possible as long th=
ey
> include changes to the FDT version.
> This is indeed implied by the last paragraph, but I think it's worth
> spelling it explicitly.
>
> Another thing that I think this should mention is that compatibility is
> only guaranteed for the kernels that use the same ABI version.

Sure, I will add both.

> > + *
> > + * FDT Structure Overview:
> > + *   The entire LUO state is encapsulated within a single KHO entry na=
med "LUO".
> > + *   This entry contains an FDT with the following layout:
> > + *
> > + *   .. code-block:: none
> > + *
> > + *     / {
> > + *         compatible =3D "luo-v1";
> > + *         liveupdate-number =3D <...>;
> > + *     };
> > + *
> > + * Main LUO Node (/):
> > + *
> > + *   - compatible: "luo-v1"
> > + *     Identifies the overall LUO ABI version.
> > + *   - liveupdate-number: u64
> > + *     A counter tracking the number of successful live updates perfor=
med.
> > + */
> ...
>
> > +static int __init liveupdate_early_init(void)
> > +{
> > +     int err;
> > +
> > +     err =3D luo_early_startup();
> > +     if (err) {
> > +             pr_err("The incoming tree failed to initialize properly [=
%pe], disabling live update\n",
> > +                    ERR_PTR(err));
>
> How do we report this to the userspace?
> I think the decision what to do in this case belongs there. Even if it's
> down to choosing between plain kexec and full reboot, it's still a policy
> that should be implemented in userspace.

I agree that policy belongs in userspace, and that is how we designed
it. In this specific failure case (ABI mismatch or corrupt FDT), the
preserved state is unrecoverable by the kernel. We cannot parse the
incoming data, so we cannot offer it to userspace.

We report this state by not registering the /dev/liveupdate device.
When the userspace agent attempts to initialize, it receives ENOENT.
At that point, the agent exercises its policy:

- Check dmesg for the specific error and report the failure to the
fleet control plane.
- Trigger a fresh (kexec or cold) reboot to reset unreclaimable resources.

Pasha

