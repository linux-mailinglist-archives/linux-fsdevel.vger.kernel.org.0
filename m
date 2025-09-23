Return-Path: <linux-fsdevel+bounces-62504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC87B9594E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 13:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E2E3B5169
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD1E321266;
	Tue, 23 Sep 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="P2hYvcYk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03203238C0D
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625918; cv=none; b=lMdlywccrai2bX3qkwGxJwV2FxF8x3FsPXZaI62f2BEC6g7IMGUHgEuQ/DBUeqmcb0UAxMYsVw+VQjbT1PhcsGP0GuHE4XjIP3z2rM7n5uNYzEIGO/7XHhOid8nm4HV1Dqv7Hf0P+tDsVE9YgXKedI/D5E1AaUd1JHXbvp0Cm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625918; c=relaxed/simple;
	bh=b5HQzS/IgzWs3gBrRSR/MIrIrjx8DeV5xFqZ5DRELLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUsQuWO+mHVL1LHlIfHs7368IcFlQ5p7AN4AvRxbtBoFCph9cxDAKmS0YHAqtukA9ap428ZO9ROtgR6tL4AFEPCzv+QG1Zmpng0egdOeEQKz1pT+IHEQ5eR8Ds4rurl4BlY8dIW9FBhg+QP066RcPWPD78nOsTE+flAmzREmylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=P2hYvcYk; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-82884bb66d6so548726585a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758625916; x=1759230716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=flFGmwu4mkO5hSvBsepBDYFlHgAlMxINsB/VP1uSo5I=;
        b=P2hYvcYkjsM9XY7qdZ+2oDWF+2NYKWBMZIeh+Pq5kGhFdBq0N5zpUwKBBsCymlrO1H
         MuTA1puT9KFuvLhQaPwdnxhvyhdJvpZCSSZa/pg9m+IVpfCVu7tNIE//jovjSPKiq658
         CQAcUOfEa0Vy0ONYXfA8envtFVe+3QAb48VrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625916; x=1759230716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flFGmwu4mkO5hSvBsepBDYFlHgAlMxINsB/VP1uSo5I=;
        b=oetsorXdzW4ivM1qO6cPAlsM2hTsqqyMcdEo0LzIOI6IKkzEImUxipPJFpBConOAbs
         z0PN3bniQCWaSRmyuZaNRJuUFxuOVMvSWUDt8sswrIlRwZZ6jinpZWSCwqD/k/ub3Lp3
         ci2UXpPMjwUJnbSwjaXIXLEbTMpFs7W/tM6a4QNX0gF0TANR5MJAFjclaKHBKQY5Cq5C
         B2mbbLRt6eeFzhAzY1ZChtInZlPqyKxP4ym7Muzto8Jv3fX3I4dnVWAcbjRotblNRqrC
         uUeCQnah0nrLaE/QV9f30Vu64RkOL1QC8weeH8wwGmB/S0Khzzh9G8Ly4kbrfBYaM2lt
         thQw==
X-Forwarded-Encrypted: i=1; AJvYcCWrko/+mb3Xm/53b7lyYH/zhHy5Uzn7CfR0PoQoNolczulx1aQOiEggLutHaHGt/dw2Cg7tByEZ++PLnfVa@vger.kernel.org
X-Gm-Message-State: AOJu0YwGC//jxcSXFH+ZrF0NatBrKFpEUu0MD+T6dCcHzwgoLHpXOshV
	gMl8DX71HD/qmgdyXsB6Nr/XYn8ZtIbYxO7Xmc2ez0Vfhx8G0pq8fLrv6wT0rIa0T1N51RwYDAf
	bVDjavA0WBuAOUbUINp3C5+yJNv2caPATxxBwSN4JWA==
X-Gm-Gg: ASbGncvVxRlq7No4dIqPhYVgfREczR9QfsD1vTMTg/HSdv/nMQdifZGoILtjzXBK9+g
	k6gchHEVlTuND2xwSb2EXsQhlUIXrXryGycrqnai3NJKqmsOEZIf7oveTla/v75utfUwq3qK+gY
	JucXMmfDm/g+E/4/0dz1fRMsmH8AQZHOsJRVaxEGOGv10cdAZRJdKvwSGUyYLmCcwSsGcSGmgfr
	70yt1yJhvvfvH+AwHaqToVvOgur79Uo5QPtVN7UrC/Nv2PFhA==
X-Google-Smtp-Source: AGHT+IEWowhMwOrt0EXgg4kdzeYYRV1P1D2GU7iVV+lG8V62/iqczkAt/wdzk3Wlp8WIgnWZa1YX7g2VmSZ7IyBtBXQ=
X-Received: by 2002:a05:620a:458b:b0:82b:4562:ea60 with SMTP id
 af79cd13be357-851af5f4c6dmr207534485a.6.1758625910538; Tue, 23 Sep 2025
 04:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs> <175798150070.381990.9068347413538134501.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150070.381990.9068347413538134501.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Sep 2025 13:11:39 +0200
X-Gm-Features: AS18NWCacoGxINt-x16sxcJyeTVSMahKj4WWFLFSM7p6uh7_e3qHhhx8aZVh8js
Message-ID: <CAJfpegtW++UjUioZA3XqU3pXBs29ewoUOVys732jsusMo2GBDA@mail.gmail.com>
Subject: Re: [PATCH 2/8] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net, 
	linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 02:24, Darrick J. Wong <djwong@kernel.org> wrote:

> +       /*
> +        * Wait for all the events to complete or abort.  Touch the watchdog
> +        * once per second so that we don't trip the hangcheck timer while
> +        * waiting for the fuse server.
> +        */
> +       smp_mb();
> +       while (wait_event_timeout(fc->blocked_waitq,
> +                       !fc->connected || atomic_read(&fc->num_waiting) == 0,
> +                       HZ) == 0)

I applied this patch, but then realized that I don't understand what's
going on here.

Why is this site special?  Should the other waits for server response
be treated like this?

Thanks,
Miklos

