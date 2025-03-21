Return-Path: <linux-fsdevel+bounces-44745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF9FA6C52A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 22:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07EF4626DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBCE230BF8;
	Fri, 21 Mar 2025 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rFDwWK0a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325C4231A51
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592502; cv=none; b=f3ZL5FOwyUYtVogMsf2M3J0GHJypctruQ8Zb9u+xRUT8Bh/+8sIh27TcOkwW1LHKzA6Lc30kUM2GoAksQAF+lEVaQcUyWswRf5pL9PekFnSUhWZuSS/jZCEhfH6KkA62YPt7uoHijv6EaQ9P2BjJVGtiERi4qoj+uNaGdn3r4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592502; c=relaxed/simple;
	bh=qXj971FSFP/wOZUPcfSsBiuTp/DvOZnX2IFBROliFJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvWKgg5yi5UVvdIqYyYV/0hK4Vpq8HYyAwurVO7RdIDkTfxbN7LxSVfoAuxTv6qTNrNSeveCrtEfnZI24iAl5MNucsaWRuDOh+hrzteq8hkfT2rGjP8PUfrnCu0VDBos3ea+KFuZ5cweJkk5N+N5/UxRuropE3iLMoOWe3A/x10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rFDwWK0a; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223fb0f619dso53360795ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742592499; x=1743197299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXTCW1lYI/NO5ybgxR6jIW3fidKxOfziUSy+malvYvc=;
        b=rFDwWK0avfNl2NXF/Sm0Tagbux0abRnzSNOxgj+WraKAiZfbGSb4JJVF5QP7dqmZat
         /g/aOJHETXEcyx+Vh4kNiV5hNc9m4Fxxh42XDwIKQPrFvrLCyHwXRQblSjNucTbQRnw6
         f08J7WmZ1APGQii0GT/oLDh/wAlOlP+Jz2E7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742592499; x=1743197299;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXTCW1lYI/NO5ybgxR6jIW3fidKxOfziUSy+malvYvc=;
        b=JelgodlCyVaMHVsWF+zrtjoJhkcvXZOg1iwNGSZwMljb/p5SVD8BnBRDghIduWEd7y
         z54h0kCtz1wE2w7qDcX6sxWps4ID0pvqnlO6noYJXe65nhEmbT4qEGUxJPtIRMs9dnDB
         n/qMtAp44saK5ztuBv9mA34DOL8qMtLdqp/YQgOssayCYHblIE7N27sXWVz+SggpWms1
         fgsLz+yBjvuWpsMbeXdEBqJPAYe37/gT53TKJjiQ1zCnLcE4c9CeN7y+rh5oBZRu5y7w
         yMzS5Kn2CjGBe/ahTbLvn9pK5bhvz375cctjqp7KCZMUnk3HgJsvpVN5ypcZ1NEjV1tq
         ziWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/etxkZip7c/aaAa05Kzk/z+U4ErGpD9lhwH+I6MkmDlv9OUszh+L6bIVte2rF3a/w7OzLfV4MvI9RPyqw@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYQIsVMoGTVmemM/hxyFq975FAUq7mN7KsDryj1cXXk6iJ1Wp
	h812H0pJTnbX4LoRw+6oHEyDL74J2Xg1DkHfXqNMNXQdfsitzVK97DHQ4GVYd2k=
X-Gm-Gg: ASbGncv0lIrbCeqNhxsyxHOwacevgfTK2hvsCTlNXpbgOyELqMk9EooBF1oRFUpsrf+
	1QF2PnCaQ5rII/FRSF6Qggml6gcHf2OawW7arCZe3EFdEM+QQBJoVbQUg6NniuKALtEL13tAKq8
	BZoyTlf+cVGHDkXjE4sI8kh96bigHBcnwVoXKjYYTAf0X9GJ1BK+ZUAf/4QnoT+7ljIHJfv1aOT
	76yqrj7s/G2iARSvMgIJIPYnJO2y6HitCa/MUMYeNyDt4EQgRqmPKW/CA1kaj/oAxUuJnUXJVqt
	/ItP8tNh7D3XXPyKH0ISRMaLAwqxYgycPnnBizozFNZCVPfL5KWnP/maVFTRST/jB4GHa3r3txT
	MWDzCxyIZgb8/o/FKc02sLiN6cXs=
