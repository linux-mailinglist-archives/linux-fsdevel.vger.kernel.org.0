Return-Path: <linux-fsdevel+bounces-13961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6EC875BEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 02:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C69B21B42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148CF20DFC;
	Fri,  8 Mar 2024 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="RQPGinmk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F602231A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860837; cv=none; b=OHsjUWi4dxMzOUbyJS7Zx/51yPmQl6mnShkbT2E3DtFW5v2nsXBXrG4XoXU/8f9z61BRpYlLvjVVC4pWHYoTVDTRRkPqW/AzyYhuy9odum7RPQ6kgeHRb21tEFq8MiXFEgN4fShAlQ4elurzrLvsNikDhsQnJpkdLME1ukwkz3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860837; c=relaxed/simple;
	bh=Nx+MT1vJP4mbJnRyh/lCdoru851YYCG1aY+izw4dc7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRyV2/nCoKnmYnObjKf6BB3M1fL0kaipPS3FqRmQSS2f7KlmroDa9JmUncvfD9eJcM0gVepHgZKY/1fgiIVJIMrNzu4OBvrRulnff/5TGjmamzQnuvJ6MqV50qTKaaQuGxlBuj69WKtpGVDaC3pTkogi5hYyjzi1bi7PHM0LNwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=RQPGinmk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso1256237a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 17:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709860835; x=1710465635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ2AF+ICFWs2W7ztvS+RsyRVeFcwNII0EUkN37zJuzw=;
        b=RQPGinmkxZrTpKgdm0eSmh1W3l+EecfInCsLJhGM/Q7HUkhGFoTqCHKbaE1v8GhiB0
         yv40+Xb5g2gcBdqGi/ZM4ba37hXY/deLaVeRsaftr3nG3b/U/i3AC1jHbhqg6pa63Rnr
         /ALqMuNK7wsdSMVOg1xRm3Mttgoq2d70NwdcaFLpc1UTNAZD+HjkGdeKVOTUR+c6U4zE
         XvQra1YFuqf1PcpaSIENa8s/CkQbh7jdYz5VTUPVwh9aHYbzhBjb9dIHjpRI11z+5bRh
         fO/rNKpcvBCKNXqhPYgigo7x2WXhCGDcnFiOaVSqI7o1UELDdVpAXLk+adPnRYg4nOMf
         fCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860835; x=1710465635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ2AF+ICFWs2W7ztvS+RsyRVeFcwNII0EUkN37zJuzw=;
        b=Bmlr2q962wNQD8E6VpCN3oPNIsE/vn5yLwJvO5YowG7kQb0wuukW2BUVfXV37MJ2ih
         ev7uWCWqlex0CoVGVQAKh7ol8yeXAtx2HBV/TiJi9kLArUxgB9dXXk6PTqjm3Egg1Aur
         1UexucJXzK41i7KJ45y3rj0HlvHxcllaBGPwN/u2TaQ8x6HfAoJHCei725ywQA1tyjXH
         28KSUW4o9sVc2oheJ56nSB7Id9btohpNNuk74FLFKy33yrJJC1jb1xaHNv0oNLotLzjG
         p1ie6DDYCCHfyVOBgVV6rZVglPVJam8C+LbGdLOkyhdqE3mUtqnYapzxHIB3FdsI7j7S
         oQdg==
X-Forwarded-Encrypted: i=1; AJvYcCVJNRod63MBDHYNwMDoeKx/VZd/fKPkpHe3Pf8ty3Pd+GnmkxbEO1I8ZwgmgS5AzJ086+sEX4rBBWd0aZt7FUmR7yUm5kt4ndHCZB6klw==
X-Gm-Message-State: AOJu0YwOtsXY3Sp56v8pLMConflp8hPArcdCEQ2LLWU7arDRIEVECewj
	qma2fJG42DSSmhqwLD7/a5JVmksqxgla3xgvJvx8nOz4GvRUk8DupRTDxQXhitQ=
X-Google-Smtp-Source: AGHT+IE5eGGiEVnsyqzqZ2APnPpCERPZ1KOQPohJT3muoTmMrtd7wpiePc9TyfqxesYYO3jsBjMBbQ==
X-Received: by 2002:a05:6a20:d38e:b0:1a1:5044:e46c with SMTP id iq14-20020a056a20d38e00b001a15044e46cmr11533947pzb.33.1709860834870;
        Thu, 07 Mar 2024 17:20:34 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id q22-20020a056a00085600b006e623639a80sm7866928pfk.19.2024.03.07.17.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 17:20:34 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1riOuV-00GUlu-2c;
	Fri, 08 Mar 2024 12:20:31 +1100
Date: Fri, 8 Mar 2024 12:20:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 10/24] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <Zepn3ycweBrgwgDO@dread.disaster.area>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-12-aalbersh@redhat.com>
 <20240304233927.GC17145@sol.localdomain>
 <ZepP3iAmvQhbbA2t@dread.disaster.area>
 <20240307235907.GA8111@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307235907.GA8111@sol.localdomain>

