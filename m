Return-Path: <linux-fsdevel+bounces-56613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E3FB199C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 03:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DF53A98FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 01:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C937F1DF269;
	Mon,  4 Aug 2025 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QEg4HgIR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472E1A4E70
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754269920; cv=none; b=tbm5osMeQ1JBhztWVVaqhzWJGl6MrHY4f15FO47UoNsxzqeEPjnVKmgPjMrc/TqPRZSxD7cFckAaXZLyT2BIeDQca0xhiNnVVmzwtXOyn6TWDvIVbbBkIESVnXM1xAOpoQFqMoN3O+IjcQXoibyXZsykOQYgkEoDOQySWlLBO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754269920; c=relaxed/simple;
	bh=dwYOkfkrLuTx/MFAcxiCoQ08IEU73UxalscP4C3rAnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ez0xwf0EAbIDAw9EBkt+9aMmB/yNwmnWaDIEzZxLruBOQ9BHqk0WYxEDDyzG7vWK9VBKhpeije9z/k08S1sbm95KlA3tongq+xs0Xa5dAde3UdnYRX4arNZ4X4vZfyliD2WNrRNHo1kFUt3EtO1jq2fq5osRMR0mbqb8yWFwY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=QEg4HgIR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab8e2c85d7so53675121cf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Aug 2025 18:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754269917; x=1754874717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5EHC7Bo4Tna4lRMiPBPdxLTjpzf5j4XSXmXAx1SxHbs=;
        b=QEg4HgIRS9N4H1et3Jj6itt+EpgeASfgoWdFChVLa/GpHmHZwTO749KMj/M0qVT9qL
         t03TxH0ncEc9mOrotDxSviMm8Wsn8jBVAWn5QUdZa9EsZQJQCCopWG14kicCqUBRmSf+
         zgyMYD06vPTJD7FWGjDJnvkoVZaRkM4z9SaLfM5pz6wTDpvpXgKLvQemlTfO0yvXOxrm
         XpG6jq5Px5ZXBNxcfjI/msUyD8WDY2McIbKCyE9SRHLWbQnsUOY6KL7Y169EGI33wpHI
         36WIDeDaj+pRUBYTf6UQNb8sk1lomqwWrRptXi9l2x9ysPDc/hwNqdbc0g3y+hmWbZUp
         +YmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754269917; x=1754874717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5EHC7Bo4Tna4lRMiPBPdxLTjpzf5j4XSXmXAx1SxHbs=;
        b=XwvWP1+0vS8KpwEzG2wMl3XAw0ZPaDCOYjQge/zhZyHHAELSdKJ4UxJ8vXuy/NXc3G
         iosyjEqjAxdVAQkdpw5ccQ3chrJQZ9OSp/FA8W1qywzx3w0959+7JtizDa0rGSMtaAMK
         dAiDkqSmawEjF0ygLtP+bmgxNDs0Wzlap23CA1nce984Htj/6CQDja8M8wrPcv4WydGe
         cGGCMnmRwisBKpZyHnf+rEqc4HsJpYYFNoHzX/x9GWO8tdJyQ2TZMUceMov7w4s/P0fM
         qNhBNDj0L/QwmrdTtYCj2SFHI26gyd0Icik8FZrlJbiJCVQgm5bwbi80lowt794m3iwx
         lZtA==
X-Forwarded-Encrypted: i=1; AJvYcCUqnEQ1YzcwvXGKDBhJv4d7xVRlL1DreFrUBvuz9cruh+x5CfjMAjUCLexAKpSsyjxAW4KBANTGmoKKrM0N@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9a5VpScrKf1EDV2K73BWgjX29cgHe5Yh/DM/R5ufCdwFVfxTp
	7xHgiOWk1Frk7PSmLy8TxEwvOt1jmkd+vqh6jPKYlWCm7vpgoHjWdLBXLKRW8ELaluS347Dua0D
	eM0JRbDoWU1JviONVTo2NnqjjSuszAFLnR78rcwIxGA==
X-Gm-Gg: ASbGncuBd4tOztW3aFcwtZFkSMQZqyNWe09sfV4K6h/oFyvBG+A/3s17ESOgwC+8dtZ
	6boNOw+6RvTahQW+wegGM7FLCiqc1DqstORuHCqpH0F3B4o++BM6Ejg4mUvzU4LRey1wEXM/YVa
	sttuUusp3f3dj5xioIhCNuviKLTAuVFS7YX2mR+f9+1rwrnRkp+vegc06uP9dIZsfty/aBsQlhd
	yDHKkYMItCJTPQ=
