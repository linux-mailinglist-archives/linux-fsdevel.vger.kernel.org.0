Return-Path: <linux-fsdevel+bounces-42840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF83A4971F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 11:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A35216759E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F39525DD03;
	Fri, 28 Feb 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh0g8I36"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080D025DB00;
	Fri, 28 Feb 2025 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738170; cv=none; b=JFlD2Z2YTHme3S97rjT6frG2f9aI+Qpf63NHuya4T7Z2pucWbmvzVzZYb2Ls5EbfiUeLKoZg1bTzPJYkh8iQgAviRDy/l5DChfxtylsZsUMEfybAZFZmtX/1xMv8OO2yPy+KhRc6MXU0ryIlQpGAERYRMTeFeG2zK0HNSJUJpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738170; c=relaxed/simple;
	bh=lptnuKK2AQkX5sEpE3Da5QaschqmVwjMp+zHMG1tzag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKw8k0Ho8eNw8yTgSUnJem0PsOusXhqlrhdKztJfLqGpPONOAJP8tjAuoVw6AWmNL/KvHI6ag/WxFLsFz+S2qn1BvrsYVtsjI6Hk1OgmMinvMPfZGXVhoe9O7Z+JALv9JXzZqy6yr3bQuK9B3QZQfAa5CmljjCh5nefO0RijUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh0g8I36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F8BC4CEE5;
	Fri, 28 Feb 2025 10:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740738169;
	bh=lptnuKK2AQkX5sEpE3Da5QaschqmVwjMp+zHMG1tzag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oh0g8I36OWtzfahFW+oVh7jFxpZlK7xs7T1kcpZ/yJxTeu+17ES/42mp2eWrIE73I
	 xLBTDHTc65Fp7VAhTNjCGgGEyd6WzQZOcecvoTHwUJ6PAGeKfGRllE1/dZ/qOfPPnS
	 SpAIprS60SVTEtXvH/gMMGG0kbNAXVUfBO+KV1Jz09hfH2epKYWkpUmtKcD60XD4uM
	 5Xp8Meov/QZ/9Q0AESTrEfyTEB9v8Q/yVx+7ONACZb0aNyckw3SN5I3CNot9C3UKUT
	 Geh42S+XVYzxhWK5UW/6BiVhgvGmkZlnUzYIMEhcGTAQF8jOxKJu/he6DcAI2JFvuz
	 6NiFy0GMpGu0g==
From: Christian Brauner <brauner@kernel.org>
To: ceph-devel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Christian Brauner <brauner@kernel.org>,
	idryomov@gmail.com,
	dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com
Subject: Re: [RFC PATCH 0/4] ceph: fix generic/421 test failure
Date: Fri, 28 Feb 2025 11:22:37 +0100
Message-ID: <20250228-herben-geknebelt-7075ad96bcb8@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205000249.123054-1-slava@dubeyko.com>
References: <20250205000249.123054-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4064; i=brauner@kernel.org; h=from:subject:message-id; bh=lptnuKK2AQkX5sEpE3Da5QaschqmVwjMp+zHMG1tzag=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQf7Ctqu6nAeNSB5zCvnHbTy4wZx4Qe+5af5+Be7/Fow XW7n++vdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEu53hD/d77htPjd5puZRx 91VpMsgdMPjXLSBqtJjrw1nFWx13vjIy7PTJuzs/tlzQN91NdvKKOC5Lux3Hfi6r/3r0B3ug3Ap XTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 04 Feb 2025 16:02:45 -0800, Viacheslav Dubeyko wrote:
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> 
> The generic/421 fails to finish because of the issue:
> 
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.894678] INFO: task kworker/u48:0:11 blocked for more than 122 seconds.
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.895403] Not tainted 6.13.0-rc5+ #1
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.895867] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.896633] task:kworker/u48:0 state:D stack:0 pid:11 tgid:11 ppid:2 flags:0x00004000
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.896641] Workqueue: writeback wb_workfn (flush-ceph-24)
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897614] Call Trace:
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897620] <TASK>
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897629] __schedule+0x443/0x16b0
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897637] schedule+0x2b/0x140
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897640] io_schedule+0x4c/0x80
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897643] folio_wait_bit_common+0x11b/0x310
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897646] ? _raw_spin_unlock_irq+0xe/0x50
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897652] ? __pfx_wake_page_function+0x10/0x10
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897655] __folio_lock+0x17/0x30
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897658] ceph_writepages_start+0xca9/0x1fb0
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897663] ? fsnotify_remove_queued_event+0x2f/0x40
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897668] do_writepages+0xd2/0x240
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897672] __writeback_single_inode+0x44/0x350
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897675] writeback_sb_inodes+0x25c/0x550
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897680] wb_writeback+0x89/0x310
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897683] ? finish_task_switch.isra.0+0x97/0x310
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897687] wb_workfn+0xb5/0x410
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897689] process_one_work+0x188/0x3d0
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897692] worker_thread+0x2b5/0x3c0
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897694] ? __pfx_worker_thread+0x10/0x10
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897696] kthread+0xe1/0x120
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897699] ? __pfx_kthread+0x10/0x10
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897701] ret_from_fork+0x43/0x70
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897705] ? __pfx_kthread+0x10/0x10
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897707] ret_from_fork_asm+0x1a/0x30
> Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897711] </TASK>
> 
> [...]

Applied to the vfs-6.15.ceph branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.ceph branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.ceph

[1/4] ceph: extend ceph_writeback_ctl for ceph_writepages_start() refactoring
      https://git.kernel.org/vfs/vfs/c/f08068df4aa4
[2/4] ceph: introduce ceph_process_folio_batch() method
      https://git.kernel.org/vfs/vfs/c/ce80b76dd327
[3/4] ceph: introduce ceph_submit_write() method
      https://git.kernel.org/vfs/vfs/c/1551ec61dc55
[4/4] ceph: fix generic/421 test failure
      https://git.kernel.org/vfs/vfs/c/fd7449d937e7

