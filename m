Return-Path: <linux-fsdevel+bounces-37193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37059EF585
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B341194095E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31298223E60;
	Thu, 12 Dec 2024 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo+gA/zs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A944A13792B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022665; cv=none; b=JFo+RDGa/CTJaKSBUJV867A50ijQrCCo3TuMewmXrlyH5K04IwNWmoKic5PTf76zkOLaB4gLl8BgoDi5v/6yUghnVPbMh2HSH5HBD+gfcs3CLbQIdcNP9cgiOa134gMq7FbWcJViC3KFwd3A1cm0sjwJW6CjUseTs/7yKkuA460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022665; c=relaxed/simple;
	bh=lSG8AFhJYnyW0d18t+fc9TVHqSlpjhpDMBhdOpWSRRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAWoOY/y0JHNbpiKvilM58iPKEpudQmVUrSqcGEvbfTxWy+K6mOtRtE8v2+7qYRoT+Y/x4Q2MAhcgQlgoskLOYaFvB87Lu9GpOEh6dbYB+O9hDmRS7OzSjw6nuZxaLnF7TXzQ7pqR7GTYrNSePM2eqSXnpaPBaeEY0H8OMdOblQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo+gA/zs; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so1115111a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734022662; x=1734627462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATzC1MkuaDB7JYqNIVEAvRvf/gRz/pnc0JpJOc1LuRE=;
        b=bo+gA/zsrlut8/FRIJn4dAts4ZG3gimgR/umY7N9yhOi6l+mAgTvPOjvDFETFSjupZ
         kuHYMCXyk5ncPikmLxwiU0QUBixCP4xkitngg/Jf5SnOgQlMstwELHZ1eyBBhDoRAxz2
         Xtq+EZfTSL9ATLJiieqJq6JtZGjx9phTLniE0SN1snWN6DnOPabkfc5znu2AyUyMEzrX
         GqhJPnpTzE+B1PJQHoWGfM8uLC7HgiJ58YEP/n/AjBFkPeOcDhQBc43p1cgjHl1dbems
         MAFt8ynKfEGoj4tk38W/U6wgxd2tTzt89gEqYPyvmPJzsek4N4nTQen26l/GEoio5vH9
         S7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734022662; x=1734627462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATzC1MkuaDB7JYqNIVEAvRvf/gRz/pnc0JpJOc1LuRE=;
        b=gK34l4YM5VtfeVkvGq3bHYCFZ18rLcfHdZGI2oNtrUUNFRWl5uiiEfqor1xyUgJXx9
         AvcV3yqqlZS7Xf3OQce7K68IbMmk4KHyJ/zqD7ru7e3Ign4RvxQn+ixWdAvmPP9SNZgy
         Ze6RAXP6hF1MXtycIo1vraIxeQBSwlbFWDqyc0fsBPY9DwgEFJFpvQ8zCzksXEKgwGoK
         Fp0gbyggHcz7KaPySzFVL/mY+lN58Mj4X3fdkxGnoxL+8cW8OOibdY4rqVeKsIKJQpwi
         5ZhJXz1YyfQyr5CjziRayJI9pulTzwf/3Klwl5xife80E/Lk/ZCPAElquXtV967CK7z9
         WUAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1uBgtoTpLWv6VI8B0iHn2OIJ8nX1oqceIWDm9SVI28ajyDptnDpTpvpo+hXTG8CEkyNnimCKuLgPNfiJU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Xnia08LK2pQLv9JX6B635YATMwv1YgRCt6D5hEWHjzcLfHaB
	eAFQwpA2GcGJQZbU5kb8yqxLGuWyhbBokYvN6dIeNQHDLw+k1Sm0/wI2n9Ngqtc0LUG2uECWRZH
	HQ1WtZpBnI6G3zXrAfYFQSbuQvug=
X-Gm-Gg: ASbGnctHB04xTHF++KYiQihd7EqJ8SPbT6D3G1YCOHtABL1oM/dmx0cBht5JQfzAJli
	BbDhmgA5q1JHB4ADlg5jYDA7eBjsuGJxYrOTckQ==