X-Google-Smtp-Source: AGHT+IFQHiH1Q74zGSjuGJPSwRB6B0nITzjFmSBxRdVQxaFhw5xJuOEQUfZo/n55kU3kKM/0M7AFag==
X-Received: by 2002:a17:903:2cb:b0:221:78a1:27fb with SMTP id d9443c01a7336-22780c50872mr79615365ad.11.1742592499418;
        Fri, 21 Mar 2025 14:28:19 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2278120a552sm22391275ad.256.2025.03.21.14.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:28:18 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:28:15 -0700
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
Message-ID: <Z93Z73vG9NYUNQtE@LQ3V64L9R2>
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
References: <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
 <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
 <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
 <Z93Mc27xaz5sAo5m@LQ3V64L9R2>
 <67a82595-0e2a-4218-92d4-a704ccb57125@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a82595-0e2a-4218-92d4-a704ccb57125@kernel.dk>

On Fri, Mar 21, 2025 at 02:33:16PM -0600, Jens Axboe wrote:
> On 3/21/25 2:30 PM, Joe Damato wrote:
> > On Fri, Mar 21, 2025 at 09:36:34AM -0700, Joe Damato wrote:
> >> On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
> >>> On 3/20/25 11:56 PM, Christoph Hellwig wrote:
> >>>>> I don't know the entire historical context, but I presume sendmsg
> >>>>> did that because there was no other mechanism at the time.
> >>>>
> >>>> At least aio had been around for about 15 years at the point, but
> >>>> networking folks tend to be pretty insular and reinvent things.
> >>>
> >>> Yep...
> >>>
> >>>>> It seems like Jens suggested that plumbing this through for splice
> >>>>> was a possibility, but sounds like you disagree.
> >>>>
> >>>> Yes, very strongly.
> >>>
> >>> And that is very much not what I suggested, fwiw.
> >>
> >> Your earlier message said:
> >>
> >>   If the answer is "because splice", then it would seem saner to
> >>   plumb up those bits only. Would be much simpler too...
> >>
> >> wherein I interpreted "plumb those bits" to mean plumbing the error
> >> queue notifications on TX completions.
> >>
> >> My sincere apologies that I misunderstood your prior message and/or
> >> misconstrued what you said -- it was not clear to me what you meant.
> > 
> > I think what added to my confusion here was this bit, Jens:
> > 
> >   > > As far as the bit about plumbing only the splice bits, sorry if I'm
> >   > > being dense here, do you mean plumbing the error queue through to
> >   > > splice only and dropping sendfile2?
> >   > >
> >   > > That is an option. Then the apps currently using sendfile could use
> >   > > splice instead and get completion notifications on the error queue.
> >   > > That would probably work and be less work than rewriting to use
> >   > > iouring, but probably a bit more work than using a new syscall.
> >   > 
> >   > Yep
> > 
> > I thought I was explicitly asking if adding SPLICE_F_ZC and plumbing
> > through the error queue notifications was OK and your response here
> > ("Yep") suggested to me that it would be a suitable path to
> > consider.
> > 
> > I take it from your other responses, though, that I was mistaken.
> 
> I guess I missed your error queue thing here, I was definitely pretty
> clear in other ones that I consider that part a hack and something that
> only exists because networking never looked into doing a proper async
> API for anything.

OK, so then I have no idea what you meant in your earlier response
with "Yep" :)

Combing everything said amongst a set of emails it sounds like the
summary is something like:

    A safe, synchronous sendfile can be implemented in userland
    using iouring, so there is no need to do anything in the kernel
    at all. At most, some documentation or examples are needed
    somewhere so people who want a safe version of sendfile know
    what to do instead.

Is that right?

If so, then great, I guess there is nothing for me to do except
figure out what documentation or man pages to update.

