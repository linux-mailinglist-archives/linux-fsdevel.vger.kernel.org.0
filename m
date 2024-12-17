Return-Path: <linux-fsdevel+bounces-37648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3911A9F5111
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 17:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E89A188D90F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3295B1F6674;
	Tue, 17 Dec 2024 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJtdd9Wh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55072149C54
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453100; cv=none; b=W9xF86uBQrvULOlZZzNg5m8jctiX86l8Ec7q78ARlZGXON2/olr1z3avN9YEjIs8GGFCxydVcBkG59kz+ig5w3yP1cnyGqwISwXIcLvynQnaBTUQTW1QLT+9MR5ckB6hB1A/t31FvHBDBYg44AlP4B9m3/3CCHP+TGV/w8jmPF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453100; c=relaxed/simple;
	bh=6NK+z3FpBQ4dkU1zWgFEJ2Zy0a5kaq2ol65YQrQVycM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTBI36rgb8naQRUjeOsGdZv8cbo78PH6rLrEGFOGOVh3bBWgv4J6XdBlOOvh8noH7ndxFHyXI5GzAZj6HxFQNrsn86djhVqlHaoGINnmB03ain+xkazdkyeSZwRPyqHsgaYvfOeethvgHiQfnkPb7q2cWVNIB1TVr0UCMGHh2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJtdd9Wh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2155c25e9a4so135345ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 08:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734453098; x=1735057898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbbarN/Rdy7B5sGVq7bbZZ+SWYVMjVxy+N4dBbT/+3Q=;
        b=uJtdd9Wh6OReJOzg9E+5y+SvG7XqG0yTy360CjLcY0vvk2NKN/oQzoNbh+qMJDKyzY
         Ow18yks25Yfx/ISExH7MBOkjpYEhmnvPA3Wt3z0yJ15BshYlALr7uMW8EwXUPdJLgiKk
         jHohbEdvGkVFaoXdUKvetY4N6+JVUO+g/AiIzQwVv4/NIq6WIYXMwzFniz45fig5oUX+
         LgQKcarSk+eutNXwVl1+KXvJ4ZFEjtJYqBklC43wEv+RCtSy+0pNhP4+y5B92wdiQoEa
         ODfqJ+YAN0AWvJMHitInXXV80R/NoOGLWPdnKkDSIqAARwDWKj9vZppzgdrfqY+GcgJm
         waeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734453098; x=1735057898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbbarN/Rdy7B5sGVq7bbZZ+SWYVMjVxy+N4dBbT/+3Q=;
        b=WA1AlNCj+jT0lkdxsW44N3NdvqnYJxACdMGJ6GReLiOBT3Cgl9+n5Ui3XojscN37X9
         Get6UdITCEaqd1EOayEIM0tQxAUvSXZ0vPB/RHs5Yy0n3Oc5NvsGRic+MuKME4X7NRjC
         8mU3LhVcFCSvXjgRnasiv4i5YVuYk/wmW/tseWxhu0wE46O6rQI/QggZR3WE3/7gIxqO
         f95VoDcT2NNIT0zpdJI51vPBnITXEf2l2zJE2uHzSR+JkNSvzrKRe3ODhx5BuqsN6oY2
         sfWOz5WaoJyeCjeM/jLo8togBeMTW233MhJoBlzmixFn8Kt8DvaU9fr5vRHPGHUJbAf4
         3Aaw==
X-Forwarded-Encrypted: i=1; AJvYcCUkALqP9Cvi6Hbf0qViou9HpoEcV4VgWYYATOGLSsemanLymWVsYB511Sdvtg6l3Uh47G/rSb84yn0ABy0T@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+u9T1x/DEINhqUmVF/c3fHYsgiNxWZ6NPuI768O4duKGgRvG9
	/hTr9haZ463PrSWNY1X1rYJCQzHliuP28YYfadTGQlGWf7oZHRWeY8RWhQSWjcJAGgCkrWRb+3O
	55zqEwVDCF+UDG2C5VuKrAW8XSNMb3slxII1sn2HS3eheQuYrQG7B
X-Gm-Gg: ASbGnctoctwpWNcOQPem/WZE80I4AN+awxwM6XuGb+J1lbAFzuUBHjRNmEkGN/sQCPz
	YtA0yRNI/9URaLuzp9SGMUGzuVw9PbbZ4kTlR
