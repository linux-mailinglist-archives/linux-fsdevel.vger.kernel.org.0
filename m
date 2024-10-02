Return-Path: <linux-fsdevel+bounces-30616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B41A98C9EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 02:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B196AB20CD3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 00:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0CF7E1;
	Wed,  2 Oct 2024 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="BhYjTNnG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086D3391
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827815; cv=none; b=q/Cs7Lt4GfOIXordW6RuOsH/Nu/bRR7VOutXRSI/BR+HSLidaOIfBe9CbtA2dBIxP6/llNwkDnYlxR4uAo9D8y62y11oXbXh5p53YkolbPAh7J+VmfpZGfDrP+j+z68AbVnipQpz44Ow8ENxTzNpjam7LqIuT6pgqNQpGK/Di/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827815; c=relaxed/simple;
	bh=EK2PJuL0rJsx0hFg/W8mjhwlsrSGQ4zPXE/RNq92Uso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOeWWoaxWdMU3vJxTPWAwiQjrP+K5fQIlmnFeqwOsmy7SGiJc6lgAecu8Sk3frHnRf5DW1LLkfKE4t8VavBgoGaxys/heoHqJwIQ/Fu4jmNuAb3asBSxsGnX+P6tFneiXnc+8P4rMJYiTJZl5XGUiqIEmyYz9nPJ3hSQMsXKCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=BhYjTNnG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e2855479so4373561b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 17:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727827813; x=1728432613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o59/6GgCFkYEVN5Vt+ZhJ3o9kIV1/zeluo3Umxq+vD8=;
        b=BhYjTNnGetVK/YEMweIBBcTdEp6urDYoMFus8NN23miiQ+xW36graW3P+3nRAXqUdF
         lwdkdYKW21LZVuc4zU6RmgUZQC0OSxISgnOi2VLU2+qPOHZw+1dq11CvC8dGVMhkiBrb
         IEj4VcMYRZkRKF4xANAv7as2JUaYihlHwWEfA0ya3JDsIXkAvw6KXGYCEpvzFS3uBGWD
         qoZe+AoHd+MdhgLDCqaz4wnhgSTGibOSfkiO5HXGwkHGeCPJTYcfYo2Q/av3euCRW2Q1
         gyl47kVgKuJ84RQ35ys0Aaa98UGlbMy6P3HGaerKs9XXPyPeRVRTxgS/Ybeif5h5UJe3
         ySVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727827813; x=1728432613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o59/6GgCFkYEVN5Vt+ZhJ3o9kIV1/zeluo3Umxq+vD8=;
        b=WEjxZFCQjhftHtwWCS/Voi13nDkazbrEwnmMUP2d7xEjiCuAG9yv2IA9CiSJ67uC08
         kMMK5mAKZUMhEbIi+f8gH/uof7Z1n5htL1z3hYlSRRvEHaBpxswx5cM3+CfxLuQ36X4d
         FQ9SaQeNJ/QY5MfYApgmKV2GDOk4EjWCxxtfSma9iOvzpAso/RE3iaCA8edaNZXgL5S8
         hIzG8NQDkSvAdf99f1f4iaWVBkssCzmaGN/AxlKe53rRu77KYyPJn/nI+uyyXwUOd1c5
         HPWIFZbuS2tUl4kEK+nB5q97I68jMUWN4TspuklmZPPukpcZ36jfCIu0ekAi/Mn6ZmQE
         YjFQ==
X-Gm-Message-State: AOJu0YzraZVFOZKKzQOgqA0CWq6+8ApUrCICeax8hRQZ6pRePszbd5Jy
	mdKJHV5azWoAdSZbNWYAgza4o4EqEv2H5mr5WJ/5jEwdlvgdIeLlLyh0Foe3TDtjgSt28caiBsb
	E
X-Google-Smtp-Source: AGHT+IFyrvIGLKMun2zBQAu/rH4qQ5xrod/OcaKZx8jK0PKAYugHRd0HtBx9ftP0/a6Jcy2+lI4bwg==
X-Received: by 2002:a05:6a00:3910:b0:710:50c8:ddcb with SMTP id d2e1a72fcca58-71dc5c424c3mr2393108b3a.5.1727827813244;
        Tue, 01 Oct 2024 17:10:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2942ecsm8993948a12.6.2024.10.01.17.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 17:10:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1svmwS-00CiKG-2a;
	Wed, 02 Oct 2024 10:10:08 +1000
