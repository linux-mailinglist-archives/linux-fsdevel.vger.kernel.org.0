Return-Path: <linux-fsdevel+bounces-66346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BEEC1C6D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 18:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEC75674FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1699234CFC5;
	Wed, 29 Oct 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ/uWHQb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B634CFB9
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758008; cv=none; b=Inr34GzTXRFeY6ngp+jOl7g82PgriAA9rEBBYDin7lhqWvlddre3PHxF+2Dn/CFf+bbtB8ojafUyHaVeTAa91XXEafqg3MtAY1AL/0lq4NWX16eI8OHmSdYezMpKZujsOVc2NlH0y7Qx27lq8TGUETBSkHLA+yYce++xRh9vqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758008; c=relaxed/simple;
	bh=43QsWZCHf7bKJtXw773dvnj2r6JiT62GtcrDdpnmJQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laVvCgnj7YfHZJqQo3btTaFyjm4OzufmlL+WFrfo549fDUBJeKs6dxgDpsUKYniR75uhtbDy/4feoiW7nDGlTs/8OcJo4nn5QsuYq8g7h/FXeZDNuI6AJrXhVekkussGjYsXyHmCuaHI8j56ADPISPaFlE9e1wzS0cuXy2WlyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ/uWHQb; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-44da99d4d40so70443b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761758005; x=1762362805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkfnIZHk8Z51qyuEGBtlHTvQyTxXa7Fx/bTiXiMoBRA=;
        b=ZJ/uWHQbWtEf+nYu7FZbOujwizDdHTSA3eBetk+lU5zwbHv+HjSNf6RUS6t4+DXyRl
         xfTEWXvL6OZ7G14HTffDEfi4B/IGvsTvNEORLl/FXaoAYIbWWBPsfPlIRX4gkxBT19Ei
         nxZfb7OJ/I7JIm1oedZGC16XToqYD46BA3t2CSydslHurmRBscI0/V9JowSARAaWuSNm
         gSyXU5q8emG9WpF0gObhZH/IlUeiUDNHjtOWrekw2chygFsZQxvV8kL3FOQDtNM1hISG
         lxcQ41PwN81suarLF3IFVuiE2DWsoeZKdlWrtPix18VWGLFk+68NhVMrbgeAjHU8FZZB
         1QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761758005; x=1762362805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkfnIZHk8Z51qyuEGBtlHTvQyTxXa7Fx/bTiXiMoBRA=;
        b=TZmZcKwUhZvstQ5kPoFt0LeYkULbbkZQpNiVdvIuIoGumekD2wmk+VwzvK/q3e6a63
         6wEeqhlIzsDD/94NitC0noLZDDuqTQOCvkXb8CQKae2mrxOqO6LYqRuienEV+ljYjsX5
         ijWm7nIuC/5ha+NdovGXqlWa9Rd4AK5szmOv/glFyKAYc0MWpX08X8Kyc/hLVZQFLd9S
         /n2TnxHXTnQKlWoAmprd2nyvue++G0qTDGjMXC0K/9rUMbiUdFqHoe3XEnxb0sBMPdTl
         KjDUlwXJVLBd7Jtkkz1zluWevQr9fuyETwUa2mPnIXfLv7rT/vMp090tshY0IWpiu8Rt
         f6sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0RRXDIsaeJyorngSW0SqkmuFyT/xwuj42zbuvR7vhZcgFlwXpw1Aw6jzmFebafnbjmJEbKzCan56FRbke@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZN2lTAvmnpOvh2afVRMAeWw8kGTNBWh3e8SsHlukCiOYuZSv
	FqPJXysy5Imt4zm+YnbqjnDk79exzz9hT96Xguuj12UYkfqKl68tHc/KmPTltDwp352cOMQnpGV
	O/IDqmj2qEaYH6NMMsMMpRcfv/ZCPl6Q=
X-Gm-Gg: ASbGncuuPmkj8y7030Qw6XrmsFfqYW4e1lWaYtnvD9lXFXlBGOVxmfkUC0NqdtSCYUn
	M16dlc55h4zptByFHeWezZ7f9zlPBvuUu6VIlrcCIpSK+SyeAjhU3rJvomtOAKuU3NqvG3M+QNT
	gvxYrcG59fTTrylOCnngHNFQJjp0MR8RPMkTB9LfReXwOM48sYuuSNpyjxUfvIJmqyohz5t95AO
	y3qA4fp0oVBkG4dvIloj0QdFFvuGcjW8j5aQIetKmZmW9q6LnJEsLjqZw==
