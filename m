Return-Path: <linux-fsdevel+bounces-23912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95593934B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C022B1C22586
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EEE12C473;
	Thu, 18 Jul 2024 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Wf5tDLnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE248286D
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296864; cv=none; b=CRi9h74qTxdLFxEtuzfh/Gy/p/Yw6nKg3Sq4SriyNJ6SHAnAH8LBam8hJrc5DF4Zo4bb6dMPK1Gvx3spPXCEvKTocCsj5jehGnNNcHyYx0u3JEdNPcs8PRc0IVxzVgOUO4hnpgD9WPgwKQXc+JPRhWoz1mRUk3BA1WN81cgKitM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296864; c=relaxed/simple;
	bh=PVKzFBjUylgl+SFX+eVz4j3ekjHizvwoGKwdu26z3lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtCO3KayvvvRRqwWgNukosw1D6G+bois1l748TOxXjx78OocxzVwt3iPDflyBR+kpKbGOHEGpNEKxJSE6NUo+SAxbnJKEQOMtiZM1ZSPj7F6UCio+deCG5wKXpvQYOCn++fEHxhLESsXyQwpQj4j07Ax/9EhDRBYPr6VBDGRv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Wf5tDLnK; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E825E400E7
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 10:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721296854;
	bh=8LsyU/bDvYfIu4r+7OnoQP5eYa7svy7lWN7+7+yiUFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Wf5tDLnKuY6XncQhAqEwssfUkujRxU6FaRZ00lo5XWZQv/+5Buk4D5GkUKbW9jmEs
	 hU0aenf2/SFIY5sfEV2yayKSzGwVuYOfBWyLH8fruLvF5BhXarUSvjzYJZ/1dJIzug
	 +zMoj7R8BcmTwI3sKC5bYr/wszFYYhWtwxBYfW5QrVL5gRJU3GlX9PDFVMPGz47Z56
	 5ZAimU4Zw76Of7bC3Z/OjNPsskHemkOi86im4F1qK71Q+sy9dTbai1SAZh5cJ1hIbR
	 zV9+lfzNyw06smxE8wLmauomzRj9uI+gJVKtWoOLga+5lSYeG8DKw3EooPPtLPWuqR
	 EP8R4g9HusJNA==
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-81f870378aaso294887241.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 03:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296853; x=1721901653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LsyU/bDvYfIu4r+7OnoQP5eYa7svy7lWN7+7+yiUFA=;
        b=vrus6LuBpdBSWweyAENScBWJVaTnEH2q7Xw9rU/YHiyWAL9Kxz4EnzJ4CVOSChOerW
         q6O/Ak0wCSCUeZjflSSEt9LxpsyjQXVxoY0S6rL5jkksECWi8eVIRZD0mtY5iCO2crEm
         fO/pCLdz6AwSQDdtvfg+3HwywwvCf7Yt0cWveawLbu5ZDkUzOP5Heby+VdohiAiFvfnZ
         9Yhv6JXvfaeyw/hH2meOx7A5vakHBnB+EV+hsHErpdvPbqGXjXrqmVy3izHSn4wi9y7L
         K6o8ZrGps0T5lO6EweTRNTxOUHxDLBdYxi1rp44ch7Q2u8itbtKpic/9V1Rxde72zr2k
         CcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUouCwG/owQMnYLqsbZaJmh8bggab35WqHWFS4NC6OPF3wHNSVRyLoJ63cPOTDaXWrGqAZG7C/MjipWUIUSjaXwtA6QhhlnxbBNWXhalQ==
X-Gm-Message-State: AOJu0Yzhce8u3IJh6TfomlpcLu8l13Y1xByR8zGYf0aob8IrcaBIoOYO
	i7oAXZ6OCrygVfYEWHJ2qEmlApVc5o2VVGRardBc4fz4rUv7X+DVNEMiyAlcbWVbCpqZIOU7cqg
	fMoJPGOyr2s+OxYZGPd1R3QeHtp90qSv3YcqsrTtxf7mjt5VRr9W711kbx+l0cUFOe5dqpEIn5+
	fubH/61M+o9uXtIPNuqvYRlE61A9bNSt3OPXi31czbfex5qpJJN9X/0Q==
X-Received: by 2002:a05:6102:5348:b0:48f:e68d:bdc6 with SMTP id ada2fe7eead31-49159a2eff7mr5727769137.33.1721296851017;
        Thu, 18 Jul 2024 03:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqJKCH3G3nyP+aVB8d0rCp17Ac0e3EmSJIvfmYYqEiGnQ4Po6sCBParIO6wIwVz03HPaymow75Y6ld3Wl9FUI=
X-Received: by 2002:a05:6102:5348:b0:48f:e68d:bdc6 with SMTP id
 ada2fe7eead31-49159a2eff7mr5727736137.33.1721296850693; Thu, 18 Jul 2024
 03:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
 <20240105152129.196824-3-aleksandr.mikhalitsyn@canonical.com> <CAJfpegsttFdeZnahAFQS=jG_uaw6XMHFfw7WKgAhujLaNszcsw@mail.gmail.com>
In-Reply-To: <CAJfpegsttFdeZnahAFQS=jG_uaw6XMHFfw7WKgAhujLaNszcsw@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 18 Jul 2024 12:00:39 +0200
Message-ID: <CAEivzxc4=p63Wgp_i+J7YVw=LrKTt_HfC5fAL=vGT9AXjUgqaw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] fuse: use GFP_KERNEL_ACCOUNT for allocations in fuse_dev_alloc
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mszeredi@redhat.com, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 12:01=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Fri, 5 Jan 2024 at 16:21, Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > fuse_dev_alloc() is called from the process context and it makes
> > sense to properly account allocated memory to the kmemcg as these
> > allocations are for long living objects.

Hi Miklos,

Sorry, this thread just got lost in my inbox. I was revisiting and
rebasing fuse idmapped mounts support series and found this again.

>
> Are the rules about when to use __GFP_ACCOUNT and when not documented som=
ewhere?

The only doc I found is this (memory-allocation.rst):
>Untrusted allocations triggered from userspace should be a subject
>of kmem accounting and must have ``__GFP_ACCOUNT`` bit set.

>
> I notice that most filesystem objects are allocated with
> __GFP_ACCOUNT, but struct super_block isn't.  Is there a reason for
> that?

I guess that it just wasn't yet covered with memcg accounting. I can
send a patch to account struct super_block too.

These days, it's pretty safe to use __GFP_ACCOUNT almost anywhere,
because even if memcg is not
determined in a current caller context then memcg charge will be
skipped (look into __memcg_slab_post_alloc_hook() function).

Let's ask what our friends who take care of mmcontrol.c think about this.
+CC Johannes Weiner <hannes@cmpxchg.org>
+CC Michal Hocko <mhocko@kernel.org>
+CC Roman Gushchin <roman.gushchin@linux.dev>
+CC Shakeel Butt <shakeel.butt@linux.dev>

I have also added Christian because he might be interested in
accounting for struct super_block.

Kind regards,
Alex

>
> Thanks,
> Miklos

