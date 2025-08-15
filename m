Return-Path: <linux-fsdevel+bounces-58008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CAEB280DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 15:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA2BB6323A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD82301490;
	Fri, 15 Aug 2025 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV6jLrlp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1321459EA;
	Fri, 15 Aug 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265825; cv=none; b=ajAHWjM2l3iX/SytkAa4QK8npE7tkGpCFAPA4sBI3KtCQqcMIPr+FSYBxR3BOLWK14ub1YDCcpoFB9m+ZHYocN4uoxOT9IHBK49tr2dEGUdRM9dLvnHjeLpvVIJmHWLslkV/bCNcHrCIRAuL0I8mFM11RWitkeVWPTBrtArUltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265825; c=relaxed/simple;
	bh=ruLLqcVPj5eB5UaPm421/6sfiuuYnTeQz9n3ChST3qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWbFFq61khV8klY9p/H+mmVe3mwPSEiA1SBnzPB7+2kIwLcAisA6Ofy3RaoJujcf+bSJL7Wkjv/8pSaLtt07ZOS6rOGytFtACzn+oJ2B0aRu6iZOS47mlzUsuKGUXE+pY4H5HhSNpDYiCUAIM0OZkydXvADJHixSE4dP6b6xMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV6jLrlp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b72b7caso2333750a12.2;
        Fri, 15 Aug 2025 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755265822; x=1755870622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVxKJKxkIR7rRYEMo6j3At6+uo+6R8lvs8Dlyuu9OBg=;
        b=TV6jLrlpKGnqQwn5cFe79Jp+EMuC3rYmYrV0Bcs2Pd7FeKOdNjzOZA8G12BVeIgxaP
         42K042lEFnZq5XhoFFROclSpHmE0X+1R6yvbXazR9OFn7PylOjsjRTGJFR8yC6HDXu+u
         ephl1Yj/5BovjvBcNfV7yBBr8wnbTWRe3pM7S1ujwLpl2NDWLYfQZ/UfCP8+IsjChCsf
         SvYNO1XVBa+gAYapGHw5YRKcETG3gjvThU0UB4zoDxYFMnwvbzZK+8QN6qSgrCi2sRu5
         msA86Oik4suCAYHZrZ6FBf3TwyI8Ool+CRO+Tx2bYamk7/kclxl9IssFnexYF4MlsBX3
         b4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755265822; x=1755870622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVxKJKxkIR7rRYEMo6j3At6+uo+6R8lvs8Dlyuu9OBg=;
        b=HGXK4DZwWb9cq0llwe238MQ8uKH3Q11xVXZNm22vLa+kA5lPs2LGDdH7jD8yfH13dX
         lRzpV03UHHvt+l4QlI/ug5c30oVfRCCZ3PfCgPbeXcU7KaStbgwXwxEFjnWamiUC8JUz
         dGf8o2Hv0OuJVEmDq98hEsBziiIcRruX9a445tuOEl5VRjjovh+Sf6kiiaDOuz4d0MFe
         bNa+dzXk3Ij7bVBR9KbqI4bN6yuIRXeKZ/KjWMzyOgSLXBpd8pKvhYIbgAGRSMpgaAwp
         0/g4ELUH5b+g3sYHWSv1eoysNUjVVb7XwrL1r389LvW4EaZm8S5g4A0uJlqR103dV18Y
         rEkg==
X-Forwarded-Encrypted: i=1; AJvYcCU1HyfU2u1q32sRbZkxwpHvRXaJxy1Mwb0M/N5/xVCsVGhM1HwpV9G4LW/R7LrTmvbh0SM09J7CVGz5o/Aw@vger.kernel.org, AJvYcCWGRnCRGYYkS4rDRyletRawyE5VZ4MPzUxcyL7YP+127IrQVaLWTguo9VdwRelv4nVQyrmlBF2dJBQViiiv@vger.kernel.org, AJvYcCWJQ0wHpzzvn8seQNa3frU+99HNiEqnYCYbc9UuWUl2wb8bqLRrVAlrC9d5e2SjGJlig9FGWqcimFjNXkWgYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRjcf9Qnxb3JozvAYsdYsizqKUPLinwIXo+ROEgcadDQACZyr
	PrfE5GYpOfgLt/au7WcflT+a36PV4Odj6zHFK9RhL/gDvfGo6OngX3h+FFNckn3CM3dW11UXbpY
	mp68a/GgKfxzu3QJbJGdWEAd5kkumnsM=
