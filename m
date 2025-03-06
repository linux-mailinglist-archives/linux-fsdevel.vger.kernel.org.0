Return-Path: <linux-fsdevel+bounces-43373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1AA55257
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 18:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2A83A214F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 17:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB442561DB;
	Thu,  6 Mar 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TShjYBFw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D313635B;
	Thu,  6 Mar 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280872; cv=none; b=OaMY65GE+yQJmr6RvDZIwOZMChf1LaS0bOxXTJFSmJYSiMbzrGNs/fC/tSVaBnYrNjYtTWpIiiMEaYGVQHUZo27VJyrUTkMRQVgvYMT3kgSdMvgxR1H7jV4aA/qOF+uTW3K+I+HTfksmjiUTaGlEkKKzGO5RbOOK58nINj7bzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280872; c=relaxed/simple;
	bh=WVlAL7+vyUeqzGkfljVYhV2817w30XL876I5kkfUIBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxcVlaVhOkplYzSWDmzxEjKpH8a9/Llce/hXQ/xmhEpzrb2nahUgvTb/iuYVDIUrjD6IGR8alA0GrmabhXFsGXxOoY6v0BnRkFPQBbRmdsDLl9U9tpYBTbLnqtQuWTgEA++N8hQ2ib4vbAXjnk0kdYwXSc26lb9+2feuMW7RVwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TShjYBFw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso1174717a12.1;
        Thu, 06 Mar 2025 09:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741280868; x=1741885668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HD5nOa+XNocJvW4LdGbyMUsLXfp9e+cQyBJglXqFrYU=;
        b=TShjYBFw4PGJEODrY4DuH1S3/H2/yjTpP7P3Q+yOpNf1jdO6B9oo93PlS+L/B5sGjE
         +vPEOts8uQ4MtY2JN4Ke2iW/eXPFqSX9FDLORC0mHZkmn7TA4/uA1IoPy5MLk3W5il+T
         Cb3UNrp6DkGuszdFv0ks3xhEesNWIIVN6hbBR114bMkKWDpoN2DnpDEjb0S9SeOO4QCA
         QyVwUB+JClHy8YUwGWXrhCjNAuuGTPtXd+ih0IuAiLo0/asTcWBEW2OQ1dS9qZQmOrcf
         ITTK10btTDeHV12ZXrYEg/3FWS+Os5w/X0q5iTThbf41vqMotdUzglIyXce9c0hPGhqF
         G7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741280868; x=1741885668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HD5nOa+XNocJvW4LdGbyMUsLXfp9e+cQyBJglXqFrYU=;
        b=tkTYrDHAWbvzi2xB45RzFa824urSJB++5USQnYDNQW44F4mcrQG4JsTgsl0oDXRkvT
         +2dtlEIDqa/Fh4bbn8AU4cu0BdBdOtuWYkAslocgljSco0X9H5XDex3s30Lru1UL15Sk
         tzEydOQG5Gnhwy7SjaufFUwBDox9JijJkcGLdwAxwK4XZB9WSEq27NNo8TzeFd33n4a8
         OlgaJTt2sBsdYk0uvkGiPj0YUlxAvfilfyWHaFQxWqDbYKbzoOdAb0nr9k8Zp/Vuon66
         Ym/MJZy+ALTXVC8SbmlxACKsrWhSK7F8h3q72kZxo1uymAYpODC471w284rX29ORmzCH
         l1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUNsB9fTb6OQBSLKvCLz465sJBpu9QKseUlADi75WhpCNgRxY1Z3hPkA065MomETdXu94CLQT6LMdtu/zNOVgCAdVdWpCgb@vger.kernel.org, AJvYcCVBj3SH9sUkYMimM4XHB4Tw7Xzyw+e8MktlOMWsC4VluEnEg81tpwz/QPXs3mQP+hhHShtgsOGhBosFR6Gf@vger.kernel.org
X-Gm-Message-State: AOJu0YwrejoGvwg5tusj0JYLwhKHPwidmc1nwsUeg0kbK6RZow/RQmS8
	mLLm3mteA/8vz5XKRqNA0OqLeDgy9DHQkQr6t+m6Ddqh93eYlGCkK1qS3R7lIW3wtTTlEerFq15
	rpmkX53NZYUdG/W/uYACypJT8HvSkD20r3LI=
