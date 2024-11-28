Return-Path: <linux-fsdevel+bounces-36103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A15A9DBB9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 18:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA5E281F1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882843232;
	Thu, 28 Nov 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlMpyYPH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7BE9463
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732813230; cv=none; b=m8bXUZQ84ZpasrotuFvorpX4qlxhZfmpn2JY80p9VW63EFsdYCUkMSx9kIzbUlJiomCTUVBWcLUky2BWD1v6+Ol+ghXsO8lCUvN+6mAJRjVkMyBE5mX+avmkn1awwYBCY8NcZEF7fHNugpjigaUFme5vJaUEshoBvY7N/vssQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732813230; c=relaxed/simple;
	bh=2sfuixJiem7Nt9P8BoIawa5Vhj9jJYgL+C8C1G8q1iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7hfHMFwg07UYGLxgP5owvFcMkeIlFXokEvqPJ/y5y0X8jVR6Xhmxk03OaG2SCUTIbizkAncpMmzU7Sg2rA7oIOUt08GYcF4erTcvbjPyjJ0/PdkSnzWAIxSRBP28WKL5sOa5diXq5zT++6cAI397WviBCMZtp+UxWPpA8I30G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlMpyYPH; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffc3f2b3a9so15722631fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 09:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732813226; x=1733418026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2+T1mC63vMrBkQHGWgNlF4mCET9O1bgo7pocJIsA78=;
        b=PlMpyYPHepKQcnoWjHyOBy7bC2skPqIDpZSNDrcIrYqals62kMTJkDxFzx1oGmTVPC
         uYptTRLj+uIl+xYuL68Wc+nlYyhVivXU2EJ+M+0xzCXCgadNX4nD8xOoMtw8WbdUG8ww
         o990Cg/dbBR5wgQVtmiPocPBuWjrhFni6xBRoXHGuwe9supO5rATxWNmhL58LQIouBUC
         RISEozwiqSOI2p7rfp+aNTLum0gdevlMxjtpE6WCpd3grPLZEEMUoe6x0+8J3LvmSyE5
         QOKwiIlHS+TboUE4Lj2AOngr2TXTIPGFYzbWqTkgCYRHZKOdPTnt14vOLlYwQJ5e4CtF
         gRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732813226; x=1733418026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2+T1mC63vMrBkQHGWgNlF4mCET9O1bgo7pocJIsA78=;
        b=kmGgLQmQRzd6SMGewVmD0yFVssWyVY83cw11yjIXvdTaiDz/f0YuT1lygaxAtKZ44H
         5lgpj3h2qnrKhea5+An1KTH4ffi+8POzvzG2rBHV1gBUUgl2rh/hkFZp7I4ire4vKjIi
         O6QKFBHSql0no+KvxTsK1rIh+INYN1uzBMe0gumKRXnMhKyofXmePA/+vPu+K4sAIZ8i
         ts571A/TT5w0K/ECOupBuwGMKuBuTppuq1H2GPafENUI7yChvnzOq3niwyVCh0ePmopp
         AQZM5WTevEiN3lRZdKnp+UCDYHxKLSbUt2NHs9I/nERESsZw/VeZkHmk33ZfBvPSw2/z
         Fkuw==
X-Forwarded-Encrypted: i=1; AJvYcCXT7gpBXnu3fJyZM2QA4C4Q51t+CRz+3gUKrvF8Kumg8ZZ3D4mlP4WlTpzNsHAeQF8X/k6X3ItLVN7NOLe7@vger.kernel.org
X-Gm-Message-State: AOJu0YzYtaPPzH6PkV3FjCn2idb9peHMkX73rYLJ61AwGy0Ee7FOdKwc
	rtgho32gxlmMDnvAEs8BRlw3K3tVM/cZQG0dx1AIOGAT/NvGjN4+G1UrdbzWGRFNYbllE4PIxK8
	hVpTnum1t+cIWYaDkMt8LVyXdICE=
X-Gm-Gg: ASbGncv8DqUKZ82bYUa+JegBN0NIEJFxa0r9esDc/77O7BmVlZnB6AIbHLQdRrnyn6e
	d1n7VhbxBKr+jw94y82XWGkrjbCVmqLc=
X-Google-Smtp-Source: AGHT+IFwaVMjc5jg4j167Xt6L4hi1BbvVXk97IjbXjLXaJvsSIMyYLTF0zVseHT0+AJSXsFAWxsuB8R+7JGVp+4ayBA=
X-Received: by 2002:a2e:a987:0:b0:2ff:a3c0:a87a with SMTP id
 38308e7fff4ca-2ffd60a95fcmr70640511fa.28.1732813225982; Thu, 28 Nov 2024
 09:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128142532.465176-1-amir73il@gmail.com> <wqjr5f4oic4cljs2j53vogzwgz2myk456xynocvnkcpvrlpzaq@clrc4e6qg3ad>
 <CAOQ4uxiqbSFGBoCzg44t4DM=uvJ3zbev_wbSot4i5C8jQW_t7Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxiqbSFGBoCzg44t4DM=uvJ3zbev_wbSot4i5C8jQW_t7Q@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 28 Nov 2024 18:00:14 +0100
Message-ID: <CAGudoHEgjTq6RTmcenUcZUaRuzkAm8WiCCbakqbUMa5AeT84fg@mail.gmail.com>
Subject: Re: [PATCH] fs: don't block write during exec on pre-content watched files
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 5:57=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Nov 28, 2024 at 3:34=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> >
> > On Thu, Nov 28, 2024 at 03:25:32PM +0100, Amir Goldstein wrote:
> > > Commit 2a010c412853 ("fs: don't block i_writecount during exec") remo=
ved
> > > the legacy behavior of getting ETXTBSY on attempt to open and executa=
ble
> > > file for write while it is being executed.
> > >
> > > This commit was reverted because an application that depends on this
> > > legacy behavior was broken by the change.
> > >
> > > We need to allow HSM writing into executable files while executed to
> > > fill their content on-the-fly.
> > >
> > > To that end, disable the ETXTBSY legacy behavior for files that are
> > > watched by pre-content events.
> > >
> > > This change is not expected to cause regressions with existing system=
s
> > > which do not have any pre-content event listeners.
> > >
> > > +
> > > +/*
> > > + * Do not prevent write to executable file when watched by pre-conte=
nt events.
> > > + */
> > > +static inline int exe_file_deny_write_access(struct file *exe_file)
> > > +{
> > > +     if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
> > > +             return 0;
> > > +     return deny_write_access(exe_file);
> > > +}
> > > +static inline void exe_file_allow_write_access(struct file *exe_file=
)
> > > +{
> > > +     if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
> > > +             return;
> > > +     allow_write_access(exe_file);
> > > +}
> > > +
> >
> > so this depends on FMODE_FSNOTIFY_HSM showing up on the file before any
> > of the above calls and staying there for its lifetime -- does that hold=
?
>
> Yes!
>

ok

In this case the new routines should come with a comment denoting it,
otherwise the code looks incredibly suspicious.

> >
> > I think it would be less error prone down the road to maintain the
> > counters, except not return the error if HSM is on.
>
> Cannot.
> The "deny write counter" and "writers counter" are implemented on the
> same counter, so open cannot get_write_access() if we maintain the
> negative deny counters from exec.
>

I'm aware, in the above suggestion they would have to be split. Not
great by any means but would beat the counter suddenly getting
modified if the above did not hold.

--=20
Mateusz Guzik <mjguzik gmail.com>

