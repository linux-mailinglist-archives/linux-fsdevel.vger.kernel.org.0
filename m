Return-Path: <linux-fsdevel+bounces-23702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4279317E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A911F22003
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5750E552;
	Mon, 15 Jul 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="tjucHpsO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42817D53C
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058700; cv=none; b=VtEjb9Kxq/V6TZlJtOpz5kLpJhDPPc3588hsh1C3rLS27DftSlrXaD7h3kmhBi9Z+OBnPSkAnzoFpYfpO3zg44sN6CYRQIGE0y1d1C0Fr9Ge3wUwXwbFGcDYB9tOZA1ZVMSSB1rk8f4vgPyYcWKRTt8J+lRPMZoRgFOmWSgmibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058700; c=relaxed/simple;
	bh=xHCA5TeqTH1cSNUXMviwZzIcHBx90ea5mvQxlsp/Ewc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=r2pBjJNMgIvutZjiU/Ul/8AKJZWILSBRnlU43TlnrJboTxGe47rr9BUamcdFiwmfsutCr5Hofk+usGX5YVHOQC9c46ATrJDXAPH4HGA3W+NRjk1C+TLTqNDFvE9jAP6dRXwwSeYO7neyDikWeA2Nb2SpCB+0ki2G66xjRbW8QbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=tjucHpsO; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f190d8ebfso258812985a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1721058697; x=1721663497; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKMdcL8EXBSA8HsI5Gcc2bmX2TYfphTaiho0vk+UeKo=;
        b=tjucHpsOR6pXOrjvcSEJizFiELixgJFjH8qzXiLwCq+iB7jmH7t2p/8SJ4eDiduR+C
         Q8ueMBFhdLWXeDBdprMiYrx3riDN5y8W+Eo0yi7OMSWzsDOMIQty9Ug2GsvaqhH9EgM/
         JS2Fpq/8B/4ph3Dke5gpDqBYCCYwOhPwcOesOX3j1rvPTWgKPZcGpvdh1K/iORSBhK1D
         THSq6VKl3ImGkJN15x5H+uwe2NUEtdzy227DRfGkWYfRD6QMJk+4LydYlTRaszA7OWhC
         cZiKArGnMcU/ZaJSdX/orBvnXibyeo9898qNu5CLV/mnGGoltslMP8tWg9hcaBhrk5Iq
         plwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721058697; x=1721663497;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKMdcL8EXBSA8HsI5Gcc2bmX2TYfphTaiho0vk+UeKo=;
        b=dCkwvY3QyKWDwFuGp02cL6mqmqm1MBa/i3MpoYOehRekeOmZHvbi2iRHRxVHdLw5Uc
         EWQnXwlD+KuTxoCrRpD7fvp1B2XrAMa6WbR5hijx03MCXMNr8DInl5LWPQRliDEXIkpF
         ivjsPk8jXzj33IPqkm4GDWZMusQN7G/SAbFyTzPKBwTLs5kBZwT58EpCvnO8dbZlPFBE
         ycb7/+zgNb0Z6qXrZJJzrL4kt/qXwrjU86zBtI7C5tQCMgTSZq3+5XlTbd12JHvZF3C9
         IuDKVeHt2QtRcOiKF/0VqgpwVcxv3IO0QvN/szHdaQAkQOjDLz7+pRhAqEto1QYDGD4v
         HbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/R9Do88EnK0AybsYw5K1eXItCIbZMFE1RecJIljS32+S4mM7DRBRIKzve6wwcx8lrGAxU1lXCsqu6pZ+DZ8+nSVq9K08OCvVuMIrYnQ==
X-Gm-Message-State: AOJu0YyzZbPiLEgrf57DA+2qLZNz0psithmcANIMnW18tKPUmmeeFhR9
	jChcn4u15nPMQHC1ae/H6UsNSrfbZ8FcsTYuDC2X8JNLn+26mwvfERxlQ0AcbEewcKNWuUMX5vu
	pktjPLfgBY1oX8G8ZPs6IHcLcAW9KvWcfQw6E
