Return-Path: <linux-fsdevel+bounces-12626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDF0861DB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 21:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C1F2857A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 20:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B951474AB;
	Fri, 23 Feb 2024 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e91HMvYv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25388143C7B;
	Fri, 23 Feb 2024 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720752; cv=none; b=U75mVRt00f/IS6T6J4MfM397QrIeTHUAWnlbfjFgBdtCq/MMk7sW0nJoli3XFgdz5fD4IjGTJaV7Rt7e/dNVzeghzcRBQ5fHPwGpB1PLKfFJwtiTtZfgwToRqMNSJk1ska3BFTJz9T4OeadVX8CGEnRYicFimHJIzby07fTh+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720752; c=relaxed/simple;
	bh=CWvz0jJizpnSo4+DoPe5JFFbeGIyISNG6la+TKtI1kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqB9WQoSxb8LuX1OAaooOfL3x5Gqk/YbZn53XYOupTFFjhRwNZlHEpmclTPNDsIzxK1rIriRNmIsDvOP2x8i5pNNM6/a5VINpZ8oiqm9j+1O8g9zP/HnmQ/9azaOfVnM5Q/F7V/s6TCTGxoIVqmax1wVgq5WG1eO2V0RUSXX8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e91HMvYv; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e2d83d2568so866342a34.3;
        Fri, 23 Feb 2024 12:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708720750; x=1709325550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rFejooLE94dTKXiepySeCh8pNdPgmcVv6PgnIh1W7c=;
        b=e91HMvYvAUvNNqJPQHfiWcLcPCYOIiXmvVcfJby89fFrbHvFNrY+eVJrXSaF9zzXbK
         z7iyH1IPdFk/wYQKFiLVNTTBFHQiYd9chUXOLxbcgmkKiMjTgynoB0V5BSFGMpA93sXH
         TAbboOttpoAgDhT4ia5EEosFw6WNFcD0SNCUnzOBUplse8/mIS17n+Ybg6qefwnZqosS
         XHShdcPfW2yAoYa26LQm6YXrxaxS102ZpSpuu2RkC8kPT9afoQi7NybeO8f0+8wSqrvR
         ErJjH0eEFQq+FdMGbLJtwZ9oLE+oZCpsWOx5xmonYdpQZBap3xEvs3K5y1b9slNA2VGm
         koFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708720750; x=1709325550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rFejooLE94dTKXiepySeCh8pNdPgmcVv6PgnIh1W7c=;
        b=GKe69yNKfBkJy1881oyjali+VQ9P/YJu+vkumk1dTYVR7Z/VRYTef1vsVjhZewLr1f
         InfAlh6As4WKi4Xztd+gd8fGMbUB1OhT49V+aFGEjCRjzKG4HEhT09hNrNrG4/iuoQAn
         z+oi3ZYdVx3b+C0WVG0XZycOoB/jSHEkcgUbiG9C11sfWyEJU9Nko5MjnQ3OA/LqXNGY
         w+0YxaIVD+JrU43XA6v+TGbVieWoUJNkpTCF2MX2J2a+eGWGFx+yIeXqkEUhobRFYQhh
         x5CbK71wPRGqA+UghrVY3poNJA1vZkZyVYnt3K72rj7f4Yztp9yvQf470jl//ZEBHbXV
         QLUg==
X-Forwarded-Encrypted: i=1; AJvYcCUItbg78fm8vDsb+ghZJ7XJod+Kg9S1GUt+HBq4hrLb0FiTXBt/48IgLiPgwXhs5u7xalhtwZpS06uiy/xNFrRaJBSg9VxGc6Z6KD+u8Qi1+pjoOk91tRF3D7wqPZmlAwPW21hr5jUdRGtq7Ee4bSKdnUAj9cg65/RkAs4L2/HyEfUmxWBGFElSrkoA7GUlg7gnBDk3HjYQwSdOVDNsJBIXzw==
X-Gm-Message-State: AOJu0Yz+krSErHFAa850XUByuf5y7XmAmEUAJ/IndgLEVYRO7zCOSDTK
	7ZX3b380BySSAJ4KV32ZFSzoL/QrglXO4MIuOQWEiNkbDMSrsZUo
