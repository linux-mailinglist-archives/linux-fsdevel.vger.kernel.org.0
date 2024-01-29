Return-Path: <linux-fsdevel+bounces-9303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D4F83FEA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 07:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAF51F21B70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 06:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4574D11A;
	Mon, 29 Jan 2024 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWFgdv3Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337DC4CDE0;
	Mon, 29 Jan 2024 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706510683; cv=none; b=aA/ZLsHtK/Jxb8ojZkt9xjvynyhivdM6Gqq4Vc1EJ60oLKHOviktFcDbdXpKfgjdvFgzqgAXZx01+ch4bFQHMhqJpxyXv/o/n9M4bH0XRLPEo9/Hp3Wz2qSxG8OCMlb/igeRP6JRtPn4hpKopZHckmZtbsdx5wc6LtDNU5ao6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706510683; c=relaxed/simple;
	bh=OxoRCOkmkae41vCfWm0QMR2mN2otuI42kdEjLO9tyNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtfRhtZ90dJTrc0xV3MsGAmXCVGDAM2s0lAZoPjVKK/KUWyU/GR5AsvsTZl7USnTSQgtAuOAn4p4PbO16UzFLRlpkGEIEjER1VzLwYIKjppw9tU8G6tVFvMdazfyjZH2j9eOovDvka8m+GO+Hkmt8SpQvdFBBids5skBFR0xOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWFgdv3Z; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68c3ac1fdb9so14734196d6.2;
        Sun, 28 Jan 2024 22:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706510681; x=1707115481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3sIeOV9vvB6C8MqwdJNXvnHEjm5BSZtIFxk4IlFlbAE=;
        b=PWFgdv3ZLyYn0BUBuz5b/IehZZKk7sUjSbMY2mQIt1axObMEUnzxY9oaskcv4hWZ+5
         17GgHrWcDyWynFGpKUk0qaQmWK0aY7Nxdkp0ljZdFB6qa0TpyJoXEz5VvHIaRT5fPNbK
         EXTWlZntxMgiPnX9YRh37VKMxcdW8fs1imj1q1nqXg0q7sqszG9p4S2ipY+ThhRvN0h1
         bqiSHD0LP73BZxLrgS6u5s1Eu+sM/ueShLHbtw7ZOHfMwTZbKuGrQLnK/p+J3786m77l
         uFRyR3qkqu537hPFwFcAP4Nkj020IX2yhrqIHNlwpN9V0bBC5ZxwQmnMxGbYkhxo7yD9
         WxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706510681; x=1707115481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sIeOV9vvB6C8MqwdJNXvnHEjm5BSZtIFxk4IlFlbAE=;
        b=AaCbTj07hVV+r1HfJ6byHHyh79y07TsWzhLI/Mffjb0sAqdf3OOPQgaukXSTT/4kUx
         jFotg2j/t9f3t4jXwmAYsX2RSHH/xIVGI0U1HFhrmMAdZ7N3VB5iegppT00TJGVdpAhC
         zvsT+8hSyE4Mlp0zbnSz8X8YfMnRdZ83h3iKOVxugv4uVpC4jg7rKU+dy0Sfi9DpRZ5E
         VE+cHIgdz8SQzQcMU14fqnGKcDZ6EzEonSRnaEza6f41y0nTaqQ5a8foKpDvuwnpfPPy
         wkv2miLyGfw1gKn7NFn4Idf9mkJ/2gTOKGG6xvMktvp3ue2cqhayCvqVJnjzCVuOq6uB
         eTrQ==
X-Gm-Message-State: AOJu0YwLo1LJX5tC4I2DZQOQP7mhGlqUSwMenwYbBfFd6QV9j1lg8CtE
	V6pfQqHEQl1RXiy6B9VIciDNY/j47fOi2oziZhNgQWR1rlwkGSFhoxcJ5h5gbqgKCNl6ER7N84U
	4/dQaf0J4JRakfrjE1ul6QZ3417Q=
