Return-Path: <linux-fsdevel+bounces-11124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77339851769
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 15:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C096B23DE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D403BB27;
	Mon, 12 Feb 2024 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg9F2EkX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04873B297
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749802; cv=none; b=dG6xrd4329iayK8nhck3IcK4iPigGRX4AZEQHiAbfponlGpk2dkprm/1i0hrLoAq0WPcLldGrV0Xyv5QIEOqRc2EAeghw9BfyUj+Yw7xaCsj5YmrLyj0vQYmujeOftTScj0vWOhjm7CVcCTPj5jPRLA1Wg07i/6Nm+LAPPCXWhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749802; c=relaxed/simple;
	bh=4sQEY5r6P2rp05XgxyO5yo6fu2md40GjshfbZvN7gUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqWgOpoKYsvsFkA+zwQpZawcbLY1ROo/YZAcOsPBqpM8wWYVRILiGwJyXwIfQbLu6DSTuYYB6VOTbhBLmb5mXFFruFbuF0/EKHP7VzcUBo1Q6+CWCGIGjScWSKaIAzdszNY749VOOtHScwoAkXXJCq2+9touLbWSj4wWXUaMeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jg9F2EkX; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a8a398cb2so22118201cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 06:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707749800; x=1708354600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jU8T2Hls5Ium/JMl9aW0l4xQkWFl5hF8EylbzofXA8=;
        b=Jg9F2EkXLZJlSAxZRBgC5rezapun1F1WznC5jk78l2HUvpM/0D1zt4VAs/eGSLqIV+
         FX4LwgD+AJxtQf2FuYYHGakVfAjrjkrhV1SpfqzqtB0aoYg+X1PxrOQEg8uXWI/DdHD0
         h8io3dWKXrEiCHKIrJGgELbQCe+64q8AuNOS8VVLfmB6+Jt9WME2+I424uC4S99iFJzw
         tCipAAHwHtZ+ShUFzWmWWpZksJP43Y5hrd1+5GdpBRMrSZVkExiqHWorTMCStNvStx6V
         ZY7tEv2EfrOtX4apYuxJqUe3ZUunC97MuaSPZXVFFWaBC0vDWtcByZVEWWKge6hrHKVp
         2NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707749800; x=1708354600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jU8T2Hls5Ium/JMl9aW0l4xQkWFl5hF8EylbzofXA8=;
        b=AjzmHd7frb/KgMw69t2JBVzv/2yfhJGglMFQHkwfHp+KSRBjqtD16JyugUzTANi3qf
         fAeEkbjM46noOKDoVs/h3TWtEa8v8lSU10lEtf1fqontsWxLzZ3BIh4oinGuCM6EqE9G
         NcpIL3J3/XAR5HmCrF3a1SzdALpJbPCGv/wUbKo3RlIj2cooLfoQgUYTM7tCw2lTh0S9
         ETUhPMqiIgqfwQVUGKAnt01uEY4G9AEPvA98Q37Ovce11io/8luIa04s8vxwnQbpw3o7
         /pE+JVIrmugp5m6q9WmLjEmUq0+LiHh884Z7tR8GRjEs+cAtSnkOe9Cad7oRz+4Y5eDH
         Ei3A==
X-Forwarded-Encrypted: i=1; AJvYcCXJjoCAfLCZaDt5HQCdoIVMt1LHCfVXW3eQxq8yy87Rg5NKFSgQFegTqhh300hELrWP39oOgf0r61iYGddN6JemOQJ7ofBZ3oQKTWgYyQ==
X-Gm-Message-State: AOJu0YwhTDfPV+oqkT+dKenFbAn8eW0c33CrevMpvmEU9AmMZ8Z6rhfk
	GAAQ3BhjnoeeYh+LaxKt3ZtUeDNv1oexXi9BCU3828X7miWfmf9u33jCc0C6javfvA4VBqnObUm
	yuQFFKjV0fDnnEtoIHZWCsQyOsng=
