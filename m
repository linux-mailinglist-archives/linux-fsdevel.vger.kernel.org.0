Return-Path: <linux-fsdevel+bounces-44920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A07E0A6E562
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D613BCA54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32641EE7C4;
	Mon, 24 Mar 2025 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="mkoFiDWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4891EFF98
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850477; cv=none; b=MfalxRjac9jCnTTT0bEjinbFOhp4SqUHV0Z+zluczjrM7Y6qlDvnie0QepkJ/pwh+t3MFFuJ1DWaBb+wbUoN24zBa74RR6aOHqlLjHQ8byMb8gGRlaHcP+NyPEB9G0qFNeo2VFBwA1fitCYA+DepCfcmMpS1gYABgz3vJPEyhVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850477; c=relaxed/simple;
	bh=4+jaryzPcQ12ZvI9RQnmYqDwxiUM2Ss9JeZ9IjK2aEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4AgL9vdrlGWbxAjeG7OQrQUjW2Z7vPPD83oFo+rZlxegmeuesnIVmGB/GjkLcbSUnHWgr0ro2TzDlLw/BnQ4ZBcZRCyms7xSxkk/KVUlr484/nTRwJ//h68xWv8mif5B4GD/LraPcXkPRUYR3X/ad1+E0OyIqNsEoLnDs0GNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=mkoFiDWX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22423adf751so90759365ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742850475; x=1743455275; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aVl4lakBwoWZF41jXp3J5+FdS/l6n2CEhMSYPi2Gqro=;
        b=mkoFiDWXKBWGyFclRoHJYhSsnsJIJNaa2tMIrG8W94DZAjj5Bz5MaK+m87AaMFaVtS
         z0UCQD6FHqAe4DgpyhEuzzzKmiu2EGsesZ+z6+/+CEDSgaBF/bK8hMk7/pH3ncmgMWJS
         6nBbaPnggH0Ni5Pludi++qHFpxFNRhh5S8tAP66BT6Y2taS9O38Hh4TyW6fpt12/+edi
         Wp5HxX4g83oLGPjTDqlq6THMpUfeUZmNKwRexVI9H/Mzp6lZJ1lPVZHmzO/Ye+Roedoo
         fuHgRo3CS/xxNd4tj9pp7/pgCQU15Sy0JtiarQsISe3J8kuwaVP1a8BYVuVt7bvChElT
         s0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742850475; x=1743455275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVl4lakBwoWZF41jXp3J5+FdS/l6n2CEhMSYPi2Gqro=;
        b=Y6dwibmSPU8KGZceyGbf98vaTWA5dSGBnj5/JyFT6SWT6TzN4RBdsnKyQoKGz3k0U3
         mhr4CBYtr6t0AzNL3UIR4I7N9EVY5ZSe6FvPQE6ArGqrcfDLVeyzg6XubmJ71MaJtoVr
         ced01p23kXUgmgzXsrFMtUzf8In4XSA4HSjbpvoNiA6Z6DdtlrNBlhN5PCY8+f+3J6Wj
         H943xaulz/EU88XhxOCBghWk1SYfyv0XCCmhCIQbO9YgQlJ7p972qy9w6eXofWPEVRYm
         2fyHXBPGbpDUPDc9w9k5s0AnpMSQseX4/s8086u8SCRxQoI3bGM+zPxvR91OQ+5kDNF+
         UlVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjqZdu92/Zu8VlvkZ53QFpszJHDRqcSU9ZHgVdlZt2pARU4L1H5t/K375ELJHg/E5rlgfruNUSiSuGjjbo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qpTcui0qLJjl3IThFK2jgmmni+fdP9j5kBeUiF+QkS38Zq0k
	jmIZVHoJS0TQqFZH1fgo92dTSAtgtgo5m0HxUdgmOltkzOQ9e3QOe4zteCbvUjI=
X-Gm-Gg: ASbGncs9hIgqkcg6zhouPXIYaVUQwPzBa8ko2u5XdrjCdWGenkvyWviwVJZwCDoxDsU
	9hVsS/su2faL9g4wq35dvyHSw54HZWCHl/xxJpsCuAxpJH5BjWffzy0kPE0pIrtkpbC2TwfbUiq
	dLam4hoHuKdgwowbRgyrQGCF1To4PPPZTBgHWR4TslQHThtvq7h0c4YwZtm94xoY2necrrzD0EE
	yHVJAZiOdKLGIABbjrdlTGadYBSlYxauXt6epX68JqnFPOUYV6gWXJU5XF9PjhwgPj8Cu94e8tx
	A/flke1Jn7qticydPZGvijlYDYKGefde+wt8KaWDXD7Zyg9JpKVJ07L1Y7/0ptZaZbeAV46EpNr
	l3KEAjaA8BkUTgpmsoH7N
