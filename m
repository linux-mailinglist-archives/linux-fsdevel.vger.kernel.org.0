Return-Path: <linux-fsdevel+bounces-12736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBDE866734
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 01:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235DB1F214DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B373D71;
	Mon, 26 Feb 2024 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GponSIXU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4164804
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708906248; cv=none; b=MDI5yKdMjVEDtMVsGXGZnVSXhfnRK3YKtk3zZtYI42T/WHzGm/mAn+IoSzkkkjspVuM05HZJew0vkBwIfqdsaRdYw3in7YYfhzBWj97VXg6OiF+cvrSLff+Arxk+LfjRoyJIC/twpRdqCSGBMQW7LUL/aAin5+VPEnaDFRqO64Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708906248; c=relaxed/simple;
	bh=GYBif4eHHYK1VBAeXhKURSAbsWCLixxMn/+30N10GqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKiTSAcO1uEAi90rsEatItFaCagsWzYCqyUFyO/W5nAkNFKZ2swQLUTg/tMhKsGRnSxfbT2TumSV/uswb535CJhVq1fTfF5kF/YutTqKB5Wf5FNCCU2p8/NuYdJUJcQ5raIaUNqfzs7LUyJgZHM4Tb1G1yaiO1PhLoEzR4k6deI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GponSIXU; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2518756a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 16:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708906246; x=1709511046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kj3tL2ojtrovMn5GzkeggiQFgfU3mHccbBEaky3cDrE=;
        b=GponSIXU0PtTlbcGZVY+04F9/RA5vbLFOTmfarRES6zSFh4wBizKT8IGgt1HgKEttj
         GPzJEUM2MUq5Ys9cyzGFpgWUp6TGDqJtj4dmncGYbpFJm3TlovKg8oThngzrqzP/4cxU
         owbbxtOLgVao/RuP/BpRl2oBPr4R7wQRYfU/I8cTN90kC37MwG3S4Q3QytxprqKVCJET
         I5RAOaQY+6+5/AP52z9WTQJyLk6Xwc1qWgO1cWZO+YKY3RjGZ1jfGdO53Z2O84PTXONL
         jVHXP1wzDGGdBYsIaNW6ssM7FjmuWFJeWe327xmSCOgYu4ZwGDGqyLublCdIE7g+MJC+
         GdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708906246; x=1709511046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kj3tL2ojtrovMn5GzkeggiQFgfU3mHccbBEaky3cDrE=;
        b=DyX0GHFpqhm+SFUuUwru+U3G4GU30xut2m/0thp5bMDUrzh0+drgAnIXujkqlGAAMq
         g7G+Gsv1Aq5GyM+ZyN5v4uq/WcLZCFqQkG17trO3zlQ4WrXT7NFRDtGPCb7ttZX7ccVk
         kzUy+bkzJ8rppqIG6w7+l66eslPQhVS2TCiyXBsc8W1vJYmkDEBeVYXteN6RHbC8+k3Q
         HFArHC4gQcm16bEdwDjUeI0A28H4Im2HKzcaiVvsmPr+rvnFqWP46ygzvcpmDp8hXI16
         i+lBMx8Pp9zIEBooDmmajjTK23pMvshgj+9howwBin2gQY8Ta1mbfhOdcycN7bEkC+/Y
         x3ow==
X-Forwarded-Encrypted: i=1; AJvYcCU2CtNTnOkIIwCdVY6dyDqo98u0TWFtdUgIMStfKGxMQltSYcGZAx2kxbfSPLe4b2k/XJjMOt+3aT3b5Inpe0VyBIoEDcUU7hgis3ND5Q==
X-Gm-Message-State: AOJu0YzDaQqq9YVTQq1+2WiAKpPgFZLHIqn3LX7sq0PRKr86EGFYn2kQ
	CsZRAZkC0zFQQn7bnLTb2MQ7dmWLzGF9b3sjoAgYRCJaZqXKwqz69qOYcIyf+W0=
X-Google-Smtp-Source: AGHT+IFZ8EbjLI7WkBtuaOZd19M5TAQKAFtl3kAlXGLmwfVVBaFV/tBsSmlNW82La8HLKnY8/R7gNQ==
X-Received: by 2002:a17:903:189:b0:1dc:692:2843 with SMTP id z9-20020a170903018900b001dc06922843mr8247359plg.5.1708906245699;
        Sun, 25 Feb 2024 16:10:45 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902d65100b001dca68a8a00sm219151plh.139.2024.02.25.16.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 16:10:45 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1reOZu-00BWTP-1n;
	Mon, 26 Feb 2024 11:10:42 +1100
