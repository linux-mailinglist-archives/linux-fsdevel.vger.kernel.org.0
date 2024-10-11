Return-Path: <linux-fsdevel+bounces-31660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED76999999F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 03:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66413285944
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 01:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE8D11187;
	Fri, 11 Oct 2024 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JSCg7dbs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB86EEA9
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610737; cv=none; b=Yyu6vtA8nRhtU7jsN3Txcz+ImSGKS/B33yZps4pwgzCzwN25aCCa2BNHdtSlq+v6Fa1/vCpC2gqWsd06gwBQQUG+ls3IOrguPlfFh6gCgss+eeHQre2pj2EmTMIGS6LWWOUVAgKVJ2lR9kaEUL4ED4KjH8nNd5Fsx1M9A3RJ+I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610737; c=relaxed/simple;
	bh=9tJXSsQ9fSvcpkQGEvBg2L68OGr0KwcdVp0VeMEtExA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gl0gyUKt8bcLpSOk5lye/S3WxQWjUx4LeI0r6ThQH/zzTBQiqwMHL39bziFlsMtyVbVVKX2XR+fwUrxrmZ4d/mP5wU+rujd/NkdcJGlfDk5XXCfWaoDdiIpIAYJY9X0tq9w69s4L5EtL01MgV1Yrd+uan9gRJFq327EhQrSJIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JSCg7dbs; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6dbb24ee2ebso18761717b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 18:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728610735; x=1729215535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRcd9cwIZFh48Jk9iJ5FWFlPG9snV80qLzRLo6hXxJo=;
        b=JSCg7dbsLrzz2Z4F7/4WhtnEh8Ni8l0mm6RCMLDgsI2tctqgNbvd5Gl4acrgKk7mtw
         82HqGBD8uC8gf+svvHOMvucERy7YIRytPO1b14sAaDoCjXK4kgUqOi28GftMSHmvQEVx
         HeflE8bxjuuADOiB8wnDYcwZy3JAC0fwyPj819EBeZBpnFFg3Jmc27yIeaikX7o5o4nD
         3bQLiR7XNRBJSMQXJCaqlt0qCkf/B2R1DcErvCqPFedM2i2JoJf+AWSMNcceyPovU3uZ
         kRLskDTU2vvEdO/MVMdQewQNhlpBXqy7PxkUey+1M9gf1as0jxayQ0CeUPG0U1ypTbA/
         VTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728610735; x=1729215535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRcd9cwIZFh48Jk9iJ5FWFlPG9snV80qLzRLo6hXxJo=;
        b=SCTbknLGMI2ZV+dhRZZpori+cJLRTgti/oM/gA+UD0UGyXgKkfC0lbTwydmLpvVMt6
         4hkaw9/y2/ySub88NOiE/h5BXUK/9SRMOq9H3wFNF3Ptx0DuURwdWmq3i1Xu/a5ZzG4H
         OrabATatz3BnKjA1kYL7If25z504Dcs0DN9Za0jKlPyOl1/crRRtE0W7YSau4ShhRlw5
         S7+g5lWb+capRoo5ImLQAEs2RZW/XdH2E9YPybXV6KydR9z1UTorfx2XgfcaQbPPN4Wz
         9ZnLLEiTUaeiDdojAmU3EsL1rXMmlyf/26v7CMApC+Hb7jcObRNAmFJfRYqszJPhssmG
         73wA==
X-Gm-Message-State: AOJu0Yz7gpnhJ/an7q/xZwp5clKGx5uZeZCSV/o+txZTnvmQ9grqY0bH
	+B9MpbXl78xzu/ke2+KeGyyWyhMMGk51Tw5akejq0i6cBG8yvGwKL5EFt2jkfvM8S1j+50GPWqa
	XvGvBT+Jp9eFZXnvGyVIY7InQPtC3sYmLdDfN
X-Google-Smtp-Source: AGHT+IFvoAiqQTsFIOJfK+l/01uP1b8r2mlIlEpP49rC76iACwSSk+CMcgg9Ira3XeXkyuN2zyckIivG5f2h/gWZomE=
X-Received: by 2002:a05:6902:124f:b0:e29:6b8:af3 with SMTP id
 3f1490d57ef6-e2919df898fmr992944276.44.1728610735214; Thu, 10 Oct 2024
 18:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-2-mic@digikod.net> <c4260a81d3c0ebe54c191b432ca33140@paul-moore.com>
In-Reply-To: <c4260a81d3c0ebe54c191b432ca33140@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Oct 2024 21:38:44 -0400
Message-ID: <CAHC9VhSJOWD93H0nPTCdKpbM2dDnq65+JVF1khPmEbX_KhHxsQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/7] audit: Fix inode numbers
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 9:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Oct 10, 2024 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <mic=
@digikod.net> wrote:
> >
> > Use the new inode_get_ino() helper to log the user space's view of
> > inode's numbers instead of the private kernel values.
> >
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Eric Paris <eparis@redhat.com>
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > ---
> >  security/lsm_audit.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Acked-by: Paul Moore <paul@paul-moore.com>

It looks like patch 1/7 still needs some revisions, and an ACK from
the NFS/VFS folks, but once that's sorted I can send the patchset up
to Linus marked for stable.

--=20
paul-moore.com

