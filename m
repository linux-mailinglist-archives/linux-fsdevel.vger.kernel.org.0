Return-Path: <linux-fsdevel+bounces-24917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4A7946973
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 13:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF701F2191E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 11:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C814E2E9;
	Sat,  3 Aug 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsZBJjsv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD224A2F;
	Sat,  3 Aug 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722684081; cv=none; b=DUQpOyaL0E0VzRqXPlavjWHSAywBpnw66vfK5dqDHBu7z2ZszpCPl1WOKLSqCTqpMQvI4aXOgCORDAMbUw5G1KCb+wtPKo2nag5qURvtUad41cjuHDTP9UnyCXo68zNBvTdiNekU0POqDcPlzYDxAZrvtv9Mo627qd0TjQC5eX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722684081; c=relaxed/simple;
	bh=QrhVcfaac/jQoid6CKCLFt0EITjZfWQrXsJQLJvguSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBFsTspmLfRtB6ZRao5K+SW90YPpVTfryOlK6aNIBLcsF511CiMUlSbd8N7sgww8u8adRObIgkbxbULYW4vEqO2ggmGWOV6F7dHPLcRSehFGQ8su2AUfuLzBK13B28t12ePd12fz5HE10PAMDas9N6DYYtCvB1FPx/CtNFjBorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsZBJjsv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso10282614a12.1;
        Sat, 03 Aug 2024 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722684078; x=1723288878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrhVcfaac/jQoid6CKCLFt0EITjZfWQrXsJQLJvguSo=;
        b=EsZBJjsvndYm7RmzzRBbbEyyt27OGGFiUk6VffKNJ0Ec/plG0KaFdyZKKeVG5q9vm/
         tKIqLe5MYxDKefl3ipfLLp8ZKd9cNIDTZxSk3ZIxyUjfT7M4TfH6ViRsCqrPVECmFvan
         BPDbiN1Bv7keTr+L1zvta2KF6K78gnXQ14xaDW0NDHlGD6f/abVME11Jjaqdj3E9DOyA
         3Rgo6tDK5QLSrrg0w0m7GF9fGL3ipHkIp8ie4I508efIE4cuNQQkGtdF7VhO253/nMVi
         DRwFaE1Nw9seA61W06EQOoFk4/IyFV0LaDGMAq/Pmcxy0YXAS/vBk2MneuLDRl4fKPPN
         wH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722684078; x=1723288878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrhVcfaac/jQoid6CKCLFt0EITjZfWQrXsJQLJvguSo=;
        b=iUIYxw7RDOQ+c4DcTXW01oqeikh1rKo9dTbtowsT5PIe1nDiywLWeNU/Q0fYpVydeo
         CTpI8/X453JCmJiqPkYaCAiWbarYyp5//VcU/fB8G6jCrvXqTr+0blbpNeJdQ7Pl8Hc+
         Vj+QBUyy4C+qqRVfTPaCE9WpPwksmd2GtDaJs3qsqDjABxL0zl0LjmvITdG+cj4n+41z
         2ni8IDZ48O5Hg74zyGSFziPtPWi9d0OBm1tO5OA3zcSIQyiJg1jN91M/CbMpmD5EP3OQ
         JURde0h7AJO6a2gNNsEM1xOeLR/fWBGgBfMy6t4GRbH/7cV08uqjs7dyP/Kt/Ip+9U4t
         a8dg==
X-Forwarded-Encrypted: i=1; AJvYcCX0IpZgZBI3XDuwBj6rEzmPEayMcanX2q31usYEur8dUC19K0YMBPtJqPbdqhSDInKFZwoqhuGtDtXy5yuO43Y8lqGvSP/vtTStvkpQdMsyl0KhQzndnyyzyWVgSGCy1Qbw1XogOkekalhIVQ==
X-Gm-Message-State: AOJu0YwDrRjhOC3jAASe42Jr2zNPp9FjmlgJGsYOx20D4YpODaFyrEBa
	FaK6uWAOgKEg7NEUnx51QKUDfkKNilTYRSASLIICl8S4ASHRtTyBcdTIWuiPrr5EdKskAnJEndy
	A4vrBRqI8u8pr0t859qKrP39WGo4=
