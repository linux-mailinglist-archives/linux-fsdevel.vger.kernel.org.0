Return-Path: <linux-fsdevel+bounces-55154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99339B075E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7DEA40B7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473642F549C;
	Wed, 16 Jul 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hw+2VBiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828C2F49F2;
	Wed, 16 Jul 2025 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669607; cv=none; b=B4ItxzY8Bzx+Q9qtLYKNVhxmfpxNJYyaVWmHLftkAHd174HZ/YlEC5HXvZGzZ969AOmgVDPyQuWoGl5T5/VYD/Xo3Phs/xEvWewogaip2hYD5IIbZfBRdQQJvWKfbxbzmTlvXwvWMTWe1nysQGTkNWiSsx3m3+8wPxQTauoY4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669607; c=relaxed/simple;
	bh=cFV2i32Bhh0qzq9LTycrOsrst5C+cWFbIeGi1+hiAFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzATIWBQN4dVHN4HJKL+xDKewV+03n/5rx3+iEMCZlstHBOvymTuf8Caqw7bfuRt8kbkMrtsMGPFo0VA10NWstFN11nnOS2iBkX98zfWuDUuolUcPWcU9AEooSKKeATrXkBBAPjdi/+gKsXcInT3sP/7t5KrhxZ4HNV9b/9HpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hw+2VBiy; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oMmU6Xd2o59wD//iRKEUw6ENLibigiHAQzt2S7vm4Xg=; b=hw+2VBiyK2ctBVD8skIXkFH2zY
	xvvVicbOpg8892/lB/eNH3Qq3uyPZkeWON9ACXaiaT5S2tggwypNL/hkXKRIaJJjGd4G0sZMiu9sS
	8OBCE4g21oYCbivpjZcfcIcBzaUxcc6Zsso8LX9c/FMRSZRBio1qGWg0456iK7fCqwILywCLcojoU
	wsyzuYBYel0QgiM4PhMIwycEKTaUaatMHvmaopqtfKbIvVOkrNL3opdZOvZ9+hQsK1UvmmicUZdAR
	j94HDP8VprcUZgTwOMVunXBfweeWXvFYBOoJ+ynVy/MrB6T78ZazZo3qw+1giRlI8Jvo4H6pgG/qW
	9xcc1x1A==;
Received: from [223.233.66.171] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uc1QU-00HJWV-4V; Wed, 16 Jul 2025 14:39:58 +0200
From: Bhupesh <bhupesh@igalia.com>
To: akpm@linux-foundation.org
Cc: bhupesh@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	oliver.sang@intel.com,
	lkp@intel.com,
	laoar.shao@gmail.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl,
	peterz@infradead.org,
	willy@infradead.org,
	david@redhat.com,
	viro@zeniv.linux.org.uk,
	keescook@chromium.org,
	ebiederm@xmission.com,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	kees@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str which is 64 bytes long
Date: Wed, 16 Jul 2025 18:09:16 +0530
Message-Id: <20250716123916.511889-4-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250716123916.511889-1-bhupesh@igalia.com>
References: <20250716123916.511889-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically due to the 16-byte length of TASK_COMM_LEN, the
users of 'tsk->comm' are restricted to use a fixed-size target
buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.

To fix the same, Kees suggested in [1] that we can replace tsk->comm,
with tsk->comm_str, inside 'task_struct':
       union {
               char    comm_str[TASK_COMM_EXT_LEN];
       };

where TASK_COMM_EXT_LEN is 64-bytes.

And then modify 'get_task_comm()' to pass 'tsk->comm_str'
to the existing users.

This would mean that ABI is maintained while ensuring that:

- Existing users of 'get_task_comm'/ 'set_task_comm' will get 'tsk->comm_str'
  truncated to a maximum of 'TASK_COMM_LEN' (16-bytes) to maintain ABI,
- New / Modified users of 'get_task_comm'/ 'set_task_comm' will get
 'tsk->comm_str' supported for a maximum of 'TASK_COMM_EXTLEN' (64-bytes).

Note, that the existing users have not been modified to migrate to
'TASK_COMM_EXT_LEN', in case they have hard-coded expectations of
dealing with only a 'TASK_COMM_LEN' long 'tsk->comm_str'.

[1]. https://lore.kernel.org/all/202505231346.52F291C54@keescook/

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 arch/arm64/kernel/traps.c        |  2 +-
 arch/arm64/kvm/mmu.c             |  2 +-
 block/blk-core.c                 |  2 +-
 block/bsg.c                      |  2 +-
 drivers/char/random.c            |  2 +-
 drivers/hid/hid-core.c           |  6 +++---
 drivers/mmc/host/tmio_mmc_core.c |  6 +++---
 drivers/pci/pci-sysfs.c          |  2 +-
 drivers/scsi/scsi_ioctl.c        |  2 +-
 drivers/tty/serial/serial_core.c |  2 +-
 drivers/tty/tty_io.c             |  8 ++++----
 drivers/usb/core/devio.c         | 16 ++++++++--------
 drivers/usb/core/message.c       |  2 +-
 drivers/vfio/group.c             |  2 +-
 drivers/vfio/vfio_iommu_type1.c  |  2 +-
 drivers/vfio/vfio_main.c         |  2 +-
 drivers/xen/evtchn.c             |  2 +-
 drivers/xen/grant-table.c        |  2 +-
 fs/binfmt_elf.c                  |  2 +-
 fs/coredump.c                    |  4 ++--
 fs/drop_caches.c                 |  2 +-
 fs/exec.c                        |  8 ++++----
 fs/ext4/dir.c                    |  2 +-
 fs/ext4/inode.c                  |  2 +-
 fs/ext4/namei.c                  |  2 +-
 fs/ext4/super.c                  | 12 ++++++------
 fs/hugetlbfs/inode.c             |  2 +-
 fs/ioctl.c                       |  2 +-
 fs/iomap/direct-io.c             |  2 +-
 fs/jbd2/transaction.c            |  2 +-
 fs/locks.c                       |  2 +-
 fs/netfs/internal.h              |  2 +-
 fs/proc/base.c                   |  2 +-
 fs/read_write.c                  |  2 +-
 fs/splice.c                      |  2 +-
 include/linux/coredump.h         |  2 +-
 include/linux/filter.h           |  2 +-
 include/linux/ratelimit.h        |  2 +-
 include/linux/sched.h            | 11 ++++++++---
 init/init_task.c                 |  2 +-
 ipc/sem.c                        |  2 +-
 kernel/acct.c                    |  2 +-
 kernel/audit.c                   |  4 ++--
 kernel/auditsc.c                 | 10 +++++-----
 kernel/bpf/helpers.c             |  2 +-
 kernel/capability.c              |  4 ++--
 kernel/cgroup/cgroup-v1.c        |  2 +-
 kernel/cred.c                    |  4 ++--
 kernel/events/core.c             |  2 +-
 kernel/exit.c                    |  6 +++---
 kernel/fork.c                    |  9 +++++++--
 kernel/freezer.c                 |  4 ++--
 kernel/futex/waitwake.c          |  2 +-
 kernel/hung_task.c               | 10 +++++-----
 kernel/irq/manage.c              |  2 +-
 kernel/kthread.c                 |  2 +-
 kernel/locking/rtmutex.c         |  2 +-
 kernel/printk/printk.c           |  2 +-
 kernel/sched/core.c              | 22 +++++++++++-----------
 kernel/sched/debug.c             |  4 ++--
 kernel/signal.c                  |  6 +++---
 kernel/sys.c                     |  6 +++---
 kernel/sysctl.c                  |  2 +-
 kernel/time/itimer.c             |  4 ++--
 kernel/time/posix-cpu-timers.c   |  2 +-
 kernel/tsacct.c                  |  2 +-
 kernel/workqueue.c               |  6 +++---
 lib/dump_stack.c                 |  2 +-
 lib/nlattr.c                     |  6 +++---
 mm/compaction.c                  |  2 +-
 mm/filemap.c                     |  4 ++--
 mm/gup.c                         |  2 +-
 mm/memfd.c                       |  2 +-
 mm/memory-failure.c              | 10 +++++-----
 mm/memory.c                      |  2 +-
 mm/mmap.c                        |  4 ++--
 mm/oom_kill.c                    | 18 +++++++++---------
 mm/page_alloc.c                  |  4 ++--
 mm/util.c                        |  2 +-
 net/core/sock.c                  |  2 +-
 net/dns_resolver/internal.h      |  2 +-
 net/ipv4/raw.c                   |  2 +-
 net/ipv4/tcp.c                   |  2 +-
 net/socket.c                     |  2 +-
 security/lsm_audit.c             |  4 ++--
 85 files changed, 171 insertions(+), 161 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index bed754b736d3..689c2b145fa1 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -245,7 +245,7 @@ static void arm64_show_signal(int signo, const char *str)
 	    !__ratelimit(&rs))
 		return;
 
-	pr_info("%s[%d]: unhandled exception: ", tsk->comm, task_pid_nr(tsk));
+	pr_info("%s[%d]: unhandled exception: ", tsk->comm_str, task_pid_nr(tsk));
 	if (esr)
 		pr_cont("%s, ESR 0x%016lx, ", esr_get_class_string(esr), esr);
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1c78864767c5..c86ab5ae4532 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -891,7 +891,7 @@ static int kvm_init_ipa_range(struct kvm_s2_mmu *mmu, unsigned long type)
 		phys_shift = KVM_PHYS_SHIFT;
 		if (phys_shift > kvm_ipa_limit) {
 			pr_warn_once("%s using unsupported default IPA limit, upgrade your VMM\n",
-				     current->comm);
+				     current->comm_str);
 			return -EINVAL;
 		}
 	}