X-Gm-Gg: ASbGncvIozFuGZd/3rY17nIMdov80SS1u+7ogUixSsfRpwRdDDJNCX1gV4UbWSSHNhS
	x600ABYMa3yIeqyp+4vSDxH/KiEdm/j9JD9o/B+qnnDysSs4CumdJGVo1zgbs7BPiHR4PRVQUTV
	h0cAb7Ev9kTUWv4pGslOGDU+6PEA==
X-Google-Smtp-Source: AGHT+IHkryn59wasjQzHOQFGkNwA0EAen023zivbTOObhJm5P0Kc6xN1zN+C6bsQHuxYdMQZKHpuaSjUo5bMEPcZfpU=
X-Received: by 2002:a17:906:d54a:b0:abf:7a26:c46d with SMTP id
 a640c23a62f3a-ac20d92d6a4mr610795266b.26.1741280867940; Thu, 06 Mar 2025
 09:07:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741047969.git.m@maowtm.org> <20250304.Choo7foe2eoj@digikod.net>
 <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org>
In-Reply-To: <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Mar 2025 18:07:35 +0100
X-Gm-Features: AQ5f1Jof1ZJtdxxw3zXzNZBEci-EkbUIziPW7Kllk-J2zfzCeTiwajBKljm2qiI
Message-ID: <CAOQ4uxjz4tGmW3DH3ecBvXEnacQexgM86giXKqoHFGzwzT33bA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
To: Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Jan Kara <jack@suse.cz>, 
	linux-security-module@vger.kernel.org, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 3:57=E2=80=AFAM Tingmao Wang <m@maowtm.org> wrote:
>
> On 3/4/25 19:48, Micka=C3=ABl Sala=C3=BCn wrote:
>
> > Thanks for this RFC, this is very promising!
>
> Hi Micka=C3=ABl - thanks for the prompt review and for your support! I ha=
ve
> read your replies and have some thoughts already, but I kept getting
> distracted by other stuff and so haven't had much chance to express
> them.  I will address some first today and some more over the weekend.
>
> > Another interesting use case is to trace programs and get an
> > unprivileged "permissive" mode to quickly create sandbox policies.
>
> Yes that would also be a good use. I thought of this initially but was
> thinking "I guess you can always do that with audit" but if we have
> landlock supervise maybe that would be an easier thing for tools to
> build upon...?
>
> > As discussed, I was thinking about whether or not it would be possible
> > to use the fanotify interface (e.g. fanotify_init(), fanotify FD...),
> > but looking at your code, I think it would mostly increase complexity.
> > There are also the issue with the Landlock semantic (e.g. access rights=
)
> > which does not map 1:1 to the fanotify one.  A last thing is that
> > fanotify is deeply tied to the VFS.  So, unless someone has a better
> > idea, let's continue with your approach.
>
> That sounds sensible - I will keep going with the current direction of a
> landlock-specific uapi. (happy to revisit should other people have
> suggestions)
>

w.r.t sharing infrastructure with fanotify, I only looked briefly at
your patches
and I have only a vague familiarity with landlock, so I cannot yet form an
opinion whether this is a good idea, but I wanted to give you a few more
data points about fanotify that seem relevant.

1. There is already some intersection of fanotify and audit lsm via the
fanotify_response_info_audit_rule extension for permission
events, so it's kind of a precedent of using fanotify to aid an lsm

2. See this fan_pre_modify-wip branch [1] and specifically commit
  "fanotify: introduce directory entry pre-modify permission events"
I do have an intention to add create/delete/rename permission events.
Note that the new fsnotify hooks are added in to do_ vfs helpers, not very
far from the security_path_ lsm hooks, but not exactly in the same place
because we want to fsnotify hooks to be before taking vfs locks, to allow
listener to write to filesystem from event context.
There are different semantics than just ALLOW/DENY that you need,
therefore, only if we move the security_path_ hooks outside the
vfs locks, our use cases could use the same hooks

3. There is a recent attempt to add BPF filter to fanotify [2]
which is driven among other things from the long standing requirement
to add subtree filtering to fanotify watches.
The challenge with all the attempt to implement a subtree filter so far,
is that adding vfs performance overhead for all the users in the system
is unacceptable.

IIUC, landlock rule set can already express a subtree filter (?),
so it is intriguing to know if there is room for some integration on this
aspect, but my guess is that landlock mostly uses subtree filter
after filtering by specific pids (?), so it can avoid the performance
overhead of a subtree filter on most of the users in the system.

Hope this information is useful.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fan_pre_modify-wip/
[2] https://lore.kernel.org/linux-fsdevel/20241122225958.1775625-1-song@ker=
nel.org/

