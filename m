Return-Path: <linux-fsdevel+bounces-44468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC0AA696CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 18:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8949119C37D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC576207A2A;
	Wed, 19 Mar 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="biyyC0Ci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5CF1E231F
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406329; cv=none; b=aZ8VcgoLAq2j1DZpsnzdw8aBk6pbjycXThBIGgPxZ7G4n2YiC/lo/a4ybVXp0zhuWPhji2ZE2Vnpn5jdZSTzoifZE2YEWmbCaJHcAqyOXlmW5astITXgjrFo3qE+1YVjgppKaQ/EQHUd0XMl16k7YigzzuWcYLgvzIGAZFW8bXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406329; c=relaxed/simple;
	bh=Mja/DsqMC96aBenZikHbYJ7mmYRS4Gju4qJTnOUreFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcrwU/os7vFf6oaj04oQzZHWKcTgkq2gQWLt34i8B5nyUXZbdAOpt7gUVRFxu2ewL9HDpy8zFa6klAj8n5/ByM+A8NQZ7h8qpSK71sgMMUcsXeVbkEQLwI0xHFnuHlN04UY9W1++a3X+oTAdjrTC8aJWb7MbxI0GhnpOMxN8E2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=biyyC0Ci; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224171d6826so52547385ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742406327; x=1743011127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88yW33TrWIk/+/WaI5H9h1QmYyDkMe4Hu9deS8t+58M=;
        b=biyyC0CidajeDa7Wg0pt7wfyYZZOZLbjQReMFZW/rVpEewIuWNO8Ax1CIz6Cw/iE8F
         SutXvBmY8l5JfvXre1l+/hxuFPtHvxtQ+qUj+6vuz8fCrloLxxu7eFqzJyOoNJBmkkR2
         K757qV5PZ9fzsIOXsHG1NnJom0T7GfETHUvy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742406327; x=1743011127;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88yW33TrWIk/+/WaI5H9h1QmYyDkMe4Hu9deS8t+58M=;
        b=rEBwfMr6CoORiPZ62rWjIEs5JKJVKFjtslzTRYMWpOTBYwkj9D/OXBCq840LrXwiv+
         tv1YQR6LnKqe+SXqmv7UI5iQZF0QYD5bN37Jur4pOoBR5w7Xqo6ciePiLX5qtAj6rXtf
         Lco5VzI4FPMWFK9M606RY7xDrhmGSRdRRf6jHKNjzV8jYWxBMfgkuqsmDSfQkxPGdZK2
         7VcHcmdM7TQx4vNQCC1QeCxM9qcDZxw5paelOkLy8DP9G35SGmFkuL2ozvHFYgEkIjC9
         EpX9IvnzQq/45x3lnKbPvhgpX1O1hgNRd5C/CQAyx8dFemAUthwczH2DYI3FNfvrvrW3
         8nUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaKKcg+MmYEQYGL7GSFnAKAbI9YbmPWy70992rFrcs4C3nbYp5wZaJkviDl1l6mwAizPz8Qb9aASlzNkcq@vger.kernel.org
X-Gm-Message-State: AOJu0YwCiBThDDzv53G3jJnatUoT1kZlNpRhCITj1yq0ydXSrTI2XB0R
	Zgp/5/woUti+uXaf2zeELv+kMjR/wHET1Q8nF5k30OjwslJ9HwFp/x/+u+D8er4=
X-Gm-Gg: ASbGncvtF58IXpaqBUGGzokc5PnbFrcvLTXwkI0lyXF44qkn9smZRHJchFHyBL9njus
	HmU3pdjai5woE8MewGugOkzuj6QmNMzcabTW5YvdwgrsEKrmd5VMGDX+KJadEjQjAmr/09dZaOq
	sFWz0SN/er9KcLmtc8627TT7lKOyca0GA2YqdVVq1i/XmHngHxfSro4M+Xuk/JwVK0X9JFS2M0i
	TauZDKdQbGFzuw25kvvd1MQfqrrckpVrPgu5QK7aluqJ6BQ8AgQHDkAMXXveM4flo+MjHTbh4gO
	XvNGnPCdQG7+OjuSR9tHA7RZqpK43+4YPxwnB5xpWfCGcgenh71ZWfZ5UVlNuahNfqhBpy2/Z+x
	9h3mKOPoJDh53LuJK
X-Google-Smtp-Source: AGHT+IERFHHbx0A4wA9qJdQkKklw0ufeU3XYHswtvVKJOCpGkGhgwLEpUnI6jmKEfZkWMIg4V+8Kpw==
X-Received: by 2002:a17:903:1790:b0:224:283f:a9ef with SMTP id d9443c01a7336-2264981d654mr49179945ad.6.1742406326748;
        Wed, 19 Mar 2025 10:45:26 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22634aa7462sm36188005ad.224.2025.03.19.10.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:45:26 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:45:22 -0700
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
Message-ID: <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
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
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>

