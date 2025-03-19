Return-Path: <linux-fsdevel+bounces-44488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6246DA69CB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 00:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE018A2AB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 23:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1F224AE8;
	Wed, 19 Mar 2025 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Uo/gT6UL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF01224880
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742426575; cv=none; b=daZV4xY5hQ+W1DXkiP4aMofZ7c9KU/YWE65tXrJeqN7EtsA/4smvITSOojfiHqBU0cVapVdxn/+cek9b980wczWts/3L7itsHVIqtosAP2D76tjCZobOjHEU87NEvlQ/ghbWCAp0ChBZE8/GCER9CNBxcUdeza8DYU9c3kbKHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742426575; c=relaxed/simple;
	bh=ae9rlx1whGDKhagXiRxttetS8FA+ejbtaGjxWFoZyII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJdIT+HvmkHwn9/J+Q5Ji3L9NKO2Y3oasru7DU0pTXKnVISTAilxwcKQOwQdwJHjD6+2Ndh26tUZofWNWq8L8lFZKgOAT5dSKYJrVJn/U3lTUixzoHI92+/VRtPUKpBZyLk6wW2W4GrlxrgCnCzdWiP316kRGsQPFrBLiJdsGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Uo/gT6UL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225df540edcso28083695ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742426573; x=1743031373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdI4ujE7yE0oblUwCTVz2MCgqM4I0uuI2fAs3f/OjUM=;
        b=Uo/gT6ULuEnl2Z1/uveAtfRoE1fVAdSTR7KNfg02NzJUBuCk69NwWNTuYTYY4EEoKA
         1i4bd9slFzeLwmYXw10WHJ+sEiU+HbtqhowLEd32PTO2z2fKTJ4uJHB2Vt2cpZXSfuRW
         C70f8WGQP8dEdzGscD9E98qyq9JXa1iS+deRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742426573; x=1743031373;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdI4ujE7yE0oblUwCTVz2MCgqM4I0uuI2fAs3f/OjUM=;
        b=xNmEqOL49Fg740Fwtku5QsrfQ7D6uJL2fZx9ZHjqmYIHYUmyL3EfAC4hxb5tVujyKL
         +fT5VdZOZ5nbvAlHEuFkgPM0VkN4TfZ4H5Vm4EapGoW4jmsK/5vmssJUNi8QzV2V4YCp
         PjVL/ulCmm2qgqniVeETpcqZq3Zp5VGsGt4F6GrSJOgOk0L7D4OIKV6taKiCUmLhkCtz
         67ZfugKLaPCiug3cEP6HxLYf1Y38oUjXUfLZKp3SXQYhE8+PbPkwaG83mg+sP74NxAY+
         49Rb5xPmi5WKd8qCIaiS/3bSTRBBJDYgA4DSruA1wZJSxCdY27lVRqDdvZ9Y87+goKAA
         b3+g==
X-Forwarded-Encrypted: i=1; AJvYcCUWHwScrU+1RNrWLHgYLzJrlqHX7i2+IqHSgyJD/uVbfr2kLbqE/BfOfNgIQkx6qEK5f0SVY6644mc7pl1z@vger.kernel.org
X-Gm-Message-State: AOJu0YxyTExM1sD49O6EmEVe0D97cZ+Ezg1ovziWXE/LPZX8EOR1zlb5
	xW/VqtNuOunsYEpJaTHXsrReap/Q96lbW8TY88TG8m4jrYtLY3TmuHazGm6uVfk=
X-Gm-Gg: ASbGncuU81lQvi059jGSt//0dRAYOLBMYSfSAW8pHY+8a2DV28YJevIhlA8YtY/hqDT
	jEda8+oHTUTgbTmbncUlCPp6nUzv3sCGjZbCr+RMEz68LWw+PCcLuImiFx245KPXjb2Vij+cE5W
	2uIzdn3rk4fi8Q4Ls3a2Q6C4OBOdo7sbyYQB+cgtBlPFvnRM9C/LSYXF/hsk3lwO8FJ8UHOC/a/
	UZZr1F2M+iYILCJBAhT3EQXFIHYMzJ4AD5p/lYEDiID6ieubijCbtT6Q5DCTltTdpkChX7TD+Dw
	0ytZ99UDs1CHa1bBSVc4ai9XC6WeQFDIIwvWYVDjJ4lb1pFP44JOCYgwnfx4vFDqUCjngxmZdUI
	UpgUdS/3wMvS+Rpyw
X-Google-Smtp-Source: AGHT+IG2dHorZURvsBe8FbIvm9Ot+bVszEXfqj6y7gPkK29Cdkho8rVqZj3wc8miFsa8O6743/+MAw==
X-Received: by 2002:a17:90b:38d0:b0:2fa:30e9:2051 with SMTP id 98e67ed59e1d1-301d42b3a2dmr1795842a91.5.1742426573223;
        Wed, 19 Mar 2025 16:22:53 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301a39f1073sm3930726a91.0.2025.03.19.16.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 16:22:52 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:22:49 -0700
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
Message-ID: <Z9tRyeJE5uKDJAdo@LQ3V64L9R2>
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
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>

On Wed, Mar 19, 2025 at 10:07:27AM -0600, Jens Axboe wrote:
> On 3/19/25 9:32 AM, Joe Damato wrote:
> > On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
> >> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
> >>> One way to fix this is to add zerocopy notifications to sendfile similar
> >>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
> >>> extensive work done by Pavel [1].
> >>
> >> What is a "zerocopy notification" 
> > 
> > See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
> > sendmsg and passes MSG_ZEROCOPY a completion notification is added
> > to the error queue. The user app can poll for these to find out when
> > the TX has completed and the buffer it passed to the kernel can be
> > overwritten.
> > 
> > My series provides the same functionality via splice and sendfile2.
> > 
> > [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
> > 
> >> and why aren't you simply plugging this into io_uring and generate
> >> a CQE so that it works like all other asynchronous operations?
> > 
> > I linked to the iouring work that Pavel did in the cover letter.
> > Please take a look.
> > 
> > That work refactored the internals of how zerocopy completion
> > notifications are wired up, allowing other pieces of code to use the
> > same infrastructure and extend it, if needed.
> > 
> > My series is using the same internals that iouring (and others) use
> > to generate zerocopy completion notifications. Unlike iouring,
> > though, I don't need a fully customized implementation with a new
> > user API for harvesting completion events; I can use the existing
> > mechanism already in the kernel that user apps already use for
> > sendmsg (the error queue, as explained above and in the
> > MSG_ZEROCOPY documentation).
> 
> The error queue is arguably a work-around for _not_ having a delivery
> mechanism that works with a sync syscall in the first place. The main
> question here imho would be "why add a whole new syscall etc when
> there's already an existing way to do accomplish this, with
> free-to-reuse notifications". If the answer is "because splice", then it
> would seem saner to plumb up those bits only. Would be much simpler
> too...

OK, I reworked the patches to drop all the sendfile2 stuff so no new
system call is added. Only a flag for splice, SPLICE_F_ZC.

It feels weird to add this to the splice path but not the path that
sendfile takes through splice.

I understand and agree with you: if we are adding a new system
call, like sendfile2, it should probably be done as you've
described in your other messages.

What about an alternative?

Would you be open to the idea that sendfile could be extended to
generate error queue completions if the network socket has
SO_ZEROCOPY set?

If so, that would solve the original problem without introducing a
new system call and still leaves the door open for a more efficient
sendfile2 based on iouring internals later.

What do you think?

