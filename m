Return-Path: <linux-fsdevel+bounces-46731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7392FA946C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 07:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04D73B8964
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 05:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C585F19E826;
	Sun, 20 Apr 2025 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lK1rxloC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F52134AC;
	Sun, 20 Apr 2025 05:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745128454; cv=none; b=aCSvCrCtAtjsZLvoQmujm/nnItWVPRCdV7G40lTGQyMblt2KO06oCNEfI9nAgVNxeOxM5ZwjewtzBYrQ0mCuQaN4GY+ujiCsuFfJCIbYQnttzdTalWifKMLQ2HpqROQcp2XqU+eTamXBW2TpQ95A89Qz82hVzjjbRQIUF/FR0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745128454; c=relaxed/simple;
	bh=EOPADxPB8mzvDWuBBryk3jf0cGpgZkuKCoMIkkcKOCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkXXz7pf34oaPK1iFG7Kdw/yrzmnvjd//58N3MXe2eTMaAW1AZF7G0GCIiRBLNo1ZjNXl4/VbR+MYf/U4oTP3hI/sBx2QvJHtI2T0ByMfQuufSK5eHdurxukzm3QL4Gkfd6jodBSELg34ParmYMo+RmYfbpSwHWI8fECuVGu338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lK1rxloC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XVMpZ3Xl+TwlbRZcZQYFM7MV6Zn8X/q7imYdXEt4H7k=; b=lK1rxloCb7Sgvev/0lTaqcxZ32
	rZ/nh5CXramOZVDm6qiaIK9uQPxui/xOQwp00bTYK1Hy6STQrY9mJfYD5qU+uk6YmyGLpbDLaRY6P
	+JJI/KMT4UsoVseGJV1R4NglePHRtRt4ntAU2NTpSpzg0ZVyaVb8yik4ZuS6Mfpp2AdWufkORPh3T
	QxwCM3mfF50T3XWbYMG//6GGmq4nGaf/9Z0CUMsp98h1RqEMpiKXczbJvHKynCGHRr4XrGV30k313
	4Cp8N6HJl1Qr7yopc942PV7EBPRFlzgGFH+kllsWZNhq+4Evh3K59c/gF+fSFOlI1vaXFkHx54cro
	KJjdYfeg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6Nd0-0000000Bhqu-2KHh;
	Sun, 20 Apr 2025 05:54:06 +0000
Date: Sun, 20 Apr 2025 06:54:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Chanudet <echanude@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Alexander Larsson <alexl@redhat.com>,
	Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250420055406.GS2023217@ZenIV>
References: <20250408210350.749901-12-echanude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408210350.749901-12-echanude@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
> Defer releasing the detached file-system when calling namespace_unlock()
> during a lazy umount to return faster.
> 
> When requesting MNT_DETACH, the caller does not expect the file-system
> to be shut down upon returning from the syscall.

Not quite.  Sure, there might be another process pinning a filesystem;
in that case umount -l simply removes it from mount tree, drops the
reference and goes away.  However, we need to worry about the following
case:
	umount -l has succeeded
	<several minutes later>
	shutdown -r now
	<apparently clean shutdown, with all processes killed just fine>
	<reboot>
	WTF do we have a bunch of dirty local filesystems?  Where has the data gone?

Think what happens if you have e.g. a subtree with several local filesystems
mounted in it, along with an NFS on a slow server.  Or a filesystem with
shitloads of dirty data in cache, for that matter.

Your async helper is busy in the middle of shutting a filesystem down, with
several more still in the list of mounts to drop.  With no indication for anyone
and anything that something's going on.

umount -l MAY leave filesystem still active; you can't e.g. do it and pull
a USB stick out as soon as it finishes, etc.  After all, somebody might've
opened a file on it just as you called umount(2); that's expected behaviour.
It's not fully async, though - having unobservable fs shutdown going on
with no way to tell that it's not over yet is not a good thing.

Cost of synchronize_rcu_expedited() is an issue, all right, and it does
feel like an excessively blunt tool, but that's a separate story.  Your
test does not measure that, though - you have fs shutdown mixed with
the cost of synchronize_rcu_expedited(), with no way to tell how much
does each of those cost.

Could you do mount -t tmpfs tmpfs mnt; sleep 60 > mnt/foo &
followed by umount -l mnt to see where the costs are?