X-Google-Smtp-Source: AGHT+IHwwQjhUTRON0ajlLfZyuteANTGiL3RTruWCreiOpmgsy7CKDbBXVDfTOzJuxpueg7QmsZnaQRBXJXIf8E1y1U=
X-Received: by 2002:a05:6808:1b20:b0:43c:27cb:8065 with SMTP id
 5614622812f47-44f7a492c46mr1929830b6e.30.1761758004711; Wed, 29 Oct 2025
 10:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916133437.713064-1-ekffu200098@gmail.com>
 <20250916133437.713064-3-ekffu200098@gmail.com> <CABFDxMFtZKSr5KbqcGQzJWYwT5URUYeuEHJ1a_jDUQPO-OKVGg@mail.gmail.com>
 <CAOQ4uxgEL=gOpSaSAV_+U=a3W5U5_Uq2Sk4agQhUpL4jHMMQ9w@mail.gmail.com>
 <CABFDxMG8uLaedhFuWHLAqW75a=TFfVEHkm08uwy76B7w9xbr=w@mail.gmail.com>
 <CAOQ4uxj9BAz6ibV3i57wgZ5ZNY9mvow=6-iJJ7b4pZn4mpgF7A@mail.gmail.com>
 <CABFDxMFRhKNENWyqh3Yraq_vDh0P=KxuXA9RcuVPX4FUnhKqGw@mail.gmail.com>
 <CAOQ4uxjxG7KCwsHYv3Oi+t1pwjLS8jUoiAroXtzTatu3+11CWg@mail.gmail.com>
 <CABFDxMGyH9jek19qEzp-3cQiS=9CTXzvtVDZztouLeO6nYEP3w@mail.gmail.com> <aQILFtsVnpVBj-k-@amir-ThinkPad-T480>
In-Reply-To: <aQILFtsVnpVBj-k-@amir-ThinkPad-T480>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Thu, 30 Oct 2025 02:13:13 +0900
X-Gm-Features: AWmQ_bnY12RBoxmQZ7x9tXlwcMEFYejKrMFjrZz5n-kOq5roMp4trqBdUVX8t1w
Message-ID: <CABFDxMGnhk3_oHW-At8HAEqqbJ9PUJ_9QTHUdZduaNCK5SfNSg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] smb: client: add directory change tracking via
 SMB2 Change Notify
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, linux-cifs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Stef Bon <stefbon@gmail.com>, 
	Ioannis Angelakopoulos <iangelak@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:39=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Oct 29, 2025 at 01:13:31AM +0900, Sang-Heon Jeon wrote:
