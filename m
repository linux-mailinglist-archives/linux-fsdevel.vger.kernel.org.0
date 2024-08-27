Return-Path: <linux-fsdevel+bounces-27473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B230B961A7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 01:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1744CB2297D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D751D4611;
	Tue, 27 Aug 2024 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JcmGxJsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA71D3186
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800873; cv=none; b=Bj0GC/n2h0aniqnR2YqYb06Xk0+1kP1xy4O0TfDKFyCvriiVbEuxWPcbiZt9H3ueip+xfJYm9Lqbxxk+O/x7HC+eDY5jmxYFgyjxgZH0YKdFygL1TS32Hg0sB6PgNGZY1m0jy1N1yMduDmDBEOmoWE3upnSwfHpS136eS5CjviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800873; c=relaxed/simple;
	bh=FuDNkY+uSpuYPew/32LGWl2xNMxMVFyiWNz4YKSjOlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+SXa71hLhsMU3ml9CZOPvBbZXU6a2VC7JoclUoXpC8BEyjvPLYcxEr1DMkdGFmHm0QMkBOsxKFw5GcUrskwk2+yQuadsojL8Q640Upph0GxshmhJIKQnglXo1TUOzqwiAAXHnD3lY091YQnqFrKIvr3UxK67a2aU6ITJCo6x+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JcmGxJsE; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b5c37a3138so54460007b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724800869; x=1725405669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyfSsM1kWmLy0fivMTkjdvz46hfeP5aLbodjn1Oq3DY=;
        b=JcmGxJsEKVm6iLeqDBRr9Gs8M+EfELFgEk+Pi+x1EZAkZp4yFsuAFdz0/bY5Ga5VVf
         YevmuiTjx/KvIp07ZIRyxydQgTQX88arxZCQSCmPSYax+UrLWaIxWqZnKc2knxslyNSj
         nMO+gHDMZaw40lMAF27/0Q9kxm9YRbwtOnBTkOZ8SDb7/AAPopyGY2d6mmK8iyUj2Xix
         yoO1PEAowzbg2pEYEstpNFA+9Rajh6Z83kCnoDe9TjqFrI+ogrcUGX7OLgA4gr1+b2uS
         BPvykPbNTDLY3Afy+4pCkCWHkz+D8ih+6cQ0+YTnQYxrVZXl46vHCUjJFQDTtn1nuwoA
         jYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800869; x=1725405669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyfSsM1kWmLy0fivMTkjdvz46hfeP5aLbodjn1Oq3DY=;
        b=If9TTIvWWL8rBvf4ssTFRQoCdJ/eYalRPPEjgKc1LCHEZO9kEP/NgDf8dJEUQwuAST
         5RSmUJMm0xgL1yYckygs+9d+XHsYr8ObVNlts910/LRJFz8f9gNOnV9nP+SVVQOYjXFG
         rDgJbQdaqZrVuPZtHzBMTJ0oBiMkISKcSQ582lZKRjpSBoS1258PzF5pS/GhSh8e6KVi
         kN1/neWVvJqpsz24LjQPJ/M5lOEy8BbxooMKyhzdXjO6MV0gxFuZIKHJx6yPXtqLT5mA
         qHG/T/kufP3zyZd2ENCdhtOEL3Pgf0fW1L0HM1utZQ3uCYXG0grdwrInkvSeAK1njoHP
         ulLw==
X-Forwarded-Encrypted: i=1; AJvYcCVYSqi8rfMqROEQBEMVhXYr8M3SrWbHR8ExEeE0kKbZm4ywkKuecDoYUH61s0j/qfQ5A77sczSVQHGv6TYg@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7VzHUW/Kp2pLx6Kc9egWwae1FJiRtyBOkDlzhoCYNR73tVQ9
	2sK9ldh4JnjK8u403f77PpyPnKTId/PlMIznEvU1LXl06XOGaBYeBeobmBUql0UfJwmRWnGbdaS
	CiecoQiSPNbun1FYs5J4mH3Lh+NHmrYQC43b9
X-Google-Smtp-Source: AGHT+IGtjzAhyrZwchJ5S91zBSvF0K/mC+GuXMXbe0LAFX6ZoLlxNnafUGdCPkBDqzGdma6ROv4c2MUeRTI4Zy5itVM=
X-Received: by 2002:a05:690c:ec8:b0:631:78a1:baf with SMTP id
 00721157ae682-6c624fb6b9emr171684047b3.6.1724800869371; Tue, 27 Aug 2024
 16:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813230300.915127-1-andrii@kernel.org> <20240813230300.915127-8-andrii@kernel.org>
 <CAEf4BzaiAWzAU8w11w3C+ws7rdSONZ5S3_7OOXy2_AW1Rwf3zQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaiAWzAU8w11w3C+ws7rdSONZ5S3_7OOXy2_AW1Rwf3zQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Aug 2024 19:20:58 -0400
Message-ID: <CAHC9VhSetig0H1B+zAm_Rk8g-spn+WW8OL+g238Zn5pKEZZiww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] security,bpf: constify struct path in
 bpf_token_create() LSM hook
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, viro@kernel.org, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, 
	Al Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 7:02=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Aug 13, 2024 at 4:03=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > There is no reason why struct path pointer shouldn't be const-qualified
> > when being passed into bpf_token_create() LSM hook. Add that const.
> >
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/lsm_hook_defs.h | 2 +-
> >  include/linux/security.h      | 4 ++--
> >  security/security.c           | 2 +-
> >  security/selinux/hooks.c      | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> >
>
> Paul,
>
> I just realized that I originally forgot to cc you and
> linux-security-modules@ on this entire patch set and I apologize for
> that. You can find the entire series at [0], if you'd like to see a
> bit wider context.
>
> But if you can, please check this patch specifically and give your
> ack, if it's fine with you.

Hi Andrii,

Thanks for sending an email about this, many maintainers don't
remember to CC the LSM list when making changes like this and I really
appreciate it when people do, so thank you for that (even if it is a
teeny bit late <g>).  To be honest, I saw this patch back on the 14th
as I've got some tools which watch for LSM/security related commits
hitting linux-next or Linus' tree that don't originate from one of the
LSM trees and I thought it looked okay, my ACK is below.

> Ideally we land this patch together with the rest of Al's and mine
> refactorings, as it allows us to avoid that ugly path_get/path_put
> workaround that was added by Al initially (see [1]). LSM-specific
> changes are pretty trivial and hopefully are not controversial.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM/SELinux)

--=20
paul-moore.com

