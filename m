Return-Path: <linux-fsdevel+bounces-9200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C22F83ECB0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D781A2852A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 10:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF23F1EB2C;
	Sat, 27 Jan 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Ck4ais"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F41C06
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350514; cv=none; b=t4AMImxdiUMJtVkzKxT8G7/fmEOgsG6mtu3SxvhRugtnl5SzIkKDdsodGHIXXLRx9e0o2oWfUvwD+xEn2wtbTc/WPLL7OCuc6cZLpQjRPGAcjOtl93g1JlmY4x9gh6x99a/JqbQZTHzfeWsGdXda9xsy/VKctIcpip8FcA6R8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350514; c=relaxed/simple;
	bh=rW0+59gcZJE9eXVolyeOz+Ks+S7INmYy/UrWpysh+Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7oI103yGlywx7mEIFI/ydfgEe4RKlVLPO5ohtL2sSM3bzZlGaJb+hgw/y4qXd9VlyYLg71wmTxW+F1jD3NTSp6/dNKx1UV3K4sIcAFH5UH8GFfefoG3FjlFmIh6zhhPhNWGuS3f8/miIJTRz2yCPsjHtT9F3nECynbKlYrqquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1Ck4ais; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68c37bf73aaso7316226d6.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 02:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706350511; x=1706955311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u738Q0FabqbaEi1Vqzz4jjzfk5DhIEX6cSXtopolu60=;
        b=U1Ck4aisjhyQwPALjd4IOd7aGCCwgmcColKj23nlHxxm/P5K7UbKP3CQmD4ATUMtbO
         ST4RSIMARpvcXBzOYQnI0SfB0wC5lI5B0yYLWAfv/6znuUOIunduiU5+vuLZrXsDf/cm
         V+cCJr4ZEqVv/cMxAclq0w06O93F2mAgPzKx4u9fHUYDyL9mASytngw/R/YAtT0IAEcj
         Al5IcoPZvhzxYrHoU66iTJJ5bUwvp8Vy6Ztk/tROgXK9fy93ym6B9V7OubpFlZd52dOr
         ZlT10taZ7x8yD7qc/qOe45O7kwIPRtwiOGE/k4CxD3Ye1rofxJ9fLhrBlC45Oy2FVS0F
         5+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706350511; x=1706955311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u738Q0FabqbaEi1Vqzz4jjzfk5DhIEX6cSXtopolu60=;
        b=qQ6QcpcmRU//rpDrbTID1SRKsu5QGWCgXfcRHpQZVbBqN3HtLPvWoMY5SMCDXnE+qf
         R6tTEKgbdFPteOPS05QTtbJJLoe0waDskqgt9opn1GsxcShhk56iWFRpidEaTRJWDFAW
         sulDzRhIBpm85TviiUo4ZKV5Hdy9zmiqGQqeEFMCCXcfnOXFshyVUdQCPgLV/1Pvf9Sc
         Fvm6+txHMvMWEg44kg5la4XVeBn2qnpyrmvLadxXUftVCvsMUNMFLwCl7veUCPuUvWgH
         4qg6hfG0zhib5qp/QnRs5vzDVLWJ2wpsPvQq8YH9yaXGxPoCeL8r46/iI4LBKsH+O91W
         08Lg==
X-Gm-Message-State: AOJu0Yx0gewtYqJsdbvGmz+DyZjsw5BMs5ZHY0fUp+3yT9LW3OqOhWhF
	gyCSg8FtG9u7ASt1P6bRFMGc3B+ViqQmLYRyL3fwy+AB+JcqxfYbT0ooLqz+Yb2AP2Iu6JMnPDX
	IXYn3hPO2o34FQCoBEwLO29vicnE1yxu1Yy8=
X-Google-Smtp-Source: AGHT+IFPxZk0oGttomvcI62HnENt3rw00UC+DOKxhh0dQfPo2rop3Sy3Cjbwza0hXBAh2DrMog+u/3/YQmCSBqhVphw=
X-Received: by 2002:ad4:5747:0:b0:681:6d57:65f6 with SMTP id
 q7-20020ad45747000000b006816d5765f6mr1688582qvx.123.1706350511543; Sat, 27
 Jan 2024 02:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125104822.04a5ad44@gandalf.local.home> <2024012522-shorten-deviator-9f45@gregkh>
 <20240125205055.2752ac1c@rorschach.local.home> <2024012528-caviar-gumming-a14b@gregkh>
 <20240125214007.67d45fcf@rorschach.local.home> <2024012634-rotten-conjoined-0a98@gregkh>
 <20240126101553.7c22b054@gandalf.local.home> <2024012600-dose-happiest-f57d@gregkh>
 <20240126114451.17be7e15@gandalf.local.home>
