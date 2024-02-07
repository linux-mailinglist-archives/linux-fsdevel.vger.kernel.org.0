Return-Path: <linux-fsdevel+bounces-10598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD01784C975
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 12:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431C91F26D96
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 11:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38081B7EE;
	Wed,  7 Feb 2024 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEwNZoEG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0671B7FF
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304570; cv=none; b=r8tGCkW8/uIH3B7qklzko3pTKq/+HhbDfEE9fLmlmZDseMqC+AqaZxsVXOzziLyzxZqh3pTARaeAU0oe+7TN3hnStGWlWCMu0oVKCy38WzGEK4wUf7/NuhiS++7Pblx+LSBgJvuKpXIv1wULNhIfBGJFlaMEAnKYUdNMyLMEtkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304570; c=relaxed/simple;
	bh=zQ4HZ6KJespP6ry1PelH4GAZPtWPrNXfFsAWZ5At2AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxxwsrO7Qx+ZtK/W7z4P5pTHBwYiGYQrxlzmlqZx9b7uR2FhnhUsTp0QdPnN7ZyfGzCGsnWHl0//17OEdQvtU5elR5p7n6Z52RKxorbgCgHfpRXocNCxGILFC1qVCH0CUm+pq+8Zt/hZcWcS4rNGAyjPWtmXmmXvFRobtfDalcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEwNZoEG; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6e0fe3195so470208276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 03:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707304567; x=1707909367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuazLOqPqze47qzaXE7+d6mXgubfJVWZpBfuah2qutA=;
        b=CEwNZoEGy6rWcrNcqeunzYVdSaVV5aaPca9RmSK623tQE2TXHMi5N3fWZEhda4KHdN
         C/sZdY1JTB/FhOWnJFctOJGT5K8HEIjRG7uYpAE/S6ulTfg+sKljefP3G8oNKbl51ZXx
         I1xY1rQB4rJ9DYcYYbORstWmtXmYo43WIzIjkGklGPv9n3gyhc9iZXUJ7g/NGlRzh3r/
         Facco2AtHc0VSEFIvuXSdQwmOYbADzV66AD4RlHoRPeteG+HKRwHOaGN9OuX1n7z+5BY
         4gr0bDPfMFLHkmNYtLFIkm9atZxWILQ0lOMecoqN5Uk2DA6riK6FniY536Mc2STVLnP5
         YJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304567; x=1707909367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuazLOqPqze47qzaXE7+d6mXgubfJVWZpBfuah2qutA=;
        b=Gj4ZqgycCVm4O2qmYMzO8+4T3aSKLkGaifcEPtcVjWHgFNZRt+p7pyTbEenfRF/iC7
         TrJPFyZmsYIjKapAF2TFBWqWbWmjCQ+jyteL3e4uMDP1aCToKIRuERuXtQ9ysRMA4tQ+
         GXQ4Rd2CP1wNZl96R971oHlHodb307Zd8XiR7Yi9QAEaeSbuA3FkeNZG3KtlrMYZ6mLb
         r2wTzLcOZ0A67HhAtcA/CVS29tkDYhVscxcyZSxse/jOe4tm8s5D0rpsXAGFFw52zG3z
         /NE4sEf5CLJfffSvFasJePcNdwbAfvImlIcs4CYxNLcpfS/KW2m5pOxlHH6oMrADrFPR
         xymA==
X-Gm-Message-State: AOJu0YwNvib3x9Mppo7sh0CXURShDvVZ4KssgBLAdhgPNI46DL9Al6zU
	usefon95subjzNkS9M+TFIJmt30TC4m9vWYHHAYQMnVz6QslfwB115/yjn3cRisifM+wscfNLOI
	IFZiK05xoPCi5d+ZxkYxB6yZeVFWBJDpvV40=
X-Google-Smtp-Source: AGHT+IFriwThfkrwT8HqP1di30tXVYOTECxi0crAKEtDudShYubBfaInOtpRoZeJZ6S0iSvi582H+YxXM3s8KglS9m0=
X-Received: by 2002:a5b:1cb:0:b0:dc2:2348:4afd with SMTP id
 f11-20020a5b01cb000000b00dc223484afdmr4268086ybp.30.1707304567428; Wed, 07
 Feb 2024 03:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMp4zn8aXNPzq1i8KYmbRfwDBvO5Qefa4isSyS1bwYuvkuBsHg@mail.gmail.com>
 <CAOQ4uxgPY_6oKZFmWitJ-FTuV1YUWHMcNqppiCiMMk46aURMUA@mail.gmail.com>
 <20240206135028.q56y6stckqnfwlbg@quack3> <CAMp4zn_EtdB2XHsWtNQ72hzruRFGCCCYc7vaRV8W-K7W4v61uw@mail.gmail.com>
 <CAOQ4uxhuPBWD=TYZw974NsKFno-iNYSkHPw6WTfG_69ovS=nJA@mail.gmail.com> <20240207104436.q7c4s4b53sal2d4q@quack3>
