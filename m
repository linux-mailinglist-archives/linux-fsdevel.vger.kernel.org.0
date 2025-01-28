Return-Path: <linux-fsdevel+bounces-40231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF12A20B59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 14:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4750E3A66AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8BA1A83EF;
	Tue, 28 Jan 2025 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BM/I/aVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072981A2567
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738071434; cv=none; b=YlG8gZPR+k/Ukkcij+MfXOZW/KPYzbKdrmkABIHvazwqmxYuHcZA6Okmy/Ncd/siowXfVNU/cYQySDg51LsZKoE8BVlLI6iy9QqWg7vCH2ID8qjH1jzJea73cULp+82LHiIrwxxs9lbO5ZPyi0QYV3W15xQVVcLPFpJNcHgt9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738071434; c=relaxed/simple;
	bh=za4jWSIXiWnx1/PtIdrlQUWfgRWi88/FEbsBClDq++Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbOl1s3n/i92pAuw1mNcs3q1Kzb2d9khNgR3Wt9SZDySsg8VmeH6GxVTRKfprIRcRPSpviCQRUKgzJat0Ya3lnvrHH141feKbL1ocvibLopGeb71g5zAocHejP1HSzR7MzlZA033eRDGMbUkz11gE462I1fN25gDEzAapx+phAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BM/I/aVo; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46df3fc7176so51169731cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 05:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738071432; x=1738676232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cEBqaIaDwYzpAfJb0Xza7F8apQH4HtqaJ+JjUwM8mEQ=;
        b=BM/I/aVopvQmXAAU9Lx1lLYfIsFez4u45iXCOilKTl7APoK/QCR33ZVougxbmZ2gci
         TW171voLB67P7eFXO54deYTFS2jCJ+VRUj7eNV1ZJS2fV++Ldaw73t7+w1eywC/EUeKm
         eH/YKXNOz+nYR/rWsYV+53sm75gtKTIAmL3PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738071432; x=1738676232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEBqaIaDwYzpAfJb0Xza7F8apQH4HtqaJ+JjUwM8mEQ=;
        b=kYJfUvgl+Nv3sISnYP5mXNb5rwUVzBv58t0BFzsjlKhGHCA100yJwoVVaW9FfmQlmb
         rss3JQJESca5PnAjZe+RI7FPJnuqUicn227jIVqZT8XUYonIGem05tALKeT2rcx17sJ5
         PbuOXhF6m+8a4kAdFGl1Fe7YrwG1WKZg0CsC9rmcYlLDge+YEDOdl4JfCp53P6fI0goj
         lqF5XflH+5Tp4Dben5p2OE2cZVaZKNH2ZCiY1beuPSd6HuwjiRVKycfSCvt7jykfySqS
         DQ2PValpZScATfzTuRy9u8/ukcjjcqdM/mYFsHziac7ZpejWUZ4e8ZoFXadM6V2XfHEh
         4Psg==
X-Forwarded-Encrypted: i=1; AJvYcCWSQWEZfJfBqKkQLjo2VIAHL5KTwM6FKK19YFawcerHVS2kQVqrkbnpjqzDYtrGi3La6TM75w2s+/kbl6ng@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1riL79I4lfxlD4fd+QcPh60wWO9uRxSAleYTEs6bzyzMQRlsP
	vi2QYzv4FYDSL3b3VUNuOJQ7neobbTilvfxqUCtveesxrHh0qPyZ+n4swrWsnDNS3Y3873MgkYQ
	CCY8g2WujIqQfNjcMqB5/HgQa963fhTlDiUCQEg==
X-Gm-Gg: ASbGnctIdgQepf7G5ybcaPuJg5XtTnkln2HSOCF/LAjDdLcfc6VnQRRcFZXK0kaiSDA
	aATIfo6Oqbjm3jUEY42bpnb0Y6kAOLpmb1QJDFMd6POipIa8gKOvs2D4Yt7u5ts1+gLkKm3c=
X-Google-Smtp-Source: AGHT+IFWTIAnK+5eL7HyrGG7lpTg04Tgrx5YKQ2A5MNEXhLez1EsL/JNf1CxyLCjHr2w2Q9lyVqeWMCdUDReSZN1y/4=
X-Received: by 2002:a05:622a:1311:b0:467:5eb6:5153 with SMTP id
 d75a77b69052e-46e12a3f746mr729277911cf.19.1738071431912; Tue, 28 Jan 2025
 05:37:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123194108.1025273-1-mszeredi@redhat.com> <20250123194108.1025273-3-mszeredi@redhat.com>
 <CAHC9VhRzRqhXxcrv3ROChToFf4xX2Tdo--q-eMAc=KcUb=xb_w@mail.gmail.com>
 <2041942.usQuhbGJ8B@xev> <CAJfpegsKWitBYVRSjWO6O_uO-qmnG88Wko2-O+zogvAjZ9CCxA@mail.gmail.com>
In-Reply-To: <CAJfpegsKWitBYVRSjWO6O_uO-qmnG88Wko2-O+zogvAjZ9CCxA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 Jan 2025 14:37:00 +0100
X-Gm-Features: AWEUYZmizeJU0a7RXrBJlqhjTqK1mNWtSBDQH9Nt1-ZaM-h_jUVyMC5_wxbnhOg
Message-ID: <CAJfpegs7n5eO6yOms+_TqeXGrN=OaJbjRB9qVm4VsW7JpWG5Xg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] fanotify: notify on mount attach and detach
To: russell@coker.com.au
Cc: Miklos Szeredi <mszeredi@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jan 2025 at 13:42, Miklos Szeredi <miklos@szeredi.hu> wrote:

> fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_MOUNT,  FAN_OPEN,
> AT_FDCWD, "/proc/self/ns/mnt");

Sorry, this should have been:

1)
fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_MNTNS, FAN_MNT_ATTACH |
FAN_MNT_DETACH, AT_FDCWD, "/proc/self/ns/mnt");

This notifies on mount and unmount events in the current mount namespace.