X-Google-Smtp-Source: AGHT+IF6zBycCZgZ37K0c0Mqt5KJZFgdpLPzxa4ka10RBRwmmEZmWl6gZSB2IrjVjllJ9HN8WQ+yjoAvN3boMOxpI+Y=
X-Received: by 2002:a17:902:c409:b0:215:7152:36e4 with SMTP id
 d9443c01a7336-218cb220b48mr2367185ad.27.1734453097470; Tue, 17 Dec 2024
 08:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426080548.8203-1-xuewen.yan@unisoc.com> <20241016-kurieren-intellektuell-50bd02f377e4@brauner>
 <ZxAOgj9RWm4NTl9d@google.com> <Z1saBPCh_oVzbPQy@google.com>
 <CADyq12y=MGzcvemZTVVGN4yhzr2ihr96OB-Vpg0yvrtrewnFDg@mail.gmail.com> <2024121705-unrigged-sanitary-7b19@gregkh>
In-Reply-To: <2024121705-unrigged-sanitary-7b19@gregkh>
From: Brian Geffon <bgeffon@google.com>
Date: Tue, 17 Dec 2024 11:31:01 -0500
Message-ID: <CADyq12ynffJLMFJvzf-hsq3OYiLG=TtRVOWev_nBVtOjK91pPw@mail.gmail.com>
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for ep_poll_callback
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "# v4 . 10+" <stable@vger.kernel.org>, Xuewen Yan <xuewen.yan@unisoc.com>, 
	Christian Brauner <brauner@kernel.org>, jack@suse.cz, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, cmllamas@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com, jing.xia@unisoc.com, 
	xuewen.yan94@gmail.com, viro@zeniv.linux.org.uk, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	lizeb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 10:34=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Dec 17, 2024 at 09:30:51AM -0500, Brian Geffon wrote:
> > On Thu, Dec 12, 2024 at 12:14=E2=80=AFPM Brian Geffon <bgeffon@google.c=
om> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 03:05:38PM -0400, Brian Geffon wrote:
> > > > On Wed, Oct 16, 2024 at 03:10:34PM +0200, Christian Brauner wrote:
> > > > > On Fri, 26 Apr 2024 16:05:48 +0800, Xuewen Yan wrote:
> > > > > > Now, the epoll only use wake_up() interface to wake up task.
> > > > > > However, sometimes, there are epoll users which want to use
> > > > > > the synchronous wakeup flag to hint the scheduler, such as
> > > > > > Android binder driver.
> > > > > > So add a wake_up_sync() define, and use the wake_up_sync()
> > > > > > when the sync is true in ep_poll_callback().
> > > > > >
> > > > > > [...]
> > > > >
> > > > > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > > > > Patches in the vfs.misc branch should appear in linux-next soon.
> > > > >
> > > > > Please report any outstanding bugs that were missed during review=
 in a
> > > > > new review to the original patch series allowing us to drop it.
> > > > >
> > > > > It's encouraged to provide Acked-bys and Reviewed-bys even though=
 the
> > > > > patch has now been applied. If possible patch trailers will be up=
dated.
> > > > >
> > > > > Note that commit hashes shown below are subject to change due to =
rebase,
> > > > > trailer updates or similar. If in doubt, please check the listed =
branch.
> > > > >
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.g=
it
> > > > > branch: vfs.misc
> > > >
> > > > This is a bug that's been present for all of time, so I think we sh=
ould:
> > > >
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Cc: stable@vger.kernel.org
> > >
> > > This is in as 900bbaae ("epoll: Add synchronous wakeup support for
> > > ep_poll_callback"). How do maintainers feel about:
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Cc: stable@vger.kernel.org
> >
> > Dear stable maintainers, this fixes a bug goes all the way back and
> > beyond Linux 2.6.12-rc2. Can you please add this commit to the stable
> > releases?
> >
> > commit 900bbaae67e980945dec74d36f8afe0de7556d5a upstream.
>

Hi Greg,

> How is this a bugfix?  It looks like it is just a new feature being
> added to epoll, what bug does it "fix"?

The bug this fixes is that epoll today completely ignores the WF_SYNC
flag. The end result is the same, the wakee is woken, but the kernel has
several places where a synchronous wakeup is expected and with epoll
this isn't honored. However, it is honored with poll, select, recvmsg, etc.
Ultimately, epoll is inconsistent with other polling methods and this
inconsistency can lead to unexpected and surprising scheduling properties
based on the mechanism used in userspace.

For example, f467a6a664 ("pipe: fix and clarify pipe read wakeup logic")
highlighted the importance of sync wakeups for pipes, should GNU make
start using epoll we would see the same regression that resulted in this
fix from Linus.

>
> confused,
>
> greg k-h

Thanks,
Brian

