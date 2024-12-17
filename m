Return-Path: <linux-fsdevel+bounces-37676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A839F5A43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 00:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304ED1894EF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1662A1FA159;
	Tue, 17 Dec 2024 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DqX3yBaX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F7C1F12FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734477412; cv=none; b=lcHfeuNP38obFVe2eOS7HwKtkoKONxDsjLo5/ejz2J1AxV6QRdBv5hCbi1VuE15UIacLgYXd3CWH/gvmmO6JlwS046fApA93ctc6Gzwqmeq83eAGE/Am0UsQU7s998kIYKdJ5NrpOR2uNj5L4fZpkjF1vPrsmsztuJ8Ng3LzyDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734477412; c=relaxed/simple;
	bh=T5IUDsHdqezYhzvwKlYtXQeoWaqVsdrSmr02IZWPqb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJB4pLpr4OTCEn3h2hk+XBNka/M0RGH1SQZ4xXN8Dd/xPR/0enq7BPnKI+jU167aKApCeeeGx+3NvaGEJIAH+gdaszjI0NUo6OO+S/SKsc1l5TFA+KfDZPo7MXlQuCjWjxoK0r0FJE36cW62TeUd6h9VgncwrHGXtQ4Nf4HIi70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DqX3yBaX; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ef9b8b4f13so48948477b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734477409; x=1735082209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZpZZca6m8n2NS8VtZHu44VsFFmS7EyCvl9umOy8ljM=;
        b=DqX3yBaXG2US0bZqNn3/CHTxIMM0RSPYjArrxUvKf3jWTtIl/B2zRAG9bXpGXHNgn6
         zYtXMQGmYwNsVclrAZusI15chw4YldIwuemVt/Zxm3i67KH+qk7zOXFif7YBrE68M9/Y
         v20bvQlrFpDUV8YzdkLqrQ76BtRHVvlknLzIzg2wFC2RCcLO9Ajm43VHJCH4sKLFiD38
         gBE9T0MgchD00Mh0PfPThETC4/uqeyQUFhp3Is/w1LG3XQ7p6mFRVEpl8+l/TeKCD5Wg
         F6IKXWTQMjad49FaJbqYso5c8ciMp1BNhuvfE4MFUEkwpOlogH24Kds4Vqwm6Z4GyNZ/
         PfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734477409; x=1735082209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZpZZca6m8n2NS8VtZHu44VsFFmS7EyCvl9umOy8ljM=;
        b=Ix80YsIDwvZjxG5nx336gmIBsx4o+2a7ajtoON/Rq89isWEUAOiAazeR2A57rnaw1A
         dTPU0ZpCNKAYg9Y5CTg7YkKtr9TCLxRa0Yt/hm6JrkdIGFELDOv/9UxTBpix+MKndrAe
         BAcMt3CxV5ba9DAYovW9GKNkTaXVdw1NMQBTf4mseBHl7EjszOjQdh4WV4209CzEjH/p
         Bbc86dy/xMqPLzkpEnMVUnj9avj/UWQEmo+Qjg3t9mwoZFmEzjOWgqL/dURew6L1i6ne
         lkWDqViYlflTDK5+v64wXyl15TxbDF7cOEzKXUuBvNMzbTiez2MP3L+07hoGPOlyMTjX
         ENUg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ndDCnJep4Dfny9Lm5l12EEX/akz4ubPwcAggq31bYOkM6RU2S+8hOHkCU9n9YSA5pkrCWBPz2acWKyQP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdx/v4jeFW30ad0C8Z/EXFOuv+UluB/DjJ8HtrjHO3VFVJPFYV
	5cVNZGPZLfOmFfdYgkWXmO3oOF8A0f0czGS4Z61t59E2+d7pGub4lsWF/sVii26q34BAbV78a3t
	FH6Q2TBBDIJTgZ/wzgoriaBfEM3s+UtTX2tQo
X-Gm-Gg: ASbGncvUDjHXHxHdTRefqrT3rzDFZrJ8WyJgcU0NiNLOeiqyaKlabEMKSadv8bgcsCh
	bcccxXgHvGzfH0Vt8PNdeIjlvriZGUk630e1v
X-Google-Smtp-Source: AGHT+IFRPfpjDzzrONQwYyV3M5Sx81AcjXWpz+0lyTANLevp6Y2aXdkLr52G7Eh6M0IhlXMXIR8uiYUYIAXFr0z6OAE=
X-Received: by 2002:a05:690c:25c2:b0:6ee:6e71:e6d6 with SMTP id
 00721157ae682-6f3d0e313f0mr5363727b3.23.1734477409076; Tue, 17 Dec 2024
 15:16:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217202525.1802109-1-song@kernel.org> <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
 <CAHC9VhTAJQJ1zh0EZY6aj2Pv=eMWJgTHm20sh_j9Z4NkX_ga=g@mail.gmail.com>
 <8FCA52F6-F9AB-473F-AC9E-73D2F74AA02E@fb.com> <B1D93B7E-7595-4B84-BC41-298067EAC8DC@fb.com>
In-Reply-To: <B1D93B7E-7595-4B84-BC41-298067EAC8DC@fb.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Dec 2024 18:16:38 -0500
Message-ID: <CAHC9VhRWhbFbeM0aNhatFTxZ+q0qKVKgPGUUKq4GuZMOzR2aJw@mail.gmail.com>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
To: Song Liu <songliubraving@meta.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Song Liu <song@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"roberto.sassu@huawei.com" <roberto.sassu@huawei.com>, 
	"dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>, 
	"eric.snowberg@oracle.com" <eric.snowberg@oracle.com>, "jmorris@namei.org" <jmorris@namei.org>, 
	"serge@hallyn.com" <serge@hallyn.com>, Kernel Team <kernel-team@meta.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 5:47=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
> If we use lsm=3D to control ima and evm, we will need the following
> changes in ordered_lsm_parse(). We still need supporting logic
> in ima and evm side, so that ima and evm are only initialized
> when they are in lsm=3D.
>
> Does this sound the right way forward?

Have you tested it?  What happens?  There is value in going through
the testing process, especially if you haven't played much with the
LSM code.

I'd also want to see a comment line in both places explaining why it
is necessary to mark the LSM as enabled prior to actually adding it to
@ordered_lsms.  Something along the lines of only parsing the
parameter once should be sufficient.

> diff --git i/security/security.c w/security/security.c
> index 09664e09fec9..00271be3b0c1 100644
> --- i/security/security.c
> +++ w/security/security.c
> @@ -365,6 +365,9 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>                         if (strcmp(lsm->name, name) =3D=3D 0) {
>                                 if (lsm->order =3D=3D LSM_ORDER_MUTABLE)
>                                         append_ordered_lsm(lsm, origin);
> +                               else if (lsm->order =3D=3D LSM_ORDER_LAST=
)
> +                                       set_enabled(lsm, true);
> +
>                                 found =3D true;
>                         }
>                 }
> @@ -386,7 +389,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>
>         /* LSM_ORDER_LAST is always last. */
>         for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -               if (lsm->order =3D=3D LSM_ORDER_LAST)
> +               if (lsm->order =3D=3D LSM_ORDER_LAST && is_enabled(lsm))
>                         append_ordered_lsm(lsm, "   last");
>         }

--=20
paul-moore.com

