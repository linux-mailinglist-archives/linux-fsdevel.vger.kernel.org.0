Return-Path: <linux-fsdevel+bounces-44633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E818A6AD10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 19:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431F9189979A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF19227E89;
	Thu, 20 Mar 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WwBCTEms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB571EB18F
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495044; cv=none; b=qYcd4OgU0n858JG28/RkjSwFKK6G740cwJO5V7yWoNoIpucp+ivTF7YvNmkqkdneyDvPMioieYr70JcR7MDu4o+7aQ44cJxPppUIYUip9iHj0uJCKpok/R3KM1FWrhcvzp5sH+rIHmUDU1oWSN8jh1SIDkH48zyfd4VlwcoA9+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495044; c=relaxed/simple;
	bh=p5C7au6pn1wBtzZYZ4qP8jufg2hjU9r8Y3dB0+e4uZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxNIrj6Vmb+spUB/XP1Oe44/8ajL/q2SjyDugu6egwn/kL4Xifm+dDmoxG0s6GKVkMZwFiJOBf184fFeuQSZCo9qRFmMuP+2nX+Vw/jENUaR9TuBNP8pW+qF08hsi9zFYhYZolrGLVbvEB9a08IvzSN1djfKH1YMZH2ctl+U1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WwBCTEms; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224341bbc1dso23538105ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742495041; x=1743099841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4hqLDLaMuKQjfJXNLqiy/5jqelv39CVb9y2B7DStAE=;
        b=WwBCTEmsZsE0u14w5+lel9PAQUo60ea3JFr9XutPnHRtSOArkey5lZs8L4WVD6XJsN
         H6cqTFbJQcbGEOWQZsJOsnuUviSYfA1qIVQNWfltM+2DamzufJB+olTsVkz/pBdrznhA
         ork0WIN/gbD1s4W2PsgM6+6+c4H/gbspynRv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742495041; x=1743099841;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4hqLDLaMuKQjfJXNLqiy/5jqelv39CVb9y2B7DStAE=;
        b=S4pfCXnmS32cFcymKkbp5fuNgcqxe73NmjFJoQQ9+aQ+l+dhKtq7lbxBDkL6LCPItw
         /JxmvHPsuEF7u4UJYj9nqN5zggxjh0d4yL6fOlyt0ssY+fol2vqkZhI3YNySpOoEWQsO
         mnh3IZfgfXodh4cBDol5G7Hq1qILdbeEa7LGtxas611y1DXD8xjAZC43vKzIgPqI5lY2
         OQvr7yzQ3h6Tk7T1rBOAsg/PRSIhxY42INGZRDiyqX5zoOJE3K+hBYCpTWjmHLyfaIN2
         WwD1cfntzxZvFVHrxYp8ZDNJGRML9/MBMvB9mHaH9As3byLXcnJZL09xhyIs6btKbUux
         owGA==
X-Forwarded-Encrypted: i=1; AJvYcCXB8aCyvgPdfOav01pxiqy9E5qyrD32JP3+9/ztw7Q0ZcfZHVJt9nURIdIGE+eFlMo4pLialKHzwSGAQVGZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDtoZzgcy0w595MFDbeKPnzxK/tE6AOjncOVGsuh2PFpqVJ9o
	jHrjwzYBXoJQdu7Ym8rA23Vuete4hQ2HjbEQS8phmdGzm6Ohrvv46yhSodFXRw0=
X-Gm-Gg: ASbGnctshlgeeu+A7YMApFJNuSyHaLd8mpC2DT70kHfFfMAeWb7iuH9k6E8Nk+HnYhz
	AuWACr0uIZrawqjU2xQDRqEWpmUOZNkpG+M+dsZPdOqERn7M10qMj6OogoBH6uJZ9ATXJWNqA7B
	S86bALSBAWwth48T5Ft4aFPNkU27pFk6LiNmDJ3zD+tkz0LtjLVl10tuOwWNCTfOwkx3IhKPxlb
	Cn0UQ8zXnkS2qm9ks8sC6N0Cls7VpQCShc/galqfPGNHO2JuqeNFXDyPfpeyH6NTj/dqGFvosaz
	ttetG96o+Ok5q2Zf4+pGbyBT95OQz8t+UKG/ysmyIttt4izeaeeuFTmH5epYqdmC68ifkJH31Yo
	NxGWa/DpLhnrkMWmI
