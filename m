Return-Path: <linux-fsdevel+bounces-53777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E7AF6CD1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 10:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F052B1C22367
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3762D028F;
	Thu,  3 Jul 2025 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvPVi6Ja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0722C3770
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531252; cv=none; b=DKuv+g02cMoJFGYStrJ5pTWuiMbXLMFv7EvnV6YaJbplUOETYwtZfsLdBzDgcP26a9+nkyuRmaAFtBeYnI6Q8z5hOdO/PSVQsVzRLKdPEy7MUylqyUfmFewhHHxTAWMJsq05nGtTG0f7PotChgNtE0kkGK/J73WRoyqBqGyIfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531252; c=relaxed/simple;
	bh=ynUKaUw4dB6UOZPfzdMiQXANf0Tqh14y9eIXWj+NKk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X30Nq0trX419F4+QpyZfaz0UPVyQFp3Lx/cfoIkrpL4FY25UVxF2nIynckb/4UFJA11YynrfxyrF98q7bYadzPvVsPGS/ejaxhcuLxuYR4aXwm0tGHZzmynf8hoYMIP+QXX4Ib2CaVe1QUbEnQdKhHNb6sWAHZE2XlSNsmPHqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvPVi6Ja; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0de1c378fso757100666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751531249; x=1752136049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMZo2X/PescMlQne5lPqIaaCed7OKVVsOi8f802GTJg=;
        b=GvPVi6JaHwveaqPMYD8uuiTa31q6qNfIVIyV1ybJ5Qj5vhI9u7K/WJ+kKFmDPZX0Ux
         Cpre91skdMaIVLI/53/jhvhjjx0fiQ7dFukKK8TZqdhwxF85Lv9zgAGQt0V3tC9dyf6C
         m0zHFgect5sx4cFz+19Gq/NMBFklvf39rMIlZQUbPG/i6q8i2jaIfa8WMN8dv0/R2N9A
         VbTozovfIiQWqof2QzOrazitWCzVPoXDfdlUyPyU7N4ZsVlxfLZBdQYn7H0CC1khpfld
         3LRHHcq7qsz3+KWk5c1oHFhybiQnPAdYvr0amHNQvOEO8BMDn8LFqaxrTvJmvHp/kXud
         Nh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751531249; x=1752136049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMZo2X/PescMlQne5lPqIaaCed7OKVVsOi8f802GTJg=;
        b=i8Y0Bfmuz0J4WMmokuRncH7ki/mxLAqKLFWUGCBH1TdPio+zPKxq40JrOz+KTIev0w
         x5js+PgiSl6pz8p2+BLRG2THeo6J4TXHqNvw6Clc7WGYNEsGLpGM+EC1jYlNp5g3iqR5
         +EE//A4s+SZLZW3ubU3ws33z3YjnREw1CI+0AcEhlaB2u6N+yYbt8QTlAt1liim5yY8b
         +oV9PFU9epop/7axjYYrrZSdRb4u2woOHS5nd5fBnLLrQalz7hqxgmcQvIld/re7m1rm
         OZFqSoirwbCxZHYtcJHXAyW8mB84GpvRTfm/7+SgFhrWO0spXR/+TBNePFn7yzCFLUNO
         SRfg==
X-Forwarded-Encrypted: i=1; AJvYcCWh94wC7A/EFOmnkaKbZ/nzQpj83ciU1O9+dJlhpwfnEmiVER7y4BhLEUR2poMb0LrhbPhntUv5gF8k4ass@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXl8k1DAucg+vUqT+KNeCKethTi5DQ4pr6Pj5faQRI57BjC7k
	6osGEgNAAb5vEvNm8h/ZgOPJs6MxtFmH6ktr5KjAQUicXqBrVhNF/HTfJEUBRIUW8obXJvsvsfm
	ah+MVVkRlCzzOVicbB0Iaj7CMeGhCfGk=