Date: Wed, 2 Oct 2024 10:10:08 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jean-Louis Dupond <jean-louis@dupond.be>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: FIFREEZE on loop device does not return EBUSY
Message-ID: <ZvyPYLDvvi7H29Ze@dread.disaster.area>
References: <67055f77-fb5e-4c2e-9570-4361ab05defa@dupond.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67055f77-fb5e-4c2e-9570-4361ab05defa@dupond.be>

On Tue, Oct 01, 2024 at 03:20:43PM +0200, Jean-Louis Dupond wrote:
> Hi All,
> 
> I've been investigating a hang/freeze of some of our VM's when running a
> snapshot on them.
> The cause seems to be that the fsFreeze call before the snapshot gets locked
> forever due to the use of a loop device.
> 
> There are multiple reports about this, like [1] or [2].
> Also there is a quite easy way to simulate it, see [3].
> 
> Now this seems to happen when you do a ioctl FIFREEZE on a mount point that
> is backed by a loop device.
> For ex:
> /dev/loop0      3.9G  508K  3.7G   1% /tmp
> 
> And loop0 is:
> /dev/loop0: [2052]:25308501 (/usr/tmpDSK)
> 
> Now if you lock the disk/partition that has /usr, and then you want to lock
> /tmp, it will hang forever (or until you thaw the /usr disk).

Yup, this is the behaviour freezing the backing filesystem of a loop
device has had since freezing filesystems was implemented 20 years
ago.

So, really, this is expected behaviour...

> You would expect that the call returns -EBUSY like the others, but that is
> not the case.

I certainly don't expect this to return -EBUSY - the /tmp filesystem
has not been frozen, and so it should not return -EBUSY to an
attempt to freeze it. It should be frozen, and because that requires
IO to be done, the behaviour of the operation is dependent on how
the lower layers process the IO that the filesystem issues.

> Is this something we want to solve? Or does somebody have better idea's on
> how to resolve this?

The actual process of freezing complex data caching heirarchies is
beyond the awareness of the kernel. To create consistent snapshot
images of a filesystem, userspace applications need to be flushing
cached data before the filesystem is frozen (i.e. so they suspend to
a coherent state for device snapshots and backups). Then the
filesystem can suspend, and once all write IO is done, the block
device can be suspended. This is a top-down process - it has to be
done in this order.

However, loop devices mean that suspend events first need to
propagate upwards to the top of the heirarchy before any suspend
operation is started so that the entire suspend can be done from the
top down. I think FUSE also introduces complex heirarchies which
could possibly include loops, and I suspect overlay can introduce
them, too.

Hence walking to the top of the heirarchy before we can start a
suspend operation on a filesystem involves interacting with
userspace policy, configuration and applications. This really can
only be done reliably from userspace.

This is especially true when we consider thawing that heirarchy.
What is the kernel supposed to do if it gets a thaw request in the
middle of such a nested suspend? Is it supposed to cascade up and
down the heirarchy? Maybe just up? Or maybe it should be ignored
because it's not at the bottom of the freeze graph? Or maybe we
should allow overrides in case of emergencies if userspace loses
track of what its frozen?

This rapidly gets complex if we try to handle all these potential
policy considerations from a completely context-free environment
inside the kernel. We cannot make the right choices for all cases
where nested freezes might or might not be required by userspace.
It's easier to say "don't do that" than it is to try to solve such a
complex problem with code.

Ultimately, I suspect that FIFREEZE needs to issue a blocking
fanotify event so that userspace can capture such requests and apply
whatever policy the user wants for nested block device hierarchies
and the applications on top of them before the filesystem itself
gets frozen....

> The Qemu issue is already a long standing issue, which I want to get
> resolved :)

It's a long standing issue because it's a complex issue that can't
really be solved by adding code to the kernel alone. Loop device
management is done by userspace, not the kernel, and there is no
one policy for freezing that applies to every situation....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

