Return-Path: <linux-fsdevel+bounces-55986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8069B114D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 01:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10D41CE317F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613902472A3;
	Thu, 24 Jul 2025 23:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPQ45Yo0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D212417C3;
	Thu, 24 Jul 2025 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400323; cv=none; b=PL4lj7cusPsGREl+c1Lz4G67G1nmIUPuAoeezGe+LsbZlNvvWs73HuqKH5F4DNSA0eJSGZLgRx2FOjCn6LUq9349RvdE1HAR0u/6HiVOgqgrV5/AE405tke/PQayHjbUyAb+N4O8UqknWcgf13fuWGXSjV8CpdbHYaqILgQmeOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400323; c=relaxed/simple;
	bh=pXdNxE9tpLip9SvGV3VJ6bsDBur/3UfJOhcasaTCFrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=co5cEVckq5tHdwqIpZJ25PQ0DqakfZ4h/ing/24pwVQwsnsScDWw+NYEnbgnPEAuIYDcZTyLqCit2N48Y47rAbdFAInAeI9AWg2/Afwj85Reik+01+g2+O2l0taYzj6gWk+dFKKV7qeXthcXGx0pPCEaFGrlQYU7PgXxBQCOrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPQ45Yo0; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73e810dc4cdso731446a34.0;
        Thu, 24 Jul 2025 16:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753400320; x=1754005120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXdNxE9tpLip9SvGV3VJ6bsDBur/3UfJOhcasaTCFrI=;
        b=dPQ45Yo0Hye6Qe4aJHAQaa8t84zNXO6x+jeMx/3CYydNhrbPFu7Xt97uWqsfaJtQRa
         CwlYkE4ZunVnjxgcZFPj48+qfchW6OsTjPsd9oPGmQcrfzWyThBCPRi1wTnBM+yAsujv
         /WCilBizPiFSiAx/lZekTQT3YPW1PBEqL4W1QeYmo2qcydO5TzYSDCFiX8D2xN0rCQV7
         kGWiwOtGmbTjk3n6aHWD2sMvN8tpQsQOrnA+e4jXVnklf/Tolc9g1kSl38NbvrKUHsFY
         eD3Sn0KbjdGb2z3PUl7Y+MgApCEC06DIInSHIEr258wQC6x3BVBXX5UZfL/fr462YKNh
         +1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753400320; x=1754005120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXdNxE9tpLip9SvGV3VJ6bsDBur/3UfJOhcasaTCFrI=;
        b=t8l3jieddgGxYFcPXWmO2MLNSwaqlTFfsh4ktdDgItGIluozEFZPj4yMozwekSgaVm
         PJatUROHTvk6bwYVIIAiJQRjJ557BCy4305lHHd8qSByNx08fYn0YrcFeGYWWZc9nA+u
         oyhBrf/3U1+Ar3gqqH8mjn98fbMxSu2Qx8LMuG+zEpY/8M/W6HwsNah6Ct6CX3GcAsYb
         a6Z94xrtYzpnKi7tKCUahgfkFx1NzWr7e1NFjdDo4ncYVkS4CgmCAEuLe6EvhaIYDaZ2
         ULcPn6kjC6yFbhX63710bwYn+3uY0phtFwkU0WS/3GG0KZFXcolJ/dUdHcfxvzOfVL2d
         fPBg==
X-Forwarded-Encrypted: i=1; AJvYcCWKumMe2jRHNtecVzgoSfyaNxKZ5zWWTJo9278pI7SbNCbyI37QoXhMr5bDX3GP5Bnksago62bdCerADNg1@vger.kernel.org, AJvYcCXanYahU8dehPkjjpiVkEDRIr2z/Yc3znN979fFe+s7cMnhHFvhFzbeUBcDz3TfFHaVBOPdffyUBPUvaFlJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt9BnNuDQerJQuPKytPyrsm6kOlDfsHoiB/YPXtInpfHwCMpX0
	02ZBKhZ58wrMFZ2t0h4SUwTxO58Oxqy6WyEje5Ym1X3bwtAZwXIS0It8uxWST5kvS3KqapeBU2k
	W8PmxB+sFHBgCugp/d8xAt/dkGBGkkd1gwNpy
X-Gm-Gg: ASbGnctFWC5kowBJSIvBGeuYNK82XT30Wp36pj80w8oX221SLL6q9/+6IXvxw1w+F1c
	oLBBMJMC4Yo0hTIHEmDteF2dCuXCK0yBxpyCFrbFVArC7CAnojIf1e6O3y4SmUC7EVYi/9jjFk6
	h4khuxdmV8U/N16+CS1rb2KlTnmfmcsnvK+07SZtG61NSfqed3SRdIxcn0Yygnqztkuc3Pej9NU
	CtLlUNp
X-Google-Smtp-Source: AGHT+IHy2Ok/9ud9aEQGUDRQM+qWc2wa92UUS6hzjNcs/utKgCV7TVhWcokhr/gmQj9XGNUqz/cnLqWlv7GJ8YaagVU=
X-Received: by 2002:a05:6870:b12:b0:2e8:f5d4:6077 with SMTP id
 586e51a60fabf-306c72fea4emr6085604fac.38.1753400320329; Thu, 24 Jul 2025
 16:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV>
In-Reply-To: <20250724230052.GW2580412@ZenIV>
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 24 Jul 2025 16:38:29 -0700
X-Gm-Features: Ac12FXwyhu4hKnB-sCEEdNMiO11nDVh2Vc7kK1htFygVvQ6qXTEXTXe-sHhe_MI
Message-ID: <CANaxB-y2MYkrsik-SKsuB6XE1Oe81y1UiTt=m46Fd=7Y=ysAyA@mail.gmail.com>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 4:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Thu, Jul 24, 2025 at 01:02:48PM -0700, Andrei Vagin wrote:
> > Hi Al and Christian,
> >
> > The commit 12f147ddd6de ("do_change_type(): refuse to operate on
> > unmounted/not ours mounts") introduced an ABI backward compatibility
> > break. CRIU depends on the previous behavior, and users are now
> > reporting criu restore failures following the kernel update. This chang=
e
> > has been propagated to stable kernels. Is this check strictly required?
>
> Yes.
>
> > Would it be possible to check only if the current process has
> > CAP_SYS_ADMIN within the mount user namespace?
>
> Not enough, both in terms of permissions *and* in terms of "thou
> shalt not bugger the kernel data structures - nobody's priveleged
> enough for that".
>
> What the hell is CRIU trying to do there?

As usual, CRIU's doing some kind of ritualistic dance to restore a
container's state. In this specific scenario, it's about restoring a
mount tree across multiple mount namespaces. Fixing this
particular issue within CRIU isn't a big deal, the challenge is in
propagating this fix to all affected users. Given that the kernel change
has already been merged into stable branches, CRIU will stop
working for most users.

The criu fix is here:
https://github.com/checkpoint-restore/criu/pull/2695/commits/e91d74a27b723d=
4dd1f9aceb83601b1b8c2b50a7

