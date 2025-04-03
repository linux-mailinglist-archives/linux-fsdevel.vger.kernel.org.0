Return-Path: <linux-fsdevel+bounces-45626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F0BA7A08E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 11:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222C1174041
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2177A2459E9;
	Thu,  3 Apr 2025 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYlSvCFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948FB186E54
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674321; cv=none; b=gAwxgthzM6tgWxhlPSuSeKlw5oF+z8d3PFo9Kb4GDiB7ohlnllWP3WJRSa01vaBgNcWkEIniGxMYu8Nqv0rXNlR9BgSbt+Ak3/MmxMqwAo0mrrQ5wVF8HH8XV4s7qiEyVAXIC0Xf6769dVpH0cnbabHv0Y/A2u1iYVv2Pw7TJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674321; c=relaxed/simple;
	bh=F5DiJ1kp59dDGAsbeEezosSO6tyWLCradNmw6f9z1nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrsKOv78ZnNhAQ3tkWAYDCrWmNrYJOL+lUhuyCKnsZ5mi2PVasadmBWnMMISeNpET5qBDtGXr7vVKROqnspYZXIH7FVSUAm+3ZFEvlG2Ans/gCKwcs0lsOYN0pvLu4SjFgymLzdPfSj5MhAXiiw4bjhK/ZSKw3bCLmXNuzmP7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYlSvCFA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac73723b2d5so132235966b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 02:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743674318; x=1744279118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5DiJ1kp59dDGAsbeEezosSO6tyWLCradNmw6f9z1nA=;
        b=RYlSvCFAmDGMDHIr5T5JnqQy3L1swDUs+3SQNuTKoUZz3efINu8SEmJTuPm8ktlj8Z
         HKVFjSyvRgPKkkZXEWb1KNU8ZCtt+I0qCMJBJDqSGgvRjTQ/IfUNsd8bV6GfGDa4qXZN
         aymbXGn9o9zQwPUdNp8PVoRQ7r49NCaaqb7ugsCS/cu3JhmM3+MeItmggQ2kK8g/puaF
         EgRNte9wGGowDy2BIHjNMNCC58qOtm04xCfI9E2XXrGFzZXk9sfpHb9vxl+baqsNmQXp
         Y0C/QhlhlKu2bx3Ep3d92PuNcnHyUqfFB7U5uMe+d1WhXLJnjXjgv2JrECY9YsUpUzD/
         zjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743674318; x=1744279118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5DiJ1kp59dDGAsbeEezosSO6tyWLCradNmw6f9z1nA=;
        b=I/S/uB4mUtgu/bGhCStIUUPChWVYz6utnM0/T6qWnWV94+xpzJD7YQKv9/PPKmhk8N
         mZnxQvESGIzIJ+qo0EKC8gfJtEuPjQgWRLXqS7H52erTdzjm2ybjk+8buI3zg38mMbN5
         3lm6mp0yEPzUEpsXs+Z94lno1Kz1PJj8eTqSp9qIRQErZP21B/3XedE1wPE1O4JCI7rJ
         ww/Qf1v51CGT0/lC4PfLYk3PrOo9xPanFzpllVnCijMCCYhogVLjjzbuFuEqZ/430PgD
         Xi4JbCeFxJR8AGxI/LE+ztHcZRysK5Q5rE6ECXx8gRHntCe14USaNp8sDQcYsgj7ZiXz
         mIdg==
X-Forwarded-Encrypted: i=1; AJvYcCUXfFd222zz53qaOAAo/QLYLgOOLkTKcQ2XxKsQVLnId0YoxcZtLLXEM+CI0SmH25F4gOhpLL1MLYCdOQKf@vger.kernel.org
X-Gm-Message-State: AOJu0YwLY7TLsN5X5e4ai4jBL/WJdb7hF1qoNtTW9+LBc4fDxMXypHqb
	ZISrERRYO0vSI/bQ2/B1CygBrQ3mYI1OCt+eKmVXHtjLpvK9tnCdftWiKMMeLUGrJcUlJnkA2AK
	NQr36yyLpWgWm+u6oUAIVb746iJ4=
X-Gm-Gg: ASbGncuCZB6/ZVMXAZKozihuw+pELJ2QzLAg1fFHAZD9UKnIYeJjOHqUOAMqJDtSfKu
	ImD/Bsj7X1h7y9Tk0kUumGUjH3HtDDM5jo2EOaBNmnZE6JWDN8XcpUqC21byb2XmlPdcKs7+Wnr
	YGcWEu/dRzhrAMM2/v95QtY8pm+g==
X-Google-Smtp-Source: AGHT+IHrQ+/gPjF1uOtJVsIRXB1hKkVRpnJ1ZMpmBvzQRh3CcVCa1wegDigCkAHWC2dnzAphZjbGlxpI+jVZ/jSiuT0=
X-Received: by 2002:a17:907:97ce:b0:ac4:16a:1863 with SMTP id
 a640c23a62f3a-ac7a1720c92mr549573666b.26.1743674317361; Thu, 03 Apr 2025
 02:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BY1PR15MB61023E97919A597059EA473CC4AD2@BY1PR15MB6102.namprd15.prod.outlook.com>
 <CAOQ4uxihnLqagEX_PXA0pssQ=inPxSz-GDLcuJ9zs603LryKfw@mail.gmail.com>
 <6za2mngeqslmqjg3icoubz37hbbxi6bi44canfsg2aajgkialt@c3ujlrjzkppr> <20250403-video-halsband-9b9d0e0c95c3@brauner>
