Return-Path: <linux-fsdevel+bounces-42453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2458A427DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 17:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EADF3B9B93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D4D263F28;
	Mon, 24 Feb 2025 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YD8RJopM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9B18B46C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414261; cv=none; b=aNQ2AeGzYHINIqFZYOaYa3D637rY2XxNgd6UQ6y7d9DoHCpUnR0cVcRzrPRGtsFT8CQ3KOGoXB44o7F0W02ltPIMo0F/llrwgm8Ng65IP4zKTDfu4xtj34OiVMSNPMZc0rIVBksdtrOmOYucJwR9lKpTpcYTYvRL1NKd8RnuprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414261; c=relaxed/simple;
	bh=f9fqrDm4f4P/5LiKN/iY17TSZ6PnstGOuVc0Ti0nO7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKFM+XJwlFAK/vvMEdk+r+Qvl2JvqutpaKMwEFUB7Uj3wVblVr31MhViAbaydfZ9Jyr3mnxnKBDRDMZtpMK8qb6OTdMQpHAFEkFxVtLZfVamzcGogtesirlTUT2TrCy8Tofkn0edz2mvxoB4B4YAse4qot5oOGe3QiyKnVyVyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=YD8RJopM; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-472003f8c47so42482751cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 08:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740414259; x=1741019059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=35lyu+6zyP8UnNWENXatfW2M13RT1ggpz1uxSE8VHmI=;
        b=YD8RJopM2Tk4qcc7ZhFkJdqsnUISOWOOEXznjVIIDqfY022w3NmduMRcK7dvJ4wERu
         qoeIiLFehhbqjzeqEWWNa+g3I/06tm6wUFLCUKpuYyC6+LN0UUFqE+Elpx++RQRRRrwd
         xFgd4Zsv5FMnyU//Im/z+NVQnn8uzbkKL/9Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414259; x=1741019059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35lyu+6zyP8UnNWENXatfW2M13RT1ggpz1uxSE8VHmI=;
        b=rebXoxnzwXm0W+PklUg8D6KWoCzLM7lPld30omnRoLyG+JjAINVf+fmpO1Fqj0hSjS
         cqTMWwbuhyS0MGOC7t88/ObJJyRw6rEsMkUAWXvV0B0/+wxh31/V2SRZtV0PjNTj4405
         4ytkyHhy426kukBMHYqsEn13dUGCcHgssBh3fcjud+Ml1dil8PkHYNNt8Sc2dgG7P5LN
         Fn66m6S34wdf1ce69GxVJWdcrzaqH7ujHRnNew828hqhQw5ZxAZE47VuWLKF5gmDkwci
         meCti2rfKqHyGBTQyVQw9o65yo38KiGX9CvNNhUJ4nlPuJ47psZ2OBiIc4A9i+3C/mrO
         dfxg==
X-Forwarded-Encrypted: i=1; AJvYcCV4FqLlH+YkFI9OO2EP/ymxZRUDng+OodfowJXLonZrLXog1f5a1Tuvw5YJ3URj4DjliIValLOgfPvmQLtF@vger.kernel.org
X-Gm-Message-State: AOJu0YyB61ECrawEgq+z/E82JizAYeDOTUdppuQXXi5EJfMkgMuU+eyy
	jfL5zy/O4yrnQ1UA9wM5ebEr0vzamw/Rm7+SoneegMJtIWKMoSar0VaXazTki6GPXgtIx9aV8S2
	PK6v7GvCqWpovt+AQ7k6i0+drL2wDjLmYzYKX1A==
X-Gm-Gg: ASbGncubOQ/LSJfeV8ihdIdW81XYOSYgnHM+PGOMnw07nQYasyY8T6CQsdjcZAOZ6eO
	piN1enUvCjELB/XR7xj3mfe6Puo+zBm6aZAaAIB9ztE2Luu1/YQkR7YlyV26hDw/z31QK+oSOLf
	IJXN/js7gK
X-Google-Smtp-Source: AGHT+IE6Ky9EEBFBIPfIG0tubUoMa5hcfqB32/Gfh0yagcinnaME1gRLzoVpVDxXuSsCd6YeSm2PCMrBg8mPoK8nMt8=
X-Received: by 2002:ac8:584b:0:b0:471:fadb:9d41 with SMTP id
 d75a77b69052e-472151469e1mr241920671cf.17.1740414259165; Mon, 24 Feb 2025
 08:24:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKXrOwbkMUo9KJd7wHjcFzJieTFj6NPWPp0vD_SgdS3h33Wdsg@mail.gmail.com>
 <db432e5b-fc90-487e-b261-7771766c56cb@bsbernd.com> <e0019be0-1167-4024-8268-e320fee4bc50@gmail.com>
 <CAOQ4uxiVvc6i+5bV1PDMcvS8bALFdp86i==+ZQAAfxKY6AjGiQ@mail.gmail.com>
 <a8af0bfc-d739-49aa-ac3f-4f928741fb7a@bsbernd.com> <CAOQ4uxiSkLwPL3YLqmYHMqBStGFm7xxVLjD2+NwyyyzFpj3hFQ@mail.gmail.com>
 <2d9f56ae-7344-4f82-b5da-61522543ef4f@bsbernd.com> <CAOQ4uxjhi_0f4y5DgrQr+H01j4N7d4VRv3vNidfNYy-cP8TS4g@mail.gmail.com>
 <CAJfpegv=3=rfxPDTP3HhWDcVJZrb_+ti7zyMrABYvX1w668XqQ@mail.gmail.com> <8e0597b9-d8a9-4d11-8209-ab0f41e94799@gmail.com>
In-Reply-To: <8e0597b9-d8a9-4d11-8209-ab0f41e94799@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Feb 2025 17:24:08 +0100
X-Gm-Features: AWEUYZkAGcL0DMXQBzs_mCpbBAb7pYa17NFtHVcfAECQBfKcOzw6NACtoHMfTvY
Message-ID: <CAJfpegtpBxXk+bJJgXWT8moqTD07DHEdufdNWy51ac9RDUVYdw@mail.gmail.com>
Subject: Re: [PATCH] Fuse: Add backing file support for uring_cmd
To: Moinak Bhattacharyya <moinakb001@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 17:06, Moinak Bhattacharyya <moinakb001@gmail.com> wrote:

> Thia would require a major version tick as we can't mantain back compat,
> unless I'm mistaken? If this is the track we want to take, I'm happy to
> send out another patchset with such a change. Would also need more
> extensive hooking into core FUSE request code.

I thought we were discussing backing file for FUSE_LOOKUP?  It doesn't
exist yet, so no backward compat issues.

Thanks,
Miklos