diff --git a/block/blk-core.c b/block/blk-core.c
index fdac48aec5ef..f93e2a1676b6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -562,7 +562,7 @@ static inline int bio_check_eod(struct bio *bio)
 	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
 		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
 				    "%pg: rw=%d, sector=%llu, nr_sectors = %u limit=%llu\n",
-				    current->comm, bio->bi_bdev, bio->bi_opf,
+				    current->comm_str, bio->bi_bdev, bio->bi_opf,
 				    bio->bi_iter.bi_sector, nr_sectors, maxsector);
 		return -EIO;
 	}
diff --git a/block/bsg.c b/block/bsg.c
index 72157a59b788..1f348e798cfa 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -151,7 +151,7 @@ static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return bsg_sg_io(bd, file->f_mode & FMODE_WRITE, uarg);
 	case SCSI_IOCTL_SEND_COMMAND:
 		pr_warn_ratelimited("%s: calling unsupported SCSI_IOCTL_SEND_COMMAND\n",
-				current->comm);
+				current->comm_str);
 		return -EINVAL;
 	default:
 		return -ENOTTY;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index d45383d57919..6f28a4d9af4a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1477,7 +1477,7 @@ static ssize_t urandom_read_iter(struct kiocb *kiocb, struct iov_iter *iter)
 		else if (ratelimit_disable || __ratelimit(&urandom_warning)) {
 			--maxwarn;
 			pr_notice("%s: uninitialized urandom read (%zu bytes read)\n",
-				  current->comm, iov_iter_count(iter));
+				  current->comm_str, iov_iter_count(iter));
 		}
 	}
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2930d6e23d40..f5b75c5837ff 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1405,7 +1405,7 @@ u32 hid_field_extract(const struct hid_device *hid, u8 *report,
 {
 	if (n > 32) {
 		hid_warn_once(hid, "%s() called with n (%d) > 32! (%s)\n",
-			      __func__, n, current->comm);
+			      __func__, n, current->comm_str);
 		n = 32;
 	}
 
@@ -1451,7 +1451,7 @@ static void implement(const struct hid_device *hid, u8 *report,
 {
 	if (unlikely(n > 32)) {
 		hid_warn(hid, "%s() called with n (%d) > 32! (%s)\n",
-			 __func__, n, current->comm);
+			 __func__, n, current->comm_str);
 		n = 32;
 	} else if (n < 32) {
 		u32 m = (1U << n) - 1;
@@ -1459,7 +1459,7 @@ static void implement(const struct hid_device *hid, u8 *report,
 		if (unlikely(value > m)) {
 			hid_warn(hid,
 				 "%s() called with too large value %d (n: %d)! (%s)\n",
-				 __func__, value, n, current->comm);
+				 __func__, value, n, current->comm_str);
 			value &= m;
 		}
 	}
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 21c2f9095bac..aa083b919532 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -951,13 +951,13 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (IS_ERR(host->mrq)) {
 			dev_dbg(dev,
 				"%s.%d: concurrent .set_ios(), clk %u, mode %u\n",
-				current->comm, task_pid_nr(current),
+				current->comm_str, task_pid_nr(current),
 				ios->clock, ios->power_mode);
 			host->mrq = ERR_PTR(-EINTR);
 		} else {
 			dev_dbg(dev,
 				"%s.%d: CMD%u active since %lu, now %lu!\n",
-				current->comm, task_pid_nr(current),
+				current->comm_str, task_pid_nr(current),
 				host->mrq->cmd->opcode, host->last_req_ts,
 				jiffies);
 		}
@@ -1000,7 +1000,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (PTR_ERR(host->mrq) == -EINTR)
 		dev_dbg(&host->pdev->dev,
 			"%s.%d: IOS interrupted: clk %u, mode %u",
-			current->comm, task_pid_nr(current),
+			current->comm_str, task_pid_nr(current),
 			ios->clock, ios->power_mode);
 
 	/* Ready for new mrqs */
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5eea14c1f7f5..a59458f1b091 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -786,7 +786,7 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	if (resource_is_exclusive(&dev->driver_exclusive_resource, off,
 				  count)) {
 		pci_warn_once(dev, "%s: Unexpected write to kernel-exclusive config offset %llx",
-			      current->comm, off);
+			      current->comm_str, off);
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}
 
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 0ddc95bafc71..4afeee7e9dec 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -894,7 +894,7 @@ int scsi_ioctl(struct scsi_device *sdev, bool open_for_write, int cmd,
 	case SCSI_IOCTL_START_UNIT:
 	case SCSI_IOCTL_STOP_UNIT:
 		printk(KERN_WARNING "program %s is using a deprecated SCSI "
-		       "ioctl, please convert it to SG_IO\n", current->comm);
+		       "ioctl, please convert it to SG_IO\n", current->comm_str);
 		break;
 	default:
 		break;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 86d404d649a3..66beaa8de571 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1017,7 +1017,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 			if (uport->flags & UPF_SPD_MASK) {
 				dev_notice_ratelimited(uport->dev,
 				       "%s sets custom speed on %s. This is deprecated.\n",
-				      current->comm,
+				      current->comm_str,
 				      tty_name(port->tty));
 			}
 			uart_change_line_settings(tty, state, NULL);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e2d92cf70eb7..d354b0d986e7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2618,7 +2618,7 @@ static int tty_set_serial(struct tty_struct *tty, struct serial_struct *ss)
 
 	if (flags)
 		pr_warn_ratelimited("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
-				__func__, current->comm, flags);
+				__func__, current->comm_str, flags);
 
 	if (!tty->ops->set_serial)
 		return -ENOTTY;
@@ -3030,7 +3030,7 @@ void __do_SAK(struct tty_struct *tty)
 	/* Kill the entire session */
 	do_each_pid_task(session, PIDTYPE_SID, p) {
 		tty_notice(tty, "SAK: killed process %d (%s): by session\n",
-			   task_pid_nr(p), p->comm);
+			   task_pid_nr(p), p->comm_str);
 		group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_SID);
 	} while_each_pid_task(session, PIDTYPE_SID, p);
 
@@ -3038,7 +3038,7 @@ void __do_SAK(struct tty_struct *tty)
 	for_each_process_thread(g, p) {
 		if (p->signal->tty == tty) {
 			tty_notice(tty, "SAK: killed process %d (%s): by controlling tty\n",
-				   task_pid_nr(p), p->comm);
+				   task_pid_nr(p), p->comm_str);
 			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p,
 					PIDTYPE_SID);
 			continue;
@@ -3047,7 +3047,7 @@ void __do_SAK(struct tty_struct *tty)
 		i = iterate_fd(p->files, 0, this_tty, tty);
 		if (i != 0) {
 			tty_notice(tty, "SAK: killed process %d (%s): by fd#%d\n",
-				   task_pid_nr(p), p->comm, i - 1);
+				   task_pid_nr(p), p->comm_str, i - 1);
 			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p,
 					PIDTYPE_SID);
 		}
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index f6ce6e26e0d4..663e752aaa7c 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -849,7 +849,7 @@ static int checkintf(struct usb_dev_state *ps, unsigned int ifnum)
 	/* if not yet claimed, claim it for the driver */
 	dev_warn(&ps->dev->dev, "usbfs: process %d (%s) did not claim "
 		 "interface %u before use\n", task_pid_nr(current),
-		 current->comm, ifnum);
+		 current->comm_str, ifnum);
 	return claimintf(ps, ifnum);
 }
 
@@ -924,7 +924,7 @@ static int check_ctrlrecip(struct usb_dev_state *ps, unsigned int requesttype,
 				dev_info(&ps->dev->dev,
 					"%s: process %i (%s) requesting ep %02x but needs %02x\n",
 					__func__, task_pid_nr(current),
-					current->comm, index, index ^ 0x80);
+					current->comm_str, index, index ^ 0x80);
 		}
 		if (ret >= 0)
 			ret = checkintf(ps, ret);
@@ -1078,7 +1078,7 @@ static int usbdev_open(struct inode *inode, struct file *file)
 	file->private_data = ps;
 	usb_unlock_device(dev);
 	snoop(&dev->dev, "opened by process %d: %s\n", task_pid_nr(current),
-			current->comm);
+			current->comm_str);
 	return ret;
 
  out_unlock_device:
@@ -1257,7 +1257,7 @@ static int do_proc_control(struct usb_dev_state *ps,
 	if (i < 0 && i != -EPIPE) {
 		dev_printk(KERN_DEBUG, &dev->dev, "usbfs: USBDEVFS_CONTROL "
 			   "failed cmd %s rqt %u rq %u len %u ret %d\n",
-			   current->comm, ctrl->bRequestType, ctrl->bRequest,
+			   current->comm_str, ctrl->bRequestType, ctrl->bRequest,
 			   ctrl->wLength, i);
 	}
 	ret = (i < 0 ? i : actlen);
@@ -1389,7 +1389,7 @@ static void check_reset_of_active_ep(struct usb_device *udev,
 	ep = eps[epnum & 0x0f];
 	if (ep && !list_empty(&ep->urb_list))
 		dev_warn(&udev->dev, "Process %d (%s) called USBDEVFS_%s for active endpoint 0x%02x\n",
-				task_pid_nr(current), current->comm,
+				task_pid_nr(current), current->comm_str,
 				ioctl_name, epnum);
 }
 
@@ -1517,7 +1517,7 @@ static int proc_resetdevice(struct usb_dev_state *ps)
 					!test_bit(number, &ps->ifclaimed)) {
 				dev_warn(&ps->dev->dev,
 					"usbfs: interface %d claimed by %s while '%s' resets device\n",
-					number,	interface->dev.driver->name, current->comm);
+					number,	interface->dev.driver->name, current->comm_str);
 				return -EACCES;
 			}
 		}