X-Google-Smtp-Source: AGHT+IElK+avqeyYUn54//o2iNNGJM5V66RJUxPCF/JnBBNYlvcJkU9/zn67Ob/Mjz52DPZ282PLlisDVXGG6S/YoQU=
X-Received: by 2002:ac8:5a12:0:b0:4ab:7d96:bbca with SMTP id
 d75a77b69052e-4af1098b133mr128405741cf.24.1754269917325; Sun, 03 Aug 2025
 18:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-11-pasha.tatashin@soleen.com> <20250729172812.GP36037@nvidia.com>
In-Reply-To: <20250729172812.GP36037@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 3 Aug 2025 21:11:20 -0400
X-Gm-Features: Ac12FXyfTkQo6Oo5aMdGv4BzhEny3uN9Ow76q668n06TlX48YEn8zjMHGbMDq6Q
Message-ID: <CA+CK2bCrfVef_sFWCQpdwe9N_go8F_pU4O-w+XBJZ6yEuXRj9g@mail.gmail.com>
Subject: Re: [PATCH v2 10/32] liveupdate: luo_core: Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
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
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > +enum liveupdate_event {
> > +     LIVEUPDATE_PREPARE,
> > +     LIVEUPDATE_FREEZE,
> > +     LIVEUPDATE_FINISH,
> > +     LIVEUPDATE_CANCEL,
> > +};
>
> I saw a later patch moves these hunks, that is poor patch planning.

Yes, you're right. I have since moved this to uapi/linux/liveupdate.h
in the introductory patch to improve the structure of the patch
series.

> Ideally an ioctl subsystem should start out with the first patch
> introducing the basic cdev, file open, ioctl dispatch, ioctl uapi
> header and related simple infrastructure.

I have modified the patch series as follows: The rudimentary parts of
the cdev, including the uapi/liveupdate.h header, are now in this
introductory patch. The rest of the ioctl interface is added in the
old patch that introduced luo_ioctl.c.

> Then you'd go basically ioctl by ioctl adding the new ioctls and
> explaining what they do in the patch commit messages.
>
> > +/**
> > + * liveupdate_state_updated - Check if the system is in the live update
> > + * 'updated' state.
> > + *
> > + * This function checks if the live update orchestrator is in the
> > + * ``LIVEUPDATE_STATE_UPDATED`` state. This state indicates that the system has
> > + * successfully rebooted into a new kernel as part of a live update, and the
> > + * preserved devices are expected to be in the process of being reclaimed.
> > + *
> > + * This is typically used by subsystems during early boot of the new kernel
> > + * to determine if they need to attempt to restore state from a previous
> > + * live update.
> > + *
> > + * @return true if the system is in the ``LIVEUPDATE_STATE_UPDATED`` state,
> > + * false otherwise.
> > + */
> > +bool liveupdate_state_updated(void)
> > +{
> > +     return is_current_luo_state(LIVEUPDATE_STATE_UPDATED);
> > +}
> > +EXPORT_SYMBOL_GPL(liveupdate_state_updated);
>
> Unless there are existing in tree users there should not be exports.

Thank you, I have removed the exports from this patch and all others
in the series.

> I'm also not really sure why there is global state, I would expect the
> fd and session objects to record what kind of things they are, not
> having weird globals.

Having a global state is necessary for performance optimizations. This
is similar to why we export the state to userspace via sysfs: it
allows other subsystems to behave differently during a
performance-optimized live update versus a normal boot.

For example, in our code base we have a driver that doesn't
participate in the live update itself (it has no state to preserve).
However, during boot, it checks this global state. If it's a live
update boot, the driver skips certain steps, like loading firmware, to
accelerate the overall boot time.

In other words, even before userspace starts, this global awareness
enables optimizations that aren't necessary during a cold boot or a
regular kexec.

> Like liveupdate_register_subsystem() stuff, it already has a lock,
> &luo_subsystem_list_mutex, if you want to block mutation of the list
> then, IMHO, it makes more sense to stick a specific variable
> 'luo_subsystems_list_immutable' under that lock and make it very
> obvious.
>
> Stuff like luo_files_startup() feels clunky to me:
>
> +       ret = liveupdate_register_subsystem(&luo_file_subsys);
> +       if (ret) {
> +               pr_warn("Failed to register luo_file subsystem [%d]\n", ret);
> +               return ret;
> +       }
> +
> +       if (liveupdate_state_updated()) {
>
> Thats going to be a standard pattern - I would expect that
> liveupdate_register_subsystem() would do the check for updated and
> then arrange to call back something like
> liveupdate_subsystem.ops.post_update()
>
> And then post_update() would get the info that is currently under
> liveupdate_get_subsystem_data() as arguments instead of having to make
> more functions calls.
>
> Maybe even the fdt_node_check_compatible() can be hoisted.
>
> That would remove a bunch more liveupdate_state_updated() calls.

That's a good suggestion for a potential refactor. For now, the
state-check call is inexpensive and is not in a performance-critical
path. We can certainly implement this optimization later if it becomes
necessary.

Thank you,
Pasha

