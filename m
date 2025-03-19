Return-Path: <linux-fsdevel+bounces-44477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ACCA698FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 20:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A9F1B80E63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 19:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF9E219A76;
	Wed, 19 Mar 2025 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vlfACF48"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF95217648
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411775; cv=none; b=BxSWY0HrgM9U068f+JesXpqdisCMisfQYMzbopTjr/i28F6ZRSdlLlxEpTRm1SUdynHH/F/1sRkTKid2nlqpU/35KmUwA5VE4lSDwFJ1EHD/bvI4Nm5GAm7AzjRX2cE+jGUHR7MVeNSqRqSTCNSQLVOnj57IVO/pTNOVWW8f+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411775; c=relaxed/simple;
	bh=AMC7O5Mkx9jqu2vg9GCA6xeI3m/5AxK89Kdq6/mF6qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i31o7uwqSt8P3EhhV5YO/BKF654fHSLB4BFJWmD4NKPGNsXL9mEMnePkxwCusj7PaeOM5g6tejNR3oEdloITX4ooI5XJccXHTWPByIhdtdKOdisGVeC/RrCJHXqVx53OqKg4v95IHlcMTbIHLrkpkV+3/4HtNpG/TZuy/YH7UqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vlfACF48; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22548a28d0cso46696035ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 12:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742411772; x=1743016572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZXwsswANMqp09rxFCGtanZZO7Rvv3Uu26H3QjdXD5I=;
        b=vlfACF48gfJhz7e8hwdARQo0ddwcyk+FnbUsCRJ2UwCS9++NJBr2X+G96/9Bjnu0qg
         o5dHpSFc8kDxdYUInot3bY3DDimd/VNZ0hNrCVmAaMOs3Srfz/WxfAe/YJ4/M8+8kMOt
         WJLT44yVt5I7wLuxXsmPCVNzloL02z5iBIM1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742411772; x=1743016572;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZXwsswANMqp09rxFCGtanZZO7Rvv3Uu26H3QjdXD5I=;
        b=gziunzxMR8313uACbDeEcsNlZ7bMsebHpgGrJLEkheK89sjfIWVktI85q6p4zEG8z1
         TJykzSPmIjrqgM7og0/0GcFYHZUzuz/zVTEIXxsEBgUt/iQGOW0jH7egKCSH4Q5qPnFg
         Sd4iL3Phlc1SLgxGrdHbzxI7VVCvFW/8N6JaTFldcbj4KoCMpo8iYbO4ilgCtama6VAF
         8uXUJEmAQWedhW4tdIEFV5hXjM0xBXY9UsHjivmOM7VXNjLVFRC+hSXO9LOUL1OiQmIL
         9tmN+0cddVtELqvo0Ac8gsMEdbBM8Xai7zIgIr8ug4c1WJz64qgt3rWK37RBYq+pUub9
         9wog==
X-Forwarded-Encrypted: i=1; AJvYcCWYBhH3+g/q03pJAeshcV1t+sWiLtQfmHmsHCCTKnILVw3nxFl5/XzhJUiJuEUrXB633zilpHFviyTeYdQ4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nHBtJhR1LI5L37oN2rFnuqZca4infw1bdpEvuRv7oV/PTqWn
	13LfqtVzu8AIUTp7OetBBWEZbMs/y2UpJ34YMcz5+mtYWJa3t0/v415hrl4wCMY=
X-Gm-Gg: ASbGnctE63454HjQP9T5ABcqXlDhUAX3AxO9JkeKH2XmveJ7Q9uqZQi1v6ejBTAp9+V
	FzNQMofoZb48QRePP6mC6dgOQ7ZZQ2N9JTpRzJ2H7QZt5i8J7CwZqtUcSJntS6c8bXEI4KQmMLh
	LAsGpEJASfOZNsqxY8QiQqUklYqz1fpFwQLRUQnlfjy/Bg4BOxl4USzFj+4Ucy7bIiEgXdEot3r
	pRTDEcjpo0N+EGuKQ1vZ8nJroUZI6wRyhpXr12jSyEBBh5NQoJACS8djHMzGqGZXFexIOh6Fe1G
	mU0BfzTOCYvtjdV7VzFgroOwYpnnbm5kXc0/Bpo2kd1hgASn+fLE9eucyfcPBUlo2YX91Wz+Rm0
	wS2LDLEEjff/87bv1
