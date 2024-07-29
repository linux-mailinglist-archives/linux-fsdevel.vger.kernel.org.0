Return-Path: <linux-fsdevel+bounces-24503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F4C93FD6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176521C20BB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD708187337;
	Mon, 29 Jul 2024 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kjPnXLRN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12F15B555
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278143; cv=none; b=rlBE7AFrLMlXWsaE30rC5IVeDUE6XW/HnwP5rhPPjSOrAZn3BRa5fDRFG6Y/lhWA0xmgOsIBil4t9quQYCQKSkKFty7jVQRQEC4uoDtojpHzcO06H9P9D3kZOeCY+FxnjmOvfScOzK1MUqylDX+QIURV021lFgJgC2EEi+51LCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278143; c=relaxed/simple;
	bh=OWLMlW9nI4AoeJRIu2xE7z91rwpxUdo9FtEkVf832u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbbVR98y+SBko+9vhyADaSa861Ff/B2PS0slT519JeRJg+3GBUtnEALZKC7YDJv2vNWrGWtKn7tI1NaqTY6qydozD2cJ92qGohp60WAdCAJYo8pCWsP43aNmUp0SD2mJXL5+GtsQI6u2RLyqZaamlTyZm6IGbn2MtET71wSNTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kjPnXLRN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd657c9199so21385ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722278141; x=1722882941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GekW6Drxgu1csmMta62dgFi3qy5FXE8VqaYgFnRbcnM=;
        b=kjPnXLRNaNCcVy/OkfYIC1cPnmoKf9W/paQpMjZJoQfSfc5CrTbAp1Msh5HmU09HA0
         iN3iMxm39ujwMiSYR8jadqeQtvyHZ/sIWp7HAWv8iZUTRr3cChPeWiLOb2JhDMF7gXxQ
         7JcKkHgnXEy8i7Tg8dmzcFH0d7a1ahk5aWbrxBYPWdf2TI0ebHe9C1IyGPGMm46L6Ieh
         JUWeEKJ/JnfOV/EkJn7HejwabzE4ofQ8R+uQ5WTXZSCoHiD/BRLjCA3JvLE0fpmMXCnR
         Cia1bIYzwxDSjFtGtEf/AVLngt8C7keTRB738e5stFnDbtuH1CK6ZpuInnhfHN2Wuodl
         mz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278141; x=1722882941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GekW6Drxgu1csmMta62dgFi3qy5FXE8VqaYgFnRbcnM=;
        b=vIZOnS/v8FPm5sfF4LRhIdYOj4Nv4EEdKGYpiDDMQl8MyXjcaRg7K4NgDuN7zNC7YD
         8tl0AyeWKfmz1Q6QdVjbtkY1giDCqe4ZcQersHfrTGmX48Y4MZ28zye8nsBAaSM28f5D
         OP2lQqnbE5tIQ7F5bUKQLKEUNBDYDYmS1j0vIxJtpAEb/rAVd9oOamEKzrnPp2hWjlY6
         E8SWdHlTxfFJaLn0Gzk0RlyrnqbYobEs9lIUNloEcZpTpB0gmldpFXyKLMsjFb7FrS8e
         UCvOG1idBhnTTV+QUtOuQEqGhqOArWxhW8GaPIW5ginKJNQQ0naGt9gInIAFQ3ksYk9n
         CvSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv2oqF4Svo2vKZ+lIhp+69KrwVxhkbtmSnoQZ/kdwUE7l36o9yC/ByYPYxGG8LJRwGQfUuES/AK0js7c/bhgZdTKxJ1i8Q8gERZhxh4A==
X-Gm-Message-State: AOJu0Yxd1UTrzzlUzC9t/sYVewx8Ojod2upt8i0KTobHMYt843/IYWUd
	cYyERHmccLV7jCW7zgX1wRRbjP5eepS8fR07bwWjXEiuFfYhkGVy/EYB0pF4qw==
