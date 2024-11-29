Return-Path: <linux-fsdevel+bounces-36132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 443079DC20C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 11:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A453B227CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0C818858A;
	Fri, 29 Nov 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzRMjrwM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10D155753
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732875798; cv=none; b=pN/aBxJAqrwuq19aFjOPKobr+2od2H3U/iYxKuyqC5mZa+293AN233bUzXJ5zZv0cGsFODfT7+cZcH/K9y47fEd7CfqRGQ2QuUdruNrHFnxQd6xZfABf0O6tnGbpS1Meu6aHDJQh0c/QZR9yka3wuWc7cKQVHebxMpgIC8t1oDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732875798; c=relaxed/simple;
	bh=ynV4kmCOGOWYmDJgCFLY/WAPYD1dC78T/rVLrFzIWHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzL4Lc+MA4g7uaOP/A9ay1vRZW9yyrjzPA2tR0fQlCrAMurxg+5VzuWs8nrIoLblpDh1o5u546OthjNWQp9nzeFAbbUZAKqPz+XLyIEz/VQQmqBaZhSEdYMIR3x89wGAuhmEWZvqJPI99w05rkEk/s8fc/vu3HVKYSrsKFeu+ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzRMjrwM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa549f2f9d2so194832266b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 02:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732875795; x=1733480595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hprLpHSNPoUJHipsQFdgteafc/RlX17qtUAto7UiTuQ=;
        b=JzRMjrwMlmiuWK1vK+rBec4rS+P4GvvGZwCWwEtPq2wHHhFXVda8ikqBhs9LZf07fb
         Lyec9tsYt55BAuKn+ggtUKkdkU7mbb84tf337nOqMdZ8r9O1iTaq90fzpl3MrV+FMgLf
         jXfIefSO02ADU6zpT3ttO4DLQ29vKeqSF6AYlYz5BA+PJSGHnc2SnZpfQS3WMIEXyG8F
         wTtIRV2Xn7sEgMIwG/srI2tGvupoYU58yuPR30IdGZSYhBeqJCCa/6KcYZOCg0F3qlYy
         J5ewXLKhjabEEzciCmINtmuirqM8y55He4+Y/TuweuQP0PpAaO6GQ58W+wJJVZS7sVGU
         lXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732875795; x=1733480595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hprLpHSNPoUJHipsQFdgteafc/RlX17qtUAto7UiTuQ=;
        b=cYrk+wZ0Hf3m5M9WcVryJznJvscznt8RLC31kM7bDMApX4ECq6xGwsQSCepaLicQsH
         7SAODgD5DO3aESsl3nqfM7YfeWtV+376N31SiKj7rRGaEPhS3D9b1NMjo3N80ijYxULx
         8acjyqqng0gf7i1KTZ1hbNEMQmfnzlxS/81gQB/MWdprwwkgCxHzTYnBLfNFJtHiUAaQ
         rtNZPEeMNFd7hCR5FZ9feFkcB/1kS1VERNVwTV28pxq8+p2mAXLWBZjIUNpdIKGRmSlj
         vggIsgF3W7oMSFXZ6ABYgQWIWhkmdTHHREeh+gDBvhwLZMkBFh45uodsY62vVNMLkp34
         OkrA==
X-Forwarded-Encrypted: i=1; AJvYcCWWt/yRJNqyq/clpq0A6/ohjSBuK3kFJkcrhcXE3TV8sM3enUHzxDrca3dGFgCKPuTwJ/T0h1K3YnuOSTyh@vger.kernel.org
X-Gm-Message-State: AOJu0YwueGGfIK980pwCJ873rWORqSiRkknGHzyyQn9+fKb0BU5geCES
	xfhXTMDBmc4wPqLSFZCmFnFq0azcrv2sNBByy0uh4JGvLS29BQ/xTPBZUDKDHQXV4Mep39UDkZV
	/jqNp3pgq7fEcJxhNZDfAOhT7U5B/TkK3kPY=
X-Gm-Gg: ASbGncsy/SPm6WUt8XOh3GICTnZ9GnWyHF+86yNwj+ghHtXUgZ6Vdo1VjSVOmU/8GTQ
	CiFG/pmA/iCMRXiWCjUb8VQrsAdjaMok=
