Return-Path: <linux-fsdevel+bounces-20099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC33D8CE112
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 08:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCB01C20EBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 06:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F27128383;
	Fri, 24 May 2024 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qU53u/e/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197229CFB;
	Fri, 24 May 2024 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716532838; cv=none; b=iNQ12/A82Dh8StKqiT8eToBcDV0x4hh4Za67wgBWO+SvrXJXIBaVmrPcUryVlAfKf6MSOqXXV5QkC+8kMU4xrSiW3aVnmgvkWGeG2phjehMxiGub7YKUYgh/EtT2HanIH/kZYfWa1NMV8z5inchW5wra3eBmSjXQn4+2ifN/8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716532838; c=relaxed/simple;
	bh=ZXj+xbqSxGn+CVGpP5LLmAUVtakGkcfQPZV90p2upEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RZpkg/0YTah6MJLZuIt8mcMHC3jyG2P3bgbQbtFEcprJx4IchhSb80DWH3wDihnQOiwuKaAm7/sQiNnWFrNgax6q6XiiLY9JtxrvrZ0hCvFG0l7CEI3zUWuG87vYog2yZfuUKlY1M9km5ZnO2/gZ+PCKQaCtb4DRWTiQtwSjmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qU53u/e/; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716532832; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=irj4yLqQZlehuPnw0PRAwbDzUyDoWcmcW8nbRN9wmRU=;
	b=qU53u/e/rtmjFq8H6kg0gUIAn6v3e5oxGWDaISG2fgGqWuyioV3TsYH2obUnf0yClt3/tn8wkSArbaLzCVcW8kdiJJO7rm5Cv9w5kT1C0mVw/uCX+pc7AJ5rn5etaT3+Q0flH80JcZqph4k2IWF2jgS03n8r7YLatn2W4ZkZIJ0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W75A0OG_1716532830;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W75A0OG_1716532830)
          by smtp.aliyun-inc.com;
          Fri, 24 May 2024 14:40:32 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	winters.zc@antgroup.com
Subject: [RFC 0/2] fuse: introduce fuse server recovery mechanism
Date: Fri, 24 May 2024 14:40:28 +0800
Message-Id: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Background
==========
The fd of '/dev/fuse' serves as a message transmission channel between
FUSE filesystem (kernel space) and fuse server (user space). Once the
fd gets closed (intentionally or unintentionally), the FUSE filesystem
gets aborted, and any attempt of filesystem access gets -ECONNABORTED
error until the FUSE filesystem finally umounted.

It is one of the requisites in production environment to provide
uninterruptible filesystem service.  The most straightforward way, and
maybe the most widely used way, is that make another dedicated user
daemon (similar to systemd fdstore) keep the device fd open.  When the
fuse daemon recovers from a crash, it can retrieve the device fd from the
fdstore daemon through socket takeover (Unix domain socket) method [1]
or pidfd_getfd() syscall [2].  In this way, as long as the fdstore
daemon doesn't exit, the FUSE filesystem won't get aborted once the fuse
daemon crashes, though the filesystem service may hang there for a while
when the fuse daemon gets restarted and has not been completely
recovered yet.

This picture indeed works and has been deployed in our internal
production environment until the following issues are encountered:

1. The fdstore daemon may be killed by mistake, in which case the FUSE
filesystem gets aborted and irrecoverable.

2. In scenarios of containerized deployment, the fuse daemon is deployed
in a container POD, and a dedicated fdstore daemon needs to be deployed
for each fuse daemon.  The fdstore daemon could consume a amount of
resources (e.g. memory footprint), which is not conducive to the dense
container deployment.

3. Each fuse daemon implementation needs to implement its own fdstore
daemon.  If we implement the fuse recovery mechanism on the kernel side,
all fuse daemon implementations could reuse this mechanism.


What we do
==========

Basic Recovery Mechanism
------------------------
We introduce a recovery mechanism for fuse server on the kernel side.