@@ -1571,7 +1571,7 @@ static int proc_setconfig(struct usb_dev_state *ps, void __user *arg)
 						->desc.bInterfaceNumber,
 					actconfig->interface[i]
 						->dev.driver->name,
-					current->comm, u);
+					current->comm_str, u);
 				status = -EBUSY;
 				break;
 			}
@@ -2428,7 +2428,7 @@ static int proc_claim_port(struct usb_dev_state *ps, void __user *arg)
 	rc = usb_hub_claim_port(ps->dev, portnum, ps);
 	if (rc == 0)
 		snoop(&ps->dev->dev, "port %d claimed by process %d: %s\n",
-			portnum, task_pid_nr(current), current->comm);
+			portnum, task_pid_nr(current), current->comm_str);
 	return rc;
 }
 
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index d2b2787be409..d33e8881281c 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -67,7 +67,7 @@ static int usb_start_wait_urb(struct urb *urb, int timeout, int *actual_length)
 
 		dev_dbg(&urb->dev->dev,
 			"%s timed out on ep%d%s len=%u/%u\n",
-			current->comm,
+			current->comm_str,
 			usb_endpoint_num(&urb->ep->desc),
 			usb_urb_dir_in(urb) ? "in" : "out",
 			urb->actual_length,
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index c376a6279de0..991ca92e9eee 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -280,7 +280,7 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
 
 	if (device->group->type == VFIO_NO_IOMMU)
 		dev_warn(device->dev, "vfio-noiommu device opened by user "
-			 "(%s:%d)\n", current->comm, task_pid_nr(current));
+			 "(%s:%d)\n", current->comm_str, task_pid_nr(current));
 	/*
 	 * On success the ref of device is moved to the file and
 	 * put in vfio_device_fops_release()
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 1136d7ac6b59..a2d34704f60f 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -778,7 +778,7 @@ static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
 			if (ret == -ENOMEM)
 				pr_warn("%s: Task %s (%d) RLIMIT_MEMLOCK "
 					"(%ld) exceeded\n", __func__,
-					dma->task->comm, task_pid_nr(dma->task),
+					dma->task->comm_str, task_pid_nr(dma->task),
 					task_rlimit(dma->task, RLIMIT_MEMLOCK));
 		}
 	}
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 5046cae05222..021e41bd7759 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -418,7 +418,7 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 					 "Device is currently in use, task"
 					 " \"%s\" (%d) "
 					 "blocked until device is released",
-					 current->comm, task_pid_nr(current));
+					 current->comm_str, task_pid_nr(current));
 			}
 		}
 	}
diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index 7e4a13e632dc..f51361e1e8e1 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -646,7 +646,7 @@ static int evtchn_open(struct inode *inode, struct file *filp)
 	if (u == NULL)
 		return -ENOMEM;
 
-	u->name = kasprintf(GFP_KERNEL, "evtchn:%s", current->comm);
+	u->name = kasprintf(GFP_KERNEL, "evtchn:%s", current->comm_str);
 	if (u->name == NULL) {
 		kfree(u);
 		return -ENOMEM;
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 04a6b470b15d..6958ce227c4f 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1163,7 +1163,7 @@ gnttab_retry_eagain_gop(unsigned int cmd, void *gop, int16_t *status,
 	} while ((*status == GNTST_eagain) && (delay < MAX_DELAY));
 
 	if (delay >= MAX_DELAY) {
-		pr_err("%s: %s eagain grant\n", func, current->comm);
+		pr_err("%s: %s eagain grant\n", func, current->comm_str);
 		*status = GNTST_bad_page;
 	}
 }
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index ea3e184cd2e3..e304d19c72e1 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -386,7 +386,7 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	if ((type & MAP_FIXED_NOREPLACE) &&
 	    PTR_ERR((void *)map_addr) == -EEXIST)
 		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
-			task_pid_nr(current), current->comm, (void *)addr);
+			task_pid_nr(current), current->comm_str, (void *)addr);
 
 	return(map_addr);
 }
diff --git a/fs/coredump.c b/fs/coredump.c
index f88deb4701ac..0ea4bd2403a8 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -200,7 +200,7 @@ static int cn_print_exe_file(struct core_name *cn, bool name_only)
 
 	exe_file = get_mm_exe_file(current->mm);
 	if (!exe_file)
-		return cn_esc_printf(cn, "%s (path unknown)", current->comm);
+		return cn_esc_printf(cn, "%s (path unknown)", current->comm_str);
 
 	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!pathbuf) {
@@ -417,7 +417,7 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 				break;
 			/* executable, could be changed by prctl PR_SET_NAME etc */
 			case 'e':
-				err = cn_esc_printf(cn, "%s", current->comm);
+				err = cn_esc_printf(cn, "%s", current->comm_str);
 				break;
 			/* file name of executable */
 			case 'f':
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 019a8b4eaaf9..dbd3f2366028 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -70,7 +70,7 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 		}
 		if (!stfu) {
 			pr_info("%s (%d): drop_caches: %d\n",
-				current->comm, task_pid_nr(current),
+				current->comm_str, task_pid_nr(current),
 				sysctl_drop_caches);
 		}
 		stfu |= sysctl_drop_caches & 4;
diff --git a/fs/exec.c b/fs/exec.c
index 2a1e5e4042a1..80c92fadb367 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1082,11 +1082,11 @@ static int unshare_sighand(struct task_struct *me)
  */
 void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 {
-	size_t len = min(strlen(buf), sizeof(tsk->comm) - 1);
+	size_t len = min(strlen(buf), sizeof(tsk->comm_str) - 1);
 
 	trace_task_rename(tsk, buf);
-	memcpy(tsk->comm, buf, len);
-	memset(&tsk->comm[len], 0, sizeof(tsk->comm) - len);
+	memcpy(tsk->comm_str, buf, len);
+	memset(&tsk->comm_str[len], 0, sizeof(tsk->comm_str) - len);
 	perf_event_comm(tsk, exec);
 }
 
@@ -1854,7 +1854,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 		bprm->argc = 1;
 
 		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",
-			     current->comm, bprm->filename);
+			     current->comm_str, bprm->filename);
 	}
 
 	retval = bprm_execve(bprm);
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index d4164c507a90..5636a53b061e 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -537,7 +537,7 @@ static int call_filldir(struct file *file, struct dir_context *ctx,
 	if (!fname) {
 		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: comm %s: "
 			 "called with null fname?!?", __func__, __LINE__,
-			 inode->i_ino, current->comm);
+			 inode->i_ino, current->comm_str);
 		return 0;
 	}
 	ctx->pos = hash2pos(file, fname->hash, fname->minor_hash);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 01c9b620b3f3..ed6743e660ce 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5235,7 +5235,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			return ERR_PTR(-ESTALE);
 		__ext4_error(sb, function, line, false, EFSCORRUPTED, 0,
 			     "inode #%lu: comm %s: iget: illegal inode #",
-			     ino, current->comm);
+			     ino, current->comm_str);
 		return ERR_PTR(-EFSCORRUPTED);
 	}
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a178ac229489..9e9c95e49587 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -147,7 +147,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 			       "inode #%lu: lblock %lu: comm %s: "
 			       "error %ld reading directory block",
 			       inode->i_ino, (unsigned long)block,
-			       current->comm, PTR_ERR(bh));
+			       current->comm_str, PTR_ERR(bh));
 
 		return bh;
 	}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d75b416401ae..a9e4e4898847 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -812,7 +812,7 @@ void __ext4_error(struct super_block *sb, const char *function,
 		vaf.va = &args;
 		printk(KERN_CRIT
 		       "EXT4-fs error (device %s): %s:%d: comm %s: %pV\n",
-		       sb->s_id, function, line, current->comm, &vaf);
+		       sb->s_id, function, line, current->comm_str, &vaf);
 		va_end(args);
 	}
 	fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);
@@ -839,12 +839,12 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 			printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: "
 			       "inode #%lu: block %llu: comm %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
-			       block, current->comm, &vaf);
+			       block, current->comm_str, &vaf);
 		else
 			printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: "
 			       "inode #%lu: comm %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
-			       current->comm, &vaf);
+			       current->comm_str, &vaf);
 		va_end(args);
 	}
 	fsnotify_sb_error(inode->i_sb, inode, error ? error : EFSCORRUPTED);
@@ -878,13 +878,13 @@ void __ext4_error_file(struct file *file, const char *function,
 			       "EXT4-fs error (device %s): %s:%d: inode #%lu: "
 			       "block %llu: comm %s: path %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
-			       block, current->comm, path, &vaf);
+			       block, current->comm_str, path, &vaf);
 		else
 			printk(KERN_CRIT
 			       "EXT4-fs error (device %s): %s:%d: inode #%lu: "
 			       "comm %s: path %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
-			       current->comm, path, &vaf);
+			       current->comm_str, path, &vaf);
 		va_end(args);
 	}
 	fsnotify_sb_error(inode->i_sb, inode, EFSCORRUPTED);
