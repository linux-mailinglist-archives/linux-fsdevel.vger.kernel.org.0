Return-Path: <linux-fsdevel+bounces-37636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C6A9F4DC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 15:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FCB167E08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 14:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA491F4E49;
	Tue, 17 Dec 2024 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smruJOT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C11F37B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445892; cv=none; b=E4g9sYgwCSiBHaueuFcCnQeAvbuVTWls+IkGrHHS6OMzzyOZvGX50KQXYFxT3yTX/nusdJXIoitGdceDJOf4MZNntYN3yAD4Py0koO+y3bVUbvuilac5tG6ko/v4LZjtgG3s+pwM7diH+7MVQ+9/nzAvO6DyelrlPxjh1C7hPsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445892; c=relaxed/simple;
	bh=zy50t/hza8/qqnHZ5cqN0yNA8hpNOnCQM+jwlTDCTW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EM80wcYIfJbcm90aeZPKsJxazdhcRP92kp6SLEGmrKryvTlHVIGbFkw6S/NXPm0qkiqt3v978IIqnYzrZA/Ukf256YdKhnxaMbZ+EY35LN4mAdSwUwcAQ4WeMVFpiODysZGHvckA+5wDhQApfuZoQnRgfqpdpC0oklDO7SG5NnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smruJOT3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-215740b7fb8so150515ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 06:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734445889; x=1735050689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IUKnZ0lzp04EWEQI6yO8xDcmIbMp5DmKbv3o4rFPlE=;
        b=smruJOT3NugDErNbgpA1Iqyu/zZwXpmen7P2Tmsqf7e3mn3ZixFxHW22iAg5m4CEVO
         Ez/ilbOKb97OspbpUwAX8j9hMNmO+LxSEDSU4fUqAVPs5CDrHDM0958Ip2WJTtTxjND8
         Agca2EZmCKwpNYe666IHBquB9BbhKP+Mh04+M5lsfRhJ+JxqHS30+v9oCxdDctb6Dlhs
         5UWac3JhBVp/ElTMC3jVajjCgVlo5sRO2hi2myJ45FdLjfkIu4RH/2iC8jsYPGUlsuWu
         5ENr7smAXPYc7/JyGqH5QZVaPrKdK0QgrXtd6CE0TnmAGN+u0Z2Rq5VJ+wYKTcAYRrPV
         vw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734445889; x=1735050689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IUKnZ0lzp04EWEQI6yO8xDcmIbMp5DmKbv3o4rFPlE=;
        b=dVwx/IBdtFs3JMgKM6+PSlmcDX3zrqdcH1t0YVqpcRXHCSGBO6hQovpr4/V0ilzBvd
         GRfs/B9X0egi2//410zKxN03eLVpYl9N5/f4B+bdMBi/+sii9CpuQSBEAyeHEurgSQxD
         yjcujbX2PC/+LBj9Lylhxoigtw7M9e5DQLkJMirE7LJd+S7XuDZFBF7H8VXd1YPyYQgv
         0uwMejfL7K3ioVzcECULDdMQYq0Zwu1Tu90i1X1r7QRCo4pqeBVeNYn+QKR9/SuCL3F/
         afkCvHK1H4CoXBpbnk0fUmqF8MV+j8g9Un61Fiz+2YSLYba0XKrueHrUCKeGmjRA6Cmg
         IWlg==
X-Forwarded-Encrypted: i=1; AJvYcCX/vlkKzL+ImZKARWdLGh9Lw8etEzmL69PN4piZuLmL7yP8kThD5OYC5JBkS1kPl0bwgLPaEeYi53nuSpjK@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/NHSNhKXVrjWbsRLlWnqh78Y9riIp46LdIKZJrl3gVMkabKe
	rJAteqywPpR1ea6C2d3ydj+WMD8cIN4c/NI2awhraVRqIam2fKHIbtIQeZnsDuzXs6Ll+GovDpv
	wGYhoDUBQ0QciDYn0iCYxGHmXBa9hOgszX+qM
X-Gm-Gg: ASbGncvGakRXHhm+nfCtJjagq7A+On/tUbbIDLxFQZYBBAzWsCdIeTqi8C09MtZ79hL
	2vbpdBAPgwcDWBXI3c3U/EwI97OEwhfYfmhZo
