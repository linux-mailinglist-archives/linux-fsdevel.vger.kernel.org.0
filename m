Return-Path: <linux-fsdevel+bounces-32136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C0F9A1286
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 21:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6317E286415
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 19:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC25B2144AE;
	Wed, 16 Oct 2024 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cCtVL1MC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9F212EF9
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106908; cv=none; b=VA5xmEOcj5FHSEtu9GPyqGCYs5mbKNRCRGQPHZKpNiUlyE4plkCAWYDE4T92i7TZoms/+oqeg/mtKes4oZxpzh/ZgS/hqrp+NtJLFvpsPSY6fgF0IrbQmrRawIskCw3KCy22mBIMvq+L8qDe5X0glPoiPdIBTI38h0e8w8zrQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106908; c=relaxed/simple;
	bh=qum8g+Ez9i9rxAyYrgyJ7I8C0I7jc/1NhuIWjYoVA3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEDkeAE9Qr/T+V+YKTel902WhkGMsVSQ8VY+/HhoIz5i/5pBksfhKoGIp3XCWCPKuLNWG1+lALhhoxepbaGUp05QgQxI96aM4KulGZYE1b8pQrUvn2d6bAXu4XF3BAtJ158e4iY6nuRV8eKLJQxZ+MqKHz+uYWeY0dDc44e7QqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=cCtVL1MC; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e3dfc24a80so125883b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1729106905; x=1729711705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQMboBStj+YoCZfdptRzj0iw9r0BoDmLsEERRiT2CJc=;
        b=cCtVL1MCPBMRNBUlLlSJLZ38o+ZFKDLwuTj18L+VBdJ+CZE33A0rISdR44mxMW0wvB
         9ZhDWk6oCBh1IW8KthRncgB0c9OCtx6qhuo84riXC3deSz23uKxZi7r7XBsb6YgWtGUG
         Lhw0MYMKXJG/4ldLTALGmRUrd384pzM1I+hqiEwHcK00thAyvHqNiHlbd3tbb7yJWBQk
         Kjr1S4w4z81DNQKM9hqzNHeyOw+cR1ef+PCY3XQlz3796UubOAztcwMU1KFf7DvMIHMW
         Afs7ZjGuTA8GD+sDbt2/oKV28JMrUo85qLpsAkjg/r5yqZNOxGXUn8+qOoTE6qOXYca9
         VQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106905; x=1729711705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQMboBStj+YoCZfdptRzj0iw9r0BoDmLsEERRiT2CJc=;
        b=BhK731yef8zjHrvwkWz7gH7gubRanjfg7k5mOubiFFo9lmHQIn+uPRKdHy2lpAJ//i
         GhbQcHiDZfj8b97UFkThNHvxMtlfAegF5KWDfV7OpcvYgpvoMUPhFwbEYfA2IX5d4Lmq
         oGHwuYDw/jOdFazC6bHXkxYwwGZmbslKT71gg2l5SL7V8x6l5l+bsp9ls5sqqX30QyO1
         kdh4o2m8BPniAAt/iMMWhZwBt/4Lq5NpLKlBEp6/kSKZTkNJDgTI3UP9PlW10l0g7vwK
         kIpsfZi0PErYN2HrmWF5NqyzzfL9dm1n7RHzVxgGS7l6/q2OT5HYPmXHOsXB6ORE2e8o
         3kpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAjr5YBosWZZqHftZviSujr3GlgX8iWakS0qhVhN1TBxxQCNdXmfBb3mLAhpSRTEp4mr7ci6oGv9M5Aw5+@vger.kernel.org
X-Gm-Message-State: AOJu0YzVjzmeddqEl7NJjpUrhNgiEjoj55A8chVCuGapSZceVmqqtwFb
	dDoLQencmWsAHjrv2GzIMsIftWaKlwvNGlO+Khfa0sNimYdZSocSA8jl0HsldySPY0FI76GMgOb
	oVA4=