X-Google-Smtp-Source: AGHT+IEofdOhpjDUT+eViAkwJ42mmOeUvQtHTn3aknfZ/omdP2jMr8YSXgAtJtZUaxMiiooBHwuu5A==
X-Received: by 2002:a05:6a00:a87:b0:736:728b:5f1f with SMTP id d2e1a72fcca58-7377a92c52bmr618119b3a.19.1742411771785;
        Wed, 19 Mar 2025 12:16:11 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115295e5sm12091157b3a.23.2025.03.19.12.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:16:11 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:16:07 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9sX98Y0Xy9-Vzqf@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
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
 <dc3ebb86-f4b2-443a-9b0d-f5470fd773f1@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc3ebb86-f4b2-443a-9b0d-f5470fd773f1@kernel.dk>

On Wed, Mar 19, 2025 at 12:37:29PM -0600, Jens Axboe wrote:
> On 3/19/25 11:45 AM, Joe Damato wrote:
> > On Wed, Mar 19, 2025 at 11:20:50AM -0600, Jens Axboe wrote:
> >> On 3/19/25 11:04 AM, Joe Damato wrote:
> >>> On Wed, Mar 19, 2025 at 10:07:27AM -0600, Jens Axboe wrote:
> >>>> On 3/19/25 9:32 AM, Joe Damato wrote:
> >>>>> On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
> >>>>>> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
> >>>>>>> One way to fix this is to add zerocopy notifications to sendfile similar
> >>>>>>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
> >>>>>>> extensive work done by Pavel [1].
> >>>>>>
> >>>>>> What is a "zerocopy notification" 
> >>>>>
> >>>>> See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
> >>>>> sendmsg and passes MSG_ZEROCOPY a completion notification is added
> >>>>> to the error queue. The user app can poll for these to find out when
> >>>>> the TX has completed and the buffer it passed to the kernel can be
> >>>>> overwritten.
> >>>>>
> >>>>> My series provides the same functionality via splice and sendfile2.
> >>>>>
> >>>>> [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
> >>>>>
> >>>>>> and why aren't you simply plugging this into io_uring and generate
> >>>>>> a CQE so that it works like all other asynchronous operations?
> >>>>>
> >>>>> I linked to the iouring work that Pavel did in the cover letter.
> >>>>> Please take a look.
> >>>>>
> >>>>> That work refactored the internals of how zerocopy completion
> >>>>> notifications are wired up, allowing other pieces of code to use the
> >>>>> same infrastructure and extend it, if needed.
> >>>>>
> >>>>> My series is using the same internals that iouring (and others) use
> >>>>> to generate zerocopy completion notifications. Unlike iouring,
> >>>>> though, I don't need a fully customized implementation with a new
> >>>>> user API for harvesting completion events; I can use the existing
> >>>>> mechanism already in the kernel that user apps already use for
> >>>>> sendmsg (the error queue, as explained above and in the
> >>>>> MSG_ZEROCOPY documentation).
> >>>>
> >>>> The error queue is arguably a work-around for _not_ having a delivery
> >>>> mechanism that works with a sync syscall in the first place. The main
> >>>> question here imho would be "why add a whole new syscall etc when
> >>>> there's already an existing way to do accomplish this, with
> >>>> free-to-reuse notifications". If the answer is "because splice", then it
> >>>> would seem saner to plumb up those bits only. Would be much simpler
> >>>> too...
> >>>
> >>> I may be misunderstanding your comment, but my response would be:
> >>>
> >>>   There are existing apps which use sendfile today unsafely and
> >>>   it would be very nice to have a safe sendfile equivalent. Converting
> >>>   existing apps to using iouring (if I understood your suggestion?)
> >>>   would be significantly more work compared to calling sendfile2 and
> >>>   adding code to check the error queue.
> >>
> >> It's really not, if you just want to use it as a sync kind of thing. If
> >> you want to have multiple things in flight etc, yeah it could be more
> >> work, you'd also get better performance that way. And you could use
> >> things like registered buffers for either of them, which again would
> >> likely make it more efficient.
> > 
> > I haven't argued that performance would be better using sendfile2
> > compared to iouring, just that existing apps which already use
> > sendfile (but do so unsafely) would probably be more likely to use a
> > safe alternative with existing examples of how to harvest completion
> > notifications vs something more complex, like wrapping iouring.
> 
> Sure and I get that, just not sure it'd be worth doing on the kernel
> side for such (fairly) weak reasoning. The performance benefit is just a
> side note in that if you did do it this way, you'd potentially be able
> to run it more efficiently too. And regardless what people do or use
> now, they are generally always interested in that aspect.

Fair enough.

> >> If you just use it as a sync thing, it'd be pretty trivial to just wrap
> >> a my_sendfile_foo() in a submit_and_wait operation, which issues and
> >> waits on the completion in a single syscall. And if you want to wait on
> >> the notification too, you could even do that in the same syscall and
> >> wait on 2 CQEs. That'd be a downright trivial way to provide a sync way
> >> of doing the same thing.
> > 
> > I don't disagree; I just don't know if app developers:
> >   a.) know that this is possible to do, and
> >   b.) know how to do it
> 
> Writing that wrapper would be not even a screenful of code. Yes maybe
> they don't know how to do it now, but it's _really_ trivial to do. It'd
> take me roughly 1 min to do that, would be happy to help out with that
> side so it could go into a commit or man page or whatever.