X-Google-Smtp-Source: AGHT+IEJguttsEGCg0THlfHQI87saP2Xh2p7C5RQA1+1AvivqYNW876SSwAdU6UgFViWtHN+tAgEywlhpGjzsUKfpZo=
X-Received: by 2002:a17:906:f5a1:b0:a7a:8e0f:aaed with SMTP id
 a640c23a62f3a-a7dc50a4adamr378204166b.50.1722684077451; Sat, 03 Aug 2024
 04:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
 <20240802-openfast-v1-3-a1cff2a33063@kernel.org> <r6gyrzb265f5w6sev6he3ctfjjh7wfhktzwxyylwwkeopkzkpj@fo3yp2lkgp7l>
 <CAGudoHHLcKoG6Y2Zzm34gLrtaXmtuMc=CPcVpVQUaJ1Ysz8EDQ@mail.gmail.com> <7ff040d4a0fb1634d3dc9282da014165a347dbb2.camel@kernel.org>
In-Reply-To: <7ff040d4a0fb1634d3dc9282da014165a347dbb2.camel@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 3 Aug 2024 13:21:05 +0200
Message-ID: <CAGudoHFn5Fu2JMJSnqrtEERQhbYmFLB7xR58iXeGJ9_n7oxw8Q@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] lockref: rework CMPXCHG_LOOP to handle contention better
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 12:59=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Sat, 2024-08-03 at 11:09 +0200, Mateusz Guzik wrote:
> > On Sat, Aug 3, 2024 at 6:44=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
> > >
> > > On Fri, Aug 02, 2024 at 05:45:04PM -0400, Jeff Layton wrote:
> > > > In a later patch, we want to change the open(..., O_CREAT) codepath=
 to
> > > > avoid taking the inode->i_rwsem for write when the dentry already e=
xists.
> > > > When we tested that initially, the performance devolved significant=
ly
> > > > due to contention for the parent's d_lockref spinlock.
> > > >
> > > > There are two problems with lockrefs today: First, once any concurr=
ent
> > > > task takes the spinlock, they all end up taking the spinlock, which=
 is
> > > > much more costly than a single cmpxchg operation. The second proble=
m is
> > > > that once any task fails to cmpxchg 100 times, it falls back to the
> > > > spinlock. The upshot there is that even moderate contention can cau=
se a
> > > > fallback to serialized spinlocking, which worsens performance.
> > > >
> > > > This patch changes CMPXCHG_LOOP in 2 ways:
> > > >
> > > > First, change the loop to spin instead of falling back to a locked
> > > > codepath when the spinlock is held. Once the lock is released, allo=
w the
> > > > task to continue trying its cmpxchg loop as before instead of takin=
g the
> > > > lock. Second, don't allow the cmpxchg loop to give up after 100 ret=
ries.
> > > > Just continue infinitely.
> > > >
> > > > This greatly reduces contention on the lockref when there are large
> > > > numbers of concurrent increments and decrements occurring.
> > > >
> > >
> > > This was already tried by me and it unfortunately can reduce performa=
nce.
> > >
> >
> > Oh wait I misread the patch based on what I tried there. Spinning
> > indefinitely waiting for the lock to be free is a no-go as it loses
> > the forward progress guarantee (and it is possible to get the lock
> > being continuously held). Only spinning up to an arbitrary point wins
> > some in some tests and loses in others.
> >
>
> I'm a little confused about the forward progress guarantee here. Does
> that exist today at all? ISTM that falling back to spin_lock() after a
> certain number of retries doesn't guarantee any forward progress. You
> can still just end up spinning on the lock forever once that happens,
> no?
>

There is the implicit assumption that everyone holds locks for a
finite time. I agree there are no guarantees otherwise if that's what
you meant.

In this case, since spinlocks are queued, a constant stream of lock
holders will make the lock appear taken indefinitely even if they all
hold it for a short period.

Stock lockref will give up atomics immediately and make sure to change
the ref thanks to queueing up.

Lockref as proposed in this patch wont be able to do anything as long
as the lock trading is taking place.

> > Either way, as described below, chances are decent that:
> > 1. there is an easy way to not lockref_get/put on the parent if the
> > file is already there, dodging the problem
> > .. and even if that's not true
> > 2. lockref can be ditched in favor of atomics. apart from some minor
> > refactoring this all looks perfectly doable and I have a wip. I will
> > try to find the time next week to sort it out
> >
>
> Like I said in the earlier mail, I don't think we can stay in RCU mode
> because of the audit_inode call. I'm definitely interested in your WIP
> though!
>

well audit may be hackable so that it works in rcu most of the time,
but that's not something i'm interested in

sorting out the lockref situation would definitely help other stuff
(notably opening the same file RO).

anyhow one idea is to temporarily disable atomic ops with a flag in
the counter, a fallback plan is to loosen lockref so that it can do
transitions other than 0->1->2 with atomics, even if the lock is held.

I have not looked at this in over a month, I'm going to need to
refresh my memory on the details, I do remember there was some stuff
to massage first.

Anyhow, I expect a working WIP some time in the upcoming week.

--
Mateusz Guzik <mjguzik gmail.com>

