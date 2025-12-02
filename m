Return-Path: <linux-fsdevel+bounces-70433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D18C9A36C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 07:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3949C3A5125
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 06:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91C12FFFA2;
	Tue,  2 Dec 2025 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6IqTdvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA52F6189
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764656312; cv=none; b=hGizRQ0ya2qs/A711/lsW8/GcxDjM9avTqnCxzrMjry2JQEEsLV7pIoUB+5VmAa6YpROk3HWpFdNYv8wAhzVIUl9r9IEBsjKZUVrmZKiJzTy9w/kebs8jgr05jgimVtv0XCDhtOcRnwseH/HXhBVZKwVGgzhMqeH3lNDaUp7+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764656312; c=relaxed/simple;
	bh=szwycVIGODyYPlntvMyXqEz3pvwBTcuUregod7hL3BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJIjmEACZ6k0EH6l5AegsBoVyipX+qqAlBhQn5vsxMULqlQ7CVM/Fj+BuC1Zh7eoAvhyQJ++VKV5Ij0yUyepE1Z68egiptGRN7jS5WxSNW6sh4u1IxAERGkb8yO8yOtCnPEnKBkonja902OcGvSOHBadKXiuAlp0M9toHwv4RBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6IqTdvs; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so7998607a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 22:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764656309; x=1765261109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPrnJL8g+8eUfEDIAPCmBoUQkj+OLnSKg2Cp5s7ZASA=;
        b=S6IqTdvs02/L2//S/Dq+qtPn+xlqrquhzLq4acv7cFhS+y8P4ag9R9EykEKzMHfltZ
         /FLQ8vVnO3xpRepgESpjU2Pi5MltsJlhqSceaWwgnKi4FMjoW8Rp0DzuYppnu/QcIWFQ
         emid9R8FXUryBmaO5foTzNxTiFLuocMMaKvLHlylw1yvW4VvJxlmVPdRzqV0nRTdvbmf
         HTVavRnX25N8bwznxKrqUFTRLr/1Tht+C/9gGvOUV1+wJLQaWqWoET25DL2FIEaRfY2Z
         QjY28t14LhZ9SLobTLnaQz/A5oGbm21GelPADbUVfSnUOnHmk7ZQjF9aSUVqpPaX2jWc
         KA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764656309; x=1765261109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPrnJL8g+8eUfEDIAPCmBoUQkj+OLnSKg2Cp5s7ZASA=;
        b=C/hyutpA9ryULbN6aKuQTJjwSakq1l8vxdzmd6oUDSTl7WjlqMOMnE16kn8+uXe0Ij
         EuVpwKt8i8sYdnnaOxNoBIdmK4DAA9iPFGDs/yffcbtPzn9aesv9qlgZwKl9pRkrpFhM
         urLaImyU+slsbcypWSD4T+jq622Bx0pFd2bgM/8ZIGFef+vNJR1NrtiU5NJkyjdAOe9m
         T/c3icmjvTuSVpY81Z/1xGfw9m9APZ3IJIJLxLFmZSD7G9/BJdmJbbUuiN2W3hs7BCH1
         vYyTLwrzlyPvhsZVSVfytgUWuhJpzXxS5UVXm5lb0qhuDuZ6ehWMkyr7ILIw9+IA7tZK
         X/Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWDEGRdMerruk/LFIRitU/3yq71aIXTSbxlP4xQ4E9YqLaY657v+O5/2L3fqgLnVRjZyV6jbUO6d13mDrgz@vger.kernel.org
X-Gm-Message-State: AOJu0YxAaCtz/s5oPNbF83zn1wawjC3w0vbID6CaUsRNpB5fZ27rEnF3
	OOkDIRDGUt4McJTzaguccJ1OlN/t4MHRQxNrM8d6CAEOG0iY+SVmNeryK8Y5h2Ki9ow3W2iVSZK
	Y5XzsgPK7wDdSMIzrPxqKItJtEIdtiCw=
