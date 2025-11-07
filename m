Return-Path: <linux-fsdevel+bounces-67402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97789C3E4AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 03:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9261889301
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 02:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9B2EBB88;
	Fri,  7 Nov 2025 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2icienk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD371D5CC7
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 02:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484315; cv=none; b=upk5A9PzXdgglrApZHkQfeekl/bdIaVhpMj7DnLKWcEZzHZurguWOm9kiovrcoBCO1Y2wtEzYXjOr7yp/XgXkn4edaBxldpChZsmhSocOCueoF5js6VUYIIeSA4AtZvGaC6FXPrXqVvt5lorGdVW39LrkaOJiNaRcWyRoOKvkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484315; c=relaxed/simple;
	bh=CnMcg/kXN5EiKNbIPt3g68fYg//OTHVOPtX1VKA2VYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8Afhf09FLjGRVTL7ix0zsVUareYO+lSAVJq3+uGC1PxfyZ1KJSf2+7T7YsvTboj8mYiymxgLvscZ3BxzPT33Q1lKQOIPqPNhmlh5M1uLklEt0+/AXxXId7LR36zRHkVkPykuxcFPwvkVdYWkAoAXHq4GG/qC7hDh0nYVZVXswk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2icienk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABEBC19423
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 02:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762484315;
	bh=CnMcg/kXN5EiKNbIPt3g68fYg//OTHVOPtX1VKA2VYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H2icienk0mhx8Svklyc7RESVshO9h/1isHvKy4Uh5LoteAZFnN6iQc0jTGSFf42Gt
	 JYNUCqZxGc7f1kCR7eECbQgs7RhTSR5mPdItruO1KbM6Cl3Ti+IZjJaEeUEUqFFIOn
	 n2Nlym25f+4MNOPv0odBtR5rtUrwQujdd6zW7l2fKJsLm8pgYNr73Y+24J8gsmc8Lw
	 4GZatp43t3v2kRPwlnjMQM12SkXdpHofm5BsBGh2mOuabXuRn4nUJtt0snlq5wxNbC
	 9cCYoaK37SEhX7lAfZbIp9UEV08oYoD81meefLui/37UsT1a5Q6QODGt6EB+JifR4Y
	 Ef5HkVJV8Jc/w==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b70fb7b54cdso52617666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 18:58:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCAWZuYrYI7xQ7oUHSDgK2E86UPLQF84V5V8DvL7//fyNWfgxBTHYbF0gfzuUfoHuAGZ7BKi4l0tmPWQN7@vger.kernel.org
X-Gm-Message-State: AOJu0YxCuOAzjktYp0GKGmuOWUIFpOsFlFF3OR1P+alw7VQhZe+L/222
	93kGem3HTspWnufBn1hAY+SuxZJtNO3vWUXdFR43qmITN9HJXNjc44oXazNibfCniqpIMspwGdZ
	cqBF0COm4pvbI6IOrms6AGqtAfz65JNY=
X-Google-Smtp-Source: AGHT+IE8krnrPRv2PXae1vIDWcCVLgktPSHDjY80bHprT5hVpdghcZoZ49o9WqzcqULrxNJOmw7CGKVM6CYazVfu3JA=
X-Received: by 2002:a17:907:9488:b0:b71:854:4e4e with SMTP id
 a640c23a62f3a-b72c0ac14f0mr151946466b.38.1762484313448; Thu, 06 Nov 2025
 18:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020020749.5522-1-linkinjeon@kernel.org> <20251020020749.5522-3-linkinjeon@kernel.org>
 <46ebc4d5-5478-4c22-8f17-069fe40ebe44@mobintestserver.ir>
In-Reply-To: <46ebc4d5-5478-4c22-8f17-069fe40ebe44@mobintestserver.ir>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 7 Nov 2025 11:58:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-YiCdiHn8ZrwisB=5A_u2fXCDPVvmZFc9n6nHf3JF_7A@mail.gmail.com>
X-Gm-Features: AWmQ_blZpFAFtNz5McsQNEZU6UnFAYCUfHhaIOfI9OjcE-kgAMGKnvAZMAkZvfw
Message-ID: <CAKYAXd-YiCdiHn8ZrwisB=5A_u2fXCDPVvmZFc9n6nHf3JF_7A@mail.gmail.com>
Subject: Re: [PATCH 02/11] ntfsplus: add super block operations
To: Mobin Aydinfar <mobin@mobintestserver.ir>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, cheol.lee@lge.com, 
	jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 5:03=E2=80=AFAM Mobin Aydinfar <mobin@mobintestserve=
r.ir> wrote:
>
Hi Mobin,
> Hi Namjae, I built your new driver (as DKMS) and I'm using it and it
> went smooth so far. Thanks for this good driver (and also really
> practical userspace tools) but something in dmesg caught my eye:
Thanks for your test:)
>
> On 10/20/25 05:37, Namjae Jeon wrote:
> > This adds the implementation of superblock operations for ntfsplus.
> >
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > ---
> >   fs/ntfsplus/super.c | 2716 ++++++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 2716 insertions(+)
> >   create mode 100644 fs/ntfsplus/super.c
> >
> > diff --git a/fs/ntfsplus/super.c b/fs/ntfsplus/super.c
> > new file mode 100644
> > index 000000000000..1803eeec5618
> > --- /dev/null
> > +++ b/fs/ntfsplus/super.c
> > @@ -0,0 +1,2716 @@
> > ...
> > +     pr_info("volume version %i.%i, dev %s, cluster size %d\n",
> > +             vol->major_ver, vol->minor_ver, sb->s_id, vol->cluster_si=
ze);
> > +
>  > ...
>
> Shouldn't pr_info() messages have "ntfsplus: " prefix? I mean most
> drivers do so and it is weird to me to have something like this:
>
> [    5.431662] volume version 3.1, dev sda3, cluster size 4096
> [    5.444801] volume version 3.1, dev sdb1, cluster size 4096
>
> instead of this:
>
> [    5.431662] ntfsplus: volume version 3.1, dev sda3, cluster size 4096
> [    5.444801] ntfsplus: volume version 3.1, dev sdb1, cluster size 4096
>
> in my dmesg. What do you think? It wouldn't be better to include
> "ntfsplus: " prefix for pr_info messages?
Okay, I will improve it in the next version.
Thanks.
>
> Best Regards