I'd never be opposed to more documentation ;)

> > In general: it does seem a bit odd to me that there isn't a safe
> > sendfile syscall in Linux that uses existing completion notification
> > mechanisms.
> 
> Pretty natural, I think. sendfile(2) predates that by quite a bit, and
> the last real change to sendfile was using splice underneath. Which I
> did, and that was probably almost 20 years ago at this point...
> 
> I do think it makes sense to have a sendfile that's both fast and
> efficient, and can be used sanely with buffer reuse without relying on
> odd heuristics.

Just trying to tie this together in my head -- are you saying that
you think the kernel internals of sendfile could be changed in a
different way or that this a userland problem (and they should use
the io_uring wrapper you suggested above) ?

> >>> I would also argue that there are likely user apps out there that
> >>> use both sendmsg MSG_ZEROCOPY for certain writes (for data in
> >>> memory) and also use sendfile (for data on disk). One example would
> >>> be a reverse proxy that might write HTTP headers to clients via
> >>> sendmsg but transmit the response body with sendfile.
> >>>
> >>> For those apps, the code to check the error queue already exists for
> >>> sendmsg + MSG_ZEROCOPY, so swapping in sendfile2 seems like an easy
> >>> way to ensure safe sendfile usage.
> >>
> >> Sure that is certainly possible. I didn't say that wasn't the case,
> >> rather that the error queue approach is a work-around in the first place
> >> for not having some kind of async notification mechanism for when it's
> >> free to reuse.
> > 
> > Of course, I certainly agree that the error queue is a work around.
> > But it works, app use it, and its fairly well known. I don't see any
> > reason, other than historical context, why sendmsg can use this
> > mechanism, splice can, but sendfile shouldn't?
> 
> My argument would be the same as for other features - if you can do it
> simpler this other way, why not consider that? The end result would be
> the same, you can do fast sendfile() with sane buffer reuse. But the
> kernel side would be simpler, which is always a kernel main goal for
> those of us that have to maintain it.
>
> Just adding sendfile2() works in the sense that it's an easier drop in
> replacement for an app, though the error queue side does mean it needs
> to change anyway - it's not just replacing one syscall with another. And
> if we want to be lazy, sure that's fine. I just don't think it's the
> best way to do it when we literally have a mechanism that's designed for
> this and works with reuse already with normal send zc (and receive side
> too, in the next kernel).

It seems like you've answered the question I asked above and that
you are suggesting there might be a better and simpler sendfile2
kernel-side implementation that doesn't rely on splice internals at
all.

Am I following you? If so, I'll drop the sendfile2 stuff from this
series and stick with the splice changes only, if you are (at a high
level) OK with the idea of adding a flag for this to splice.

In the meantime, I'll take a few more reads through the iouring code
to see if I can work out how sendfile2 might be built on top of that
instead of splice in the kernel.

Thank you very much for your time, feedback, and attention,
Joe

