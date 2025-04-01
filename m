Return-Path: <linux-fsdevel+bounces-45441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7EFA77ABF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0437189061F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F033202F9C;
	Tue,  1 Apr 2025 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPf5KW8p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32920103A;
	Tue,  1 Apr 2025 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510093; cv=none; b=IwqvilZ+8SdR2ktua/vtKAnWTbC5dtMNKA1+u1NGXhJ5QrmnYKDRsCyy4ZD0WUPoYLfwJSiIvTiZJsoqmoe6D8F1wuL2s2N56Ve1cD4baKqGHuRoJoyH37Z0lCpEqhMVqjJepwzebhFbEum97gso3ImoByTliP8u+i0B1Biqiqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510093; c=relaxed/simple;
	bh=eFP+fsfelC51X1xrxP0bq6+M0QIiTmftqFVcJ4OJXZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZjk7akdzCAJ8HjY+9w4eODYI/2pf3XtTaUz+weq69wzOX2KHDhXHLhF44DW3x9mNCS4wsCyZs4NlDqzRSd0rzxB0Eek8GX2ClR3HUL7h3wPyssO3KrsVvV53x8MbFo7kkhwVrnypqTCPyfkE4EBHUXYt4YW/KXwrNYXrevPvF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPf5KW8p; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so8301821a12.3;
        Tue, 01 Apr 2025 05:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743510090; x=1744114890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFP+fsfelC51X1xrxP0bq6+M0QIiTmftqFVcJ4OJXZ0=;
        b=PPf5KW8pJ8Mp6ZCbzC8bI/IfBnjfCVn13V/JAV0RWIY64ZyCo1mEa5lUN8C4byveJf
         VUBi/XXr7IHN7BJvhf1Hl3ZFzDqG/zT76TNsCzDvPe7X0KfBOFMwQ1UsrkUQVOFNwE3c
         Yemm2DMo+v6xeiggM59v4Z9qHAWsr1brFAisTECqnQ4lknR4Ywbc+0QT3BZXVrkTBwtH
         5uz1ZepZM+69ic1AVLidhse0VoJa0HpNG69IxXh1ux2uPU+kbCz5trXUwe06G2HvCnTZ
         KILo89immOPFHXUWWnzapUN4P9sx+EiD0bUTRxy2pz93O5BnH6+m0BK2BMSAq9INSp5U
         lS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743510090; x=1744114890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFP+fsfelC51X1xrxP0bq6+M0QIiTmftqFVcJ4OJXZ0=;
        b=gjm8KFxt6iRqcN1y59UPqZ9iEQj68CfIaMVunB7RC4YGFK0EqeIa69wlwaiuezRnFJ
         lLdW2dyT+N2j4uuP+n/XEEvJDrtEXCIoRhn2Y9xAkoXzG4Im4iJIpwsEtO+5aqana9Vi
         AVTXctlLfxxA5cXmIBCE7EQmcbC/x9G1oKoBHWLSJzYfpJoA+JXaMcN/u4ZR4gt6FwXr
         Vjw8hZBFDaWzbOmTu+nOHAPPf5Q0vh1wVj0yBwrl+mquTaQULVX9zwYm/opvAPDFgTaC
         l2v/R2KxzPZjD36/LKA0ek5VPMEjp4tdlHFhG6iGpT9O4aKpXrdxcec0q0ZKfSgtjzrB
         yCpA==
X-Forwarded-Encrypted: i=1; AJvYcCW2tiu7GDh+xzTAeK4pLlBFDAaZrbQG/SubZBU5aou+efCRLeR2PXgqk4zIawC1MFn0KpgLKQmW375MXLk2@vger.kernel.org, AJvYcCXX5wmqm2AZ3pxd/SlK8R8zrDVIXitxAyWQ39Fil9Coc2BDFXzYbwuG+WLWFphi81W7+Tw38EFpu9ORXKJP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3O+0pB+USxWrMDCY3Sh+wYw5RikTQeHEEtzZjYNZhD8csvsiE
	BoumaHEdvL9FTdPmp6Lpj++6wXC//qFbMi6BR45mV6UznJEBvOg2ddv/w/brJEXdrQ2muoNXkvh
	QgMXdu1TlhRQQr5F/OlPsErAA1cY=
