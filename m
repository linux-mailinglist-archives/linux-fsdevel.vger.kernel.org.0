Return-Path: <linux-fsdevel+bounces-69465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACDDC7BC1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 22:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8DE3A502E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 21:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4F6305070;
	Fri, 21 Nov 2025 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FU5oByk/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39627F16C
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763760686; cv=none; b=JjMWSOD/aWikb1YupgEc9zatIxfNZpUg1mmqN+QJkbBv9gJhWuvFFg4+JumFBWO/DloEP/L819mlD6EJXsIBoS4rIOcd+IyBxzkM0Z/nQOYEAG28EnSigxQT/IHJ/FbscPed75KrFW2WkqehymOUtdV45DcMBxbPNvc98TH4LsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763760686; c=relaxed/simple;
	bh=51TGYrsgBnz8fkKL33FrJi93VLUlmGwP1Py2nYzy7Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myKoHN4ItiiPiWlrwx1As0FPtQr2lgu5K2dpJGDtMpQ1Ul6HX+1sKpO4xxkaKH5AB56dF+4Fzzq/IyBo2KbO2sst194SEh9pFVy10OUtCU5FLVyaXxsHfJOd9i64osHHvaYtCZxkOF+blzOaZeKBLgvRpb1AxYDdoHRcYxZWmiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FU5oByk/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso3732585a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 13:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763760683; x=1764365483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+byFGoWk/0V52ELeDrnzRQimZK8yvBtN44GDPwhdBk0=;
        b=FU5oByk/BiqfVPKMhVP7o1j5ToDaGm2herCIdfHyX0U1BClwhkrpvFnCtkRXaJi0fV
         R6Ghd2xkNVUgtCk9p6OqW7tSGhKgZutrM5qu9cplMQbg5FB32aCyJrRG4dD+7rAAy9dy
         4qKRZyQuTKBNRZlY+Ttkc+L4nNSyfFMbsJIrckmwbnpYXSOMdbF+6rk1BCE0EcUcBqaz
         xYybISBe3KW3FZdkSrarJBM/JLcr6odNMBCa9G5Cs8ptmX29joJkqcaV73ag62rOXMGq
         pd00qHzOIcoKZ1/9PEk6mX/ZUp8rQbGu8SXmORkLkdtLP92kX7wIAQC/QGiKChj5JIrQ
         Sxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763760683; x=1764365483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+byFGoWk/0V52ELeDrnzRQimZK8yvBtN44GDPwhdBk0=;
        b=Eoq1PMrXi7w6yjbKM1XT4x32Ai//TErgWE+6sweCS2ub7MKlmFUwQbkIn9G8Tr0PLM
         19uwJCUyNGsFwlx5XfLe1m0jeKbZhoL83PH+9jCAcYFVZgSDE8awlG+5zSE06FidjUlP
         MFSi0Y4O/vvQv2rQN5Cf/XQILuHoS7TcATPzdAS/i+AZL1rOUzS42oxHkSCwnAhfNh9W
         /KpXCPHhtPpz3I4dJeSr5XSmakVNn/UyF4ZqF5/doWlkcKJ7m1dlCOR82FgQunsoQdKX
         nhDy3i2hoXQyrVWI2oKDXePeyhGJRTCMge6Lq7a2UPPv8WqucRWpUcljFqq/R7kvQvEd
         fuOg==
X-Forwarded-Encrypted: i=1; AJvYcCUgUpAGM/CMGEKdFA/T6mO8Kpr1/3Cfm3uvIwSCgUdPD/xJ/lWmQjhXX3pc0XogDPkvr8xpEgzrKwfO2Q3x@vger.kernel.org
X-Gm-Message-State: AOJu0YyeVzBclV0aOGRZ3c7yJGWdM8jf99ib4JMTThmJyy2yV8ZJul1D
	w/K16RTus+FKe4ZUz0F7A1KCYA1wGAb56sT6On/zBLx1G3mEvIGRwPnq8y2D3EMQZJiC+MIVR/f
	D9ldkTJ93GKVozWCuBc4zd6swYIw5BGuJIY0CUjj8uQ==