X-Google-Smtp-Source: AGHT+IEHNZiMoov2AsXBkt/jER+U3N5DXIhAwPLEbddAMvIFZ1fo5s0zOr3BYmnAr2xPzzF/YB6UxSuh1+ql7oDE8dE=
X-Received: by 2002:a05:622a:8f:b0:42c:7037:4f02 with SMTP id
 o15-20020a05622a008f00b0042c70374f02mr5737721qtw.53.1707749799632; Mon, 12
 Feb 2024 06:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215153108.GC683314@perftesting> <CAOQ4uxjVuhznNZitsjzDCanqtNrHvFN7Rx4dhUEPeFxsM+S22A@mail.gmail.com>
 <20231218143504.abj3h6vxtwlwsozx@quack3> <CAOQ4uxjNzSf6p9G79vcg3cxFdKSEip=kXQs=MwWjNUkPzTZqPg@mail.gmail.com>
 <CAOQ4uxgxCRoqwCs7mr+7YP4mmW7JXxRB20r-fsrFe2y5d3wDqQ@mail.gmail.com>
 <20240205182718.lvtgfsxcd6htbqyy@quack3> <CAOQ4uxgMKjEMjPP5HBk0kiZTfkqGU-ezkVpeS22wxL=JmUqhuQ@mail.gmail.com>
 <CAOQ4uxhvCbhvdP4BiLmOw5UR2xjk19LdvXZox1kTk-xzrU_Sfw@mail.gmail.com>
 <20240208183127.5onh65vyho4ds7o7@quack3> <CAOQ4uxiwpe2E3LZHweKB+HhkYaAKT5y_mYkxkL=0ybT+g5oUMA@mail.gmail.com>
 <20240212120157.y5d5h2dptgjvme5c@quack3>
In-Reply-To: <20240212120157.y5d5h2dptgjvme5c@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 12 Feb 2024 16:56:28 +0200
Message-ID: <CAOQ4uxi45Ci=3d62prFoKjNQanbUXiCP4ULtUOrQtFNqkLA8Hw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
	Sweet Tea Dorminy <thesweettea@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 2:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 08-02-24 21:21:13, Amir Goldstein wrote:
> > On Thu, Feb 8, 2024 at 8:31=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > On Thu 08-02-24 16:04:29, Amir Goldstein wrote:
> > > > > > On Mon 29-01-24 20:30:34, Amir Goldstein wrote:
> > > > > > > On Mon, Dec 18, 2023 at 5:53=E2=80=AFPM Amir Goldstein <amir7=
3il@gmail.com> wrote:
> > > > > > > > In the HttpDirFS HSM demo, I used FAN_OPEN_PERM on a mount =
mark
> > > > > > > > to deny open of file during the short time that it's conten=
t is being
> > > > > > > > punched out.
> > > > > > > > It is quite complicated to explain, but I only used it for =
denying access,
> > > > > > > > not to fill content and not to write anything to filesystem=
.
> > > > > > > > It's worth noting that returning EBUSY in that case would b=
e more meaningful
> > > > > > > > to users.
> > > > > > > >
> > > > > > > > That's one case in favor of allowing FAN_DENY_ERRNO for FAN=
_OPEN_PERM,
> > > > > > > > but mainly I do not have a proof that people will not need =
it.
> > > > > > > >
> > > > > > > > OTOH, I am a bit concerned that this will encourage develop=
er to use
> > > > > > > > FAN_OPEN_PERM as a trigger to filling file content and then=
 we are back to
> > > > > > > > deadlock risk zone.
> > > > > > > >
> > > > > > > > Not sure which way to go.
> > > > > > > >
> > > > > > > > Anyway, I think we agree that there is no reason to merge F=
AN_DENY_ERRNO
> > > > > > > > before FAN_PRE_* events, so we can continue this discussion=
 later when
