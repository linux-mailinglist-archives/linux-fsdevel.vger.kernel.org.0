Return-Path: <linux-fsdevel+bounces-36844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C19C9E9C83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 18:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762861888E5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DC614F9EE;
	Mon,  9 Dec 2024 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EcgIjACh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3414F121
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763741; cv=none; b=Z+oCqo9cNUzvDdum00KkCQKvXBQK3s3N/VnFKHGjBJPWENiPf3wNYEilP0MKU+pmqj9SfYxEKNBiSVZixj9BAhbdOYVhVYs5NZszgO8hdN+/IElty4xolPRmO+d5aZmhz+Xgt7s+NmvuiPM1NdA4HryfRFJ96Y6SserLRjpjX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763741; c=relaxed/simple;
	bh=GeFHkLfAgP3ElS53iID8it/8M3ukGxedur1sttkud94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3mtwH35hkozS8fvOB1/8uDehVWvyLNjVd0c+QQrIB4IGW0GqdQAEX9Ey60LleOzIORx0IpoGZao+VzBw2HfFZMWJgxb2sfnbdp/8VbkVBvsErSr9gmrmuV7M2vhknK3fwz1RNTwr0/fMgv4QvmC0XPYqLzDOK63puDyz21FUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EcgIjACh; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467631f3ae3so7661011cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 09:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1733763737; x=1734368537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NPJ5X+nvJru6KQSIO0EekHOkp263+8acp1+Ic7dTJnQ=;
        b=EcgIjAChCRwlhSIOjOaaHtJJsZy1JExyQyRPwhxHxzNcZrVAQ1/OgFuRu5ofxX6vRj
         +Bkar+I/Rc3/f7FXGUKUsoyq6r9IUW+fri4LT9bdF0Grf/7PwxasawHgKcdaMD1jbSg3
         YwW6Kw8aGNI33xWXl6EV+3330izeM/csI19YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763737; x=1734368537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPJ5X+nvJru6KQSIO0EekHOkp263+8acp1+Ic7dTJnQ=;
        b=Ib8796L0x5JXWr00E9bPTDDIXu9r1RbrymTyv8W+Gl3zleUESArnDaK1V8iYWpiDS7
         Tsfop9cmZnqQEaNV4BsPNhgdr67rtb5se73iYjVCJqpOxviUjLvFolAdDJD+0H8Ev+M9
         c9oVRsUqQ1deUBZI2mlYmmzZ1GnsfdWk/2BIJ4IWyVG5GMqK6qUTZrEVryRx0YOBbXFL
         GDOYScLnPa/XQIXM5Q/SQUAvgSa5pCZQQVysObFlU0ruS/Vg9ESDX/mHVF6ydte04uTZ
         YJa89KQqsIEcR5vFLB7HfKG6lCPfaueTRHT2HvjEpKw05gMc/o1/+yzSq1luoKpwwipu
         hhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgEpmZoRruPXr1x6RoyzAzjfaYBX3lIH+k9epEF944gJ3OvSYLc0Iq2aM0T6fbhb/uQ2u3QRor8LzJfaIw@vger.kernel.org
X-Gm-Message-State: AOJu0Yyga94pVtWPaEX/80d2zMfOvlABPGp0BEVmM8GIuYuCubG/2CPW
	04HhX4Z7BmUOqoOMrw8OJKm8WIog4NBXZN1xR/PIxESCTFBXNQkAE8Cqu5i0RZwdf5Ic8sgJMua
	eKKB1El0+CplEMdfFgIthhVPeFFsDAwknxZDQHQ==
X-Gm-Gg: ASbGncu5ut0UHewO3w1A+6nHmMvPgeWvPfh4/M/HiyoPqLh2Quli14+vbsTaEh5dNWd
	ZaTxYWEIh7CUurOVsyXjnrzlvpTJhXgA=
X-Google-Smtp-Source: AGHT+IFQttTNm5nr9ZNhhPKyN6E92TFInxmqnzSuuxa46e5GI7BZGolQWCKpkgYQgzmbBejLzNYpwQfP0sa2hzFP038=
X-Received: by 2002:a05:622a:205:b0:462:b36a:73b8 with SMTP id
 d75a77b69052e-46734f76d8amr220489621cf.43.1733763737081; Mon, 09 Dec 2024
 09:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206151154.60538-1-mszeredi@redhat.com> <20241207-zucken-bogen-7a3d015af168@brauner>
