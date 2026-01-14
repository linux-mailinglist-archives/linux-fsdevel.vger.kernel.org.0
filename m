Return-Path: <linux-fsdevel+bounces-73653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EA7D1DB8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C7A23007C36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5338756F;
	Wed, 14 Jan 2026 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjDjfTps";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXvH81Rp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622F34EF04
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384388; cv=none; b=QUeRtJpp9m4H4SiCknmqgoNvzVOq6FUqz25LI74CUpEhqPUNkkeoq56V5SyIVqMk2QN8nUtXcGGWGNHR/BstBX6vwEjtQx+2jl+gDnruLULyDcuZ8iXuhvWEXaSxWp7rARiikfzX2X4qyZdaMz7J1mveqFTcwBj7Iy5Irx7WpMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384388; c=relaxed/simple;
	bh=j5dIhiNJiGy1Qtc22ykR0iIEoSppbe3oLD7npilDfdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if8mMP3w+QR91FhF0628Rl4WV2Lvz0mQZaAQB2iGP+aHWesQZBGcdGyIKMyTJNtN5mx4fTHqJg4THsN5tQZRWPGSnHkITBykTy3PxWTC23N3NlHvK0J+9tKYEzxiwWijlDni6YIqKI+kZjmd/gzydRbcK/uNZ7R3lMzt9+qGIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjDjfTps; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXvH81Rp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768384385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aSFGgkgkpAF2fQrg8Gq7zIy2TZqVfBWhEA5o4HTAphk=;
	b=PjDjfTpsTWOsBOmTZ7nUGJ0gMKYxueyBwzsCprD0eC1i7Wx02mlKMfd/bGhHJtcP5VxfX+
	3awtW+624kRS3jZeKRIEdOGB6gF5TeND+S22knHbeaOU4ZIO37W3je0NvYy9FG2t2F63rf
	yEkpwHY+y5NQ1NdWTIRI6fcsNw+q2ag=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-lJOw2IokNByblbnQ9cHJcQ-1; Wed, 14 Jan 2026 04:53:04 -0500
X-MC-Unique: lJOw2IokNByblbnQ9cHJcQ-1
X-Mimecast-MFC-AGG-ID: lJOw2IokNByblbnQ9cHJcQ_1768384383
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so70851645e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 01:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768384383; x=1768989183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSFGgkgkpAF2fQrg8Gq7zIy2TZqVfBWhEA5o4HTAphk=;
        b=iXvH81RpV/62GVRd7EvSFBHup8D8LC0/TmitVHYA+8uurzjqbaO1LDFN/otyZDiaES
         iOKhlo+AI3PP30gu+ET0Q4dT/YdHkDMfNT1Zv+CiD4eANOquUGxae6x4JmzaAxhDcmwP
         GPgeP9WpZN4WYS7WjeoErv/bv7SH7S5HjSh9gKcNMQTuxi2sfvTjTtX0Uvlc0mHXY4K6
         nXAkhWBvDGn71sA6sQNgopzcgYYzcM2lBCdtxSIkkEMqCz3FYcLTXGKPEuNxaUnFWiKC
         E7JCu79O0znukhJGIn1jbvOVs0nrOh+OoNwTIItByH9TyIWY9vKLoLxHu7c+S45p7YpT
         WJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384383; x=1768989183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSFGgkgkpAF2fQrg8Gq7zIy2TZqVfBWhEA5o4HTAphk=;
        b=QQ+7uN6YuYrAir1RhfSvAmh9wiqzU1bXIL70gC96/3H0YhMqcWPMoRT6x+mTizn7rk
         b1l2uCBRoX90SLcpUAOSHxJJq0Qan5+QJTJEDF8PxEgk35StKxWvgBl+JQC13ceTod7b
         Y1BFqCyd/QRBJ+Hx+pUtBlWWa0B3bUlVLxuSOKTWKUNdH7k5GAmohB3irs13hNdVfqqb
         DwWxV2Zg+7Os+gZbk18hoSswQmNKkqnKGB0XJQlJUd8nc9ZnyS5c9OI8GusfD2/zRSIu
         GiwTWKwhaJejFIKtae9C3mhVN+x8tUOfdzDdR49eQpPgyYJxA7tCpCB34BarlAqxaFP3
         xEfw==
X-Forwarded-Encrypted: i=1; AJvYcCWUv6yT5pDBkUS2TvhXZ0YGHp19RP/EZO7aj2HHjo2AlAcbBDOYoXypGbIsboHOHe5xptY5Ah2C0M3rehgN@vger.kernel.org
X-Gm-Message-State: AOJu0YwArENJP7C09S6BCrNffkD7oluII5nrdVjQcn9aFSl9Y/t/EOVe
	17zABVBtvxmm2ZYf6IVpGegiGSYqwwZ8In8YevmnVvbPlFxV83VNsvYLT7iuRm+IgCRBmm4lwk3
	7UZcOZ63ijU1qIlIYDBT0ZN1yl7d8m+LyQykcm6Vja3lsIJRi/fYNu5v7Hdvo7hIyUA==
