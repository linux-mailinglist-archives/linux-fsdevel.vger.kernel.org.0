Return-Path: <linux-fsdevel+bounces-21676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9F4907DB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 22:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7A2285B72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 20:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290CB13C832;
	Thu, 13 Jun 2024 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LY4ASSj5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C346C13B5B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718312114; cv=none; b=YRNTNMeLtyJC9Jshx14Ra41/AjXqqzueqhN7+QmnqnIROb4o16zpIrOxCvlrBO3pdi7P9FCN9ZSArS49/qMUg+azeS8yOOzGhPtdJmjiqvpPiW0r6u11aPJu0hej+W2uJzb/Y9R6Jziijlan+gnsPZEfpU+gVcjN9s2m6cPaZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718312114; c=relaxed/simple;
	bh=l5BZRVe4EjUxYN3yXF5F7zfYiMw/7+iKLgPHpiV/pbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZFqASrTGggz982qhp2IEM6cnEuXYtR3JFmm8RYrMjmoO/cvc0Kkr8qrJfM2fS6i+3Vg3iJvNloOAdxugxxfeDIr+KPIyOZFQpX2Fp1wnk8OTAuke3NbA6GDGvipvjyZEpXIIoOlNZzvh6mUyuyIi1iHjwTXDKFCkmOv68ZINRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LY4ASSj5; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-63152a07830so10688437b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718312112; x=1718916912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcXAwgD8G/DtMBTj2XjZiXsT2OTNX1kHEG3gcoNV7As=;
        b=LY4ASSj5sD1R9fmYZn5gSBdQcVKzA/Abv6SD3GZehE/Wn/sDSFoAp1R/vhdCDnwbf+
         b83ZV/RHzrYz32yqmtZQVOwlbNCk5jFSSY8Ik3l/S3j10VNT7tVhSg7az9C8eBWBFjdy
         j2PuEv2yLn903jg6kZp4KtNTlc5UaM4pK+W38Sx7a9auud2uZ5LoWNHqLqacnv8dYGrW
         xRALKPOwEPfpDwZ5tuXLIxYXsGseEFUbyVIVyPZpZ90SbdwdV6aaDp/xx0S+06fJ6bbx
         WBaG+a7x50apV2PFHdkYt6I9t/ZZGrkI6JfBLa14L/dhPQ/Y7UR4OpHbRhwRJkSnhMEb
         p5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718312112; x=1718916912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcXAwgD8G/DtMBTj2XjZiXsT2OTNX1kHEG3gcoNV7As=;
        b=LInysDLJjgHkcckiBs8OStUTUeZpLzpl91WAFn7DhywR9ahKAlUe2wVGg6k6igbpnd
         iRAHxaucNPWEozS26h+uCcnG7UYanJTTtP/2AdY2UYFZi8MZ1tiOgOTKeWOmS96p5gO5
         nbE0pwHu+3rwVX8vsvsNObnre1aJRmIjgm3GJ+9RdPM90Kips6OU86l+aJOR7RdyK8gk
         UamH9RSBWClrnGwviG8ur6VYyCaKtBVFzSd6jN2riRwC9/7Nbeu++7er7VmNJjySt3iB
         Wj1LPSiMug6W4ua2I7zrqa5B54SSyyU08tibijpz+ymPsjymZqrWcRSVrkX0zexWa7lv
         C/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXK14imXwf55y/V00CQybyXL5AMMLqI1DAb7AJc4Ur86bWAuNwnMzaoqTZxtvpSZei9PyxBLV4bAcM0aqBQs6Mz5xENpPenvXr90+YBVg==
X-Gm-Message-State: AOJu0YwNY26zz56EYZEQufj/7p6oMs60PC6LAOHoNd1r6twiOUiwYNmo
	YZjDwmpnsZ8cfrW2ytq1ubt/Bt/veqBBb3+VgdHaC81l3rS6dcDllfecwADQbpsCvOWdjygTWI/
	tNbcnqDG+dXb+sIYuVJM+clqF2xxbjUDzku2B
X-Google-Smtp-Source: AGHT+IGDrzqvYL8x8To8WRZC5EK4ZE7eYh19cN6eIrPp+Dp9L8DQSAkqnp5RVfEyty6oWnZormmtfNXBsvqkuSccnaA=
X-Received: by 2002:a81:910f:0:b0:62f:ad9c:cd4 with SMTP id
 00721157ae682-6322470facfmr6187707b3.41.1718312111715; Thu, 13 Jun 2024
 13:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609104355.442002-5-jcalmels@3xx0.net> <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>
 <z2bgjrzeq7crqx24chdbxnaanuhczbjnq6da3xw6al6omjj5xz@mqbzzzfva5sw>
 <887a3658-2d8d-4f9e-98f2-27124bb6f8e6@canonical.com> <CAHC9VhQFNPJTOct5rUv3HT6Z2S20mYdW75seiG8no5=fZd7JjA@mail.gmail.com>
 <uuvwcdsy7o4ulmrdzwffr6uywfacmlkjrontmjdj44luantpok@dtatxaa6tzyv>
 <CAHC9VhRnthf8+KgfuzFHXWEAc9RShDO0G_g0kc1OJ-UTih1ywg@mail.gmail.com>
 <rgzhcsblub7wedm734n56cw2qf6czjb4jgck6l5miur6odhovo@n5tgrco74zce>
 <CAHC9VhRGJTND25MFk4gR-FGxoLhMmgUrMpz_YoMFOwL6kr28zQ@mail.gmail.com>
 <ba8d88c8-a251-4c1f-8653-1082b0a101dd@canonical.com> <zwh766li4dwx5be6uxnxl2lhtxb4jsiua4atilpqvoeuksgz2h@v3pna3o3ewkp>