In-Reply-To: <20241207-zucken-bogen-7a3d015af168@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 9 Dec 2024 18:02:06 +0100
Message-ID: <CAJfpegtdtKgA+JQY7q-bj0YkCaROQ7BRrJr+4ro16RWbcuD7Gg@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Dec 2024 at 22:26, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Dec 06, 2024 at 04:11:52PM +0100, Miklos Szeredi wrote:

> I wanted to see how feasible this would be and so I've added my changes
> on top of your patch. Please see the appended UNTESTED DIFF.

Why a separate list for connected unmounts and for mounts?  Can't the
same list be used for both?

> > +static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt, struct list_head *notif)
> > +{
> > +     __mnt_add_to_ns(ns, mnt);
> > +     queue_notify(ns, mnt, notif);
>
> All but one call to mnt_add_to_ns() passes NULL. I would just add a
> mnt_add_to_ns_notify() helper and leave all the other callers as is.

Still need the else branch from queue_notify() otherwise the prev_ns
logic breaks.

>
> >  void dissolve_on_fput(struct vfsmount *mnt)
> >  {
> >       struct mnt_namespace *ns;
> > +     LIST_HEAD(notif);
> > +
> >       namespace_lock();
> >       lock_mount_hash();
> >       ns = real_mount(mnt)->mnt_ns;
> >       if (ns) {
> >               if (is_anon_ns(ns))
> > -                     umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
> > +                     umount_tree(real_mount(mnt), &notif, UMOUNT_CONNECTED);
>
> This shouldn't notify as it's currently impossible to place mark on an
> anonymous mount.

Yeah, I was first undecided whether to allow notification on anon
namespaces, but then opted not to for simplicity.

> > @@ -1855,8 +1906,18 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
> >               mnt = path.mnt;
> >               if (mark_type == FAN_MARK_MOUNT)
> >                       obj = mnt;
> > -             else
> > +             else if (mark_type == FAN_MARK_FILESYSTEM)
> >                       obj = mnt->mnt_sb;
> > +             else /* if (mark_type == FAN_MARK_MNTNS) */ {
> > +                     mntns = get_ns_from_mnt(mnt);
>
> I would prefer to be strict here and require that an actual mount
> namespace file descriptor is passed instead of allowing the mount
> namespace to be derived from any file descriptor.

Okay.

>
> > +                     ret = -EINVAL;
> > +                     if (!mntns)
> > +                             goto path_put_and_out;
> > +                     /* don't allow anon ns yet */
> > +                     if (is_anon_ns(mntns))
> > +                             goto path_put_and_out;
>
> Watching an anoymous mount namespace doesn't yet make sense because you
> currently cannot add or remove mounts in them apart from closing the
> file descriptor and destroying the whole mount namespace. I just
> remember that I have a pending patch series related to this comment. I
> haven't had the time to finish it with tests yet though maybe I can find
> a few days in December to finish the tests...

Okay.

>
> > @@ -549,8 +549,10 @@ static void restore_mounts(struct list_head *to_restore)
> >                       mp = parent->mnt_mp;
> >                       parent = parent->mnt_parent;
> >               }
> > -             if (parent != mnt->mnt_parent)
> > +             if (parent != mnt->mnt_parent) {
> > +                     /* FIXME: does this need to trigger a MOVE fsnotify event */
> >                       mnt_change_mountpoint(parent, mp, mnt);
>
> This is what I mentally always referred to as "rug-pulling umount
> propagation". So basically for the case where we have a locked mount
> (stuff that was overmounted when the mntns was created) or a mount with
> children that aren't going/can't be unmounted. In both cases it's
> necessary to reparent the mount.
>
> The watcher will see a umount event for the parent of that mount but
> that's not enough information because the watcher could end up infering
> that all child mounts of the mount have vanished as well which is
> obviously not the case.
>
> So I think that we need to generate a FS_MNT_MOVE event for mounts that
> got reparented.

Yep.

Thanks,
Miklos

