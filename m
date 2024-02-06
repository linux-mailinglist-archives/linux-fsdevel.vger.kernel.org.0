Return-Path: <linux-fsdevel+bounces-10501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D35B84BAF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 17:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8031C23588
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB06139D;
	Tue,  6 Feb 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="WhKq/w+V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18B1373
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237037; cv=none; b=r1ZOy2R/NbvPoBqIBcOl0cfrO+kMVvOfHcBpDhwYWX9F4HTqgnAg2Yr0CcOIxjxvdJKKM2fkjUtGtYGOiT/gZrTzYR6yYrnK+AdVTTkyE8XuIKHOO1h0LWfkTUTQIwAm3TPCVa/tiYiHidTLbkQQHTjfGqGW5quFH3+u8DJEq8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237037; c=relaxed/simple;
	bh=+mxdzXN1DDXdjGfyiarZI3lOlI1G/S+Q//I8yqbmA5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sm532W4XvYdjAm0AZNOIAK5RetLCUBs+pCtJNLnNnP8s2aMxTryeOD6Ay11VOfjK9gLdreBNQC4uagOBdDpv3XKQpCAOquXv5N0/IBNYi61Q8vekIeea8cECbYcrqiWlzB+7wp/igXnMQDpIr92wW0cuW3fsCWNDNWIhZ2apvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sargun.me; spf=pass smtp.mailfrom=sargun.me; dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b=WhKq/w+V; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sargun.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sargun.me
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55ff4dbe6a8so5190687a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 08:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google; t=1707237032; x=1707841832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt02AWtf7l4aIKQ5cICpjsyuCFTXSdlrt5jbuNlu2EE=;
        b=WhKq/w+VJaAFxeMsCBEtq7F+P6KXtCUJuIcdux4FlK4x0Piy9mVdXoKGa6EEhSCrUZ
         xf2fe8w8FRMlcchRnaaJZ7hH+cE7euCyoZIBbM3Efur7N4Vv2UiefiUbqI62U+gea44g
         pultvwWWQIAzMVjL7dgcpcW+szYE5qQocz4IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237032; x=1707841832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wt02AWtf7l4aIKQ5cICpjsyuCFTXSdlrt5jbuNlu2EE=;
        b=cCyuSk02cEYZrmrh9bMweK9ASWdLJKmLFVBZAhytvN0OVf1hDvj2BC3axUcTVGneCl
         vDAgFjJOuEb0FzLbUq/vzklFLHnh5SGfE2cNW9byuSitMQ4TCP6fFUM82p7hv8sp79AP
         kmobhaOt0CGVwHhtiNp30IxIAzNXkAcqoYsGM4upR2U5d6TnG4ciC6pdi++mEpdk0N2d
         RUZxQO7gRRHX4t5VF1IHYgGphwTuQPZdPcPB2V7NIKg271JqEnls+vHRPFI+Qjaylfxi
         28d0YfBupi3FkgxnVAHgiOakXS0MUGX3HyUtTXMR36Udca0p/M8af8xd7gx+zeNVpSJy
         ebmg==
X-Gm-Message-State: AOJu0YwoQNbtVPGPhwv8vhf1SenBFeG1aJyMA0dslOIVHOmMVRcfWlPX
	1zzl7NAMjdURUd5hgQqsDe8109BO7jttAT0i8RIyWSDnc8aHqfi5YAC/TUrpXv+Lfzep4XozHMI
	6He3f/F/1u7SDQ7zafwI/Tn7TZhxEaOZf0up4PA==
X-Google-Smtp-Source: AGHT+IHfZhR+3ypU3pfzUwLgtRRBfqJYjqaTnWFwHkXcvtUF0hr4VtJOmev/z4IiDSoeN6jhZkSCkoBc2rVymnrIvfs=
X-Received: by 2002:a17:906:b88d:b0:a37:124b:4782 with SMTP id
 hb13-20020a170906b88d00b00a37124b4782mr1762447ejb.36.1707237032273; Tue, 06
 Feb 2024 08:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMp4zn8aXNPzq1i8KYmbRfwDBvO5Qefa4isSyS1bwYuvkuBsHg@mail.gmail.com>
 <CAOQ4uxgPY_6oKZFmWitJ-FTuV1YUWHMcNqppiCiMMk46aURMUA@mail.gmail.com> <20240206135028.q56y6stckqnfwlbg@quack3>
