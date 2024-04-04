Return-Path: <linux-fsdevel+bounces-16137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6C78990ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 00:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9860A289072
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E5913C3D9;
	Thu,  4 Apr 2024 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SvSU3HHb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92413BAEB;
	Thu,  4 Apr 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268078; cv=none; b=pCbvaxAy7z5T5Yz+b7LLe1eoyLYEz5M6TU+pDI7zvoXkcq8H86qAm4j0OAEz8bbrgrHnl1w1fqFSatUNS2rypS0UY3aMB1BjUfIf4FuqFEBKV1p5mORanwCHH8V/qdSxAL+ZMvgGK84DX+Zn7LwmL1M1JuBtzr8JZsH5lWch+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268078; c=relaxed/simple;
	bh=6QN77bM5eaKWq592iQn7Zfbv1Ht+etn+Tqg/2FEHFoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpTc228pxFFCiIr7Zys0N8ScGrI0TtsYGrxt/LcK6daidyHr0CPwcPpXF8IYPttVb1KCsOOfgXEVvU3tsPHhl+Pq2DCf030wuMGhJdNXPWQHjv4Uv6qJun0G83rmkGY53ki2kOohyy8YF1uAmFM0o9gLuFnprUKH2bnhOB4hWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SvSU3HHb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5GxWmiEW8cxRUvYpr6QE/44g8xV+AEZ5YGPD0FX451A=; b=SvSU3HHbitU7Sm0vaC2Gbie+g1
	sAgr23TjHvoIlqpobR5T5/90hjdhQ6shFrov4ee1f8i/p1nLbpsYwS1EsWogUTPh0L5+9qzFB1GTg
	YIo4tCKvESp+K51GQGcsB+SQPfNvu4idwZI5ZyBfbsSN78JY+0yXAaZIJsfvDtpc/oIqzaliUoFHI
	HV3RA0+32e0/GD3rXLtQG0dLJH4mYTJVeIvPjrbGKiWZYmhorc1slpRwojKS0QCl8Iv34Yc1w4CEW
	f8eanWfn9yxsqm+V9p0sNqYSeqzpKtRNIsFvd+XlWZTq3SLxE8GVdtOsl4BO10l6ZgpAI3rlaj7y9
	kgH5WAnA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsV8u-005rD2-2G;
	Thu, 04 Apr 2024 22:01:08 +0000
Date: Thu, 4 Apr 2024 23:01:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tj@kernel.org, valesini@yandex-team.ru,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240404220108.GT538574@ZenIV>
References: <00000000000098f75506153551a1@google.com>
 <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV>
 <20240404082110.GR538574@ZenIV>
 <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 04, 2024 at 12:33:40PM +0300, Amir Goldstein wrote:

> This specifically cannot happen because sysfs is not allowed as an
> upper layer only as a lower layer, so overlayfs itself will not be writing to
> /sys/power/resume.

Then how could you possibly get a deadlock there?  What would your minimal
deadlocked set look like?

1.  Something is blocked in lookup_bdev() called from resume_store(), called
from sysfs_kf_write(), called from kernfs_write_iter(), which has acquired
->mutex of struct kernfs_open_file that had been allocated by
kernfs_fop_open() back when the file had been opened.  Note that each
struct file instance gets a separate struct kernfs_open_file.  Since we are
calling ->write_iter(), the file *MUST* have been opened for write.

2.  Something is blocked in kernfs_fop_llseek() on the same of->mutex,
i.e. using the same struct file as (1).  That something is holding an
overlayfs inode lock, which is what the next thread is blocked on.

+ at least one more thread, to complete the cycle.

Right?  How could that possibly happen without overlayfs opening /sys/power/resume
for write?  Again, each struct file instance gets a separate of->mutex;
for a deadlock you need a cycle of threads and a cycle of locks, such
that each thread is holding the corresponding lock and is blocked on
attempt to get the lock that comes next in the cyclic order.

If overlayfs never writes to that sucker, it can't participate in that
cycle.  Sure, you can get overlayfs llseek grabbing of->mutex of *ANOTHER*
struct file opened for the same sysfs file.  Since it's not the same
struct file and since each struct file there gets a separate kernfs_open_file
instance, the mutex won't be the same.

Unless I'm missing something else, that can't deadlock.  For a quick and
dirty experiment, try to give of->mutex on r/o opens a class separate from
that on r/w and w/o opens (mutex_init() in kernfs_fop_open()) and see
if lockdep warnings persist.

Something like

        if (has_mmap)
                mutex_init(&of->mutex);
        else if (file->f_mode & FMODE_WRITE)
                mutex_init(&of->mutex);
	else
                mutex_init(&of->mutex);

circa fs/kernfs/file.c:642.