In-Reply-To: <20240207104436.q7c4s4b53sal2d4q@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 Feb 2024 13:15:55 +0200
Message-ID: <CAOQ4uxjMbuxHRjY3M9rdOqTJwxKRAt21NTjgrNrADJBVyTz2dg@mail.gmail.com>
Subject: Re: Fanotify: concurrent work and handling files being executed
To: Jan Kara <jack@suse.cz>
Cc: Sargun Dhillon <sargun@sargun.me>, 
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Sweet Tea Dorminy <thesweettea@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:44=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 06-02-24 18:44:47, Amir Goldstein wrote:
> > On Tue, Feb 6, 2024 at 6:30=E2=80=AFPM Sargun Dhillon <sargun@sargun.me=
> wrote:
> > >
> > > On Tue, Feb 6, 2024 at 6:50=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Tue 06-02-24 09:44:29, Amir Goldstein wrote:
> > > > > On Tue, Feb 6, 2024 at 1:24=E2=80=AFAM Sargun Dhillon <sargun@sar=
gun.me> wrote:
> > > > > >
> > > > > > One of the issues we've hit recently while using fanotify in an=
 HSM is
> > > > > > racing with files that are opened for execution.
> > > > > >
> > > > > > There is a race that can result in ETXTBUSY.
> > > > > > Pid 1: You have a file marked with FAN_OPEN_EXEC_PERM.
> > > > > > Pid 2: execve(file_by_path)
> > > > > > Pid 1: gets notification, with file.fd
> > > > > > Pid 2: blocked, waiting for notification to resolve
> > > > > > Pid 1: Does work with FD (populates the file)
> > > > > > Pid 1: writes FAN_ALLOW to the fanotify file descriptor allowin=
g the event.
> > > > > > Pid 2: continues, and falls through to deny_write_access (and f=
ails)
> > > > > > Pid 1: closes fd
> > > >
> > > > Right, this is kind of nasty.
> > > >
> > > > > > Pid 1 can close the FD before responding, but this can result i=
n a
> > > > > > race if fanotify is being handled in a multi-threaded
> > > > > > manner.
> > > >
> > > > Yep.
> > > >
> > > > > > I.e. if there are two threads operating on the same fanotify gr=
oup,
> > > > > > and an event's FD has been closed, that can be reused
> > > > > > by another event. This is largely not a problem because the
> > > > > > outstanding events are added in a FIFO manner to the outstandin=
g
> > > > > > event list, and as long as the earlier event is closed and resp=
onded
> > > > > > to without interruption, it should be okay, but it's difficult
> > > > > > to guarantee that this happens, unless event responses are seri=
alized
> > > > > > in some fashion, with strict ordering between
> > > > > > responses.
> > > >
> > > > Yes, essentially you must make sure you will not read any new event=
s from
> > > > the notification queue between fd close & writing of the response. =
Frankly,
> > > > I find this as quite ugly and asking for trouble (subtle bugs down =
the
> > > > line).
> > > >
> > > Is there a preference for either refactoring fanotify_event_metadata,=
 or
> > > adding this new ID type as a piece of metadata?
> > >
> > > I almost feel like the FD should move to being metadata, and we shoul=
d
> > > use ID in place of fd in fanotify_event_metadata. If we use an xarray=
,
> > > it should be reasonable to use a 32-bit identifier, so we don't need
> > > to modify the fanotify_event_metadata structure at all.
> >
> > I have a strong preference for FANOTIFY_METADATA_VERSION 4
> > because I really would like event->key to be 64bit and in the header,
> > but I have a feeling that Jan may have a different opinion..
>
> I also think 64-bit ID would be potentially more useful for userspace
> (mostly because of guaranteed uniqueness). I'm just still not yet sure ho=
w
> do you plan to use it for persistent events because there are several
> options how to generate the ID. I'd hate to add yet-another-id in the nea=
r
> future.

The use case of permission events and persistent async events do not
overlap and for the future, they should not be mixed in the same group
at all. mixing permission events and async events in the same group
was probably a mistake and we should not repeat it.

The event->id namespace is per group.
permission events are always realtime events so they do not persist
and event->id can be a runtime id used for responding.
A future group for persistent async events would be something like
https://learn.microsoft.com/en-us/windows/win32/fileio/change-journal-recor=
ds
and then the 64-bit event->id would have a different meaning.
It means "ACK that events up ID are consumed" or "query the events since ID=
".

>
> Regarding FANOTIFY_METADATA_VERSION 4: What are your reasons to want the =
ID
> in the header?

Just a matter of personal taste - I see event->id as being fundamental
information
and not "extra" information.

Looking forward at persistent events, it would be easier to iterate and ski=
p
up to ID, if event->id is in the header.

> I think we'd need explicit init flag to enable event ID
> reporting anyway?But admittedly I can see some appeal of having ID in the
> header if we are going to use the ID for matching responses to permission
> events.

Yes, as you wrote,
permission events with FAN_REPORT_FID are a clean start.
I don't mind if this setup requires an explicit FAN_REPORT_EVENT_ID flag.

Also, regarding your suggestion to report FID instead of event->fd,
I think we can do it like that:
1. With FAN_REPORT_FID in permission events, event->fd should
    NOT be used to access the file
2. Instead, it should be used as a mount_fd arg to open_by_handle_at()
    along with the reported fid
3. In that case, event->fd may be an O_PATH fd (we need a
    patch to allow O_PATH fd as mount_fd)
4. An fd that is open with open_by_handle_at(event->fd, ...
    will have the FMODE_NONOTIFY flag, so it is safe to access the file

This model also solves my problem with rename(), because a single
mount_fd could be used to open both old and new parent path fds.

Does that sound like a plan?

Thanks,
Amir.

