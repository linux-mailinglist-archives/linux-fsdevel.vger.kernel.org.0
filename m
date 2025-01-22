Return-Path: <linux-fsdevel+bounces-39873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0DCA19A97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 22:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B111694BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 21:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDCE1C9DC6;
	Wed, 22 Jan 2025 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="gOUa9sVf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FBB1C8FD6
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737583113; cv=none; b=Bn413RAkiInyZlu97BOIekyXPclKoh0HArw7mJQaiQ++rkWvl+3iLeR1wi1TpPg2J5gunGPPlRXiaoXz+Min6Ea20REKWeVXAV5NJJ179wwXasIYWZfGGmjGMagkCTFbj6SS3m/bc+beqV5bsdTax4g9vmA5vTCfAXLJAftt+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737583113; c=relaxed/simple;
	bh=3SYl4+g1NDV+Zn9PgqRX7HmhqCL6eecegckdXkGBGQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Adw7hHjcJFheUivIRvJzxNxBxzM3j/svnzajZ9MPQoQxPT9uCMlNAZ6F3flYKX2DpU4NUWVL6ZvdA3rSEbJvkRAq+F8F+2O6S95WLTEG249MJNJe9W63aw8GaCEId84RXzOQHmROAwCyMtFjx3zg54l9fILjPg/f8WTCikqt0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=gOUa9sVf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2165cb60719so3038895ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 13:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737583111; x=1738187911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXvn1GAZum62eGt9FVKhSYNWM9rpkSfE7ZuGmpHTELc=;
        b=gOUa9sVf5VRMOjtstH4vTAcj5r0I91w7O1Ywz/O8Hu/hiWAy4xsv0Nr8rMIAZsd1+R
         uCd9Xx/ywuT5Bh5Gp3l8qTEXsv4iGCtN+HSoYU8mWfk+zwu4E/3hyijmnSi2YvA0fAs2
         UvM/9xBgE+1idJ48qwqrnOKL0GkruArS3w6GyQfTBNUJouU2qhsodKX9CBpgEPkScgEl
         Rv5Y0A4yRHJcV99fu4jG8XtO6SlHrQs3/zVpiCoo1abZyyjNKIGyuZulV5/T+PFxQ5mg
         PUpPHeh0yGQdXQLxplgmIZ+cGy4JTIXqzComc2/aAuMKOl1woOxt2S1patGtZaEQllTl
         jmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737583111; x=1738187911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXvn1GAZum62eGt9FVKhSYNWM9rpkSfE7ZuGmpHTELc=;
        b=dpJ4uiC7FBNcfHQ3WKGymFtBR16JctNtGzURmeRmIzWPnuYxfhj+nM2uAyIfnLqbyt
         so0u9GGHzxqcjyfakVIxO6dwbSZoXH+WpvYUlz/njfN07AYWMdkCiLX9xfWPM9szDY63
         ldIyKVj7LB2iDB9SXA9FkHpjASs5yV5tFQjqReiv9mEE1HV1t/HM0OR5PjOOObyxWDsm
         3swatveoSrYhh8/qEeXNwHetrvY4e0oyxW79DIaZDye5MtZWciVTLISJYTze7XqXaWDI
         L1XbYjzIKXrA8L1q160HHXZH3h30MWBtC8uFivys8VmSapDjqYGT8V8Cz5NzsLbobeb7
         pZsw==
X-Forwarded-Encrypted: i=1; AJvYcCVZJFrZMVal3j2lsFFgZUrW/h2kRchax3PYjI+9b1QG+VeYwG766FzJ5OBH+mdFtO9yolFMbUtNOxB3wG90@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRGp+NntuNXTYSACSgYX7dhh8b/raEzHBxGNpzrDbFFOE9clH
	e0E6Q9BBEmBe3KX5ayhHPyOhGhiIKWSwDtBdLbZ0qQKuXgoCjr0lZasdBVyJYj8=
X-Gm-Gg: ASbGnct6Ph26xkwZzUn2PD0mtqN5rhsOru4wU1n7lMe9pe0/V7+j5Bfy87+XxAVPay4
	lNHWqDYYm7UWiRdt2tqlngEKqofdb9ZV0VfjbmLOvum6Z9UNWtF63yZsOBZIHLL+yYspfHu3sdu
	eWEpaXeHkfXb5h7F4EO1v+O4fEc8ym0KavxutJbsR2CeTQGiMfPkiv+13Se4+a4sKd9cova/ncd
	y9FR9pCI1bzl0kvA/FwqgaofaWE/cmVF8q+7Rx0LuJf4v5T0Q6iogylReqJ0zey5kKXltao6ssJ
	trw3/70ujz82zbDmoisZrv6woYcLHR/ybDq6eh96IiyW3w==
