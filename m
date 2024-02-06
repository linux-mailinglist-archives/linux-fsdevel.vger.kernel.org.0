Return-Path: <linux-fsdevel+bounces-10504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7740384BB47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 17:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0250E1F26FCC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26184C85;
	Tue,  6 Feb 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qlxh6vka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656C4A08
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237902; cv=none; b=gOYzF9tQJiKPQclclfIzcQgNaMFY6xG1btro5qrVmkqWYeHjV6mxE2wJyNeedAXfviUsSS5mr26Btu+vhPKD9vYeUx0zNUq8D9y9GJ/JXB29QlXapM5ykiPQiJCG0lIANyt+j+7eceAqyOkbHqvVDz3nCRwUEeecW1zh0hbxZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237902; c=relaxed/simple;
	bh=DLj5K8UkoiMaBEqBBa/z3x3IW3/j7QyfTNipzbo/+ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGmhhgvsWZ8RBc9mijmvCOT7VPXTbvQZoMmypjeglljEdmoxMUYX5tVaNnjsceH0H/1K2GpmAz/7JAaU6CzlrQhAPDiA7MVutogvtAk5u0eHwhx4kw4DZI/h6C7GKq2U6PfbHjD4xOKgUmq7YfXhyNpzCk1tSP53oPiRZc0Fm1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qlxh6vka; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4c03beb85f4so655177e0c.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 08:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707237899; x=1707842699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLj5K8UkoiMaBEqBBa/z3x3IW3/j7QyfTNipzbo/+ls=;
        b=Qlxh6vkaXZvvRYZlv6iZts92d2mukXQ9otc3hfZXAMyjGR+4yP+OEf9PvIQCjfQQb6
         lm2X/EPgdcDzMetvDk0YJdC3R4tAwmBDSw2RpylnGh3hn2PPd2GKOe63aA+UraSy6jpb
         Ynzm4nC8rUoJ+CI6flAhXpiQeD0GW+bNlX396dR2jMmRLRptiKUmzGOj1bvn9uVk4enr
         DE7jaEWY9zh3XwpY7vMUJca4uTI33VKlhNeIJfA6sWE77JTKQWVQyOurTgb+Glg133/q
         l0p0ecdfPHAaYIfY//v7RFQRkJSCIrXed8TJZo5WHp/btsDQfiGwLZWaLTUjBjkQMm1s
         G9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237899; x=1707842699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLj5K8UkoiMaBEqBBa/z3x3IW3/j7QyfTNipzbo/+ls=;
        b=U7rBHGPHo0oepmMMvoPss1NqkCaHfGdMVnVXiCJpdkVUytUa8Dgys4+EKh3eH83xRz
         0jKPvjqan7vdEiozcFu0Av+4jFC7gL6B9Xd8oZK7QSGFEpeAM+g90PzsZo9DgmzltMRP
         oqEjdE4GVwXIDT/Y8XZH3WTvWWIZSPyASV5VXE6MzMnF8ff9HU5rRH3H1FbTPqXiA9Lt
         f0y5LVjW58+exTe2Qae8LfjLFRv/crBWltVWgrNkoWQlbAf6y/twvhCDQk6EYpvwx28e
         80uryow4exvrGRXVUGyG/yTBpOa+GJYvW5vNmkC4U55RJD06NDP9TEXvatUUeTiSALW3
         hGCg==
X-Forwarded-Encrypted: i=1; AJvYcCX0eu2KBWTWKZHTnCotWWjiuYtHcT5VWsYWOHkh2nS87l4ZvtrOv9SK748lFlh1BexYUaN/5iQlxcpHzN1cPgnSSaMx7ukiwuFMNMmNJw==
X-Gm-Message-State: AOJu0Yyv7uDGOKLZyM81xWYx64SoO+vfdxqsf8wrhBoT/UEAfUz/qS1s
	vrxOHfcgpHm+GToU25b9FyLnEVnqv1tAJWAJxH6PpO4Nf5VFANtauhsQ8UvF0gkg45TrgPqVEfT
	Oy1Ue56Dnp9yVGhhur4PjDSgCSnF26kK+FJg=
X-Google-Smtp-Source: AGHT+IGnhMyvWOPrnQlNUJqD7wdTDjrq1qqBaZ2yJALg8y3ouUfiMVoIrGUczfqBq+s47KOz0xXMfsebQ6iK2a+52T0=
X-Received: by 2002:a05:6122:1b09:b0:4c0:1afb:b4cc with SMTP id
 er9-20020a0561221b0900b004c01afbb4ccmr71331vkb.13.1707237898401; Tue, 06 Feb
 2024 08:44:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMp4zn8aXNPzq1i8KYmbRfwDBvO5Qefa4isSyS1bwYuvkuBsHg@mail.gmail.com>
 <CAOQ4uxgPY_6oKZFmWitJ-FTuV1YUWHMcNqppiCiMMk46aURMUA@mail.gmail.com>
 <20240206135028.q56y6stckqnfwlbg@quack3> <CAMp4zn_EtdB2XHsWtNQ72hzruRFGCCCYc7vaRV8W-K7W4v61uw@mail.gmail.com>
