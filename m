Return-Path: <linux-fsdevel+bounces-12624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F2E861D0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 20:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E5B1C24CB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 19:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B361A145FFB;
	Fri, 23 Feb 2024 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbbQdQDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E01448F3;
	Fri, 23 Feb 2024 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718207; cv=none; b=R0bGiSsb/uMHzlt0IYaKEiOldtXN1T9NkpOV/TOmKXR0h+Kv/xcPCGqN/pff+S1ZvQLN54weGSpqForjL/nV17E9nuzSRSKVCrgVV6w9f0OCMzgqusOL8ZI08/TR8JdCkQZfiaBkptmYQ7sBzl0mtezIiUAHzL95/qICntmJfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718207; c=relaxed/simple;
	bh=V5uXT1I1WxLZr1gVzh31tRJlTZrs2HDa7enKzhMqPFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2rULxQ2sPusbVDmWD1dFyU7f+T1AeNR5ZNrzUpE/Qax6Ob4QwB3zo5+UUkGqrMO2EUmUrhQlgrOOsJNfBMaF2ZNuovwyS+de+rhyL/AiJLPg9smc3GGBn4Eb2IedmDlX+cmNZUeo1hfCQsmxL7qWFwC/jxPFetqnKHUenLRNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbbQdQDD; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so773509b6e.3;
        Fri, 23 Feb 2024 11:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708718204; x=1709323004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Smi/Sp7XgkONWFBICEY7Pi/t1Ktm49FpndchyfXCKuA=;
        b=RbbQdQDDCDWuVZB19hVQYaQUxPUqH2DZOMnyjvJy/C4sA1mEg92ezQnaDsdfR4LeWT
         2ld0HsEfKKpgzmOpwtEAvRPBrRkeukKsb4uNtkWg+2CFbTUtWpsNv5C7f0F8IwI1E2fA
         rCoMWvsdQaY+BJpZPBj9hFHJP+KbtiNfaWkjEM2aeSHQ8SFu876RN92K3HeeW7DjX/5c
         Ql2Kc33U8M3yZNyQk36syxgS+XExa4KzPlWEmSo/H1g8nJQqSVnG/COK96KpvIeLm+dr
         w5cMK7ry2/8QInE+MQ4Tfc16LgVSow1mXz6ZOpAnslLlzmg1g7JeWGGMenz1G9uS2DUt
         rJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708718204; x=1709323004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Smi/Sp7XgkONWFBICEY7Pi/t1Ktm49FpndchyfXCKuA=;
        b=mqeGlQX/vvt0hJwGN8lG3uRZs5sGbKgk5f2wSBewXvcrkiFYPdABRvb2wbznr8uPt1
         au+wqdngzgTgw1kP1n6R+HFaZzIAz+TebAq1D/vh0WEOiN8NoPPCg486BvpT/KUwc689
         EmEAZV+Lf1EHbYEOOkLarANUWdYX8kL6GJw1FCwAYkCuW1Jb6y4rDTW8w1OHVH1KBipd
         h8ctm71m5GMxZBn7Y8BCOOIGbqhzq4FETtANhufhSB4jqZI9pChHuVmy35oNZjAhy61t
         hZJwKLwRlaC7v3PrgaF0/dQKTG1BPVJgQbl954y+yGKaS4LKllk7z97yDxS95jggPlLL
         Mh8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbDTF+2jtANMZvRglZ1o5a6sVIbYxJCRI2zoY6lrRJe6FhSfn5GJXr718ZvV0x/5IVU+NUwpTl1074hdiIHg0KPrRIostg2V6uE84jWZjRokr7FWiLlIdCaxbMQE5zNCaMZOU2r9zfs9zOnyJ8dRjOV7d36l9x6sKkuzDZvBRLUmXUMfn4tcgauPJIwcRMlzFjFnzXm0NDWp2wWZ3g5BDyrQ==
X-Gm-Message-State: AOJu0YziA6tKLpc8PnIfe5d1JgeOIRdsV1u6xDFSiS77hqO8ORtHoNYs
	dlzODiliaqiu5+wQwbIlTm8vLkEcHgn7HjYmmrwLOWHwNdamSeNI
X-Google-Smtp-Source: AGHT+IHv5O7Zzjo9iR5rZ4wp2Y09L1nqF5uadiqzZbbKIzO71izmp6TPS4UCh8sTcVQ34stK3LQaXA==
X-Received: by 2002:a05:6870:b250:b0:21e:7a1d:b4ec with SMTP id b16-20020a056870b25000b0021e7a1db4ecmr939717oam.7.1708718204401;
        Fri, 23 Feb 2024 11:56:44 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id gq19-20020a056870d91300b0021e8424e466sm3680600oab.25.2024.02.23.11.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 11:56:44 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 23 Feb 2024 13:56:42 -0600
From: John Groves <John@groves.net>
To: Dave Hansen <dave.hansen@intel.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 16/20] famfs: Add fault counters
Message-ID: <l66vdkefx4ut73jis52wvn4j6hzj5omvrtpsoda6gbl27d4uwg@yolm6jx4yitn>
References: <cover.1708709155.git.john@groves.net>
 <43245b463f00506016b8c39c0252faf62bd73e35.1708709155.git.john@groves.net>
 <05a12c0b-e3e3-4549-b02e-442e4b48a86d@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a12c0b-e3e3-4549-b02e-442e4b48a86d@intel.com>

On 24/02/23 10:23AM, Dave Hansen wrote:
> On 2/23/24 09:42, John Groves wrote:
> > One of the key requirements for famfs is that it service vma faults
> > efficiently. Our metadata helps - the search order is n for n extents,
> > and n is usually 1. But we can still observe gnarly lock contention
> > in mm if PTE faults are happening. This commit introduces fault counters
> > that can be enabled and read via /sys/fs/famfs/...
> > 
> > These counters have proved useful in troubleshooting situations where
> > PTE faults were happening instead of PMD. No performance impact when
> > disabled.
> 
> This seems kinda wonky.  Why does _this_ specific filesystem need its
> own fault counters.  Seems like something we'd want to do much more
> generically, if it is needed at all.
> 
> Was the issue here just that vm_ops->fault() was getting called instead
> of ->huge_fault()?  Or something more subtle?

Thanks for your reply Dave!

First, I'm willing to pull the fault counters out if the brain trust doesn't
like them.

I put them in because we were running benchmarks of computational data
analytics and and noted that jobs took 3x as long on famfs as raw dax -
which indicated I was doing something wrong, because it should be equivalent
or very close.

The the solution was to call thp_get_unmapped_area() in
famfs_file_operations, and performance doesn't vary significantly from raw
dax now. Prior to that I wasn't making sure the mmap address was PMD aligned.

After that I wanted a way to be double-secret-certain that it was servicing
PMD faults as intended. Which it basically always is, so far. (The smoke
tests in user space check this.)

John