@@ -1022,7 +1022,7 @@ void __ext4_warning_inode(const struct inode *inode, const char *function,
 	vaf.va = &args;
 	printk(KERN_WARNING "EXT4-fs warning (device %s): %s:%d: "
 	       "inode #%lu: comm %s: %pV\n", inode->i_sb->s_id,
-	       function, line, inode->i_ino, current->comm, &vaf);
+	       function, line, inode->i_ino, current->comm_str, &vaf);
 	va_end(args);
 }
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 14929fcea52d..d4263c3da019 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1540,7 +1540,7 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 
 		if (user_shm_lock(size, ucounts)) {
 			pr_warn_once("%s (%d): Using mlock ulimits for SHM_HUGETLB is obsolete\n",
-				current->comm, current->pid);
+				current->comm_str, current->pid);
 			user_shm_unlock(size, ucounts);
 		}
 		return ERR_PTR(-EPERM);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 0248cb8db2d3..3c543b581501 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -79,7 +79,7 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
 	if (block > INT_MAX) {
 		error = -ERANGE;
 		pr_warn_ratelimited("[%s/%d] FS: %s File: %pD4 would truncate fibmap result\n",
-				    current->comm, task_pid_nr(current),
+				    current->comm_str, task_pid_nr(current),
 				    sb->s_id, filp);
 	}
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 844261a31156..231a1a904496 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -570,7 +570,7 @@ static int iomap_dio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		 * DELALLOC block that the page-mkwrite allocated.
 		 */
 		pr_warn_ratelimited("Direct I/O collision with buffered writes! File: %pD4 Comm: %.20s\n",
-				    dio->iocb->ki_filp, current->comm);
+				    dio->iocb->ki_filp, current->comm_str);
 		return -EIO;
 	default:
 		WARN_ON_ONCE(1);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index c7867139af69..800c5aa86d49 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -329,7 +329,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	    rsv_blocks + blocks > jbd2_max_user_trans_buffers(journal)) {
 		printk(KERN_ERR "JBD2: %s wants too many credits "
 		       "credits:%d rsv_credits:%d max:%d\n",
-		       current->comm, blocks, rsv_blocks,
+		       current->comm_str, blocks, rsv_blocks,
 		       jbd2_max_user_trans_buffers(journal));
 		WARN_ON(1);
 		return -ENOSPC;
diff --git a/fs/locks.c b/fs/locks.c
index 559f02aa4172..ba204c8b2316 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2146,7 +2146,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 	 * throw a warning to let people know that they don't actually work.
 	 */
 	if (cmd & LOCK_MAND) {
-		pr_warn_once("%s(%d): Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.\n", current->comm, current->pid);
+		pr_warn_once("%s(%d): Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.\n", current->comm_str, current->pid);
 		return 0;
 	}
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d4f16fefd965..2988d5cf3c88 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -443,7 +443,7 @@ void fscache_create_volume(struct fscache_volume *volume, bool wait);
  * debug tracing
  */
 #define dbgprintk(FMT, ...) \
-	printk("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
+	printk("[%-6.6s] "FMT"\n", current->comm_str, ##__VA_ARGS__)
 
 #define kenter(FMT, ...) dbgprintk("==> %s("FMT")", __func__, ##__VA_ARGS__)
 #define kleave(FMT, ...) dbgprintk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
diff --git a/fs/proc/base.c b/fs/proc/base.c
index e93149a01341..7f05e8b8f09a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1144,7 +1144,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
 		 * /proc/pid/oom_score_adj instead.
 		 */
 		pr_warn_once("%s (%d): /proc/%d/oom_adj is deprecated, please use /proc/%d/oom_score_adj instead.\n",
-			  current->comm, task_pid_nr(current), task_pid_nr(task),
+			  current->comm_str, task_pid_nr(current), task_pid_nr(task),
 			  task_pid_nr(task));
 	} else {
 		if ((short)oom_adj < task->signal->oom_score_adj_min &&
diff --git a/fs/read_write.c b/fs/read_write.c
index c5b6265d984b..5cb15fa8a3ed 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -499,7 +499,7 @@ static int warn_unsupported(struct file *file, const char *op)
 {
 	pr_warn_ratelimited(
 		"kernel %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
-		op, file, current->pid, current->comm);
+		op, file, current->pid, current->comm_str);
 	return -EINVAL;
 }
 
diff --git a/fs/splice.c b/fs/splice.c
index 4d6df083e0c0..b02395d5921f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -920,7 +920,7 @@ static int warn_unsupported(struct file *file, const char *op)
 {
 	pr_debug_ratelimited(
 		"splice %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
-		op, file, current->pid, current->comm);
+		op, file, current->pid, current->comm_str);
 	return -EINVAL;
 }
 
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 988b233dcc09..a53e5fe41b05 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -54,7 +54,7 @@ extern void vfs_coredump(const kernel_siginfo_t *siginfo);
 	do {	\
 		char comm[TASK_COMM_LEN];	\
 		/* This will always be NUL terminated. */ \
-		memcpy(comm, current->comm, TASK_COMM_LEN); \
+		memcpy(comm, current->comm_str, TASK_COMM_LEN); \
 		comm[TASK_COMM_LEN - 1] = '\0'; \
 		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
 			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
diff --git a/include/linux/filter.h b/include/linux/filter.h
index eca229752cbe..2ae63a4c54c8 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1285,7 +1285,7 @@ static inline void bpf_jit_dump(unsigned int flen, unsigned int proglen,
 				u32 pass, void *image)
 {
 	pr_err("flen=%u proglen=%u pass=%u image=%pK from=%s pid=%d\n", flen,
-	       proglen, pass, image, current->comm, task_pid_nr(current));
+	       proglen, pass, image, current->comm_str, task_pid_nr(current));
 
 	if (image)
 		print_hex_dump(KERN_ERR, "JIT code: ", DUMP_PREFIX_OFFSET,
diff --git a/include/linux/ratelimit.h b/include/linux/ratelimit.h
index 7aaad158ee37..751cd81867ef 100644
--- a/include/linux/ratelimit.h
+++ b/include/linux/ratelimit.h
@@ -58,7 +58,7 @@ static inline void ratelimit_state_exit(struct ratelimit_state *rs)
 
 	m = ratelimit_state_reset_miss(rs);
 	if (m)
-		pr_warn("%s: %d output lines suppressed due to ratelimiting\n", current->comm, m);
+		pr_warn("%s: %d output lines suppressed due to ratelimiting\n", current->comm_str, m);
 }
 
 static inline void
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a4a23267a982..1cdfb024173e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -316,6 +316,7 @@ struct user_event_mm;
  */
 enum {
 	TASK_COMM_LEN = 16,
+	TASK_COMM_EXT_LEN = 64,
 };
 
 extern void sched_tick(void);
@@ -1158,7 +1159,7 @@ struct task_struct {
 	 *   - logic inside set_task_comm() will ensure it is always NUL-terminated and
 	 *     zero-padded
 	 */
-	char				comm[TASK_COMM_LEN];
+	char				comm_str[TASK_COMM_EXT_LEN];
 
 	struct nameidata		*nameidata;
 
@@ -1941,7 +1942,7 @@ extern void kick_process(struct task_struct *tsk);
 
 extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec);
 #define set_task_comm(tsk, from) ({			\
-	BUILD_BUG_ON(sizeof(from) != TASK_COMM_LEN);	\
+	BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN);	\
 	__set_task_comm(tsk, from, false);		\
 })
 
@@ -1960,7 +1961,11 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
  */
 #define get_task_comm(buf, tsk) ({			\
 	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
-	strscpy_pad(buf, (tsk)->comm);			\
+	strscpy_pad(buf, (tsk)->comm_str);		\
+	if ((sizeof(buf)) == TASK_COMM_LEN)		\
+		buf[TASK_COMM_LEN - 1] = '\0';		\
+	else						\
+		buf[TASK_COMM_EXT_LEN - 1] = '\0';	\
 	buf;						\
 })
 
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..afb815189efc 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -121,7 +121,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.group_leader	= &init_task,
 	RCU_POINTER_INITIALIZER(real_cred, &init_cred),
 	RCU_POINTER_INITIALIZER(cred, &init_cred),
-	.comm		= INIT_TASK_COMM,
+	.comm_str	= INIT_TASK_COMM,
 	.thread		= INIT_THREAD,
 	.fs		= &init_fs,
 	.files		= &init_files,
diff --git a/ipc/sem.c b/ipc/sem.c
index a39cdc7bf88f..764d03a43f6c 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1083,7 +1083,7 @@ static int check_qop(struct sem_array *sma, int semnum, struct sem_queue *q,
 	 */
 	pr_info_once("semctl(GETNCNT/GETZCNT) is since 3.16 Single Unix Specification compliant.\n"
 			"The task %s (%d) triggered the difference, watch for misbehavior.\n",
-			current->comm, task_pid_nr(current));
+			current->comm_str, task_pid_nr(current));
 
 	if (sop->sem_num != semnum)
 		return 0;
diff --git a/kernel/acct.c b/kernel/acct.c
index 6520baa13669..2e4a029d97c9 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -481,7 +481,7 @@ static void fill_ac(struct bsd_acct_struct *acct)
 	memset(ac, 0, sizeof(acct_t));
 
 	ac->ac_version = ACCT_VERSION | ACCT_BYTEORDER;
-	strscpy(ac->ac_comm, current->comm, sizeof(ac->ac_comm));
+	strscpy(ac->ac_comm, current->comm_str, sizeof(ac->ac_comm));
 
 	/* calculate run_time in nsec*/
 	run_time = ktime_get_ns();
