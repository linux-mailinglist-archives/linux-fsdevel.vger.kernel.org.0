Return-Path: <linux-fsdevel+bounces-45634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706B5A7A2C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 14:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215C5173663
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 12:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498B924DFFD;
	Thu,  3 Apr 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azklJVdM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396624C07E;
	Thu,  3 Apr 2025 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743683006; cv=none; b=f6U6nD+UwEq3NaL4UBz3YC0eCd2ZzH9f0xcPVoVU38LhEQNqyLi/iXKd95O+bQa1Ri6aDFO/IHIG9ewjNr2N4vsc0vPrwKH3WoFByimA24YGnXvH9bdfhnlomiu/3o8uGV5AZCTl1XJowKGL/NZUn9D6nQFPEBWo8XAknfpDn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743683006; c=relaxed/simple;
	bh=3wdRy2WuyXa10CNk3qMyyiz0iXD39XzVC5qfk2+7ryk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdRUf3wVbGxzJOrSbMwSbZHOhC82sVu7f0mvpuvPrrlF4loTMM/v98FwN/YuyWjvP2cDrinbfdhnRYn2AYdzLzcx0lhMa/wwQ0IdEupfMARK+67RKsiZSVjjiwRlfDHJ0yvZ3iVszyvM1btK3rjGusYqukvZlND84r1k+qS7AQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azklJVdM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac25d2b2354so139542466b.1;
        Thu, 03 Apr 2025 05:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743683003; x=1744287803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX0pwBcQH4RFYaZi1MPAb1SdEPoI+rIJh90SI6wiiTk=;
        b=azklJVdM5bCQyLnW/UwSMPHwuo/lclokz8Jeq7a3/rQjli8CCV+LkJ3/mcJvB5ZvLf
         9UMK6zDG8gKpEMQAhlmMGXC+BTAx2BxWqP1Ixq1Fg02Q7stWA+B/47eBuJarRCo8+kNR
         vdhgFK6glEvLbUPj0HP7xyAl9EKqUyk/eSGWRn0JikXB8c/IdbBypSbmZfIBZxY77TX6
         vWUlFTlE8J6HBZr9fpfuQYpofkxrAftufPJPdXD9CeqmSQ0Km/MMAIeqxs0qsZzYe1Jc
         2SKZ6UxOTOPHj65tmQ9mcQ1Ul877ZNQYGWaEIA1cRVckh+Pthi+owlSXNOy4XllIq1Vj
         rFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743683003; x=1744287803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX0pwBcQH4RFYaZi1MPAb1SdEPoI+rIJh90SI6wiiTk=;
        b=Gbczy1cxHLv05aW9OprFrUgD9UPn1fdgU9SnbEX/PKe8ApRWTWpWF7q3/nD/Zk5qrz
         6sbvQo7TDp/hfOYxdziAO5tOG/u9B7N8FLCT/rZ0X+tb/ucaFUg4tEvVi6+qDS066lSc
         xH4+DQUOOEwXtuk/r/skG6ch3zvBRXGZTwFzqQc2fS9iZCgJTziSlL3L4d7etgzSDGol
         xvEXo3QC4mPryUeyd/tZR5i/66uSGREXtV3Ce4sMY04v6RxvkbmW839r6XRxJPfQiJUp
         ddofjIJm/yo/bqWftYHctHqnOwDbVDJ3bhrjYSDsQ7zmrFnfMw+/7ykNLKs3rwV4DYBy
         o9zw==
