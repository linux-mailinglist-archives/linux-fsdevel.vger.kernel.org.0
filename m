Return-Path: <linux-fsdevel+bounces-49840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2D9AC3DB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 12:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E613B7A8134
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86E1F4180;
	Mon, 26 May 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6VPx7Yg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08E1E492D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748254314; cv=none; b=p7G6TqxWtMOD83bAlVpsnxufKIexn6p2PRLSUdlMAeE73mG/SAYbJr09ctlIR7atXKE+zqh8Cst0PQcyvxm8DNeNhs2GoTxEhEPTKoDZ6bZ3eAdF1yN5k7IRgsP99YszV2Tnn9ZnMs0rtbgFiAx7PtHjVOdYTj9+nzGvhOOxQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748254314; c=relaxed/simple;
	bh=0bRj0m8NqrY6Zc88gVe0+/4nnLgOhAg//LQuf4Aia0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7n9HeQ8JnykvzUtOvUDIVmm5hr+mZCG5FnmmNY8j992uiNaNfv0OyYDT5p0ZIDOS9jimbnYmsBvOHOI5dx+XoQSxBf7YU9v5zRGoV6Cgl28GAMOyBG7x7PE/NJNAMkHERWNoSM+2I3DNm/IoaqTOtcpvX4D7pWuubbUY2E/o8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6VPx7Yg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad1f6aa2f84so421009066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748254310; x=1748859110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLdNL7lM3nZxHe2LrdKKBFDePG4rqYyQMgbEWMJ3UfY=;
        b=D6VPx7YgSCNVo/HKApi033/knu9zDhMyQrHRO4C3/7sDksTOKcgpuOtoi0kpG/DVJm
         nN1bEjMp6W9totOQ8GalDOKPUTg6OZ/8IhOhNaXBHv1zKABw5ViPDTuJ7cZsDb0A6w53
         7BsQJ5qE+QBzM1WWBnA+p3wFd5h//JKsdB5Lqfecbpd/zv/b0Z8gkJFiLRm5Up239kQH
         44rH5zGMiXMdxlMuq4jYjIpRY8k7QQqt1TT1KpYVpICzsUsOAPr0wc1hzQMKz2uoq2a+
         xs9zUyLga5uIxbjdqjeUQInXsfT6Jl7XXdr26XuCLLtk6jJ5C9A0tQJvnXQkalYI5CkD
         pBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748254310; x=1748859110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLdNL7lM3nZxHe2LrdKKBFDePG4rqYyQMgbEWMJ3UfY=;
        b=Un7WYQoGvXHhuHKxoHtlvwH10m9BV+PoHQLEHVaV6pSsEwVlsSpq3vlWWuphVt/LZH
         qpILPycd85QeffohqlBjf6EqzKiPNKvjScjRacYVo8r7FwPKe54OytN+lpm988ksA1w7
         K862hf3exWWurKfGK/B6+fZfwE/gxdDnJi1fh+re2MtEiZZWXKYZGDIRBBTiI8Dmb5eA
         nvUnqHQF8EcrJRJn+t7AqXOQq1WS66abdqIOskK2gzxZsC4NEUtN8amJnNhWwPt2ZLup
         SYyYXOfljW1clTw5eDWs3NuZ6l+Rg5pSiuWkU+WPKuNrY3soYpV1mp747GzjSOpIo39T
         sDUg==
X-Forwarded-Encrypted: i=1; AJvYcCUk2sRd64//T9hc48E1bW96/XOZ7l5nIfTSO/scyJ4QRTJB/aaRAQPFqMG3B1gjHSs4lLK0B/53wcyCn57h@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7aP0XUHCQ3Af2u7XxrJKZzGv7ep8ikIAv3TFV63vFg156eDX
	eNyOHpidM8bSScibny+zH2vWchReofYoJPlyWIIgveCl3D5eKMw2jz5v+5YxZlJEAATts8ERsEM
	ldB5ksd1gUvwJA/TN+DWEr29HvM4zJbfvMP5wi0yJxg==
X-Gm-Gg: ASbGnctuIYtcyurM8QzaEykhAUA56XeOaW2niFOAx6DQpqz/rYgi2cvTIxA2Qqgf3wC
	1uQehPl/yNKTTyl/khpe7MyiNVPDJ/Bw1WWjIBtU+HgikG0hpILcMf7V4Y9Qrx/rKYTFmRnELeQ
	dLaeeIp7LJz+fbQ0e/LTMbPMZDZ+jZhbmA