X-Google-Smtp-Source: AGHT+IFjGyoj26a+mfA5sPrt2XYRA48FDA00r7QAzbLWG2KYNvo58GwB3aOzyQT77qllSS0qHLvptA==
X-Received: by 2002:a17:90b:2fc7:b0:2f9:bcd8:da33 with SMTP id 98e67ed59e1d1-3030feaa56fmr348796a91.21.1742495041407;
        Thu, 20 Mar 2025 11:24:01 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f5d4e46sm180311a91.14.2025.03.20.11.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:24:00 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:23:57 -0700
From: Joe Damato <jdamato@fastly.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org>
 <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <Z9uuSQ7SrigAsLmt@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9uuSQ7SrigAsLmt@infradead.org>

On Wed, Mar 19, 2025 at 10:57:29PM -0700, Christoph Hellwig wrote:
> On Wed, Mar 19, 2025 at 10:45:22AM -0700, Joe Damato wrote:
> > I don't disagree; I just don't know if app developers:
> >   a.) know that this is possible to do, and
> >   b.) know how to do it
> 
> So if you don't know that why do you even do the work?

I am doing the work because I use splice and sendfile and it seems
relatively straightforward to make them safer using an existing
mechanism, at least for network sockets.

After dropping the sendfile2 patches completely, it looks like in my
new set all of the code is within CONFIG_NET defines in fs/splice.c.
 
> > In general: it does seem a bit odd to me that there isn't a safe
> > sendfile syscall in Linux that uses existing completion notification
> > mechanisms.
> 
> Agreed.  Where the existing notification mechanism is called io_uring.

Sure. As I mentioned to Jens: I agree that any new system call
should be built differently.

But does that mean we should leave splice and sendfile as-is when
there is a way to potentially make them safer?

In my other message to Jens I proposed:
  - SPLICE_F_ZC for splice to generate zc completion notifications
    to the error queue
  - Modifying sendfile so that if SO_ZEROCOPY (which already exists)
    is set on a network socket, zc completion notifications are
    generated.

In both cases no new system call is needed and both splice and
sendfile become safer to use. 

At some point in the future a mechanism built on top of iouring
introduced as new system calls (sendmsg2, sendfile2, splice2, etc)
can be built.

> > Of course, I certainly agree that the error queue is a work around.
> > But it works, app use it, and its fairly well known. I don't see any
> > reason, other than historical context, why sendmsg can use this
> > mechanism, splice can, but sendfile shouldn't?
> 
> Because sendmsg should never have done that it certainly should not
> spread beyond purely socket specific syscalls.

I don't know the entire historical context, but I presume sendmsg
did that because there was no other mechanism at the time.

I will explain it more clearly in the next cover letter, but the way
I see the situation is:
  - There are existing system calls which operate on network sockets
    (splice and sendfile) that avoid copies
  - There is a mechanism already in the kernel in the networking
    stack for generating completion notifications
  - Both splice and sendfile could be extended to support this for
    network sockets so they can be used more safely, without
    introducing a new system call

> > If you feel very strongly that this cannot be merged without
> > dropping sendfile2 and only plumbing this through for splice, then
> > I'll drop the sendfile2 syscall when I submit officially (probably
> > next week?).
> 
> Splice should also not do "error queue notifications".  Nothing
> new and certainly nothing outside of net/ should.

It seems like Jens suggested that plumbing this through for splice
was a possibility, but sounds like you disagree.

Not really sure how to proceed here?

If code I am modifying is within CONFIG_NET defines, but lives in
fs/splice.c ... is that within the realm of net or fs ?

I am asking because I genuinely don't know.

As mentioned above and in other messages, it seems like it is
possible to improve the networking parts of splice (and therefore
sendfile) to make them safer to use without introducing a new system
call.

Are you saying that you are against doing that, even if the code is
network specific (but lives in fs/)?

> > I do feel pretty strongly that it's more likely apps would use
> > sendfile2 and we'd have safer apps out in the wild. But, I could be
> > wrong.
> 
> A purely synchronous sendfile that is safe is a good thing.  Spreading
> non-standard out of band notifications is not.  How to build that
> safe sendmsg is a good question, and a sendmsg2 might be a sane
> option for that.  The important thing is that the underlying code
> should use iocbs and ki_complete to notify I/O completion so that
> all the existing infrastucture like io_uring and in-kernel callers
> can reuse this.

I'm not currently planning to build sendmsg2 (and I've already
mentioned to Jens and above I will drop sendfile2), but if I have the time
it sounds like an interesting project.

