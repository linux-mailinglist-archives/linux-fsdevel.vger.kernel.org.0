Return-Path: <linux-fsdevel+bounces-35317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EE29D399A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884781F22066
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5529C1A01C6;
	Wed, 20 Nov 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4CLpfn8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B60199E84;
	Wed, 20 Nov 2024 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102629; cv=none; b=Q+R+pwjLZKy61dfln1mAlcXO328Zh11VvLflW5bNUSHhoPX/cRCNUCo3f/WULN/9XY6QvAajtWyrQqmrRUKvteCzB+6xWF1lXHH74fm7fAYFyc5FhpU6OnJix07WosEfuC8vsDPrF8xSGD+ApdcCYb1ZlT5QcTWp4MAV1Atlleo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102629; c=relaxed/simple;
	bh=WXyTkhgO9PBh1mEZg0phtzXcE5QutKufLO4I2F//yo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJUpfaHAulu1aBD7eUsrbdbd4K6AFrGkr26esfNb12H4tXcfOUrBLyuBaiBllKnCfYuGCPN+3gcdrtUTOKGWop3dWsEqTXa0LRcBzaXcYZUaE9q9mQLi4SpRnfYbJrnHnd6OkNuIok9NDUMqazAhP5kvy95oVxmTPC3BcF14DhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4CLpfn8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa4cb5fcc06so331208266b.0;
        Wed, 20 Nov 2024 03:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732102625; x=1732707425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjBVxK9rXt0t3MRbp/9z40eDvzoHWwNmyXmndFIb6s0=;
        b=I4CLpfn8a/EoYWZt2sVHzKRZohsqOVFGwNVUIwM3qZE4OuPXxU5HBO9IMMzR3CUaaX
         z+6Zs24IUQNByA7J57vXqoVWN7F2PaKRyIfSRAwwzseg8T6gBSyalfpJGojEdlCap2ou
         ptSc9EJoEe4bjz7vZISVh2SxdUF18/M/kO3xVNOdc3N/dG8rqeZL6bsps5BnuoC6VG0n
         gA2hBcbvRPz2kvjpFdZstyiTM5XiQmNLhJAC87/jLnQcNLjEsobaEonbiVgdmHPKQgQa
         AFzuR6Y2WmHF2n+l/8iGiLk0LB7VSeohVTnMq7pjWR5rFZWjMrO5DdfkHOy/gDp+F9Jj
         NleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732102625; x=1732707425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjBVxK9rXt0t3MRbp/9z40eDvzoHWwNmyXmndFIb6s0=;
        b=SCznlAO20a/47cLyvtT/UvYUEFUiQWQRN77uUs33Wh4AGfjmQebThrJiYcfHlkxeFq
         PrMqRGLWxTIl+LlO6rCSNzF4Z+QkYEWHeLjTejuIkhExKf3++zmvJldgSIFuq4Zgv5JB
         2/EfvKv5IFdReIe3If7ObYQ8Y54Ui8rT3zYBxHvRgCTthCxzMhvzp/nvVVeFd0+2yk/e
         0Lf4aBvLPOwnlVduU1dH3Q8+wGwPQloZmvghXnF3hdOMT9gCXcH/E6J36sMx90Mcxklx
         DQS33DQj4xKdtOI7FMu4Q/BDB0N+oDuBgyrpz6MgSK7vcoJLcq94t6DpgfZ/hK6u2/yG
         kGpw==
X-Forwarded-Encrypted: i=1; AJvYcCUA6ew1aw4LETG0qViZjctLJWBjf3SadiP4rZddd5bfq5dE6qqbBaWwTmwTmz/AsWM+mmWAOWiONi/Vxw==@vger.kernel.org, AJvYcCVcqVLHTc40n42PzzffzSY7aUWodZgA2NtSL0G0sqvTgqQ/VHXsYljKVJu2Q3IHbmo7eUOTmTe6cOg7Qg==@vger.kernel.org, AJvYcCVlqBPKxxq2PGXCMZquiia3u0DtVuDhES/Dn5tKkL9EM4yH9S+R0sySSzZyVCPGq3pIsP9HBiCwV+l4@vger.kernel.org, AJvYcCXiylnulxHtYXgA+KeF7uTVnPhspX+xxRyYNpMRkixHM5DV9v2fO0AIQcm7iAZIaXkXN/T8G2hvOy4e/N4TNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnsZnC8fET01n7aeRnpYG0H9hYNKD8GThK9bF6qlAKDbR6r2I
	TlzVp4YlVp3TuA+I4L1c1nCa6NMchUUdXgk1gJxvv0eNCPO/5uBjfssH9sYWNvN3oRDmZ7/j9Re
	hd5H9eBRTKoJck9LqAFcFMzCWQE8=
X-Google-Smtp-Source: AGHT+IHwjUZ/D0gPZk+CyMnQLtq/DsFFmkIX1MphMhWMqr5QE96IKENIsI2zKWWf445KGdU4ZCgAOjb0OqPbrvF1gaI=
X-Received: by 2002:a17:907:7214:b0:a9a:b9d:bd93 with SMTP id
 a640c23a62f3a-aa4dd52feb6mr214525666b.4.1732102625052; Wed, 20 Nov 2024
 03:37:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com> <20241120-banditen-nimmersatt-e53c268d893a@brauner>
In-Reply-To: <20241120-banditen-nimmersatt-e53c268d893a@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Nov 2024 12:36:53 +0100
Message-ID: <CAOQ4uxjwXbpCxo0CetBnWkEHQ-X1MjPS9J2siQfGCqDYNDhZPA@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 12:10=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> > But if anybody is really worried about running out of f_mode bits, we
> > could almost certainly turn the existing
> >
> >         unsigned int f_flags;
> >
> > into a bitfield, and make it be something like
> >
> >         unsigned int f_flags:26, f_special:6;
>
> I just saw this now. Two points I would like to keep you to keep mind.
>
> I've already mentiond that I've freed up 5 fmode bits so it's not that
> we're in immediate danger of running out. Especially since I added
> f_ops_flags which contains all flags that are static, i.e., never change
> and can simply live in the file operations struct and aren't that
> performance sensitive.
>
> I shrunk struct file to three cachelines. And in fact, we have 8 bytes
> to use left since I removed f_version. So it really wouldn't be a
> problem to simply add a separate u32 f_special member into struct file
> without growing it and still leaving a 4 byte hole if it ever comes to
> that.

That's good to know, but for the record, I ended up using just one
extra f_mode bit for fsnotify [1].

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/5ea5f8e283d1edb55aa79c35187bfe344=
056af14.1731684329.git.josef@toxicpanda.com/

