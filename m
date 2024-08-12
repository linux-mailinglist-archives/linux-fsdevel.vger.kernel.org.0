Return-Path: <linux-fsdevel+bounces-25691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF24994F145
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 17:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57411B22232
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905D117F4FE;
	Mon, 12 Aug 2024 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PH9uJ1aj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361115B0E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475219; cv=none; b=JM8PddGzBDumCTIvy1RhVSc2ik624w29dD++J72ZjS16JLBiqII8RPRmrc7kShpZ8FtFQCgh/hRkmOkrJW8vpKgYnQ9+tGzS5bZaNuMsov+WiMIQQIMR20Ka9kdFoGfQn72Q6kaQSt9otdq1m45F2IX8Z7JQeXDLsyDdRvUQdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475219; c=relaxed/simple;
	bh=/le9A2aEVKUmIV4UkSEJp/ETmS0AvR1tTz3Yj+RukI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZwPdA2echParu5NGwKVDkRRp8MosOUPP4XRXeI9SpssCqXO1usKMfHQLvpB/Z4MnsCBupaImu3TTMncTyWqWkyTI9ImVnGcQ3cfWATQdrm1WvxpjmJ/4HplwPTdtgQMDBbHVrJH7grXkzSP2FKgFmoh2wTgOzEeeBRrlV/a2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PH9uJ1aj; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so14655a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723475216; x=1724080016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/le9A2aEVKUmIV4UkSEJp/ETmS0AvR1tTz3Yj+RukI4=;
        b=PH9uJ1ajF+VwsbFmieHQ/jDrNVgDM9gz+/DwqwKIF639c7FJEroC/+cyv8n69v5Isl
         nXUvZJkMXhotNViuWUQOirS8pm8gCgFTYB1LhjzaD98BUiDA/5TZqcIa0l6gnVVkYsE0
         3wjH3PKctHMrh58LjomGY94dm4VhgSPE6Ks1f0xB2oj17ZlEgpGq53395gDutO15JB9B
         RmbjYBWtTvvPI7DvFZnzQGmyfawvk0JNUpRXluI6yWZHmckLUyvt06mxzxrJsCpvTriw
         qWHpsD+J81TuG7gAhzKsvLNCvYeEKwRggvxtPQEwwZpiilLZAwmndZ7aoyZNd0TRnKck
         dIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723475216; x=1724080016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/le9A2aEVKUmIV4UkSEJp/ETmS0AvR1tTz3Yj+RukI4=;
        b=RVnG9VKdfZhhpkZBgOf7KlM9BVnP+kDiyxQ8vR2AWjref9iZZ856Bb0Po66BcrZihL
         qHLfJYflxGdHATb4sz95jVfZqa93r1hpCdDmhgNqBHxDQbja9YCIKma0D62uGPUOJNWV
         GIrgqW/OPgokFwkd19FcjIBzBe//WGISgFZGHhw3hh3Y0HAT1V03hDcVToIkucMq0lha
         XnNkiGi1X+8T3gHC+N6Lc+JvNNF8dnsu84gzzIRD5eyIcF9GK0QJvJJf2/rd3k0MQ1fU
         SuEaQ5d+mydQbO/bjYlfIXFJxJfA8ikDbykzmyNnOnKLN5q9Go9egbDkg6albgUNrRiW
         cu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTm0+lMQk2kfHTGBG9gPkSbKUpeJmktegOBLx5j7018ELsAQewrtoE200wkOugb4yASI4RgdT4FVQGJGMWfRD7REg7OV/hMLgu+GCUtQ==
X-Gm-Message-State: AOJu0YxPgQHDtPaIMgLhKnD6PGtox5kDHHiaWziP4DIhQOgsH9YRD3R6
	sDDl+YO/MmU4TrLaKBsIDkuqZKEXNG9E17dtcmJMxlg9PA76CHJ38OE2WasFbkIT6kZqLzyOOx/
	OOTCHRej8izcyq26pAOdBM2xPcdpfBu+3T3kl
X-Google-Smtp-Source: AGHT+IH0SfAmG8rb+QcktSGfHWi/AHs2OD7smK1wxxMlrDuISAWiDiKzS7E7leJ1IekWL3YFAERaSLWneIBYBvP6CMA=
X-Received: by 2002:a05:6402:5206:b0:58b:93:b623 with SMTP id
 4fb4d7f45d1cf-5bd1b40925cmr206174a12.5.1723475214958; Mon, 12 Aug 2024
 08:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net> <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net> <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net> <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
 <20240809.se0ha8tiuJai@digikod.net> <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>
 <CAHC9VhQsTH4Q8uWfk=SLwQ0LWJDK5od9OdhQ2UBUzxBx+6O8Gg@mail.gmail.com>
 <CAG48ez1fVS=Hg0szXxQym9Yfw4Pgs1THeviXO7wLXbC2-YrLEg@mail.gmail.com> <CAHC9VhS6=s9o4niaLzkDG6Egir4WL=ieDdyeKk4qzQo1WFi=WQ@mail.gmail.com>
In-Reply-To: <CAHC9VhS6=s9o4niaLzkDG6Egir4WL=ieDdyeKk4qzQo1WFi=WQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 12 Aug 2024 17:06:17 +0200
Message-ID: <CAG48ez2tvHgv7sOVP14gCF1MAGE-UzJoMCfZqdmY1nXX4FFV4Q@mail.gmail.com>
Subject: Re: f_modown and LSM inconsistency (was [PATCH v2 1/4] Landlock: Add
 signal control)
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tahera Fahimi <fahimitahera@gmail.com>, gnoack@google.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 4:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Aug 12, 2024 at 9:09=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > On Mon, Aug 12, 2024 at 12:04=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
>
> ...
>
> > > From a LSM perspective I suspect we are always going to need some sor=
t
> > > of hook in the F_SETOWN code path as the LSM needs to potentially
> > > capture state/attributes/something-LSM-specific at that
> > > context/point-in-time.
> >
> > The only thing LSMs currently do there is capture state from
> > current->cred. So if the VFS takes care of capturing current->cred
> > there, we should be able to rip out all the file_set_fowner stuff.
> > Something like this (totally untested):
>
> I've very hesitant to drop the LSM hook from the F_SETOWN path both
> because it is reasonable that other LSMs may want to do other things
> here,

What is an example for other things an LSM might want to do there? As
far as I understand, the whole point of this hook is to record the
identity of the sender of signals - are you talking about an LSM that
might not be storing credentials in struct cred, or something like
that?

> and adding a LSM hook to the kernel, even if it is re-adding a
> hook that was previously removed, is a difficult and painful process
> with an uncertain outcome.

Do you mean that even if the LSM hook ends up with zero users
remaining, you'd still want to keep it around in case it's needed
again later?