> > On Fri, Oct 24, 2025 at 12:30=E2=80=AFAM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > >
> > > ...
> > > > > > Hello, Amir
> > > > > >
> > > > > > > First feedback (value):
> > > > > > > -----------------------------
> > > > > > > This looks very useful. this feature has been requested and
> > > > > > > attempted several times in the past (see links below), so if =
you are
> > > > > > > willing to incorporate feedback, I hope you will reach furthe=
r than those
> > > > > > > past attempts and I will certainly do my best to help you wit=
h that.
> > > > > >
> > > > > > Thanks for your kind comment. I'm really glad to hear that.
> > > > > >
> > > > > > > Second feedback (reviewers):
> > > > > > > ----------------------------------------
> > > > > > > I was very surprised that your patch doesn't touch any vfs co=
de
> > > > > > > (more on that on design feedback), but this is not an SMB-con=
tained
> > > > > > > change at all.
> > > > > >
> > > > > > I agree with your last comment. I think it might not be easy;
> > > > > > honestly, I may know less than
> > > > > > Ioannis or Vivek; but I'm fully committed to giving it a try, n=
o
> > > > > > matter the challenge.
> > > > > >
> > > > > > > Your patch touches the guts of the fsnotify subsystem (in a w=
rong way).
> > > > > > > For the next posting please consult the MAINTAINERS entry
> > > > > > > of the fsnotify subsystem for reviewers and list to CC (now a=
dded).
> > > > > >
> > > > > > I see. I'll keep it in my mind.
> > > > > >
> > > > > > > Third feedback (design):
> > > > > > > --------------------------------
> > > > > > > The design choice of polling i_fsnotify_mask on readdir()
> > > > > > > is quite odd and it is not clear to me why it makes sense.
> > > > > > > Previous discussions suggested to have a filesystem method
> > > > > > > to update when applications setup a watch on a directory [1].
> > > > > > > Another prior feedback was that the API should allow a clear
> > > > > > > distinction between the REMOTE notifications and the LOCAL
> > > > > > > notifications [2][3].
> > > > > >
> > > > > > Current design choice is a workaround for setting an appropriat=
e add
> > > > > > watch point (as well as remove). I don't want to stick to the R=
FC
> > > > > > design. Also, The point that I considered important is similar =
to
> > > > > > Ioannis' one: compatible with existing applications.
> > > > > >
> > > > > > > IMO it would be better to finalize the design before working =
on the
> > > > > > > code, but that's up to you.
> > > > > >
> > > > > > I agree, although it's quite hard to create a perfect blueprint=
, but
> > > > > > it might be better to draw to some extent.
> > > > > >
> > > > > > Based on my current understanding, I think we need to do the fo=
llowing things.
> > > > > > - design more compatible and general fsnotify API for all netwo=
rk fs;
> > > > > > should process LOCAL and REMOTE both smoothly.
> > > > > > - expand inotify (if needed, fanotify both) flow with new fsnot=
ify API
> > > > > > - replace SMB2 change_notify start/end point to new API
> > > > > >
> > > > >
> > > > > Yap, that's about it.
> > > > > All the rest is the details...
> > > > >
> > > > > > Let me know if I missed or misunderstood something. And also pl=
ease
> > > > > > give me some time to read attached threads more deeply and clea=
n up my
> > > > > > thoughts and questions.
> > > > > >
> > > > >
> > > > > Take your time.
> > > > > It's good to understand the concerns of previous attempts to
> > > > > avoid hitting the same roadblocks.
> > > >
> > > > Good to see you again!
> > > >
> > > > I read and try to understand previous discussions that you attached=
. I
> > > > would like to ask for your opinion about my current step.
> > > > I considered different places for new fsnotify API. I came to the s=
ame
> > > > conclusion that you already suggested to Inoannis [1]
> > > > After adding new API to `struct super_operations`, I tried to find =
the
> > > > right place for API calls that would not break existing systems and
> > > > have compatibility with inotify and fanotify.
> > > >
> > > > From my current perspective, I think the outside of fsnotify (like
> > > > inotify_user.c/fanotify_user.c) is a better place to call new API.
> > > > Also, it might lead some duplicate code with inotify and fanotify, =
but
> > > > it seems difficult to create one unified logic that covers both
> > > > inotify and fanotify.
> > >
> > >
> > > Personally, I don't mind duplicating this call in the inotify and
> > > fanotify backends.
> > > Not sure if this feature is relevant to other backends like nfsd and =
audit.
> > >
> > > I do care about making this feature opt-in, which goes a bit against =
your
> > > requirement that existing applications will get the REMOTE notificati=
ons
> > > without opting in for them and without the notifications being clearl=
y marked
> > > as REMOTE notifications.
> > >
> > > If you do not make this feature opt-in (e.g. by fanotify flag FAN_MAR=
K_REMOTE)
> > > then it's a change of behavior that could be desired to some and surp=
rising to
> > > others.
> >
> > You're right, Upon further reflection, my previous approach may create
> > unexpected effects to the user program. But to achieve my requirement,
> > inotify should be supported (also safely). I will revisit inotify with
> > opt-in method after finishing the discussion about fanotify.
> >
> > > Also when performing an operation on the local smb client (e.g. unlin=
k)
> > > you would get two notifications, one the LOCAL and one the REMOTE,
> > > not being able to distinguish between them or request just one of the=
m
> > > is going to be confusing.
> > >
> > > > With this approach, we could start inotify first
> > > > and then fanotify second that Inoannis and Vivek already attempted.
> > > > Even if unified logic is possible, I don't think it is not difficul=
t
> > > > to merge and move them into inside of fsnotify (like mark.c)
> > > >
> > >
> > > For all the reasons above I would prefer to support fanotify first
> > > (with opt-in flag) and not support inotify at all, but if you want to
> > > support inotify, better have some method to opt-in at least.
> > > Could be a global inotify kob for all I care, as long as the default
> > > does not take anyone by surprise.
> >
> > Thanks for the detailed description. I understand the point of
> > distinguishing remote and local notification better. And the way you
> > prefer (fanotify first) is also reasonable to me because implementing
> > fanotify would also help support inotify more safely.
> >
> > > > Also, I have concerns when to call the new API. I think after updat=
ing
> > > > the mark is a good moment to call API if we decide to ignore errors
> > > > from new API; now, to me, it is affordable in terms of minimizing s=
ide
> > > > effect and lower risk with user spaces. However, eventually, I beli=
eve
> > > > the user should be able to decide whether to ignore the error or no=
t
> > > > of new API, maybe by config or flag else. In that case, we need to
> > > > rollback update of fsnotify when new API fails. but it is not
> > > > supported yet. Could you share your thoughts on this, too?
> > > >
> > >
> > > If you update remote mask with explicit FAN_MARK_REMOTE
> > > and update local mask without FAN_MARK_REMOTE, then
> > > there is no problem is there?
> > >
> > > Either FAN_MARK_REMOTE succeeded or not.
> > > If it did, remote fs could be expected to generate remote events.
> >
> > I understand you mean splitting mask into a local and remote
> > notification instead of sharing, is it right?
>
> No, that's no what I meant.
>
> > TBH, I never thought of that solution but it's quite clear and looks go=
od to me.
> > If I misunderstand, could you please explain a bit more?
> >
>
> It is indeed clear, but inode space is quite expensive, so we cannot
> add i_fsnotify_remote_mask field for all inodes and also its not
> necessary.

