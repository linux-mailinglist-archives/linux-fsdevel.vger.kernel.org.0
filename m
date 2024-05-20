Return-Path: <linux-fsdevel+bounces-19833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5118CA2DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 21:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64FF2820D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E7B13848D;
	Mon, 20 May 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YnRE3DgM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7348C06
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234427; cv=none; b=uRgldTleKPH2UMzr8IdrGZcLowyL8LVf8B72xNSwaRteUCA/SCgDy0eVff9Xfz89XesthJcBvgL5VfEU4zkIXW1b4YJFRDO2iOwxrXfUOrxAXiUHYUVp6RtRLCcGueIXWCEJbBDjM5BXiDkEXkLeKbzgUsgr99fO85NrG93SPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234427; c=relaxed/simple;
	bh=hyEqnKpH9ZE+r+RPB7m3q/7FOQLjm6iwtXlcrHSQymM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRY/TPYu30dl0GU9tqntTiwLeEc5nwg45gAoxT62VB7l26l2sJvaDa53b73B/vok8bZGIKnYnUZMzxIWFQKunVap4gwVF4XSnoYfNsUbned67lZW8IkL2sRuDe/QhMgHgVG5jcgduRU9DSasePy3cl//DxEoHnAerUx5cn9rqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YnRE3DgM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso56169921fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 12:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716234423; x=1716839223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ6efrGjmgYaeIkGPRWO0fHPe/4SGOBoxXlwYTBzSZs=;
        b=YnRE3DgMt8OIuJKxVIWYbqtRyoPJ7wIflJvp/P3vO9/U1xgfcnod1hQfA8/5FJI47O
         BWmd74kIdHp/0cNMhsKW2Fc70AzRxDAbju8L8HBuA9xzjAQjB1rM+fIiqet9t64GUf4z
         jZyEgETQ12r1zyqAtDfIa6loPkG7kl6NmIXXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716234423; x=1716839223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQ6efrGjmgYaeIkGPRWO0fHPe/4SGOBoxXlwYTBzSZs=;
        b=F14WLKS6qscagnGFRaQ7D6W28wyryKwtmcySzDLTaXne3ya4VKqRDkrjT2MOaYdG8R
         Y3Tsdmivcqu7UJQadeTV37ovo6G4DYM2Q5x1FhV/ZWvIOnzwxbJunMz04HKvii/DF0IU
         Xi8yc4Y+mM2IwAtDuUoT8Ldr6PdLvDRLL87nwo5Cmgv9LgDiy1nunWEUaEKlfpb+Gbq7
         Hse2GftztKiDPxixTd4MlszN1U2xJ0BpgveHwqklB0PjKzQ2h8NdE/60uEHN0fcm5L4x
         6tnSNEUy8gVajCnOtqT50ft78FKc41NLC5w3H2vEZeRLTEGgjdF3FPgvYV2j2HkviFH4
         uXaA==
X-Gm-Message-State: AOJu0YxXUNk9E9UJEBjClvlz/GG+YgYptBU28aVEix4q4tvv0Mvu9CNH
	HHWv5vUZdqMkaXnRT297NHV70B/4tr1ZDqj+2/nz3cfHkaHdKN+xDV7hkER0dT/SgUHqs5O+4/4
	JTEcS2A==
X-Google-Smtp-Source: AGHT+IFHHvhWwBInf5y/T5CdCu9TFeUxyh3vZxmVSS5gttaNzO5jwNJ1RsODB6jiXzpl3ZndFiyt2A==
X-Received: by 2002:a2e:9d91:0:b0:2e6:935f:b6d3 with SMTP id 38308e7fff4ca-2e6935fbcd5mr204727591fa.14.1716234422881;
        Mon, 20 May 2024 12:47:02 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e678552f89sm26023241fa.107.2024.05.20.12.47.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 12:47:02 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51ffff16400so7538936e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 12:47:02 -0700 (PDT)
X-Received: by 2002:a05:6512:1392:b0:522:32d1:d0e with SMTP id
 2adb3069b0e04-52232d10ed6mr28657122e87.67.1716234421850; Mon, 20 May 2024
 12:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520112239.pz35myprqju2gzo6@quack3>
In-Reply-To: <20240520112239.pz35myprqju2gzo6@quack3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 May 2024 12:46:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPmdZS5sNE3k4CUYOu79kE88VsfW0hyMBkVE9Wk-UjZw@mail.gmail.com>
Message-ID: <CAHk-=whPmdZS5sNE3k4CUYOu79kE88VsfW0hyMBkVE9Wk-UjZw@mail.gmail.com>
Subject: Re: [GIT PULL] fsnotify changes for 6.10-rc1
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 04:22, Jan Kara <jack@suse.cz> wrote:
>
>   * A few small cleanups

This IS NOT A CLEANUP! It's a huge mistake:

> Nikita Kiryushin (1):
>       fanotify: remove unneeded sub-zero check for unsigned value

The old code did

    WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);

and that is very legible and very understandable to humans.

The new code is

    WARN_ON_ONCE(len >= FANOTIFY_EVENT_ALIGN);

and now a human that reads that line needs to go back and check what
the type of 'len' is to notice that it's unsigned. It is not at all
clear from the context, and the declaration of 'len' is literally 80
lines up. Not very close at all, in other words.

And a compiler doesn't care. A compiler will know the type, and not
generate pointless code.

So this kind of change SHOULD NOT BE DONE. This was making the code
less legible for no good reason.

The reason for this change is quoted as

    Found by Linux Verification Center (linuxtesting.org) with SVACE.

and honestly, that only means that linuxtesting.org is actively
detrimental, and whatever "SVACE" is is just incompetent garbage.

Please stop accepting these kinds of patches.

I have done this pull, but I reverted that damage.

                                   Linus

