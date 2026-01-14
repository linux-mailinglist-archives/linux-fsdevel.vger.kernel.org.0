Return-Path: <linux-fsdevel+bounces-73785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A472AD205C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3F0630779BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDBF3A640C;
	Wed, 14 Jan 2026 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/tW/0ko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8C3A6402
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409475; cv=none; b=ZLRY22Sn3W6WVTa3j4humBM9nwjl6veb4WUZRQao4R20bablnwWjOXhsQEDeQJk8FP/fbbRFNgW03RP5Xik2P7Q4vIB1mZS0WXPJs0XCNRfcKePT94sl9RGYHHD8qTculTqMJNk0MwwIMvQsnVUg0hU1rBDXRaRlEt0b7C8uJCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409475; c=relaxed/simple;
	bh=AfUFgO0b7GPKI9ov+xLUaJEaH3EYfZlGNCRjx7S3gbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgygacmdxRKP3iUX9zboYFsojp6BzW3kvMrTE4xn9eeLmDmar9Fi2URIzvBrIk9LwWQvzUXzDFgZHnD627tO66f0LRi7Y+8O5sGdvmrCaMOoAQhDU+cDmC3ux4O8OHITRZ6oczfTrq8JSUcFXiHtmCME8WfncpOG1mNv6LucQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/tW/0ko; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee4539adfso327075e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 08:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768409472; x=1769014272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ3QbmhqfJKikc8lqUdpaAQrOYzjv70oEJ76oRdKAR0=;
        b=M/tW/0kocLeMlzqGk4TuQDsjtbM360FveKnPnHQzhzG5DafyKsh1BzFwabt9D1fkot
         tmpIq/ZwO5y4fpyIzv2aoT5ho+3YyCTuHzBUDbCDzt0/UZePPIbN+ZTIvM+xUik6saIM
         xmfXRcI9s6et5k7OAvs949u8dugPa81Zcb8f2Vahi0oRdOrxkoMdydk7gcIlLKPSLfhX
         hdZep6M5nXDl10HFW58+6nDham0X9ovkDQ7S+FLWfETzI+vsthKYMVOchM5bfV/ewYvy
         ECERRzPsX9d7etHEpp8baX1Al40o6DQPqjVDPyUWa6k+upR3XYpOsKFOWs/tl0Y1zKva
         f1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409472; x=1769014272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQ3QbmhqfJKikc8lqUdpaAQrOYzjv70oEJ76oRdKAR0=;
        b=Y7dslmV/yzGqKmRoGWw8XNriv9+YH2GZ0df+3FAmcKJckZhhYqixmO29pmtfKtzOKz
         jrT1xLihtUMiVvAEsm9i+gc1s95zjRdiwX76npKtTeNHAmPBRMQAcyfatPN9VTTqO5u8
         O8BTiQka5hePr7g0B/g/8PkaNbM0hnFL1NmcLAmYA/q8laiZEEBsGmq+Hx+ef/xxHQhp
         Sf7rIhJED3RcD7TzrFJwifS3So4d46S7fqV8B+53AXXcgdWAAHhTowO+6tlvAgXb2uKc
         kA5FNTBKSlCHGtzmHkBkIuN86ShLSDdmObkKQ1MdIWgU+fOH8acxCPLhTb/cnCwtomvB
         rHOQ==
X-Gm-Message-State: AOJu0Yw0+XBFCkZ0BXlE3L4jXpRvIbrQ4Zqgf8cGLnqRkWmmCjX49BUE
	ubSbCRqggL6ub2VGKJ5fFJDCNQTV/8pBpjPVnKuqnv8gVWEIfHAXNkVx
X-Gm-Gg: AY/fxX5h9h297dkSsO1W9k0BOeRLVKuxQlDfq2CGO97HZIE6/msKEvJpy0OHSU42CJ1
	gER6f5Ng3Y3mCVjS2I0Ml6rGnYGsHCEXY5iPdnyxs/2Z09WRZwLLWujUZjn6gc3uPiPptQdG2QL
	95W8etUE0qM6QORWNaF3T8oHeqOGsjlSI6WqGPSk1Q2coIIsSOn6ndHZCkEy0QAQ+y+bDeuYPwa
	HVQCzrq3xkIJzdBZ61WumCfIiq1MVU6DimZQObsEV6KTvhZsx1NoLNma1KQzEU53935Y3ZZbm1X
	GlKP6dCMM9aL3SEtdAmTK0H3zzSf0cCVxC75qu+j8Iq8dtykEUym3HMM2SwBufxbQzKx4HrDc3G
	+KdOTMT8nIkZkGzVbmIa2QG4tU6NEgc1/zEl8fvBXSlPhDA1MC5PDSStr3LAvMkBDg1/BUiJN0U
	SvRe632sErvqYuTrwfO5Op8mvBEiTnn1SjUIhy4FzT/Owor3IcPSTE
X-Received: by 2002:a05:600c:a4c:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-47ee338a820mr41712075e9.29.1768409471570;
        Wed, 14 Jan 2026 08:51:11 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653596sm314104f8f.14.2026.01.14.08.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:51:11 -0800 (PST)
Date: Wed, 14 Jan 2026 16:51:09 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, Paul Moore
 <paul@paul-moore.com>, Jens Axboe <axboe@kernel.dk>, audit@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 68/68] sysfs(2): fs_index() argument is _not_ a
 pathname
Message-ID: <20260114165109.60e46e14@pumpkin>
In-Reply-To: <20260114143555.GV3634291@ZenIV>
References: <20260114043310.3885463-1-viro@zeniv.linux.org.uk>
	<20260114043310.3885463-69-viro@zeniv.linux.org.uk>
	<20260114104155.708180fc@pumpkin>
	<20260114143555.GV3634291@ZenIV>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 14:35:55 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Wed, Jan 14, 2026 at 10:41:55AM +0000, David Laight wrote:
> > On Wed, 14 Jan 2026 04:33:10 +0000
> > Al Viro <viro@zeniv.linux.org.uk> wrote:
> >   
> > > ... it's a filesystem type name.
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  fs/filesystems.c | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/fs/filesystems.c b/fs/filesystems.c
> > > index 95e5256821a5..0c7d2b7ac26c 100644
> > > --- a/fs/filesystems.c
> > > +++ b/fs/filesystems.c
> > > @@ -132,24 +132,21 @@ EXPORT_SYMBOL(unregister_filesystem);
> > >  static int fs_index(const char __user * __name)
> > >  {
> > >  	struct file_system_type * tmp;
> > > -	struct filename *name;
> > > +	char *name __free(kfree) = strndup_user(__name, PATH_MAX);
> > >  	int err, index;
> > >  
> > > -	name = getname(__name);
> > > -	err = PTR_ERR(name);
> > >  	if (IS_ERR(name))
> > > -		return err;
> > > +		return PTR_ERR(name);  
> > 
> > Doesn't that end up calling kfree(name) and the check in kfree() doesn't
> > seem to exclude error values.  
> 
> include/linux/slab.h:523:DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
> 
> kfree() the function won't be even called in that case...

I wasn't expecting the code to be optimised for the pointer being invalid.

I guess one of the defines does a 'dance' so that the pointer can be returned
without kfree() being called - and that needs a check in the function itself.
(I'm sure I remember something about the compiler optimising at all away.)

Perhaps the test could be:
	if (!statically_true(IS_ERR_OR_NULL(_T)) kfree(_T)
adjusting the check in kfree() to ignore -4096..16 not just 0..16.
That should reduce code size without slowing down the 'normal' paths
and possibly speeding up the error paths.

	David