X-Gm-Gg: ASbGnctWvMYyVc5QRW/TuPUE+w1u4o2BchxIzpsp+O7KFGfE46ELX/icU6arIbolZAO
	6/uaIrIuW/xvRNZig0FsU0UyrxV5a+3yzXtIjFDdvYNyThYKb6QagvMrNv3YWpMngrtIOnbuE9Z
	kb5dgTCco/iQjiyKHoTXjaDIn1KbdR4hpSaTZqi7Ovpih+req7dF8n/QXASsvuPQ/W8z1sUViAH
	czCnqw=
X-Google-Smtp-Source: AGHT+IH7RDqwp3AkwsGLY/rD7QWo3+30dh6mkwhKaJOOBQp7D5mfywDSZxacbyG96W5YBC4ATcXdwnm5eCVkiAWSt4o=
X-Received: by 2002:a05:6402:13d3:b0:618:4a41:80b2 with SMTP id
 4fb4d7f45d1cf-618b0755226mr1718508a12.33.1755265821419; Fri, 15 Aug 2025
 06:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
 <cffb248a-87ce-434e-bd64-2c8112872a18@igalia.com> <CAOQ4uxiVFubhiC9Ftwt3kG=RoGSK7rBpPv5Z0GdZfk17dBO6YQ@mail.gmail.com>
 <e2238a17-3d0a-4c30-bc81-65c8c4da98e6@igalia.com>
In-Reply-To: <e2238a17-3d0a-4c30-bc81-65c8c4da98e6@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Aug 2025 15:50:09 +0200
X-Gm-Features: Ac12FXyMWCloJWIBnMtqLXlovfG1p6TA8JMvh2LlyfcPyxqjUIpjrP0xrZ2Q6_w
Message-ID: <CAOQ4uxgfKcey301gZRBHf=2YfWmNg5zkj7Bh+DwVwpztMR1uOg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] ovl: Enable support for casefold layers
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com, Gabriel Krisman Bertazi <krisman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 3:34=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Hi Amir,
>
> On 8/14/25 21:06, Amir Goldstein wrote:
> > On Thu, Aug 14, 2025 at 7:30=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid=
@igalia.com> wrote:
> >> Em 14/08/2025 14:22, Andr=C3=A9 Almeida escreveu:
> >>> Hi all,
> >>>
> >>> We would like to support the usage of casefold layers with overlayfs =
to
> >>> be used with container tools. This use case requires a simple setup,
> >>> where every layer will have the same encoding setting (i.e. Unicode
> >>> version and flags), using one upper and one lower layer.
> >>>
> >> Amir,
> >>
> >> I tried to run your xfstest for casefolded ovl[1] but I can see that i=
t
> >> still requires some work. I tried to fix some of the TODO's but I didn=
't
> >> managed to mkfs the base fs with casefold enabled...
> > When you write mkfs the base fs, I suspect that you are running
> > check -overlay or something.
> >
> > This is not how this test should be run.
> > It should run as a normal test on ext4 or any other fs  that supports c=
asefold.
> >
> > When you run check -g casefold, the generic test generic/556 will
> > be run if the test fs supports casefold (e.g. ext4).
> >
> > The new added test belongs to the same group and should run
> > if you run check -g casefold if the test fs supports casefold (e.g. ext=
4).
> >
> I see, I used `check -overlay` indeed, thanks!
>

Yeh that's a bit confusing I'll admit.
It's an overlayfs test that "does not run on overlayfs"
but requires extra overlayfs:

_exclude_fs overlay
_require_extra_fs overlay

Because it does the overlayfs mount itself.
That's the easiest way to test features (e.g. casefold) in basefs

You should also run check -overlay -g overlay/quick,
but that's only to verify your patches did not regress any
non-casefolded test.


> >> but we might as
> >> well discuss this in a dedicated xfstest email thread if you want to
> >> send a RFC for the test.
> >>
> >> [1]
> >> https://github.com/amir73il/xfstests/commit/03b3facf60e14cab9fc563ad54=
893563b4cb18e4
> >>
> >>
> > Can you point me to a branch with your ovl patches, so I can pull it
> > for testing?
>
> You can find my branch here, based on top of vfs.all:
> https://gitlab.freedesktop.org/andrealmeid/linux/-/commits/ovl_casefold
>
> I fixed the following minor issues:
>
> - 4/9: dropped the `kfree(cf_name);` - 6/9: fixed kernel robot warning
> `unused variable 'ofs'` - 8/9: change pr_warn_ratelimited() string
>

Cool. Let me know when the test is passing (regardless of TODOs).
I'll try to test it next week.

Thanks,
Amir.