X-Google-Smtp-Source: AGHT+IHpNXzEDizxXUaP+qhVhDGM/6CzcfsTvz8bGC6/q51aZ4HDAeIaKSo3aEqGYpR6Eyp0UlrLWg==
X-Received: by 2002:a05:6a20:a10c:b0:1d9:6c9c:75ea with SMTP id adf61e73a8af0-1eb21470203mr34616403637.5.1737583109417;
        Wed, 22 Jan 2025 13:58:29 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48cd0sm11735376b3a.131.2025.01.22.13.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 13:58:28 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1taijy-00000009FSe-1SgK;
	Thu, 23 Jan 2025 08:58:26 +1100
Date: Thu, 23 Jan 2025 08:58:26 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: djwong@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: xfs_repair after data corruption (not caused by xfs, but by
 failing nvme drive)
Message-ID: <Z5FqAgxiLbqI6gmz@dread.disaster.area>
References: <20250120-hackbeil-matetee-905d32a04215@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120-hackbeil-matetee-905d32a04215@brauner>

On Mon, Jan 20, 2025 at 04:15:00PM +0100, Christian Brauner wrote:
> Hey,
> 
> so last week I got a nice surprise when my (relatively new) nvme drive
> decided to tell me to gf myself. I managed to recover by now and get
> pull requests out and am back in a working state.
> 
> I had to reboot and it turned out that my LUKS encrypted xfs filesystem
> got corrupted. I booted a live image and did a ddrescue to an external
> drive in the hopes of recovering the things that hadn't been backed up
> and also I didn't want to have to go and setup my laptop again.
> 
> The xfs filesystem was mountable with:
> 
> mount -t xfs -o norecovery,ro /dev/mapper/dm4 /mnt
> 
> and I was able to copy out everything without a problem.
> 
> However, I was curious whether xfs_repair would get me anything and so I
> tried it (with and without the -L option and with and without the -o
> force_geometry option).
> 
> What was surprising to me is that xfs_repair failed at the first step
> finding a usable superblock:
> 
> > sudo xfs_repair /dev/mapper/dm-sdd4
> Phase 1 - find and verify superblock...
> couldn't verify primary superblock - not enough secondary superblocks with matching geometry !!!
> 
> attempting to find secondary superblock...
> ..found candidate secondary superblock...
> unable to verify superblock, continuing...
> ....found candidate secondary superblock...
> unable to verify superblock, continuing...

Yeah, so it's a 4 AG filesystem so it has 1 primary superblock and 2
secondary superblocks. Two of the 3 secondary superblocks are trash,
and repair needs 2 of the secondary superblocks to match the primary
for it to validate the primary as a good superblock.

xfs_repair considers this situation as "too far gone to reliably
repair" and so aborts.

I did notice a pattern to the corruption, though. while sb 1 is
trashed, the adjacent sector (agf 1) is perfectly fine. So is agi 1.
But then agfl 1 is trash. But then the first filesystem block after
these (a free space btree block) is intact. In the case of sb 3,
it's just a single sector that is gone.

To find if there were any other metadata corruptions, I copied the
primary superblock over the corrupted one in AG 1:

xfs_db> sb 1
Superblock has bad magic number 0xa604f4c6. Not an XFS filesystem?
xfs_db> daddr
datadev daddr is 246871552
xfs_db> q
$ dd if=t.img of=t.img oseek=246871552 bs=512 count=1 conv=notrunc
...

and then ran repair on it again. This time repair ran (after zeroing
the log) and there were no corruptions other than what I'd expect
from zeroing the log (e.g. unlinked inode lists were populated,
some free space mismatches, etc).

Hence there doesn't appear to be any other metadata corruptions
outside of the 3 bad sectors already identified. Two of those
sectors were considered critical by repair, hence it's failure.

What I suspect happened is that the drive lost the first page that
data was ever written to - mkfs lays down the AG headers first, so
there is every chance that the FTL has put them in the same physical
page. the primary superblock, all the AGI, AGF and AGFL headers get
rewritten all the time, so the current versions of them will be
immediately moved to some other page. hence if the original page is
lost, the contents of those sectors will still be valid. However,
the superblocks never get rewritten, so only they get lost.

Journal recovery failed on the AGFL sector in AG 1 that was also
corrupted - that had been rewritten many times, so it's possible
that the drive lost multiple flash pages. It is also possible that
garbage collection had recently relocated the secondary superblocks
and that AGFL into the same page and that was lost. This is only
speculation, though.

That said, Christian, I wouldn't trust any of the recovered data to
be perfectly intact - there's every chance random files have random
data corruption in them. Even though the filesystem was recovered,
it is worth checking the validity of the data as much as you can...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

