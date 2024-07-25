Return-Path: <linux-fsdevel+bounces-24215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE793BA88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 04:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312601F25318
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 02:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A67C8F3;
	Thu, 25 Jul 2024 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6uATj5B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF111876;
	Thu, 25 Jul 2024 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721873398; cv=none; b=st3d36SPEM6ZRn8PNLDsgH4ayHkU4okhIln8KCBRk2NNFRd3qZMeh7lr+NtoQ4hEk5aXIE8R7Ut72rbIbKRZBihiM4A93riMhqgFqasRgqU/nke888SPOv7XD0OO9Xxod+YfLibFO5gEcjJp1KzQYKpnM76SSc6rLavWDCqdmVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721873398; c=relaxed/simple;
	bh=5mzlHBEZJrXOFSiAtn8W89Tn+T0WordHs/S0NOgvODE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwpi6MZlzv/RJ5DtgJCjMEPcsUB0j/vt/PZb5kYQxOk2N6PRQahq1lZLdl/xTPOpemMg+uO8pf4YgoLuxCy0p9igVkFzeNL6C2oksYgQjBCS15Y/TQJHL+5W4cCktu9yaZ1RvlvF2dd9c14oJc4JQfVwSG7IP03n5HTls4Q3fz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6uATj5B; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so440912a12.3;
        Wed, 24 Jul 2024 19:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721873395; x=1722478195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcQxUErjDPne227PdokUHN1umguq6JRSbMCob0CuJeg=;
        b=c6uATj5BsuejkeVx+KIVL47a5zns4kJtO5EXABQm5f3/ZNe7U+AQHCqmYZIm1xQ70L
         9wBfYrQ/udgt+c4zSbPX/s0BJEgTZJHvMAAaklRruaIiRm/5Tk3rU4TeYUoyvplhMoZs
         8H88Acli0P4bFAYbzl6UfcifCU1XuBZsFJ+/yWRed0QTP8tgsJ47KHEXBIMcC/iKIVK4
         78HMcBeZZmisYzoziSX8rYceJ01mu9kiBylQD0LNDp982knsbc+2Q2By5gtbTbXCvGh+
         Mr28evfZ27JTNmvzToIulxY4PeC0Toa1YdklnXTL20zVOoC7VZiyBf7LFYo3bt2K2zFk
         p1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721873395; x=1722478195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcQxUErjDPne227PdokUHN1umguq6JRSbMCob0CuJeg=;
        b=VhDpZDGq2efU2ouH/7knvYv1el5VgdAGPLeVYSk/yZVurXg7MWhPmKqQSWEs2y474j
         TAKjsAGI7zzCIOCN1/eHdr1irgTgKnAlAyKvWKEqlf0yFLvBDb5aqLzMbqI8rtPl/yhz
         BEe5qwK4Gv7Z3y5Hn7dGLd9f+D7GFJDX+xL6mnmCdZ34aJh1A73sUiegEo+5ppWx+2d9
         3/sr9OX8qCV6wiu/Z3FRc2MySt+WV6Yp/upP86l8a0YNGpMtScEBI56DybiW/8j5ycKU
         2BYY9WRLRfdyNXANYrvGiEaQpBSHtqfyJRnioJWZPiQtodOh5Pj7BcbkuKiAkh/U/6e8
         mzmw==
X-Forwarded-Encrypted: i=1; AJvYcCVK0uLWLu0mIsTffXVzyhBLti9McmZVTuTqzIuG2PlGNcz2ASEcPKBHHi/+o7HEcDNrxf8LY6XJ+2RCFJn8SuJQ9tFKxsX/gqiXNSkL0dqK12YD/15xJYVDY5XzMfx0tk7noLXAQL8Fsd/TFw==
X-Gm-Message-State: AOJu0YxyBnNZ2goYOiGf+s0+eSDrLoQ/5NCXxL/5IT1BCThfP2aA1xZy
	GO3d5wfLgdeJ1yLB1ysO6UDrQe9y30mGnEQ+QkEL3/JEbK9KLMZXLHN9Jzdz1M4Qu1ibSJTmY1y
	pQCJTge+r7/93LzJH/xM3yPFrQKUPsSRGbsMGGg==
X-Google-Smtp-Source: AGHT+IGjiEQPgWvzUhVGqlmg9jofNlbeQr7JMG5CW4VhldmoqsO1+1wxpTwX1/+ZcuW4M7uEAyylUHruDUh/efgHm7o=
X-Received: by 2002:a50:9f6d:0:b0:5aa:2a06:d325 with SMTP id
 4fb4d7f45d1cf-5ac6203a67fmr336236a12.7.1721873395155; Wed, 24 Jul 2024
 19:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723091154.52458-1-sunjunchao2870@gmail.com> <7a1be8c1f49fc6356a0a79591af3c3de8d4675ec.camel@perches.com>
In-Reply-To: <7a1be8c1f49fc6356a0a79591af3c3de8d4675ec.camel@perches.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Wed, 24 Jul 2024 22:09:41 -0400
Message-ID: <CAHB1NaijJ16haCsH3uHy_zVZFXJ7_-qFOk8mFx7QSeqD+X6Z3g@mail.gmail.com>
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
To: Joe Perches <joe@perches.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, masahiroy@kernel.org, akpm@linux-foundation.org, 
	n.schier@avm.de, ojeda@kernel.org, djwong@kernel.org, kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Joe Perches <joe@perches.com> =E4=BA=8E2024=E5=B9=B47=E6=9C=8824=E6=97=A5=
=E5=91=A8=E4=B8=89 09:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 2024-07-23 at 05:11 -0400, Julian Sun wrote:
> > Hi,
> >
> > Recently, I saw a patch[1] on the ext4 mailing list regarding
> > the correction of a macro definition error. Jan mentioned
> > that "The bug in the macro is a really nasty trap...".
> > Because existing compilers are unable to detect
> > unused parameters in macro definitions. This inspired me
> > to write a script to check for unused parameters in
> > macro definitions and to run it.
> >
>
> checkpatch has a similar test:
>
> https://lkml.kernel.org/r/20240507032757.146386-3-21cnbao@gmail.com
>
> $ git log --format=3Demail -1 b1be5844c1a0124a49a30a20a189d0a53aa10578
> From b1be5844c1a0124a49a30a20a189d0a53aa10578 Mon Sep 17 00:00:00 2001
> From: Xining Xu <mac.xxn@outlook.com>
> Date: Tue, 7 May 2024 15:27:57 +1200
> Subject: [PATCH] scripts: checkpatch: check unused parameters for
>  function-like macro
>
> If function-like macros do not utilize a parameter, it might result in a
> build warning.  In our coding style guidelines, we advocate for utilizing
> static inline functions to replace such macros.  This patch verifies
> compliance with the new rule.
>
> For a macro such as the one below,
>
>  #define test(a) do { } while (0)
>
> The test result is as follows.
>
>  WARNING: Argument 'a' is not used in function-like macro
>  #21: FILE: mm/init-mm.c:20:
>  +#define test(a) do { } while (0)
>
>  total: 0 errors, 1 warnings, 8 lines checked
>
>
> > Link: https://lkml.kernel.org/r/20240507032757.146386-3-21cnbao@gmail.c=
om
Yeah, I noticted the test. The difference between checkpatch and
macro_checker is that checkpatch only checks the patch files, instead
of the entire source files, which results in the inability to check
all macros in source files.
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