X-Gm-Gg: ASbGnctb5Tl+g+FoDx5GlzZ7t88IVBo62Z8duvgf6X+zxlW7Y0fL8PrHvQcknz3Tmbu
	rmXTtSkTI/mTBodztjoEM7qAXsf5uaq2UXs6TstNz6fTvWGQ7pKNTl1I5XmS3daqBjM7lK/972F
	/D2MK7IJy4vy+ocu+cd23gtbauqynZ2NVj1GoK6cpaMYbn8AIkhJzKlhqAf5LpZOJFYG2h6AUUl
	uwMmXgwBbcB8KUyRnppdP+YmTGc1osadxCeaw3MUuc6L+OfP3Nw4VEhTZ8aHzKETIjN
X-Google-Smtp-Source: AGHT+IHb/TNH6HpXoXxdJqBqtls7NiUE5U9WcaIN1X3bEaIYHVHMwMKVOTZ0kii/oe8jLFgQnVtKbwI5uYAd2wY8FI4=
X-Received: by 2002:a05:6402:20d1:10b0:640:f8a7:aa25 with SMTP id
 4fb4d7f45d1cf-64555d0426fmr2711637a12.30.1763760682926; Fri, 21 Nov 2025
 13:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-5-pasha.tatashin@soleen.com> <mafs08qfz1h3c.fsf@kernel.org>
