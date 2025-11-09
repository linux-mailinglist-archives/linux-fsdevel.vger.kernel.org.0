Return-Path: <linux-fsdevel+bounces-67619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A680CC448D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 23:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A64F345E9A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 22:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8B1FC8;
	Sun,  9 Nov 2025 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CITd8G5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3CA19CD05
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762726556; cv=none; b=XoYWGRq6jUNpRvXPqvVlEs80KC8pxVBX1Auf1ziNcJlAvFF0OVSjZJ8Hi9A9yrRLOz///qH5ZnOs3/ccYl01ipG3OqpJ2JdM4shQEiAKLMPq15LtPo65crg1WXcWmHoGKq0xAM/6Suj3+Lls3p8N8mqLvcr/7NFeHeuGhH51DLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762726556; c=relaxed/simple;
	bh=tKJObxD2DlAcBppI4XR2Q6wxmQG8NDqwYNptQ/xrx7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRw7mBHMaFdFXy4uWbEDd0Z0RhzYhK3ExAMDmxu0Tg5Ql7Gkq7A4NvVQt7xjHbwzwD/A4ma/IsKRk5fOH/gYwmaDQumSOKP4bSbNtgQnQle4BmCJAnQR59IPiULgB7nKiXkKBwG38UpvqNcz1RAYrgIsNIi/2s31q8ZWBm9xru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CITd8G5K; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2953ad5517dso22087385ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 14:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1762726554; x=1763331354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0lKfVVOJDL/oN342gKhQywskOHolZGAyYrUsYWvnBU=;
        b=CITd8G5KOpvZ68qI9uSjNigevbXvarkWjiHv420oNmyotgIMqgsimGHUkexDMnk3xd
         9kZ3ajk+h/d1EFhxPGc6bttlmZxwe25lKI51C8TUq/Sekgofp01piz63rZXq5XE0CLFo
         SGdbmaSKP06tQSJHnZKRgyWsQW68cycMkcntfY8zSlXlvsxYMdismQiQeJmhB2qqaFC8
         DXaOU5iLArBGDn67JLgWAJtJT+xtSyrakOCIZRYTWBx5/YKPtcRgjJS3lJAstCWTGBF9
         yoKmYeh+uPyN9sZY2+IfPEvBoUH1/daBBplxqm/IcTrT4+nFAv/0qgzy4PhpDrwfl1kd
         U2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762726554; x=1763331354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0lKfVVOJDL/oN342gKhQywskOHolZGAyYrUsYWvnBU=;
        b=GVDf1b9wQS/aXb25l5QXdlIKcYACcROzUz7BCM9VYtOtczGCGORYxYQgxPmG5/1/vc
         35a+RoLiCLLPHnKAPefkO5RqAW28IdyNWc+gbA55sLPFnAuPokgR8So2Bm14WNW+gcJh
         KXtk3xEGXgmyshhLWd4+Dk5tpA+uPwBYEsAKMVkB+jZhJsMwC/Onb5Max2PV7E4sjP3O
         D97V82iXKMAaCPyNSdDrEQlVVGHyrgjrDi/nQCRyBRlL1Q8sIkttou2qbE7+KwKyPyMJ
         bdSMFYut3N+Uu5UJmrtjA46kekpOPKdjRe+QX3WRv2i5K9rjt9jGICp+4oIPz7pPLtu3
         otlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4OXJgn10M8IXXP9uQ2bDeh/ARPnvhwHZoe/Mdv64nymPvSDwVuW4wTtZzqMhuFeJOwp4DhhGCHHzG1ta9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn1hfRvMXof8aQPAYZXXd8BD0THXWE9Gd62sfx69vdiKQi7TjK
	eMK8f18SFbLOMvtmvEdt+l478IHDPYJeGkDn42z5GYceG4J+YywVFCJK9ry+oCe/etA=
X-Gm-Gg: ASbGncsVCupdyVTqMQJH0HZizq49pY3amKPX0rkIyLurN2XjNgBWn/oL0R/p7QeoQa5
	uy4wyLGX35/bjAKYFv8lcxI+1VgLeIimBFF3vvIynQNj3GILO0Fdy9CYgwyiPe5YQgNs/7wc7ds
	GZIUgr5iR+k6cdtd4NcF+gtUmD0XnZ6R3WWl0T+i3OZTDO0atR4a5zuhXmOSd/KIvXd+sLGiuv5
	+uEZWvUWpAPzxWPk7u6ndIJ4WZrjSRk2pHJHOZN4eWcSv01zFzhe6cTl2LO1gNoYRFVd5XD4YD1
	w+YGUCN3gQAIA6ME1qieUEsouk1fgR3lmI5PIn++RB17Z8cpmpUAR9s0WEIuxXTepi/h/Xhthiz
	xqJxiXZL+8UDn0du0madIALop28KRJtf8qInozCCNe7+g3vKp5G20DNtFM1Esy3HreA2yK1/FCs
	7sXYo5AomJInhVY0TXGhASJGmwF9BqOwrmfL0xkdyE0H+EFwtmx+FO5MSEiqcCVA==
