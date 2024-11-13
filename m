Return-Path: <linux-fsdevel+bounces-34656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862269C736C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164071F24840
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F3D1DED47;
	Wed, 13 Nov 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHZGnl0b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620743172
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507784; cv=none; b=hp1xY95qp23/o+3EhQnNRnelXulP7Q3WN8O+ITIfAxlhiwAae23VMag47tn6Ilb/vyN13JQ7corloxpxp8FvRyTNZvYSRyacsdx+NEu72PrFrYoPcJs3RFk5Opqb4rje8mXKulqMimydgSZTrfsrE84YqJzINLsRCNgIilOSFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507784; c=relaxed/simple;
	bh=4CyQiEdL2c8KiwGST9txTXLH4epeCx/tfQVdC1qY3QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnvYskWEGMsW5Q/uD0rFZIeh3IPcLz7aqcaS2mc3bR/CUqmfUHgkoo3+/9o5RQrOlQbrQRqmDz675DwWx4IhB0LduTxuQB8qzAtydvU+eBvGAhxQYxorkCsAMXZBzNuhT+8Ihy1Z2q5sbJCqLWWPyK6yi8YVDLgVNmjSX82rcFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHZGnl0b; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46090640f0cso54250111cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 06:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731507782; x=1732112582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCXf7IqFOg+ASSUZwiTGHoCyyONcyvP/zTe0dzKyR1s=;
        b=EHZGnl0b/At4k9J3mU3B7Gm9oNEzsmERYXATAm54M1XrR9WYvrb55jCcWaPwe/6zzY
         ygm0X/Lf9Jx+CErqfLDmJnOXzhBKLDflZc5VZsP7NddSkVJQmtSzHKkfoa8PaspAMZ3D
         cOoSkO6z/rBlprE68NNSAYp3N2+E4zmkGRWt03ZXBT9sgpU22uSDpPIIltpjcKH/VOls
         KECLSn3GHML9JNxQ0xqH3peuEQh5kGxANkV4Eu3jKGtzUR1eo9MHOIL413yy1jlzjOag
         I7RUF6qGA/wcmegFFjgk8VnEZA42ll/Ssl0N8YTg6mj6M0/o8lGI6cWLFNdHz7mXvHUE
         ZutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731507782; x=1732112582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCXf7IqFOg+ASSUZwiTGHoCyyONcyvP/zTe0dzKyR1s=;
        b=A5INC6Cpp3IDjafupqVeYFoEbFto99xg4En9q2I/r/nZJ8E0dEa2Sck3jNU74RIj/J
         Bbx8ppVVuEdowaINs6O06u2fuJ2BpljWZtBF7ndXqgGDG6s0u4Jki5ElFIT8n04qQchW
         WjX5HAEdzEgAgLPRvBUs3pM5CBSMIdQMR/LRNRUKAmoaLjXBsphvcT/5u97eRbLbcAfv
         C1a/3Cfg4q8OIyceyPhvoa2TQFSKcLEMSWoqezMN0fVH2hLnTyJg94L3Un62hYkUvFQX
         qKoWSPNOp2Gd0XtW5I9j7o6KqAPvK5sQJlUe4KuAJBhg7uJ12oriYFz6vyZf0+vS++pB
         BuzA==
X-Forwarded-Encrypted: i=1; AJvYcCUfv3fU4cccNEIuCYAsyTW89ZE7kz9HkpnTsdWgkeKPG8qu0rTOYBhPEjkza/tUb6LaPsvzgLvdJX8ivkE3@vger.kernel.org
X-Gm-Message-State: AOJu0YyctAFHgHnDqJ6b8BCPYbyFX7GAGfk6CIqfMWev4pVTeQqJtgKA
	SJy10+xbEnSMcqYZ2ebwjcDMK/Ai0JAYZA7nXGiZl4oZGuE/ghwc3preALPCeismIkk9DxaDadB
	ZY56LY6gcpYMYNIjSByEMzfigL6I=
X-Google-Smtp-Source: AGHT+IEnCan7koQW8EvhcxQnoWrqheIrxqXMlwg5y0x8lr0IrTi1mdbK8u8amhThkO9lv99KD6bbe1rY9Hke/cXfEfI=
X-Received: by 2002:a05:622a:19a8:b0:458:5ed8:628 with SMTP id
 d75a77b69052e-46309319366mr280576651cf.2.1731507781518; Wed, 13 Nov 2024
 06:23:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111201101.177412-1-amir73il@gmail.com> <20241113134258.524nduvn3piqqkco@quack3>