In-Reply-To: <zwh766li4dwx5be6uxnxl2lhtxb4jsiua4atilpqvoeuksgz2h@v3pna3o3ewkp>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Jun 2024 16:55:00 -0400
Message-ID: <CAHC9VhTaD+LxEL8hMdbvFFJgU1xbEtmN7gSwSdKRS=hX_uVnVQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM hooks
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: John Johansen <john.johansen@canonical.com>, brauner@kernel.org, ebiederm@xmission.com, 
	Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	containers@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	apparmor@lists.ubuntu.com, keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 4:45=E2=80=AFAM Jonathan Calmels <jcalmels@3xx0.net=
> wrote:
> On Wed, Jun 12, 2024 at 08:54:28PM GMT, John Johansen wrote:
> > On 6/12/24 10:29, Paul Moore wrote:
> > > On Wed, Jun 12, 2024 at 4:15=E2=80=AFAM Jonathan Calmels <jcalmels@3x=
x0.net> wrote:
> > > > On Tue, Jun 11, 2024 at 06:38:31PM GMT, Paul Moore wrote:
> > > > > On Tue, Jun 11, 2024 at 6:15=E2=80=AFPM Jonathan Calmels <jcalmel=
s@3xx0.net> wrote:
> > >
> > > ...
> > >
> > > > > > Arguably, if we do want fine-grained userns policies, we need L=
SMs to
> > > > > > influence the userns capset at some point.
> > > > >
> > > > > One could always use, or develop, a LSM that offers additional
> > > > > controls around exercising capabilities.  There are currently fou=
r
> > > > > in-tree LSMs, including the capabilities LSM, which supply a
> > > > > security_capable() hook that is used by the capability-based acce=
ss
> > > > > controls in the kernel; all of these hook implementations work
> > > > > together within the LSM framework and provide an additional level=
 of
> > > > > control/granularity beyond the existing capabilities.
> > > >
> > > > Right, but the idea was to have a simple and easy way to reuse/trig=
ger
> > > > as much of the commoncap one as possible from BPF. If we're saying =
we
> > > > need to reimplement and/or use a whole new framework, then there is
> > > > little value.
> > >
> > > I can appreciate how allowing direct manipulation of capability bits
> > > from a BPF LSM looks attractive, but my hope is that our discussion
> > > here revealed that as you look deeper into making it work there are a
> > > number of pitfalls which prevent this from being a safe option for
> > > generalized systems.
> > >
> > > > TBH, I don't feel strongly about this, which is why it is absent fr=
om
> > > > v1. However, as John pointed out, we should at least be able to mod=
ify
> > > > the blob if we want flexible userns caps policies down the road.
> > >
> > > As discussed in this thread, there are existing ways to provide fine
> > > grained control over exercising capabilities that can be safely used
> > > within the LSM framework.  I don't want to speak to what John is
> > > envisioning, but he should be aware of these mechanisms, and if I
> > > recall he did voice a level of concern about the same worries I
> > > mentioned.
> > >
> >
> > sorry, I should have been more clear. I envision LSMs being able to
> > update their own state in the userns hook.
> >
> > Basically the portion of the patch that removes const from the
> > userns hook.
>
> Yes, pretty sure we'll need this regardless.
>
> > An LSM updating the capset is worrysome for all the reasons you
> > pointed out, and I think a few more. I haven't had a chance to really
> > look at v2 yet, so I didn't want to speak directly on the bpf part of
> > the patch without first giving a good once over.


> > > I'm happy to discuss ways in which we can adjust the LSM hooks/layer
> > > to support different approaches to capability controls, but one LSM
> > > directly manipulating the state of another is going to be a no vote
> > > from me.
> >
> > I might not be as hard no as Paul here, I am always willing to listen
> > to arguments, but it would have to be a really good argument to
> > modify the capset, when there are multiple LSMs in play on a system.
>
> The way I see it, it's more about enhancing the capability LSM with BPF
> hooks and have it modify its own state dynamically, not so much
> crosstalk between two distinct LSM frameworks (say one where the BPF
> LSM implements a lot of things like capable()).

As I mentioned previously, if you want to do something with the
capability sets you simply need to do it within the confines of
security/commoncap.c.  If you're really set on the "MUST BE BPF!" way
of life, and you can convince Serge (capabilities maintainer) that it
would be a good idea, you could propose a dedicated BPF hook within
the capabilities LSM.  I'm not sure how wise that would be, but it
would resolve a lot of the LSM ordering/stacking issues that we've
discussed.

> If we think there is no way we can come up with something that's safe
> enough, and that the risks outweigh the benefits, fine by me, we can
> drop this patch from the series.

To be clear, this patch is not acceptable at this point in time.  With
the understanding that I haven't looked that closely at the rest of
the patchset, it looks fairly well contained to the capabilities code
which means it is largely up to Serge, not me.

I will mention that you should update the audit code to recognize the
new capability set, look at kernel/auditsc.c for more information.

--=20
paul-moore.com

