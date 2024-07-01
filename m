Return-Path: <linux-fsdevel+bounces-22841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F7991D6F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 06:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB080281D16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 04:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6BF24A08;
	Mon,  1 Jul 2024 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xUdX3f89"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0BDDD8
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 04:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719807881; cv=none; b=V4TMY+BdbpM22SKRiyu4V7VF7qy9StTWTImgTJgl2G8SxgpoEse/TV0MRB0iOcEfN8f72YU6CVWU7gom6c8mDxdBc2O3wOwmwZ1ynl9FmrH4VN7BUmEA93HSZvNAqE1UUL8sb0mB4i2B4Ju7zx1AQ4/pFtbdv646AiLofwy44Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719807881; c=relaxed/simple;
	bh=paVAf+8j2Ao8wNZ6d9H4Go6mO+YeHszO+g9YMet+gN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts4XqlbGDAhBCKgm3M9TA97xbqd6X1xjQ1K2zR5RvP9kGniFtK9vV+ViAfcDhQ3EQr7r8vyQGZlhmGWvcyNFy/tfymdRBzEWNf5+79gbJk+IRh+FBKUWAghpzDDBInmqnK8JnAdLMm3sJ5tyqpC/cmCxH4QmLw8Lp7jq0Qi3JLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xUdX3f89; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa244db0b2so16471495ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jun 2024 21:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1719807880; x=1720412680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q8FaXxeW49XxQjIVoOOnJuKPW6Isofg2ljkc7tdAOtU=;
        b=xUdX3f897Grs5cWWuQ2CuoY+jfH5lwciBkIJtBCf7XHn5Vy6PLpf3Y0oEYflVH6KRZ
         cYzqRjL46Mhp7NxfpjavH3SLzSlx/uSa+Ln6e3xWzWkLpvU+SfWd11Q1NUXSphwk/a55
         6NmKjcHlf15ki8DBVRvoXxG9iAS8BoybM1PwJHIm2FC/Xyljt+0GJqf8Ngywja2J2Ww9
         D7HdBC8qSbQMyH3T7iDhdnoO18ctAczp+b2l/XZzsQNlAQ1DbgvNmMyhXtCE/zKg1CQ5
         RXhY8LPV6wTdbxdJutRYXNqMgvPmIWb0wLA295TCggO7vn7bIjBeCllNLk12n3yQw1Ko
         M1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719807880; x=1720412680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8FaXxeW49XxQjIVoOOnJuKPW6Isofg2ljkc7tdAOtU=;
        b=M94nG73W0Smsl7IYu5Yp9sab+UyEQPdD3XyrHmRigMXwZ3WTcvjkjn/RIn5p2Fd+YI
         JmXBImjmTciqmKVHjEodK//SLXbsw0iZXdop1ipYS8SbwvtnQC3Slw0HlWiAhS0/pe9Z
         c4HnxLRXxIKSZr4qUIHAXLlTCPD2lD9DMD8hdaArleic8LSh0Xu2g4Q88yhQb2dp3d77
         OaQt01Pbc4DhAs3cAuV0PIxgATGz3oKnlneM8QlKAS8MHNQKsdUkAuQIxh7DuKdpAED6
         61/aLgJs0Q6U+1p+kfAWk9rDAlpPkIRSORGluX4FIvj+kuRUB5Qc+LeOPzWEjdMJ4kPN
         NTpg==
X-Forwarded-Encrypted: i=1; AJvYcCX2eEMNrMuTEJ5CkIVVVM4eXpTv0dZ/id2eB/2r9pNeOdAjtP0K/3gOGkJhHrdCw8yjxZc6sPHNMczdKEp4mpr8eQquA0oTBdd/t4TseQ==
X-Gm-Message-State: AOJu0YwC654Frf9ud7p66fkc/QMDoiQmKeGLTa8wVnfbms6qT607W3Wj
	0C/bHkGzjtSZ273DRztT58nQlhSEjlMyLBYVwmkxeuUoNOAHEFpO8c+8SVMB0TQ=
X-Google-Smtp-Source: AGHT+IFKQ7mlIRHK3qLypxLI+wB6C/xuRboouR5zOv5/KrFwuLBxwDWk/1+R28Hzvt5tq0xC0UW+Zw==
X-Received: by 2002:a17:902:d2cc:b0:1fa:2d0:f85b with SMTP id d9443c01a7336-1fadbce9d59mr26040185ad.49.1719807879574;
        Sun, 30 Jun 2024 21:24:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1569051sm53926215ad.215.2024.06.30.21.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 21:24:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sO8ai-00HWNB-2Q;
	Mon, 01 Jul 2024 14:24:36 +1000
Date: Mon, 1 Jul 2024 14:24:36 +1000
From: Dave Chinner <david@fromorbit.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com, hch@lst.de
Subject: Re: [PATCH 00/13] fs/dax: Fix FS DAX page reference counts
Message-ID: <ZoIvhDvzMCw28VBI@dread.disaster.area>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>

On Thu, Jun 27, 2024 at 10:54:15AM +1000, Alistair Popple wrote:
> FS DAX pages have always maintained their own page reference counts
> without following the normal rules for page reference counting. In
> particular pages are considered free when the refcount hits one rather
> than zero and refcounts are not added when mapping the page.
> 
> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
> mechanism for allowing GUP to hold references on the page (see
> get_dev_pagemap). However there doesn't seem to be any reason why FS
> DAX pages need their own reference counting scheme.
> 
> By treating the refcounts on these pages the same way as normal pages
> we can remove a lot of special checks. In particular pXd_trans_huge()
> becomes the same as pXd_leaf(), although I haven't made that change
> here. It also frees up a valuable SW define PTE bit on architectures
> that have devmap PTE bits defined.
> 
> It also almost certainly allows further clean-up of the devmap managed
> functions, but I have left that as a future improvment.
> 
> This is an update to the original RFC rebased onto v6.10-rc5. Unlike
> the original RFC it passes the same number of ndctl test suite
> (https://github.com/pmem/ndctl) tests as my current development
> environment does without these patches.

I strongly suggest running fstests on pmem devices with '-o
dax=always' mount options to get much more comprehensive fsdax test
coverage. That exercises a lot of the weird mmap corner cases that
cause problems so it would be good to actually test that nothing new
got broken in FSDAX by this patchset.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

