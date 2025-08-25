Return-Path: <linux-fsdevel+bounces-59019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12549B33F0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAADA1614E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B176026;
	Mon, 25 Aug 2025 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm2IOc17"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9BD17736;
	Mon, 25 Aug 2025 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124108; cv=none; b=Yvbt67gf1ZbHt0sWwdebs3uC0tH6r0O9ejkCXc1xBRygxFmEmSLQy6gJrLTvQPuigfpMNTTfE1Hidu8GEVRTIlGSjkTaZMinW5ilq0kHJ1yaqxO196Vdg5SIfGRCDoeVJN9JR8vAxvUwK1JubaRSG9JK381FOtu/th0rIPdleJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124108; c=relaxed/simple;
	bh=JaKe4DqhYWnFPu/DwQ4MSDSvTTHr/XdiZsU9DSAm2Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpk+vCWl2hMQF/2x7nzf29vqSXTrvB7LbvlM6JPuQ2hhL4eJ9g23iA0jk3/g40eudHNwgCKr+4P4yktHWPbGqK+2Pek/wsE0HN5UZ6ig89Uv4TH4/W/HPS6r1mWj2w0Z1w575uhU79yFJI3Gi42Mkcde2dIhv7Y4zHKR/X2eRX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm2IOc17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A056DC4CEED;
	Mon, 25 Aug 2025 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756124107;
	bh=JaKe4DqhYWnFPu/DwQ4MSDSvTTHr/XdiZsU9DSAm2Hw=;
	h=From:To:Cc:Subject:Date:From;
	b=Hm2IOc17eHSwIPJVEgJD/wRlHlhGBOmkygBbDMH4JHv7X8A8mUtCQKfgphITjIgLw
	 ao/laXmcKgi3VeQXhVhoO2lY7KKkolZIXoZV177jWQ8fARPHscH+VRs731Sd+E2eE9
	 Lw0nddgddKU9+RyN8fp7if0L4tAGzxf9l/3TfgpuXbHHX2QEPI8saHLA6VuQ/GqSDK
	 nSoBlcka6/ztzvEglzcPLxxs+3vl6HVIGFo8Co0RgXbP8pAqIR9sO95NfVxcmv0OlQ
	 aHFTW3yrA7M+mF+p2CBc6telbxmf3wadH7uQzCjBXgdHlTyJXyhb4oSVDUXCvVaKVM
	 G+Q9TdbX+0mrA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jiufei Xue <jiufei.xue@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-5.15] fs: writeback: fix use-after-free in __mark_inode_dirty()
Date: Mon, 25 Aug 2025 08:14:50 -0400
Message-ID: <20250825121505.2983941-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16.3
Content-Transfer-Encoding: 8bit

From: Jiufei Xue <jiufei.xue@samsung.com>

[ Upstream commit d02d2c98d25793902f65803ab853b592c7a96b29 ]

An use-after-free issue occurred when __mark_inode_dirty() get the
bdi_writeback that was in the progress of switching.

CPU: 1 PID: 562 Comm: systemd-random- Not tainted 6.6.56-gb4403bd46a8e #1
......
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mark_inode_dirty+0x124/0x418
lr : __mark_inode_dirty+0x118/0x418
sp : ffffffc08c9dbbc0
........
Call trace:
 __mark_inode_dirty+0x124/0x418
 generic_update_time+0x4c/0x60
 file_modified+0xcc/0xd0
 ext4_buffered_write_iter+0x58/0x124
 ext4_file_write_iter+0x54/0x704
 vfs_write+0x1c0/0x308
 ksys_write+0x74/0x10c
 __arm64_sys_write+0x1c/0x28
 invoke_syscall+0x48/0x114
 el0_svc_common.constprop.0+0xc0/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x40/0xe4
 el0t_64_sync_handler+0x120/0x12c
 el0t_64_sync+0x194/0x198

Root cause is:

systemd-random-seed                         kworker
----------------------------------------------------------------------
___mark_inode_dirty                     inode_switch_wbs_work_fn

  spin_lock(&inode->i_lock);
  inode_attach_wb
  locked_inode_to_wb_and_lock_list
     get inode->i_wb
     spin_unlock(&inode->i_lock);
     spin_lock(&wb->list_lock)
  spin_lock(&inode->i_lock)
  inode_io_list_move_locked
  spin_unlock(&wb->list_lock)
  spin_unlock(&inode->i_lock)
                                    spin_lock(&old_wb->list_lock)
                                      inode_do_switch_wbs
                                        spin_lock(&inode->i_lock)
                                        inode->i_wb = new_wb
                                        spin_unlock(&inode->i_lock)
                                    spin_unlock(&old_wb->list_lock)
                                    wb_put_many(old_wb, nr_switched)
                                      cgwb_release
                                      old wb released
  wb_wakeup_delayed() accesses wb,
  then trigger the use-after-free
  issue

