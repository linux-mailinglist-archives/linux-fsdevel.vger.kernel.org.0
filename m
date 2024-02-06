Return-Path: <linux-fsdevel+bounces-10522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95D84BEED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 21:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1A71C22CA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 20:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C631B94D;
	Tue,  6 Feb 2024 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IJa7jKPm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F191B941;
	Tue,  6 Feb 2024 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707252621; cv=none; b=RGtl9TWAedizv8K80u1GYLkme6EOzLoYqWXxRUUalf8Bw6A4+P3fIMu5oNEExhPxKNSIzf3QGIGMR3i4DUTpf9rTkfPMDFsP39VgUTca2IeFBh3Ef3Rlf4rK37cu80TBpSD2HhEH8jA3REKYC8XHXgJtHMNUByw9qPi6cMaTQLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707252621; c=relaxed/simple;
	bh=knWcBAhY/RN4SzvGeW5Z8yXWAL3FGRCJ0j8BoXZiDtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvM59xs82q2vvQnG8jT5DS79otpe/Qr3+gpzj5IRyMraQQJ1ZpjQqOuBfQttMm59jOx7Ia3bFMpKYd6jGIjUq911kQP0cqAMAYxQAyS2e1gHHcI5ldC2CJWQ2vQw1SJWMR40pOxymb8X/5b6AjVdZ6ls0NEeM9uWmjGKtDZWb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IJa7jKPm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5RnTcGMZ9Fnqw/5A9a+zyo/aV++3sTlK5wnBXsTtPOw=; b=IJa7jKPmSatudnLcE2I9lQmSVX
	8Vu8xXYq3RjnYKu2uZEEBQ8wzQ1h4042wvPQBXqRl/B48nE40rzPdKLNr/ehQvIHhkQlhNx6dXAIL
	8hRebSMIK8R9YArSx156eelbbNX9XqysDII0YseA+SbK0S8dI8hNz9r4SEWarqyQ5SBApXI6klZye
	4Z3ShSF3zfvLIYuumrW9Pid54F1O4fTRV1bkwvxNNQeox/nP/rZfl0TNlkQe99Kc1g7XYGChlnBu8
	eZKlA1sqCeOXN0XNLidQeR1TnGWiqwf8LBFVd/HI6up/XHcUw+9l2h8ZODfYyt4fq/b02B8/WbOBd
	gGxAayqQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rXSOU-002YDN-0g;
	Tue, 06 Feb 2024 20:50:14 +0000
Date: Tue, 6 Feb 2024 20:50:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Calvin Owens <jcalvinowens@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Infinite loop in cleanup_mnt() task_work on 6.3-rc3
Message-ID: <20240206205014.GA608142@ZenIV>
References: <ZcKOGpTXnlmfplGR@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcKOGpTXnlmfplGR@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 06, 2024 at 11:52:58AM -0800, Calvin Owens wrote:
> Hello all,
> 
> A couple times in the past week, my laptop has been wedged by a spinning
> cleanup_mnt() task_work from an exiting container runtime (bwrap).
> 
> The first time it reproduced was while writing to dm-crypt on nvme, so I
> blew it off as a manifestation of the tasklet corruption. But I hit it
> again last night on rc3, which contains commit 0a9bab391e33, so that's
> not it.
> 
> I'm sorry to say I have very little to go on. Both times it happened, I
> was using Nautilus to browse around in some directories, but I've tried
> monkeying around with that and had no luck reproducing it. The spinning
> happens late enough in the exit path that /proc/self/ is gutted, so I
> don't know what the bwrap container was actually doing.
> 
> The NMI stacktrace and the kconfig I'm running are below. The spinning
> task still moves between CPUs. No hung task notifications appear except
> for random sync() calls happening afterwards from userspace, which all
> block on super_lock() in iterate_supers(). Trying to ptrace the stuck
> process hangs also hangs the tracing process forever.
> 
> I rebuilt with lockdep this morning, but haven't seen any splats, and
> haven't hit the bug again.
> 
> Please let me know if you see anything specific I can test or try that
> might help narrow the problem down. Otherwise, I'll keep working on
> finding a reliable reproducer.

Check if git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #fixes

helps.

