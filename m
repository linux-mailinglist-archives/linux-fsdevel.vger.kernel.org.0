Return-Path: <linux-fsdevel+bounces-34843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC49C930F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 21:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC31B27486
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 20:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC061ABEBA;
	Thu, 14 Nov 2024 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvNoxTAj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4191AAE39;
	Thu, 14 Nov 2024 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615262; cv=none; b=cxy/4NzyfslizKK5B9A5N/ETHPYQA7X1mmW5en/lmdRbAaPorxB4RtHPfukSABzRiHYfax4Lc72YC1i6zrv9NRm0KxfE6jw6NJPzgleJG+C9oT93bHlisuWJOH3FoYxnYnHNZKJE6cAaJdAwDjtR7NlNAVyKQYLtjNBlOWKTroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615262; c=relaxed/simple;
	bh=XtNg4k51hF59mvYHKYsqm9M6xnzczvoM4FNPSaRFKzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXrU8saqW8RCZZ6jACmrNYbcD8Z1hsNovgw5juTNaDSLXBoXmZmUi1p8VvbRs2SWhEWGyddpdzzyC6drl+CEKaayAN6prfDK/6660NbFHc/xiCAiaQfo3PJwzWp0n5iJIOCYv8Xfy0Cb7A5mBk7EG8t9Sk83QkfLc+/uIegF4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvNoxTAj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d495d217bso832198f8f.0;
        Thu, 14 Nov 2024 12:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731615259; x=1732220059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPRirCK3lhthn4lCppmTRv3W8De7Ak9KG1z6XIgAvWg=;
        b=SvNoxTAjUfpAYravCFQ8b7y8pXttHKm00LTG4UwCVNgFY9kKCSruvzM4/a+23hoheW
         CeuprQr2meznwL4YIg/S2g4Tcw6N+eOYETe3FCSsN6uxF07wIxsLbVIDoSVwYMOv/Kgz
         GqfVGtYndoH+awgi7Sp/63V3skKmuoXP/83ktkam0PUp7mccqHgNku3sCR87806JrXck
         szUQ69sc/LfxyLOJm85zN16M4u19F58aLBVXYmIv4nuWsDZIrkYgVua9Mc2BqNhxsgG0
         NrerGkJly2Umq185qRZ8blwsXbvCLkxovlqUkgHbMtBhSy/R6gXKj3mjbCfLqnZb0D8E
         9VMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615259; x=1732220059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPRirCK3lhthn4lCppmTRv3W8De7Ak9KG1z6XIgAvWg=;
        b=oYQbrBfR63q876cXSd3VGP4TDSUTmu0pymjP4Fi4n2sk1tkjAvs9ZXCDNpLJLwl2eP
         5m8xHUHbQHe3gUIWLkCY9LvJs4eFkWhuImHyr0FgIpLDoDtq9lXU39pFyS4qMOVfbn6e
         z6dQI8uMI+Wyl8W7hG2DaIAy1qihhees2kCspM1bHnfV/jfQtQsfH/atcrNpSyi/3wfW
         QZb1J0sBo8vhTSMiduQGaTKm7tCdAqyG4rDwxb4hZAPGpA+QoItfwU1NCnVWJXf5GmYg
         n/qVIDDCcO8hjgOeevm3Fl6wqgVb5JEP8V1gB67nGvOnb7h2KzJFPudsU6xGLZYnHPcT
         4rGw==
X-Forwarded-Encrypted: i=1; AJvYcCW5ilZbYOl/Dq1ncMsVt0Z6pbj1p5RHkOO6I75nzXELPRe3xDx/DHjTgnT+8H/gh0NsEINxJrETLo2iHkGY@vger.kernel.org, AJvYcCW9sMh3iaWLx85NAiuVDcl5TFAHToh4aidwa5EdVJyyrzJKMnQAQQsX2B80OmpoZzUt1/I9uNDuxEGPIP0zlkrZAI+kbwdl@vger.kernel.org, AJvYcCX0vt1/10qgO6RG+qE5jclv9ZHC5bfz4rj4x56bXkcH2CmmOXKUeU/nYFYzCHz2Gn/+copnsKd0lLGtRe6p@vger.kernel.org
X-Gm-Message-State: AOJu0YzY804rIPMRcGnOR95gYMkBvyA7i3ElrR/mN2wb0anAbwBbUk91
	KktGjkZqOxsaC/DOUCnu1Wwez2KHJC1MflakBx1HZd+TFwm5sgr1NTF/u10PGdv6PPDu1o5JIEw
	70aqc3GHpg9vIoOlgPBhAJD5HHkE=
X-Google-Smtp-Source: AGHT+IGkMeVSaBG5rRKAduAAHTiSeSOwLLcww6UElDBZ+fxd2bmg2YZz/pUfL6t9m+65xGdQcwb2ZF+ns36YghmYaw8=
X-Received: by 2002:a05:6000:1868:b0:37d:43d4:88b7 with SMTP id
 ffacd0b85a97d-38225a21c50mr101460f8f.3.1731615259233; Thu, 14 Nov 2024
 12:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114084345.1564165-1-song@kernel.org> <20241114084345.1564165-8-song@kernel.org>
In-Reply-To: <20241114084345.1564165-8-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Nov 2024 12:14:08 -0800
Message-ID: <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com>
Subject: Re: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 12:44=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> +
> +       if (bpf_is_subdir(dentry, v->dentry))
> +               ret =3D FAN_FP_RET_SEND_TO_USERSPACE;
> +       else
> +               ret =3D FAN_FP_RET_SKIP_EVENT;

It seems to me that all these patches and feature additions
to fanotify, new kfuncs, etc are done just to do the above
filtering by subdir ?

If so, just hard code this logic as an extra flag to fanotify ?
So it can filter all events by subdir.
bpf programmability makes sense when it needs to express
user space policy. Here it's just a filter by subdir.
bpf hammer doesn't look like the right tool for this use case.