X-Gm-Gg: ASbGncvmNCfLqIQmcHSmkiLGZVTD2h8G06tJDDmZnsFogH9tzFxsPs5jfLRh9JYBbLJ
	qLplcaaNllzgzy+dDQN0rpCQwKDEOG9gxVisv6WLl7SJuc/cuUGg0tBqIzBvZn7KkZmD1iPjAHS
	BqKSMI3Ug8Nl/JiUXJm9+owt9s
X-Google-Smtp-Source: AGHT+IHgssLUWFJ9KtZvYnVpQINEIFt6wQFC5wV8vrVZiGfEZI7KAuEWO+6K5fRQuRgPH7rnnA+HTSvTgtwasbSFaxE=
X-Received: by 2002:a05:6402:5193:b0:5ed:1d7d:f326 with SMTP id
 4fb4d7f45d1cf-5edfceaccdamr11476439a12.10.1743510090049; Tue, 01 Apr 2025
 05:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACVxJT_qZP-AKUzf5sXfp2h+qJ+L0BZit3pgi-aGCuXk4Kmzuw@mail.gmail.com>
 <CAGudoHFThX1-VQ9vte4YwtjA6aCNQ0Hc5X-=yxyjdzBjD6Kr-w@mail.gmail.com>
In-Reply-To: <CAGudoHFThX1-VQ9vte4YwtjA6aCNQ0Hc5X-=yxyjdzBjD6Kr-w@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 1 Apr 2025 14:21:17 +0200
X-Gm-Features: AQ5f1JrI2hd3InDqErfo4r4AFjYGpeTFm26DoCuCjRxIOYqu5VESG5nT43S9ous
Message-ID: <CAGudoHEgnvyS=ZNcVHoBr69OAF_ZUCqxx3HLqNYyk2fyFq6F3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc: add a helper for marking files as permanent by
 external consumers
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linux Kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 2:17=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Tue, Apr 1, 2025 at 1:14=E2=80=AFPM Alexey Dobriyan <adobriyan@gmail.c=
om> wrote:
> >
> > > +void proc_make_permanent(struct proc_dir_entry *de)
> > > +{
> > > + pde_make_permanent(de);
> > > +}
> > > +EXPORT_SYMBOL(proc_make_permanent);
> >
> > no, no, no, no
> >
> > this is wrong!
> >
> > marking should be done in the context of a module!
> >
> > the reason it is not exported is because the aren't safeguards against
> > module misuse
> >
> > the flag is supposed to be used in case where
> > a) PDE itself is never removed and,
> > b) all the code supporting is never removed,
> > so that locking can be skipped
> >
> > this it fine to mark /proc/filesystems because kernel controls it
> >
> > this is fine to mark /proc/aaa if all module does is to write some
> > info to it and deletes it during rmmod
> >
> > but it is not fine to mark /proc/aaa/bbb if "bbb" is created/deleted
> > while module is running,
> > locking _must_ be done in this case
>
> Well I'm unhappy to begin with

unhappy with the API :)

> but did not want to do anything
> churn-inducing. The above looks like a minimal solution to me.
>
> The pde_ marking things are in an internal header and I did not want
> to move them around.
>
> If anything I'm surprised there is no mechanism to get this done (I
> assumed there would be a passable flags argument, but got nothing).
>
> What I need here is that /proc/filesystems thing sorted out, as in this c=
all:
> > proc_create_single("filesystems", 0, NULL, filesystems_proc_show);
>
> Would you be ok with adding proc_create_single_permanent() which hides
> the logic and is not exported to modules?
>

This still does not add a 'flags' argument, but given limited number
of consumers perhaps it is fine?

I'm not going to push for any specific solution as long as
/proc/filesystems gets to shed the overhead.

If you don't like the idea of proc_create_single_permanent(), then
perhaps it would be least back-and-forth inducing if you did whatever
change which you think is fine and then I just use it? There is
absolutely no rush.
--=20
Mateusz Guzik <mjguzik gmail.com>