> > > > > > > > I post FAN_PRE_* patches - not for this cycle.
> > > > > > >
> > > > > > > I started to prepare the pre-content events patches for posti=
ng and got back
> > > > > > > to this one as well.
> > > > > > >
> > > > > > > Since we had this discussion I have learned of another use ca=
se that
> > > > > > > requires filling file content in FAN_OPEN_PERM hook, FAN_OPEN=
_EXEC_PERM
> > > > > > > to be exact.
> > > > > > >
> > > > > > > The reason is that unless an executable content is filled at =
execve() time,
> > > > > > > there is no other opportunity to fill its content without get=
ting -ETXTBSY.
> > > > > >
> > > > > > Yes, I've been scratching my head over this usecase for a few d=
ays. I was
> > > > > > thinking whether we could somehow fill in executable (and execu=
ted) files on
> > > > > > access but it all seemed too hacky so I agree that we probably =
have to fill
> > > > > > them in on open.
> > > > > >
> > > > >
> > > > > Normally, I think there will not be a really huge executable(?)
> > > > > If there were huge executables, they would have likely been broke=
n down
> > > > > into smaller loadable libraries which should allow more granular
> > > > > content filling,
> > > > > but I guess there will always be worst case exceptions.
> > > > >
> > > > > > > So to keep things more flexible, I decided to add -ETXTBSY to=
 the
> > > > > > > allowed errors with FAN_DENY_ERRNO() and to decided to allow
> > > > > > > FAN_DENY_ERRNO() with all permission events.
> > > > > > >
> > > > > > > To keep FAN_DENY_ERRNO() a bit more focused on HSM, I have
> > > > > > > added a limitation that FAN_DENY_ERRNO() is allowed only for
> > > > > > > FAN_CLASS_PRE_CONTENT groups.
> > > > > >
> > > > > > I have no problem with adding -ETXTBSY to the set of allowed er=
rors. That
> > > > > > makes sense. Adding FAN_DENY_ERRNO() to all permission events i=
n
> > > > > > FAN_CLASS_PRE_CONTENT groups - OK,
> > > > >
> > > > > done that.
> > > > >
> > > > > I am still not very happy about FAN_OPEN_PERM being part of HSM
> > > > > event family when I know that O_TRUCT and O_CREAT call this hook
> > > > > with sb writers held.
> > > > >
> > > > > The irony, is that there is no chance that O_TRUNC will require f=
illing
> > > > > content, same if the file is actually being created by O_CREAT, s=
o the
> > > > > cases where sb writers is actually needed and the case where cont=
ent
> > > > > filling is needed do not overlap, but I cannot figure out how to =
get those
> > > > > cases out of the HSM risk zone. Ideas?
> > > > >
> > > >
> > > > Jan,
> > > >
> > > > I wanted to run an idea by you.
> > > >
> > > > I like your idea to start a clean slate with
> > > > FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID
> > > > and it would be nice if we could restrict this HSM to use
> > > > pre-content events, which is why I was not happy about allowing
> > > > FAN_DENY_ERRNO() for the legacy FAN_OPEN*_PERM events,
> > > > especially with the known deadlocks.
> > > >
> > > > Since we already know that we need to generate
> > > > FAN_PRE_ACCESS(offset,length) for read-only mmap() and
> > > > FAN_PRE_MODIFY(offset,length) for writable mmap(),
> > > > we could treat uselib() and execve() the same way and generate
> > > > FAN_PRE_ACCESS(0,i_size) as if the file was mmaped.
> > >
> > > BTW uselib() is deprecated and there is a patch queued to not generat=
e
> > > OPEN_EXEC events for it because it was causing problems (not the gene=
ration
> > > of events itself but the FMODE_EXEC bit being set in uselib). So I do=
n't
> > > think we need to instrument uselib().
> > >
> >
> > Great. The fewer the better :)
> >
> > BTW, for mmap, I was thinking of adding fsnotify_file_perm() next to
> > call sites of security_mmap_file(), but I see that:
> > 1. shmat() has security_mmap_file() - is it relevant?
>
> Well, this is effectively mmap(2) of a tmpfs file. So I don't think this =
is
> particularly useful for HSM purposes but we should probably have it for
> consistency?

OK.

Actually, I think there is a use case for tmpfs + HSM. HSM is about
lazy populating of a local filesystem from a remote slower tier.
The fast local tier could be persistent, but could just as well be tmpfs,
for a temporary lazy local mirror.

This use case reminds overlayfs a bit, where the local tier is the upper fs=
,
but in case of HSM, the "copy up" happens also on read.

I do want to limit HSM to "fully featured local fs", so we do not end up
with crazy fs doing HSM. The very minimum should be decodable
file handle support and unique fsid, but we could also think of more strict
requirements(?). Anyway, tmpfs should meet all the "fully featured local fs=
"
requirement.

