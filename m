Return-Path: <linux-fsdevel+bounces-25890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF99515B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 09:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1A51F245C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95C413C906;
	Wed, 14 Aug 2024 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNC8/zIm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37829CFB;
	Wed, 14 Aug 2024 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621487; cv=none; b=nuB6bBhxrlAuY6yH1QdyAMYgLlgYQMqyCgSA8BwvVkcrpEWcbAiDeQ02iNGMQ4H40L7Q4/qbZEYBkE2ur5HK4yVpG0mjc8pwvpEjWb3MCr1dQvK7quUjqPwncv1jm2KZRZ7TpNm656KPRhkHmyOiRyIF6BnuVK0w0evKaftV6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621487; c=relaxed/simple;
	bh=X7ZR74qxegvWCExsbqkPxjZ910EyeK2C1VOJ9w+Oeg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1k3AOOQR2z5+T5vKhb05HlQP2TDNLnBhc1gohMW2K6RjV0ZkIQpMwQfLcsfWvHYdz7A3O49ngI+T9aL24S6urnrgiRj2Hx5AVdtF5AAlKVj6wnx1auvNuaSbxXVYXBUp2zwd1KPVS3gyFHvHNMye0qDpzszS0mXfSpwbSgWTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNC8/zIm; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f025ab3a7so3269365e87.2;
        Wed, 14 Aug 2024 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723621483; x=1724226283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7ZR74qxegvWCExsbqkPxjZ910EyeK2C1VOJ9w+Oeg0=;
        b=VNC8/zImK+xgHRxQxVYZNX0mulxZtBjAXIMe3tS75yGTlDieRbdRnYlLM8YU9qcy2l
         UaFEcoTx86yUtgnFZ5rGL4zauWDi+Cet1wHgkpMLVm1Ht2mg/pc6aTgtwTtChJWbbm2W
         QfN029wUyASM9+zFutvNTedFpvVuDiz8S1ZfvOxGsM+7VQVBC4AA3q7wz2gIoJVB4X9Z
         fiza2j07WhUTjg9PIhXMKjFhFEOjfDgdRXWC79dA5o3376urdoSjJ4dFT46AwwZbGsRK
         lLUE00ua69/Z2QJCzU4Nd6VSAsv+pB8uPtyItmN7LiV+Wptp14UCmHdRRvJO3ghNcROE
         yQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723621483; x=1724226283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7ZR74qxegvWCExsbqkPxjZ910EyeK2C1VOJ9w+Oeg0=;
        b=Ck41jxyW0gPs55qO/emU+wPssDmxPaECeAJXKPvQ60wNUOUCofGkocyok4wVHNEsNM
         HfmP5lS1PCsz4cQPFhlb47jmibVh/wPJBI/Oep9LtjYyLzZ8KYnNP9AWjEJxRXyA4oy/
         cr9iR471N6UnjH9oBc6MsYh9y/ShsQFMgQW1lVZfKIaF6dW8EX7mq+CwrbDr8ywtPNuE
         818HLbnZxM5chg44XUGLM4mYS0+q/v5CJVOlzO7Uokuh1L+7cCxWE0pmR/DqheLoPry9
         acwchQoMtC5gmSH/I1Lf2IcWyBN18MiHOo+2D/7VBuLbj42/C7z/xGrllsymVfVNsoDf
         lbfg==
X-Forwarded-Encrypted: i=1; AJvYcCXp6BnZYbr2VFQOB3lGJAhLYj3JguhBMCRMRGWu83qqYq3EactC3B1OyFq0xBLYWz4O4dIGNt/SQfq6Kfem1aWgE+oMYhOYaDdXZC9GlkkwToF0d7F0j9Abf0Mtcnu6pn6N2/r00tHvaW65Rh5/zDOanvJeKHU1IboHOkJYegum/oEtB6fcIPyL9Yx9csLwi3LxpPt1wGI2mb+tTl76KI8I4NrOVspAS8/xt/g=
X-Gm-Message-State: AOJu0YxnycHjwejYD6lGkAYxElDsaKxd1dwiGdo0kDiDc9oXkk/yEVaL
	JrCj391V3/08N0mnJQV38KgzPtR45+xgKrIcn4pl7hNpmvwwyWf/EerMYbkRt0SuB6jHxMGCDMk
	JZEAtUs+VQbk7LXp+Y46ZUPcXmjg=
X-Google-Smtp-Source: AGHT+IHJkXde1OwwGBk+YX2XBvSJp2vPJzqn1gETqia69EsI+RMzoJAY0GFmVJ7SQAPl/JBr8Y7slzZETMgovaMcJKQ=
X-Received: by 2002:a05:651c:2203:b0:2ef:2fcc:c9fb with SMTP id
 38308e7fff4ca-2f3aa1f9152mr14192331fa.36.1723621482997; Wed, 14 Aug 2024
 00:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812174421.1636724-1-mic@digikod.net> <CAHC9VhRp5hMsmZ9jUok+5c20U37XLiXmoEAguorTqRF5MQq2Gg@mail.gmail.com>
 <20240813.la2Aiyico3lo@digikod.net> <CAHC9VhRrcTo4gXrexb=fqEGbNcynKUUoMWR=EseJ+oa0ZM-8qA@mail.gmail.com>
 <20240813.ideiNgoo1oob@digikod.net> <CAHC9VhR-jbQQpb6OZjtDyhmkq3gb5GLkt87tfUBQM84uG-q1bQ@mail.gmail.com>
In-Reply-To: <CAHC9VhR-jbQQpb6OZjtDyhmkq3gb5GLkt87tfUBQM84uG-q1bQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 14 Aug 2024 09:44:31 +0200
Message-ID: <CAGudoHEQA5hZf_mpB0byt24doF7Kwj7XO-uJ2-oKm25DXX4s3Q@mail.gmail.com>
Subject: Re: [PATCH v2] fs,security: Fix file_set_fowner LSM hook inconsistencies
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:39=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> I don't see how where the cred reference live will have any impact,
> you still need to get and drop references which will have an impact.
> There will always be something.
>

The patch as posted here adds 2 atomics in the fast path and that
indeed is a problem, but it can be trivially avoided -- either use
get/put_cred_many or make it so that the same pointer means the ref is
held implicitly (after all the f_cred one is guaranteed to be there
for the entire file's lifetime).

Either way extra overhead does not have to be there (modulo one branch
on teardown to check for mismatched creds) and can be considered a
non-factor.

I have no basis to comment on the idea behind the patch.

I'll note however that the patch to move f_owner out of struct file
(and have *not* present by default) is likely to come through, it
already landed here:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dvfs=
.misc&id=3D0e8540d012189259261c75360d2725a2107761e7

I don't know if it has any bearing on viability of the patch posted here.

--=20
Mateusz Guzik <mjguzik gmail.com>

