Return-Path: <linux-fsdevel+bounces-44602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB45EA6A945
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B5E47B1828
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6BA8F6E;
	Thu, 20 Mar 2025 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuUHWUep"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11191E8323;
	Thu, 20 Mar 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482854; cv=none; b=e8P25HYlOwLDDbYb/htInloYNihPmyBNDiMAcKzmxpXZ7UBICItjsFkBnQZRb1EqEVwOGMixpGb+rKxFGbaHdYtiOQ5m38d4HV4FUDyKty1Vc8nYcSgov5Zpm62Jh2zypeYkQ7riRNE3JVWuWnNaHdUn3bMHbQCE8YfpwRr73q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482854; c=relaxed/simple;
	bh=9pTLdxAtgrJsqFdcgdMTfhCiZPwpbClW40GE8//9L6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYGVbL4Hyn/qe1Nr4nHvQ+4eWGidql7SVDUtuAUmqOZBGIw2lbqHGHIo1cj65lJYtoSZgU0UOqPmrfihSi/ye/5hJk/LBPJYn1xi4dFOkqvQRyEh6FjvM3ysajglmY0wxLB2QiuMXSfL5JX4DmZz74xL1TEuWTcpU6LaULa7piM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuUHWUep; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30795988ebeso8839061fa.3;
        Thu, 20 Mar 2025 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742482851; x=1743087651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pTLdxAtgrJsqFdcgdMTfhCiZPwpbClW40GE8//9L6o=;
        b=PuUHWUepED9IFf4mw0eBbK/Ios14FJVZg/pHj5A36O2sRcS5fpZJljLyWkECCucp6R
         w2tS1JugIQGKVM95WujlfWDVVQUABQjwhwdSumCdnpP2la0gFSlE0a9SQVW8EDqTC2WZ
         QhYYBncTP1WTVis9ydOBdC2cAFG8mieYxXoK+TtNJaqd5GhcWcz/vUt6FOnqbBxvoceL
         CrVvdxQdhjcgBdaw5SZrZuWyXBCfC0lx98MlBjlI3PztwmrowU4dGSnS/aeL6LKgRUSs
         kJ2Nip67beGXQEtjX78JYQBsBJKCQ9ouBsLp7KxbtoIGYCUGsvlgamUG+XJiA3umXIfy
         wjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742482851; x=1743087651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pTLdxAtgrJsqFdcgdMTfhCiZPwpbClW40GE8//9L6o=;
        b=Ffc+P55rVCcygawq4V04pf54tmTHQf4uROMOCB+l3bkoDdB8U7gJKumXRc2F//BB+e
         zBchw1ybIlfwdKNTRyak1RK9ORRkIzOtMe1iNDpQllmi4jYBxczZ45uGC1deYc2LUwjj
         b6LnY8NjRSlm6XPn6QL3zy53b/LDKqJ+wF5kxNsQAXAjUnf9+aBEU80ahWqQgMitwX8M
         Uek52ROJlibSUJBVhw0TKEW+H5d68GdnVa6LTqxE/mdRXKWXWwYI55nfwLrqTTT8BbEU
         JoCfFSADv5nO/ViaJ8k77JbX646PQ4dsxHPEZp0KKdL0CoVOwYq8d22XW4IEKUiCYYFI
         fUpw==
X-Forwarded-Encrypted: i=1; AJvYcCVsyezeIU+Qmn2mqoMy6DU/64OSt5KQjlgIL0wwaWxiheD26ZLyHUoblYXTLZx8S8lpbVFWbEXVMgc=@vger.kernel.org, AJvYcCWCSAy7tC1V2QLI1TQfRRk00EzutjRl2N96PWTRybCwJmzMsJP50hXv8UKRjp89kujE6b8yyNTgUkxPgUMxpA==@vger.kernel.org, AJvYcCXjZGWcsvUIy3xxPRfhX4X+ZSOxs6sQbLl7ErHvWgWc1dy+8fKku24SG6E3mtkgHBPACqZUycfjfgMgM/sh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3bYjxvPtbPPZD5zGM6/LZTWeDCSP+RXblRFe96Rzxp6ElXuES
	bYMHQzBf2d0I4JKqxTfqudNLtLhN4a6ECHpSw1zn8B1mjUhJweVvE4PduIJ13/+ectrgE1okOPD
	0beiWk0jRiyB3maJHlXWAZd4pe0A=
X-Gm-Gg: ASbGncsN94x7kjLvAhk6K2525JflYWTQ76LG8821UM5KWQfAAfSfV4MhPSNp7iNTSTm
	JooY5PuJo62RYHNEf/cZn9AprNWAxxx0Zm9egPccdjeh5MbKCHLh85Oqx1c3QyA/vPU7cc2CVi5
	Y/JXfBtvKkKchDtgXhJj22o8Jpf9Q=
X-Google-Smtp-Source: AGHT+IFcAQGu4dcHPMMMTDjZXD39ScyoZicDpJAPf3QODoX1p8n5ve681VrqpR7cohfc9ZYH79+ER6ZKnoyA9ZodQdk=
X-Received: by 2002:a05:651c:2211:b0:30a:44ca:7e74 with SMTP id
 38308e7fff4ca-30d6a3e4308mr30581311fa.12.1742482850475; Thu, 20 Mar 2025
 08:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320063903.2685882-1-avagin@google.com> <24d6f7a9-82db-4240-a8d6-2c8b58861521@lucifer.local>
In-Reply-To: <24d6f7a9-82db-4240-a8d6-2c8b58861521@lucifer.local>
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 20 Mar 2025 08:00:36 -0700
X-Gm-Features: AQ5f1JrXudWuepBjRLzmdl2-9SJu1uWlfvYIgvYvJPd4oC0rVqDvyy0YLbrWIvs
Message-ID: <CANaxB-xuND3OoUqDrFQfN+xLwiWzY0SMRJ_RvF1+-emTuqNZkA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fs/proc: extend the PAGEMAP_SCAN ioctl to report
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrei Vagin <avagin@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	criu@lists.linux.dev, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, Pavel Tikhomirov <snorcht@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 4:04=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Well I guess it couldn't wait ;) we're (very!) late in the cycle and
> immediately pre-LSF (will you be there btw?) so this is 6.16 for sure.
>
> Kinda wish you'd mentioned you wanted to do it as I'd rearranged my
> schedule to tackle this as a priority post-LSF, but you've done a good jo=
b
> so we're all good! Just a little heads up would have been nice ;)
>
> Some nits and you need to fix the test header thing but otherwise good.

I wasn't rushing these changes. Just trying to help and save you some
time:). We'd like to backport this to older releases, but that's a separate
task. I'll submit backport requests to the stable branches and hope
(fingers crossed) the maintainers approve them. Sorry I didn't let you know
I could help with this.

Thanks for the review.

P.S. I don't think I made the CRIU urgency clear enough earlier. We're not
in panic mode, and we do have time to handle this. The lightweight guard
regions are in glibc, but aren't in any distro releases yet. We found the
problem when CRIU tests started failing on Fedora Rawhide. We probably have
a few months before the new glibc hits official distros and becomes a real
issue for CRIU users.

Thanks,
Andrei

