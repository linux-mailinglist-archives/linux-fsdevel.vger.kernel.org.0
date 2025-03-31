Return-Path: <linux-fsdevel+bounces-45319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9549BA762FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 11:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFB3169E0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993BC1DACA7;
	Mon, 31 Mar 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y21qwdpz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA713CA97;
	Mon, 31 Mar 2025 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412408; cv=none; b=WKvJ9OB8QdtpriMkmwdCgxeVIoLKd+Ckd7szVT9StiAm3UaCXf4qcP5qz1cFmgV1ZwxaMDDUDGO48yDgqqurSMSIwIfyemdkyQihezpGPuQ/cgPcS04mDLR/L1HidLLKqN+GAsTtZ4qWj+p5w+7RhEVjL8dLJHaDj+zoeqBbkBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412408; c=relaxed/simple;
	bh=P9fMSpSn4Svn5ww5bpg2gabNVZZWkbyy9tvOD2Nel8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1XDssszRQD+TpC9YnzkkMsOD7GSyBjYBYV4/TKrgjbO12P5DoAkt617iVOdLM12beRsuPISaoC+Xqs9fV1jN7VFgy3HKN7TL+mVsaqUxqCMCT4MKGlp9qFLIjnXckkkL4OJKB3dxsCWqFq08wHsyRu4rdhyepLvkCN/nnilt6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y21qwdpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95E4C4CEE3;
	Mon, 31 Mar 2025 09:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743412407;
	bh=P9fMSpSn4Svn5ww5bpg2gabNVZZWkbyy9tvOD2Nel8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y21qwdpzy3yp0rkjKWgyfcATC/8e28FkCoAaWRITgSNECYAorLOz4GR2pJ/ZVntc4
	 +loHP0op04pdj4B6yAQqalZ9KCBCg+NZkNj3h5lx0jAgO1x8xWK7KFan+ZZffmRrr+
	 mDf/yVgoWIlWT4RlmWmr7cdPF8v3Md1/KTGKSU6QLqOkSLBaTYXM4/GCkKEcH0ZyTH
	 khT7mebsXCBUp/5O2QdBDV7aHioqQJveDJwfEuc1wibzCqozbEJPjtPJPuzSaVoNRZ
	 e1Q9ms0+LNTiVeOVxK+ayaSIvvqCHP1UVEyVmsurbWb16XDgqUpGDH1lW1Z5GawjWW
	 cRPip7WEwoKoA==
Date: Mon, 31 Mar 2025 11:13:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 0/6] Extend freeze support to suspend and hibernate
Message-ID: <20250331-inkrafttreten-lieder-5396ffd0af7a@brauner>
References: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
 <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <12ce8c18f4e16b1de591cbdfb8f6e7844e42807b.camel@HansenPartnership.com>
 <9c0a24cd8b03539fd6b8ecd5a186a5cf98b5d526.camel@HansenPartnership.com>
 <20250330-heimweg-packen-b73908210f79@brauner>
 <3f140c076c3756e84d515b81ee9eeeaf13ca4b42.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f140c076c3756e84d515b81ee9eeeaf13ca4b42.camel@HansenPartnership.com>

On Sun, Mar 30, 2025 at 10:00:56AM -0400, James Bottomley wrote:
> On Sun, 2025-03-30 at 10:33 +0200, Christian Brauner wrote:
> [...]
> > > I found the systemd bug
> > > 
> > > https://github.com/systemd/systemd/issues/36888
> > 
> > I don't think that's a systemd bug.
> 
> Heh, well I have zero interest in refereeing a turf war between systemd
> and dracut over mismatched expectations.  The point for anyone who
> wants to run hibernate tests is that until they both sort this out the
> bug can be fixed by removing the system identifier check from systemd-
> hibernate-resume-generator.
> 
> > > And hacked around it, so I can confirm a simple hibernate/resume
> > > works provided the sd_start_write() patches are applied (and the
> > > hooks are plumbed in to pm).
> > > 
> > > There is an oddity: the systemd-journald process that would usually
> > > hang hibernate in D wait goes into R but seems to be hung and can't
> > > be killed by the watchdog even with a -9.  It's stack trace says
> > > it's still stuck in sb_start_write:
> > > 
> > > [<0>] percpu_rwsem_wait.constprop.10+0xd1/0x140
> > > [<0>] ext4_page_mkwrite+0x3c1/0x560 [ext4]
> > > [<0>] do_page_mkwrite+0x38/0xa0
> > > [<0>] do_wp_page+0xd5/0xba0
> > > [<0>] __handle_mm_fault+0xa29/0xca0
> > > [<0>] handle_mm_fault+0x16a/0x2d0
> > > [<0>] do_user_addr_fault+0x3ab/0x810
> > > [<0>] exc_page_fault+0x68/0x150
> > > [<0>] asm_exc_page_fault+0x22/0x30
> > > 
> > > So I think there's something funny going on in thaw.
> > 
> > My uneducated guess is that it's probably an issue with ext4 freezing
> > and unfreezing. xfs stops workqueues after all writes and pagefault
> > writers have stopped. This is done in ->sync_fs() when it's called
> > from freeze_super(). They are restarted when ->unfreeze_fs is called.
> 
> It is possible, but I note that if I do
> 
> fsfreeze --freeze /

Freezing the root filesystem from userspace will inevitably lead to an
odd form of deadlock eventually. Either the first accidental request for
opening something as writable or even the call to fsfreeze --unfreeze /
may deadlock.

The most likely explanation for this stacktrace is that the root
filesystem isn't unfrozen. In userspace it's easy enough to trigger by
leaving the filesystem frozen without also freezing userspace processes
accessing that filesystem:

[  243.232205] INFO: task systemd-journal:539 blocked for more than 120 seconds.
[  243.239491]       Not tainted 6.14.0-g9ad3884269ca #131
[  243.243771] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  243.248517] task:systemd-journal state:D stack:0     pid:539   tgid:539   ppid:1      task_flags:0x400100 flags:0x00000006
[  243.253480] Call Trace:
[  243.254641]  <TASK>
[  243.255663]  __schedule+0x61e/0x1080
[  243.257071]  ? percpu_rwsem_wait+0x149/0x1b0
[  243.258473]  schedule+0x3a/0x120
[  243.259533]  percpu_rwsem_wait+0x155/0x1b0
[  243.260844]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[  243.262620]  __percpu_down_read+0x83/0x1c0
[  243.263968]  btrfs_page_mkwrite+0x45b/0x890 [btrfs]
[  243.266828]  ? find_held_lock+0x2b/0x80
[  243.267765]  do_page_mkwrite+0x4a/0xb0
[  243.268698]  do_wp_page+0x331/0xdc0
[  243.269559]  __handle_mm_fault+0xb15/0x11d0
[  243.270566]  handle_mm_fault+0xb8/0x2b0
[  243.271557]  do_user_addr_fault+0x20a/0x700
[  243.272574]  exc_page_fault+0x6a/0x200
[  243.273462]  asm_exc_page_fault+0x26/0x30

This happens because systemd-journald mmaps the journal file. It
triggers a pagefault which wants to get pagefault based write access to
the file. But it can't because pagefaults are frozen. So it hangs and as
it's not frozen it will trigger hung task warnings.

IOW, the most likely explanation is that the root filesystem wasn't
unfrozen and systemd-journald wasn't frozen.