X-Google-Smtp-Source: AGHT+IF8xjD56HA0NLui8kHyTpt5jvrPCAkNdesIKCe+WNAvzhOA6aIdD5XSQadn6WKTfCDM43WCgA==
X-Received: by 2002:a17:903:fa5:b0:295:c2e7:7199 with SMTP id d9443c01a7336-297e56acaefmr86527445ad.29.1762726554460;
        Sun, 09 Nov 2025 14:15:54 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8f4sm122294505ad.10.2025.11.09.14.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 14:15:54 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vIDhO-00000008fPl-33cV;
	Mon, 10 Nov 2025 09:15:50 +1100
Date: Mon, 10 Nov 2025 09:15:50 +1100
From: Dave Chinner <david@fromorbit.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Christoph Hellwig <hch@lst.de>, Florian Weimer <fweimer@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <aRESlvWf9VquNzx3@dread.disaster.area>
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
 <lhuikfngtlv.fsf@oldenburg.str.redhat.com>
 <20251106135212.GA10477@lst.de>
 <aQyz1j7nqXPKTYPT@casper.infradead.org>
 <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
 <20251106170501.GA25601@lst.de>
 <878qgg4sh1.fsf@mid.deneb.enyo.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qgg4sh1.fsf@mid.deneb.enyo.de>

On Sat, Nov 08, 2025 at 01:30:18PM +0100, Florian Weimer wrote:
> * Christoph Hellwig:
> 
> > On Thu, Nov 06, 2025 at 05:31:28PM +0100, Florian Weimer wrote:
> >> It's been a few years, I think, and maybe we should drop the allocation
> >> logic from posix_fallocate in glibc?  Assuming that it's implemented
> >> everywhere it makes sense?
> >
> > I really think it should go away.  If it turns out we find cases where
> > it was useful we can try to implement a zeroing fallocate in the kernel
> > for the file system where people want it.

This is what the shiny new FALLOC_FL_WRITE_ZEROS command is supposed
to provide. We don't have widepsread support in filesystems for it
yet, though.

> > gfs2 for example currently
> > has such an implementation, and we could have somewhat generic library
> > version of it.

Yup, seems like a iomap iter loop would be pretty trivial to
abstract from that...

> Sorry, I remember now where this got stuck the last time.
> 
> This program:
> 
> #include <fcntl.h>
> #include <stddef.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> 
> int
> main(void)
> {
>   FILE *fp = tmpfile();
>   if (fp == NULL)
>     abort();
>   int fd = fileno(fp);
>   posix_fallocate(fd, 0, 1);
>   char *p = mmap(NULL, 1, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>   *p = 1;
> }
> 
> should not crash even if the file system does not support fallocate.

I think that's buggy application code.

Failing to check the return value of a library call that documents
EOPNOTSUPP as a valid error is a bug. IOWs, the above code *should*
SIGBUS on the mmap access, because it failed to verify that the file
extension operation actually worked.

I mean, if this was "ftruncate(1); mmap(); *p =1" and ftruncate()
failed and so SIGBUS was delivered, there would be no doubt that
this is an application bug. Why is should we treat errors returned
by fallocate() and/or posix_fallocate() any different here?

> I hope we can agree on that.  I expect avoiding SIGBUS errors because
> of insufficient file size is a common use case for posix_fallocate.
> This use is not really an optimization, it's required to get mmap
> working properly.
> 
> If we can get an fallocate mode that we can use as a fallback to
> increase the file size with a zero flag argument, we can definitely

The fallocate() API already support that, in two different ways:
FALLOC_FL_ZERO_RANGE and FALLOC_FL_WRITE_ZEROS. 

But, again, not all filesystems support these, so userspace has to
be prepared to receive -EOPNOTSUPP from these calls. Hence userspace
has to do the right thing for posix_fallocate() if you want to
ensure that it always extend the file size even when fallocate()
calls fail...

> use that in posix_fallocate (replacing the fallback path on kernels
> that support it).  All local file systems should be able to implement
> that (but perhaps not efficiently).  Basically, what we need here is a
> non-destructive ftruncate.

You aren't going to get support for such new commands on existing
kernels, so userspace is still going to have to code the ftruncate()
fallback itself for the desired behaviour to be provided
consistently to applications.

As such, I don't see any reason for the fallocate() syscall
providing some whacky "ftruncate() in all but name" mode.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