In-Reply-To: <CAMp4zn_EtdB2XHsWtNQ72hzruRFGCCCYc7vaRV8W-K7W4v61uw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 18:44:47 +0200
Message-ID: <CAOQ4uxhuPBWD=TYZw974NsKFno-iNYSkHPw6WTfG_69ovS=nJA@mail.gmail.com>
Subject: Re: Fanotify: concurrent work and handling files being executed
To: Sargun Dhillon <sargun@sargun.me>
Cc: Jan Kara <jack@suse.cz>, 
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Sweet Tea Dorminy <thesweettea@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:30=E2=80=AFPM Sargun Dhillon <sargun@sargun.me> wr=
ote:
>
> On Tue, Feb 6, 2024 at 6:50=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 06-02-24 09:44:29, Amir Goldstein wrote:
> > > On Tue, Feb 6, 2024 at 1:24=E2=80=AFAM Sargun Dhillon <sargun@sargun.=
me> wrote:
> > > >
> > > > One of the issues we've hit recently while using fanotify in an HSM=
 is
> > > > racing with files that are opened for execution.
> > > >
> > > > There is a race that can result in ETXTBUSY.
> > > > Pid 1: You have a file marked with FAN_OPEN_EXEC_PERM.
> > > > Pid 2: execve(file_by_path)
> > > > Pid 1: gets notification, with file.fd
> > > > Pid 2: blocked, waiting for notification to resolve
> > > > Pid 1: Does work with FD (populates the file)
> > > > Pid 1: writes FAN_ALLOW to the fanotify file descriptor allowing th=
e event.
> > > > Pid 2: continues, and falls through to deny_write_access (and fails=
)
> > > > Pid 1: closes fd
> >
> > Right, this is kind of nasty.
> >
> > > > Pid 1 can close the FD before responding, but this can result in a
> > > > race if fanotify is being handled in a multi-threaded
> > > > manner.
> >
> > Yep.
> >
> > > > I.e. if there are two threads operating on the same fanotify group,
> > > > and an event's FD has been closed, that can be reused
> > > > by another event. This is largely not a problem because the
> > > > outstanding events are added in a FIFO manner to the outstanding
> > > > event list, and as long as the earlier event is closed and responde=
d
> > > > to without interruption, it should be okay, but it's difficult
> > > > to guarantee that this happens, unless event responses are serializ=
ed
> > > > in some fashion, with strict ordering between
> > > > responses.
> >
> > Yes, essentially you must make sure you will not read any new events fr=
om
> > the notification queue between fd close & writing of the response. Fran=
kly,
> > I find this as quite ugly and asking for trouble (subtle bugs down the
> > line).
> >
> Is there a preference for either refactoring fanotify_event_metadata, or
> adding this new ID type as a piece of metadata?
>
> I almost feel like the FD should move to being metadata, and we should
> use ID in place of fd in fanotify_event_metadata. If we use an xarray,
> it should be reasonable to use a 32-bit identifier, so we don't need
> to modify the fanotify_event_metadata structure at all.
>

I have a strong preference for FANOTIFY_METADATA_VERSION 4
because I really would like event->key to be 64bit and in the header,
but I have a feeling that Jan may have a different opinion..

> > > > There are a couple of ways I see around this:
> > > > 1. Have a flag in the fanotify response that's like FAN_CLOSE_FD,
> > > > where fanotify_write closes the fd when
> > > > it processes the response.
> > >
> > > That seems doable and useful.
> > >
> I can work on this. We already have FAN_AUDIT and FAN_INFO as optional
> bits that can be set in the response. I know there's another thread talki=
ng
> about using the high-bits for error codes, and I wouldn't want to pollute
> the higher bits too much if we go down that route.
>

There is plenty of bits space still.
I could implement FAN_CLOSE_FD if we get to a conclusion that it
will help. it should be quite trivial so better not do conflicting work
in parallel. But I think that Jan's idea of not opening event->fd at all
may be better.

> I'm also not sure how best to implement capability probing (other than yo=
u
> get an EINVAL in userspace and retry without that bit being set).
>

Yes, easy.
You can event write a response with FAN_NOFD for fd after
fanotify_init() to check capability.
If capability is supported you will get -ENOENT otherwise -INVAL.

Thanks,
Amir.

