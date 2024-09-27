Return-Path: <linux-fsdevel+bounces-30232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166F7988059
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 10:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E3A284E23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 08:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984641898F1;
	Fri, 27 Sep 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuirOky9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690918308A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426132; cv=none; b=t9lh20WmK4neMGHreDrXvUDv9Zsv1tVXN5OFWaz2fi4nONP8u9lr2cezF8MvhTrOMSzUtqWQPcnIKjLCGJ2ldVUVQ14mWPh7ks3ItiGIQ+csRwtYVrszcgmvQyK+6p1eGoBZaSwS6l//BF2UfjGe5jaWuAyIpfxsD600lZVrThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426132; c=relaxed/simple;
	bh=WdHCfssJBfAGWrUKzv3JISdS3NwnfQshMXghECmnc0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkMx8EokU4UNExCE4hB7YeNid95npzz/EiRJz/nNKMg3dyQ0VPui0FHGqUTxGKtBcSKNoiDJyluXupHonVPy5OEVlXDSZqcEtI8qcQUkF4R6/UNXbCNwpQ4mRmlGKYWfu8c9TMVo8UgOPSyOSzi7GBLd3BwdKtifJ4HDo9x5+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuirOky9; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9ad15d11bso164722385a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 01:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727426129; x=1728030929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c09mzcUV6e7wOQOB/SdFy2XBC+9LPo/MP10U/jpIHPs=;
        b=ZuirOky9hKdA309Q1bzv6+BT3vdNAziUbWrB+m17cCknEyZPq9zrEZUFOID7VF/P2d
         piS0Qr3gGhbx5hL900TYLaX3ZnQ+Wp0Mg0PYloeK44ueoGbPQHd5jHUT2ZPgGIm7OrX5
         qZleBx0FLnJgfqTtkw9xGpMTRP9TUQcRXOC/U+y7dbxOFW2YAy4bHOA3DBI6hiiXDnK2
         Sob3N59xNSqvkLx9Qx/yDewtp4ZczbnhYrN6fzSsNpGJ0QyhnFG4YTo7op7NJ1KUlbjZ
         JXb5IGXkyEnqJ7dCOIWuXPK08udURZMGXmiJ6bWaINLg1mNBHbGo2u6ckZF1FuHC0G3n
         B5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727426129; x=1728030929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c09mzcUV6e7wOQOB/SdFy2XBC+9LPo/MP10U/jpIHPs=;
        b=PNCxeFOTXdZ+dg2oaN/95tz/C06qdWbLJdxU+b0JfL2Re33XNjIuSRp5P56RlZTHU2
         DEIBljPdS67nuL0ve5F0Wbw4FpmKAM5tuPW5fOWsYknB4qrh/hDU4RcN0Z6G1lO+uj1z
         auTz6zEUUPisKv2gxpPgu/SzWomTBEcV6ZBTQchIMxXfi7SwcobkSsnx1rZp456n4HKX
         slKrGmJrW0ZtteJdxb1oMehOTTAlomjadKIfN+o+eUUD6USlnLvcm6tKYoWwGI2zPuK4
         rVtt3dBwerlPFUCGhy3G2wBQk+tFc3swF2ui/ELTKmZ/MV8kkfOWF+Y3tXGVKW8LfQry
         /MpA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+UJz7ZUyzR9FG3if+6BUcSnTeLVQrRKPYQV4VVyiBs7Gk8Lc5odAaLUEZ4v+AhTtRYTzjDXSY0gwmASt@vger.kernel.org
X-Gm-Message-State: AOJu0YwFDfHd1hxpIwvn69SoJ3wCckcVKpHqhFGGqOj/tVioQENC6Aaq
	p9/+7PxQ8PkjwpNhswpJZ2Hkwg2KWCZ2QhHySAqgchu/3P3fkZNtasNT+AHmJJ3S5OegHTWpNmy
	vEX1scCY4IwxICS6fpR30iEfjG2+lGMFXiZM=