diff --git a/kernel/audit.c b/kernel/audit.c
index 61b5744d0bb6..cdead92ab251 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1600,7 +1600,7 @@ static void audit_log_multicast(int group, const char *op, int err)
 {
 	const struct cred *cred;
 	struct tty_struct *tty;
-	char comm[sizeof(current->comm)];
+	char comm[sizeof(current->comm_str)];
 	struct audit_buffer *ab;
 
 	if (!audit_enabled)
@@ -2243,7 +2243,7 @@ void audit_put_tty(struct tty_struct *tty)
 void audit_log_task_info(struct audit_buffer *ab)
 {
 	const struct cred *cred;
-	char comm[sizeof(current->comm)];
+	char comm[sizeof(current->comm_str)];
 	struct tty_struct *tty;
 
 	if (!ab)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index eb98cd6fe91f..89e7e972049e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2723,7 +2723,7 @@ void __audit_ptrace(struct task_struct *t)
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	strscpy(context->target_comm, t->comm);
+	strscpy(context->target_comm, t->comm_str);
 	security_task_getlsmprop_obj(t, &context->target_ref);
 }
 
@@ -2750,7 +2750,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		strscpy(ctx->target_comm, t->comm);
+		strscpy(ctx->target_comm, t->comm_str);
 		security_task_getlsmprop_obj(t, &ctx->target_ref);
 		return 0;
 	}
@@ -2772,7 +2772,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
 	security_task_getlsmprop_obj(t, &axp->target_ref[axp->pid_count]);
-	strscpy(axp->target_comm[axp->pid_count], t->comm);
+	strscpy(axp->target_comm[axp->pid_count], t->comm_str);
 	axp->pid_count++;
 
 	return 0;
@@ -2919,7 +2919,7 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
 		       enum audit_nfcfgop op, gfp_t gfp)
 {
 	struct audit_buffer *ab;
-	char comm[sizeof(current->comm)];
+	char comm[sizeof(current->comm_str)];
 
 	ab = audit_log_start(audit_context(), gfp, AUDIT_NETFILTER_CFG);
 	if (!ab)
@@ -2940,7 +2940,7 @@ static void audit_log_task(struct audit_buffer *ab)
 	kuid_t auid, uid;
 	kgid_t gid;
 	unsigned int sessionid;
-	char comm[sizeof(current->comm)];
+	char comm[sizeof(current->comm_str)];
 
 	auid = audit_get_loginuid(current);
 	sessionid = audit_get_sessionid(current);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6b4877e85a68..9c3e48f1348f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -266,7 +266,7 @@ BPF_CALL_2(bpf_get_current_comm, char *, buf, u32, size)
 		goto err_clear;
 
 	/* Verifier guarantees that size > 0 */
-	strscpy_pad(buf, task->comm, size);
+	strscpy_pad(buf, task->comm_str, size);
 	return 0;
 err_clear:
 	memset(buf, 0, size);
diff --git a/kernel/capability.c b/kernel/capability.c
index 829f49ae07b9..73f945dadb58 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -39,7 +39,7 @@ __setup("no_file_caps", file_caps_disable);
 static void warn_legacy_capability_use(void)
 {
 	pr_info_once("warning: `%s' uses 32-bit capabilities (legacy support in use)\n",
-		     current->comm);
+		     current->comm_str);
 }
 
 /*
@@ -61,7 +61,7 @@ static void warn_legacy_capability_use(void)
 static void warn_deprecated_v2(void)
 {
 	pr_info_once("warning: `%s' uses deprecated v2 capabilities in a way that may be insecure\n",
-		     current->comm);
+		     current->comm_str);
 }
 
 /*
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index fa24c032ed6f..05e6a54d710f 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1101,7 +1101,7 @@ int cgroup1_reconfigure(struct fs_context *fc)
 
 	if (ctx->subsys_mask != root->subsys_mask || ctx->release_agent)
 		pr_warn("option changes via remount are deprecated (pid=%d comm=%s)\n",
-			task_tgid_nr(current), current->comm);
+			task_tgid_nr(current), current->comm_str);
 
 	added_mask = ctx->subsys_mask & ~root->subsys_mask;
 	removed_mask = root->subsys_mask & ~ctx->subsys_mask;
diff --git a/kernel/cred.c b/kernel/cred.c
index 9676965c0981..2e5e9a60aee0 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -23,13 +23,13 @@
 #if 0
 #define kdebug(FMT, ...)						\
 	printk("[%-5.5s%5u] " FMT "\n",					\
-	       current->comm, current->pid, ##__VA_ARGS__)
+	       current->comm_str, current->pid, ##__VA_ARGS__)
 #else
 #define kdebug(FMT, ...)						\
 do {									\
 	if (0)								\
 		no_printk("[%-5.5s%5u] " FMT "\n",			\
-			  current->comm, current->pid, ##__VA_ARGS__);	\
+			  current->comm_str, current->pid, ##__VA_ARGS__);	\
 } while (0)
 #endif
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 22fdf0c187cd..e39c8556685a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8962,7 +8962,7 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	unsigned int size;
 
 	memset(comm, 0, sizeof(comm));
-	strscpy(comm, comm_event->task->comm);
+	strscpy(comm, comm_event->task->comm_str);
 	size = ALIGN(strlen(comm)+1, sizeof(u64));
 
 	comm_event->comm = comm;
diff --git a/kernel/exit.c b/kernel/exit.c
index f03caf17b214..198227a39eb9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -850,7 +850,7 @@ static void check_stack_usage(void)
 	spin_lock(&low_water_lock);
 	if (free < lowest_to_date) {
 		pr_info("%s (%d) used greatest stack depth: %lu bytes left\n",
-			current->comm, task_pid_nr(current), free);
+			current->comm_str, task_pid_nr(current), free);
 		lowest_to_date = free;
 	}
 	spin_unlock(&low_water_lock);
@@ -1023,12 +1023,12 @@ void __noreturn make_task_dead(int signr)
 
 	if (unlikely(irqs_disabled())) {
 		pr_info("note: %s[%d] exited with irqs disabled\n",
-			current->comm, task_pid_nr(current));
+			current->comm_str, task_pid_nr(current));
 		local_irq_enable();
 	}
 	if (unlikely(in_atomic())) {
 		pr_info("note: %s[%d] exited with preempt_count %d\n",
-			current->comm, task_pid_nr(current),
+			current->comm_str, task_pid_nr(current),
 			preempt_count());
 		preempt_count_set(PREEMPT_ENABLED);
 	}
diff --git a/kernel/fork.c b/kernel/fork.c
index cfe2f1df5f27..fd5bb94596ba 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1922,6 +1922,7 @@ __latent_entropy struct task_struct *copy_process(
 	struct file *pidfile = NULL;
 	const u64 clone_flags = args->flags;
 	struct nsproxy *nsp = current->nsproxy;
+	unsigned char comm[TASK_COMM_EXT_LEN];
 
 	/*
 	 * Don't allow sharing the root directory with processes in a different
@@ -2013,8 +2014,12 @@ __latent_entropy struct task_struct *copy_process(
 	if (args->io_thread)
 		p->flags |= PF_IO_WORKER;
 
-	if (args->name)
-		strscpy_pad(p->comm, args->name, sizeof(p->comm));
+	if (args->name) {
+		memcpy(comm, args->name, sizeof(p->comm_str) - 1);
+		comm[sizeof(p->comm_str) - 1] = '\0';
+
+		set_task_comm(p, comm);
+	}
 
 	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? args->child_tid : NULL;
 	/*
diff --git a/kernel/freezer.c b/kernel/freezer.c
index 8d530d0949ff..e5b066b7a166 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -64,7 +64,7 @@ bool __refrigerator(bool check_kthr_stop)
 	unsigned int state = get_current_state();
 	bool was_frozen = false;
 
-	pr_debug("%s entered refrigerator\n", current->comm);
+	pr_debug("%s entered refrigerator\n", current->comm_str);
 
 	WARN_ON_ONCE(state && !(state & TASK_NORMAL));
 
@@ -89,7 +89,7 @@ bool __refrigerator(bool check_kthr_stop)
 	}
 	__set_current_state(TASK_RUNNING);
 
-	pr_debug("%s left refrigerator\n", current->comm);
+	pr_debug("%s left refrigerator\n", current->comm_str);
 
 	return was_frozen;
 }
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index e2bbe5509ec2..d72246096c06 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -214,7 +214,7 @@ static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 			 * is sane again
 			 */
 			pr_info_ratelimited("futex_wake_op: %s tries to shift op by %d; fix this program\n",
-					    current->comm, oparg);
+					    current->comm_str, oparg);
 			oparg &= 31;
 		}
 		oparg = 1 << oparg;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a1205f82..470ad5bdfc47 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -138,11 +138,11 @@ static void debug_show_blocker(struct task_struct *task)
 		switch (blocker_type) {
 		case BLOCKER_TYPE_MUTEX:
 			pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
-			       task->comm, task->pid);
+			       task->comm_str, task->pid);
 			break;
 		case BLOCKER_TYPE_SEM:
 			pr_err("INFO: task %s:%d is blocked on a semaphore, but the last holder is not found.\n",
-			       task->comm, task->pid);
+			       task->comm_str, task->pid);
 			break;
 		case BLOCKER_TYPE_RWSEM_READER:
 		case BLOCKER_TYPE_RWSEM_WRITER:
@@ -161,11 +161,11 @@ static void debug_show_blocker(struct task_struct *task)
 		switch (blocker_type) {
 		case BLOCKER_TYPE_MUTEX:
 			pr_err("INFO: task %s:%d is blocked on a mutex likely owned by task %s:%d.\n",
-			       task->comm, task->pid, t->comm, t->pid);
+			       task->comm_str, task->pid, t->comm_str, t->pid);
 			break;
 		case BLOCKER_TYPE_SEM:
 			pr_err("INFO: task %s:%d blocked on a semaphore likely last held by task %s:%d\n",
-			       task->comm, task->pid, t->comm, t->pid);
+			       task->comm_str, task->pid, t->comm_str, t->pid);
 			break;
 		case BLOCKER_TYPE_RWSEM_READER:
 		case BLOCKER_TYPE_RWSEM_WRITER:
