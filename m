Return-Path: <linux-fsdevel+bounces-24174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211B893AB7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 05:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91834B230B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 03:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44571C6A7;
	Wed, 24 Jul 2024 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqxBF3B3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9824A00;
	Wed, 24 Jul 2024 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721790249; cv=none; b=hRvWBk14n9JahaXXn/zkQMnTIbPGyOtKJ+EWU3ag4Orzmr6PUbyKgT4Oc0oRCjwrUE9JcgLHpyf/QAq2/KQD9KvEy1odtDczDqdA0oGM/Q8jLGB76iFVfSkArhQUJuK94OSHxOs0XOxsjzSRbdR8nrvaR8EnDcb/ClP3cMZOUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721790249; c=relaxed/simple;
	bh=ir2p808DDlbmnPfYSAHgOiYn2a/peBOuTuHTPOzlUs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYiyhBxX/Mrjkixd0Y3huvoLLsFuuuVO/PEKTs9z1RtyVZF5jlQsrYhqCT75cSeEqGxGg4sxgatSzi1zCATTJWUaO0wPJENtpwsZadSvhZvlROddkdHTTLvpWYo+ASf2OU2PEbKs0jAPRes2ux+0vV4TyiL014MqCiismcJq1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqxBF3B3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so29241931fa.1;
        Tue, 23 Jul 2024 20:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721790245; x=1722395045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WP6cBs+BulTekqwtkBUSULVpWzfMdW1wh1fz5BAJN0I=;
        b=hqxBF3B3DBtxKmo+gpK9ETKoZbgyTuu64ePtbBfB/KmWPZd3uNcC6J+8IkzQELmNkk
         BO2/Rny6a9/Q10Xw/AnklmStXEywS0sVfC8QiSmA6OUmMlHgGF/tOF6LVGam1GQu/8vp
         e/vEScRXeVMtW2FLCekUZyWiBk3lzcRaO7RxxxonwssmKjO5h0bi0vNzMDTelljrt5Jw
         JGCf2jLI5nmLfa5+2kbg9Nt6sb+uhT6jVATXMjAsP73T8plSEfA5v7CFQEvoGIibuLo8
         EveAi39EPiZvNvHk+6y/86u6xEFKVVQSTFssY1LEzYBcTfhFGXLTDaKTFVIZahBwIZoW
         PwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721790245; x=1722395045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WP6cBs+BulTekqwtkBUSULVpWzfMdW1wh1fz5BAJN0I=;
        b=czNjd1GmWomCf1+JyxzefuHohEBimvSEYsqfybryYlJtrBSG6F49MnwZDRxbgWNKLh
         ByLJfVpZogd/kfvtiqhgk8/utawVJkKwtB+SGbV8qtvzUfTKhb0TJ8ujCB/jLSXw8JXz
         eJN+vwg8Q4RbQyRx41ubQkDFIHxZWpK3Pqd832M8ePm8YK9lTJwOx2Z17oXck4gGQLdn
         iMPXUjLNwcKnSTCSq2UKq37Wnu8Nbk+q+k/QcioJ01hx7AskuIOf31TebXk+yPnYewJk
         Z8fEiWwDRKgbTRQrwJ1UeLnCF+OdJDW41GF+Jhj5GjAFAxJDvuXEMXjireK4GQAIa/Fi
         9Pjw==
X-Forwarded-Encrypted: i=1; AJvYcCWUdp+IIZ+xUewSN+m/CSsHp8dRsERPUfyroRPBb11w+TEqjEii7kdKpIGJzWShCMJq2oMpjXsnV8HvfPWUikyRL4/NhpljJN8b1ZKBOda4OIgEi4GX5FhBZ36cIzpYN1CThtvJalLVtzJVtA==
X-Gm-Message-State: AOJu0YwMlX1I/2OzETXv/4sKEcV93fdcX7sDWWR46s78lhGGJ1QOik2U
	3zVAhOHzxqiAKGbLS8iRjlAYBsuT5/GHZuw4hEuCRYPfugUgXOd4MAJvn+Z3L3KP3ch2MknQrkt
	RXr95leMyfW/AziJZrAqjmBwFH2k=
X-Google-Smtp-Source: AGHT+IFUuJ+b2C5SjIAcLydtlJ+5QxZdTbyus1M3xiSkOWJuiih78IYx3YTAjQQSWXyd3UZ+t67885N3SxfsaBKaDvc=
X-Received: by 2002:a2e:7010:0:b0:2ee:52f4:266 with SMTP id
 38308e7fff4ca-2f02b6f9370mr13673201fa.3.1721790244880; Tue, 23 Jul 2024
 20:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723091154.52458-1-sunjunchao2870@gmail.com> <20240723150931.42f206f9cd86bc391b48c790@linux-foundation.org>
In-Reply-To: <20240723150931.42f206f9cd86bc391b48c790@linux-foundation.org>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Tue, 23 Jul 2024 23:03:53 -0400
Message-ID: <CAHB1NagijZv=M28x+QDF8aS7rVGaPsXdaLgJvRyLODPL0DTe0w@mail.gmail.com>
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, masahiroy@kernel.org, n.schier@avm.de, 
	ojeda@kernel.org, djwong@kernel.org, kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=882=
3=E6=97=A5=E5=91=A8=E4=BA=8C 18:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 23 Jul 2024 05:11:54 -0400 Julian Sun <sunjunchao2870@gmail.com> =
wrote:
>
> > Hi,
> >
> > Recently, I saw a patch[1] on the ext4 mailing list regarding
> > the correction of a macro definition error. Jan mentioned
> > that "The bug in the macro is a really nasty trap...".
> > Because existing compilers are unable to detect
> > unused parameters in macro definitions. This inspired me
> > to write a script to check for unused parameters in
> > macro definitions and to run it.
>
>
> > Seems a useful contribution thanks.  And a nice changelog!
Thanks for your review and kind words.
>
> >  scripts/macro_checker.py | 101 +++++++++++++++++++++++++++++++++++++++
>
>
> > Makes me wonder who will run this, and why.  Perhaps a few people will
> > run ls and wonder "hey, what's that".  But many people who might have
> > been interested in running this simply won't know about it.
Yeah. For example, I am not familiar with these current checking tools...
>
>
> > "make help | grep check" shows we have a few ad-hoc integrations but I
> > wonder if we would benefit from a top-level `make static-checks'
> > target?
I have another idea. I asked some of my friends,  they are familiar
with scripts/checkpatch.pl and usually use it to check patches before
submitting them. Therefore, can we integrate some checking tools like
includecheck and macro_checker into checkpatch? This way, when
contributors use this tool, it will automatically check the modified
source files. The benefit is that contributors can benefit from these
tools without knowing their existence, and over time, all source files
will be checked.


Best regards,
--=20
Julian Sun <sunjunchao2870@gmail.com>