>
> > 2. remap_file_pages() calls do_mmap() without security_mmap_file() -
> >     do we need to cover it?
>
> Hmm, AFAIU remap_file_pages() just allows you to mess with an existing
> mapping so it isn't very interesting from HSM POV?

Nope.

>
> > > > I've already pushed a POC to fan_pre_content branch [1].
> > > > Only sanity tested that nothing else is broken.
> > > > I still need to add the mmap hooks and test the new events.
> > > >
> > > > With this, HSM will have appropriate hooks to fill executable
> > > > and library on first access and also fill arbitrary files on open
> > > > including the knowledge if the file was opened for write.
> > > >
> > > > Thoughts?
> > >
> > > Yeah, I guess this looks sensible.
> >
> > Cool, so let's see, what is left to do for the plan of
> > FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID?
> >
> > 1. event->fd is O_PATH mount_fd for open_by_handle_at()
> > 2. open_by_handle_at() inherits FMODE_NONOTIFY from mount_fd
> > 3. either implement the FAN_CLOSE_FD response flag (easy?) and/or
> >     implement FAN_REPORT_EVENT_ID and new header format
> >
> > Anything else?
> > Are you ok with 1 and 2?
>
> I'm not sure about 1) and 2) so I'm mostly thinking out loud now. AFAIU y=
ou
> want to provide mount_fd only because of FMODE_NONOTIFY inheritance so 2)
> is the key question. But if you provide mount_fd with FMODE_NONOTIFY and
> have FMODE_NONOTIFY inheritance, then what's the difference to just allow
> opens with FMODE_NONOTIFY from the start? I don't think restricting
> FMODE_NONOTIFY to inheritance gives any additional strong security
> guarantees?
>

You are right.
Just need to think of the right API.
It is just very convenient to be getting the FMODE_NONOTIFY from
fanotify, but let's think about it.

> I understand so far we didn't expose FMODE_NONOTIFY so that people cannot
> bypass fanotify permission events. But now we need a sensible way to fill
> in the filesystem without deadlocking on our own watches. Maybe exposing
> FMODE_NONOTIFY as an open flag is too attractive for misuse so could be
> somehow tie it to the HSM app? We were already discussing that we need to
> somehow register the HSM app with the filesystem to avoid issues when the
> app crashes or so. So maybe we could tie this registration to the ability
> of bypassing generation of notification?
>

Last time we discussed this the conclusion was an API of a group-less
default mask, for example:

1. fanotify_mark(FAN_GROUP_DEFAULT,
                           FAN_MARK_ADD | FAN_MARK_MOUNT,
                           FAN_PRE_ACCESS, AT_FDCWD, path);
2. this returns -EPERM for access until some group handles FAN_PRE_ACCESS
3. then HSM is started and subscribes to FAN_PRE_ACCESS
4. and then the mount is moved or bind mounted into a path exported to user=
s

It is a simple solution that should be easy to implement.
But it does not involve "register the HSM app with the filesystem",
unless you mean that a process that opens an HSM group
(FAN_REPORT_FID|FAN_CLASS_PRE_CONTENT) should automatically
be given FMODE_NONOTIFY files?

There is one more crazy idea that I was pondering -
what if we used the fanotify_fd as mount_fd arg to open_by_handle_at()?
The framing is that it is not the filesystem, but fanotify which actually
encoded the fsid+fid, so HSM could be asking fanotify to decode them.
Technically, the group could keep a unique map from fsid -> sb, then
fanotify group could decode an fanotify_event_info_fid buffer to a specific
inode on a specific fs.
Naturally, those decoded files would be FMODE_NONOTIFY.

Too crazy?

I am very much open to a simpler suggestion.

> > Do you have a preference for 3?
>
> Yeah. FAN_CLOSE_FD seems as a hack to me (and you're likely to get it wro=
ng
> until you've spent quite some time debugging with exec sometimes fails wi=
th
> ETXTBUSY). So I prefer FAN_REPORT_EVENT_ID and use event id as an
> identifier when replying to HSM events.

OK.

At the end of this week I am going on a one week vacation,
so it is unlikely that pre-content events will be ready for 6.9.
Perhaps I will be able to get some prep work ready for the
merge window, we shall see.

Thanks,
Amir.