To do this:
1. Introduce a new "tag=" mount option, with which users could identify
a fuse connection with a unique name.
2. Introduce a new FUSE_DEV_IOC_ATTACH ioctl, with which the fuse server
could reconnect to the fuse connection corresponding to the given tag.
3. Introduce a new FUSE_HAS_RECOVERY init flag.  The fuse server should
advertise this feature if it supports server recovery.


With the above recovery mechanism, the whole time sequence is like:
- At the initial mount, the fuse filesystem is mounted with "tag="
  option
- The fuse server advertises FUSE_HAS_RECOVERY flag when replying
  FUSE_INIT
- When the fuse server crashes and the (/dev/fuse) device fd is closed,
  the fuse connection won't be aborted.
- The requests submitted after the server crash will keep staying in
  the iqueue; the processes submitting the requests will hang there
- The fuse server gets restarted and recovers the previous state before
  crash (including the negotiation results of the last FUSE_INIT)
- The fuse server opens /dev/fuse and gets a new device fd, and then
  runs FUSE_DEV_IOC_ATTACH ioctl on the new device fd to retrieve the
  fuse connection with the tag previously used to mount the fuse
  filesystem
- The fuse server issues a FUSE_NOTIFY_RESEND notification to request
  the kernel to resend those inflight requests that have been sent to
  the fuse server before the server crash but not been replied yet
- The fuse server starts to process requests normally (those queued in
  iqueue and those resent by FUSE_NOTIFY_RESEND)

In summary, the requests submitted after the server crash will stay in
the iqueue and get serviced once the fuse server recovers from the crash
and retrieve the previous fuse connection.  As for the inflight requests
that have been sent to the fuse server before the server crash but not
been replied yet, the fuse server could request the kernel to resend
those inflight requests through FUSE_NOTIFY_RESEND notification type.


Security Enhancement
---------------------
Besides, we offer a uid-based security enhancement for the fuse server
recovery mechanism.  Otherwise any malicious attacker could kill the
fuse server and take the filesystem service over with the recovery
mechanism.

To implement this, we introduce a new "rescue_uid=" mount option
specifying the expected uid of the legal process running the fuse
server.  Then only the process with the matching uid is permissible to
retrieve the fuse connection with the server recovery mechanism.


Limitation
==========
1. The current mechanism won't resend a new FUSE_INIT request to fuse
server and start a new negotiation when the fuse server attempts to
re-attach to the fuse connection through FUSE_DEV_IOC_ATTACH ioctl.
Thus the fuse server needs to recover the previous state before crash
(including the negotiation results of the last FUSE_INIT) by itself.

PS. Thus I had to do hacking tricks on libfuse passthrough_ll daemon
when testing the recovery feature.

2. With the current recovery mechanism, the fuse filesystem won't get
aborted when the fuse server crashes.  A following umount will get hung
there.  The call stack shows the hang task is waiting for FUSE_GETATTR
on the mntpoint:

[<0>] request_wait_answer+0xe1/0x200
[<0>] fuse_simple_request+0x18e/0x2a0
[<0>] fuse_do_getattr+0xc9/0x180
[<0>] vfs_statx+0x92/0x170
[<0>] vfs_fstatat+0x7c/0xb0
[<0>] __do_sys_newstat+0x1d/0x40
[<0>] do_syscall_64+0x60/0x170
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

It's not fixed yet in this RFC version.

3. I don't know if a kernel based recovery mechanism is welcome on the
community side.  Any comment is welcome.  Thanks!


[1] https://copyconstruct.medium.com/file-descriptor-transfer-over-unix-domain-sockets-dcbbf5b3b6ec
[2] https://copyconstruct.medium.com/seamless-file-descriptor-transfer-between-processes-with-pidfd-and-pidfd-getfd-816afcd19ed4


Jingbo Xu (2):
  fuse: introduce recovery mechanism for fuse server
  fuse: uid-based security enhancement for the recovery mechanism

 fs/fuse/dev.c             | 55 ++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          | 15 +++++++++++
 fs/fuse/inode.c           | 46 +++++++++++++++++++++++++++++++-
 include/uapi/linux/fuse.h |  7 +++++
 4 files changed, 121 insertions(+), 2 deletions(-)

-- 
2.19.1.6.gb485710b