X-Google-Smtp-Source: AGHT+IHvVNjrfcKrmLp8J0RHHmkEdU6tIRc8D27FoJrKa2C7ggDQBJLV2BHA5c/4pF95RMFRkW2Ryg==
X-Received: by 2002:a05:6830:18e6:b0:6e4:8cb4:b4cc with SMTP id d6-20020a05683018e600b006e48cb4b4ccmr252402otf.1.1708720750269;
        Fri, 23 Feb 2024 12:39:10 -0800 (PST)
Received: from Borg-9 (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id ci3-20020a05683063c300b006e4878962ddsm193629otb.12.2024.02.23.12.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 12:39:09 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 23 Feb 2024 14:39:08 -0600
From: John Groves <John@groves.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 16/20] famfs: Add fault counters
Message-ID: <ytyzwnrpxrc4pakw763qytiz2uft66qynwbjqhuuxrs376xiik@iazam6xcqbhv>
References: <cover.1708709155.git.john@groves.net>
 <43245b463f00506016b8c39c0252faf62bd73e35.1708709155.git.john@groves.net>
 <05a12c0b-e3e3-4549-b02e-442e4b48a86d@intel.com>
 <l66vdkefx4ut73jis52wvn4j6hzj5omvrtpsoda6gbl27d4uwg@yolm6jx4yitn>
 <65d8fa6736a18_2509b29410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d8fa6736a18_2509b29410@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On 24/02/23 12:04PM, Dan Williams wrote:
> John Groves wrote:
> > On 24/02/23 10:23AM, Dave Hansen wrote:
> > > On 2/23/24 09:42, John Groves wrote:
> > > > One of the key requirements for famfs is that it service vma faults
> > > > efficiently. Our metadata helps - the search order is n for n extents,
> > > > and n is usually 1. But we can still observe gnarly lock contention
> > > > in mm if PTE faults are happening. This commit introduces fault counters
> > > > that can be enabled and read via /sys/fs/famfs/...
> > > > 
> > > > These counters have proved useful in troubleshooting situations where
> > > > PTE faults were happening instead of PMD. No performance impact when
> > > > disabled.
> > > 
> > > This seems kinda wonky.  Why does _this_ specific filesystem need its
> > > own fault counters.  Seems like something we'd want to do much more
> > > generically, if it is needed at all.
> > > 
> > > Was the issue here just that vm_ops->fault() was getting called instead
> > > of ->huge_fault()?  Or something more subtle?
> > 
> > Thanks for your reply Dave!
> > 
> > First, I'm willing to pull the fault counters out if the brain trust doesn't
> > like them.
> > 
> > I put them in because we were running benchmarks of computational data
> > analytics and and noted that jobs took 3x as long on famfs as raw dax -
> > which indicated I was doing something wrong, because it should be equivalent
> > or very close.
> > 
> > The the solution was to call thp_get_unmapped_area() in
> > famfs_file_operations, and performance doesn't vary significantly from raw
> > dax now. Prior to that I wasn't making sure the mmap address was PMD aligned.
> > 
> > After that I wanted a way to be double-secret-certain that it was servicing
> > PMD faults as intended. Which it basically always is, so far. (The smoke
> > tests in user space check this.)
> 
> We had similar unit test regression concerns with fsdax where some
> upstream change silently broke PMD faults. The solution there was trace
> points in the fault handlers and a basic test that knows apriori that it
> *should* be triggering a certain number of huge faults:
> 
> https://github.com/pmem/ndctl/blob/main/test/dax.sh#L31

Good approach, thanks Dan! My working assumption is that we'll be able to make
that approach work in the famfs tests. So the fault counters should go away
in the next version.

John


