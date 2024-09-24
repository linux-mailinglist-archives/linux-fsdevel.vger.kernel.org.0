Return-Path: <linux-fsdevel+bounces-29922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50023983B72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 05:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAA6282BB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 03:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A1A17C91;
	Tue, 24 Sep 2024 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ffM1EVfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3A14263
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727147075; cv=none; b=Ocqfv0be66qeYdRNZjkJauS2mcQb6LxYu3IjEwZMNasSZRW9WGeayooil4OKE0+7ZbrWBr0zHgvT0hQIAY5M1/WEgrszMIF5LpGZRYyhG85m/oe7s42in3q1yt8D7F85ShrRjRCnfPUuZ6i1CGNi/z1vRSZ7HjqObfJNCD4iCPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727147075; c=relaxed/simple;
	bh=8oNuoCVbfMXwNtX7RPT0C6fZdIyf/UL2u1CR1LtpClw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYa+7m5uSBhnKYFN8wlAzaZxV3F+y1eRN/KkUXb1FE6EKBqqEFrS39xDy+yIx+40FyE8LAKsijV2UjaExYXApWKsybf4IHVE74ugeSn588oBWyT86d3qRrfw7GUUW7h+1Y7gv6BziMfsbCoDxhvFJHECvnNTWMPhDl4sater+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ffM1EVfh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so4211180b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 20:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727147073; x=1727751873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcLBeHEvd4a4/13ZAs+Cbq1xvL33+EPPFTh/XAx8Bqo=;
        b=ffM1EVfhckandOr+9J3eHN+fAFXVBNKqmOZqKDo7bAW/0Yldvc2m7TAYefW0tf9MWa
         fVDu1SlAEPfHNbGE/0sZ6kKjqDDsxn7aelGKaWzlIaPlNpzR4IsZ20jhPhmElVmHZzhs
         UBoSpNPgPSyFLCNjIl+38Z4OB0Nn/Hll5/UqOa8G22h2k0UoY7pO+vMSMjsXd0wuAM/4
         unXjxv8aDEgTAwv9dgQfcQj60IMjO5yAHJ9UZiWjKj/yahaqip/h5H3CxEzVqCIhzCrD
         P8dmoTosHXs22y9Bul5P60NOQq7jPfPQbtWx3QAUpk9hYRsovsRnI8oc1/5N/a20Jgj0
         6pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727147073; x=1727751873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcLBeHEvd4a4/13ZAs+Cbq1xvL33+EPPFTh/XAx8Bqo=;
        b=v0GPGfPT2gH5dMILokiDqxjsrakR4lAN/bpr2OLmEk3M8xPxZyMIJqMmy09z+L+WQQ
         Y4W0EWQ0cAOKi7VI5ZWzwgXB3Iqzewg5MSeZv1pXyQiMcN67VK1A3ggEdgcdBJJnlLMs
         r2nEPx5/aWD6QbCQfR3a6SLV6VUwYguMmXTXlgFX2gv479oDhbfX8VF6ciA6+bwWJ2q8
         Zfho3mmDMxVpZAxLD31xz+tP8G6VS5pLbdGtR8+ZqSCYITzMOKFJRdYATVMBxNOSJjs9
         Uottra9lvtI926MEoOrD7QV6DDmCUELczP64urhgsAgFL05x1HtIij6qd357SX/hiUoP
         /iVw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Kv/U448Is/q6ADWISWBYKzLVE2LuWgFBylRE57krb4riCXFBGRD4n1i+0nlnbLgUsE6kikEhdEJF9g1n@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+RykrAeE7G+2vBIdyJ/TKBjfi2f8t8jBsb5t9F4GM4pjZjtp
	SXPkK1XNX4n5PEXnYP5KvccvbhyHzdcEk5uai/yKQJ+ky9gYHm3GA6sBnYHqyc8=
X-Google-Smtp-Source: AGHT+IFAPI8wgTAdQiHhIxyTS3M81fYM5GIfzkXeAYV4uofYzTIdaLuq0lpgQWdQrfcLw1NV/hskqw==
X-Received: by 2002:a05:6a00:1881:b0:714:28c7:2455 with SMTP id d2e1a72fcca58-7199c936b37mr21551638b3a.6.1727147073283;
        Mon, 23 Sep 2024 20:04:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc8493cdsm288060b3a.88.2024.09.23.20.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 20:04:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ssvqn-009Fga-32;
	Tue, 24 Sep 2024 13:04:29 +1000
Date: Tue, 24 Sep 2024 13:04:29 +1000
From: Dave Chinner <david@fromorbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <ZvIsPe4JbJ7HX2sQ@dread.disaster.area>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>

On Mon, Sep 23, 2024 at 07:26:31PM -0700, Linus Torvalds wrote:
> On Mon, 23 Sept 2024 at 17:27, Dave Chinner <david@fromorbit.com> wrote:
> >
> > However, the problematic workload is cold cache operations where
> > the dentry cache repeatedly misses. This places all the operational
> > concurrency directly on the inode hash as new inodes are inserted
> > into the hash. Add memory reclaim and that adds contention as it
> > removes inodes from the hash on eviction.
> 
> Yeah, and then we spend all the time just adding the inodes to the
> hashes, and probably fairly seldom use them. Oh well.
> 
> And I had missed the issue with PREEMPT_RT and the fact that right now
> the inode hash lock is outside the inode lock, which is problematic.

*nod*

> So it's all a bit nasty.
> 
> But I also assume most of the bad issues end up mainly showing up on
> just fairly synthetic benchmarks with ramdisks, because even with a
> good SSD I suspect the IO for the cold cache would still dominate?

No, all the issues show up on consumer level NVMe SSDs - they have
more than enough IO concurrency to cause these CPU concurrency
related problems.

Keep in mind that when it comes to doing huge amounts of IO,
ramdisks are fundamentally flawed and don't scale.  That is, the IO
is synchonous memcpy() based and so consumes CPU time and both read
and write memory bandwidth, and concurrency is limited to the number
of CPUs in the system..

With NVMe SSDs, all the data movement is asynchronous and offloaded
to hardware with DMA engines that move the data. Those DMA engines
can often handle hundreds of concurrent IOs at once.

DMA sourced data is also only written to RAM once, and there are no
dependent data reads to slow down the DMA write to RAM like there is
with a data copy streamed through a CPU. IOWs, once the IO rates and
concurrency go up, it is generally much faster to use the CPU to
program the DMA engines to move the data than it is to move the data
with the CPU itself.

The testing I did (and so the numbers in those benchmarks) was done
on 2018-era PCIe 3.0 enterprise NVMe SSDs that could do
approximately 400k 4kB random read IOPS. The latest consumer PCIe
5.0 NVMe SSDs are *way faster* than these drives when subject to
highly concurrent IO requests...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