X-Google-Smtp-Source: AGHT+IFzxutq8InEVh6ERKf3WjezyZqYeGTpafiufqMx6rb97ufSdoJaluPruzGbwrADRQk9iwwFGx5ZHLEbNV8g9+4=
X-Received: by 2002:a05:620a:4412:b0:7a1:d73f:53d2 with SMTP id
 af79cd13be357-7ae37838bbdmr342241485a.20.1727426128923; Fri, 27 Sep 2024
 01:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3> <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
 <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjfO0BJUsnB-QqwqsjQ6jaGuYuAizOB6N2kNgJXvf7eTg@mail.gmail.com>
 <JH0P153MB099940642723553BA921C520D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com>
 <CAOQ4uxivUh4hKoB_V3H7D75wTX1ijX4bV4rYcgMyoEuZMD+-Eg@mail.gmail.com>
 <CAOQ4uxgRnzB0E2ESeqgZBHW++zyRj8-VmvB38Vxm5OXgr=EM9g@mail.gmail.com> <JH0P153MB099961BA4C71F05B394D0D6FD46B2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <JH0P153MB099961BA4C71F05B394D0D6FD46B2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Sep 2024 10:35:17 +0200
Message-ID: <CAOQ4uxjF9Lt4g6q2=C9mO-rRPDmXhFgMVhwjrGv=bdY3GWgFMg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> -----Original Message-----
> From: Amir Goldstein <amir73il@gmail.com>
> Sent: Friday, September 27, 2024 3:40 AM
> To: Krishna Vivek Vitta <kvitta@microsoft.com>
> Cc: Jan Kara <jack@suse.cz>; linux-fsdevel@vger.kernel.org; Eric Van Hens=
bergen <ericvh@kernel.org>; Latchesar Ionkov <lucho@ionkov.net>; Dominique =
Martinet <asmadeus@codewreck.org>; v9fs@lists.linux.dev
> Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with=
 FANOTIFY
>
> On Thu, Sep 26, 2024 at 10:28=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >
> > > > What would be the next steps for this investigation ?
> > > >
> > >
> > > I need to find some time and to debug the reason for 9p open failure
> > > so we can make sure the problem is in 9p code and report more
> > > details of the bug to 9p maintainers, but since a simple reproducer
> > > exists, they can also try to reproduce the issue right now.
> >
> > FWIW, the attached reproducer mimics git clone rename_over pattern clos=
er.
> > It reproduces fanotify_read() errors sometimes, not always, with
> > either CLOSE_WRITE or OPEN_PERM | CLOSE_WRITE.
> > maybe CLOSE_WRITE alone has better odds - I'm not sure.
> >
>
> scratch that.
> I think the renames were just a destruction git clone events do not alway=
s fail on a close+rename pattern, they always fail on the close+unlink that=
 follows the renames:
