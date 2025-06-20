Return-Path: <linux-fsdevel+bounces-52345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D067AE21CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87114A843F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCB02EAD1A;
	Fri, 20 Jun 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhJem19N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE42EA752;
	Fri, 20 Jun 2025 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750443090; cv=none; b=Gh148CpQ+BDl5heV6qpqtCSTTQI27IAZBlfz2eCelZEqr4nu16ZzpZT0yzzhyBhHk5VKHpQ55bFs05wkvPgXWTGXVTn/U1UOvE5r+FHvsg+wLhZmS6g3Ozj0mqyZ1vS+GVPV5WkGBsDk7SOZ0wYh+LZKDomRqHlzSJccDdUWEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750443090; c=relaxed/simple;
	bh=1dDLFyjAEHX8cxwcTCC/k6iBaRFF/axpFXkeBLu67dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvcSxBMNFIbQaE2fo+4aWcGFvG4rJ9Bs4fmriMSUf7s6KTCXH5pbmoucFgr0xXMYuS+7MWe/4Kkh5VtU8UO5bI81kuXecE9ncgKJen95P1lnT/FZdXNNpQwGvn+IeC0ZsGgTJ0027vjl9T9IDRHql9/URNvm+rU+7u52P1USNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhJem19N; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so2188888f8f.1;
        Fri, 20 Jun 2025 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750443087; x=1751047887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mEzXZ/YIhixe6E1kyZ5GIWXcl4av2h83GgvTF7RG6c=;
        b=fhJem19Nxd5HtTVDbiWg7qT8ulK/k0VLXouM/SZffxvSjhf96aO7ROeG/XH/6vDLnX
         SeICoFd4PtLYMZW0k4r2X0adfBPYFDvgeH1R8EQAMQ9rtdHStgFEz4ah/WIRjp5c5zGj
         aSPECJB1/jnm+Lo72u63YDnHXm4XRMeSDQ8Th4FmoTmXsyJFzigsb7jYlV2/fVf34elI
         EeLkmBYEBvNXDu0J/Mj4T8wcOxohINFWNw84rtCzC+KK4RH49k7TFBSu0LrCzFEDouaQ
         cB9lupTCg3r9Iw++f3QjYqTpUF7SAV5V0Qfp3GRsfMDNzC8pmiJ71xrl+OThVaWXG4/5
         JuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750443087; x=1751047887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mEzXZ/YIhixe6E1kyZ5GIWXcl4av2h83GgvTF7RG6c=;
        b=IxP4lGphzozaKG0sMBP1+15yOWSty9OYCT6hG/kzblsV68t1xelzPZU+YExbJWmnpG
         iCxA2I4s9BgDs+gG84qZ8bmiskNTompCzEDhWeJhMaQYZUif6jyQgOFoqh3e+NPxMEKT
         GLWILgFrb8tj/qSE0n0lD/pCiYshCGW+5NunHLesAwduKa4Tz83Mp5go/rMWtGt1KIhk
         f2Btis4hpHGw7e7xDvt8nx7+bMmFqzUKz42POJ7TTnCII3ZV4roLB7nTmif1W8oZ8d25
         yTOeJF1EKUoHeRtmcY2+WjMUQL0hGL43zwtiQHSe+yeOHZ/IZHMoRWK+HlnBG0fskZMK
         EaSA==
X-Forwarded-Encrypted: i=1; AJvYcCUbVelZf8AQI0YaRAsb20HT5wR9mG9In4yEzZMLQxXmdGwZFB7ZhDZATPCMU2j6Y++MJTlmag8/+gv8G9zP@vger.kernel.org, AJvYcCVOuKwyAwvluHj66MqTgZsjb4m//kuz3aBX6FnPWrYnlUR7zLsOBdWrnn+10D8QFeG573Xes9p5r5/hpSd1cU1IwkXGJvbR@vger.kernel.org, AJvYcCXEAi9NoLGr0bEFuIS0vlYHuCckHcT/6P46tdx0OtQk7Vu9WeVdA2G6AXOqGU8x7pVBlQu97rUlGyeY+dPK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4bf1LH+J7pbPHRAlvT9yEq6EDJ9gwHkQv0YocLAE9arkccsU
	Tvdfjfi2nxcPRHkPH9nlcK43jJaRhcWIjLY0V8OMqCzRK6DInSwF+qgOYce3tkYKtJG6ANdXDaK
	5c5ab3KaO2TY73ldX9CMaA6odeMWBwmA=
X-Gm-Gg: ASbGncuEdZu2bDMoPQzHH3PQJkpE+AoZmRnSGRA8cglG8RsD5js3FtQuRXgCjRFxWmx
	TEOJilV5i9HIGbsGlwUn3MR2Z0JXgkiUig7s4CrqlzwiQ8I63UQFGlDYO8KQp1K/SYE7vAkczEz
	e4azj8QX+hp2zTo0nb6Th3FrWZR0NnwDWC7+TfZ16HbF0lqCCwxVo2wwUmEmD9UQTJYQpsMO4O
X-Google-Smtp-Source: AGHT+IGfJOYs+TU8Pm+1eKpur6OPfhxYVjv6rAi7gkrEUuJaY+iWia/CHhyGwOziyeDcYZ+upUUxt3w9mKnp3ZXK7uY=
X-Received: by 2002:a05:6000:2011:b0:3a0:b565:a2cb with SMTP id
 ffacd0b85a97d-3a6d277a9bcmr3464061f8f.1.1750443086458; Fri, 20 Jun 2025
 11:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619220114.3956120-1-song@kernel.org> <20250619220114.3956120-5-song@kernel.org>
In-Reply-To: <20250619220114.3956120-5-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Jun 2025 11:11:15 -0700
X-Gm-Features: Ac12FXyshEwARoZFYJF1zB3nJckCcTMlv6mMIXAMOjn59QA2CaNEhkcL1gCUHnA
Message-ID: <CAADnVQKKQ8G91EudWVpw5TZ6zg3DTaKx9nVBUj1EdLu=7K+ByQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] selftests/bpf: Add tests for bpf_cgroup_read_xattr
To: Song Liu <song@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 3:02=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> +       bpf_dynptr_from_mem(xattr_value, sizeof(xattr_value), 0, &value_p=
tr);

https://github.com/kernel-patches/bpf/actions/runs/15767046528/job/44445539=
248

progs/cgroup_read_xattr.c:19:9: error: =E2=80=98bpf_dynptr_from_mem=E2=80=
=99 is static
but used in inline function =E2=80=98read_xattr=E2=80=99 which is not stati=
c [-Werror]
19 | bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
| ^~~~~~~~~~~~~~~~~~~


Jose,

Could you please help us understand this gcc-bpf error ?
What does it mean?

