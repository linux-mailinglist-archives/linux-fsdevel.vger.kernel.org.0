Return-Path: <linux-fsdevel+bounces-25349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1830494AFE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E0E1C21ACA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B5B80C0C;
	Wed,  7 Aug 2024 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyiGKsbK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0331386C6;
	Wed,  7 Aug 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055623; cv=none; b=FabkPVgVSC0tAxp9TzM8ZcVD25BffsoI/oR3/xVxj69c18Z27nBvQgJpMXI69+AZqt/tj3gKj4QrJZQUX5Y7R4EJPXDihg5d+OGwQ4+dpU3qwvqZrxzWt0D0hoqwW/IhKs2SRK4u2hmKGg3isU7BjGTB6LfNKsKtBrF0TPvB7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055623; c=relaxed/simple;
	bh=viDE7+qxvDbtQha2LNMPjQljnlwfV+/PdDCK+VhHq44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKuqEXT9vf//6A7kxmDyVNegRmO7UmMLsuwh8mAN3xsVwTIg1NSSIPRY8hNyBN5WJaP9nc0qAP8hIJhzxVLSltCCchtLU1rTlEvZv/ifVqEirxFLZYK3SNEQrHFbOeHjbqyaRKO8eFy2NprHEZoUlCB9EMv37wvy6YUh8w4OKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyiGKsbK; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so1215971fa.1;
        Wed, 07 Aug 2024 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723055620; x=1723660420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MxBRAH0Ag1ClcuTsky8lb49iobr7PX00s08176mpWw=;
        b=dyiGKsbKZFXIjh35apmaz7n/mTQ+q0LriGjJwxmUmRnA0lmRcsmccSeXiMsuXhsE5H
         AEjqkaYWaD5U1W/3mJlVOdX2ELQ72sWOIazDGUAahCrMzGQCn+gRW+xn1KbMfaBRl3U8
         z2QipXJ9cyWYuslBhYjXt8jPMLu/5yuuYwbogZ72Xf4uHPRcGuSAwgLAUMYnTLm13VLx
         Cq93Xg4GX4TMJox9jqnVczH2umV6Km1xKdYuw/D3HPV67gb4hRMN+LGK/55gvqLwLXTE
         Y0DR8EpGEr3hqwMpNxqpF3Rl+SPDhocQWw/XXf+jMZjcK8t0vrFXyS2B0qw5YY0YkQC7
         MFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723055620; x=1723660420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MxBRAH0Ag1ClcuTsky8lb49iobr7PX00s08176mpWw=;
        b=hQH2HzwTudSVLLbgy855r8lvTumAzlcZKj9/rxafuzxEf46Eiz+i2IdXyFI5CcMTeu
         Wg/zYrNU56DrqWj1isv4AObw/Q50vE8YpSntB2BlBbeE1Ecf2X4OxViwTFK7v/6I0PBw
         SUsVaZk7ZkBE3wgdbPvZPNBYKqRnlt6hOGQphn7ltg+RD5/3eKksg5LVPBCiDLcFFwEU
         y0IPS+8g1Sye5JubYL83QArOdEsEprTfeZhGvNwhsWo+/4t2XHitICOhIFWehDW/AJZe
         9BZ+Ggmilyi/ApWfvmc/mNxylXtL4dKlDeHE4wsbQvECBxKvEZ1VzygP+9kevITU4apv
         JVLg==
X-Forwarded-Encrypted: i=1; AJvYcCVdDS6x/N8uTuDclqqJEt5Cgs+0dBw55tia0xYVDXPU3HaL23Zxq90ZpB1QCy8nsYGOviNP/o2ZGq3KGFd5tYYyupXxmrhWpLCTfv64NPn5lhfQ+PWoXwljzNRgDQJe6D0h7S21japMWUilQpegE5prB7vJ0kbOsfC5dq7XtyvvbQ==
X-Gm-Message-State: AOJu0Ywj3p5n/UDwACGgKbMySjJkMcio0LsGrXcY41qswH3UemcZp7Hq
	gid5qQjUY1MTpwz3pvuFohJfBy6KudYGt5OsgDLESGtAH8kueU62y+xqrG7pQFjiTAD4oqdKh9c
	mkSvt7hr+UGPtePFqZLzklYi45qI=
X-Google-Smtp-Source: AGHT+IHhFw9ZRB1L2uLpvRmL8fArsvCLSfCmS3oB6tt5t43QMtj+sCg22Sz/be3OHydK8/4XolzUp/7xJXr3PR+JZt4=
X-Received: by 2002:a2e:b602:0:b0:2ef:17f7:6e1d with SMTP id
 38308e7fff4ca-2f15aa85eeamr137158281fa.4.1723055619166; Wed, 07 Aug 2024
 11:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806230904.71194-1-song@kernel.org> <20240806230904.71194-4-song@kernel.org>
 <ZrM_dOOcdbC7sMTV@krava> <CAPhsuW7PEUKyOCYctTy6K3v0m+-UA83cvYpFS3-Ur0rU9LoNxg@mail.gmail.com>
In-Reply-To: <CAPhsuW7PEUKyOCYctTy6K3v0m+-UA83cvYpFS3-Ur0rU9LoNxg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Aug 2024 11:33:28 -0700
Message-ID: <CAADnVQ+EX+PnXNhePFU3oMAD4vxVQvKb8sWqhPLc4GbUJ8LOTw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: Add tests for bpf_get_dentry_xattr
To: Song Liu <song@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	liamwisehart@meta.com, lltang@meta.com, shankaran@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:40=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> > +struct dentry;
> > > +/* Description
> > > + *  Returns xattr of a dentry
> > > + * Returns__bpf_kfunc
> >
> > nit, extra '__bpf_kfunc' suffix?
>
> Good catch.. I somehow got it from bpf_sock_addr_set_sun_path.

Fixed up both while applying.

