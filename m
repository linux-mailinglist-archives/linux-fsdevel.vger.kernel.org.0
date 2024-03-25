Return-Path: <linux-fsdevel+bounces-15235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7CC88ACDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302D41F3971C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C81C1F922;
	Mon, 25 Mar 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YTTx+L+K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5212208E
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387293; cv=none; b=SCfV97POxIMNwjajdP3efhaCLlBtJQGPJXh7AT3Srtq1Ro4wtVWP6hTvPlOxkqLV5IW780HQvFTuZyJbbEg39a4NeWEeHmQJ7qOQ58j1w0chiin6Np6VL0bGe4e9XjkV4pjG0N2u3fOhTF11gNS8rwGA6K6dJpfB3O4qibF24BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387293; c=relaxed/simple;
	bh=viw5DHYPaObU3U7ujOkzz6hhRTbM8dWi+h/TUtfWHlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCejj4i1Wfff3UI01f0BrVCod5flFNQLmbKkmNpoyL4GO2jCVLrYKat8PvAXEcSD9i/M040Vb9o1AuBAALHNA59pH3nLSiyQU8BYW0fty5L2gj9e+b8bWfftdst8ywPvqNDdxKgzGWmvBgwK8xKytxCrBTtRWzWLJIVN6OC/578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YTTx+L+K; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609f060cbafso57348737b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711387291; x=1711992091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwFJJMO8Y9QW/VnLPngFZc/sbeBlDHZAU2bsUzRDf74=;
        b=YTTx+L+KKPuBuhxnpXHeUOcGt8Uppef+zkahssJep2AgGWDOHljab1Iv+i3+xFKuEQ
         AedEqMLV30CVEKseuJCHYMatq/Ao2y29L0rUJ/y7WWgFwHUe9PpUHunZ0iHX7A3pHnVA
         bu+44E6/EZhSswDywqaK86dGhvY9Ne0QGdhC8bSojLoMxA/AJuRS3IISZG8MOubOfM+q
         rdiBpQSaVfzt8dRjM3VzPOaEQYn5HnGWC4oRHoIodImVh35IF/sB0aDxFU8YcIo55Px3
         7iXnPO+oqSCFJb9yS5+/Yewcix0r84Fss4uSeJa9ycsUQo1W/6GTX8cds+XLTV+2DNZS
         y+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387291; x=1711992091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwFJJMO8Y9QW/VnLPngFZc/sbeBlDHZAU2bsUzRDf74=;
        b=M8cxVL9/GDdcSeeXf6hj1/3P4rXWZgwlk6Qh2RQY1BXz24yBRsEQ2iMF3AXRVqGakI
         8ykaY6baMkihgqYFBnxVZOyaSpUoNjrPmQrj1mEZzXpXbcpSm8xkctwlMQhkz3jFSNKN
         6NAaZM883hxhHmNHfXN3Bp73qvGoI6br+2iQKVD0AJn9IHu0t17gYS4Xgkq/H7YVqfLL
         rVeqMy/dGT9hBI42uvsbVzqN4BdDshizSpjjKIkf8zfZrHHLqb8oghJhgZv+ojpfFTnQ
         4VLICcx4+IWPpv93L7t8BvUK8h44Yga4RNXjH4hvJB5SvgnEZtnD12Rs9cX+Mf4jC7mH
         flBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFgS24VF/mlsDQrnr3Bhj7ofMx9MILmX6fEwyqj67i4+GsHsnvzJ9Cv+PznlPZMAbmtAovP/q0Wts+EMBdHDAdAzKYCWQ9W2T3b46Q/Q==
X-Gm-Message-State: AOJu0Yw0wqQ6xAy5iT1261Bq7QAO8ywv6k+osrP4QYlgaLNZq5qxS01q
	tMZjvb1G5e/2wTOtM19HNg+HYcdKWu/krjcKd54SLU6PFlIN5kZgm7/EX0alMNRfPbveWVifgCo
	0xFwTzTZLWcquTgLiS7UgwVS5hvwv2OT3mFPX
X-Google-Smtp-Source: AGHT+IFMwOQ7JYZ7RIBsL/iaaKoCpBdaov3J7tHg8zqWWrlziSCuAkCo3Xzme8ojXw3lDFimOmE9DPWmLf9w8Ru0nlE=
X-Received: by 2002:a81:a10e:0:b0:60f:e8ca:4959 with SMTP id
 y14-20020a81a10e000000b0060fe8ca4959mr6688036ywg.18.1711387291265; Mon, 25
 Mar 2024 10:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV> <3441a4a1140944f5b418b70f557bca72@huawei.com> <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
In-Reply-To: <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 25 Mar 2024 13:21:20 -0400
Message-ID: <CAHC9VhSamu4706AwP1M+3D9vyxrMZgaZmHH8KUmjuG1Jig4aPw@mail.gmail.com>
Subject: Re: kernel crash in mknod
To: Christian Brauner <brauner@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Steve French <smfrench@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Christian Brauner <christian@brauner.io>, 
	Mimi Zohar <zohar@linux.ibm.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 12:06=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> I'm a bit confused now why this is taking a dentry. Nothing in IMA or
> EVM cares about the dentry for these hooks so it really should have take
> an inode in the first place?

I don't want to speak for Roberto or Mimi here, but this LSM hook was
intended to replace the dedicated ima_post_path_mknod() hook as I
wanted to see IMA/EVM integrated as proper LSMs so we could so away
with all of the special IMA/EVM hooks and treat everything as a LSM.
Part of this was creating new LSM hooks where historically we only had
a IMA and/or EVM hook, the security_path_post_mknod() hook is such a
case (e.g. /ima_post_path_mknod/security_path_post_mknod/) and the new
LSM hook kept the same parameters as the old IMA hook.

Yes, you are correct that neither IMA and EVM do anything with the
dentry other than looking at the associated inode.  I'm not the
IMA/EVM expert in this thread, but I suspect this is simply an old
vestige of former code, or perhaps an "optimization" to avoid having
to fetch the inode pointer in cases where IMA/EVM was not enabled
(although it is used in the vfs_create() call directly above, so who
knows ...

> And one minor other question I just realized. Why are some of the new
> hooks called security_path_post_mknod() when they aren't actually taking
> a path in contrast to say
> security_path_{chown,chmod,mknod,chroot,truncate}() that do.

Once again, think of this as a
/ima_post_path_mknod/security_path_post_mknod/ type of replacement and
you have your answer.  That said, I'm not really against bikeshedding
LSM hook names if people want to do that, it's not a stable protected
API so while we try to keep it stable~ish simply for our own sanity,
I'm happy to see it changed if everyone agrees it makes sense.

--=20
paul-moore.com

