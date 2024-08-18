Return-Path: <linux-fsdevel+bounces-26202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7F4955A9B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 04:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12131C20A80
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 02:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524748BE5;
	Sun, 18 Aug 2024 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWJeMW2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257B4C80;
	Sun, 18 Aug 2024 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723948063; cv=none; b=N+cuGkGfxtUmDu8MaXbjWEKN+lgKAOhTiBJkHvUPKT7GX/djXFvS1qSJKFJR6ZJnOUq43WqDOJEZHpAEdyxJV8r8+4ktNj56wNKZUDlvAhB+gWyhz+izQQ3dOvnGRHggXEWsSd43lBEzDpllcZqPj00Am2vl0k96a/CRuB6YI2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723948063; c=relaxed/simple;
	bh=04pUGq8xn6AO/pvOuW9ABo1fxGcbZbzmTxra89/hpZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQH84NyqqMTcwYIYNSbjwW5BT/ex42hhN+aI+u+FZcF9SZZezIzmmEEybD2dzyX/jZrwyodyC9df1edEcVTsKwXfWAPj4L8Ij8cMhV2dWV4XeiKPKINCA6r/PI8xBWmHTWfQiZGMqw9lDfTNbPALTqvM09GgXVZOJu2VYuuqwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWJeMW2k; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d3e93cceso411071185a.1;
        Sat, 17 Aug 2024 19:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723948061; x=1724552861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCUZss5UGlk8Yb6DPWfInlcX9mugrcEG4f0aPMm2bCE=;
        b=KWJeMW2kz15Yw/Ko2jmU1/QIf44RDV+ZitksmGohJ8EDVMJPr2bO4HDTZU4yDRuFMX
         YOxPbhWKRpe79gea0hU4UM4G/8EYNs3fGH07o2K5xrKyVJ1d1CMTRvfeyYnQm/x0Lom5
         j/5zArNBU1yOkbbcOinxqWBf+f3VorRsacz8XRMxayvvSRyHdej27oUJuPGkxurQNPzv
         f1S808OZLHTIENxmdIR4BjnTs70fhl2BOh+wpgKB1oe32ymZqKPBJ7axS0mMCs7HXqw9
         UBnLarmhUY+R5xY+9WWkF+UVU7Yjn8B3CzqpQH7DzVHpi3i8frqxcW/5jvhlfX6yqlYb
         BZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723948061; x=1724552861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCUZss5UGlk8Yb6DPWfInlcX9mugrcEG4f0aPMm2bCE=;
        b=XF4Xddrky2u+lM2y1zm6a85snS8YBP1wWJFa5C0yj++APmKmHeMwdz3EGAFhKkujfk
         SLQnKk3nlM8OP9RThMbqQWg4L832DF0SkwQLstcJ7fwhOF0Ch2ffvwy0WPVCtlVjcmPo
         OVO6rf5Lh2R4wzMtbQz3W0zWZcH/lA6KcDP668tHVVu+MQWe2XSkPdCejmQIpQaqLwSP
         9hwEqSJPjpIvoBqLGlSoo5vAhguJ7ih91Pei/nIeTXga7hCwj1gr2w96uGCvjdNWfxy2
         AX/f6mPW8kxNsMr3IMdSFjrqPAPIqnHZB/8fg1OHtdxs+SnDOp5JK71qdrP/FfPRjVGY
         Ofvw==
X-Forwarded-Encrypted: i=1; AJvYcCWfmC0oUFus7AGAOv8tTa7MhhEfFRmuM0LQeP0d/bm1PpUirB7J3N3j5h/PHZj6wxZSZr9/fengtXMY7KaF7LzlP63Xf5xhr0A2NkIOWZMFNa4lcqKRKH+kfCzzrHSpkCw7dz5/xU1c5qpkRzdkrsMOwyVVvBEtmJMR2/x486xvW2QbbjenKzjfof4uf0PkLA4m5zjGevgRnYC34KIFFiFg5XPXO09vg4lPasglN2ivFh1vRX05HaDAmI0I4WZMMTMMdufkpMZzFF1c/hyhmVPaxaEwFvuB+J4yLsmN2A7x/n8YGhWYYRFrT/+6un0UY5fQJwGzMQ==
X-Gm-Message-State: AOJu0YwFWnJteLc7LVrcW325GHdf9sVR/h4JRPWW5iAymluJRgm7xrs5
	rR7Md3aRLMzYVV1xkK7heHWtocGABbMGyBka9AGguV6SVNIYlmS9Qd+hhdpiwa5VZHgOz/MGDMM
	on42UBFOi2egJhVHF7m4d5hv8QkE=
X-Google-Smtp-Source: AGHT+IF6fsYhsqIGmUj8T8nAX8ZPHa9aPPiBT0MCECGu/PEHdrCH4USnvIhXgIzMD1DqBj/lqnH5UAtX5RLYSKjl0r4=
X-Received: by 2002:ad4:5894:0:b0:6bf:7ae1:9a8f with SMTP id
 6a1803df08f44-6bf7ae19b89mr122178546d6.19.1723948061122; Sat, 17 Aug 2024
 19:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817025624.13157-1-laoar.shao@gmail.com> <20240817025624.13157-5-laoar.shao@gmail.com>
 <teajtay63uw2ukcwhna7yfblnjeyrppw4zcx2dfwtdz3tapspn@rntw3luvstci>
In-Reply-To: <teajtay63uw2ukcwhna7yfblnjeyrppw4zcx2dfwtdz3tapspn@rntw3luvstci>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 18 Aug 2024 10:27:01 +0800
Message-ID: <CALOAHbAzSAQMtts5x+OMDDy1ZY5icUJv2wAM5w74ffhtEbN1mQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] bpftool: Ensure task comm is always NUL-terminated
To: Alejandro Colomar <alx@kernel.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 4:39=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> Hi Yafang,
>
> On Sat, Aug 17, 2024 at 10:56:20AM GMT, Yafang Shao wrote:
> > Let's explicitly ensure the destination string is NUL-terminated. This =
way,
> > it won't be affected by changes to the source string.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Reviewed-by: Quentin Monnet <qmo@kernel.org>
> > ---
> >  tools/bpf/bpftool/pids.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> > index 9b898571b49e..23f488cf1740 100644
> > --- a/tools/bpf/bpftool/pids.c
> > +++ b/tools/bpf/bpftool/pids.c
> > @@ -54,6 +54,7 @@ static void add_ref(struct hashmap *map, struct pid_i=
ter_entry *e)
> >               ref =3D &refs->refs[refs->ref_cnt];
> >               ref->pid =3D e->pid;
> >               memcpy(ref->comm, e->comm, sizeof(ref->comm));
> > +             ref->comm[sizeof(ref->comm) - 1] =3D '\0';
>
> Why doesn't this use strscpy()?

bpftool is a userspace tool, so strscpy() is only applicable in kernel
code, correct?

> Isn't the source terminated?

It is currently terminated, but I believe we should avoid relying on
the source. Making it independent of the source would reduce potential
errors.

>
> Both the source and the destination measure 16 characters.  If it is
> true that the source is not terminated, then this copy might truncate
> the (non-)string by overwriting the last byte with a NUL.  Is that
> truncation a good thing?

It's not ideal, but we should still convert it to a string, even if it
ends up being truncated.

--
Regards
Yafang

