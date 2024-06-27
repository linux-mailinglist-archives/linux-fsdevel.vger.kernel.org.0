Return-Path: <linux-fsdevel+bounces-22670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9D491AFB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4D61F239BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D3719D8BD;
	Thu, 27 Jun 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN7bT+6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BD19D8AA;
	Thu, 27 Jun 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516673; cv=none; b=IAN/5xDYGEoUce0I2LtPq9upPWh0anAWzomde8CKAcI9MvFt7RgJmOFpYL9+2ki+iGnY/OB79HTQsclqy/UvXcVsIBdUzXpgj80Qiq1wHLGn1nzB//v9KkbJxyeyFgLGmSFbHPKwF8l327pFO9Mmf4xmTYLR3y8SMkVqFEX54zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516673; c=relaxed/simple;
	bh=Cz5VpmWszFF38N4E1COvFngYrmJ9V2WuQ83ifQGj52w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbBLMGFaAF8/seSVtgmXaKoi1vgerjnZQnEtTNidEdiZQXnNkR0Ysc6/ReAXylkkm5NjA6TmpH2deb0mKKWmmfn2skJeQprgmkPr0sbiswRvUUQ50+Apwl+IyozctDKs5OmMxkjDtcxoBWzUwhbnRBLe1xDah+s0kbPLXHzQbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN7bT+6E; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4249196a361so38549175e9.0;
        Thu, 27 Jun 2024 12:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719516670; x=1720121470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny6HkmE+qY2SG56r9G2DPsCtupADeB7549mmgxbkcn8=;
        b=MN7bT+6E2IzqNI7JolQA2+LEbvvM3uKWHDxuhX47NFtWLeY3kgE37UvYuRGS9L/FLA
         V6U06MZPuazpBWdzhT5sWAVEnp5ynPMrm4aj2TKG+XXi8eXbHFQuf4i7baPl//8i2Hv+
         qOas39unZewCL9RoVNsZItEg+rnY+mc4ngqLGuMNM4pYIKKy8a8TNj0KMigWSpSmeus1
         gP34y6qfWSzRbI6RCqkHkyDX46ChDf3Mcqrb6NOJfbLqL9+l5cP6bRir/OvdSjmWSYKC
         XD/VyYGJ4KqnYhhu03tbY6fTMi1QkQw5SnnSZVwDCiHfJD8iQohrI3C1u9KvWzvATq9/
         b6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719516670; x=1720121470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny6HkmE+qY2SG56r9G2DPsCtupADeB7549mmgxbkcn8=;
        b=YHZQCnwm2wjE8RluYToGRMWUfNKzrWXxlWLO/vEBt/Fv5AvDyeGlQJSTTQpHw5okRS
         c3379WIOT+AHT7IpMPHxhR2VPYMRmno9JeZPhdeh31dqbymzA+hClCC9WlP8BpsMAMGE
         k2tnk9iyY2PHrXjVWyR34zTAu78DgGvmkmF4W24WnohhXOXQWMfgQDw43AQ49cafMgOZ
         I6dwT1SviwQ2gdsRWlpEsrYz1jdb21VaqdvltSAIRB6ytJts7+gNLbAy3f4EPuIYMBBN
         6OGulJ4cnjBzZ6/Qygy8gqvhVhZNohL7kJqSFCx7abXqewQ77X1sjDOjCIfw7Mvth938
         1Usw==
X-Forwarded-Encrypted: i=1; AJvYcCVel6KxNmp4Ve2sj4BQ5LOO1NF7Gn1ADxDb6cCBHPJhIlNGWzKk4seEzvMZkdepmI498Po8f/01knx4TpBovdj4w+dGxZsDYCMYM8/+Cst6aAUxPXscfKI5HGk37GLycjsgrtEys3KczldGbg==
X-Gm-Message-State: AOJu0YxcPMutJ02CF1KTj7APGzY6BU9ykp2IxQ00avx9boO/SGMCiuWH
	xuypeyAMlq7Xe0JjNyWUwvz0eXllobCyCRujDdcLaLozpHh4QiUv
