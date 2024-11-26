Return-Path: <linux-fsdevel+bounces-35885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C169B9D9511
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 11:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C03FDB278B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D7F1BD517;
	Tue, 26 Nov 2024 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKPkOQvE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC15C96;
	Tue, 26 Nov 2024 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614468; cv=none; b=KIyyN/Yf3KM9udsPduXJ9fFDN3/+lTkzqzwGbsjyZgtGMZojF0Kw7Fr0rtj6C/FO1J77I5Sq6UqA0zeop1iavxbYepCBGzuxnyozFNBND2Cb4rc4VjosGhOiYcl6dw2k70yT5eW+xvONlmEK4yBL5ivozQ7KVhSumhfAd3KnyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614468; c=relaxed/simple;
	bh=jC8gFsCCu/uZr3NUk3rOeyEFSgWSWYf9yt31kUIDsr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1v1+x5isT7FiIx99y0DT53JfObj14+lgotuODTF6l14vG0r4UcG4ZqvC10jBIcCqPv7emU6kZXm3n09YVBhgDJFZC57H2tNjuTDCOkIbfuQgVXoLGpHa1JrzMD3MwEhTIgXDquacLxDh6ZiEAJfRUixylKcoZLCBST8rA1pJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKPkOQvE; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53dede30436so256130e87.2;
        Tue, 26 Nov 2024 01:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732614464; x=1733219264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQGkwLaBoqeNnLkNbHsiFkTqZPYYIv864btvDKK2Uw0=;
        b=AKPkOQvEJh70nm2wY4eoT9/EtgklL54NKmoKLrcVD8LA/WkwJf01xqCBlknRA2MlcF
         eQ6X5W4Gq+4YoI7PPD4Yp8qXCr+h3OzCYrvH5jnvBWUR9GkMVYUXEzL9NIsT34O4D/OU
         DzE7us+QUpYeVRYHVQlS7rsQqHW3JCIF2zRJt5qoWqc2v7rnBttZCrOxc/4jxKRQKIwn
         1Nksf/R3aSRatVRm5bc09hb2rxjrm8nq0nROqqEpLS9vLcLtH7n+VWDBckavboIt5Ic/
         PQrUIfMCt2Z78xpHIyAhmDVJd4OliPLdigt4hXRuj1PZtxitfWOBCzEiUp66K3KAqxMd
         TsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732614464; x=1733219264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQGkwLaBoqeNnLkNbHsiFkTqZPYYIv864btvDKK2Uw0=;
        b=up9gBY6QnGM0dzmApd7uF84dtM5Cb/QQnM5UOPe3s167qNpQvYcMeGCYnyJXUcvTIl
         4KXwLdFZISeqOuhBZTRZOYWswEHZEsIgoozcX2U3QlRtIrqXHIYnggTD7yNKQvatpokc
         05G/B+oM7FAeW+XXtsfRUqPqjMAOWItMAfKxGMfBmIBMDCg4Kpw4OpEcnQbSVCSVxbEM
         ZOk77Q4SbAmF+EUbua9bxu3wGDSONk8/wOyeLkRFPjAiJ0fkVqbcwwOSMZJud9vQvAL7
         ksdqwkotu9QFYkXM/LyaBxYPhVfWq8WRWhH2fzIkgHl2xMIqiQSTqoFn9wEUl2VhyN3I
         6WfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7pO0ZjUgHGFmMkr7GAS33vzJtKDyMIlas87KllcDpHv3zxP/EyuJzwImlnXyviryszcwxayimPRLO2dBgsg==@vger.kernel.org, AJvYcCX4ax0Q4b3u/xxctnGfI0+3uV+N8hauVah8XBF7DY8em/wntCDh4H6uM0FQnzrv5Hi4sTiYjti7vnXTrTue@vger.kernel.org, AJvYcCXZwtEnVQreDSy8j2AWUCuT0szCmAKHG9+iuyJ7NXh1+dOLyg0HhYf53mZ/iQzs65zPTv0I4GvdGzHRxgF1@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfDXFY7RjxmYNd9/qCP0zV0YiNNOGdkHkOvwv5526fta1WPNL
	UdKjQy1i2YV4IlymcxwXsu9rI+8a0Uyr5cR2Ws5cNXUnKOKFHDfTpQ1m7XdX7I4CDfeHLMUZXTA
	egxVVbFX+xTFylaRe+0S5vHqe95c=
