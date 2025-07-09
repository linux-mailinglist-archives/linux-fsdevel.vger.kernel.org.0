Return-Path: <linux-fsdevel+bounces-54388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2578BAFF16C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 21:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC485C11A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 19:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6081F23F27B;
	Wed,  9 Jul 2025 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gNSh2cAx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2C239E98
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087888; cv=none; b=eKLbo8lnhrE5cx/0syl241XpNAJCtVmDx6X6hlTQu9rYFn6NxMN4pljQZoqywtAPqfveJ9rEmTNZ+ZG20jB4hvFchxqIkJCzax7JeXYfIugtGAa8KtyOUxFooq9cNCnKcjMUy468wGPV4OCV3uBqFDqlw2diAAJVDsOhXQHumH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087888; c=relaxed/simple;
	bh=oRGJxOoY6Sb9QvNhIjZ1ZJhSnfSKCQdsXzj4pLtR8xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFpdQNqOOUX+LhbD/VhU4PwJgRK/t+yczcZNN+cBY2DuhXRO9bheYM7VOuTV6+BjPjEw1QOFgzl82HHvoF5qsjRapU6OsLlOtraMrvUbb75lcIz4wP1052v0IWan7hIfHEGuPHfTb9M8wIZuAUQGhj7GX7vS7LUi5PSorP639CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gNSh2cAx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo216739a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752087885; x=1752692685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oMoCHTAV5NeIpZMq+DMEKC+TktfxuQeI3NG81ytBeE=;
        b=gNSh2cAxDTBJoHztwizWyZZ3DiFKTi3wxKyznQsDnWmd1QbZGN06zsxFOINFhEp7IB
         yfLbtqYSVkGMDhyxZGxjcQN0jFYGzFPHVc2AZqXty9tL0Ju71UroMih9Mr3iu6qqV7nj
         lw3c1trpU/sgXaZdW46x5q3VycvC+Kx/pxnQQXN9w6q3xMS7sKadXvuhVHVnzfWr63rJ
         u3NymWMMO1a7A8hAtX4WzUdkDKBocrk80U9+CLlbQYfVpTVOE9lLlTSmGtusmKB//WrA
         AnSkmEGx+FU8/5DPnl1aVOIkMS+Pl+t1jRpA/y/1wOVURm5tvoZL7W7LiTNKp7/jsU5m
         hanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752087885; x=1752692685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oMoCHTAV5NeIpZMq+DMEKC+TktfxuQeI3NG81ytBeE=;
        b=ShMe/qCfgeNel+jbAcjYFLzE1TQeeBYzB7GKMvwmKb59/Kll3tbAeXtXmYHuNLhwI8
         llIzmINQ3GgQaVfsVgqE0276cTZ9VVreOMuKpPXbA6JqDHHbKAv5vRtTIP0X6k25zju3
         OCF2G8HfuZHCPe1QJNnkWBG5zM6Bn3va38Jl5gkwoMXW14Kyz7gdfkd9O3uJcTCMA19O
         l4aQs2CgqFf68DSonZnfdGja5LoRjn8/Ja7xBElLpHsymp0+mVd2wWOC5e+5gvnMh7ZC
         MP+05+qsDng+OLvJYAwb2v5e8K+5UZqLVBSpPbLaHEVck7sghUCoojBBVti7gSFo2KyU
         4zVg==
X-Forwarded-Encrypted: i=1; AJvYcCUxb3v/PJn9aOhrSAHktFnVwSA7x30PhMC73xPfjxOyS4CX9LAqUTafZwYsF/LbF3st5fLAJg1zgQvUHS6Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBGYBJbkSk4oRaDu3lzVxbZbxicHZZhWriDyiI/vvyEKS9Lgc
	DcrNaZP6OT+wFI1DCbtKrS/uU2Ob71wpFPPr8SJgFrARRQrpNNqHr4j8aFkGh4Y9u6DpPD31OyC
	f9bbGRMnWJeClijH/TUXe1kEg0ufqLl4IDWHZ+sFftQ==
X-Gm-Gg: ASbGncvHDVexi46K3QJUI3gSUJMvAIFfRm9+a5mD1Xm8FNA5xoU4nvlTnO5yEJ4DhOh
	gzXulYSp34tJz0YK72rQsVPuO5ZQ7tjGFBHufk0oXFL5e+C4NA38Km/vPVsqyw9gDDXa3B8Udba
	U1hQn2vAadsHhlKcSTXpCHKQE/MFdvppj6dPskWuwUhrvfdZ32SsoO5CrOJLQnkBZl4HlgjmVwF
	gOSoKEd6Q==
X-Google-Smtp-Source: AGHT+IHHFatUYcYPUIaiNLDpnLA9ZJlzI11FgOes6AgoJS9tnoz2rAKkdasV4aiimfA44DVTmm7JJ+DkAfN2TlJGB04=
X-Received: by 2002:a17:906:c116:b0:ade:450a:695a with SMTP id
 a640c23a62f3a-ae6cfbea8f3mr343461166b.61.1752087884599; Wed, 09 Jul 2025
 12:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
 <2724318.1752066097@warthog.procyon.org.uk>
In-Reply-To: <2724318.1752066097@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 21:04:31 +0200
X-Gm-Features: Ac12FXxBjj4Q8rQSAFMTvxq4Dux5Rk-Aycgaq2Qj_9vYK8pVlc0gHVgIsMegDWo
Message-ID: <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:01=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
> If you keep an eye on /proc/fs/netfs/requests you should be able to see a=
ny
> tasks in there that get stuck.  If one gets stuck, then:

After one got stuck, this is what I see in /proc/fs/netfs/requests:

REQUEST  OR REF FL ERR  OPS COVERAGE
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D =3D=3D=3D =3D=3D =3D=3D=3D=3D =3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D
00000065 2C   2 80002020    0   0 @0000 0/0

> Looking in /proc/fs/netfs/requests, you should be able to see the debug I=
D of
> the stuck request.  If you can try grepping the trace log for that:
>
> grep "R=3D<8-digit-hex-id>" /sys/kernel/debug/tracing/trace

   kworker/u96:4-455     [008] ...1.   107.145222: netfs_sreq:
R=3D00000065[1] WRIT PREP  f=3D00 s=3D0 0/0 s=3D0 e=3D0
   kworker/u96:4-455     [008] ...1.   107.145292: netfs_sreq:
R=3D00000065[1] WRIT SUBMT f=3D100 s=3D0 0/29e1 s=3D0 e=3D0
   kworker/u96:4-455     [008] ...1.   107.145311: netfs_sreq:
R=3D00000065[1] WRIT CA-PR f=3D100 s=3D0 0/3000 s=3D0 e=3D0
   kworker/u96:4-455     [008] ...1.   107.145457: netfs_sreq:
R=3D00000065[1] WRIT CA-WR f=3D100 s=3D0 0/3000 s=3D0 e=3D0
     kworker/8:1-437     [008] ...1.   107.149530: netfs_sreq:
R=3D00000065[1] WRIT TERM  f=3D100 s=3D0 3000/3000 s=3D2 e=3D0
     kworker/8:1-437     [008] ...1.   107.149531: netfs_rreq:
R=3D00000065 2C WAKE-Q  f=3D80002020

I can reproduce this easily - it happens every time I log out of that
machine when bash tries to write the bash_history file - the write()
always gets stuck.

(The above was 6.15.5 plus all patches in this PR.)

