Return-Path: <linux-fsdevel+bounces-22850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E2491DA42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EFBB2260E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE5A84E1E;
	Mon,  1 Jul 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+0rYqNJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42C8289C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823317; cv=none; b=TN7+gEvKxTaEjen95AeLHZtqfd33RRaPmaKKttDLGLlo+gwDgD+n1Xw6uOUi9FytummgsQXorlzUIIszMfhyKtBnPJkflvvzudu+Jy8xAYxsu2ESzKZqrKazErliucMEUlBMYQzhxm/mYjtItoiULcZ087uIginiJ4zXKiEoFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823317; c=relaxed/simple;
	bh=98/yARMgR7LwngA3FFhVlRw2ly6+sDcbpTvJSV5r3Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inJfEE9rxcZbJ5cD6/9XXdqNKLvKRcXtdHrNSKg4t8nOuKgP1YZT7VWoGd4CqdPGjUbYpkFo7mbQgIAUYvV5e/KTdwrNRp/E2WWowIWtRS6/xeu9unLzKr8Fq/y4zlIx3jIh4mJFavHfoE0yIt0YB/Gre6CyRBmhHXJ8ympgau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+0rYqNJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719823314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFuYJuF23ilR26DvtLr3NKMhW/7ERM9own7UOA3paPg=;
	b=S+0rYqNJI77GibFWKNz2rbPwv4vaQv8r0RvjRWI2LkNHtOQODdquO68CuXSVMOLOGDmt79
	amjahKJwtqprijqNjH3JtbUqXkD0PcknuUhtEvAwOdWVID9Ke1woLbMThkeei2AMsyH6r7
	hrZkRdTHSh51g1HebWWmT66H2SlJL2w=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-HQlmFNa0Njam5cR8zlTOWg-1; Mon, 01 Jul 2024 04:41:52 -0400
X-MC-Unique: HQlmFNa0Njam5cR8zlTOWg-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3765604de70so33367915ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2024 01:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823312; x=1720428112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFuYJuF23ilR26DvtLr3NKMhW/7ERM9own7UOA3paPg=;
        b=gAFQk8+OzlpWZbZSjpFrcoRMlyQKKsWB4v3fCN28SH/kGBKncsHW6jTwyhFLO9j+qx
         FoeMAStiPYvd79niSknG7p2Vz6Iit5dkY6oUsbNGFXzZVkV9MB6eBIPJys5IDMCQ7xAR
         UGmbdGKKIiiqEIhSduTPDy6nSdacNvbSM08wPgDqwFUcjkMvXNWU4X4aBlBu0A2sktVG
         QO3xEMcsfrxI7xkib5Tax2nguu85ABWXlNYIh6xrPxgtlhiG2tkw+RkD1slYThW/a7MK
         nGIuRRujDNFbjewU3JF6fMZpN1huiOMQxOyrXhJpZvSEFSoVanHg2MNqqagMe8mnrYEt
         HyIA==
X-Forwarded-Encrypted: i=1; AJvYcCUkJO9RtXkZGtzqbhQpkz6PrtQU/MIBhMoxOaADvpV+I2TbPMdrZo0Z9Og7UIqfmiYiTof8JiDqOU5oaoKDKLsqLkDeJgVb8sdceX5lUQ==
X-Gm-Message-State: AOJu0YxN+3sd0AicKHjNW7KHj+OhFeZsnCO2Z4kAiR/9ikkWmz+/hNuu
	/SIqJfwxzGLcrkNrctd5eH6djtEl1vZnTRVjawXL6PwttJ5pzhN14k+/Hgg1hEF6l0htehPV5W4
	GLba9eFjyl4yPkTxhUk1fJ9HZMPlNJKy7ft2zknkdFKSwAdWDnnIJ6V0xgoR5IhiVBJvIzfGY4a
	F7Ihh+TIen1DY7XhTFow4ggB7HI0LlkjFmbLKhQw==
X-Received: by 2002:a05:6e02:18c6:b0:376:3e9c:d9a8 with SMTP id e9e14a558f8ab-37cd169a012mr60188065ab.9.1719823311923;
        Mon, 01 Jul 2024 01:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ3y4drjAYdSWs4QiL8X7hDAC6CgqCfAJPZG5DjOd5WCm0ZkwSvXgxmwb93eBH/DXOt6glH8WwXWNWRBJw1cw=
X-Received: by 2002:a05:6e02:18c6:b0:376:3e9c:d9a8 with SMTP id
 e9e14a558f8ab-37cd169a012mr60187965ab.9.1719823311695; Mon, 01 Jul 2024
 01:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626201129.272750-2-lkarpins@redhat.com> <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org> <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3> <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com> <20240628-gelingen-erben-0f6e14049e68@brauner>
 <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
 <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com> <20240701-zauber-holst-1ad7cadb02f9@brauner>
In-Reply-To: <20240701-zauber-holst-1ad7cadb02f9@brauner>
From: Alexander Larsson <alexl@redhat.com>
Date: Mon, 1 Jul 2024 10:41:40 +0200
Message-ID: <CAL7ro1FOYPsN3Y18tgHwpg+VB=rU1XB8Xds9P89Mh4T9N98jyA@mail.gmail.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>
Cc: Ian Kent <ikent@redhat.com>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk, raven@themaw.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Chanudet <echanude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 7:50=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > I always thought the rcu delay was to ensure concurrent path walks "see=
" the
> >
> > umount not to ensure correct operation of the following mntput()(s).
> >
> >
> > Isn't the sequence of operations roughly, resolve path, lock, deatch,
> > release
> >
> > lock, rcu wait, mntput() subordinate mounts, put path.
>
> The crucial bit is really that synchronize_rcu_expedited() ensures that
> the final mntput() won't happen until path walk leaves RCU mode.
>
> This allows caller's like legitimize_mnt() which are called with only
> the RCU read-lock during lazy path walk to simple check for
> MNT_SYNC_UMOUNT and see that the mnt is about to be killed. If they see
> that this mount is MNT_SYNC_UMOUNT then they know that the mount won't
> be freed until an RCU grace period is up and so they know that they can
> simply put the reference count they took _without having to actually
> call mntput()_.
>
> Because if they did have to call mntput() they might end up shutting the
> filesystem down instead of umount() and that will cause said EBUSY
> errors I mentioned in my earlier mails.

But such behaviour could be kept even without an expedited RCU sync.
Such as in my alternative patch for this:
https://www.spinics.net/lists/linux-fsdevel/msg270117.html

I.e. we would still guarantee the final mput is called, but not block
the return of the unmount call.


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com