@@ -233,7 +233,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
+		       t->comm_str, t->pid, (jiffies - t->last_switch_time) / HZ);
 		pr_err("      %s %s %.*s\n",
 			print_tainted(), init_utsname()->release,
 			(int)strcspn(init_utsname()->version, " "),
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c94837382037..6f52730f86e4 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1175,7 +1175,7 @@ static void irq_thread_dtor(struct callback_head *unused)
 	action = kthread_data(tsk);
 
 	pr_err("exiting task \"%s\" (%d) is an active IRQ thread (irq %d)\n",
-	       tsk->comm, tsk->pid, action->irq);
+	       tsk->comm_str, tsk->pid, action->irq);
 
 
 	desc = irq_to_desc(action->irq);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 0e98b228a8ef..4222e531d487 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -108,7 +108,7 @@ void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk)
 	struct kthread *kthread = to_kthread(tsk);
 
 	if (!kthread || !kthread->full_name) {
-		strscpy(buf, tsk->comm, buf_size);
+		strscpy(buf, tsk->comm_str, buf_size);
 		return;
 	}
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c80902eacd79..ab883220d4e8 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -712,7 +712,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 			prev_max = max_lock_depth;
 			printk(KERN_WARNING "Maximum lock depth %d reached "
 			       "task: %s (%d)\n", max_lock_depth,
-			       top_task->comm, task_pid_nr(top_task));
+			       top_task->comm_str, task_pid_nr(top_task));
 		}
 		put_task_struct(task);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0efbcdda9aab..ba7f690c8ba9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -777,7 +777,7 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
 
 	/* Ratelimit when not explicitly enabled. */
 	if (!(devkmsg_log & DEVKMSG_LOG_MASK_ON)) {
-		if (!___ratelimit(&user->rs, current->comm))
+		if (!___ratelimit(&user->rs, current->comm_str))
 			return ret;
 	}
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ae360daf7d80..c4c437b1a035 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3240,7 +3240,7 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
 out_set_mask:
 	if (printk_ratelimit()) {
 		printk_deferred("Overriding affinity for process %d (%s) to CPUs %*pbl\n",
-				task_pid_nr(p), p->comm,
+				task_pid_nr(p), p->comm_str,
 				cpumask_pr_args(override_mask));
 	}
 
@@ -3545,7 +3545,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 		 */
 		if (p->mm && printk_ratelimit()) {
 			printk_deferred("process %d (%s) no longer affine to cpu%d\n",
-					task_pid_nr(p), p->comm, cpu);
+					task_pid_nr(p), p->comm_str, cpu);
 		}
 	}
 
@@ -5156,7 +5156,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 */
 	if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,
 		      "corrupted preempt_count: %s/%d/0x%x\n",
-		      current->comm, current->pid, preempt_count()))
+		      current->comm_str, current->pid, preempt_count()))
 		preempt_count_set(FORK_PREEMPT_COUNT);
 
 	rq->prev_mm = NULL;
@@ -5849,7 +5849,7 @@ static noinline void __schedule_bug(struct task_struct *prev)
 		return;
 
 	printk(KERN_ERR "BUG: scheduling while atomic: %s/%d/0x%08x\n",
-		prev->comm, prev->pid, preempt_count());
+		prev->comm_str, prev->pid, preempt_count());
 
 	debug_show_held_locks(prev);
 	print_modules();
@@ -5881,7 +5881,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	if (!preempt && READ_ONCE(prev->__state) && prev->non_block_count) {
 		printk(KERN_ERR "BUG: scheduling in a non-blocking section: %s/%d/%i\n",
-			prev->comm, prev->pid, prev->non_block_count);
+			prev->comm_str, prev->pid, prev->non_block_count);
 		dump_stack();
 		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 	}
@@ -7645,7 +7645,7 @@ void sched_show_task(struct task_struct *p)
 	if (!try_get_task_stack(p))
 		return;
 
-	pr_info("task:%-15.15s state:%c", p->comm, task_state_to_char(p));
+	pr_info("task:%-15.15s state:%c", p->comm_str, task_state_to_char(p));
 
 	if (task_is_running(p))
 		pr_cont("  running task    ");
@@ -7786,7 +7786,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	idle->sched_class = &idle_sched_class;
 	ftrace_graph_init_idle_task(idle, cpu);
 	vtime_init_idle(idle, cpu);
-	sprintf(idle->comm, "%s/%d", INIT_TASK_COMM, cpu);
+	sprintf(idle->comm_str, "%s/%d", INIT_TASK_COMM, cpu);
 }
 
 int cpuset_cpumask_can_shrink(const struct cpumask *cur,
@@ -8322,7 +8322,7 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
 		if (!task_on_rq_queued(p))
 			continue;
 
-		printk("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);
+		printk("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm_str);
 	}
 }
 
@@ -8667,7 +8667,7 @@ void __might_resched(const char *file, int line, unsigned int offsets)
 	       file, line);
 	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
 	       in_atomic(), irqs_disabled(), current->non_block_count,
-	       current->pid, current->comm);
+	       current->pid, current->comm_str);
 	pr_err("preempt_count: %x, expected: %x\n", preempt_count(),
 	       offsets & MIGHT_RESCHED_PREEMPT_MASK);
 
@@ -8711,7 +8711,7 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 	printk(KERN_ERR "BUG: assuming atomic context at %s:%d\n", file, line);
 	printk(KERN_ERR "in_atomic(): %d, irqs_disabled(): %d, pid: %d, name: %s\n",
 			in_atomic(), irqs_disabled(),
-			current->pid, current->comm);
+			current->pid, current->comm_str);
 
 	debug_show_held_locks(current);
 	dump_stack();
