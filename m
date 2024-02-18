Return-Path: <linux-fsdevel+bounces-11960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0358B8598B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 19:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E58C1F21E51
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 18:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2D16F09A;
	Sun, 18 Feb 2024 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C9oGqq5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0468225772
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282661; cv=none; b=UEH/naKDBmCJ4If1Mqy8iDuq47+uBzUfiSgJy77AOiy6rTxVLCthEyujvdUFYF77eIDEfkojDswMBqFI+kPJCC/XV8zLKKLmvxZkNPKeAltKk2VtldLLHNZqxAGy4MOdj2iAEivEXXKy/e9J/BAiGgwKKalbuiOedwMcy0Nqz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282661; c=relaxed/simple;
	bh=HR6DGCNY6bn+9T/fDrY/9UnXFxvg9vfvxoHjIu64FLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZ+uIU678tq/8Hxl5Lt0cnJzKSKokeIYNkxAjIvnkPwW5S0+nh10zAvwvFlkOE+l9WEnEyvlJAyvIN5mRFcZjGzxeOM3+OHPU+3myWdJosko3VdKbot9g7q3TIpIabrBt5jk60dTNvoDi5uBw3TcaInqMc27QLwPayV+30aP7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C9oGqq5N; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512acc1a881so652406e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 10:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708282658; x=1708887458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a04AVkJe8owWBXazK51XGY3n2MbPCmXNl0t/6M1f0Pc=;
        b=C9oGqq5NKHWdBn2LyDYMCwlJQNVfBXq1jZLhhAq8UEdJQ4yBEagnEDtYVyQhBnuIHx
         dXYwgQh8nE0Wg+yDQRrNd2v09fbkK5KqIIWcUjQTmxV29jM4I4KLg0OTuMkzss34FL0l
         AQynqIuQRnWFdjDGLVXcXkQL4Sn/4RNtaywuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708282658; x=1708887458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a04AVkJe8owWBXazK51XGY3n2MbPCmXNl0t/6M1f0Pc=;
        b=tC0fKvrpUDs5DUtqegCqN5XlW5slX6W6BKk8UpSMf00SB/Od8zkvimc8E397SeihmM
         q4Qt0xjJZPNe/aDynKRiqlptM12A24wZve1DZ0lE/Pa/Uu87trZW3Ua/oz8S7IJEaGGJ
         7QRalmLVCPiGy/ZvhqxQPMjk8zjuiy+sarNapjTFecdJImTSxhruf5xQqBxgVO8/0pM/
         3S1UCaWSPZjuKH+KrIQG8rVIqs+M3SJPIdOxb1MMX+O581h2k5JxwoW2AVE9zK5HId7c
         BXNeFryOYVVbnFeEZ4Wj2/rouL+ng0qpb5+9OjMvlEZlWibbvDH5+aZ6JCI4rpATNPy6
         IAHg==
X-Forwarded-Encrypted: i=1; AJvYcCWz+ZeoPwfF+DbRaP2IsK8lU5ZKqle21MOZgijzFWSKXnEub3hprB0tdPqrOswo3JhctbD246d/fz0zPhpi5Aq8AdUF37x0F6w+TMLw6Q==
X-Gm-Message-State: AOJu0Ywm0BfSeicg3aukfH50GEvqWkAnho+Rqj8OGQGPCJ2scCqLUPPE
	Y354tmsgJYzl9WrXge4oygNw5FzQo9iEcql1lMTvw4Mi3YdGObrSgEvGQH3gSVcZYMKV6wX4Nyb
	wwzs=
X-Google-Smtp-Source: AGHT+IFucjUKwTNIRrX5ZysueiHj2Md/UXbBY+gu5ygC8kEFDlEgHV/QQI0X8YLHVFkQZK8ni8C+SA==
X-Received: by 2002:a05:6512:3d24:b0:512:ae18:74a1 with SMTP id d36-20020a0565123d2400b00512ae1874a1mr1496082lfv.11.1708282657989;
        Sun, 18 Feb 2024 10:57:37 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651204c900b005119fdbac87sm618528lfq.289.2024.02.18.10.57.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 10:57:37 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50eac018059so5293022e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 10:57:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXj3DYT2UO65hEw+dfm+OLElVOjeFnwvKjRo6yRQl4VJEDKnjsblerQB6ZD2YXV14RdC8hX3vgWH/7nqEHItZx8+pxzyXM1yT9vGOvzNQ==