X-Google-Smtp-Source: AGHT+IFdGRQfUdkuH5BgVEfuVw+NW9O3Tjn8vpqf3zKF2lgWTc6D8XAyOko55+jbazGHrKeARtK6gQ==
X-Received: by 2002:a7b:c3d8:0:b0:424:a4ab:444f with SMTP id 5b1f17b1804b1-424a4ab464cmr56536255e9.33.1719516669623;
        Thu, 27 Jun 2024 12:31:09 -0700 (PDT)
Received: from localhost ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5ba67sm5239905e9.19.2024.06.27.12.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 12:31:08 -0700 (PDT)
Date: Thu, 27 Jun 2024 20:31:07 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 7/7] tools: add skeleton code for userland testing of
 VMA logic
Message-ID: <f005a7b0-ca31-4d39-b2d5-00f5546d610a@lucifer.local>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <22777632a0ed9d2dadbc8d7f0689d65281af0f50.1719481836.git.lstoakes@gmail.com>
 <202406270957.C0E5E8057@keescook>
 <5zuowniex4sxy6l7erbsg5fiirf4d4f5fbpz2upay2igiwa2xk@vuezoh2wbqf4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5zuowniex4sxy6l7erbsg5fiirf4d4f5fbpz2upay2igiwa2xk@vuezoh2wbqf4>

On Thu, Jun 27, 2024 at 02:25:36PM -0400, Liam R. Howlett wrote:
> * Kees Cook <kees@kernel.org> [240627 12:58]:
> > On Thu, Jun 27, 2024 at 11:39:32AM +0100, Lorenzo Stoakes wrote:
> > > Establish a new userland VMA unit testing implementation under
> > > tools/testing which utilises existing logic providing maple tree support in
> > > userland utilising the now-shared code previously exclusive to radix tree
> > > testing.
> > >
> > > This provides fundamental VMA operations whose API is defined in mm/vma.h,
> > > while stubbing out superfluous functionality.
> > >
> > > This exists as a proof-of-concept, with the test implementation functional
> > > and sufficient to allow userland compilation of vma.c, but containing only
> > > cursory tests to demonstrate basic functionality.
> >
> > Interesting! Why do you want to have this in userspace instead of just
> > wiring up what you have here to KUnit so testing can be performed by
> > existing CI systems that are running all the KUnit tests?
>
> The primary reason we did the maple tree testing in userspace was for
> speed of testing.  We don't need to build the kernel, but a subset of
> APIs.  Debugging problems is also much quicker since we can instrument
> and rebuild, iterate down faster.  Tracing every call to the maple tree
> on boot alone is massive.
>
> It is also difficult to verify the vma correctness without exposing APIs
> we don't want exported (or, I guess, parse proc files..).  On my side, I
> have a module for testing the overall interface while I have more tests
> on the userspace side that poke and prod on internal states, and
> userspace rcu testing is possible.  I expect the same issues on the vma
> side.
>
> Adding tests can also be made very efficient with tracepoints dumping
> something to add to an array, for example.
>
> Finally, you have ultimate control on what other functions return (or
> do) - so you can fail allocations to test error paths, for example.  Or
> set the external function to fail after N allocations.  This comes in
> handy when a syzbot reports a failed allocation at line X caused a
> crash.
>
> This has worked out phenomenally on the maple tree side.  I've been able
> to record boot failures and import them, syzbot tests, and fuzzer tests.
> The result is a huge list of tests that allowed me to rewrite my node
> replacement algorithm and have it just work, once it passed the
> collected tests.
>
> I haven't used kunit as much as I have userspace testing, so I cannot
> say if all of these points are not possible, but I didn't see a way to
> test races like I do with rcu in userspace.
>
> Thanks,
> Liam

Liam's response is excellent, and obviously I agree
wholeheartedly. Additionally, I'm not really experienced with kunit, but
surely it's implemented as a kernel module somehow? If so, these interfaces
are largely not exported so it wouldn't be functional as a unit test.

And also as Liam says, it'd be very difficult to test this stuff _in_ the
kernel without unwanted side-effects triggering and it'd be very difficult
to isolate or mock components we don't want to play a role (for instance -
rlimits that we might not be able to control).

But overall (again as Liam says) the performance benefit, flexibility and
ability to recreate things at a whim are huge.

And the fact maple tree (which forms a HUGE part of these VMA operations)
and related radix tree and other shims/stubs already exist means that it
wasn't anywhere near as huge a task to implement this as it would be
otherwise.