X-Google-Smtp-Source: AGHT+IFfnDR1hP2vNcK5/+uNBDfC+cRSdRdOBWtG/DpVWbvO1oPjEMoTq+dNVq51e1c6V3N7S06sP6xZmzYAK3sGg6M=
X-Received: by 2002:ad4:576f:0:b0:681:7c2b:d86e with SMTP id
 r15-20020ad4576f000000b006817c2bd86emr5735432qvx.114.1706510681049; Sun, 28
 Jan 2024 22:44:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
 <20240128175111.69f8b973@rorschach.local.home> <CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
 <20240128185943.6920388b@rorschach.local.home> <20240128192108.6875ecf4@rorschach.local.home>
 <CAHk-=wg7tML8L+27j=7fh8Etk4Wvo0Ay3mS5U7JOTEGxjy1viA@mail.gmail.com> <20240128210938.436fc3b4@rorschach.local.home>
In-Reply-To: <20240128210938.436fc3b4@rorschach.local.home>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Jan 2024 08:44:29 +0200
Message-ID: <CAOQ4uxikMN9EapL5+6jtMn5Ahe4h7wGZOgEsdsjy87v72FxJDw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

> >
> > You need to deal with the realities of having made a filesystem. And
> > one of those realities is that you don't control the dentries, and you
> > can't randomly cache dentry state and then do things behind the VFS
> > layer's back.
>
> I'm not. I'm trying to let VFS know a directory is deleted. Because
> when you delete a kprobe, the directory that has the control files for
> that kprobe (like enabling it) go away too. I have to let VFS know that
> the directory is deleted, just like procfs has to tell it when a
> directory for a process id is no more.
>
> You don't kill tasks with: rmdir /proc/1234
>
> And you don't delete kprobes with: rmdir events/kprobe/sched
>
> >
> > So remove that broken function. Really.  You did a filesystem, and
> > that means that you had better play by the VFS rules.
> >
> > End of discussion.
>
> And I do it just like debugfs when it deletes files outside of VFS or
> procfs, and pretty much most virtual file systems.
>

I think it is better if we used the term "pseudo" file systems, because
to me VFS already stands for "virtual file system".

> >
> > Now, you can then make your own "read" and "lookup" etc functions say
> > "if the backing store data has been marked dead, I'll not do this".
> > That's *YOUR* data structures, and that's your choice.
> >
> > But you need to STOP thinking you can play games with dentries.  And
> > you need to stop making up BS arguments for why  you should be able
> > to.
> >
> > So if you are thinking of a "Here's how to do a virtual filesystem"
> > talk, I would suggest you start with one single word: "Don't".
> >
> > I'm convinced that we have made it much too easy to do a half-arsed
> > virtual filesystem. And eventfs is way beyond half-arsed.
> >
> > It's now gone from half-arsed to "I told you how to do this right, and
> > you are still arguing". That makes it full-arsed.
> >
> > So just stop the arsing around, and just get rid of those _broken_ dentry games.
>
> Sorry, but you didn't prove your point. The example you gave me is
> already covered. Please tell me when a kprobe goes away, how do I let
> VFS know? Currently the tracing code (like kprobes and synthetic
> events) calls eventfs_remove_dir() with just a reference to that ei
> eventfs_inode structure. I currently use the ei->dentry to tell VFS
> "this directory is being deleted". What other means do I have to
> accomplish the same thing?
>

Would kernfs_node_dentry() have been useful in that case?
Just looking at kernfs_node and eventfs_inode gives a very strong
smell of reinventing.

Note that the fact that eventfs has no rename makes the whole dentry
business a lot less complicated than it is in the general VFS case -
IIUC, an eventfs path either exists or it does not exist, but if it exists,
it conceptually always refers to the same underlying object (kprobe).

I am not claiming that kernfs can do everything that eventfs needs  -
I don't know, because I did not look into it.

But the concept of detaching the pseudo filesystem backing objects
from the vfs objects was already invented once and Greg has also
said the same thing.

My *feeling* at this point is that the best course of action is to use
kernfs and to improve kernfs to meet eventfs needs, if anything needs
improving at all.

IMO, the length and content of this correspondence in itself
is proof that virtual file systems should use an abstraction that
is much less flexible than the VFS.

Think of it this way - kernefs and VFS are both under-documented,
but the chances of getting kernfs well documented are far better
than ever being able to document all the subtleties of VFS for mortals.

IOW, I would be happy if instead of the LSFMM topic
"Making pseudo file systems inodes/dentries more like normal file systems"
We would be talking about
"Best practices for writing a pseudo filesystem" and/or
"Missing kernfs functionality for writing pseudo filesystems"

Thanks,
Amir.