Agree, especially the point that remote masks are not for every inode.

> TBH, I do have a final picture of the opt-in API and there are several
> shapes that it could take.
>
> I think that we anyway need an "event mask flag" FAN_REMOTE,
> similar to FAN_ONDIR.
>
> A remote notification is generated by the filesystem and this source
> of notification always sets the FS_REMOTE in the event mask, which is
> visible to users reading the events.
>
> This makes it natural to also opt-in for remote events via the mask,
> some as is done with FAN_ONDIR.
>
> However, I would like to avoid the complexities involved with flipping
> this FS_REMOTE bit in event mask, that's why I was thinking about
> FAN_MARK_REMOTE that sets a flag in the mark, like FAN_MARK_EVICTABLE
> and forces all mark updates to use the same flag.

I also considered setting flag inside of mark, and using that to
distinguish local and remote.
The reason why I split mask was that the local and remote masks might
differ. However, I don't yet have any clear use case in my mind. So I
will follow your suggestion now.

> But for your first RFC, I suggest that you make it simple and use
> a group flag to request only remote notifications at fanotify_init
> time.
>
> This way you can take the existing cifs implementation of remote
> notifications using an ioctl and "bind" it to use the fanotify API
> with as little interferance with local notifications as possible.

Currently, I also think that the REMOTE flag should be attached to
mark(or similar level) in the end. But it's good to develop RFC step
by step. I'll follow your guidance as well.

> > > > If my inspection is wrong or you might have better idea, please let=
 me
> > > > know about it. TBH, understanding new things is hard, but it's also=
 a
> > > > happy moment to me.
> > > >
> > >
> > > I am relying on what I think you mean, but I may misunderstand you
> > > because you did not sketch any code samples, so I don't believe
> > > I fully understand all your concerns and ideas.
> > >
> > > Even an untested patch could help me understand if we are on the same=
 page.
> >
> > Thanks for your advice. I think we're getting closer to the same page.
>
> Not quite there yet :)
>
> > I also attached patch of my current sketch (not tested and cleaned),
> > feel free to give your opinions.
>
> This is not what I was looking for.
>
> What I am looking for is a POC patch of binding cifs notifications
> to fsnotify/fanotify:
>
> - fanotify_mask() calls filesystem method to update server event mask
> - filesystem calls fnsotify() hook with FS_REMOTE flag
> - groups or marks that did not opt-in for remote notifications
>   would drop this event
>
> First milestone: be able to write program that listens to remote
> notifications only.
>
> Same program can use two groups remote and local with mask per type
> to request a mixture of local and remote events.
>
> Honestly, I don't think we need more than that?

Yeah.. No more this time. While digging about fsnotify, I missed some
important and origin interests. Thanks for reminding me through
setting the first milestone. I think it would be better to discuss
next topics after reaching the first milestone.

If there are no further questions (and hopefully there aren't), I'll
make and send the RFC patch.
Please bear with me if it takes some time and also thank you so much
for all your help.

> Thanks,
> Amir.
>
>

Best Regards.
Sang-Heon Jeon