X-Google-Smtp-Source: AGHT+IFAmrPEhROo32XRUZV0yslhRSSsmX4GgNKFrYjHsnWd6jmUspl8cItCP7TFNtcyzc4GnmWDtYCgDlIKhTikNE8=
X-Received: by 2002:a05:620a:bcc:b0:79f:1860:5621 with SMTP id
 af79cd13be357-7a179fa6e00mr14905485a.56.1721058696959; Mon, 15 Jul 2024
 08:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o55vku65ruvtvst7ch4jalpiq4f5lbn3glmrlh7bwif6xh6hla@eajwg43srxoj>
In-Reply-To: <o55vku65ruvtvst7ch4jalpiq4f5lbn3glmrlh7bwif6xh6hla@eajwg43srxoj>
From: Mike Marshall <hubcap@omnibond.com>
Date: Mon, 15 Jul 2024 11:51:26 -0400
Message-ID: <CAOg9mSSJCzh6KtEh+EvP7mrbktSjch5tzDzLXYtnpOrCYPgU9w@mail.gmail.com>
Subject: Re: Shared test cluster for filesystem testing
To: Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kent...

I think it would be cool if there was an orangefs filesystem tester
in your cluster. It is easy to set up (I'd help if needed) and then
maybe there'd  be more people running xfstests on orangefs and
more eyes on its code... plus you have all those other tests
besides xfstests...

-Mike

On Sun, Jul 14, 2024 at 7:35=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> Those who know me have oft heard me complain about the state of testing
> automation and infrastructure, in filesystem land and the wider kernel.
> In short - it sucks.
>
> For some years I've been working, off and on, on my own system off and
> on, and I think I've got it to the point where I can start making it
> available to the wider filesystem community, and I hope it will be of
> some use to people.
>
> Here's my philosophy and requirements:
>
> - Tests should be done with results up in a dashboard _as quickly as
>   possible_
>
> Nothing's worse than having to wait hours, overnight, or days for test
> results - by which time you've context switched onto something else. I
> want full test results in 10 minutes.
>
> - Every commit gets tested, and the results are available in a git log
>   view.
>
> Manual bisection is a timesuck, and every commit should be tested
> anyways. I want to be able able to churn out code in nice clean simple
> commits, push it all out to the CI, and when one of them is broken, be
> able to see at a glance which one it is.
>
> - Simple and extensible, and able to do any kernel testing that can be
>   done in a VM.
>
> kdevops is right out - all the stateful ansible crap is not what I'm
> after. Simple and declarative tests that specify how the kernel, qemu
> etc. should be configured.
>
> - Available to all developers and maintainers
>
> Maintainers shouldn't be looking at patches that haven't been tested.
> Everyone doing filesystem development needs access to this
> system, on whatever branches they're working on.
>
> IOW: big cluster of machines watching git branches and uploading results
> to a dashboard, with sharding at subtest granularity so we can get
> results back _quick_.
>
> I've got 8 80 core arm machines for this so far. We _will_ need more
> machines than this, and I'll need funding to pay for those machines, but
> this is enough to get started.
>
> A shared cluster of dedicated machines with full sharding means that us
> individual developers can get results back _quick_. The CI tests each
> branch, newest to oldest, and since we're not all going to be pushing at
> the same time, or need the lockdep/kasan variants right away (those run
> at a lower priority) - we can all get the results we need (most recent
> commit, basic tests) pretty much immediately.
>
> I've got fstests tests wrappers for bcachefs, btrfs, ext2, ext4, f2fs,
> jfs, nfs, nilfs2 and xfs so far, with lockdep, kasan and ubsan variants
> for all of those.
>
> The tests the CI runs are easy to run locally, for reproducability -
> ktest was first written for local, interactive use. I suggest you try
> it, it's slick [0]:
>
> Send me an email with your ssh pubkey and the username you want, and
> I'll give you an account - this is how you'll configure your config file
> that specifies which tests to run and which branches to test.
>
> And please send me patches to ktest adding tests for more filesystems
> and subsystems. This isn't intended to be filesystem specific - the goal
> here is one single _quick_ dashboard for anything that can be tested in
> a VM.
>
> Results dashboard:
> https://evilpiepirate.org/~testdashboard/ci
>
> Results for Linus's tree:
> https://evilpiepirate.org/~testdashboard/ci?branch=3Dmaster
>
> [0] Ktest: https://evilpiepirate.org/git/ktest.git/
>

