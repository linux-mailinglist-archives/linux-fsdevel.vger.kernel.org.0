Return-Path: <linux-fsdevel+bounces-20020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6108CC6B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 21:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861E41F227E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 19:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E9145FF6;
	Wed, 22 May 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G08kuBza"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810184C9A;
	Wed, 22 May 2024 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404649; cv=none; b=e/cnP8hOj+BAa267BKX68gtzMWM7Ro/6hKWc7kfLprkklWSZ55WOWIxEPffxxXTc0tPMj3AKlDlO5OFJSmzFks+zbUPVfMds9sGX4r7CklNNDySO1KEzeeZsDR6OTVBkhhr5ycFmyHXyW8hxLN2sNkFxt2H2EhJqpAfl2+/t5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404649; c=relaxed/simple;
	bh=naPqae9NhhGSu1hXRtGdKUlnkPgFQKrKm6m3DnHH2xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tI2t9DVQUpDwurgbc7QqGgozlKqaJpKrs0g6UWl/pv4vzY4yRXtHWnIdEmNFaiiQ1DqWDOXn1aDWfHYJaai14CIEW3BRMV2aJFHJjyUEitKFr9H12GPW577DYSMmwsXT10v562wUqPXLwaK+2vkXRK19/JKez+FH1PGigrE3iAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G08kuBza; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c9a0042e7dso2682651b6e.0;
        Wed, 22 May 2024 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716404647; x=1717009447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhTCzNR+kkWgJXYlLCgQiTzJ53TKdalqadL/jDFO8ng=;
        b=G08kuBza1emOToU/ksVyZtKqFZQ3xZWJbY5xTVDSRVyNp9FPmWKGQSlFHs+8bf7PEH
         33eZAnNMivYc/668kljY3xvwH7IBUkCnEJ9Fc/lY6uKt/05XJs8YpVQUNG1n29SdSFhn
         Kj8TvH/sZaZA+JSKG1tq8pKG3QJ8cZmzHEa/V3dZqVYJvaXAb6PVIuRln+r3yBDxa2Vr
         6NBIkkOwom1TS2BgNhWjrIARTtCplURgw/cF/J+BAu73k8/4NLt1VCbGhOq+3ZCwypOc
         juyQC0H15xN3Ri861Zj84TTLYfNUanVaFC4FS2A8kNyD1PQbqPgMouq0E8ZD0qCReu6Z
         UH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716404647; x=1717009447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhTCzNR+kkWgJXYlLCgQiTzJ53TKdalqadL/jDFO8ng=;
        b=XT+O3kK6WAQWzo4RF2BTPS3cHjdC/qqNSA6i+wy1mYWgYB6q33R5ef7aQDLI5lhCV/
         v12VZ8vuSb31laF2wpBHa+99NSsNpcq0mCcTjc4pKsa0wOeXRtfpnlV1vwDJnFLXyybi
         h+8xSBLxwooCPj49CFUpeunOBCmA48H485kLFzL4QLM6GpVR+8dScRZA1BwKI5xuqMMU
         spr1+PlFUhcLDIqKo+4aQ9vF8GcKgSf0p8PF0lP4R8736qoHhvSd2B+lpvxEjn8hyhtX
         bEjAeB6E0qqdd/tHNDR48kUXGP9UsvB7CB88RHpGoVmoDcSGhPhlvAuNq63+ZBLhjwUP
         uANg==
X-Forwarded-Encrypted: i=1; AJvYcCVyYqmF2msWse/aZ+kGh9xSZkYzgGwziMQNfawyCY9bjklMyEitPD0tWGVgvBTo4x5NnIm0/G7woPW5URBT0qhxvRcJAd3ZRQQfg2liL9Cyt7vxcwlCjYfW6n6tC8N1lawHrc4aCThp8Q==
X-Gm-Message-State: AOJu0Yze5OwrKI6vrRMF7WRBVeW2ky7diUjBD99iOtmixIoIR+CSUP6g
	07NdgZr1eOWjl685b/4NoAU955sjoTogALDufW0JcHeWr41WzVH7lvch7E4Td1IZcV7eI/58RtA
	uncPqOTGVJNGRa6VKvY07JqdDwKY=
X-Google-Smtp-Source: AGHT+IHXGG8EeECVx6IQRrc2tmEp7pGT7N+FzEhPFyZ1tm9iUiRy0me55JvgI94rkmjegw0PVLR87pcoKkgGjI2LEF0=
X-Received: by 2002:a05:6870:184d:b0:24c:4fcc:9017 with SMTP id
 586e51a60fabf-24c68e065a7mr3124594fac.34.1716404647362; Wed, 22 May 2024
 12:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520164624.665269-2-aalbersh@redhat.com> <20240520164624.665269-4-aalbersh@redhat.com>
 <CAOQ4uxikMjmAkXwGk3d9897622JfkeE8LXaT9PBrtTiR5y3=Rg@mail.gmail.com>
 <z6ctkxtwhwioc5a5kzisjxffkde6xpchstrr3zlflh4bsz4mpd@5z2s2d7lbje5>
 <CAOQ4uxjaLbrmSDk_a_M6YDT5tQoHO=dXTDsHVOSYcMxeQnpP1w@mail.gmail.com>
 <3b7opex4hgm3ed6v24m7k4oagp2gnsjms45yq223u2nnrbvicx@bgoqeylzxelj>
 <20240522162853.GW25518@frogsfrogsfrogs> <20240522163856.GA1789@sol.localdomain>
In-Reply-To: <20240522163856.GA1789@sol.localdomain>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 May 2024 22:03:55 +0300
Message-ID: <CAOQ4uxjkHyRvV1VVAa+Agdgb8TOHJv1QOJvNbgmG-PY=G1L+DQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and FS_IOC_FSGETXATTRAT
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 7:38=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Wed, May 22, 2024 at 09:28:53AM -0700, Darrick J. Wong wrote:
> >
> > Do the other *at() syscalls prohibit dfd + path pointing to a different
> > filesystem?  It seems odd to have this restriction that the rest don't,
> > but perhaps documenting this in the ioctl_xfs_fsgetxattrat manpage is o=
k.
>
> No, but they are arbitrary syscalls so they can do that.  ioctls traditio=
nally
> operate on the specific filesystem of the fd.

To emphasize the absurdity
think opening /dev/random and doing ioctl to set projid on some xfs file.
It is ridiculous.

>
> It feels like these should be syscalls, not ioctls.
>

I bet whatever name you choose for syscalls it is going to be too
close lexicographically to [gs]etxattrat(2) [1]. It is really crowded
in the area of getattr/getfattr/fgetxattr/getxattr/getfileattr/getfsxattr..=
.
I think I would vote for [gs]etfsxattrat(2) following the uapi struct fsxat=
tr.
I guess we have officially spiralled.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20240426162042.191916-1-cgoettsch=
e@seltendoof.de/