X-Gm-Gg: ASbGnctxOKj13dUOqBs9m3Plv4L3Vw53f7DIjZtH7khVZV9iQmAsnEi2pwB5DLuiNAu
	JQAnFAq2dKPpXBBS1sbmZ3IqvakeE+gG+50mJRIO+ParizMKznFnjQCKelBJjQI1+BIFoGPdFyc
	7NFLuKqpcxbK/Q9oSAaVWIHnB1WH4BhIeVHmZ9T7aon0Y=
X-Google-Smtp-Source: AGHT+IG5wpwtU4RRrIZF2N1dEp95R+4RZD1kNtXhbCiLx+rTlnBMv2Od2ZmDN9nmdjpofAxqHo4+7RdFH999BbPuLIk=
X-Received: by 2002:a17:906:794b:b0:ade:4339:9358 with SMTP id
 a640c23a62f3a-ae3d84635cfmr216333866b.22.1751531249078; Thu, 03 Jul 2025
 01:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjTtyn04XC65hv2MVsRByGyvxJ0wK=-FZmb1sH1w0CFtA@mail.gmail.com>
 <20250703070916.217663-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250703070916.217663-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Jul 2025 10:27:17 +0200
X-Gm-Features: Ac12FXzq3zjCZr0OvW1s32RNIzH61UyMP9zZDR0wV_r9hX8UDMsbualmdWZH50U
Message-ID: <CAOQ4uxgfhf6g71_8y5iXLmNVMBvYVtpPJgd9PNXQzZnqa2=CkQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: support custom default close response
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 9:10=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@meta.c=
om> wrote:
>
> > On Wed, Jul 2, 2025 at 6:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > Eventually the new service starts and we are in the situation I descr=
ibe 3
> > > paragraphs above about handling pending events.
> > >
> > > So if we'd implement resending of pending events after group closure,=
 I
> > > don't see how default response (at least in its current form) would b=
e
> > > useful for anything.
> > >
> > > Why I like the proposal of resending pending events:
> > > a) No spurious FAN_DENY errors in case of service crash
> > > b) No need for new concept (and API) for default response, just a fea=
ture
> > >    flag.
> > > c) With additional ioctl to trigger resending pending events without =
group
> > >    closure, the newly started service can simply reuse the
> > >    same notification group (even in case of old service crash) thus
> > >    inheriting all placed marks (which is something Ibrahim would like=
 to
> > >    have).
> >
>
> I'm also a fan of the approach of support for resending pending events. A=
s
> mentioned exposing this behavior as an ioctl and thereby removing the nee=
d to
> recreate fanotify group makes the usage a fair bit simpler for our case.
>
> One basic question I have (mainly for understanding), is if the FAN_RETRY=
 flag is
> set in the proposed patch, in the case where there is one existing group =
being
> closed (ie no handover setup), what would be the behavior for pending eve=
nts?
> Is it the same as now, events are allowed, just that they get resent once=
?

Yes, same as now.
Instead of replying FAN_ALLOW, syscall is being restarted
to check if a new watcher was added since this watcher took the event.

Wondering out loud:
Currently we order the marks on the mark obj_list,
within the same priority group, first-subscribed-last-handled.

I never stopped to think if this order made sense or not.
Seems like it was just the easier way to implement insert by priority order=
.

But if we order the marks first-subscribed-first-handled within the same
priority group, we won't need to restart the syscall to restart mark
list iteration.

The new group of the newly started daemon, will be next in the mark list
after the current stopped group returns FAN_ALLOW.
Isn't that a tad less intrusive handover then restarting the syscall
and causing a bunch of unrelated subsystems to observe the restart?

And I think that the first-subscribed-first-handled order makes a bit more
sense logically.
I mean, if admin really cares about making some super important security
group first, admin could make sure that its a priority service that
starts very early
admin cannot make sure that the important group starts last...

Thanks,
Amir.

