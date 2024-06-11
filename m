Return-Path: <linux-fsdevel+bounces-21378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7B5902FD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 07:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6490CB21E07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 05:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179B4170859;
	Tue, 11 Jun 2024 05:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPLgoAVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E63469D;
	Tue, 11 Jun 2024 05:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083077; cv=none; b=rDPkY8OkdY4CE6NP/N/J8C6FwK4pMbY/OR9lXklQrzZslZEGaAIZbhIMr6FmctFOYGYeh1TtZ3Q6GIvtFEtEubvUZWg4OVmPK8Gl2i9aMMMLOE7LF+t3ddTf7EPLwovIBhdXCvaQUC5xPnVQ9TqrkWC2Y35PM1oqbHaRUefJV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083077; c=relaxed/simple;
	bh=AfWFA0YQaEAWvwqUx+29BJvkXlvDyjanEfD3MpXz1tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pa3xroA0y8ZGRVT4etzSDB1I95vPXQPaSWXjaK8dnqJF/TqUxy2Koc7wIuZVHXVyLZ/UdgAXwNyceqjMwZmb+kQZu1JNC6wcQLIKZYoZjyKI+lOAeFAJ/BLLO1UnJxPoIIRghYCAkzEWT19elPlJ5DkaNBIQ5H7LiFQ1Ryn4Nmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPLgoAVz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so775206a12.1;
        Mon, 10 Jun 2024 22:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718083074; x=1718687874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piqzYbgJkU+e1s69JwjuEdZoLPDUayYPpapi3Ayym5o=;
        b=aPLgoAVzWQ2XWEUT9RY7KcVkO8ibXonuMNUEgtmzDVXoo/Sy+45+0qosCCV5pWKeSb
         vGSfXnaqdsZSte87fDyZPCItpOylY6v6jZkfyS716/duvuI06CuLKrGma0nYJqbq02zP
         EtYLl1sILQJszneDPBav1g/qiCHelvzkQrByBOG7cXpKawUCHbYFP1qOcUeimCEyIqCA
         12tXauML4ys26/2JQUTjkP53N5bAIZ7kP9yGxLbmCm3NOZ8CvF9hnvhrpFvvJvvu4BdR
         f8hx0OCDoH7iJ99z7XYYKHlaQAudImJui14tgVHzK01yuss6G/VWGUXGpFvJbVqBIkvK
         ANtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718083074; x=1718687874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piqzYbgJkU+e1s69JwjuEdZoLPDUayYPpapi3Ayym5o=;
        b=OKheA5F1zQQXApuWf+HFk5/gTPT1/8F0I3qshdbV2xLJ9EK0PfeuYzkb3e+wyaeU4G
         Clx3+w/RTVFBqbOrMAqXFx8XzktBEEpT7S9t98S636eUZWut5Ls/KdD7zoj+1QwjIic5
         ivEtKaH2TllwOH3xewF6v+ZJYJFpuVVZibIEI0Y0RULTfwt2UMu1g6XynihGKt4sdxf8
         WmbWA+y3AXjuw0KGOpQm4D34szrXsRz22W6ex00WRV263SNp4bTAA3n7gvpVWN1xNeqV
         3LMrgXQMo+OpdKTG1Xk18zmd5Y4mGNlsMG74QUOQw2nVor2+vDYnj/SY+xyjdW2YGSFJ
         8t9A==
X-Forwarded-Encrypted: i=1; AJvYcCXFwpk/rGXOVymkD6GhBXMCoXvrg7eLoT6jOt0jQp6eVBXbhm01LvgSAE08Gd8LJJekV/uKikVauUJfWUbLGo09cK+3SKe82cf4eZaJOWSeKT0PxW7QjD19NMZIMUijUqP7ws7BsGWqOhCif/CpKnEC7VieBg1RG1jU2E7EghW/ff1F24Y+iP3S
X-Gm-Message-State: AOJu0Yz5pkD05ItHAicBZm9oBqJ4UN6BLDexZ/XwTJ+VNz6VXimk6osE
	4wpHIKYrAFHkQaK+s3EZiyGxyMMtv/0gdkAIqWXszf10B7AUZrwCFXRPo2H56KncsbRIljGxvJM
	oMrrtBb19iDVArE2PuuFDI831f9dAPol5
X-Google-Smtp-Source: AGHT+IG0gbTyrx993BiiW+MsuA3vxBABCx7Y+PzZsgs9teddxdS3/i8h8NVX0MVv7EEpnBboLgYgHyF7NTwCsiFT9GA=
X-Received: by 2002:a50:d657:0:b0:57c:6bd6:d8e5 with SMTP id
 4fb4d7f45d1cf-57c6bd6de01mr5139006a12.8.1718083073841; Mon, 10 Jun 2024
 22:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610195828.474370-1-mjguzik@gmail.com> <20240610195828.474370-2-mjguzik@gmail.com>
 <ZmfZukP3a2atzQma@infradead.org>
In-Reply-To: <ZmfZukP3a2atzQma@infradead.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Jun 2024 07:17:41 +0200
Message-ID: <CAGudoHE12-7c0kmVpKz8HyBeHt8jX8hOQ7zQxZNJ0Re7FF8r6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfs: add rcu-based find_inode variants for iget ops
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 6:59=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > +EXPORT_SYMBOL(iget5_locked_rcu);
>
> EXPORT_SYMBOL_GPL for rcu APIs.
>

noted for v3, thanks

> > +static void __wait_on_freeing_inode(struct inode *inode, bool locked)
> >  {
> >       wait_queue_head_t *wq;
> >       DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
> >       wq =3D bit_waitqueue(&inode->i_state, __I_NEW);
> >       prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> >       spin_unlock(&inode->i_lock);
> > -     spin_unlock(&inode_hash_lock);
> > +     rcu_read_unlock();
> > +     if (locked)
> > +             spin_unlock(&inode_hash_lock);
>
> The conditional locking here is goign to make sparse rather unhappy.
> Please try to find a way to at least annotate it, or maybe find
> another way around like, like leaving the schedule in finish_wait
> in the callers.
>

So I tried out sparse on my patch vs fs-next and found it emits the
same warnings.

fs/inode.c:846:17: warning: context imbalance in 'inode_lru_isolate' -
unexpected unlock
fs/inode.c:901:9: warning: context imbalance in 'find_inode' -
different lock contexts for basic block
fs/inode.c:932:9: warning: context imbalance in 'find_inode_fast' -
different lock contexts for basic block
fs/inode.c:1621:5: warning: context imbalance in 'insert_inode_locked'
- wrong count at exit
fs/inode.c:1739:20: warning: context imbalance in 'iput_final' -
unexpected unlock
fs/inode.c:1753:6: warning: context imbalance in 'iput' - wrong count at ex=
it
fs/inode.c:2238:13: warning: context imbalance in
'__wait_on_freeing_inode' - unexpected unlock

The patch does not make things *worse*, so I don't think messing with
the code is warranted here.

> > +extern struct inode *ilookup5_nowait_rcu(struct super_block *sb,
> > +             unsigned long hashval, int (*test)(struct inode *, void *=
),
> > +             void *data);
>
> No need for the extern here (or down below).
>

I agree, but this is me just copying and modifying an existing line.

include/linux/fs.h is chock full of extern-prefixed func declarations,
on top of that some name the arguments while the rest does not.

Someone(tm) should definitely clean it up, but I'm not interested in
bikeshedding about it.

--=20
Mateusz Guzik <mjguzik gmail.com>