X-Gm-Gg: ASbGncsPWv2pblBGK6fAXouG7EWSZx9JVxgpSY4q8yJtlxIWMrLmVhs7Oo+FABz9DWe
	YDg5iYOiQFcPPT7+M5vevj+lMSIYVS9M=
X-Google-Smtp-Source: AGHT+IGLWOWAJahf/CPPIkfrPTt2Tsmp7VmGgd0e4lBS0MKYAvNP3gRNBupDVLGuY4TMyEYStWhW3Mvh+9BH736FKZw=
X-Received: by 2002:a05:6512:2382:b0:539:e85f:ba98 with SMTP id
 2adb3069b0e04-53dd3babe78mr7220370e87.56.1732614463880; Tue, 26 Nov 2024
 01:47:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106-overlayfs-fsopen-log-v1-1-9d883be7e56e@cyphar.com>
 <20241106-mehrzahl-bezaubern-109237c971e3@brauner> <CAOQ4uxirsNEK24=u3K-X5A-EX80ofEx5ycjoqU4gocBoPVxbYw@mail.gmail.com>
 <CAOQ4uxj+gAtM6cY_aEmM7TAqLor7498f0FO3eTek_NpUXUKNaw@mail.gmail.com>
 <20241106.141100-patchy.noises.kissable.cannons-37UAyhH88iH@cyphar.com>
 <j7ngxuxqdwrq5o6zi2hmt3zfmh6s5mzrlvwjw6snqbv5oc5ggo@nqpr6wjec7go> <20241126.065751-glad.dagger.vile.lyrics-RJ5aGOKAtri@cyphar.com>
