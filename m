Return-Path: <linux-fsdevel+bounces-24649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8CA942477
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 04:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1487B23CC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 02:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492812E5D;
	Wed, 31 Jul 2024 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoiVWuAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FE23BB;
	Wed, 31 Jul 2024 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722392127; cv=none; b=Ecymr8250RzGTDZEk2AYTuugc97OnjksMwdAGCb1jPxyvkTmBLOUt5CyahVZbi2L0H/rEwvErx2QI5cewJNjHL3cuNos+mrIAGZ7em/Y7Wuywb3m2ceSQ8enupY0cXjG3uOOUU2ijm2zvKOlwV4mW681IXVvzeSZLFUedmuRczo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722392127; c=relaxed/simple;
	bh=0AyB6FRnuqjrcez3EHZaZCqZ0VKwUEuDsGyaSyiRaUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bztZfQ+EyVovGhOIVSUPMUt4YIZDaFVUBhKBj5eIlD2jKy/IQrSQJntFqvwcg0ng9qyrjYhsJbSBejAc8u3rLjsBje8MhjBjur4focNgp+3IEJojLXN75xpj3NMEJ9K5JGAe98Z4nS47SdLIuOmfxoGVQaGgqNiBrCXVzxRFieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoiVWuAD; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b95b710e2cso31865036d6.2;
        Tue, 30 Jul 2024 19:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722392124; x=1722996924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpOoG/RLrOqlfYfTau1ZI4Yg/763W2V/48rNlpEaGLo=;
        b=SoiVWuAD544XKkNhXBkJOW21oI4ECWqDxXMFgpSMEIfbxBfaRKTR/ZEY94dIrcongj
         LlAzO1OrMENJtqHfpEd5Hktt4ylACpNNVbN8H5TQNTrv8auydoyNjBGA1XuSK62UfUFS
         SB26y3Ele23Yt8UrO6VWyjx8hYQv/ASCcUTNPIBz5S4/3eIxVuVnmruEzPl9zHQ9mYAZ
         8YEqKyJv5GCjIGGybNLUlu9qAoLhGf+KMtWlTTchvNeeWMrU1gvN3HLXBF5VWvhZkuvm
         Pzg/DKyx6dunt4ChbL8RjBaHO4oBiZSETecnn8asDwVAqIkViBx8dlOptpMWfqBSNm/f
         rrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722392124; x=1722996924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpOoG/RLrOqlfYfTau1ZI4Yg/763W2V/48rNlpEaGLo=;
        b=BMItm0bxdOFZNo9uzqJx0xcojAOHohwtkJLNVfEeysQe4l6wy83T8k7tRjTMrvjfR3
         SpxDwEoWM6NkEbMK10UIW/BTLEZ8BQ/eq1trSm/BVpKql2yrsvEEtwFo4lTWrg91gT4p
         sH2pfOOOS9ip4TGxgA4XDlMx+z3Z58VU0kIHQLxcwTmN5DrSilWSxl/J3rzDOdUTbZsu
         2P45ylwTguw3QhmQXEsxvE+vEuWxgb1ztv05jDrQJ/5oxSglwGIle/2WiMWmmDrFzvcz
         0NWRlMY/at+PxFIbb6CBC3r75AdT4TNp1UFAOEuqDeSM6HY7NcSyci3Jtj5zC/T/vOw9
         40/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuOk8uq2VeuT+M1YpB8RvkmODaZges+tobqGgQwEMBE5JskHcsYq7QNNMbWGQPQ2ESst/TcYtyT1G1nIP18SXVUxSOe+syafEPyQNIJptpejk6nfQBYhElNbwLb8b0i10zrJqwb7dV8xSj0p32gYw4WmCQh+UnRnnGP9fnTE4KWaNdI4h3piI7+BuM+yAdDdkmykRkKgUpVlJxKal/ToMqo2UOSxCrInunjxCpi99GQnWdCawGLO69lUrN1Spa6g3kzJhnXBu8Gfb1VvQwmeHKGeLBG8r+Jx4KLr6vK+cdFj5dIAhxeJ8lbsvijU0w2UNj/Qs5KQ==
X-Gm-Message-State: AOJu0Yyf+D+hWP0tP3RMtUOO0cMIgJ+B6Bg9xYH59YaEB0Rlf+pTyTr2
	xAqaY0PLMWxhsM+ha3jEu8GdZOujo3VoP/d6iARYlmKHax0AaiC6Rnob2MKeTr01efBYfyIRqCz
	teITkzJ3Bu0iOT14UH8bRm6FJFcQ=
X-Google-Smtp-Source: AGHT+IExK4nk1O4rGXBVJI3hTBgaSm4OMa/Q+JI34XmOHqthammrX2+56ouv+IPsoXJAUAPqosbOqNjTYsvBgTnKXGc=
X-Received: by 2002:ad4:4eed:0:b0:6b7:b3b8:e882 with SMTP id
 6a1803df08f44-6bb55a5c953mr178760546d6.25.1722392124637; Tue, 30 Jul 2024
 19:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729023719.1933-1-laoar.shao@gmail.com> <20240730175927.673754c361a70351ad8a3ff9@linux-foundation.org>
In-Reply-To: <20240730175927.673754c361a70351ad8a3ff9@linux-foundation.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 31 Jul 2024 10:14:48 +0800
Message-ID: <CALOAHbBiYPNaULVSR5DS=XE=C28DVmwZC48ZZ4DhOf2SYqkz4A@mail.gmail.com>
Subject: Re: [PATCH resend v4 00/11] Improve the copy of task comm
To: Andrew Morton <akpm@linux-foundation.org>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 8:59=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 29 Jul 2024 10:37:08 +0800 Yafang Shao <laoar.shao@gmail.com> wro=
te:
>
> > Is it appropriate for you to apply this to the mm tree?
>
> There are a couple of minor conflicts against current 6.11-rc1 which
> you'd best check.  So please redo this against current mainline?

I will rebase it.

--=20
Regards
Yafang