X-Gm-Gg: AY/fxX7HAtbBLFJ5ozLdE+/UKXGuuNL2vjwzQg78YpR6XVglArZ0izzr3YSqHXspxaD
	HtX61BsoG/syD0FXYiFB2rwEfIH6S1UcokWxh0tljT2eFrxOK3LXdD7Z0bdcNpgH3HqMuRxT4YV
	rxD8ffrxtdUEHdkKUfXLK7KW7L2knrSNQemzDG2J54YdMthdkUVv49t/n5u3zOq4F+tI52tuoQW
	bQi2BU4Bhq4b45h88T8mLIsdkaQy/EVUU9KwxSf6RwLGcJNMywPwvA7YSQ1Atdd3kOLbfg/iEzz
	XkK+AeNG8IvRVKVVuycDv+3X7IZQQ8Fb9RaxDvLsXEiev2QIrZXObUQzuuqMfJjnOkHRVVefItk
	=
X-Received: by 2002:a5d:584e:0:b0:430:f790:99d7 with SMTP id ffacd0b85a97d-4342c504f28mr2510673f8f.27.1768384383085;
        Wed, 14 Jan 2026 01:53:03 -0800 (PST)
X-Received: by 2002:a5d:584e:0:b0:430:f790:99d7 with SMTP id ffacd0b85a97d-4342c504f28mr2510645f8f.27.1768384382674;
        Wed, 14 Jan 2026 01:53:02 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e19bfsm48777428f8f.18.2026.01.14.01.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 01:53:01 -0800 (PST)
Date: Wed, 14 Jan 2026 10:53:00 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, fsverity@lists.linux.dev, 
	linux-xfs@vger.kernel.org, ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 0/23] fs-verity support for XFS with post EOF merkle
 tree
Message-ID: <6r24wj3o3gctl3vz4n3tdrfjx5ftkybdjmmye2hejdcdl6qseh@c2yvpd5d4ocf>
References: <cover.1768229271.patch-series@thinky>
 <aWZ0nJNVTnyuFTmM@casper.infradead.org>
 <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl>
 <aWci_1Uu5XndYNkG@casper.infradead.org>
 <20260114061536.GG15551@frogsfrogsfrogs>
 <5z5r6jizgxqz5axvzwbdmtkadehgdf7semqy2oxsfytmzzu6ik@zfvhexcp3fz2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5z5r6jizgxqz5axvzwbdmtkadehgdf7semqy2oxsfytmzzu6ik@zfvhexcp3fz2>

On 2026-01-14 09:20:34, Andrey Albershteyn wrote:
> On 2026-01-13 22:15:36, Darrick J. Wong wrote:
> > On Wed, Jan 14, 2026 at 05:00:47AM +0000, Matthew Wilcox wrote:
> > > On Tue, Jan 13, 2026 at 07:45:47PM +0100, Andrey Albershteyn wrote:
> > > > On 2026-01-13 16:36:44, Matthew Wilcox wrote:
> > > > > On Mon, Jan 12, 2026 at 03:49:44PM +0100, Andrey Albershteyn wrote:
> > > > > > The tree is read by iomap into page cache at offset 1 << 53. This is far
> > > > > > enough to handle any supported file size.
> > > > > 
> > > > > What happens on 32-bit systems?  (I presume you mean "offset" as
> > > > > "index", so this is 1 << 65 bytes on machines with a 4KiB page size)
> > > > > 
> > > > it's in bytes, yeah I missed 32-bit systems, I think I will try to
> > > > convert this offset to something lower on 32-bit in iomap, as
> > > > Darrick suggested.
> > > 
> > > Hm, we use all 32 bits of folio->index on 32-bit plaftorms.  That's
> > > MAX_LFS_FILESIZE.  Are you proposing reducing that?
> > > 
> > > There are some other (performance) penalties to using 1<<53 as the lowest
> > > index for metadata on 64-bit.  The radix tree is going to go quite high;
> > > we use 6 bits at each level, so if you have a folio at 0 and a folio at
> > > 1<<53, you'll have a tree of height 9 and use 17 nodes.
> > > 
> > > That's going to be a lot of extra cache misses when walking the XArray
> > > to find any given folio.  Allowing the filesystem to decide where the
> > > metadata starts for any given file really is an important optimisation.
> > > Even if it starts at index 1<<29, you'll almost halve the number of
> > > nodes needed.
> 
> Thanks for this overview!
> 
> > 
> > 1<<53 is only the location of the fsverity metadata in the ondisk
> > mapping.  For the incore mapping, in theory we could load the fsverity
> > anywhere in the post-EOF part of the pagecache to save some bits.
> > 
> > roundup(i_size_read(), 1<<folio_max_order)) would work, right?
> 
> Then, there's probably no benefits to have ondisk mapping differ,
> no?

oh, the fixed ondisk offset will help to not break if filesystem
would be mounted by machine with different page size.

-- 
- Andrey