In-Reply-To: <20240206135028.q56y6stckqnfwlbg@quack3>
From: Sargun Dhillon <sargun@sargun.me>
Date: Tue, 6 Feb 2024 09:29:55 -0700
Message-ID: <CAMp4zn_EtdB2XHsWtNQ72hzruRFGCCCYc7vaRV8W-K7W4v61uw@mail.gmail.com>
Subject: Re: Fanotify: concurrent work and handling files being executed
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Sweet Tea Dorminy <thesweettea@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:50=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 06-02-24 09:44:29, Amir Goldstein wrote:
> > On Tue, Feb 6, 2024 at 1:24=E2=80=AFAM Sargun Dhillon <sargun@sargun.me=
> wrote:
> > >
> > > One of the issues we've hit recently while using fanotify in an HSM i=
s
> > > racing with files that are opened for execution.
> > >
> > > There is a race that can result in ETXTBUSY.
> > > Pid 1: You have a file marked with FAN_OPEN_EXEC_PERM.
> > > Pid 2: execve(file_by_path)
> > > Pid 1: gets notification, with file.fd
> > > Pid 2: blocked, waiting for notification to resolve
> > > Pid 1: Does work with FD (populates the file)
> > > Pid 1: writes FAN_ALLOW to the fanotify file descriptor allowing the =
event.
> > > Pid 2: continues, and falls through to deny_write_access (and fails)
> > > Pid 1: closes fd
>
> Right, this is kind of nasty.
>
> > > Pid 1 can close the FD before responding, but this can result in a
> > > race if fanotify is being handled in a multi-threaded
> > > manner.
>
> Yep.
>
> > > I.e. if there are two threads operating on the same fanotify group,
> > > and an event's FD has been closed, that can be reused
> > > by another event. This is largely not a problem because the
> > > outstanding events are added in a FIFO manner to the outstanding
> > > event list, and as long as the earlier event is closed and responded
> > > to without interruption, it should be okay, but it's difficult
> > > to guarantee that this happens, unless event responses are serialized
> > > in some fashion, with strict ordering between
> > > responses.
>
> Yes, essentially you must make sure you will not read any new events from
> the notification queue between fd close & writing of the response. Frankl=
y,
> I find this as quite ugly and asking for trouble (subtle bugs down the
> line).
>
Is there a preference for either refactoring fanotify_event_metadata, or
adding this new ID type as a piece of metadata?

I almost feel like the FD should move to being metadata, and we should
use ID in place of fd in fanotify_event_metadata. If we use an xarray,
it should be reasonable to use a 32-bit identifier, so we don't need
to modify the fanotify_event_metadata structure at all.

> > > There are a couple of ways I see around this:
> > > 1. Have a flag in the fanotify response that's like FAN_CLOSE_FD,
> > > where fanotify_write closes the fd when
> > > it processes the response.
> >
> > That seems doable and useful.
> >
I can work on this. We already have FAN_AUDIT and FAN_INFO as optional
bits that can be set in the response. I know there's another thread talking
about using the high-bits for error codes, and I wouldn't want to pollute
the higher bits too much if we go down that route.

I'm also not sure how best to implement capability probing (other than you
get an EINVAL in userspace and retry without that bit being set).

> > > 2. Make the response identifier separate from the FD. This can either
> > > be an IDR / xarray, or a 64-bit always
> > > incrementing number. The benefit of using an xarray is that responses
> > > can than be handled in O(1) speed
> > > whereas the current implementation is O(n) in relationship to the
> > > number of outstanding events.
> >
> > The number of outstanding permission events is usually limited
> > by the number of events that are handled concurrently.
> >
> > I think that a 64-bit event id is a worthy addition to a well designed
> > notifications API. I am pretty sure that both Windows and MacOS
> > filesystem notification events have a 64-bit event id.
>
> I agree that having 64-bit id in an event and just increment it with each
> event would be simple and fine way to identify events. This could then be
> used to match responses to events when we would be reporting permission
> events for FID groups as I outlined in my email yesterday [1].
>
> > If we ever implement filesystem support for persistent change
> > notification journals (as in Windows), those ids would be essential.
>
> How do you want to use it for persistent change journal? I'm mostly askin=
g
> because currently I expect the number to start from 0 for each fsnotify
> group created but if you'd like to persist somewhere the event id, this
> would not be ideal?
>
> > > This can be implemented by adding an additional piece of response
> > > metadata, and then that becomes the
> > > key vs. fd on response.
> > > ---
> > >
> > > An aside, ETXTBUSY / i_writecount is a real bummer. We want to be abl=
e
> > > to populate file content lazily,
> > > and I realize there are many steps between removing the write lock,
> > > and being able to do this, but given
> > > that you can achieve this with FUSE, NFS, EROFS / cachefilesd, it
> > > feels somewhat arbitrary to continue
> > > to have this in place for executable files only.
> >
> > I think there are way too many security models built around this
> > behavior to be able to change it for the common case.
> >
> > However, I will note that technically, the filesystem does not
> > need to require a file open for write to fill its content as long as th=
e
> > file content is written directly to disk and as long as page cache
> > is not populated in that region and invalidate_lock is held.
>
> I was thinking about this as well and as you say, technically there is no
> problem with this - just bypass writer the checks when opening the file -
> but I think it just gives userspace too much rope to hang itself on. So i=
f
> we are going to support something like this it will require very careful
> API design and wider consensus among VFS people this is something we are
> willing to support.
>
> > Requiring FMODE_WRITE for btrfs_ioctl_encoded_write()
> > may make sense, but it is not a must.
> > A more fine grained page cache protection approach is also
> > an option, a bit like (or exactly like) exported pNFS layouts.
> >
> > IOW, you could potentially implement lazy filling of executable
> > content with specific file systems that support an out of band
> > file filling API, but then we would also need notifications for
> > page faults, so let's leave that for the far future.
>
> That's another good point that currently we don't generate fsnotify event=
s
> on page faults. For lazy filling of executables this is basically must-ha=
ve
> functionality and I'd say that even for lazy filling of other files,
> handling notifications on page faults will come up sooner rather than
> later. So this is probably the thing we'll have to handle first.
>
>                                                                 Honza
>
> [1] https://lore.kernel.org/all/20240205182718.lvtgfsxcd6htbqyy@quack3
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

