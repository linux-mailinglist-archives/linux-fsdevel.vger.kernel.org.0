Return-Path: <linux-fsdevel+bounces-11778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67A4857178
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7B51C22073
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852431468F4;
	Thu, 15 Feb 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Tu/KY/w0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D514600E
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039056; cv=none; b=iU16mLmuuN1UOBKMmgVHQHJ+vPk5HwGCqSBypU7dg1GP/cRir+fu7CxPAUIQcBPP6g6MaSFd07wmr+vZI4K3cTi9JafkSM00x2AX61k0qV1dpK6mDW3Eka1M7ziypQJnBsYXZrnz+GsgNcXM6+rQYP9xwA9302TmsSe/cRx+rwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039056; c=relaxed/simple;
	bh=IQzXo8YAC7z3kfvXEALYTSg4Bkn7ckildzJH7UoOgRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGPPpcKzNQp9MkJdn9tntEYiP0K8Nt/etvUSJmMIuRYvcPz9D5OD9zgLGMaRaGvFCqumKMdxHa5zgy6qjNjgj1NFbXKvoywkGC236a/Q7AxQE3GjyuOpExtXDVl4R62C7VTibekbnGLsxSI1d8lAPNVYcxLxrrMlt7GAIG4EXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Tu/KY/w0; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-296dcd75be7so1217928a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 15:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708039053; x=1708643853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/et5MSWxRm/qeqE7m6EKR3xHrEpnYGsOApna7Ov6Ak=;
        b=Tu/KY/w0ogFz+aDAE7+EsAre2Q45YrjUPCMfM/DtpS+hEe7PwFkRGOSYovQfj6I6Vk
         uF46N0Q+wSnw+6W5i211RL7hATdAzQyzGjwWbndHC6xPzqpF/93Idqo/qrnVCwkCzib6
         wlUeVgZv1xaECXxiVwb64VuSJVjC6ucxSZLza1KyaDCU0QPQ271ZgutIHa0KmDcMhSQl
         gv5wnIRI5OV9u0g/kdAl0gKaqjfdJ7QZyRoQTuYlzBjVgsTq397AjHuwUJS6JkXOy4Bk
         YaGtCJliUdf69ccPXhBlCIsEa5ZhKm4nhY362pLdg2yXIJWs+RoHNQRj2Z6LZb/Ab1r7
         bOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708039053; x=1708643853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/et5MSWxRm/qeqE7m6EKR3xHrEpnYGsOApna7Ov6Ak=;
        b=cIRd0Cw0dj1GvAdBV18t2LHERfJVHKN4GhC6hXTZXYYY84boI9VRKq35s0adEk1Lp7
         DAxHmtw1irYAXW5IvnZZaE7cJ3W8EE7vqMh3kzMEPI9G4rHSyscHAGPCsuV5sDOiD/5X
         HEBGhr8zoV9Tusu0VAwdMScZ2FFeIaD3tgSUsw3n4ZdJheVfunuaEjatarpt1AD1+r0b
         X0mT4j18CazSzsVUFq8qPlaF/ctz/sJYbPloZZw3LZYn+P0Yrgl7HCkM23ZBdg4sdufe
         gvDmagyv9GipejVs2xECpGM9D3s/cRXBuLfiXnvqYi9NcqZ9TsaVqz/vmq21uaYErie3
         ugNg==
X-Forwarded-Encrypted: i=1; AJvYcCXJJzW9u5fJwCi1Z1QLEXtIjXc3Sf34VuW5CYIuJ/Q2djFFCmD8tjyPzVFtvwXhr7hYYfQnsN09/q/OI786OqIBN+HK/zQ2yvLvxtCWxQ==
X-Gm-Message-State: AOJu0YxgYQde0TB9H5B09aNGio/x6s4Dhaby3ChRmy1tdQ89QLg2rtgW
	W2ChnljexFkMEeLXejWUXgRCsKM+Xr0u8nNZk7af59R7m4llCLKL5pz8Fgo869E=
X-Google-Smtp-Source: AGHT+IFhA4H/FgqLaX5RroaIei6TRFkU6Su0sp4d98cSsiQq3PYmJvaE1sS4txnHDPpO9+9KxCEcqg==
X-Received: by 2002:a17:90a:ac08:b0:296:3a5:6fb8 with SMTP id o8-20020a17090aac0800b0029603a56fb8mr3007778pjq.25.1708039053227;
        Thu, 15 Feb 2024 15:17:33 -0800 (PST)
Received: from dread.disaster.area (pa49-195-8-86.pa.nsw.optusnet.com.au. [49.195.8.86])
        by smtp.gmail.com with ESMTPSA id eu16-20020a17090af95000b00296f3401cabsm336168pjb.41.2024.02.15.15.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 15:17:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rakyv-0072Pt-2a;
	Fri, 16 Feb 2024 10:17:29 +1100