Date: Mon, 26 Feb 2024 11:10:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, John Garry <john.g.garry@oracle.com>,
	Tso Ted <tytso@mit.edu>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	"kbus @pop.gmail.com>> Keith Busch" <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>, hch@lst.de, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	chandan.babu@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, jbongio@google.com,
	ojaswin@linux.ibm.com
Subject: Re: [LSF/MM/BPF TOPIC] no tears atomics & LBS
Message-ID: <ZdvXAn1Q/+QX5sPQ@dread.disaster.area>
References: <ZdfDxN26VOFaT_Tv@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdfDxN26VOFaT_Tv@bombadil.infradead.org>

On Thu, Feb 22, 2024 at 01:59:32PM -0800, Luis Chamberlain wrote:
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
>
> We get both alignment constraints gauranteed and now ensure
> we use contigous memory for the IOs for DMA too it is built on using large
> folios. We expect NVMe drives which support support large atomics can
> easily profit from this without any userspace modification other than
> when you create the filesystem.

If we combine atomic writes with buffered writeback then we create a
major IO constraint: *all* writes must be atomic in this sort of
setup because we cannot allow multi-sector writes to be torn
randomly in the middle of *any* sector. i.e.  the driver needs to
telling the block device that it's maximum IO size is limited by the
max atomic write size the device supports.

With that constraint in place, I don't see how the page cache or
filesystem needs to care about how the underlying storage device
provides it's atomic sector sized IO. If the underlying device uses
atomic writes, then it needs to set up all it's published IO
constraints that are used by filesystems to build bios around the
limitations of atomic writes.  And that bleeds into userspace as
well - it needs to know the sector sizes so it can set up the
filesystem correctly in the first place.

Hence I think there is -zero- overlap between LBS and atomic writes.
Yes, a device can provide a larger sector size via atomic write
support, but that's orthogonal to LBS infrastructure. All the device
needs to do is to set all of the device limits to be based on atomic
write constraints. Nothing else in the kernel or userspace needs to
care, and then the driver can simply add the REQ_ATOMIC flag to all
the write IOs itself....

Note that I'm not talking about IOCB_ATOMIC here: the page cache
doesn't give any guarantees about atomic write semantics. e.g. reads
are allowed to race with writes to the same folio, "atomic" user
writes that span folios can be written back independently (even
whilst the write() is in progress!) breaking the atomicity that
userspace specified.

Hence if we want IOCB_ATOMIC for buffered writes, the first problem
that needs to be solved is providing guaranteed stable atomic write
semantics through the page cache right down to the async writeback
code.....

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

But I like to cry.

>    - allows directories to have separate alignment requirements
>      - this might be useful for folks who want to use large IOs with
>        large atomics for some workloads but smaller IOs for another
>        directory on the same drive. It this a viable option to some
>        users for large atomics with concerns of being forced to use
>        only large writes with LBS?

We can already do that with extent size hints in XFS.

>    - statx is modified so to display new alignment considerations
>    - atomics are power of 2
>    - there seems to be some interest in supporting no-hardware-accel atomic
>      solution, so a software implemented atomic solution, could someone
>      clarify if that's accurate? How is the double write avoided? What are
>      the use cases? Do databases use that today?

Christoph's proposal for XFS involves using existing internal
copy-on-write infrastructure for IOCB_ATOMIC writes. i.e. it uses
the filesystem journal to do the atomic swap of the new data extent
in place of the old one.

>    - How do we generalize a solution per file? Would extending a min
>      order per file be desirable? Is that even tenable?

AFAIA, this is already the plan with XFS via a FORCE_ALIGN inode
flag in conjunction with extent size hints.

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

This is just how the page cache and filesystems behave according to
sector and block size constraints defined by the block device and
mkfs. I'm not sure what you're asking that we comment on or discuss
here...

> Tooling:
> 
>   - Both efforts stand to gain from a shared verification set of tools
>     for alignment and atomic use
>   - We have a block layer eBPF alignent tool written by Daniel Gomez [6]
>     however there is lack of interested parties to help review a simpler
>     version of this tool this tool so we merge it [7], we can benefit from more
>     eyeablls from experienced eBPF / block layer folks.

Running and maintaining eBPF tools on development systems running
custom kernels is a PITA in my experience.

Wouldn't it be better just to add block tracepoint analysis filters
to things like trace-cmd? We already have tracepoints that expose
all the IO operations like queuing, merging, dispatch, etc that
users are familiar with and have scripts and tooling written for.
Adding a filter that calculates IO alignment for traces during
report generation would by much more useful for IO analysis in
general as understanding these behaviours is not specific to atomic
writes.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

