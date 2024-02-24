Return-Path: <linux-fsdevel+bounces-12648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B6886228A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 04:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0DF1F258EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 03:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C3614006;
	Sat, 24 Feb 2024 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXl7xbeR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E86FA9;
	Sat, 24 Feb 2024 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708746147; cv=none; b=UFg58CWXwWv5a4alSLqQ8VIwfgb6dYxZuqimhxv1BAjjpKixc2lcDSxwxLgJiAeBf+jeR+pZpIozPh6QgQiyLOEUO3L/KLS6Okcbt0W0Oj6S/+18aoT0spkCvDwv6kYh/w26XP+F5zQzflQrTdp46q88zV2H3jaIrZ95kerM3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708746147; c=relaxed/simple;
	bh=Mo84iZeMq5RPlHJjNVe7KdcGc2x7QyIrCKrw9vG9RqA=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=S6GQ3t3fsnh5ixvb7OoHR/WoML0iC7EbyAGvIs9TBJIh/hEmIHdvf3Kal7HsZmnaGtyYS35OWiA+BwrUtVBSy767QTwwRtJIKYVOBCeCGPj9YAjdyVQSMTmiB5bLfPWx9Nqmn8UFJtmYYUBVZQo4+JiJdwftsB0OHKDIUPjdk7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXl7xbeR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1db6e0996ceso11972805ad.2;
        Fri, 23 Feb 2024 19:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708746145; x=1709350945; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=82ndwq1r8iJGcKxdTGgyHwEUSv2EnlJPfsRhslovu74=;
        b=eXl7xbeRtfvcXZ5XZHa2mQL29BnEzu/7k6rTZoSFonpJRwBrJLjSSKZHIqZLEhz/Aj
         FZ2/1EqJxljlox+BM6tfU04IoDGdDppfLHibNN8oKZZevq3MAyasfj7k8LgFWuUTlXMb
         zgnbslmi/dZe5bfC4pmbk6FPLDjduHvuU51TP1neSds6cqD0cGenfXXaSCWCw5HGp3xS
         8uOk+GGzOm+rjncTeACcHgA8b120U3vFGlEok9EZjEIbiUsCi65eQ7UU2LfNp9YOEEyK
         +O014YScd7enER+FC6m9c7ZXSyKozYIHzmgBQBE6H7RM2XKsWP6nLmy49L7UM1a4y7ro
         e2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708746145; x=1709350945;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82ndwq1r8iJGcKxdTGgyHwEUSv2EnlJPfsRhslovu74=;
        b=KtKRseaXgK/zHolKuqzGfgcAopHtUViHIK6kpyCJCEbcaX4pdKMrsusnxUCif2kvnv
         daDhGebXbev/svyQ1LnSbh9Nk2zT8/dGQ6dx707wXdRw+MhCT5P3cTYkyekEX49/6ofF
         g9rXs6/0+SSGU5AYrXV8UUkPCcaZErJ9o2GRwcef+0CavDp1LBoydOzYTXQuvN3e3zuS
         XNU3eaaJq4HRVizi1Ufd/9GhKBDed8i0M35q+2kRGfKyBZ1O76U/QwHq1Phq/fJjpojS
         KHnPEs5j0ecunxw3L9UguRwm8WSnCgSuT7QtKjbV+hp5guMYkfivM80aefLOollj9B0w
         6/kg==
X-Forwarded-Encrypted: i=1; AJvYcCVjdiL5VLm44gLsM0Z8kAfgVT+eR/npzawBE81x6ogO6SoCuIHjiy8L/IAxT7Uld1XS78J7qFisacSw3C2/Fd2HU/x/JGB0D/4G3B0G4FN5a+94KBZFWCwTqgE+g+nZG1BSi/r35jV3s/rdln6WTmDUnDjXxS1X1rK5pOeEGjPv7+xX5MzgLIs0uxRcGOZE0jwSVKfF+Q17MjNoqXuB5VFqIG5G
X-Gm-Message-State: AOJu0YwJt/QYFfsPp0QuAIwvVx1eJ755MmOZYH0iJzWfJYUPk5qBfdyX
	Imwoybke7bNrV7hly1qjccjKkCBI3OhiDnklqfa4gB7CXnXwh5/p