In-Reply-To: <20241113134258.524nduvn3piqqkco@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 15:22:50 +0100
Message-ID: <CAOQ4uxhswHmgJ0fxVp2PKvkYuVO0uX9rzoGs8HZt2mVBDcfQTA@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: fix sending inotify event with unexpected filename
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 2:43=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 11-11-24 21:11:01, Amir Goldstein wrote:
> > We got a report that adding a fanotify filsystem watch prevents tail -f
> > from receiving events.
> >
> > Reproducer:
> >
> > 1. Create 3 windows / login sessions. Become root in each session.
> > 2. Choose a mounted filesystem that is pretty quiet; I picked /boot.
> > 3. In the first window, run: fsnotifywait -S -m /boot
> > 4. In the second window, run: echo data >> /boot/foo
> > 5. In the third window, run: tail -f /boot/foo
> > 6. Go back to the second window and run: echo more data >> /boot/foo
> > 7. Observe that the tail command doesn't show the new data.
> > 8. In the first window, hit control-C to interrupt fsnotifywait.
> > 9. In the second window, run: echo still more data >> /boot/foo
> > 10. Observe that the tail command in the third window has now printed
> > the missing data.
> >
> > When stracing tail, we observed that when fanotify filesystem mark is
> > set, tail does get the inotify event, but the event is receieved with
> > the filename:
> >
> > read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\20\0\0\0foo\0\0\0\0\0\0\0\0\0\0\0\0\0=
",
> > 50) =3D 32
> >
> > This is unexpected, because tail is watching the file itself and not it=
s
> > parent and is inconsistent with the inotify event received by tail when
> > fanotify filesystem mark is not set:
> >
> > read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0", 50) =3D 16
> >
> > The inteference between different fsnotify groups was caused by the fac=
t
> > that the mark on the sb requires the filename, so the filename is passe=
d
> > to fsnotify().  Later on, fsnotify_handle_event() tries to take care of
> > not passing the filename to groups (such as inotify) that are intereste=
d
> > in the filename only when the parent is watching.
> >
> > But the logic was incorrect for the case that no group is watching the
> > parent, some groups are watching the sb and some watching the inode.
> >
> > Reported-by: Miklos Szeredi <miklos@szeredi.hu>
> > Fixes: 7372e79c9eb9 ("fanotify: fix logic of reporting name info with w=
atched parent")
> > Cc: stable@vger.kernel.org # 5.10+
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Thanks for analysis, Amir!
>
> > @@ -333,12 +333,14 @@ static int fsnotify_handle_event(struct fsnotify_=
group *group, __u32 mask,
> >       if (!inode_mark)
> >               return 0;
> >
> > -     if (mask & FS_EVENT_ON_CHILD) {
> > +     if (mask & FS_EVENTS_POSS_ON_CHILD) {
>
> So this is going to work but as far as I'm reading the code in
> fsnotify_handle_event() I would be maybe calmer if we instead wrote the
> condition as:
>
>         if (!(mask & ALL_FSNOTIFY_DIRENT_EVENTS))

The problem is that the comment below
"Some events can be sent on both parent dir and child marks..."
is relevant in the context of FS_EVENTS_POSS_ON_CHILD
and FS_EVENT_ON_CHILD, meaning those are exactly the set of
events that could be sent to parent with FS_EVENT_ON_CHILD
and to child without it.

The comment makes no sense in the context of the
ALL_FSNOTIFY_DIRENT_EVENTS check,
Unless we add a comment saying the dirent events set has
zero intersection with events possible on child.

>
> I.e., if the event on the inode is not expecting name & dir, clear them.
> Instead of your variant which I understand as: "if we could have added na=
me
> & dir only for parent, clear it now". The bitwise difference between thes=
e
> two checks is: FS_DELETE_SELF | FS_MOVE_SELF | FS_UNMOUNT | FS_Q_OVERFLOW=
 |
> FS_IN_IGNORED | FS_ERROR, none of which should matter. Maybe I'm paranoid
> but we already had too many subtle bugs in this code so I'm striving for
> maximum robustness :). What do you think?

How about a
BUILD_BUG_ON(FS_EVENTS_POSS_ON_CHILD & ALL_FSNOTIFY_DIRENT_EVENTS)
with a comment to clarify?

> BTW, I can just massage the patch on commit since you're now busy with HS=
M
> stuff but I wanted to check what's your opinion on the change.

Sure, no problem.

Thanks,
Amir.