In-Reply-To: <20240126114451.17be7e15@gandalf.local.home>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 27 Jan 2024 12:15:00 +0200
Message-ID: <CAOQ4uxjRxp4eGJtuvV90J4CWdEftusiQDPb5rFoBC-Ri7Nr8BA@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:44=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 26 Jan 2024 07:41:31 -0800
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> > > The reason I brought it up was from Linus's comment about dentries an=
d
> > > inodes should not exist if the file system isn't mounted. That's not =
the
> > > case with debugfs. My question is, do we want debugfs to not use dent=
ries
> > > as its main handle?
> >
> > In the long run, yes, I want the "handle" that all callers to debugfs t=
o
> > NOT use a dentry, and have been slowly migrating away from allowing
> > debugfs to actually return a dentry to the caller.  When that is
> > eventually finished, it will be an opaque "handle" that all users of
> > debugfs has and THEN we can convert debugfs to do whatever it wants to.
>
> So it does sound like we are on the same page ;-)
>
> >
> > Again, long-term plans, slowly getting there, if only I had an intern o=
r
> > 10 to help out with it :)
>
> Yeah, this is something we need to think about when people come up to us
> and say "I'd like to be a kernel developer, is there anything you know of
> that I can work on?" Add a KTODO?
>
> >
> > But, this is only being driven by my "this feels like the wrong api to
> > use" ideas, and seeing how debugfs returning a dentry has been abused b=
y
> > many subsystems in places, not by any real-world measurements of
> > "debugfs is using up too much memory!" like we have had for sysfs ever
> > since the beginning.
>
> So we have a bit of miscommunication. My motivation for this topic wasn't
> necessary on memory overhead (but it does help). But more about the
> correctness of debugfs. I can understand how you could have interpreted m=
y
> motivation, as eventfs was solely motivated by memory pressure. But this
> thread was motivated by Linus's comment about dentries not being allocate=
d
> before mounting.
>
> >
> > If someone comes up with a real workload that shows debugfs is just too
> > slow or taking up too much memory for their systems for functionality
> > that they rely on (that's the kicker), then the movement for debugfs to
> > kernfs would happen much faster as someone would actually have the need
> > to do so.
>
> Another motivation is to prevent another tracefs happening. That is,
> another pseudo file system that copies debugfs like the way tracefs was
> created. I've had a few conversations with others that say "we have a
> special interface in debugfs but we want to move it out". And I've been
> (incorrectly) telling them what I did with tracefs from debugfs.
>
> >
> > > > Don't change stuff unless you need to, right?
> > > >
> > > > > I could look at it too, but as tracefs, and more specifically eve=
ntfs,
> > > > > has 10s of thousands of files, I'm very concerned about meta data=
 size.
> > > >
> > > > Do you have real numbers?  If not, then don't worry about it :)
> > >
> > > I wouldn't be doing any of this without real numbers. They are in the
> > > change log of eventfs.
> > >
> > >  See commits:
> > >
> > >    27152bceea1df27ffebb12ac9cd9adbf2c4c3f35
> > >    5790b1fb3d672d9a1fe3881a7181dfdbe741568f
> >
> > Sorry, I mean for debugfs.
>
> No problem. This is how I figured we were talking pass each other. eventf=
s
> was a big culprit in memory issues, as it has so many files. But now I'm
> talking about correctness more than memory savings. And this came about
> from my conversations with Linus pointing out that "I was doing it wrong"=
 ;-)
>
> >
> > > > Again, look at kernfs if you care about the memory usage of your vi=
rtual
> > > > filesystem, that's what it is there for, you shouldn't have to rein=
vent
> > > > the wheel.
> > >
> > > Already did because it was much easier than trying to use kernfs with=
out
> > > documentation. I did try at first, and realized it was easier to do i=
t
> > > myself. tracefs was based on top of debugfs, and I saw no easy path t=
o go
> > > from that to kernfs.
> >
> > Perhaps do some digging into history and see how we moved sysfs to
> > kernfs, as originally sysfs looked exactly like debugfs.  That might
> > give you some ideas of what to do here.
>
> I believe one project that should come out of this (again for those that
> want to be a kernel developer) is to document how to create a new pseudo
> file system out of kernfs.
>
> >
> > > > And the best part is, when people find issues with scaling or other
> > > > stuff with kernfs, your filesystem will then benifit (lots of tweak=
s
> > > > have gone into kernfs for this over the past few kernel releases.)
> > >
> > > Code is already done. It would be a huge effort to try to convert it =
over
> > > to kernfs without even knowing if it will regress the memory issues, =
which
> > > I believe it would (as the second commit saved 2 megs by getting rid =
of
> > > meta data per file, which kernfs would bring back).
> > >
> > > So, unless there's proof that kernfs would not add that memory footpr=
int
> > > back, I have no time to waste on it.
> >
> > That's fine, I was just responding to your "do we need a in-kernel way
> > to do this type of thing" and I pointed out that kernfs already does
> > just that.  Rolling your own is great, like you did, I'm not saying you
> > have to move to kernfs at all if you don't want to as I'm not the one
> > having to maintain eventfs :)
>
> Yeah. So now the focus is on keeping others from rolling their own unless
> they have to. I (or more realistically, someone else) could possibly
> convert the tracefs portion to kernfs (keeping eventfs separate as it is
> from tracefs, due to the amount of files). It would probably take the sam=
e
> effort as moving debugfs over to kernfs as the two are pretty much
> identical.
>
> Creating eventfs was a great learning experience for me. But it took much
> more time than I had allocated for it (putting me way behind in other
> responsibilities I have).
>
> I still like to bring up this discussion with the hopes that someone may =
be
> interested in fixing this.
>

I would like to attend the talk about what happened since we suggested
that you use kernfs in LSFMM 2022 and what has happened since.
I am being serious, I am not being sarcastic and I am not claiming that
you did anything wrong :)

Also ,please do not forget to also fill out the Google form:

          https://forms.gle/TGCgBDH1x5pXiWFo7

So we have your attendance request with suggested topics in our spreadsheet=
.

Thanks,
Amir.