X-Google-Smtp-Source: AGHT+IEQrDRKH+35dgIZBo9SO/pJ8MqThZb69DMu/QCthz0U4Ww5MeKnFffLUMrgfFg6rI1MgU0MVA==
X-Received: by 2002:a05:6a21:3403:b0:1a0:e19c:9631 with SMTP id yn3-20020a056a21340300b001a0e19c9631mr1437071pzb.59.1708746145125;
        Fri, 23 Feb 2024 19:42:25 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id pv6-20020a17090b3c8600b0029732fc0154sm2368207pjb.3.2024.02.23.19.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 19:42:24 -0800 (PST)
Date: Sat, 24 Feb 2024 09:12:11 +0530
Message-Id: <878r3acyuk.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, John Garry <john.g.garry@oracle.com>, Tso Ted <tytso@mit.edu>, "Martin K. Petersen" <martin.petersen@oracle.com>, Pankaj Raghav <p.raghav@samsung.com>, Daniel Gomez <da.gomez@samsung.com>, Matthew Wilcox <willy@infradead.org>, "kbus >> Keith Busch" <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Dave Chinner <david@fromorbit.com>, hch@lst.de, mcgrof@kernel.org
Cc: djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [LSF/MM/BPF TOPIC] no tears atomics & LBS
In-Reply-To: <ZdfDxN26VOFaT_Tv@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Luis Chamberlain <mcgrof@kernel.org> writes:

> At last year's LSFMM we learned through Ted Ts'o about the interest by
> cloud providers in large atomics [0]. It is a good example where cloud
> providers innovated in an area perhaps before storage vendors were
> providing hardware support for such features. An example use case was
> databases. In short, with large atomics databases can disable their own version
> of journaling so to increase TPS. Large atomics lets you  disabling things like
> MySQL innodb_doublewrite. The feature to allow you to disable this and use
> large atomcis is known as torn write prevention [1]. At least for MySQL the
> default page size for the database (used for columns) is 16k, and so enabling
> for example a 16k atomic can allow you to take advantage of this. It was also
> mentioned how PostgreSQL only supports buffered-IO and so it would be desirable
> for a solution to support buffered-IO with large atomics as well. The way
> cloud providers enable torn write protection, is by using direct IO.
>
> John Garry has been working on adding an API for atomic writes, it would
> seem some folks refer to this as the no-tears atomic API. It consists of
> two parts, one for the block layer [2] and another set of changes for
> XFS [3]. It enables Direct IO support with large atomics.  It includes
> a userspace API which lets you peg a FS_XFLAG_ATOMICWRITES flag onto a
> file, and you then create an XFS filesystem using the XFS realtime
> subvolume with with an extent alignment. The current users of this API
> seems to be SCSI, but obviously this can grow to support others. A neat
> feature of this effort is you can have two separate directories with
> separate aligment requirements. There is no generic filesystem solution
> yet.
>
> Meanwhile we're now at a v2 RFC for LBS support [4]. Although the LBS
> effort originally was a completely orthogonal effort to large atomics, it
> would seem there is a direct relationship here now worth discussing.
> In short LBS enables buffered-IO large atomic support if the hardware
> support its.
> We get both alignment constraints gauranteed and now ensure
> we use contigous memory for the IOs for DMA too it is built on using large
> folios. We expect NVMe drives which support support large atomics can
> easily profit from this without any userspace modification other than
> when you create the filesystem.
>
> We reviewed the possible intersection of both efforts at our last LBS cabal
> with LBS interested folks and Martin Peterson and John Garry. It is somewhat
> unclear exactly how to follow up on some aspects of the no-tear API [5]
> but there was agreement about the possible intersection of both efforts,
> and that we should discuss this at LSFMM. The goal would be to try to reach
> consensus on how no-tear API and how LBS could help with those
> interested in leveraging large atomics.
>
> Some things to evaluate or for us to discuss:
>
>  * no-tear API:
>    - allows directories to have separate alignment requirements
>      - this might be useful for folks who want to use large IOs with
>        large atomics for some workloads but smaller IOs for another
>        directory on the same drive. It this a viable option to some
>        users for large atomics with concerns of being forced to use
>        only large writes with LBS?
>    - statx is modified so to display new alignment considerations
>    - atomics are power of 2
>    - there seems to be some interest in supporting no-hardware-accel atomic
>      solution, so a software implemented atomic solution, could someone
>      clarify if that's accurate? How is the double write avoided? What are
>      the use cases? Do databases use that today?
>    - How do we generalize a solution per file? Would extending a min
>      order per file be desirable? Is that even tenable?