In-Reply-To: <mafs08qfz1h3c.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 21 Nov 2025 16:30:46 -0500
X-Gm-Features: AWmQ_bmySwNVArPJNxXTzBmV6LhGk1Wdy9I8BgPPnIaZuGaVx8wlezdZ8VKPhXs
Message-ID: <CA+CK2bDSSJhjx8fH1rsb3unS099pKWze-=WX1B2ZnE0LCMXUAw@mail.gmail.com>
Subject: Re: [PATCH v6 04/20] liveupdate: luo_session: add sessions support
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> >  /*
> >   * The LUO FDT hooks all LUO state for sessions, fds, etc.
> > - * In the root it allso carries "liveupdate-number" 64-bit property that
> > + * In the root it also carries "liveupdate-number" 64-bit property that
>
> Nit: This needs a bit of patch massaging. Patch 2 added the typo, and
> this patch fixes it. It would be better to just update patch 2.

Yeap, this is fixed.


> > + * This structure is located at the beginning of a contiguous block of
> > + * physical memory preserved across the kexec. It provides the necessary
> > + * metadata to interpret the array of session entries that follow.
> > + */
> > +struct luo_session_header_ser {
> > +     u64 pgcnt;
>
> Why do you need pgcnt here? Can't the size be inferred from count? And
> since you use contiguous memory block, the folio will know its page
> count anyway, right? The less we have in the ABI the better IMO.

Right, I had pgnct because my allocators were using size as an
argument, but we removed that, so pgcnt can also be removed.

> Same for other structures below.
>
> > +     u64 count;
> > +} __packed;
> > +
> > +/**
> > + * struct luo_session_ser - Represents the serialized metadata for a LUO session.
> > + * @name:    The unique name of the session, copied from the `luo_session`
> > + *           structure.
> > + * @files:   The physical address of a contiguous memory block that holds
> > + *           the serialized state of files.
> > + * @pgcnt:   The number of pages occupied by the `files` memory block.
> > + * @count:   The total number of files that were part of this session during
> > + *           serialization. Used for iteration and validation during
> > + *           restoration.
> > + *
> > + * This structure is used to package session-specific metadata for transfer
> > + * between kernels via Kexec Handover. An array of these structures (one per
> > + * session) is created and passed to the new kernel, allowing it to reconstruct
> > + * the session context.
> > + *
> > + * If this structure is modified, LUO_SESSION_COMPATIBLE must be updated.
> > + */
> > +struct luo_session_ser {
> > +     char name[LIVEUPDATE_SESSION_NAME_LENGTH];
> > +     u64 files;
> > +     u64 pgcnt;
> > +     u64 count;
> > +} __packed;
> > +
> >  #endif /* _LINUX_LIVEUPDATE_ABI_LUO_H */
> [...]
> > +/* Create a "struct file" for session */
> > +static int luo_session_getfile(struct luo_session *session, struct file **filep)
> > +{
> > +     char name_buf[128];
> > +     struct file *file;
> > +
> > +     guard(mutex)(&session->mutex);
> > +     snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
> > +     file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
>
> Nit: You can return the file directly and get rid of filep.

I prefer returning error here.

>
> > +     if (IS_ERR(file))
> > +             return PTR_ERR(file);
> > +
> > +     *filep = file;
> > +
> > +     return 0;
> > +}
> [...]
> > +int __init luo_session_setup_outgoing(void *fdt_out)
> > +{
> > +     struct luo_session_header_ser *header_ser;
> > +     u64 header_ser_pa;
> > +     int err;
> > +
> > +     header_ser = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
>
> Nit: The naming is a bit confusing here. At first glance I thought this
> was just allocating the header, but it allocates the whole session
> serialization buffer.

I made it a little clearer by adding "outgoing_buffer" local variable,
and then assigning head_ser to this local variable.

> > +     if (IS_ERR(header_ser))
> > +             return PTR_ERR(header_ser);
> > +     header_ser_pa = virt_to_phys(header_ser);
> > +
> > +     err = fdt_begin_node(fdt_out, LUO_FDT_SESSION_NODE_NAME);
> > +     err |= fdt_property_string(fdt_out, "compatible",
> > +                                LUO_FDT_SESSION_COMPATIBLE);
> > +     err |= fdt_property(fdt_out, LUO_FDT_SESSION_HEADER, &header_ser_pa,
> > +                         sizeof(header_ser_pa));
> > +     err |= fdt_end_node(fdt_out);
> > +
> > +     if (err)
> > +             goto err_unpreserve;
> > +
> > +     header_ser->pgcnt = LUO_SESSION_PGCNT;
> > +     INIT_LIST_HEAD(&luo_session_global.outgoing.list);
> > +     init_rwsem(&luo_session_global.outgoing.rwsem);
> > +     luo_session_global.outgoing.header_ser = header_ser;
> > +     luo_session_global.outgoing.ser = (void *)(header_ser + 1);
> > +     luo_session_global.outgoing.active = true;
> > +
> > +     return 0;
> > +
> > +err_unpreserve:
> > +     kho_unpreserve_free(header_ser);
> > +     return err;
> > +}
> [...]
> > +int luo_session_deserialize(void)
> > +{
> > +     struct luo_session_header *sh = &luo_session_global.incoming;
> > +     int err;
> > +
> > +     if (luo_session_is_deserialized())
> > +             return 0;
> > +
> > +     luo_session_global.deserialized = true;
> > +     if (!sh->active) {
> > +             INIT_LIST_HEAD(&sh->list);
> > +             init_rwsem(&sh->rwsem);
>
> Nit: it would be a bit simpler if LUO init always initialized this. And
> then luo_session_setup_incoming() can fill the list if it has any data.
> Slight reduction in code duplication and mental load.

These are now statically initialized.

>
> > +             return 0;
> > +     }
> > +
> > +     for (int i = 0; i < sh->header_ser->count; i++) {
> > +             struct luo_session *session;
> > +
> > +             session = luo_session_alloc(sh->ser[i].name);
> > +             if (IS_ERR(session)) {
> > +                     pr_warn("Failed to allocate session [%s] during deserialization %pe\n",
> > +                             sh->ser[i].name, session);
> > +                     return PTR_ERR(session);
> > +             }
> > +
> > +             err = luo_session_insert(sh, session);
> > +             if (err) {
> > +                     luo_session_free(session);
> > +                     pr_warn("Failed to insert session [%s] %pe\n",
> > +                             session->name, ERR_PTR(err));
> > +                     return err;
> > +             }
> > +
> > +             session->count = sh->ser[i].count;
> > +             session->files = sh->ser[i].files ? phys_to_virt(sh->ser[i].files) : 0;
> > +             session->pgcnt = sh->ser[i].pgcnt;
> > +     }
> > +
> > +     kho_restore_free(sh->header_ser);
> > +     sh->header_ser = NULL;
> > +     sh->ser = NULL;
> > +
> > +     return 0;
> > +}
> [...]
>
> --
> Regards,
> Pratyush Yadav

Thanks!

Pasha