X-Forwarded-Encrypted: i=1; AJvYcCUp/BJw5+CI6TlFdeJA/fo0Joa936tbMrWDA/9gjpSgz05LnQuCHEVji8Y6n/0Hmsk60VuKTza0PDIFx5hV@vger.kernel.org, AJvYcCWh+1YMTPnd0zBEA1wDXokhFn26NMonqUBOjj1PCigy+gQ9y9w0DWWTq8Wb01lHeCzeoDwTQacQRHZa@vger.kernel.org
X-Gm-Message-State: AOJu0YwJiBTWvf4Tjft9MLNQcdsZ3LTK7kO6zieKvasINmbHFXusUNvV
	DuksyiP+HqGFwS4CSXL9eZAZPv018Lrhhbb6BNuGZWANWqGJySVwCu/4vf5aUhnqLx1y/ACQ3Yi
	ZwLh2S0DYyjQVhsy+GuAb9g27+74=
X-Gm-Gg: ASbGnctXljXrbg8BHvNsvtEYqSlBeHd5ZKhQmNvKcGwK8gOXgKue2mme2vUnZOEe+AX
	zJ0/KDZs50/5VVu6WTRN8C6nqPgkxPBmPDi8UlrfMxZnkpjTt+4CJja3c8hMTeNaGAiiRbKtbif
	QKBIP/C/xB1QR31+swXF3GmAxNdA==
X-Google-Smtp-Source: AGHT+IGSxAUJWx4IzWOpgKJ6tW8Qfj/w7xLZJ8m6aFohxu8XewTX55n+1hh4YujywAlZNT/tm3ATi7xOcj7VVnJcbA8=
X-Received: by 2002:a17:907:9625:b0:ac2:a5c7:7fc9 with SMTP id
 a640c23a62f3a-ac738c13711mr1810681466b.51.1743683002464; Thu, 03 Apr 2025
 05:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401194629.1535477-1-amir73il@gmail.com> <6gjqzfp252aiv6jqsw4tv2gbz7r6cjuiitkv4uzucpl2eotw3s@fmwqa26bjaco>
In-Reply-To: <6gjqzfp252aiv6jqsw4tv2gbz7r6cjuiitkv4uzucpl2eotw3s@fmwqa26bjaco>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Apr 2025 14:23:10 +0200
X-Gm-Features: AQ5f1Jqtm9qd644yXazRJWGehvcz-VQbdYbINHnhpXVatZWjuqrOjbtYgy8NSfI
Message-ID: <CAOQ4uxjOzFzdp-mkzGJAgHSBmSfdUpVJ+4Y1i1BHAq+dCJkQmw@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: Document mount namespace events
To: Alejandro Colomar <alx@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 10:20=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> Hi Amir,
>
> On Tue, Apr 01, 2025 at 09:46:29PM +0200, Amir Goldstein wrote:
> > Used to subscribe for notifications for when mounts
> > are attached/detached from a mount namespace.
> >
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Changes since v1:
> > - Add RVB
> > - Add reference to statx() unique mnt_id (Jan)
> > - Fix description of MARK_MNTNS path (Miklos)
> >
> >  man/man2/fanotify_init.2 | 20 ++++++++++++++++++
> >  man/man2/fanotify_mark.2 | 35 +++++++++++++++++++++++++++++++-
> >  man/man7/fanotify.7      | 44 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 98 insertions(+), 1 deletion(-)
> >
> > diff --git a/man/man2/fanotify_init.2 b/man/man2/fanotify_init.2
> > index 699b6f054..26289c496 100644
> > --- a/man/man2/fanotify_init.2
> > +++ b/man/man2/fanotify_init.2
> > @@ -330,6 +330,26 @@ that the directory entry is referring to.
> >  This is a synonym for
> >  .RB ( FAN_REPORT_DFID_NAME | FAN_REPORT_FID | FAN_REPORT_TARGET_FID ).

See here

> >  .TP
> > +.BR FAN_REPORT_MNT " (since Linux 6.14)"
> > +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> > +This value allows the receipt of events which contain additional infor=
mation
> > +about the underlying mount correlated to an event.
> > +An additional record of type
> > +.B FAN_EVENT_INFO_TYPE_MNT
> > +encapsulates the information about the mount and is included alongside=
 the
