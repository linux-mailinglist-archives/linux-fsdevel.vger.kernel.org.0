Return-Path: <linux-fsdevel+bounces-44740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB82A6C43C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 21:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADA8464B98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BB7231A2B;
	Fri, 21 Mar 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="l5o0kxHw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754F2309A1
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589050; cv=none; b=SceFOcSzDGiwibv6sSWg8LXoa9nOOknsFyY/HPfjOfARdhcD0maHKj+lQ0FXQKJ+YwmpD75hM0Dnxdd9QOeJeibkK4DBkPE8l5EXp52jCRDNMJ3K9H20M/Pkl6cktXZ4kAM5rXCj2klVdw3DHUY2Rt19+W4L/XFAAoZRHEQo7fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589050; c=relaxed/simple;
	bh=kufjJ7ROxUIeeWBTf87pHaUYN0P9yN6f9l3gagdcYI0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRXGjBZ+T8eja/6tA9EmVZOJFI6XYt3gW6V1B6afk2IxmJjRCpKTjvihsBHAB5IBk76uBScBfecincPzbiC4ytU8Nu8LZfffz78VhQgTYvX3PB0YZZUcrhOBKuYh7iymYQoWRd2kAVvubUe8i9jrSAFDQRVeegN5lccYU+26DjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=l5o0kxHw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2239c066347so58101785ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742589047; x=1743193847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R/gNIM+yOS6xUSJi/6mY04tkW5DVweXdgmtDBLblehc=;
        b=l5o0kxHwz56/APvSz0yxxES3DtKjkGRzP3aHJgNtqfsPTeXBNyJqn9VNgMK3W6VEgd
         C3QYN/SUg1QAF8O7bGci/PkW/6tvRBw+3iE/xpWr29FsLghzQGbm9S5Ud3iooTfeENXt
         V1W51rg8ZwyivdKhNuOGhhAQIyBNtmn8MsF/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589047; x=1743193847;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/gNIM+yOS6xUSJi/6mY04tkW5DVweXdgmtDBLblehc=;
        b=grBvgkisT85x1mP+VrH5tNBQB7s1WFUgAFPiLYLezAVKCbZEUcCr2ga+AsoXxU4zir
         ljAU0QMV8b/A6vdE58InQQIuH2hFCS/Qh/51mkkmpn0a810n3xWf/vcckPaRVf6RIo4x
         wdyaz3QD+JFQDJK/FN1p24kXHMLx4lc6dTalQpLicQiNFRJkSC5CU+Ufjjn37dvhZ/g0
         Ad3zh+XK6CIAJFmbSuIRD2kStsZNFqBqt2KKUMkIV1q3+denqWXRpAixm4mMyXW8PMIf
         Y9mgFQfL+JvRk2lalC7pfFTVbPOvlF+IyWbpk5EC77H5eUgKR4CgCZQIT6AirJIP2ILV
         uw8w==
X-Forwarded-Encrypted: i=1; AJvYcCVE01s5dWiJlgoRrLaYcTQOztsncBKyzF84if6+XBoXMc49anNygdXFhrlqr5MRQQ8ZMBzE5Wa3OjruVk57@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5WZ75h/q0q8/VPX2tY9KhXROi0d7Rn1CfHVmn/DU/tbe++oa
	l+cCnawYe83aZjMlaw9kK1OD4lI+5SsYsPVIKUqs4+/Jd70IBAYJNUN2r1xv/IE=
X-Gm-Gg: ASbGncva4ObnDybcrXwtITPqxU4pa0m9WGxwPrE8e8iUciRP5Mz7uCqDdoRbXS/TL2V
	YUzLRITBzMTZhI5epWJaZvWNUU+bc0YbgPCQVxahPDq/2vlCj1BQhn1tFM4OEF9gXeKML+LhY9T
	+8oGYXFDYek7t5f5qCjFrUjgkfdsNXDDeC5yhf9fS1fh8MEzd3/ZhkMVnjak2F3LQqzR3Bx4ZUl
	RSu5JkVgrg8xXqEsgIWdXmQeGzSKOScfF5SfxhXSlUIHvg6gnM+ehFUB9GiPR6OyLtJHfPBTQ8/
	BtT1MbvmJRaLe5y9/h4si7/AmOZF9cNO5NXNCCHGi1KCcnwdtXDIzMqmuW0RlDyc1Zw30pCXYmW
	nfsd1Dvh90hfJOpRp
X-Google-Smtp-Source: AGHT+IE/0vRvWUIrCU9TpLfmE4aooUPQeYEWA/MrsW2UXdaB42a9j/XwGhSTptf5SM5XxL22FRt0Ug==
X-Received: by 2002:a17:903:41ce:b0:224:10b9:357a with SMTP id d9443c01a7336-22780e3fbabmr64649685ad.32.1742589047213;
        Fri, 21 Mar 2025 13:30:47 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2aefsm21875045ad.109.2025.03.21.13.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:30:46 -0700 (PDT)
Date: Fri, 21 Mar 2025 13:30:43 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z93Mc27xaz5sAo5m@LQ3V64L9R2>
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
References: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
 <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
 <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z92VkgwS1SAaad2Q@LQ3V64L9R2>

On Fri, Mar 21, 2025 at 09:36:34AM -0700, Joe Damato wrote:
> On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
> > On 3/20/25 11:56 PM, Christoph Hellwig wrote:
> > >> I don't know the entire historical context, but I presume sendmsg
> > >> did that because there was no other mechanism at the time.
> > > 
> > > At least aio had been around for about 15 years at the point, but
> > > networking folks tend to be pretty insular and reinvent things.
> > 
> > Yep...
> > 
> > >> It seems like Jens suggested that plumbing this through for splice
> > >> was a possibility, but sounds like you disagree.
> > > 
> > > Yes, very strongly.
> > 
> > And that is very much not what I suggested, fwiw.
> 
> Your earlier message said:
> 
>   If the answer is "because splice", then it would seem saner to
>   plumb up those bits only. Would be much simpler too...
> 
> wherein I interpreted "plumb those bits" to mean plumbing the error
> queue notifications on TX completions.
> 
> My sincere apologies that I misunderstood your prior message and/or
> misconstrued what you said -- it was not clear to me what you meant.

I think what added to my confusion here was this bit, Jens:

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

I thought I was explicitly asking if adding SPLICE_F_ZC and plumbing
through the error queue notifications was OK and your response here
("Yep") suggested to me that it would be a suitable path to
consider.

I take it from your other responses, though, that I was mistaken.

