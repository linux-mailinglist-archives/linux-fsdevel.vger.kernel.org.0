Return-Path: <linux-fsdevel+bounces-34678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5919C79E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98C8B380CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C861FF7C6;
	Wed, 13 Nov 2024 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XsocD30/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531070829
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517075; cv=none; b=hCXT8LotaASvA4xtiylD8ZYU1IqznQkqK4V57WufUxJgbgbsYNagxjf5k/KCykMDkOjnKILd41/71g44+bU3LQBEnIHBOgYJETZkHETKFFdjsQNILV+uhibOodLbIcpq87KoXfEkfOL4GvtSQhnyKIoMP4t3gMXMpHEBolMjfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517075; c=relaxed/simple;
	bh=csPBoYSDByNBHf+k5gUPUX7+wR76Q1hEBFh0oJb/HtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=to+fYELMkN+8AQla6DgOako3OkulW640KE70mldbul0E4ar1Hl1gP35rVmLKvs/Dx5fnyLxUD+znAtNvLHazsU7xVz/968J5dSOk3MFsjmcJk20+eV5sQHVoTpkZQzErxZ6PnKN6N1O1PQlEBgSt51lLfU1UpIIu3zro7LrsueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XsocD30/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cf6f7ee970so1034955a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731517072; x=1732121872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r6dKI9I0XiNa6P0LadyJEAqhNHGcRQ6Z3i6i70GfR1Y=;
        b=XsocD30/gXul2vROh5Ys/l609H69kF00w7ADaURIHXGD2wnw+esQzMhYoLpPUNux1E
         enpgwxayRyyogPs5s0BfTt4louTe7d2f64Fs7nPY/zaEBDf8mHLPx3b/3tIkSuvLY02i
         HEoA0zTwcH3VjX7zxw3Pp+HS25XsCpSdpgnkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517072; x=1732121872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6dKI9I0XiNa6P0LadyJEAqhNHGcRQ6Z3i6i70GfR1Y=;
        b=ba8iwTZETsWz3vzODm7qgLK2S+knqy2IvqvUAsuzwA3JI2bj/uZvgyi9nUXFbEVmNd
         VpfB+k4ujDa9NtibkgNJEtZjC63jZqzqWqBU7iUICCbHGbCZR2qxgYYVQaaHn/gXuh9m
         eoxzcvyNIj+xfKs3Hr1bQO/7A1wtktEXPax7NoO9hLQKB2LRrgKoHlZLg2WecfkVtXYb
         ihS02e/H6hXlQ2U856rhcWKkqFekfB9+7sqSZtNyhClj+tKou5HfPxhhANXaeUsaOhOZ
         fCeATOSTXPHvuJhqPBGILMinh0S3PGGtxK83lS3f36pe6LzXQGVcpL6jsFSLrHgF28dr
         m/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU6dENXek08pmgoLw7tkCIAyGAmUroSbtqxsp9MdSH0V0noCeyun4SkRepb9sUTC1yrHTEPWM74+0MTsbhs@vger.kernel.org
X-Gm-Message-State: AOJu0YycXa0Z+6DtqQQCX0aZWRfFtktH08jGqL9GglDa1/ERn2SPRaYJ
	ZDp2+ux/QlQIO+y9cZUrVsrY+ICR946PBegjhclyLrSmHJPPEMPrQY0sZh+Va1lRztoLM1yy8oy
	qIyXZsg==
X-Google-Smtp-Source: AGHT+IHuXJJj/kgKfaxBGVZr8lk1xBYKf2zcqGv3vs4cplnKe8z6xJx9M8mtnKtFzsCoT4rn0XWEPw==
X-Received: by 2002:a05:6402:b55:b0:5ce:cfef:1d08 with SMTP id 4fb4d7f45d1cf-5cf4f3c0ba4mr4604717a12.32.1731517072185;
        Wed, 13 Nov 2024 08:57:52 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7d957sm7333048a12.87.2024.11.13.08.57.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:57:51 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so643084466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 08:57:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzAR64YAH3f/F9tINzh7YLgNpnGzpP7lfv+OdIVq4joF48526qQHcOWz8A5zVunGOJP8gKKUOl7xaHvZDt@vger.kernel.org
X-Received: by 2002:a17:906:7308:b0:a9a:3718:6d6 with SMTP id
 a640c23a62f3a-aa1c57ffee4mr725890666b.58.1731517070805; Wed, 13 Nov 2024
 08:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com> <CAOQ4uxjob2qKk4MRqPeNtbhfdSfP0VO-R5VWw0txMCGLwJ-Z1g@mail.gmail.com>
In-Reply-To: <CAOQ4uxjob2qKk4MRqPeNtbhfdSfP0VO-R5VWw0txMCGLwJ-Z1g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Nov 2024 08:57:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigQ0ew96Yv29tJUrUKBZRC-x=fDjCTQ7gc4yPys2Ngrw@mail.gmail.com>
Message-ID: <CAHk-=wigQ0ew96Yv29tJUrUKBZRC-x=fDjCTQ7gc4yPys2Ngrw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 16:06, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Maybe I could use just this one bit, but together with the existing
> FMODE_NONOTIFY bit, I get 4 modes, which correspond to the
> highest watching priority:

So you'd use two bits, but one of those would re-use the existing
FMODE_NONOTIFY? That sounds perfectly fine to me.

             Linus