In-Reply-To: <20250403-video-halsband-9b9d0e0c95c3@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Apr 2025 11:58:26 +0200
X-Gm-Features: ATxdqUHqOI79aghVDa2fKZ75g87Rt-xtrWzhkiYHWE5a20lWDeiFRpM45-Rghtw
Message-ID: <CAOQ4uxjVNuR2dWLv+f98TuHcqsr77K3Y36zgRBBhUrer4ikWqA@mail.gmail.com>
Subject: Re: Reseting pending fanotify events
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, 
	Sargun Dhillon <sargun@meta.com>, Alexey Spiridonov <lesha@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 10:25=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Apr 01, 2025 at 06:28:11PM +0200, Jan Kara wrote:
> > On Mon 31-03-25 21:08:51, Amir Goldstein wrote:
> > > [CC Jan and Josef]
> >
> > CCed fsdevel. Actually replying here because the quoting in Ibrahim's e=
mail
> > got somehow broken which made it very hard to understand.
> >
> > > I am keeping this discussion private because you did not post it to
> > > the public list,
> > > but if you can CC fsdevel in your reply that would be great, because =
it seems
> > > like a question with interest to a wider audience.
> > >
> > > On Mon, Mar 31, 2025 at 8:19=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh=
@meta.com> wrote:
> > > >
> > > > Hi Amir,
> > > >
> > > > We have been using fanotify to support lazily loading file contents=
.
> > > > We are struggling with the problem that pending permission events c=
annot be recovered on daemon restart.
> > > >
> > > > We have a long-lived daemon that marks files with FAN_OPEN_PERM and=
 populates their contents on access.
> > > > It needs a reliable path for updates & crash recovery.
> > > > The happy path for fanotify event processing is as follows:
> > > >
> > > > A notification is read from fanotify file descriptor
> > > > File contents are populated
> > > > We write back FAN_ALLOW to fanotify file descriptor, or DENY if con=
tent population failed.
> > > >
> > > > We would like to guarantee that all file accesses receive an ALLOW =
or DENY response, and no events are lost.
> > >
> > > Makes sense.
> > >
> > > > Unfortunately, today a filesystem client can hang (in D state)
> > > > if the event-handler daemon crashes or restarts at the wrong time.
> > >
> > > Can you provide exact stack traces for those cases?
> > >
> > > I wonder how process gets to D state with commit fabf7f29b3e2
> > > ("fanotify: Use interruptible wait when waiting for permission events=
")
> >
> > So D state is expected when waiting for response. We are using
> > TASK_UNINTERRUPTIBLE sleep (the above commit had to be effectively
> > reverted). But we are also setting TASK_KILLABLE and TASK_FREEZABLE so =
that
> > we don't block hibernation and tasks can be killed when fanotify listen=
er
> > misbehaves.
> >
> > But what confuses me is the following: You have fanotify instance to wh=
ich
> > you've got fd from fanotify_init(). For any process to be hanging, this=
 fd
> > must be still held open by some process. Otherwise the fanotify instanc=
e
> > gets destroyed and all processes are free to run (they get FAN_ALLOW re=
ply
> > if they were already waiting). So the fact that you see processes hangi=
ng
> > when your fanotify listener crashes means that you have likely leaked t=
he
> > fd to some other process (lsof should be able to tell you which process=
 has
> > still handle to fanotify instance). And the kernel has no way to know t=
his
> > is not the process that will eventually read these events and reply...
> >
> > > > In this case, any events that have been read but not yet responded =
to would be lost.
> > > > Initially we considered handling this internally by saving the file=
 descriptors for pending events,
> > > > however this proved to be complex to do in a robust manner.
> > > >
> > > > A more robust solution is to add a kernel fanotify api which resets=
 the fanotify pending event queue,
> > > > thereby allowing us to recover pending events in the case of daemon=
 restart.
> > > > A strawman implementation of this approach is in
> > > > https://github.com/torvalds/linux/compare/master...ibrahim-jirdeh:l=
inux:fanotify-reset-pending,
> > > > a new ioctl that resets `group->fanotify_data.access_list`.
> > > > One other alternative we considered is directly exposing the pendin=
g event queue itself
> > > > (https://github.com/torvalds/linux/commit/cd90ff006fa2732d28ff6bb59=
75ca5351ce009f1)
> > > > to support monitoring pending events, but simply resetting the queu=
e is likely sufficient for our use-case.
> > > >
> > > > What do you think of exposing this functionality in fanotify?
> > > >
> > >
> > > Ignoring the pending events for start, how do you deal with access to
> > > non-populated files while the daemon is down?
> > >
> > > We were throwing some idea about having a mount option (something
> > > like a "moderate" mount) to determine the default response for specif=
ic
> > > permission events (e.g. FAN_OPEN_PERM) in the case that there is
> > > no listener watching this event.
> > >
> > > If you have a filesystem which may contain non-populated files, you
> > > mount it with as "moderated" mount and then access to all files is
> > > denied until the daemon is running and also denied if daemon is down.
> > >
> > > For restart, it might make sense to start a new daemon to start liste=
ning
> > > to events before stopping the old daemon.
> > > If the new daemon gets the events before the old daemon, things shoul=
d
> > > be able to transition smoothly.
> >
> > I agree this would be a sensible protocol for updates. For unplanned cr=
ashes
> > I agree we need something like the "moderated" mount option.
>
> I hope you mean as a superblock option, not an actual mount option.
> Because a per-mount option is not something I want us to do. We're not
> giving a specific subsystem a way to alter per-mount behavior.

I don't think that mount option is the right API for this.
I think if we ever need to implement the semantics of
"never allow unmoderated access to this fs or via this mount"
to close the window of time until an fanotify permission mark is set
then we will need to implement what you proposed once
to allow setting an fanotify mark on a sb/mount before
they are attached to the mount namespace.

If I am ever saying "moderated mount" in an email, then this
is actually what I mean.

Thanks,
Amir.