Date: Fri, 16 Feb 2024 10:17:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Adrian Vovk <adrianvovk@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <Zc6biamtwBxICqWO@dread.disaster.area>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <20240116114519.jcktectmk2thgagw@quack3>
 <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
 <20240117143528.idmyeadhf4yzs5ck@quack3>
 <ZafpsO3XakIekWXx@casper.infradead.org>
 <3107a023-3173-4b3d-9623-71812b1e7eb6@gmail.com>
 <20240215135709.4zmfb7qlerztbq6b@quack3>
 <da1e04bf-7dcc-46c8-af30-d1f92941740d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1e04bf-7dcc-46c8-af30-d1f92941740d@gmail.com>

On Thu, Feb 15, 2024 at 02:46:52PM -0500, Adrian Vovk wrote:
> On 2/15/24 08:57, Jan Kara wrote:
> > On Mon 29-01-24 19:13:17, Adrian Vovk wrote:
> > > Hello! I'm the "GNOME people" who Christian is referring to
> > Got back to thinking about this after a while...
> > 
> > > On 1/17/24 09:52, Matthew Wilcox wrote:
> > > > I feel like we're in an XY trap [1].  What Christian actually wants is
> > > > to not be able to access the contents of a file while the device it's
> > > > on is suspended, and we've gone from there to "must drop the page cache".
> > > What we really want is for the plaintext contents of the files to be gone
> > > from memory while the dm-crypt device backing them is suspended.
> > > 
> > > Ultimately my goal is to limit the chance that an attacker with access to a
> > > user's suspended laptop will be able to access the user's encrypted data. I
> > > need to achieve this without forcing the user to completely log out/power
> > > off/etc their system; it must be invisible to the user. The key word here is
> > > limit; if we can remove _most_ files from memory _most_ of the time Ithink
> > > luksSuspend would be a lot more useful against cold boot than it is today.
> > Well, but if your attack vector are cold-boot attacks, then how does
> > freeing pages from the page cache help you? I mean sure the page allocator
> > will start tracking those pages with potentially sensitive content as free
> > but unless you also zero all of them, this doesn't help anything against
> > cold-boot attacks? The sensitive memory content is still there...
> > 
> > So you would also have to enable something like zero-on-page-free and
> > generally the cost of this is going to be pretty big?
> 
> Yes you are right. Just marking pages as free isn't enough.
> 
> I'm sure it's reasonable enough to zero out the pages that are getting
> free'd at our request. But the difficulty here is to try and clear pages
> that were freed previously for other reasons, unless we're zeroing out all
> pages on free. So I suppose that leaves me with a couple questions:
> 
> - As far as I know, the kernel only naturally frees pages from the page
> cache when they're about to be given to some program for imminent use.

Memory pressure does cause cache reclaim. Not just page cache, but
also slab caches and anything else various subsystems can clean up
to free memory..

> But
> then in the case the page isn't only free'd, but also zero'd out before it's
> handed over to the program (because giving a program access to a page filled
> with potentially sensitive data is a bad idea!). Is this correct?

Memory exposed to userspace is zeroed before userspace can access
it.  Kernel memory is not zeroed unless the caller specifically asks
for it to be zeroed.

> - Are there other situations (aside from drop_caches) where the kernel frees
> pages from the page cache? Especially without having to zero them anyway? In

truncate(), fallocate(), direct IO, fadvise(), madvise(), etc. IOWs,
there are lots of runtime vectors that cause page cache to be freed.

> other words, what situations would turning on some zero-pages-on-free
> setting actually hurt performance?

Lots.  page contents are typically cold when the page is freed so
the zeroing is typically memory latency and bandwidth bound. And
doing it on free means there isn't any sort of "cache priming"
performance benefits that we get with zeroing at allocation because
the page contents are not going to be immediately accessed by the
kernel or userspace.

> - Does dismounting a filesystem completely zero out the removed fs's pages
> from the page cache?

No. It just frees them. No explicit zeroing.

> - I remember hearing somewhere of some Linux support for zeroing out all
> pages in memory if they're free'd from the page cache. However, I spent a
> while trying to find this (how to turn it on, benchmarks) and I couldn't
> find it. Do you know if such a thing exists, and if so how to turn it on?
> I'm curious of the actual performance impact of it.

You can test it for yourself: the init_on_free kernel command line
option controls whether the kernel zeroes on free.

Typical distro configuration is: 

$ sudo dmesg |grep auto-init
[    0.018882] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
$

So this kernel zeroes all stack memory, page and heap memory on
allocation, and does nothing on free...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

