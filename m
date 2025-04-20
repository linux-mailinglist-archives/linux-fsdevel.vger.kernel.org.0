Return-Path: <linux-fsdevel+bounces-46729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4B0A946B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 06:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CC13B7C5E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 04:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D33515A86B;
	Sun, 20 Apr 2025 04:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qP0sd6jx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06715258A;
	Sun, 20 Apr 2025 04:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745123063; cv=none; b=N8wyDw445OoPs7gOSA9jh/YK0qSQ18oMAqPyU8/ZwxYU/onYawrPWRlreyLu8wRKOUxsIhNuA+g6n52rdava0OTrDWN9p/9fet+nQqVnnXhdpQeoAVutWg0vQo4ipTpiWIiERSwhyrWzQnHqF9LKIc7Ixcbke2IRn2uS5KAk/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745123063; c=relaxed/simple;
	bh=qpGp/hvCdpddsSQAiFEZtJs+MZRgmSA06DPH9WGl5Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwDXDeEO0FiKo69eSi/NVhFpWTqW3s9yv4kpluxXn47xi7KOZS6DYmVkCq5x0qQvhWi1vhamTTg+VTCemOHPgL1log9I2B4BdSD1LHiKTMCR7PwVRaI4cvAlmqIZ+2jq6i9Wzlupk48LU54r7aQFoh7D6hDZm/aDo/Nf7rifAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qP0sd6jx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EXpjqqkYgWFpxmIfvyHYNkH5n5ljP+com3Bt+11ZzSs=; b=qP0sd6jxXmaeoG1chZXL1nnfvb
	BMJKSM3T2WcH2+GWzkmewGTZ+nELqXBR+v4NsGTsTN8Sg4cTqQfu73V4EN2bHJGI7ai4bs3bcZkmV
	MJ7Nt8oIZgCQLRpRJGLMBp/YAn36TLHrVm7wOiPp80NcZ/9BY4TmJUoytdQAccYaoqsMKdXnkY94x
	4t6yNka1PrprDVY3SIo7tMSqljXFgrdO4jStNufFJOZSCLW/MVcY++WZ25EFxt+a6fYU0IV6QD2hX
	kydYbC5IJUAz4ZNMa61K6+JCQmqCtxc09qMTOEkaD/utP890OHCaweuxuasTfRsgt/A4YWdle3AIj
	fey4eJEQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6ME0-0000000BMoK-2w2i;
	Sun, 20 Apr 2025 04:24:12 +0000
Date: Sun, 20 Apr 2025 05:24:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Ian Kent <raven@themaw.net>, Mark Brown <broonie@kernel.org>,
	Eric Chanudet <echanude@redhat.com>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Alexander Larsson <alexl@redhat.com>,
	Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250420042412.GQ2023217@ZenIV>
References: <20250408210350.749901-12-echanude@redhat.com>
 <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
 <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-outen-dreihundert-7a772f78f685@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 17, 2025 at 05:12:26PM +0200, Christian Brauner wrote:

> (2) If a userspace task is dealing with e.g., a broken NFS server and
>     does a umount(MNT_DETACH) and that NFS server blocks indefinitely
>     then right now it will be the task's problem that called the umount.
>     It will simply hang and pay the price.
> 
>     With your patch however, that cleanup_mnt() and the
>     deactivate_super() call it entails will be done from
>     delayed_mntput_work...
> 
>     So if there's some userspace process with a broken NFS server and it
>     does umount(MNT_DETACH) it will end up hanging every other
>     umount(MNT_DETACH) on the system because the dealyed_mntput_work
>     workqueue (to my understanding) cannot make progress.
> 
>     So in essence this patch to me seems like handing a DOS vector for
>     MNT_DETACH to userspace.

(3) Somebody does umount -l and a few minutes later proceeds to reboot.
All filesystems involved are pinned only by mounts, but the very first
victim happens to be an NFS mount from a slow server.  No indication
of the problem, just a bunch of local filesystems that got a dirty shutdown...

