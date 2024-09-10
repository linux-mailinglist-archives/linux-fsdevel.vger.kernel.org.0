Return-Path: <linux-fsdevel+bounces-29021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051899738FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4AB1F25F91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 13:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115D219413D;
	Tue, 10 Sep 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjmvqSLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0217192D67
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975886; cv=none; b=njbcj6HnqdjCSAnwcbWv9tZ1kTacSffVUUj4f2m8q6eOKABIZcP+4h3CgK92EI/IM1MJ2Nt62G1dQPwlhIIZtYpKy37qHJ9dgA/87xUh9fnvZ8CEGrpW4rIuUfih8qD7F8TA+0vy94+IJ1pXS3PinS8FiElwAcV/1/prPnKK9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975886; c=relaxed/simple;
	bh=+2rafr0pu/xprOUQfabcy9CzJdHSkB0mCvNG7B8wBCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUCIiofU2o4lw3czB++UQhLZ1Ar2ERycNBuGMSerN9iNNbnNXvWt7txuA9wGwGataCoAidbQJfPd9JSIEzDzG5aJN1IpsDfZfixGbcSi3P3Tu/oX1ILKRyy2GPw8uHbLJQDxG/jmImd9qEhqS0s1OTvTrBcC1229gIPQ7ESX7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjmvqSLO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cbaf9bfdbso14213695e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725975883; x=1726580683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAioznHAX4Yw9T0HjHEBFdIPTOMMNXCytxH0rP3bVDk=;
        b=LjmvqSLOsTftTrnp4Jlg+k/PqJBtk3fSq5ouLI0O8CkkV4kx+dQqeK38uk0SQParHQ
         xCQbLAgBmWJNGstoUVUbuzYNcfPzF8GwcUef6OR3XvUBfQtCgYy0K8vgA3+XXEbwCENw
         zAC9Lmc0LGRh/3bKbZe2RMGw+JMIYSzzUZICOR4JZHMM5iXR9QG1WQFbN3xbYj0JFbad
         bpWj8j8jMuTA/dhLoql6H4jnzskG928tGH5USDpZ47YWydzqxCc0MWhkOXbe+1YnkF8P
         VQP63JPZqeu9Bipgm0UsLtWfTjJ7rKy3+nrtTklIYETHrDmEVVw7d3d4xx/eIozgfd7v
         UnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725975883; x=1726580683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAioznHAX4Yw9T0HjHEBFdIPTOMMNXCytxH0rP3bVDk=;
        b=BaJh/Sp7hQSl0v+cS1A+RyJeRu1N803ltbGa97suwg4yvhOomPIAHrZuC27HiTx1w1
         /KbZmT7XwSGW0a6RP3XL7THeCFawxELLa8Jz230DEB7J8CRR4U6t5EpMG7igEaxRP5kK
         xCmDwJPwCNaL5IdjZFKzMZCczcjgu+ob9Ndl/ylAc29LQ83cIjwAkTBIiwhQo0KqwFX0
         Y+U+l+JhoMABns5eUfOqcD00RzgticVj3JYG8wVyDYE08M4iB1ckmcR1mG5WClkw1WRc
         sP6+TUWiuJWv8JLwEeL4MEg9W0cOB0YsIuQLf0ty3CKUvciYZ8J6l4mNIsrCsp1SVGoA
         1+aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUlovKEo0OHu+2EuW3emd5Q97rWRtmvvPbBgKfNoK7AX9IM3wuqcGkxLv8njiKdczSOB/QYRaTv+czS0vp@vger.kernel.org
X-Gm-Message-State: AOJu0YxltLNZaleTrOMcNHsPXQxZpYBPaJOjLBKgbE4slSMNcfs8xzGl
	EwRGSX08pCqynx/uLOwDwu9mF6i3etUk7bP3mH1hnxfvDpd6d/V5