X-Google-Smtp-Source: AGHT+IEA96QyDlGaCqXqp1Ned/WFV8dItd/N02cyuUDyK24hkHSbf8iWpGdn/upWVfjxgtazY4odyA==
X-Received: by 2002:a05:6808:1813:b0:3e3:e0d1:b157 with SMTP id 5614622812f47-3e5c912a6d0mr15343505b6e.47.1729106905157;
        Wed, 16 Oct 2024 12:28:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc229714d0sm20847766d6.131.2024.10.16.12.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:28:24 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:28:23 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] Fsnotify changes for 6.12-rc1
Message-ID: <20241016192823.GA2377558@perftesting>
References: <20240923110348.tbwihs42dxxltabc@quack3>
 <CAHk-=wiE1QQ-_kTKSf4Ur6JEjMtieu7twcLqu_CH4r1daTBiCw@mail.gmail.com>
 <20240923191322.3jbkvwqzxvopt3kb@quack3>
 <CAHk-=whm4QfqzSJvBQFrCi4V5SP_iD=DN0VkxfpXaA02PKCb6Q@mail.gmail.com>
 <20240924092757.lev6mwrmhpcoyjtu@quack3>
 <CAHk-=wgzLHTi7s50-BE7oq_egpDnUqhrba+EKux0NyLvgphsEw@mail.gmail.com>
 <e46d20c8-c201-41fd-93ea-6d5bc1e38c6d@linux.alibaba.com>
 <CAHk-=wijqCH+9HUkOgwT_f1o4Tp05ACQUFG9YrxLpOVdRoCwpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wijqCH+9HUkOgwT_f1o4Tp05ACQUFG9YrxLpOVdRoCwpw@mail.gmail.com>

On Tue, Sep 24, 2024 at 06:15:51PM -0700, Linus Torvalds wrote:
> On Tue, 24 Sept 2024 at 17:17, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >
> > Just side note: I think `generic_file_vm_ops` already prepares this
> > feature, so generic_file_mmap users also have fault around behaviors.
> 
> Hmm. Maybe. But it doesn't really change the fundamental issue - the
> code in question seems to be just *random*.
> 
> And I mean that in a very real and very immediate sense: the
> fault-around code and filemap_map_pages() only maps in pages that are
> uptodate, so it literally DEPENDS ON TIMING whether some previous IO
> has completed or not, and thus on whether the page fault is handled by
> the fault-around in filemap_map_pages() or by the filemap_fault()
> code.
> 
> In other words - I think this is all completely broken.
> 
> Put another way: explain to me why random IO timing details should
> matter for the whether we do __filemap_fsnotify_fault() on a page
> fault or not?

They don't, or at least I don't understand what you're getting at here.

I have a file with these precontent watches on, no IO is going to occur on these
pages without calling the fanotify hook first.  We have readahead disabled in
this case for this very reason, we need to make sure that every single page
access is caught by fanotify before we allow the IO to proceed, otherwise we do
get random garbage (well really we just get empty pages because these files are
just truncated to the final size).

Now there is the case where userspace could have just done a normal pwrite() to
fill in the file, so any subsequent faults would find uptodate pages and thus
we'd not get an event.  My original code disabled this, specifically because I
wanted to have the consistency of "any access == event".  But we decided in one
of our many discussions around this code that it would be a bit too heavy
handed, and if there were uptodate pages it would be because the HSM application
filled them in.

As Jan pointed out, I'm fine going back to that model, as it does have more
consistent behavior.  But I don't want to go rework this code for a 6th time
just to have you reject it and it take me a couple of weeks to notice that it
didn't go in.

I realize to you that "we're already using this" doesn't matter, but it matters
to me.  As a rule we don't like carrying patches that aren't upstream, the only
reason we do it is for these cases where we need to see how it works in
production to see if it's actually worth chasing and implementing.  In this case
the answer overwhelmingly is yes, this feature is extremely useful and pretty
greatly improves the launch times of our containers and our applications.  So
I'd really like some concrete guidance on how exactly you want this to look
before I go back to rework it again.  Thanks,

Josef