X-Google-Smtp-Source: AGHT+IFn6D5rj0NF5vhUvrN31NsU2Uf2Yu42r1XVq72eKtcympGIgALUBboOAPelMwcAddzq4hsuyyUQo/FQAT45D8g=
X-Received: by 2002:a05:6402:35ca:b0:5d0:e877:764e with SMTP id
 4fb4d7f45d1cf-5d6334f69a2mr1083493a12.24.1734022661492; Thu, 12 Dec 2024
 08:57:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211153709.149603-1-mszeredi@redhat.com> <20241212112707.6ueqp5fwgk64bry2@quack3>
 <CAJfpeguN6bfPa1rBWHFcA4HhCCkHN_CatGB4cC-z6mKa_dckWA@mail.gmail.com>
 <CAOQ4uxhNCg53mcNpzDyos3BV5dmL=2FVAipb4YKYmK3bvEzaBQ@mail.gmail.com> <20241212160411.xzdp64o3v2ilxsf5@quack3>
In-Reply-To: <20241212160411.xzdp64o3v2ilxsf5@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Dec 2024 17:57:29 +0100
Message-ID: <CAOQ4uxgOpJx23bXWPitF3X11hsuQr8GvA1zvP1KA1ved6+O2jA@mail.gmail.com>
Subject: Re: [PATCH v3] fanotify: notify on mount attach and detach
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Karel Zak <kzak@redhat.com>, Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:04=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 12-12-24 16:02:16, Amir Goldstein wrote:
> > On Thu, Dec 12, 2024 at 1:45=E2=80=AFPM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> > >
> > > On Thu, 12 Dec 2024 at 12:27, Jan Kara <jack@suse.cz> wrote:
> > >
> > > > Why not:
> > > >         if (p->prev_ns =3D=3D p->mnt_ns) {
> > > >                 fsnotify_mnt_move(p->mnt_ns, &p->mnt);
> > > >                 return;
> > > >         }
> > >
> > > I don't really care, but I think this fails both as an optimization
> > > (zero chance of actually making a difference) and as a readability
> > > improvement.
>
> I was just staring at the code trying to understand why you special-case
> the situations with non-existent prev / current ns until I understood
> there's no real reason. But I agree it's a matter of a taste so I'm fine
> with keeping things as you have them.
>
> > > > > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/f=
anotify.c
> > > > > index 24c7c5df4998..a9dc004291bf 100644
> > > > > --- a/fs/notify/fanotify/fanotify.c
> > > > > +++ b/fs/notify/fanotify/fanotify.c
> > > > > @@ -166,6 +166,8 @@ static bool fanotify_should_merge(struct fano=
tify_event *old,
> > > > >       case FANOTIFY_EVENT_TYPE_FS_ERROR:
> > > > >               return fanotify_error_event_equal(FANOTIFY_EE(old),
> > > > >                                                 FANOTIFY_EE(new))=
;
> > > > > +     case FANOTIFY_EVENT_TYPE_MNT:
> > > > > +             return false;
> > > >
> > > > Perhaps instead of handling this in fanotify_should_merge(), we cou=
ld
> > > > modify fanotify_merge() directly to don't even try if the event is =
of type
> > > > FANOTIFY_EVENT_TYPE_MNT? Similarly as we do it there for permission=
 events.
> > >
> > > Okay.
> >
> > Actually, I disagree.
> > For permission events there is a conceptual reason not to merge,
> > but this is not true for mount events.
> >
> > Miklos said that he is going to add a FAN_MOUNT_MODIFY event
> > for changing mount properties and we should very much merge multiple
> > mount modify events.
> >
> > Furthermore, I wrote my comment about not merging mount events
> > back when the mount event info included the parent mntid.
> > Now that the mount event includes only the mount's mntid itself,
> > multiple mount moves *could* actually be merged to a single move
> > and a detach + attach could be merged to a move.
> > Do we want to merge mount move events? that is a different question
> > I guess we don't, but any case this means that the check should remain
> > where it is now, so that we can check for specific mount events in the
> > mask to decide whether or not to merge them.
>
> Ok, fair enough. What triggered this request was that currently we just
> look at each event in the queue, ask for each one "can we merge" only to
> get "cannot" answer back. Which seemed dumb. But if we are going to add
> events that can be merged, this reason obviously doesn't hold anymore. So
> I'm retracting my objection :)
>
> > > > > @@ -303,7 +305,11 @@ static u32 fanotify_group_event_mask(struct =
fsnotify_group *group,
> > > > >       pr_debug("%s: report_mask=3D%x mask=3D%x data=3D%p data_typ=
e=3D%d\n",
> > > > >                __func__, iter_info->report_mask, event_mask, data=
, data_type);
> > > > >
> > > > > -     if (!fid_mode) {
> > > > > +     if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
> > > > > +     {
> > > >
> > > > Unusual style here..
> > >
> > > Yeah, fixed.
> > >
> > > > Now if we expect these mount notification groups will not have more=
 than
> > > > these two events, then probably it isn't worth the hassle. If we ex=
pect
> > > > more event types may eventually materialize, it may be worth it. Wh=
at do
> > > > people think?
> > >
> > > I have a bad feeling about just overloading mask values.  How about
> > > reserving a single mask bit for all mount events?  I.e.
> > >
> > > #define FAN_MNT_ATTACH 0x00100001
> > > #define FAN_MNT_DETACH 0x00100002
> >
> > This is problematic.
> > Because the bits reported in event->mask are often masked
> > using this model makes assumptions that are not less risky
> > that the risk of overloading 0x1 0x2 IMO.
> >
> > I was contemplating deferring the decision about overloading for a whil=
e
> > by using high bits for mount events.
> > fanotify_mark() mask is already 64bit with high bits reserved
> > and fanotify_event_metadata->mask is also 64bit.
>
> Oh, right, fanotify API actually has a plenty of bits. I forgot that the
> type is different from the generic one in fsnotify. Thanks for reminding
> me!
>
> > The challenge is that all internal fsnotify code uses __u32 masks
> > and so do {i,sb,mnt}_fsnotify_mask.
>
> Yeah, including struct fanotify_event.
>
> > However, as I have already claimed, maintaining the mount event bits
> > in the calculated object mask is not very helpful IMO.
> >
> > Attached demo patch that sends all mount events to group IFF
> > group has a mount mark.
> >
> > This is quite simple, but could also be extended later with a little
> > more work to allow sb/mount mark to actually subscribe to mount events
> > or to ignore mount events for a specific sb/mount, if we think this is =
useful.
>
> So I like the prospect of internal event type eventually becoming 64-bit
> but I don't think we should tie it to this patch set given we still have =
7
> bits left in the internal mask. Also if we do the conversion, I'd like to
> go full 64-bit except for the very few places that have a good reason so
> stay 32-bit. Because otherwise it's very easy to loose the upper bits
> somewhere. So what we could do is to allocate the new FAN_MNT_ constants
> from the upper 32 bits, for now leave FS_MNT_ in the lower 32 bits, and d=
o
> the conversions as I've mentioned. When we really start running out of
> internal mask bits, we can implement the 64-bit event constant handling i=
n
> fsnotify core and move FS_MNT_ constants in the upper bits.
>

Fair enough.
As long as I get to call dibs on the planned HSM event bits ;)

So please shift the FS_MNT_ event bits one nibble left, so we can have this=
:

 #define FS_OPEN_PERM           0x00010000      /* open event in an
permission hook */
 #define FS_ACCESS_PERM         0x00020000      /* access event in a
permissions hook */
 #define FS_OPEN_EXEC_PERM      0x00040000      /* open/exec event in
a permission hook */

#define FS_PATH_MODIFY         0x00080000      /* Path pre-modify HSM hook =
*/
#define FS_PRE_ACCESS          0x00100000      /* File pre-access HSM hook =
*/
#define FS_PRE_MODIFY          0x00200000      /* File pre-modify HSM hook =
*/
#define FS_PATH_ACCESS         0x00400000      /* Path pre-lookup HSM hook =
*/

#define FS_MNT_ATTACH          0x01000000      /* Mount was attached */
#define FS_MNT_DETACH          0x02000000      /* Mount was detached */
#define FS_MNT_MODIFY          0x04000000      /* Mount was modified */

Thanks,
Amir.