X-Gm-Gg: ASbGncvDf0cle3eYWOx7Fqa1wj7XD8MKEgqjT10dEAa23enDxN7VVkQbdNLbH0OnY36
	FoR/mfHbd2J8xsCNIiBbP9hrMgYk9MdsiFEvZ+oyjTma73ItlYIrvYlGt3+6b5f1Kc4k9S8QOJw
	HptidOZew8KDFaITDIb29+6gvq24zXCuBXkHpUuWhr8eA9H1emPzcS4lhtFMjIwER8snFoFcn2x
	kR/BLjShF7auEvnsvzTq+H729/8Vyz8Wq0MOpPI7VkfXSIuhbJfAI4+tTL4bzUjiK2AeE4iImYE
	4kt86J7K3udPIWL4xIqa2e2nwH2iYODWg3Dr
X-Google-Smtp-Source: AGHT+IFiHEExsmxms5ECnObyJrUEoHdUgnkfTQ2DvugZXXJLrjajdkyNC9k7RU6suLhaVqBieP/ECQaZaUAB/FMkHO8=
X-Received: by 2002:a05:6402:27cd:b0:640:c643:75dd with SMTP id
 4fb4d7f45d1cf-645eb228cccmr27209878a12.12.1764656308602; Mon, 01 Dec 2025
 22:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201083226.268846-1-mjguzik@gmail.com> <20251201085117.GB3538@ZenIV>
 <20251202023147.GA1712166@ZenIV> <CAGudoHGbYvSAq=eJySxsf-AqkQ+ne_1gzuaojidA-GH+znw2hw@mail.gmail.com>
 <20251202055258.GB1712166@ZenIV>
In-Reply-To: <20251202055258.GB1712166@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 2 Dec 2025 07:18:16 +0100
X-Gm-Features: AWmQ_bm1bJpKrmINuK6wO614XT26O50cUkzwK5LiRoFvdgmQ-afaxJuxaPfty2A
Message-ID: <CAGudoHFD6bWhp-8821Pb6cDAEnR9N8UFEj9qT7G-_v0FOS+_vg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: hide names_cache behind runtime const machinery
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 6:52=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Tue, Dec 02, 2025 at 06:10:36AM +0100, Mateusz Guzik wrote:
>
> > So IIUC whatever APIs aside, the crux of this idea is to have
> > kmem_cache objs defined instead of having pointers to them, as in:
> > -struct kmem_cache *names_cachep __ro_after_init;
> > +struct kmem_cache names_cachep __ro_after_init;
>
> Huh?  __ro_after_init will break instantly - the contents changes with
> each allocation, after all.  What I want is
> static struct kmem_cache_store names_cache;
>

c'mon man, I copy pasted the existing line and removed the asterisk to
de-pointer it to make for illustrative purposes. You went straight to
description how to make your idea happen, so I wanted to make sure we
are on the same page on what it is.

> As for the many places to modify...
>
> fs/file.c:390:  newf =3D kmem_cache_alloc(files_cachep, GFP_KERNEL);
> fs/file.c:422:                  kmem_cache_free(files_cachep, newf);
> fs/file.c:514:          kmem_cache_free(files_cachep, files);
> include/linux/fdtable.h:116:extern struct kmem_cache *files_cachep;
> kernel/fork.c:429:struct kmem_cache *files_cachep;
> kernel/fork.c:2987:     files_cachep =3D kmem_cache_create("files_cache",
> samples/kmemleak/kmemleak-test.c:52:    pr_info("kmem_cache_alloc(files_c=
achep) =3D 0x%px\n",
> samples/kmemleak/kmemleak-test.c:53:            kmem_cache_alloc(files_ca=
chep, GFP_KERNEL));
> samples/kmemleak/kmemleak-test.c:54:    pr_info("kmem_cache_alloc(files_c=
achep) =3D 0x%px\n",
> samples/kmemleak/kmemleak-test.c:55:            kmem_cache_alloc(files_ca=
chep, GFP_KERNEL));
>
> I would argue for making it static in fs/file.c, where we have the grand
> total of 3 places using the sucker, between two functions.
>

The claim was not that your idea results in insurmountable churn. The
claim was *both* your idea and runtime const require churn on per kmem
cache basis. Then the question is if one is going to churn it
regardless, why this way over runtime const. I do think the runtime
thing is a little bit less churn and less work on the mm side to get
it going, but then the runtime thing *itself* needs productizing
(which I'm not signing up to do).

Per the previous e-mail I don't have a strong opinion myself and it is
the mm folk who need either idea sold to anyway.