>
> 1776  openat(AT_FDCWD, "/vtmp/filebench/.git/tjEzMUw", O_RDWR|O_CREAT|O_E=
XCL, 0600) =3D 3
> 1776  close(3)                          =3D 0
> 1776  unlink("/vtmp/filebench/.git/tjEzMUw") =3D 0
> 1776  symlink("testing", "/vtmp/filebench/.git/tjEzMUw") =3D 0
> 1776  lstat("/vtmp/filebench/.git/tjEzMUw", {st_mode=3DS_IFLNK|0777, st_s=
ize=3D7, ...}) =3D 0
> 1776  unlink("/vtmp/filebench/.git/tjEzMUw") =3D 0
>
> I know because I added this print:
>
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -275,6 +275,7 @@ static int create_fd(struct fsnotify_group *group, co=
nst struct path *path,
>                  */
>                 put_unused_fd(client_fd);
>                 client_fd =3D PTR_ERR(new_file);
> +               pr_warn("%s(%pd2): ret=3D%d\n", __func__, path->dentry,
> client_fd);
>         } else {
>
> We should consider adding it as is or maybe ratelimited.
>
> The trivial reproducer below fails fanotify_read() always with one try.
>
> Thanks,
> Amir.
>
> int main() {
>     const char *filename =3D "config.lock";
>     int fd;
>
>     // Create a new file
>     fd =3D open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
>     if (fd =3D=3D -1) {
>         perror("Failed to create file");
>         return EXIT_FAILURE;
>     }
>     close(fd);
>
>     // Remove the file
>     if (unlink(filename) !=3D 0) {
>         perror("Failed to unlink file");
>         return EXIT_FAILURE;
>     }
>
>     return EXIT_SUCCESS;
> }

On Fri, Sep 27, 2024 at 8:34=E2=80=AFAM Krishna Vivek Vitta
<kvitta@microsoft.com> wrote:
>
> Hi Amir

Hi Krishna,

Please do not "top post" on mailing lists.
It makes it very hard for people that are trying to follow the
conversation in mailing archives
or join in the middle of the conversation.

>
> Thanks for the experiment.
> Though reproducer program is succeeding but fanotify listener is terminat=
ing since its failing to read the event. Right ?

Right, the fanotify_example.c is programmed to stop on event read error.
Productions fanotify listeners should log the error or ignore it, but not a=
bort.

>
> Can you elaborate on: " We should consider adding it as is or maybe ratel=
imited." ?

When fanotify fails to open an fd for reporting an event, we either
return the error to fanotify_read() or silently ignore the event.
What I meant is that we should add the pr_warn() in that case
to make the problem more visible to sysadmins.

>
> Does this mean there should be a fix at fanotify side ?

Yes, I think there should be a fix in fanotify.
9p is not doing something terribly wrong and as Jan
already wrote, the exact same case from nfs/cifs is handled
by ignoring the open error.

>
> Can you summarize the problem statement for once in larger interest of gr=
oup.
>

Yes, I will try.

fanotify needs to report an open fd with the event (in some operation modes=
).
The open fd needs to be created and installed in the fd table of the
listener process
that is calling fanotify_read() to read the event.

By the time that the listener process wants to read the events, the
file in question
may have already been unlinked.

fanotify holds a reference on the dentry where an event happened while the
event is in the queue.
In local filesystems, it should not be a problem to open an unlinked file
from a referenced dentry.
For example, If adding sleep(1) before handle_events() then
fanotify_example will
print these messages from ext/xfs:

   FAN_CLOSE_WRITE: File /vdc/config.lock (deleted)

The problem is that remote/network filesystems cannot provide
full guarantee that an unlinked file can be opened even if the
dentry reference exists.

nfs/nfs4/cifs clients return -EOPENSTALE in that case, so vfs/nfsd
can retry the open and fanotify also recognizes this error and
silently drops the event.

But vfs/fanotify cannot guarantee that all the remote/network
filesystems will return this special error code and as the comment
in  create_fd() says, there are many other cases that open can fail:

/*
 * we still send an event even if we can't open the file.  this
 * can happen when say tasks are gone and we try to open their
 * /proc files or we try to open a WRONLY file like in sysfs
 * we just send the errno to userspace since there isn't much
 * else we can do.
 */

The problems are:
1. The first line of the comment is wrong - we are not sending the event
2. We only send the errno to userspace if this is the first event being rea=
d
3. Even if userspace gets the errno, there is very little visibility about =
the
    event that caused the error (*)

(*) This can be improved by the pr_warn() that I suggested

Frankly, I never understood why this situation is not handled
as the first line of the comment claims - that is to send the
event with event->fd =3D -errno.

This way userspace gets an event about every error and get
try to do something about it (start an investigation).
Getting the errno sometimes and ignoring it sometimes
is a very poor UAPI.

> I assume the whole of these experiments succeed in ext, xfs.
>

Yes. This specific experiment succeeds on ext/xfs.
However, other failures to open fd for event can also
happen on ext/xfs, for example if the listener is watching
FAN_CLOSE|FAN_OPEN and fanotify_init() uses O_WRONLY
as event_f_flags argument and the watched fs is mounted read-only,
then you would get an error like this in fanotify_example,
after opening a file for read on ext/xfs:

   read: Read-only file system

At the bottom line, this is a UAPI issue. The UAPI can be improved,
but we will probably have to make a new opt-in flag for a new UAPI.

But I must say that I do not fully understand your original report.
Your original report claimed that git clone fails when
MDE(Microsoft Defender for Endpoint) is watching CLOSE_WRITE
events on a 9p mount.

Failures to report a FAN_CLOSE_WRITE event should have never
failed git clone. Only failure to report FAN_OPEN_PERM could have
failed git clone operations, but in that case, open would have failed anywa=
y.

My guess is that a would-be ENOENT open failure is replaced with
an EPERM open failure when fanotify is watching FAN_OPEN_PERM
events, but I have no confirmation to this assumption from your strace.

Unless I misunderstand the report, it sounds like the fix (to git clone
failure) should be in MDE software, because I could never reproduce
git clone failure with fanotify_example, no matter with events I tried.

Anyway, if I misunderstood something in the report, please clarify.

Thanks,
Amir.

