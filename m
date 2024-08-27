Return-Path: <linux-fsdevel+bounces-27474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F799961A9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 01:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C155284F15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038531D4616;
	Tue, 27 Aug 2024 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHCR3gNF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060C919ADB6;
	Tue, 27 Aug 2024 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724801425; cv=none; b=eIuv3klxpwGYqILUTtkhrR/NiTWz6liWwd+rGtA4W6oXSPos50s+dfta0t5reMId3y1WoF6zLODfwn4y2Pd3roV7G63uT2d7GbWhz53BV3Hji4d0rjBP7Svpe9DotAZoz7YDQV/PZqk4KgJjj+QdXq9v5TeVcXaui8KMKyb0Q90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724801425; c=relaxed/simple;
	bh=RhH0dhNYO5L8wmOJ3K/eXcM5XhNNs1TqVoeK6A1yOSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZzNdVlbNiALrM+qOB7Z3qrv2YBdKcMl90t+kKORtG8bh8O7lCPOBB63WFfgtAVSxr1andBcq6iYj/vKuuahs+OhWl+AgK32UVe4QcylZ+XNxiu1EtWmrFmpi91iZ99+hr++7ywIwU6CF9Nw0BgSamBEqOjf85Su8BwIqkJ0wKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHCR3gNF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d439583573so4436898a91.3;
        Tue, 27 Aug 2024 16:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724801423; x=1725406223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hza6Jbg1A+LzoIXgZFxWIfOKAPOq8dlsqOIG/XCE+wI=;
        b=HHCR3gNFjNnVn2MasNfPEHnLovaBKM2ZmrpJ0dtHq7lJSsoz8g1azLiDOnMS4hqS72
         Yku48y5V+3aaDWEksQK+6aHvwM5rxqBKUCOdA6mKIyMS2CfP1U9xzaEVXW6TD5k+djiB
         mazGwI4fww1//bkdDWVDR2QJSnUSCT4Wwbo2xfPeVp0fha8kk48QMEFc6+o/wZZ+xLDb
         QRZXDD+uenShGe3nqP3waaA+SipwtQ07rYgeWUKyiwQMXmtsefmT3AMbOlL5m/vMRykb
         XuO2N6Rfmk/RAouUU1kz8XaAg/SNQiO/EmcsWOkM5F1J675zhE/Hix4kEZup8iiMUdPG
         254Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724801423; x=1725406223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hza6Jbg1A+LzoIXgZFxWIfOKAPOq8dlsqOIG/XCE+wI=;
        b=h8wl9VHvQRL3onzrypeg6HhG1IQcJwcu1NLyz+aW1cgkcrmaElkU9CJAh/IXKKF9KW
         8UndMuH5WzgfshQRpACBx/i3PvqUlEuXDKieGbgcwzdc5BBZRxCnopRoCFzHpyryZHtM
         sbRlALxKn8TY+6gFeh1JmXu41Z7+RvQDa+EZkLPjbInZdO5+yDyW5G7GcBT8SLhpWH/I
         q3gpxpYVjQcxSwHJC5MRde3lETXpJwPUQGB4mP1Y/FPay3ossbiWud+3IrKEcrLW54gY
         CuCYRacE5wFE0Sxy0427lg43P2Zf9P4/epLJrtP0ApWybGb0WBaY3RMkQoNTz1DXvtuO
         z7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6j/NnCjh5a7sowGzZ1iGO21ndLa/2m5gzcGOa4n6M+HSQoYyv1uiZe2MUJ6BpnaqnvVr6tZGtIQ==@vger.kernel.org, AJvYcCVAVII+UmZEpJUj1T0ok5v/occbHYYUTusE+RcAFn14wTQrWaVptJTAH8y/jQxl4P+ezqdWJ4W2kytqEeo354Oq/SIQAbzg@vger.kernel.org, AJvYcCVclTPWqchwUbC6SVlDIfizjWCLbuex/LY7215eipSLarGX/O/J9nfwi576mB+EQ+s8qYGGkcLCltTZCjVwlQ==@vger.kernel.org, AJvYcCXRRs5EZWHa+Wq34f1aLRWl5t9LEE2PqY4XaensGB+VGkbwFHfj/S2gDYRUdX+ZtqBrrqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoTsF9pVpUtC3D2i85oEscF8A66cbpKr+PW8CGT3O5pU3lfghf
	L7UWh1ZBNY0c44VwEdn1flPgFyJP9poTu38X6fscurVt7xIUD24Yc3ThhpcqLcw7l/yUZKkVa2e
	zwCuO1Yjo8KtrjpfpEUIhq7eHPH0=