X-Google-Smtp-Source: AGHT+IESbSckvUo37rOlLxxa79GelGeHABdioI+PY1ufmTi8NObe/uROac21XYGZJ8Q4RaqO0JgFzA==
X-Received: by 2002:a05:600c:4713:b0:426:689b:65b7 with SMTP id 5b1f17b1804b1-42c9f9d359dmr114994185e9.25.1725975882809;
        Tue, 10 Sep 2024 06:44:42 -0700 (PDT)
Received: from f (cst-prg-85-144.cust.vodafone.cz. [46.135.85.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb444b0sm113346025e9.21.2024.09.10.06.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 06:44:41 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:44:31 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] uidgid: make sure we fit into one cacheline
Message-ID: <mcd76j43z7frppbthfjlolkifwqc22kbjyocdololbvyzj7v75@b23mafxtwfjp>
References: <20240910-work-uid_gid_map-v1-1-e6bc761363ed@kernel.org>
 <aqoub7lr2zg6mlxmhe4xgulk2vteu6p2rsptqajxol2qawgtef@mz2xks2gkjul>
 <20240910130043.GA1545671@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240910130043.GA1545671@mit.edu>

On Tue, Sep 10, 2024 at 09:00:43AM -0400, Theodore Ts'o wrote:
> On Tue, Sep 10, 2024 at 12:48:16PM +0200, Mateusz Guzik wrote:
> > May I suggest adding a compile-time assert on the size? While it may be
> > growing it will be unavoidable at some point, it at least wont happen
> > unintentionally.
> 
> That should be fine for this structure since everything is defined in
> terms of types that should be fixed across architectures, and they
> aren't using any types that might change depending on the kernel
> config, but as a general matter, we should be a bit careful when
> rearranging structrues to avoid holes and to keep things on the same
> cache line.
> 
> I recently had a patch submission which was rearranging structure
> order for an ext4 data structure, and what worked for the patch
> submitter didn't work for me, because of differences between kernel
> configs and/or architecture types.
> 
> So it's been on my todo list to do a sanity check of various ext4
> structuers, but to do so checking a number of different architectures
> and common production kernel configs (I don't really care if enabling
> lockdep results in more holes, because performance is going to be
> impacted way more for reasons other than cache lines :-).
> 

While I agree all bets are off for an arbitrarily b0rked kernel, a lot
can be done and for more than structs of constant sizes like the one at
hand.

General note is that things are definitely oversized, with
semi-arbitrary field placement and most notably avoidably go past a
magic threshold like a multiply of 64. Cache misses aside this also
results in memory waste in the allocator, which is my primary concern
here.

If people did sweeps over structs in code they maintain (and code which
is not maintained at all) that would be great (tm), realistically wont
happen for vast majority of the kernel.

Even so, for heavily used stuff interested maintainers should be able to
assert that some baseline does not exceed a certain size -- there is a
huge overlap in *important* distro configs. Perhaps configs used by the
oe-lkp folk would be fine?

Bonus points if relative field placement is also checked for
false-sharing reduction.

So for example *some* stuff could be always statically asserted, like
the size of the struct above and many others.

Other stuff could be conditional on lockdep or whatever other debug
bloater not being enabled.

Stuff of importance which is too messy to be treated this way can have
the check be made on demand -- interested maintainers would compile with
"make CHECK_STRUCT_SIZES=1" based on sensible(tm) config and get the
info, while random users messing with their configs remain unaffected.

If there is a random-ass distro with a config which suffers a size
problem for a given struct they can find out thanks to optional size
tests and try to do something about. As is nobody knows squat unless
they explicitly look at stuff one by one.

I did an exercise of the sort elsewhere and managed to shrink quite a
few 136 byters back to 128 etc.

I have some wip here and there, but I'm not signing up for any such
work. I would argue everyone maintaining a subsystem should be able to
sort this out over time, if they have interest.

> Hmm, maybe fodder for a GSOC or intern project would be creating some
> kind of automation to check for optimal structure layouts across
> multiple configs/architectures?
> 

I'm going to stop ranting here.

I do think what I outlined above is easily doable over time and is a
nice to have before anyone even attempts this one.