In-Reply-To: <20241126.065751-glad.dagger.vile.lyrics-RJ5aGOKAtri@cyphar.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 26 Nov 2024 10:47:32 +0100
Message-ID: <CAOQ4uxj_jY36nJ9eTVv5VomSp+ne_yif-6JPZcQB1nXDdRC02w@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: port all superblock creation logging to fsopen logs
To: Aleksa Sarai <cyphar@cyphar.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Karel Zak <kzak@redhat.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 8:25=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2024-11-13, Karel Zak <kzak@redhat.com> wrote:
> > On Thu, Nov 07, 2024 at 02:09:19AM GMT, Aleksa Sarai wrote:
> > > On 2024-11-06, Amir Goldstein <amir73il@gmail.com> wrote:
> > > > On Wed, Nov 6, 2024 at 12:00=E2=80=AFPM Amir Goldstein <amir73il@gm=
ail.com> wrote:
> > > > >
> > > > > On Wed, Nov 6, 2024 at 10:59=E2=80=AFAM Christian Brauner <braune=
r@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Nov 06, 2024 at 02:09:58PM +1100, Aleksa Sarai wrote:
> > > > > > > overlayfs helpfully provides a lot of of information when set=
ting up a
> > > > > > > mount, but unfortunately when using the fsopen(2) API, a lot =
of this
> > > > > > > information is mixed in with the general kernel log.
> > > > > > >
> > > > > > > In addition, some of the logs can become a source of spam if =
programs
> > > > > > > are creating many internal overlayfs mounts (in runc we use a=
n internal
> > > > > > > overlayfs mount to protect the runc binary against container =
breakout
> > > > > > > attacks like CVE-2019-5736, and xino_auto=3Don caused a lot o=
f spam in
> > > > > > > dmesg because we didn't explicitly disable xino[1]).
> > > > > > >
> > > > > > > By logging to the fs_context, userspace can get more accurate
> > > > > > > information when using fsopen(2) and there is less dmesg spam=
 for
> > > > > > > systems where a lot of programs are using fsopen("overlay"). =
Legacy
> > > > > > > mount(2) users will still see the same errors in dmesg as the=
y did
> > > > > > > before (though the prefix of the log messages will now be "ov=
erlay"
> > > > > > > rather than "overlayfs").
> > > > >
> > > > > I am not sure about the level of risk in this format change.
> > > > > Miklos, WDYT?
> > > > >
> > > > > > >
> > > > > > > [1]: https://bbs.archlinux.org/viewtopic.php?pid=3D2206551
> > > > > > >
> > > > > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > > > > ---
> > > > > >
> > > > > > To me this sounds inherently useful! So I'm all for it.
> > > > > >
> > > > >
> > > > > [CC: Karel]
> > > > >
> > > > > I am quite concerned about this.
> > > > > I have a memory that Christian suggested to make this change back=
 in
> > > > > the original conversion to new mount API, but back then mount too=
l
> > > > > did not print out the errors to users properly and even if it doe=
s
> > > > > print out errors, some script could very well be ignoring them.
> > >
> > > I think Christian mentioned this at LSF/MM (or maybe LPC), but it see=
ms
> > > that util-linux does provide the log information now in the case of
> > > fsconfig(2) errors:
> > >
> > >     % strace -e fsopen,fsconfig mount -t overlay -o userxattr=3Dstr x=
 /tmp/a
> > >     fsopen("overlay", FSOPEN_CLOEXEC)       =3D 3
> > >     fsconfig(3, FSCONFIG_SET_STRING, "source", "foo", 0) =3D 0
> > >     fsconfig(3, FSCONFIG_SET_STRING, "userxattr", "str", 0) =3D -1 EI=
NVAL (Invalid argument)
> > >     mount: /tmp/a: fsconfig system call failed: overlay: Unexpected v=
alue for 'userxattr'.
> > >                dmesg(1) may have more information after failed mount =
system call.
> > >
> > > (Using the current HEAD of util-linux -- openSUSE's util-linux isn't
> > > compiled with support for fsopen apparently.)
> >
> > After failed mount-related syscalls, libmount reads messages prefixed
> > with "e " from the file descriptor created by fdopen(). These messages
> > are later printed by mount(8).
> >
> > mount(8) or libmount does not read anything from kmesg.
> >
> > > However, it doesn't output any of the info-level ancillary
> > > information if there were no errors.
> >
> > This is the expected default behavior. mount(8) does not print any
> > additional information.
> >
> > We can enhance libmount to read and print other messages on stdout if
> > requested by the user. For example, the mount(8) command has a
> > --verbose option that is currently only used by some /sbin/mount.<type>
> > helpers, but not by mount(8) itself. We can improve this and use it in
> > libmount to read and print info-level messages.
> >
> > I can prepare a libmount/mount(8) patch for this.
>
> This sounds like a good idea to me.
>
> > > So there will definitely be some loss of
> > > information for pr_* logs that don't cause an actual error (which is =
a
> > > little unfortunate, since that is the exact dmesg spam that caused me=
 to
> > > write this patch).
> > >
> > > I could take a look at sending a patch to get libmount to output that
> > > information, but that won't help with the immediate issue, and this
> > > doesn't help with the possible concern with some script that scrapes
> > > dmesg. (Though I think it goes without saying that such scripts are k=
ind
> > > of broken by design -- since unprivileged users can create overlayfs
> > > mounts and thus spam the kernel log with any message, there is no
> > > practical way for a script to correctly get the right log information
> > > without using the new mount API's logging facilities.)
> >
> > > I can adjust this patch to only include the log+return-an-error cases=
,
> > > but that doesn't really address your primary concern, I guess.
> > >
> > > > > My strong feeling is that suppressing legacy errors to kmsg shoul=
d be opt-in
> > > > > via the new mount API and that it should not be the default for l=
ibmount.
> > > > > IMO, it is certainly NOT enough that new mount API is used by use=
rspace
> > > > > as an indication for the kernel to suppress errors to kmsg.
> >
> > For me, it seems like we are mixing two things together.
> >
> > kmesg is a *log*, and tools like systemd read and save it. It is used
> > for later issue debugging or by log analyzers. This means that all
> > relevant information should be included.
> >
> > The stderr/stdout output from tools such as mount(8) is simply
> > feedback for users or scripts, and informational messages are just
> > hints. They should not be considered a replacement for system logging
> > facilities. The same applies to messages read from the new mount API;
> > they should not be a replacement for system logs.
> >
> > In my opinion, it is acceptable to suppress optional and unimportant
> > messages and not save them into kmesg. However, all other relevant
> > messages should be included regardless of the tool or API being used.
>
> For warning or error messages, this makes sense -- though I think the
> "least spammy" option would be that the logs are output to kmesg if
> userspace closes the fscontext fd without reading the logs. That should
> catch programs that miss log information, without affecting programs
> that do read the logs (and do whatever they feel is appropriate with
> them). That would be some reasonable default behaviour, and users could
> explicitly opt into a verbose mode.
>
> For informational or debug messages, I feel that the default should be
> that we want to avoid outputting to kmesg when using the new mount API
> since the information is non-critical and the only way of associating
> the information is using the fscontext log. But if we had this "only log
> on close if not read" behaviour, I think having the same behaviour for
> all log messages would still work and would be more consistent.
>
> > Additionally, it should be noted that mount(8)/libmount is only a
> > userspace tool and is not necessary for mounting filesystems. The
> > kernel should not rely on libmount behavior; there are other tools
> > available such as busybox.
>
> Sure, but by switching to the new mount API you are buying into
> different behaviour for error logs (if only for the generic VFS ones),
> regardless of what kind of program you are.
>
> > > I can see an argument for some kind of MS_SILENT analogue for
> > > fsconfig(), though it will make the spam problem worse until programs
> > > migrate to setting this new flag.
> >
> > Yes, the ideal solution would be to have mount options that can
> > control this behavior. This would allow users to have control over it
> > and save their settings to fstab, as well as keep it specific to the
> > mount node.
> >
> > > Also, as this is already an issue ever since libmount added support f=
or
> > > the new API (so since 2.39 I believe?), I think it would make just as
> > > much sense for this flag to be opt-in -- so libmount could set the
> > > "verbose" or "kmsglog" flag by default but most normal programs would
> > > not get the spammy behaviour by default.

The "spammy" behavior is the legacy behavior, so we do not want to
regress it without opt-in unless there is a good reason to do it.
I may be slow, but I did not catch what that good reason is.

> >
> > I prefer if the default behavior is defined by the kernel, rather than
> > by userspace tools like libmount. If we were to automatically add any
> > mount options through libmount, it would make it difficult to coexist
> > with settings in fstab, etc. It's always better to have transparency
> > and avoid any hidden factors in the process.
>
> Right, my suggestion was that verbose should be opt-in precisely because
> wanting to output to kmesg when using the new mount API is something
> that only really makes sense for libmount and similar tools and so
> should be opt-in rather than opt-out.

My point was that kernel does not know which libmount version is used
and there are clearly libmount versions out in the wild, that will remain
out in the wild which by default, do not output all the legacy messages
that are currently printed to kmsg.

So I'm sorry, but I don't buy the argument for making the kernel default
behavior silence those messages.

Maybe I have a misconception about how useful those messages are.
I would love Miklos to chime in if he has an opinion.

Thanks,
Amir.