X-Google-Smtp-Source: AGHT+IFDW6XvLjcuBeaeEfqTb5/MYUs4HDyKi6Wro5NOVXcPidfha5m2d484zipsCXeKMFOtOjpatw==
X-Received: by 2002:a17:902:fc8d:b0:1fd:d0c0:1a69 with SMTP id d9443c01a7336-1ff34d8afefmr907325ad.9.1722278133866;
        Mon, 29 Jul 2024 11:35:33 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:c685:61bd:100e:aec7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1b80asm85755135ad.184.2024.07.29.11.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:35:33 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:35:28 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: tglx@linutronix.de, jstultz@google.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	saravanak@google.com, mjguzik@gmail.com,
	Manish Varma <varmam@google.com>,
	Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6] fs: Improve eventpoll logging to stop indicting
 timerfd
Message-ID: <Zqfg8G-6r0ujHnpK@google.com>
References: <20240703214315.454407-1-isaacmanjarres@google.com>
 <20240704-umsatz-drollig-38db6b84da7b@brauner>
 <Zo2l65cTwuSMDU-Z@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo2l65cTwuSMDU-Z@google.com>

On Tue, Jul 09, 2024 at 02:04:43PM -0700, Isaac Manjarres wrote:
> On Thu, Jul 04, 2024 at 04:03:59PM +0200, Christian Brauner wrote:
> > On Wed, Jul 03, 2024 at 02:43:14PM GMT, Isaac J. Manjarres wrote:
> > > From: Manish Varma <varmam@google.com>
> > > 
> > > We'll often see aborted suspend operations that look like:
> > > 
> > >  PM: suspend entry 2024-07-03 15:55:15.372419634 UTC
> > >  PM: PM: Pending Wakeup Sources: [timerfd]
> > >  Abort: Pending Wakeup Sources: [timerfd]
> > >  PM: suspend exit 2024-07-03 15:55:15.445281857 UTC
> > > 
> > > From this, it seems a timerfd caused the abort, but that can be
> > > confusing, as timerfds don't create wakeup sources. However,
> > > eventpoll can, and when it does, it names them after the underlying
> > > file descriptor. Unfortunately, all the file descriptors are called
> > > "[timerfd]", and a system may have many timerfds, so this isn't very
> > > useful to debug what's going on to cause the suspend to abort.
> > > 
> > > To improve this, change the way eventpoll wakeup sources are named:
> > > 
> > > 1) The top-level per-process eventpoll wakeup source is now named
> > > "epollN:P" (instead of just "eventpoll"), where N is a unique ID token,
> > > and P is the PID of the creating process.
> > > 
> > > 2) Individual eventpoll item wakeup sources are now named
> > > "epollitemN:P.F", where N is a unique ID token, P is PID of the creating
> > > process, and F is the name of the underlying file descriptor.
> > 
> > Fyi, that PID is meaningless or even actively misleading in the face of
> > pid namespaces. And since such wakeups seem to be registered in sysfs
> > globally they are visible to all containers. That means a container will
> > now see some timerfd wakeup source with a PID that might just accidently
> > correspond to a process inside the container. Which in turn also means
> Thanks for your feedback on this, Christian. With regards to this
> scenario: would it be useful to use a namespace ID, along with the PID,
> to uniquely identify the process? If not, do you have a suggestion for
> this?
> 
> I understand that the proposed naming scheme has a chance of causing
> collisions, however, it is still an improvement over the existing
> naming scheme in terms of being able to attribute wakeups to a
> particular application.
> 
> > you're leaking the info about the creating process into the container.
> > IOW, if PID 1 ends up registering some wakeup source the container gets
> > to know about it.
> Is there a general security concern about this? If not, can you please
> elaborate why this is a problem?
> 
Hey Christian,

I just wanted to follow-up to see if you had a chance to go through my
questions above?

Thanks,
Isaac