Fix this race condition by holding inode spinlock until
wb_wakeup_delayed() finished.

Signed-off-by: Jiufei Xue <jiufei.xue@samsung.com>
Link: https://lore.kernel.org/20250728100715.3863241-1-jiufei.xue@samsung.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my thorough analysis of the commit and the kernel code, here's
my assessment:

**Backport Status: YES**

## Extensive Explanation:

This commit fixes a **critical use-after-free vulnerability** in the
writeback subsystem that should definitely be backported to stable
kernel trees. Here's why:

### 1. **Real Security Bug with Clear Impact**
The commit fixes a genuine use-after-free vulnerability that occurs in
`__mark_inode_dirty()`. The bug manifests as a kernel crash with a clear
call trace showing memory corruption. This is not a theoretical issue -
it has been observed in production (kernel 6.6.56).

### 2. **Race Condition Details**
The race condition occurs between two concurrent operations:
- **Thread A** (`__mark_inode_dirty`): Gets a reference to
  `inode->i_wb`, releases the inode lock, then calls
  `wb_wakeup_delayed(wb)`
- **Thread B** (`inode_switch_wbs_work_fn`): Switches the inode's
  writeback context, releases the old wb via `wb_put_many()`, which can
  trigger `cgwb_release` and free the wb structure

The vulnerability window exists because Thread A accesses the wb
structure (`wb_wakeup_delayed(wb)`) after releasing the inode lock but
before completing its operation, while Thread B can free that same wb
structure in parallel.

### 3. **Minimal and Contained Fix**
The fix is remarkably simple and surgical - it only reorders lock
releases:
```c
- spin_unlock(&wb->list_lock);
- spin_unlock(&inode->i_lock);
- trace_writeback_dirty_inode_enqueue(inode);
-
  if (wakeup_bdi && (wb->bdi->capabilities & BDI_CAP_WRITEBACK))
      wb_wakeup_delayed(wb);
+
+ spin_unlock(&wb->list_lock);
+ spin_unlock(&inode->i_lock);
+ trace_writeback_dirty_inode_enqueue(inode);
```

The fix ensures that `wb_wakeup_delayed()` is called while still holding
the locks, preventing the wb from being freed during the operation. This
is a classic lock ordering fix with minimal code change (just moving 3
lines).

### 4. **Critical Subsystem**
The writeback subsystem is fundamental to filesystem operations - it
handles dirty page writeback, inode management, and I/O scheduling. A
use-after-free here can lead to:
- System crashes/panics
- Data corruption
- Security vulnerabilities (potential for exploitation)

### 5. **Matches Stable Criteria**
This fix perfectly aligns with stable kernel rules:
- **Fixes a real bug**: Documented use-after-free with crash trace
- **Already upstream**: Has been reviewed by Jan Kara (filesystem
  maintainer) and merged by Christian Brauner
- **Small change**: Only 6 lines moved, no new logic
- **No new features**: Pure bug fix
- **Low regression risk**: Simply extends existing lock protection
  slightly

### 6. **Similar Historical Fixes**
The git history shows multiple similar use-after-free fixes in this
subsystem have been backported:
- `f87904c07551` - writeback: avoid use-after-free after removing device
- `8e00c4e9dd85` - writeback: fix use-after-free in
  finish_writeback_work()
- `614a4e377314` - writeback, cgroup: fix premature wb_put()

### 7. **CONFIG_CGROUP_WRITEBACK Dependency**
While this bug primarily affects systems with `CONFIG_CGROUP_WRITEBACK`
enabled (used for cgroup-aware writeback), this is a common
configuration in modern distributions, especially those using cgroups v2
for container workloads.

### 8. **No Side Effects**
The change has no functional side effects beyond fixing the race:
- The trace event still fires at the same logical point
- The wb_wakeup_delayed() still executes under the same conditions
- Only the lock hold duration is slightly extended to cover the wb
  access

This is a textbook example of a commit that should be backported to
stable kernels - it fixes a serious bug with minimal, well-understood
changes in a critical subsystem.

 fs/fs-writeback.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cc57367fb641..a07b8cf73ae2 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2608,10 +2608,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			wakeup_bdi = inode_io_list_move_locked(inode, wb,
 							       dirty_list);
 
-			spin_unlock(&wb->list_lock);
-			spin_unlock(&inode->i_lock);
-			trace_writeback_dirty_inode_enqueue(inode);
-
 			/*
 			 * If this is the first dirty inode for this bdi,
 			 * we have to wake-up the corresponding bdi thread
@@ -2621,6 +2617,11 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (wakeup_bdi &&
 			    (wb->bdi->capabilities & BDI_CAP_WRITEBACK))
 				wb_wakeup_delayed(wb);
+
+			spin_unlock(&wb->list_lock);
+			spin_unlock(&inode->i_lock);
+			trace_writeback_dirty_inode_enqueue(inode);
+
 			return;
 		}
 	}
-- 
2.50.1