X-Google-Smtp-Source: AGHT+IEfMqQ97z+ChhdSQa2CYbXcyoJuYvw8/44TsMObaABMk2Es45MYjYNsh5v9eR/lNzxTd4C7GyTjVoARNCTmxT4=
X-Received: by 2002:a17:906:7943:b0:aca:d29e:53f1 with SMTP id
 a640c23a62f3a-ad859842fcemr789127066b.12.1748254299793; Mon, 26 May 2025
 03:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtdy7BYUpt795vGKFDHfRpyPVhqrL=gbQzauTvNawrZyw@mail.gmail.com>
 <20250514121415.2116216-1-allison.karlitskaya@redhat.com> <CAJfpegtS3HLCOywFYuJ7HLPVKaSu7i6pQv-GhKQ=PK3JAiz+JQ@mail.gmail.com>
 <20250515-dunkel-rochen-ad18a3423840@brauner> <CAJfpegutBsgbrGN740f0eP1yMtKGn4s786cwuLULJyNRiL_yRg@mail.gmail.com>
 <CAOYeF9Uj3R+j55vJvO+fiVr79BsDe2de-pvhSyveoq35wOeuuw@mail.gmail.com>
In-Reply-To: <CAOYeF9Uj3R+j55vJvO+fiVr79BsDe2de-pvhSyveoq35wOeuuw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 26 May 2025 12:11:28 +0200
X-Gm-Features: AX0GCFtO9PX-klcJg-Fbtsbzc57LOa68XhBZ0mFJKHBs89JKS6UYypPzJ8VR2ow
Message-ID: <CAOQ4uxgea2g7A0R1yD7E8=EP1zuuO4R7L4yXJbzUj2DoEz4vUQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add max_stack_depth to fuse_init_in
To: Allison Karlitskaya <lis@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 10:51=E2=80=AFAM Allison Karlitskaya <lis@redhat.co=
m> wrote:
>
> hi,
>
> Sorry for being so late to reply to this: it's been busy.
>
> On Fri, 16 May 2025 at 11:07, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > Okay, let's add it to fuse_init_in as uint8_t.
>
> Is this to help save a few bytes?  I'm not sure it's worth it, for a
> few reasons:
>  - there are 11 reserved fields here, which is still quite a lot of room
>  - even if we reduce this to a single byte, we need to add 3 extra
> bytes of padding, which is a bit awkward.  We also only get to use
> this if we have something else that fits into a u8 or u16, otherwise
> it's wasted
>  - we might imagine some sort of a beautiful future where the kernel
> figures out a way to increase this restriction considerably (ie: >
> 256).  I'm not sure how that would look, but it seems foolish to not
> consider it.
>
> I'm happy to redo the patch if you're sure this is right (since I want
> to update the commit message a bit anyway), but how should I call the
> 3 extra bytes in that case?  unused2?  reserved?
>

Allison,

Sorry for joining so late.

I cannot help feeling that all this is really pointless.

The reality is that I don't imagine the kernel's FILESYSTEM_MAX_STACK_DEPTH
constant to grow any time soon and that for the foreseen future
the only valid values for arg->max_stack_depth are 1 or 2.

I can't remember why we did not use 0.
I must have inherited this from the Android patches or something.
As it is, with or without knowing FILESYSTEM_MAX_STACK_DEPTH
this argument is quite hard to document for userspace.

for this reason I left an explicit documentation for the only two
possible values in libfuse:

        /**
         * When FUSE_CAP_PASSTHROUGH is enabled, this is the maximum allowe=
d
         * stacking depth of the backing files.  In current kernel, the max=
imum
         * allowed stack depth if FILESYSTEM_MAX_STACK_DEPTH (2), which inc=
ludes
         * the FUSE passthrough layer, so the maximum stacking depth for ba=
cking
         * files is 1.
         *
         * The default is FUSE_BACKING_STACKED_UNDER (0), meaning that the
         * backing files cannot be on a stacked filesystem, but another sta=
cked
         * filesystem can be stacked over this FUSE passthrough filesystem.
         *
         * Set this to FUSE_BACKING_STACKED_OVER (1) if backing files may b=
e on
         * a stacked filesystem, such as overlayfs or another FUSE passthro=
ugh.
         * In this configuration, another stacked filesystem cannot be stac=
ked
         * over this FUSE passthrough filesystem.
         */
#define FUSE_BACKING_STACKED_UNDER      (0)
#define FUSE_BACKING_STACKED_OVER       (1)

If the problem is that this is not defined in uapi/fuse.h we can define:

#define FUSE_STACKED_UNDER (1)
#define FUSE_STAKCED_OVER (2)

With the comment from libfuse.
If we ever need to pass values greater than 2 we can introduce a new
init flag for that.

What do you think?
Did I misunderstand the problem that you are trying to solve?

Thanks,
Amir.