On Thu, Mar 07, 2024 at 03:59:07PM -0800, Eric Biggers wrote:
> On Fri, Mar 08, 2024 at 10:38:06AM +1100, Dave Chinner wrote:
> > > This makes all kernels with CONFIG_FS_VERITY enabled start preallocating memory
> > > for these bios, regardless of whether they end up being used or not.  When
> > > PAGE_SIZE==4096 it comes out to about 134 KiB of memory total (32 bios at just
> > > over 4 KiB per bio, most of which is used for the BIO_MAX_VECS bvecs), and it
> > > scales up with PAGE_SIZE such that with PAGE_SIZE==65536 it's about 2144 KiB.
> > 
> > Honestly: I don't think we care about this.
> > 
> > Indeed, if a system is configured with iomap and does not use XFS,
> > GFS2 or zonefs, it's not going to be using the iomap_ioend_bioset at
> > all, either. So by you definition that's just wasted memory, too, on
> > systems that don't use any of these three filesystems. But we
> > aren't going to make that one conditional, because the complexity
> > and overhead of checks that never trigger after the first IO doesn't
> > actually provide any return for the cost of ongoing maintenance.
> > 
> > Similarly, once XFS has fsverity enabled, it's going to get used all
> > over the place in the container and VM world. So we are *always*
> > going to want this bioset to be initialised on these production
> > systems, so it falls into the same category as the
> > iomap_ioend_bioset. That is, if you don't want that overhead, turn
> > the functionality off via CONFIG file options.
> 
> "We're already wasting memory, therefore it's fine to waste more" isn't a great
> argument.

Adding complexity just because -you- think the memory is wasted
isn't any better argument. I don't think the memory is wasted, and I
expect that fsverity will end up in -very- wide use across
enterprise production systems as container/vm image build
infrastructure moves towards composefs-like algorithms that have a
hard dependency on fsverity functionality being present in the host
filesytsems.

> iomap_ioend_bioset is indeed also problematic, though it's also a bit different
> in that it's needed for basic filesystem functionality, not an optional feature.
> Yes, ext4 and f2fs don't actually use iomap for buffered reads, but IIUC at
> least there's a plan to do that.  Meanwhile there's no plan for fsverity to be
> used on every system that may be using a filesystem that supports it.

That's not the case I see coming for XFS - by the time we get this
merged and out of experimental support, the distro and application
support will already be there for endemic use of fsverity on XFS.
That's all being prototyped on ext4+fsverity right now, and you
probably don't see any of that happening.

> We should take care not to over-estimate how many users use optional features.
> Linux distros turn on most kconfig options just in case, but often the common
> case is that the option is on but the feature is not used.

I don't think that fsverity is going to be an optional feature in
future distros - we're already building core infrastructure based on
the data integrity guarantees that fsverity provides us with. IOWs,
I think fsverity support will soon become required core OS
functionality by more than one distro, and so we just don't care
about this overhead because the extra read IO bioset will always be
necessary....

> > > How about allocating the pool when it's known it's actually going to be used,
> > > similar to what fs/crypto/ does for fscrypt_bounce_page_pool?  For example,
> > > there could be a flag in struct fsverity_operations that says whether filesystem
> > > wants the iomap fsverity bioset, and when fs/verity/ sets up the fsverity_info
> > > for any file for the first time since boot, it could call into fs/iomap/ to
> > > initialize the iomap fsverity bioset if needed.
> > > 
> > > BTW, errors from builtin initcalls such as iomap_init() get ignored.  So the
> > > error handling logic above does not really work as may have been intended.
> > 
> > That's not an iomap problem - lots of fs_initcall() functions return
> > errors because they failed things like memory allocation. If this is
> > actually problem, then fix the core init infrastructure to handle
> > errors properly, eh?
> 
> What does "properly" mean?

Having documented requirements and behaviour and then enforcing
them. There is no documentation for initcalls - they return an int,
so by convention it is expected that errors should be returned to
the caller.

There's *nothing* that says initcalls should panic() instead of
returning errors if they have a fatal error. There's nothing that
says "errors are ignored" - having them be declared as void would be
a good hint that errors can't be returned or handled.

Expecting people to cargo-cult other implementations and magically
get it right is almost guaranteed to ensure that nobody actually
gets it right the first time...

> Even if init/main.c did something with the returned
> error code, individual subsystems still need to know what behavior they want and
> act accordingly.

"return an error only on fatal initialisation failure" and then the
core code can decide if the initcall level is high enough to warrant
panic()ing the machine.

> Do they want to panic the kernel, or do they want to fall back
> gracefully with degraded functionality.

If they can gracefully fall back to some other mechanism, then they
*haven't failed* and there's no need to return an error or panic.

> If subsystems go with the panic (like
> fsverity_init() does these days), then there is no need for doing any cleanup on
> errors like this patchset does.

s/panic/BUG()/ and read that back.

Because that's essentially what it is - error handling via BUG()
calls. We get told off for using BUG() instead of correct error
handling, yet here we are with code that does correct error handling
and we're being told to replace it with BUG() because the errors
aren't handled by the infrastructure calling our code. Gross, nasty
and really, really needs to be documented.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