On Wed, Mar 19, 2025 at 11:20:50AM -0600, Jens Axboe wrote:
> On 3/19/25 11:04 AM, Joe Damato wrote:
> > On Wed, Mar 19, 2025 at 10:07:27AM -0600, Jens Axboe wrote:
> >> On 3/19/25 9:32 AM, Joe Damato wrote:
> >>> On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
> >>>> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
> >>>>> One way to fix this is to add zerocopy notifications to sendfile similar
> >>>>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
> >>>>> extensive work done by Pavel [1].
> >>>>
> >>>> What is a "zerocopy notification" 
> >>>
> >>> See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
> >>> sendmsg and passes MSG_ZEROCOPY a completion notification is added
> >>> to the error queue. The user app can poll for these to find out when
> >>> the TX has completed and the buffer it passed to the kernel can be
> >>> overwritten.
> >>>
> >>> My series provides the same functionality via splice and sendfile2.
> >>>
> >>> [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
> >>>
> >>>> and why aren't you simply plugging this into io_uring and generate
> >>>> a CQE so that it works like all other asynchronous operations?
> >>>
> >>> I linked to the iouring work that Pavel did in the cover letter.
> >>> Please take a look.
> >>>
> >>> That work refactored the internals of how zerocopy completion
> >>> notifications are wired up, allowing other pieces of code to use the
> >>> same infrastructure and extend it, if needed.
> >>>
> >>> My series is using the same internals that iouring (and others) use
> >>> to generate zerocopy completion notifications. Unlike iouring,
> >>> though, I don't need a fully customized implementation with a new
> >>> user API for harvesting completion events; I can use the existing
> >>> mechanism already in the kernel that user apps already use for
> >>> sendmsg (the error queue, as explained above and in the
> >>> MSG_ZEROCOPY documentation).
> >>
> >> The error queue is arguably a work-around for _not_ having a delivery
> >> mechanism that works with a sync syscall in the first place. The main
> >> question here imho would be "why add a whole new syscall etc when
> >> there's already an existing way to do accomplish this, with
> >> free-to-reuse notifications". If the answer is "because splice", then it
> >> would seem saner to plumb up those bits only. Would be much simpler
> >> too...
> > 
> > I may be misunderstanding your comment, but my response would be:
> > 
> >   There are existing apps which use sendfile today unsafely and
> >   it would be very nice to have a safe sendfile equivalent. Converting
> >   existing apps to using iouring (if I understood your suggestion?)
> >   would be significantly more work compared to calling sendfile2 and
> >   adding code to check the error queue.
> 
> It's really not, if you just want to use it as a sync kind of thing. If
> you want to have multiple things in flight etc, yeah it could be more
> work, you'd also get better performance that way. And you could use
> things like registered buffers for either of them, which again would
> likely make it more efficient.

I haven't argued that performance would be better using sendfile2
compared to iouring, just that existing apps which already use
sendfile (but do so unsafely) would probably be more likely to use a
safe alternative with existing examples of how to harvest completion
notifications vs something more complex, like wrapping iouring.

> If you just use it as a sync thing, it'd be pretty trivial to just wrap
> a my_sendfile_foo() in a submit_and_wait operation, which issues and
> waits on the completion in a single syscall. And if you want to wait on
> the notification too, you could even do that in the same syscall and
> wait on 2 CQEs. That'd be a downright trivial way to provide a sync way
> of doing the same thing.

I don't disagree; I just don't know if app developers:
  a.) know that this is possible to do, and
  b.) know how to do it

In general: it does seem a bit odd to me that there isn't a safe
sendfile syscall in Linux that uses existing completion notification
mechanisms.

> > I would also argue that there are likely user apps out there that
> > use both sendmsg MSG_ZEROCOPY for certain writes (for data in
> > memory) and also use sendfile (for data on disk). One example would
> > be a reverse proxy that might write HTTP headers to clients via
> > sendmsg but transmit the response body with sendfile.
> > 
> > For those apps, the code to check the error queue already exists for
> > sendmsg + MSG_ZEROCOPY, so swapping in sendfile2 seems like an easy
> > way to ensure safe sendfile usage.
> 
> Sure that is certainly possible. I didn't say that wasn't the case,
> rather that the error queue approach is a work-around in the first place
> for not having some kind of async notification mechanism for when it's
> free to reuse.

Of course, I certainly agree that the error queue is a work around.
But it works, app use it, and its fairly well known. I don't see any
reason, other than historical context, why sendmsg can use this
mechanism, splice can, but sendfile shouldn't?

> > As far as the bit about plumbing only the splice bits, sorry if I'm
> > being dense here, do you mean plumbing the error queue through to
> > splice only and dropping sendfile2?
> > 
> > That is an option. Then the apps currently using sendfile could use
> > splice instead and get completion notifications on the error queue.
> > That would probably work and be less work than rewriting to use
> > iouring, but probably a bit more work than using a new syscall.
> 
> Yep

I'm not opposed to dropping the sendfile2 part of the series for the
official submission. I do think it is a bit odd to add the
functionality to splice only, though, when probably many apps are
using splice via calls to sendfile and there is no way to safely use
sendfile.

If you feel very strongly that this cannot be merged without
dropping sendfile2 and only plumbing this through for splice, then
I'll drop the sendfile2 syscall when I submit officially (probably
next week?).

I do feel pretty strongly that it's more likely apps would use
sendfile2 and we'd have safer apps out in the wild. But, I could be
wrong.

That said: if the new syscsall is the blocker, I'll drop it and
offer a change to the sendfile man page suggesting users swap it
with calls to splice + error queue for safety.

I greatly appreciate you taking a look and your feedback.

Thanks,
Joe