I would also be interested in this discussion. For e.g. let's also try
and bring below points in the agenda -

1. Like LBS, for systems with large page size 64k (PowerPC and ARM), we should
already be able to utilize the untorn/atomic writes if they format the
filesystem with a given blocksize (for DIO atleast).
I think we need not even use bigalloc in such case for ext4.
So what does it takes from Linux Filesystems to expose an interface
to user such that they can start utilizing it?
(Now this has a catch that the FS still needs to be formatted with a
given blocksize to utilize untorn writes.)

2. What others think on adding O_ATOMIC interface similar to O_DIRECT
such that applications don't need much changes? We should still have
RWF_ATOMIC for pwrites, but for open/read/write calls an O_ATOMIC will
be useful too.

3. Buffered-io is important for Postgres and I have been looking into it
from the perspective of supporting untorn writes for buffered-io as
well. It will be again easier maybe to start off with 64k pagesize
systems or by utilizing large folio support. This way we have less work
in managing multiple pages which needs to be written atomically.

4. We already have RFC for ext4 multiblock code to support aligned
allocations which can be used to plug in untorn Direct-io write support
to ext4 [1]

[1]: https://lore.kernel.org/linux-ext4/cover.1701339358.git.ojaswin@linux.ibm.com/


>
>   * LBS:
>     - stat will return the block size set, so userspace applications
>       using stat / statx will use the larger block size to ensure
>       alignment
>     - a drive with support for a large atomic but supporting smaller
>       logical block sizes will still allow writes to the logical block
>       size. If a block driver has a "preference" (in NVMe this would
>       be the NPWG for the IU) to write above the logical block size,
>       do we want the option to lift the logical block size? In
>       retrospect I don't think this is needed given Jan Kara's patches
>       to prevent allowing writes to to mounted devices [4], that should
>       ensure that if a filesystem takes advantage of a larger physical
>       block size and creates a filesystem with it as the sector size,
>       userspace won't be mucking around with lower IOs to the drive
>       while it is mounted. But, are there any applications which would
>       get the block device logical block size instead for DIO?
>     - LBS is transparent to to userspace applications
>     - We've verified *most* IOs are aligned if you use a 16k block size
>       but a smaller sector size, the lower IOs were verified to come
>       from the XFS buffer cache. If your drive supports a large atomic
>       you can avoid these as you can lift the sector size set as the
>       physical block size will be larger than the logical block size.
>       For NVMe today this is possible for drives with a large
>       NPWG (the IU) and NAWUFP (the large atomic), for example.
>
> Tooling:
>
>   - Both efforts stand to gain from a shared verification set of tools
>     for alignment and atomic use
>   - We have a block layer eBPF alignent tool written by Daniel Gomez [6]
>     however there is lack of interested parties to help review a simpler
>     version of this tool this tool so we merge it [7], we can benefit from more
>     eyeablls from experienced eBPF / block layer folks.
>   - More advanced tools are typically not encouraged, and this leaves us
>     wondering what a better home would be other than side forks
>   - Other than preventing torn writes, do users of the no-tear API care
>     about WAF? While we have one for NVMe for WAF [8] would
>     collaborating on a generic tool be of interest ?
>
> Any other things folks want to get out of this as a session, provided
> there is interest?
>
> [0] https://lwn.net/Articles/932900/
> [1] https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/storage-twp.html
> [2] https://lore.kernel.org/linux-nvme/20240124113841.31824-1-john.g.garry@oracle.com/T/#m4ad28b480a8e12eb51467e17208d98ca50041ff2
> [3] https://lore.kernel.org/all/20240124142645.9334-1-john.g.garry@oracle.com/
> [4] https://lore.kernel.org/all/20240213093713.1753368-1-kernel@pankajraghav.com/T/#u
> [5] https://lkml.kernel.org/r/20231101173542.23597-1-jack@suse.cz
> [6] https://github.com/dagmcr/bcc/tree/blkalgn-dump
> [7] https://github.com/iovisor/bcc/pull/4813
> [8] https://github.com/dagmcr/bcc/tree/nvmeiuwaf
>
>   Luis