@@ -8743,7 +8743,7 @@ void __cant_migrate(const char *file, int line)
 	pr_err("BUG: assuming non migratable context at %s:%d\n", file, line);
 	pr_err("in_atomic(): %d, irqs_disabled(): %d, migration_disabled() %u pid: %d, name: %s\n",
 	       in_atomic(), irqs_disabled(), is_migration_disabled(current),
-	       current->pid, current->comm);
+	       current->pid, current->comm_str);
 
 	debug_show_held_locks(current);
 	dump_stack();
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3f06ab84d53f..24db33d9016e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -734,7 +734,7 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
 	SEQ_printf(m, " %15s %5d %9Ld.%06ld   %c   %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld   %5d ",
-		p->comm, task_pid_nr(p),
+		p->comm_str, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
 		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
 		SPLIT_NS(p->se.deadline),
@@ -1150,7 +1150,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 {
 	unsigned long nr_switches;
 
-	SEQ_printf(m, "%s (%d, #threads: %d)\n", p->comm, task_pid_nr_ns(p, ns),
+	SEQ_printf(m, "%s (%d, #threads: %d)\n", p->comm_str, task_pid_nr_ns(p, ns),
 						get_nr_threads(p));
 	SEQ_printf(m,
 		"---------------------------------------------------------"
diff --git a/kernel/signal.c b/kernel/signal.c
index e2c928de7d2c..de0e1a413d04 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -257,7 +257,7 @@ static inline void print_dropped_signal(int sig)
 		return;
 
 	pr_info("%s/%d: reached RLIMIT_SIGPENDING, dropped signal %d\n",
-				current->comm, current->pid, sig);
+				current->comm_str, current->pid, sig);
 }
 
 /**
@@ -1224,11 +1224,11 @@ static void print_fatal_signal(int signr)
 	exe_file = get_task_exe_file(current);
 	if (exe_file) {
 		pr_info("%pD: %s: potentially unexpected fatal signal %d.\n",
-			exe_file, current->comm, signr);
+			exe_file, current->comm_str, signr);
 		fput(exe_file);
 	} else {
 		pr_info("%s: potentially unexpected fatal signal %d.\n",
-			current->comm, signr);
+			current->comm_str, signr);
 	}
 
 #if defined(__i386__) && !defined(__arch_um__)
diff --git a/kernel/sys.c b/kernel/sys.c
index 1e28b40053ce..25c79f78fbbf 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2456,7 +2456,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
 	struct task_struct *me = current;
-	unsigned char comm[sizeof(me->comm)];
+	unsigned char comm[sizeof(me->comm_str)];
 	long error;
 
 	error = security_task_prctl(option, arg2, arg3, arg4, arg5);
@@ -2512,9 +2512,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			error = -EINVAL;
 		break;
 	case PR_SET_NAME:
-		comm[sizeof(me->comm) - 1] = 0;
+		comm[sizeof(me->comm_str) - 1] = 0;
 		if (strncpy_from_user(comm, (char __user *)arg2,
-				      sizeof(me->comm) - 1) < 0)
+				      sizeof(me->comm_str) - 1) < 0)
 			return -EFAULT;
 		set_task_comm(me, comm);
 		proc_comm_connector(me);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cb6196e3fa99..e5bceda6fc3d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -140,7 +140,7 @@ static void warn_sysctl_write(const struct ctl_table *table)
 	pr_warn_once("%s wrote to %s when file position was not 0!\n"
 		"This will not be supported in the future. To silence this\n"
 		"warning, set kernel.sysctl_writes_strict = -1\n",
-		current->comm, table->procname);
+		current->comm_str, table->procname);
 }
 
 /**
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 876d389b2e21..7fda10130508 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -363,7 +363,7 @@ SYSCALL_DEFINE3(setitimer, int, which, struct __kernel_old_itimerval __user *, v
 		memset(&set_buffer, 0, sizeof(set_buffer));
 		printk_once(KERN_WARNING "%s calls setitimer() with new_value NULL pointer."
 			    " Misfeature support will be removed\n",
-			    current->comm);
+			    current->comm_str);
 	}
 
 	error = do_setitimer(which, &set_buffer, ovalue ? &get_buffer : NULL);
@@ -410,7 +410,7 @@ COMPAT_SYSCALL_DEFINE3(setitimer, int, which,
 		memset(&set_buffer, 0, sizeof(set_buffer));
 		printk_once(KERN_WARNING "%s calls setitimer() with new_value NULL pointer."
 			    " Misfeature support will be removed\n",
-			    current->comm);
+			    current->comm_str);
 	}
 
 	error = do_setitimer(which, &set_buffer, ovalue ? &get_buffer : NULL);
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 2e5b89d7d866..19ed72294481 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -851,7 +851,7 @@ static bool check_rlimit(u64 time, u64 limit, int signo, bool rt, bool hard)
 	if (print_fatal_signals) {
 		pr_info("%s Watchdog Timeout (%s): %s[%d]\n",
 			rt ? "RT" : "CPU", hard ? "hard" : "soft",
-			current->comm, task_pid_nr(current));
+			current->comm_str, task_pid_nr(current));
 	}
 	send_signal_locked(signo, SEND_SIG_PRIV, current, PIDTYPE_TGID);
 	return true;
diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 16b283f9d831..6eaa5e0e20b4 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -76,7 +76,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	stats->ac_minflt = tsk->min_flt;
 	stats->ac_majflt = tsk->maj_flt;
 
-	strscpy_pad(stats->ac_comm, tsk->comm);
+	strscpy_pad(stats->ac_comm, tsk->comm_str);
 }
 
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ae99311f1a96..a573cd6b26b3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3252,7 +3252,7 @@ __acquires(&pool->lock)
 		     rcu_preempt_depth() != rcu_start_depth)) {
 		pr_err("BUG: workqueue leaked atomic, lock or RCU: %s[%d]\n"
 		       "     preempt=0x%08x lock=%d->%d RCU=%d->%d workfn=%ps\n",
-		       current->comm, task_pid_nr(current), preempt_count(),
+		       current->comm_str, task_pid_nr(current), preempt_count(),
 		       lockdep_start_depth, lockdep_depth(current),
 		       rcu_start_depth, rcu_preempt_depth(),
 		       worker->current_func);
@@ -3716,7 +3716,7 @@ static void check_flush_dependency(struct workqueue_struct *target_wq,
 
 	WARN_ONCE(current->flags & PF_MEMALLOC,
 		  "workqueue: PF_MEMALLOC task %d(%s) is flushing !WQ_MEM_RECLAIM %s:%ps",
-		  current->pid, current->comm, target_wq->name, target_func);
+		  current->pid, current->comm_str, target_wq->name, target_func);
 	WARN_ONCE(worker && ((worker->current_pwq->wq->flags &
 			      (WQ_MEM_RECLAIM | __WQ_LEGACY)) == WQ_MEM_RECLAIM),
 		  "workqueue: WQ_MEM_RECLAIM %s:%ps is flushing !WQ_MEM_RECLAIM %s:%ps",
@@ -6486,7 +6486,7 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
 			raw_spin_unlock_irq(&pool->lock);
 		}
 	} else {
-		strscpy(buf, task->comm, size);
+		strscpy(buf, task->comm_str, size);
 	}
 
 	mutex_unlock(&wq_pool_attach_mutex);
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index b3a85fe8b673..5ebf7503f3c6 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -57,7 +57,7 @@ void dump_stack_print_info(const char *log_lvl)
 	printk("%sCPU: %d UID: %u PID: %d Comm: %.20s %s%s %s %.*s %s " BUILD_ID_FMT "\n",
 	       log_lvl, raw_smp_processor_id(),
 	       __kuid_val(current_real_cred()->euid),
-	       current->pid, current->comm,
+	       current->pid, current->comm_str,
 	       kexec_crash_loaded() ? "Kdump: loaded " : "",
 	       print_tainted(),
 	       init_utsname()->release,
diff --git a/lib/nlattr.c b/lib/nlattr.c
index be9c576b6e2d..994a4ae5b2ec 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -212,7 +212,7 @@ static int nla_validate_range_unsigned(const struct nla_policy *pt,
 	if (pt->validation_type == NLA_VALIDATE_RANGE_WARN_TOO_LONG &&
 	    pt->type == NLA_BINARY && value > range.max) {
 		pr_warn_ratelimited("netlink: '%s': attribute type %d has an invalid length.\n",
-				    current->comm, pt->type);
+				    current->comm_str, pt->type);
 		if (validate & NL_VALIDATE_STRICT_ATTRS) {
 			NL_SET_ERR_MSG_ATTR_POL(extack, nla, pt,
 						"invalid attribute length");
@@ -412,7 +412,7 @@ static int validate_nla(const struct nlattr *nla, int maxtype,
 
 	if (nla_attr_len[pt->type] && attrlen != nla_attr_len[pt->type]) {
 		pr_warn_ratelimited("netlink: '%s': attribute type %d has an invalid length.\n",
-				    current->comm, type);
+				    current->comm_str, type);
 		if (validate & NL_VALIDATE_STRICT_ATTRS) {
 			NL_SET_ERR_MSG_ATTR_POL(extack, nla, pt,
 						"invalid attribute length");
@@ -645,7 +645,7 @@ static int __nla_validate_parse(const struct nlattr *head, int len, int maxtype,
 
 	if (unlikely(rem > 0)) {
 		pr_warn_ratelimited("netlink: %d bytes leftover after parsing attributes in process `%s'.\n",
-				    rem, current->comm);
+				    rem, current->comm_str);
 		NL_SET_ERR_MSG(extack, "bytes leftover after parsing attributes");
 		if (validate & NL_VALIDATE_TRAILING)
 			return -EINVAL;
diff --git a/mm/compaction.c b/mm/compaction.c
index bf021b31c7ec..e89741a68834 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3278,7 +3278,7 @@ static int proc_dointvec_minmax_warn_RT_change(const struct ctl_table *table,
 		return ret;
 	if (old != *(int *)table->data)
 		pr_warn_once("sysctl attribute %s changed by %s[%d]\n",
-			     table->procname, current->comm,
+			     table->procname, current->comm_str,
 			     task_pid_nr(current));
 	return ret;
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index 413492492b5a..085335253b11 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -154,7 +154,7 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 	VM_BUG_ON_FOLIO(folio_mapped(folio), folio);
 	if (!IS_ENABLED(CONFIG_DEBUG_VM) && unlikely(folio_mapped(folio))) {
 		pr_alert("BUG: Bad page cache in process %s  pfn:%05lx\n",
-			 current->comm, folio_pfn(folio));
+			 current->comm_str, folio_pfn(folio));
 		dump_page(&folio->page, "still mapped when deleted");
 		dump_stack();
 		add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
@@ -4084,7 +4084,7 @@ static void dio_warn_stale_pagecache(struct file *filp)
 			path = "(unknown)";
 		pr_crit("Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!\n");
 		pr_crit("File: %s PID: %d Comm: %.20s\n", path, current->pid,
-			current->comm);
+			current->comm_str);
 	}
 }
 
diff --git a/mm/gup.c b/mm/gup.c
index adffe663594d..ca529d439e72 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1308,7 +1308,7 @@ static struct vm_area_struct *gup_vma_lookup(struct mm_struct *mm,
 
 	/* Let people know things may have changed. */
 	pr_warn("GUP no longer grows the stack in %s (%d): %lx-%lx (%lx)\n",
-		current->comm, task_pid_nr(current),
+		current->comm_str, task_pid_nr(current),
 		vma->vm_start, vma->vm_end, addr);
 	dump_stack();
 	return NULL;
diff --git a/mm/memfd.c b/mm/memfd.c
index bbe679895ef6..acfdb41ed161 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -331,7 +331,7 @@ static int check_sysctl_memfd_noexec(unsigned int *flags)
 	if (!(*flags & MFD_NOEXEC_SEAL) && sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED) {
 		pr_err_ratelimited(
 			"%s[%d]: memfd_create() requires MFD_NOEXEC_SEAL with vm.memfd_noexec=%d\n",
-			current->comm, task_pid_nr(current), sysctl);
+			current->comm_str, task_pid_nr(current), sysctl);
 		return -EACCES;
 	}
 #endif
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 003b51e4adc0..b81dd0b7a5a3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -354,7 +354,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 	int ret = 0;
 
 	pr_err("%#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
-			pfn, t->comm, task_pid_nr(t));
+			pfn, t->comm_str, task_pid_nr(t));
 
 	if ((flags & MF_ACTION_REQUIRED) && (t == current))
 		ret = force_sig_mceerr(BUS_MCEERR_AR,
@@ -370,7 +370,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 				      addr_lsb, t);
 	if (ret < 0)
 		pr_info("Error sending signal to %s:%d: %d\n",
-			t->comm, task_pid_nr(t), ret);
+			t->comm_str, task_pid_nr(t), ret);
 	return ret;
 }
 
@@ -475,7 +475,7 @@ static void __add_to_kill(struct task_struct *tsk, const struct page *p,
 	 */
 	if (tk->addr == -EFAULT) {
 		pr_info("Unable to find user space address %lx in %s\n",
-			page_to_pfn(p), tsk->comm);
+			page_to_pfn(p), tsk->comm_str);
 	} else if (tk->size_shift == 0) {
 		kfree(tk);
 		return;
@@ -532,7 +532,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill,
 		if (forcekill) {
 			if (tk->addr == -EFAULT) {
 				pr_err("%#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
-				       pfn, tk->tsk->comm, task_pid_nr(tk->tsk));
+				       pfn, tk->tsk->comm_str, task_pid_nr(tk->tsk));
 				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
 						 tk->tsk, PIDTYPE_PID);
 			}
