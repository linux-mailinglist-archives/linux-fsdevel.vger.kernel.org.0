Return-Path: <linux-fsdevel+bounces-9267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF45683FA54
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 23:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F587281235
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE993C49A;
	Sun, 28 Jan 2024 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g4U0LJc4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390513C49D
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706480768; cv=none; b=VzlMhFNDDcDLr1xbrMjA4Q21wDVHi4Ef56OQGX60uaUprrl5Y9UDIC/YrDilzqbFHuGC3UhJG/YJ+EHmIxRH6abilqTtiLKZ1YdIqSToeT3ckiFc/UWX1ClIeyigoU1/P568F4JEKI9EURqp03VntZ8SaYtSFBH8c9NSO4tTJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706480768; c=relaxed/simple;
	bh=j+se+h8m73lMZ5bO5OVB41iLFrTcnxKO4rHbaHCahqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMnauhq6x0M9Y35B+tSg0U77HnH6ad8+oSfVYSgWUx+q8dBZIG7NxYRtrAHrHP6yDY/YqA+KFld9Wne8TVGYjeK09M5ze1qYj/wq9JF1kTRlgu2dWHactP5GPGU7cHzl/GX7bydXCkwdyBlUlYJglEk6HIA2o3C/Xvyppf6b9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g4U0LJc4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51109060d6aso928257e87.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706480764; x=1707085564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HN/bf1OB33r34YH/RajJRYZVQ8GWrEHQI2/Udp84+Ew=;
        b=g4U0LJc4ul/Fu5yynhmBw8s858TUraXbOKdAPTPpfl1QbihNcQ6IQ5XvJLNv9VIIW5
         vfKVuH8vR3EZz1lIzvsx1DpQKm9BaF7PekpPL129CIScYbSv2UPRL6xXN2CYPSHLHyI/
         YTdvaxyfoRQte2wH4/6fGxtM5kfX0lpd+ahFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706480764; x=1707085564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HN/bf1OB33r34YH/RajJRYZVQ8GWrEHQI2/Udp84+Ew=;
        b=n+uxOGDBSrV0tTAX2AUjQt8+4DQU2kMyIORp4nhjKXZhoH2XV8VkWfd8NAZ+1htv39
         221kz69TEj7lfhSnbpVDbKzp60o2+50r41A6CwgdcSiBJpOYk2utrwwT5wsW1zjpllPN
         BVyG0W9RVWShSAHGTcUXrhEufb8xRINr1GM6mPlqViBpoUy6HXFsVrEVBQQTZKpmpvyJ
         wr7RYoep4XKl7/yT0B2QmFHIqIaaV5n+7rsaIaD+FlyGAAhfirziQKQRi+AjANPT5mas
         TclPinFyeuJ1EPoVLBbe6qPskOgKxzWYn5t1x6upUeVsH5j4tftNAOHQDRWQ8gnhtBl0
         7qvw==
X-Gm-Message-State: AOJu0YyYDKGWi6xnUzOn5Rpzw4VweMWT97QkkJbl6HJmg5d8HNCTPg5i
	B58z/H0uRAbNj4SvysTPsP81EYQo8udb6fSR9pn4SJj75PHhFQImzyaaDVYmx58FZTrPERa2PNl
	Xo/VDVQ==
X-Google-Smtp-Source: AGHT+IHEg7cpt6Q+Tm0ioE18lx4o/4nJs8fym7HUoziIxoku1H5Co4kyfU8kJc9xV0iuQ+ZwJ+3JYg==
X-Received: by 2002:a05:6512:1281:b0:511:f4c:8ab0 with SMTP id u1-20020a056512128100b005110f4c8ab0mr1157785lfs.50.1706480764076;
        Sun, 28 Jan 2024 14:26:04 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id ti10-20020a170907c20a00b00a35b4edb266sm474249ejc.87.2024.01.28.14.26.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 14:26:02 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso73584a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 14:26:02 -0800 (PST)
X-Received: by 2002:a05:6402:3137:b0:55e:b30c:e0db with SMTP id
 dd23-20020a056402313700b0055eb30ce0dbmr2586779edb.35.1706480762366; Sun, 28
 Jan 2024 14:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
 <20240128151542.6efa2118@rorschach.local.home> <CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
 <20240128161935.417d36b3@rorschach.local.home> <CAHk-=whYOKXjrv_zMZ10=JjrPewwc81Y3AXg+uA5g1GXFBHabg@mail.gmail.com>
 <CAHk-=whJ56_YdH-hqgAuV5WkS0r3Tq2CFX+AQGJXGxrihOLb_Q@mail.gmail.com> <20240128171733.2ba41226@rorschach.local.home>
In-Reply-To: <20240128171733.2ba41226@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 14:25:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjc4ieo09KxdUBNXHPB5+LD8XeqhmRVnqf2k8EAx3ZCaw@mail.gmail.com>
Message-ID: <CAHk-=wjc4ieo09KxdUBNXHPB5+LD8XeqhmRVnqf2k8EAx3ZCaw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 14:17, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The original code just used the mutex, but then we were hitting
> deadlocks because we used the mutex in the iput() logic. But this could
> have been due to the readdir logic causing the deadlocks.

I agree that it's likely that the readdir logic caused the deadlocks
on the eventfs_mutex, but at the same time it really does tend to be a
good idea to drop any locks when dealing with readdir().

The issue with the readdir iterator is that it needs to access user
space memory for every dirent it fills in, and any time you hold a
lock across a user space access, you are now opening yourself up to
having the lock have really long hold times. It's basically a great
way to cauise a mini-DoS.

And even if you now can do without the mutex in the release paths etc
by just using refcounts, and even if you thus get rid of the deadlock
itself, it's typically a very good idea to have the 'iterate_shared()'
function drop all locks before writing to user space.

The same is obviously true of 'read()' etc that also writes to user
space, but you tend to see the issue much more with the readdir code,
because it iterates over all these small things, and readdir()
typically wants the lock more too (because there's all that directory
metadata).

So dropping the lock might not be something you *have* to do in
iterate_shared, but it's often a good idea.

But dropping the lock also doesn't tend to be a big problem, if you
just have refcounted data structures. Sure, the data might change
(because you dropped the lock), but at least the data structure itself
is still there when you get the lock, so at most it might be a "I will
need to re-check that the entry hasn't been removed" kind of thing.

                 Linus