X-Received: by 2002:a05:6512:4020:b0:512:9e58:b1ad with SMTP id
 br32-20020a056512402000b005129e58b1admr4151398lfb.57.1708282656569; Sun, 18
 Feb 2024 10:57:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner> <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner> <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com> <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
 <20240218-gremien-kitzeln-761dc0cdc80c@brauner> <20240218-anomalie-hissen-295c5228d16b@brauner>
 <20240218-neufahrzeuge-brauhaus-fb0eb6459771@brauner> <CAHk-=wgSjKuYHXd56nJNmcW3ECQR4=a5_14jQiUswuZje+XF_Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgSjKuYHXd56nJNmcW3ECQR4=a5_14jQiUswuZje+XF_Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 18 Feb 2024 10:57:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtLF5Z5=15-LKAczWm=-tUjHO+Bpf7WjBG+UU3s=fEQw@mail.gmail.com>
Message-ID: <CAHk-=wgtLF5Z5=15-LKAczWm=-tUjHO+Bpf7WjBG+UU3s=fEQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Feb 2024 at 10:08, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The only ugliness I see is the one that comes from the original code -
> I'm not thrilled about the "return -EAGAIN" part, and I think that if
> we found a previously stashed entry after all, we should loop.
>
> But I think that whole horror comes from a fear of an endless loop
> when the dentry is marked dead, and another CPU still sees the old
> value (so you can't re-use it, and yet it's not NULL).

Actually, I think this is fairly easily fixable, but let's fix it
*after* you've done your cleanups.

The eventual fix is fairly simple: allow installing a new dentry not
just as a replacement for a previous NULL dentry, but also replacing a
previous dead dentry.

That requires just two simple changes:

 - the ->d_prune() callback should no longer just blindly set the
stashed value to NULL, it would do

        // Somebody could have re-used our stash as the dentry
        // died, so we only NULL it out of if matches our pruned one
        cmpxchg(&stashed, dentry, NULL);

 - when installing, instead of doing

        if (cmpxchg(&stashed, NULL, dentry) .. FAIL ..

   we'd loop with something like this:

        guard(rcu)();
        for (;;) {
                struct dentry *old;

                // Assume any old dentry was cleared out
                old = cmpxchg(&stashed, NULL, dentry);
                if (likely(!old))
                        break;

                // Maybe somebody else installed a good dentry
                // .. so release ours and use the new one
                if (lockref_get_not_dead(&old->d_lockref)) {
                        d_delete(dentry);
                        dput(dentry);
                        return old;
                }

                // There's an old dead dentry there, try to take it over
                if (likely(try_cmpxchg(&stashed, old, dentry)))
                        break;

                // Ooops, that failed, to back and try again
                cpu_relax();
        }

        // We successfully installed our dentry
        // as the new stashed one
        return dentry;

which really isn't doesn't look that complicated (note the RCU guard
as a way to make sure this all runs RCU-locked without needing to
worry about the unlock sequence).

Note: your initial optimistic "get_stashed_dentry()" stays exactly as
it is. The above loop is just for the "oh, we didn't trivially re-use
an old dentry, so now we need to allocate a new one and install it"
case.

Anyway, the above is written just in the MUA, there's no testing of
the above, and again - I think this should be done *after* you've done
the cleanups of the current code. But I think it would clarify the odd
race condition with an old dentry dying just as a new one is created,
and make sure there isn't some -EAGAIN case that people need to worry
about.

Because either we can re-use the old one, or there isn't an old one,
or we find a dead one that can't be reused but can just be replaced.

Fairly straightforward, no?

               Linus