@@ -545,7 +545,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill,
 			 */
 			else if (kill_proc(tk, pfn, flags) < 0)
 				pr_err("%#lx: Cannot send advisory machine check signal to %s:%d\n",
-				       pfn, tk->tsk->comm, task_pid_nr(tk->tsk));
+				       pfn, tk->tsk->comm_str, task_pid_nr(tk->tsk));
 		}
 		list_del(&tk->nd);
 		put_task_struct(tk->tsk);
diff --git a/mm/memory.c b/mm/memory.c
index 4020639593ce..c7049ced1ae3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -540,7 +540,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 	index = linear_page_index(vma, addr);
 
 	pr_alert("BUG: Bad page map in process %s  pte:%08llx pmd:%08llx\n",
-		 current->comm,
+		 current->comm_str,
 		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
 	if (page)
 		dump_page(page, "bad pte");
diff --git a/mm/mmap.c b/mm/mmap.c
index 7306253cc3b5..c5971b26b005 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1096,7 +1096,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	vm_flags_t vm_flags;
 
 	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.\n",
-		     current->comm, current->pid);
+		     current->comm_str, current->pid);
 
 	if (prot)
 		return ret;
@@ -1334,7 +1334,7 @@ bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags, unsigned long npages)
 			return true;
 
 		pr_warn_once("%s (%d): VmData %lu exceed data ulimit %lu. Update limits%s.\n",
-			     current->comm, current->pid,
+			     current->comm_str, current->pid,
 			     (mm->data_vm + npages) << PAGE_SHIFT,
 			     rlimit(RLIMIT_DATA),
 			     ignore_rlimit_data ? "" : " or use boot option ignore_rlimit_data");
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..023eec5ec9c3 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -406,7 +406,7 @@ static int dump_task(struct task_struct *p, void *arg)
 		get_mm_counter(task->mm, MM_ANONPAGES), get_mm_counter(task->mm, MM_FILEPAGES),
 		get_mm_counter(task->mm, MM_SHMEMPAGES), mm_pgtables_bytes(task->mm),
 		get_mm_counter(task->mm, MM_SWAPENTS),
-		task->signal->oom_score_adj, task->comm);
+		task->signal->oom_score_adj, task->comm_str);
 	task_unlock(task);
 
 	return 0;
@@ -452,14 +452,14 @@ static void dump_oom_victim(struct oom_control *oc, struct task_struct *victim)
 			nodemask_pr_args(oc->nodemask));
 	cpuset_print_current_mems_allowed();
 	mem_cgroup_print_oom_context(oc->memcg, victim);
-	pr_cont(",task=%s,pid=%d,uid=%d\n", victim->comm, victim->pid,
+	pr_cont(",task=%s,pid=%d,uid=%d\n", victim->comm_str, victim->pid,
 		from_kuid(&init_user_ns, task_uid(victim)));
 }
 
 static void dump_header(struct oom_control *oc)
 {
 	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
-		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
+		current->comm_str, oc->gfp_mask, &oc->gfp_mask, oc->order,
 			current->signal->oom_score_adj);
 	if (!IS_ENABLED(CONFIG_COMPACTION) && oc->order)
 		pr_warn("COMPACTION is disabled!!!\n");
@@ -596,7 +596,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 		goto out_finish;
 
 	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
-			task_pid_nr(tsk), tsk->comm,
+			task_pid_nr(tsk), tsk->comm_str,
 			K(get_mm_counter(mm, MM_ANONPAGES)),
 			K(get_mm_counter(mm, MM_FILEPAGES)),
 			K(get_mm_counter(mm, MM_SHMEMPAGES)));
@@ -623,7 +623,7 @@ static void oom_reap_task(struct task_struct *tsk)
 		goto done;
 
 	pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
-		task_pid_nr(tsk), tsk->comm);
+		task_pid_nr(tsk), tsk->comm_str);
 	sched_show_task(tsk);
 	debug_show_all_locks();
 
@@ -927,7 +927,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	p = find_lock_task_mm(victim);
 	if (!p) {
 		pr_info("%s: OOM victim %d (%s) is already exiting. Skip killing the task\n",
-			message, task_pid_nr(victim), victim->comm);
+			message, task_pid_nr(victim), victim->comm_str);
 		put_task_struct(victim);
 		return;
 	} else if (victim != p) {
@@ -952,7 +952,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
 	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
-		message, task_pid_nr(victim), victim->comm, K(mm->total_vm),
+		message, task_pid_nr(victim), victim->comm_str, K(mm->total_vm),
 		K(get_mm_counter(mm, MM_ANONPAGES)),
 		K(get_mm_counter(mm, MM_FILEPAGES)),
 		K(get_mm_counter(mm, MM_SHMEMPAGES)),
@@ -979,8 +979,8 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 			can_oom_reap = false;
 			set_bit(MMF_OOM_SKIP, &mm->flags);
 			pr_info("oom killer %d (%s) has mm pinned by %d (%s)\n",
-					task_pid_nr(victim), victim->comm,
-					task_pid_nr(p), p->comm);
+					task_pid_nr(victim), victim->comm_str,
+					task_pid_nr(p), p->comm_str);
 			continue;
 		}
 		/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fa09154a799c..92de19bdf9d4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -643,7 +643,7 @@ static void bad_page(struct page *page, const char *reason)
 		resume = jiffies + 60 * HZ;
 
 	pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
-		current->comm, page_to_pfn(page));
+		current->comm_str, page_to_pfn(page));
 	dump_page(page, reason);
 
 	print_modules();
@@ -3923,7 +3923,7 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	pr_warn("%s: %pV, mode:%#x(%pGg), nodemask=%*pbl",
-			current->comm, &vaf, gfp_mask, &gfp_mask,
+			current->comm_str, &vaf, gfp_mask, &gfp_mask,
 			nodemask_pr_args(nodemask));
 	va_end(args);
 
diff --git a/mm/util.c b/mm/util.c
index 68ea833ba25f..0995f8e90edb 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -965,7 +965,7 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 error:
 	bytes_failed = pages << PAGE_SHIFT;
 	pr_warn_ratelimited("%s: pid: %d, comm: %s, bytes: %lu not enough memory for the allocation\n",
-			    __func__, current->pid, current->comm, bytes_failed);
+			    __func__, current->pid, current->comm_str, bytes_failed);
 	vm_unacct_memory(pages);
 
 	return -ENOMEM;
diff --git a/net/core/sock.c b/net/core/sock.c
index 8b7623c7d547..516eab62f3c9 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -443,7 +443,7 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 		if (warned < 10 && net_ratelimit()) {
 			warned++;
 			pr_info("%s: `%s' (pid %d) tries to set negative timeout\n",
-				__func__, current->comm, task_pid_nr(current));
+				__func__, current->comm_str, task_pid_nr(current));
 		}
 		return 0;
 	}
diff --git a/net/dns_resolver/internal.h b/net/dns_resolver/internal.h
index 0c570d40e4d6..447b1256bf42 100644
--- a/net/dns_resolver/internal.h
+++ b/net/dns_resolver/internal.h
@@ -44,7 +44,7 @@ extern unsigned int dns_resolver_debug;
 do {							\
 	if (unlikely(dns_resolver_debug))		\
 		printk(KERN_DEBUG "[%-6.6s] "FMT"\n",	\
-		       current->comm, ##__VA_ARGS__);	\
+		       current->comm_str, ##__VA_ARGS__);	\
 } while (0)
 
 #define kenter(FMT, ...) kdebug("==> %s("FMT")", __func__, ##__VA_ARGS__)
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 1d2c89d63cc7..5037968c95dd 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -520,7 +520,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			goto out;
 		if (usin->sin_family != AF_INET) {
 			pr_info_once("%s: %s forgot to set AF_INET. Fix it!\n",
-				     __func__, current->comm);
+				     __func__, current->comm_str);
 			err = -EAFNOSUPPORT;
 			if (usin->sin_family)
 				goto out;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 31149a0ac849..c98e4d577ea3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2761,7 +2761,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 		if ((flags & MSG_PEEK) &&
 		    (peek_seq - peek_offset - copied - urg_hole != tp->copied_seq)) {
 			net_dbg_ratelimited("TCP(%s:%d): Application bug, race in MSG_PEEK\n",
-					    current->comm,
+					    current->comm_str,
 					    task_pid_nr(current));
 			peek_seq = tp->copied_seq + peek_offset;
 		}
diff --git a/net/socket.c b/net/socket.c
index 682969deaed3..df2f3d0c10b4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1537,7 +1537,7 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	 */
 	if (family == PF_INET && type == SOCK_PACKET) {
 		pr_info_once("%s uses obsolete (PF_INET,SOCK_PACKET)\n",
-			     current->comm);
+			     current->comm_str);
 		family = PF_PACKET;
 	}
 
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 7d623b00495c..c64dce81e4f2 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -274,7 +274,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 		if (tsk) {
 			pid_t pid = task_tgid_nr(tsk);
 			if (pid) {
-				char tskcomm[sizeof(tsk->comm)];
+				char tskcomm[TASK_COMM_LEN];
 				audit_log_format(ab, " opid=%d ocomm=", pid);
 				audit_log_untrustedstring(ab,
 				    get_task_comm(tskcomm, tsk));
@@ -414,7 +414,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 static void dump_common_audit_data(struct audit_buffer *ab,
 				   const struct common_audit_data *a)
 {
-	char comm[sizeof(current->comm)];
+	char comm[TASK_COMM_LEN];
 
 	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
 	audit_log_untrustedstring(ab, get_task_comm(comm, current));
-- 
2.38.1


