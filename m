Return-Path: <linux-fsdevel+bounces-63111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 124D0BAC7A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 12:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D0F188F159
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 10:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D68221F0A;
	Tue, 30 Sep 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lxGFj5wu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A09253F11
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228185; cv=none; b=Mqs7sqVSTEE26yFXJfIKVb2xQ2woa5v9RRj2yRfzdgPfSZvrQg3IyBSj7FmHY74/RiWhEB+gVfseja1dmFbfHyuYpXU0pycM8/Rh8aN5qQmhyUpohhf40jiWwrf2c3/aSYc1kt9BaF8H9Ao7DIHGvGEUtzsb0g6IoeZgP7ZCHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228185; c=relaxed/simple;
	bh=kEkp6++hhMsukQ7Co43d2hva1/jaPJAiRZVOch3dZnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y75jaksfEnfCUOXYWf5/M9gaIph6QXKb0WrpAEhUHAeavi7oMb2l5jtyUcCn2lehH4gvylEBAmeM1Fvz7Q7lz6eDV7OPbM7Jv+LD5hpRFVBeFZSoIEG4hfgTzcKCRq6p6t9gnJeszIAwBIvBC34ODpk9HB3PxO39kLK5YIj078E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lxGFj5wu; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4dffec0f15aso32228341cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1759228182; x=1759832982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bTfqprXJfvkg3sEJpNRj208d4FU4g7NixV9zMkm9LDg=;
        b=lxGFj5wu3IQ/hPnFhdpXXG9HvZxnGvWsumzK5UmyynlX1WDm/TvPvTH0cnU3QyVeGg
         QLeTMirmeAubbo87yOZWUmqXB2QGScFV311GNTpsdwI0ZtXL/mqp1WkG+HZmfsN3Gd8k
         vB47OXr327zFuR7kVp8MLeBoErMK6htBHPikw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759228182; x=1759832982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTfqprXJfvkg3sEJpNRj208d4FU4g7NixV9zMkm9LDg=;
        b=uEoA/6ojSYRD5JKkYxexQMDde/z3B+KRN/5i09K8DErxEXUjyCmC1r9yrIPUoCfO9R
         dqoMhr0EpR8ugT25xVnpEaBgN3NttOSEyhFp1MvdMIU6d+4ZMxxZF/QralM7O5hYHVi8
         YI8+q+XNWa+hBwA6loi18UNwhUt8cj8iYW4/u0Zs3yY/HtuYHhgAl699YIRab4QoMhRB
         tCTU7WgBc0Pc5Z3mydO99mtiyoiSS9O8Rzyl4pHMfT4KSEID9AaW6GCdnuURpPWRygka
         W7ZpcIT/Fi88+NFHZ8M6gA5QCIr1ANAW+zoeE9VV/AGmnOPPVvZJnOLw80niTbQy35QC
         1n/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU419+5BDwzQDKuvp/WsxB9Tsd31nmfxcDnUL7zTnA8UOyhFiR6qLCAH1HYjOXZVUIHczUPL44mX2B660te@vger.kernel.org
X-Gm-Message-State: AOJu0YxLI4OU1t5Tv63un8Vv1SyQCe5toR2XjAco6RHSLwdQQwq1vkcz
	IjSxN97E9YOggH5Drp7kvDL2PS6T9b+O9XvJewWNEx3aD/AZVLyJeK2VweS8CkU0UG5Bz1jfgog
	FfjFa11txU7FN8QzRSCnmz9Re5Cl/tAodM4F7RT/Fcg==
X-Gm-Gg: ASbGnctfNWMJc8SUWgVZ/xmCbkho6fY4ffWlJ1bfsFC41+PrJcHD7fU8sb81SVxBAHP
	pMgEk9IzgJWzK+qELSg4sKPkdjNf96T3GKpppQiYiJ4c5zrCg3oq+hu/Hdz8IXS/pMiTBFWS9jh
	+KHIEmM+oKw+VM8WThah2ZevSzhVZ39RNaR1RDVOUWQ33t7WM6Jbn+7Q59oaNBv40RR4KULrca0
	x2lERKAbeJv3EXW1hiI9Txrhullr7X7Tny9YxfXP0unEN/JsajRIpNjeVLtAaTf3X8sytdN9g==
X-Google-Smtp-Source: AGHT+IGzuMgWcMC8J1gmVuG1jhDodNPDypimmkHMqGMXQSg4mN5gSWlDIvVy/uGasgivb6Qzz8zJvmXNNDc31Qw/A2U=
X-Received: by 2002:ac8:5fd3:0:b0:4b3:4d98:cb39 with SMTP id
 d75a77b69052e-4da481d9806mr253690471cf.9.1759228182235; Tue, 30 Sep 2025
 03:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150070.381990.9068347413538134501.stgit@frogsfrogsfrogs>
 <CAJfpegtW++UjUioZA3XqU3pXBs29ewoUOVys732jsusMo2GBDA@mail.gmail.com>
 <20250923145413.GH8117@frogsfrogsfrogs> <CAJfpegsytZbeQdO3aL+AScJa1Yr8b+_cWxZFqCuJBrV3yaoqNw@mail.gmail.com>
 <20250923205936.GI1587915@frogsfrogsfrogs> <20250923223447.GJ1587915@frogsfrogsfrogs>
 <CAJfpegthiP32O=O5O8eAEjYbY2sAJ1SFA0nS8NGjM85YvWBNuA@mail.gmail.com>
 <20250924175056.GO8117@frogsfrogsfrogs> <CAJfpegsCBnwXY8BcnJkSj0oVjd-gHUAoJFssNjrd3RL_3Dr3Xw@mail.gmail.com>
 <20250924205426.GO1587915@frogsfrogsfrogs>
In-Reply-To: <20250924205426.GO1587915@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 30 Sep 2025 12:29:30 +0200
X-Gm-Features: AS18NWD7FH2ECHsqy--ansfHcFvhFuJl9zxXuoH-_wb_I9ayFnO6DQxvIV2et2o
Message-ID: <CAJfpegshs37-R9HZEba=sPi=YT2bph4WxMDZB3gd9P8sUpTq0w@mail.gmail.com>
Subject: Re: [PATCH 2/8] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net, 
	linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 22:54, Darrick J. Wong <djwong@kernel.org> wrote:

> I think we don't want stuck task warnings because the "stuck" task
> (umount) is not the task that is actually doing the work.

Agreed.

I do wonder why this isn't happening during normal operation.  There
could be multiple explanations:

 - release is async, so this particular case would not trigger the hang warning

 - some other op could be taking a long time to complete (fsync?), but
request_wait_answer() starts with interruptible sleep and falls back
to uninterruptible sleep after a signal is received.  So unless
there's a signal, even a very slow request would fail to trigger the
hang warning.

A more generic solution would be to introduce a mechanism that would
tell the kernel that while the request is taking long, it's not
stalled (e.g. periodic progress reports).

But I also get the feeling that this is not very urgent and possibly
more of a test checkbox than a real life issue.

Thanks,
Miklos