X-Google-Smtp-Source: AGHT+IGBlddCZHNeQdFhYj/bvEzKbB+kc3uyNwp3f7ivS7rNy9g1PBas8hv90pYnHQsQK8CZ9ipArQ==
X-Received: by 2002:a05:6a20:430c:b0:1f5:9961:c44 with SMTP id adf61e73a8af0-1fe42f09264mr25955542637.3.1742850474958;
        Mon, 24 Mar 2025 14:07:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611c8afsm8508538b3a.111.2025.03.24.14.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:07:54 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1twp1U-0000000HQmN-0PkU;
	Tue, 25 Mar 2025 08:07:52 +1100
Date: Tue, 25 Mar 2025 08:07:52 +1100
From: Dave Chinner <david@fromorbit.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <Z-HJqLI7Bi4iHWKU@dread.disaster.area>
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
 <Z9xG2l8lm7ha3Pf2@infradead.org>
 <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
 <Z9z32X7k_eVLrYjR@infradead.org>
 <576418420308d2511a4c155cc57cf0b1420c273b.camel@HansenPartnership.com>
 <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
 <vnb6flqo3hhijz4kb3yio5rxzaugvaxharocvtf4j4s5o5xynm@nbccfx5xqvnk>
 <Z-HFjTGaOnOjnhLP@dread.disaster.area>
 <7f3eddf89f8fd128ffeb643bc582e45a7d13c216.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f3eddf89f8fd128ffeb643bc582e45a7d13c216.camel@HansenPartnership.com>

On Mon, Mar 24, 2025 at 05:02:54PM -0400, James Bottomley wrote:
> On Tue, 2025-03-25 at 07:50 +1100, Dave Chinner wrote:
> > On Mon, Mar 24, 2025 at 12:38:20PM +0100, Jan Kara wrote:
> > > On Fri 21-03-25 13:00:24, James Bottomley via Lsf-pc wrote:
> > > > On Fri, 2025-03-21 at 08:34 -0400, James Bottomley wrote:
> > > > [...]
> > > > > Let me digest all that and see if we have more hope this time
> > > > > around.
> > > > 
> > > > OK, I think I've gone over it all.  The biggest problem with
> > > > resurrecting the patch was bugs in ext3, which isn't a problem
> > > > now.  Most of the suspend system has been rearchitected to
> > > > separate suspending user space processes from kernel ones.  The
> > > > sync it currently does occurs before even user processes are
> > > > frozen.  I think (as most of the original proposals did) that we
> > > > just do freeze all supers (using the reverse list) after user
> > > > processes are frozen but just before kernel threads are (this
> > > > shouldn't perturb the image allocation in hibernate, which was
> > > > another source of bugs in xfs).
> > > 
> > > So as far as my memory serves the fundamental problem with this
> > > approach was FUSE - once userspace is frozen, you cannot write to
> > > FUSE filesystems so filesystem freezing of FUSE would block if
> > > userspace is already suspended. You may even have a setup like:
> > > 
> > > bdev <- fs <- FUSE filesystem <- loopback file <- loop device <-
> > > another fs
> > > 
> > > So you really have to be careful to freeze this stack without
> > > causing deadlocks. So you need to be freezing userspace after
> > > filesystems are frozen but then you have to deal with the fact that
> > > parts of your userspace will be blocked in the kernel (trying to do
> > > some write) waiting for the filesystem to thaw. But it might be
> > > tractable these days since I have a vague recollection that system
> > > suspend is now able to gracefully handle even tasks in
> > > uninterruptible sleep.
> > 
> > I thought we largely solved this problem with userspace flusher
> > threads being able to call prctl(PR_IO_FLUSHER) to tell the kernel
> > they are part of the IO stack and so need to be considered
> > special from the POV of memory allocation and write (dirty page)
> > throttling.
> > 
> > Maybe hibernate needs to be aware of these userspace flusher
> > tasks and only suspend them after filesystems are frozen instead
> > of when userspace is initially halted?
> 
> I can confirm it's not.  Its check for kernel thread is in
> kernel/power/process.c:try_to_freeze_tasks().  It really only uses the
> PF_KTHREAD flag in differentiating between user and kernel threads.
> 
> But what I heard in the session was that we should freeze filesystems
> before any tasks because that means tasks touching the frozen fs freeze
> themselves.

But that's exactly the behaviour that leads to FUSE based deadlocks,
is it not? i.e. freeze the backing fs, then try to freeze the FUSE
filesystem and the freeze blocks forever trying to write to the
frozen backing fs....

What am I missing here?

-Dave
-- 
Dave Chinner
david@fromorbit.com