X-Google-Smtp-Source: AGHT+IFoMcKiwhpVojffJyTPC8mIDKPSp9PhGoDHRV5S+I/4zP3OsSI/fN1atI3bFL41oks+/jbZ3OWD7SAyybItydI=
X-Received: by 2002:a17:906:2182:b0:aa5:3853:5535 with SMTP id
 a640c23a62f3a-aa581028f7dmr901741866b.38.1732875794262; Fri, 29 Nov 2024
 02:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128144002.42121-1-mszeredi@redhat.com> <CAOQ4uxjAvpOnGp32OnsOKujivECgY1iV+UiBF_woDsxNSyJN_A@mail.gmail.com>
 <CAJfpegvaq5LAF+z9+AUXZiR5ZB4VOPTa0Svb33e-Y8Q=135h+A@mail.gmail.com>
In-Reply-To: <CAJfpegvaq5LAF+z9+AUXZiR5ZB4VOPTa0Svb33e-Y8Q=135h+A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 Nov 2024 11:23:03 +0100
Message-ID: <CAOQ4uxhbW=r9dZtkAx1ogoEmEKQh9f3g_WLh8jf+0o-rURCprQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fanotify: notify on mount attach and detach
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 8:16=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 28 Nov 2024 at 17:44, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > This sounds good, but do the watchers actually need this information
> > or is it redundant to parent_id?
>
> Everything but mnt_id is redundant, since they can be retrieved with stat=
mount.
>
> I thought, why not use the existing infrastructure in the event?  But
> it's not strictly needed.
>
> > If we are not sure that reporting fd/fid is needed, then we can limit
> > FAN_REPORT_MNTID | FAN_REPORT_*FID now and consider adding it later.
> >
> > WDYT?
>
> Sounds good.
>
>
> > You missed fanotify_should_merge(). IMO FAN_MNT_ events should never be=
 merged
> > so not sure that mixing this data in the hash is needed.
>
> Okay.
>
> > I think if we do not HAVE TO mix mntid info and fid info, then we bette=
r
> > stick with event->fd + mntid and add those fields to fanotify_path_even=
t.
>
> Okay.
>
> > See patch "fanotify: don't skip extra event info if no info_mode is set=
"
> > in Jan's fsnotify_hsm branch.
> > This should be inside copy_info_records_to_user().
>
> Makes sense.  I was wondering why copy_info_records_to_user() was
> called conditionally.

Up to pre-content events and FAN_EVENT_INFO_TYPE_RANGE,
fanotify_event_metadata had preserved its legacy non-extended format,
unless userspace explicitly opted-in to acknowledge the format extension
with one of the FAN_REPORT_ init flags.

If you take the route of FAN_REPORT_MNTID that I suggested, and add this
flag to FANOTIFY_INFO_MODES then copy_info_records_to_user() will be
called anyway.

This brings the question: should the FAN_REPORT_MNT flag be added to
FANOTIFY_ADMIN_INIT_FLAGS or FANOTIFY_USER_INIT_FLAGS?

Currently, watching a sb/mount requires capable(SYS_ADMIN),
but I have a pretty simple patchset [1] to require ns_capable(SYS_ADMIN).
Thing is, I never got feedback from userspace that this is needed [2].
Seeing that statmount/listmount() requires at most ns_capable(SYS_ADMIN),
I am guessing that you would also want mount monitor to require
at most ns_capable(SYS_ADMIN) rather than capable(SYS_ADMIN)?
If that is the case, feel free to pick up my patches and test mount monitor
inside userns.

Which then still leaves the question: do we want to allow an unprivileged
user to setup an inode mark with FAN_MNT_ events on a mount point?
This can be a bit tricky, because currently setting up an inode mark only
requires that the caller has access to that path.
That could lead to sending events with mntid from other namespaces
to unprivileged user watching a mount point inode.

Option #1: do not allow setting FAN_MNT_ events on inode marks (for now)
Option #2: apply the same requirement for sb mark from fanotify_userns patc=
h
to inode mark on group with FAN_REPORT_MNTID.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_userns/
[2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxiwGTg=3DFeO6iiLEwtsP9eTudw=
-rsLD_0u3NtG8rz5chFg@mail.gmail.com/