X-Google-Smtp-Source: AGHT+IHbAEaUpJMyIaGlrjcJhGwBko6mxJsWZi6pmCmhJ4SsZtC8iAiesZb8JsVR66lmc8LPi188LgFqCcBX8rJnxzU=
X-Received: by 2002:a17:903:120e:b0:215:b077:5c21 with SMTP id
 d9443c01a7336-218c9cd8afcmr2759855ad.26.1734445888799; Tue, 17 Dec 2024
 06:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426080548.8203-1-xuewen.yan@unisoc.com> <20241016-kurieren-intellektuell-50bd02f377e4@brauner>
 <ZxAOgj9RWm4NTl9d@google.com> <Z1saBPCh_oVzbPQy@google.com>
In-Reply-To: <Z1saBPCh_oVzbPQy@google.com>
From: Brian Geffon <bgeffon@google.com>
Date: Tue, 17 Dec 2024 09:30:51 -0500
Message-ID: <CADyq12y=MGzcvemZTVVGN4yhzr2ihr96OB-Vpg0yvrtrewnFDg@mail.gmail.com>
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for ep_poll_callback
To: Greg KH <gregkh@linuxfoundation.org>, "# v4 . 10+" <stable@vger.kernel.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, Christian Brauner <brauner@kernel.org>, jack@suse.cz, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, cmllamas@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, jing.xia@unisoc.com, xuewen.yan94@gmail.com, 
	viro@zeniv.linux.org.uk, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, lizeb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:14=E2=80=AFPM Brian Geffon <bgeffon@google.com> =
wrote:
>
> On Wed, Oct 16, 2024 at 03:05:38PM -0400, Brian Geffon wrote:
> > On Wed, Oct 16, 2024 at 03:10:34PM +0200, Christian Brauner wrote:
> > > On Fri, 26 Apr 2024 16:05:48 +0800, Xuewen Yan wrote:
> > > > Now, the epoll only use wake_up() interface to wake up task.
> > > > However, sometimes, there are epoll users which want to use
> > > > the synchronous wakeup flag to hint the scheduler, such as
> > > > Android binder driver.
> > > > So add a wake_up_sync() define, and use the wake_up_sync()
> > > > when the sync is true in ep_poll_callback().
> > > >
> > > > [...]
> > >
> > > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > > Patches in the vfs.misc branch should appear in linux-next soon.
> > >
> > > Please report any outstanding bugs that were missed during review in =
a
> > > new review to the original patch series allowing us to drop it.
> > >
> > > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > > patch has now been applied. If possible patch trailers will be update=
d.
> > >
> > > Note that commit hashes shown below are subject to change due to reba=
se,
> > > trailer updates or similar. If in doubt, please check the listed bran=
ch.
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > > branch: vfs.misc
> >
> > This is a bug that's been present for all of time, so I think we should=
:
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
>
> This is in as 900bbaae ("epoll: Add synchronous wakeup support for
> ep_poll_callback"). How do maintainers feel about:
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org

Dear stable maintainers, this fixes a bug goes all the way back and
beyond Linux 2.6.12-rc2. Can you please add this commit to the stable
releases?

commit 900bbaae67e980945dec74d36f8afe0de7556d5a upstream.

>
> >
> > I sent a patch which adds a benchmark for nonblocking pipes using epoll=
:
> > https://lore.kernel.org/lkml/20241016190009.866615-1-bgeffon@google.com=
/
> >
> > Using this new benchmark I get the following results without this fix
> > and with this fix:
> >
> > $ tools/perf/perf bench sched pipe -n
> > # Running 'sched/pipe' benchmark:
> > # Executed 1000000 pipe operations between two processes
> >
> >      Total time: 12.194 [sec]
> >
> >       12.194376 usecs/op
> >           82005 ops/sec
> >
> >
> > $ tools/perf/perf bench sched pipe -n
> > # Running 'sched/pipe' benchmark:
> > # Executed 1000000 pipe operations between two processes
> >
> >      Total time: 9.229 [sec]
> >
> >        9.229738 usecs/op
> >          108345 ops/sec
> >
> > >
> > > [1/1] epoll: Add synchronous wakeup support for ep_poll_callback
> > >       https://git.kernel.org/vfs/vfs/c/2ce0e17660a7
>
> Thanks,
> Brian
>

 Thanks,
 Brian