X-Google-Smtp-Source: AGHT+IHyG3Y77XSEiY9yBPR4KE8d2/1ZzC+HtlBBx0nBaLlUT6J3LAGJNNDVSzlhp1LyCwdkrVG0Ib2Y8HELRur9lRU=
X-Received: by 2002:a17:90a:ec06:b0:2d3:d8c9:780e with SMTP id
 98e67ed59e1d1-2d8441089ffmr334611a91.20.1724801423298; Tue, 27 Aug 2024
 16:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813230300.915127-1-andrii@kernel.org> <20240813230300.915127-8-andrii@kernel.org>
 <CAEf4BzaiAWzAU8w11w3C+ws7rdSONZ5S3_7OOXy2_AW1Rwf3zQ@mail.gmail.com> <CAHC9VhSetig0H1B+zAm_Rk8g-spn+WW8OL+g238Zn5pKEZZiww@mail.gmail.com>
In-Reply-To: <CAHC9VhSetig0H1B+zAm_Rk8g-spn+WW8OL+g238Zn5pKEZZiww@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Aug 2024 16:30:11 -0700
Message-ID: <CAEf4BzZnV6bLqwuW+QLEvZ8Ojk+NZE-QYabcgWF5eLzAiVptuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] security,bpf: constify struct path in
 bpf_token_create() LSM hook
To: Paul Moore <paul@paul-moore.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, viro@kernel.org, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, 
	Al Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Aug 27, 2024 at 7:02=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Tue, Aug 13, 2024 at 4:03=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > > There is no reason why struct path pointer shouldn't be const-qualifi=
ed
> > > when being passed into bpf_token_create() LSM hook. Add that const.
> > >
> > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/lsm_hook_defs.h | 2 +-
> > >  include/linux/security.h      | 4 ++--
> > >  security/security.c           | 2 +-
> > >  security/selinux/hooks.c      | 2 +-
> > >  4 files changed, 5 insertions(+), 5 deletions(-)
> > >
> >
> > Paul,
> >
> > I just realized that I originally forgot to cc you and
> > linux-security-modules@ on this entire patch set and I apologize for
> > that. You can find the entire series at [0], if you'd like to see a
> > bit wider context.
> >
> > But if you can, please check this patch specifically and give your
> > ack, if it's fine with you.
>
> Hi Andrii,
>
> Thanks for sending an email about this, many maintainers don't
> remember to CC the LSM list when making changes like this and I really
> appreciate it when people do, so thank you for that (even if it is a
> teeny bit late <g>).  To be honest, I saw this patch back on the 14th

Yep, my bad, I will try to be less forgetful next time. Thanks for a
quick reply and your ack!

> as I've got some tools which watch for LSM/security related commits
> hitting linux-next or Linus' tree that don't originate from one of the
> LSM trees and I thought it looked okay, my ACK is below.
>
> > Ideally we land this patch together with the rest of Al's and mine
> > refactorings, as it allows us to avoid that ugly path_get/path_put
> > workaround that was added by Al initially (see [1]). LSM-specific
> > changes are pretty trivial and hopefully are not controversial.
>
> Acked-by: Paul Moore <paul@paul-moore.com> (LSM/SELinux)
>
> --
> paul-moore.com