> > +generic event metadata structure.
> > +The use of
> > +.BR FAN_CLASS_CONTENT ,
> > +.BR FAN_CLASS_PRE_CONTENT,
> > +or any of the
> > +.B FAN_REPORT_DFID_NAME_TARGET
>
> What do you mean by any of the flags?  Is _NAME_ a placeholder?  If so,
> the placeholder should be in italics:
>
>         .BI FOO_ placeholder _BAR

FAN_REPORT_DFID_NAME_TARGET is a macro for combination
of flags (see above)

None of those flags are allowed together with FAN_REPORT_MNT

>
> > +flags along with this flag is not permitted
> > +and will result in the error
> > +.BR EINVAL .
> > +See
> > +.BR fanotify (7)
> > +for additional details.
> > +.TP
> >  .BR FAN_REPORT_PIDFD " (since Linux 5.15 and 5.10.220)"
> >  .\" commit af579beb666aefb17e9a335c12c788c92932baf1
> >  Events for fanotify groups initialized with this flag will contain
> > diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
> > index da569279b..dab7e1a32 100644
> > --- a/man/man2/fanotify_mark.2
> > +++ b/man/man2/fanotify_mark.2
> > @@ -67,7 +67,8 @@ contains
> >  all marks for filesystems are removed from the group.
> >  Otherwise, all marks for directories and files are removed.
> >  No flag other than, and at most one of, the flags
> > -.B FAN_MARK_MOUNT
> > +.BR FAN_MARK_MNTNS ,
> > +.BR FAN_MARK_MOUNT ,
> >  or
> >  .B FAN_MARK_FILESYSTEM
> >  can be used in conjunction with
> > @@ -99,6 +100,20 @@ If the filesystem object to be marked is not a dire=
ctory, the error
> >  .B ENOTDIR
> >  shall be raised.
> >  .TP
> > +.BR FAN_MARK_MNTNS " (since Linux 6.14)"
> > +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> > +Mark the mount namespace specified by
> > +.IR pathname .
> > +If the
> > +.I pathname
> > +is not a path that represents a mount namespace (e.g.
> > +.BR /proc/ pid /ns/mnt ),
>
> Paths should be in italics, not bold.
>
>         .IR /proc/ pid /ns/mnt ),
>
> > +the call fails with the error
> > +.BR EINVAL .
> > +An fanotify group that is initialized with flag
>
> The fanotify group must have been initialized previously, I assume.  If
> so, I think we should say s/is/have been/.  Or maybe s/is/was/.
>
> > +.B FAN_REPORT_MNT
> > +is required.
> > +.TP
> >  .B FAN_MARK_MOUNT
> >  Mark the mount specified by
> >  .IR pathname .
> > @@ -395,6 +410,24 @@ Create an event when a marked file or directory it=
self has been moved.
> >  An fanotify group that identifies filesystem objects by file handles
> >  is required.
> >  .TP
> > +.BR FAN_MNT_ATTACH ", " FAN_MNT_DETACH " (since Linux 6.14)"
>
> Let's use two separate tags.  We can do like sched_setattr(2):
>
>
>             SCHED_FLAG_UTIL_CLAMP_MIN
>             SCHED_FLAG_UTIL_CLAMP_MAX (both since Linux 5.3)
>                    These flags  indicate  that  the  sched_util_min  or
>                    sched_util_max  fields,  respectively,  are present,
>                    representing the expected minimum and  maximum  uti=E2=
=80=90
>                    lization of the thread.
>
>                    The  utilization  attributes  provide  the scheduler
>                    with boundaries within which it should schedule  the
>                    thread,  potentially informing its decisions regard=E2=
=80=90
>                    ing task placement and frequency selection.
>
> This would be coded as:
>
>         .TP
>         .B FAN_MNT_ATTACH
>         .TQ
>         .BR FAN_MNT_DETACH " (both since Linux 6.14)"
>
> > +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> > +Create an event when a mount was attached to or detached from a marked=
 mount namespace.
>
> Please don't go past 80 columns in source code.  Here, I'd break after
> 'event', for example, and maybe also before 'marked'.
>
> > +An attempt to set this flag on an inode, mount or filesystem mark
>
> If I'm reading this correctly, I think you should add a comma after
> 'mount'.
>
> > +will result in the error
> > +.BR EINVAL .
> > +An fanotify group that is initialized with flag
> > +.B FAN_REPORT_MNT
> > +and the mark flag
> > +.B FAN_MARK_MNTNS
> > +are required.
> > +An additional information record of type
> > +.B FAN_EVENT_INFO_TYPE_MNT
> > +is returned with the event.
> > +See
> > +.BR fanotify (7)
> > +for additional details.
> > +.TP
> >  .BR FAN_FS_ERROR " (since Linux 5.16, 5.15.154, and 5.10.220)"
> >  .\" commit 9709bd548f11a092d124698118013f66e1740f9b
> >  Create an event when a filesystem error
> > diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> > index 77dcb8aa5..a2f766839 100644
> > --- a/man/man7/fanotify.7
> > +++ b/man/man7/fanotify.7
> > @@ -228,6 +228,23 @@ struct fanotify_event_info_pidfd {
> >  .EE
> >  .in
> >  .P
> > +In cases where an fanotify group is initialized with
> > +.BR FAN_REPORT_MNT ,
> > +event listeners should expect to receive the below
> > +information record object alongside the generic
>
> I'd break the sentence after 'receive' and before 'alongside'.
>
> > +.I fanotify_event_metadata
> > +structure within the read buffer.
> > +This structure is defined as follows:
> > +.P
> > +.in +4n
> > +.EX
> > +struct fanotify_event_info_mnt {
> > +    struct fanotify_event_info_header hdr;
> > +    __u64 mnt_id;
> > +};
> > +.EE
> > +.in
> > +.P
> >  In case of a
> >  .B FAN_FS_ERROR
> >  event,
> > @@ -442,6 +459,12 @@ A file or directory that was opened read-only
> >  .RB ( O_RDONLY )
> >  was closed.
> >  .TP
> > +.BR FAN_MNT_ATTACH
> > +A mount was attached to mount namespace.
> > +.TP
> > +.BR FAN_MNT_DETACH
> > +A mount was detached from mount namespace.
> > +.TP
> >  .B FAN_FS_ERROR
> >  A filesystem error was detected.
> >  .TP
> > @@ -540,6 +563,7 @@ The value of this field can be set to one of the fo=
llowing:
> >  .BR FAN_EVENT_INFO_TYPE_FID ,
> >  .BR FAN_EVENT_INFO_TYPE_DFID ,
> >  .BR FAN_EVENT_INFO_TYPE_DFID_NAME ,
> > +.BR FAN_EVENT_INFO_TYPE_MNT ,
> >  .BR FAN_EVENT_INFO_TYPE_ERROR ,
> >  .BR FAN_EVENT_INFO_TYPE_RANGE ,
> >  or
> > @@ -727,6 +751,26 @@ in case of a terminated process, the value will be
> >  .BR \-ESRCH .
> >  .P
> >  The fields of the
> > +.I fanotify_event_info_mnt
> > +structure are as follows:
> > +.TP
> > +.I .hdr
> > +This is a structure of type
> > +.IR fanotify_event_info_header .
> > +The
> > +.I .info_type
> > +field is set to
> > +.BR FAN_EVENT_INFO_TYPE_MNT .
> > +.TP
> > +.I .mnt_id
> > +Identifies the mount associated with the event.
> > +It is a 64bit unique mount id as the one returned by
>
> s/64bit/64-bit/
>
> > +.BR statx (2)
> > +with the
> > +.BR STATX_MNT_ID_UNIQUE
>
> s/BR/B/
>

Fixed all.

Let me know if you are happy with my clarification on
FAN_REPORT_DFID_NAME_TARGET

and I will post v3.

Thanks,
Amir.

