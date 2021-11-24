Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43D445B67B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 09:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbhKXI1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 03:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241344AbhKXI1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:27:37 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CB8C061714
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 00:24:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id iq11so1885378pjb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 00:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miWQ12v1rFyWeFj0ywtsPS7M9e50Ctd840Y83iFhuvo=;
        b=zxVqHeA+pPKBuzRNn2boRHGxfwEJeYpYhwK2lPv+H08Mgz+ldNTNHPnh4cSPLYAARU
         SYT0bCqsqinbWnjJxA3cXhKdvcMm+lpA6EhYWs05wL4R69DzkWw2dslPeT7NTvHUfEJ4
         xv2mo1SptKqpF+ijgN4oDuM7fVRM/dKWcGx0JzmzxXGtqwud/CK4R4NxvIeFZsWeADkC
         1/k375ep4PEXcyAmKeyUDg9endCZhA8oACihPyvEaZSOP0mRob0aExi1krh0L1gVlYrO
         UeBMbDvTehX+GDI8aIGecXKw9PcpE9m9Ahdf3AsaMVjMCOLbpJtHZfzphzQ7wHcggtxu
         /aUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miWQ12v1rFyWeFj0ywtsPS7M9e50Ctd840Y83iFhuvo=;
        b=s7n9PJW8lRcHHBsFrxyJuEMF4vLfMQdZDPSKRfiD03JZeLClon/nIXHUYBromv334d
         /PTypToYRqqiqwb/hJZoCwkm0W358UPMHcC60sxkMc0yjfGhNknJ+jcos+OdtS9cJ+3h
         96XTjpPgYzHVl45L93hf6J7RQfMUPpbr7nNMEGFqmOfXwelnc5QEPKh2zeHyp3kwZFw2
         0EcUImhuHkfg4nVj7Mqfknif0UeDaMacI8NTFvMOz/sR8KO6eE01cswvQ9g/odKesXGT
         D6pHRV85WaMGsRT5vpSj/3F837ZtKaWQFoAYip98BsXFUtf8mux4csXXMFhkQy2nEIew
         sRug==
X-Gm-Message-State: AOAM531UDSR21aHf2OTCWFOOswcYvYTpROLLSfUrXpJouiXxtrxpVGZU
        LLWi31aG3kz+Il/Zs/bP2XOSMA==
X-Google-Smtp-Source: ABdhPJy9sSgt4jSQK9x4Cpa7Kmy+/Zw0omY0K6DofwOEHMY4aRf+IHOGfOyqwv460o5v8mmYrT+frQ==
X-Received: by 2002:a17:902:d488:b0:141:f3a3:d2f4 with SMTP id c8-20020a170902d48800b00141f3a3d2f4mr16232904plg.86.1637742266470;
        Wed, 24 Nov 2021 00:24:26 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id v38sm10451521pgl.38.2021.11.24.00.24.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 00:24:26 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        gladkov.alexey@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 2/2] proc: remove PDE_DATA() completely
Date:   Wed, 24 Nov 2021 16:19:56 +0800
Message-Id: <20211124081956.87711-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211124081956.87711-1-songmuchun@bytedance.com>
References: <20211124081956.87711-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove PDE_DATA() completely and replace it with pde_data().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/alpha/kernel/srm_env.c                        |  4 ++--
 arch/arm/kernel/atags_proc.c                       |  2 +-
 arch/ia64/kernel/salinfo.c                         | 10 ++++-----
 arch/powerpc/kernel/proc_powerpc.c                 |  4 ++--
 arch/sh/mm/alignment.c                             |  2 +-
 arch/xtensa/platforms/iss/simdisk.c                |  4 ++--
 drivers/acpi/proc.c                                |  2 +-
 drivers/hwmon/dell-smm-hwmon.c                     |  4 ++--
 drivers/net/bonding/bond_procfs.c                  |  8 ++++----
 drivers/net/wireless/cisco/airo.c                  | 22 ++++++++++----------
 drivers/net/wireless/intersil/hostap/hostap_ap.c   | 16 +++++++--------
 .../net/wireless/intersil/hostap/hostap_download.c |  2 +-
 drivers/net/wireless/intersil/hostap/hostap_proc.c | 24 +++++++++++-----------
 drivers/net/wireless/ray_cs.c                      |  2 +-
 drivers/nubus/proc.c                               |  2 +-
 drivers/parisc/led.c                               |  4 ++--
 drivers/pci/proc.c                                 | 10 ++++-----
 drivers/platform/x86/thinkpad_acpi.c               |  4 ++--
 drivers/platform/x86/toshiba_acpi.c                | 16 +++++++--------
 drivers/pnp/isapnp/proc.c                          |  2 +-
 drivers/pnp/pnpbios/proc.c                         |  4 ++--
 drivers/scsi/scsi_proc.c                           |  4 ++--
 drivers/usb/gadget/function/rndis.c                |  4 ++--
 drivers/zorro/proc.c                               |  2 +-
 fs/afs/proc.c                                      |  6 +++---
 fs/ext4/mballoc.c                                  | 14 ++++++-------
 fs/jbd2/journal.c                                  |  2 +-
 fs/proc/proc_net.c                                 |  8 ++++----
 include/linux/proc_fs.h                            |  4 +---
 include/linux/seq_file.h                           |  2 +-
 ipc/util.c                                         |  2 +-
 kernel/irq/proc.c                                  |  8 ++++----
 kernel/resource.c                                  |  4 ++--
 net/atm/proc.c                                     |  4 ++--
 net/bluetooth/af_bluetooth.c                       |  8 ++++----
 net/can/bcm.c                                      |  2 +-
 net/can/proc.c                                     |  2 +-
 net/core/neighbour.c                               |  6 +++---
 net/core/pktgen.c                                  |  6 +++---
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  6 +++---
 net/ipv4/raw.c                                     |  8 ++++----
 net/ipv4/tcp_ipv4.c                                |  2 +-
 net/ipv4/udp.c                                     |  6 +++---
 net/netfilter/x_tables.c                           | 10 ++++-----
 net/netfilter/xt_hashlimit.c                       | 18 ++++++++--------
 net/netfilter/xt_recent.c                          |  4 ++--
 net/sunrpc/auth_gss/svcauth_gss.c                  |  4 ++--
 net/sunrpc/cache.c                                 | 24 +++++++++++-----------
 net/sunrpc/stats.c                                 |  2 +-
 sound/core/info.c                                  |  4 ++--
 50 files changed, 161 insertions(+), 163 deletions(-)

diff --git a/arch/alpha/kernel/srm_env.c b/arch/alpha/kernel/srm_env.c
index 528d2be58182..217b4dca51dd 100644
--- a/arch/alpha/kernel/srm_env.c
+++ b/arch/alpha/kernel/srm_env.c
@@ -83,14 +83,14 @@ static int srm_env_proc_show(struct seq_file *m, void *v)
 
 static int srm_env_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, srm_env_proc_show, PDE_DATA(inode));
+	return single_open(file, srm_env_proc_show, pde_data(inode));
 }
 
 static ssize_t srm_env_proc_write(struct file *file, const char __user *buffer,
 				  size_t count, loff_t *pos)
 {
 	int res;
-	unsigned long	id = (unsigned long)PDE_DATA(file_inode(file));
+	unsigned long	id = (unsigned long)pde_data(file_inode(file));
 	char		*buf = (char *) __get_free_page(GFP_USER);
 	unsigned long	ret1, ret2;
 
diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
index 3c2faf2bd124..3ec2afe78423 100644
--- a/arch/arm/kernel/atags_proc.c
+++ b/arch/arm/kernel/atags_proc.c
@@ -13,7 +13,7 @@ struct buffer {
 static ssize_t atags_read(struct file *file, char __user *buf,
 			  size_t count, loff_t *ppos)
 {
-	struct buffer *b = PDE_DATA(file_inode(file));
+	struct buffer *b = pde_data(file_inode(file));
 	return simple_read_from_buffer(buf, count, ppos, b->data, b->size);
 }
 
diff --git a/arch/ia64/kernel/salinfo.c b/arch/ia64/kernel/salinfo.c
index a25ab9b37953..bd3ba276e69c 100644
--- a/arch/ia64/kernel/salinfo.c
+++ b/arch/ia64/kernel/salinfo.c
@@ -282,7 +282,7 @@ salinfo_event_open(struct inode *inode, struct file *file)
 static ssize_t
 salinfo_event_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
-	struct salinfo_data *data = PDE_DATA(file_inode(file));
+	struct salinfo_data *data = pde_data(file_inode(file));
 	char cmd[32];
 	size_t size;
 	int i, n, cpu = -1;
@@ -340,7 +340,7 @@ static const struct proc_ops salinfo_event_proc_ops = {
 static int
 salinfo_log_open(struct inode *inode, struct file *file)
 {
-	struct salinfo_data *data = PDE_DATA(inode);
+	struct salinfo_data *data = pde_data(inode);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -365,7 +365,7 @@ salinfo_log_open(struct inode *inode, struct file *file)
 static int
 salinfo_log_release(struct inode *inode, struct file *file)
 {
-	struct salinfo_data *data = PDE_DATA(inode);
+	struct salinfo_data *data = pde_data(inode);
 
 	if (data->state == STATE_NO_DATA) {
 		vfree(data->log_buffer);
@@ -433,7 +433,7 @@ salinfo_log_new_read(int cpu, struct salinfo_data *data)
 static ssize_t
 salinfo_log_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
-	struct salinfo_data *data = PDE_DATA(file_inode(file));
+	struct salinfo_data *data = pde_data(file_inode(file));
 	u8 *buf;
 	u64 bufsize;
 
@@ -494,7 +494,7 @@ salinfo_log_clear(struct salinfo_data *data, int cpu)
 static ssize_t
 salinfo_log_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
 {
-	struct salinfo_data *data = PDE_DATA(file_inode(file));
+	struct salinfo_data *data = pde_data(file_inode(file));
 	char cmd[32];
 	size_t size;
 	u32 offset;
diff --git a/arch/powerpc/kernel/proc_powerpc.c b/arch/powerpc/kernel/proc_powerpc.c
index 877817471e3c..6a029f2378e1 100644
--- a/arch/powerpc/kernel/proc_powerpc.c
+++ b/arch/powerpc/kernel/proc_powerpc.c
@@ -25,7 +25,7 @@ static ssize_t page_map_read( struct file *file, char __user *buf, size_t nbytes
 			      loff_t *ppos)
 {
 	return simple_read_from_buffer(buf, nbytes, ppos,
-			PDE_DATA(file_inode(file)), PAGE_SIZE);
+			pde_data(file_inode(file)), PAGE_SIZE);
 }
 
 static int page_map_mmap( struct file *file, struct vm_area_struct *vma )
@@ -34,7 +34,7 @@ static int page_map_mmap( struct file *file, struct vm_area_struct *vma )
 		return -EINVAL;
 
 	remap_pfn_range(vma, vma->vm_start,
-			__pa(PDE_DATA(file_inode(file))) >> PAGE_SHIFT,
+			__pa(pde_data(file_inode(file))) >> PAGE_SHIFT,
 			PAGE_SIZE, vma->vm_page_prot);
 	return 0;
 }
diff --git a/arch/sh/mm/alignment.c b/arch/sh/mm/alignment.c
index fb517b82a87b..20aaee8db36d 100644
--- a/arch/sh/mm/alignment.c
+++ b/arch/sh/mm/alignment.c
@@ -140,7 +140,7 @@ static int alignment_proc_open(struct inode *inode, struct file *file)
 static ssize_t alignment_proc_write(struct file *file,
 		const char __user *buffer, size_t count, loff_t *pos)
 {
-	int *data = PDE_DATA(file_inode(file));
+	int *data = pde_data(file_inode(file));
 	char mode;
 
 	if (count > 0) {
diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 07b642c1916a..8eb6ad1a3a1d 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -208,7 +208,7 @@ static int simdisk_detach(struct simdisk *dev)
 static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
 			size_t size, loff_t *ppos)
 {
-	struct simdisk *dev = PDE_DATA(file_inode(file));
+	struct simdisk *dev = pde_data(file_inode(file));
 	const char *s = dev->filename;
 	if (s) {
 		ssize_t n = simple_read_from_buffer(buf, size, ppos,
@@ -225,7 +225,7 @@ static ssize_t proc_write_simdisk(struct file *file, const char __user *buf,
 			size_t count, loff_t *ppos)
 {
 	char *tmp = memdup_user_nul(buf, count);
-	struct simdisk *dev = PDE_DATA(file_inode(file));
+	struct simdisk *dev = pde_data(file_inode(file));
 	int err;
 
 	if (IS_ERR(tmp))
diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 0cca7991f186..4322f2da6d10 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -127,7 +127,7 @@ static int
 acpi_system_wakeup_device_open_fs(struct inode *inode, struct file *file)
 {
 	return single_open(file, acpi_system_wakeup_device_seq_show,
-			   PDE_DATA(inode));
+			   pde_data(inode));
 }
 
 static const struct proc_ops acpi_system_wakeup_device_proc_ops = {
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index af0d0d2b6e99..ebc50b9cc493 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -545,7 +545,7 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
 
 static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 {
-	struct dell_smm_data *data = PDE_DATA(file_inode(fp));
+	struct dell_smm_data *data = pde_data(file_inode(fp));
 	long ret;
 
 	mutex_lock(&data->i8k_mutex);
@@ -602,7 +602,7 @@ static int i8k_proc_show(struct seq_file *seq, void *offset)
 
 static int i8k_open_fs(struct inode *inode, struct file *file)
 {
-	return single_open(file, i8k_proc_show, PDE_DATA(inode));
+	return single_open(file, i8k_proc_show, pde_data(inode));
 }
 
 static const struct proc_ops i8k_proc_ops = {
diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index f3e3bfd72556..07d1a1537afc 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -11,7 +11,7 @@
 static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(RCU)
 {
-	struct bonding *bond = PDE_DATA(file_inode(seq->file));
+	struct bonding *bond = pde_data(file_inode(seq->file));
 	struct list_head *iter;
 	struct slave *slave;
 	loff_t off = 0;
@@ -30,7 +30,7 @@ static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *bond_info_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct bonding *bond = PDE_DATA(file_inode(seq->file));
+	struct bonding *bond = pde_data(file_inode(seq->file));
 	struct list_head *iter;
 	struct slave *slave;
 	bool found = false;
@@ -57,7 +57,7 @@ static void bond_info_seq_stop(struct seq_file *seq, void *v)
 
 static void bond_info_show_master(struct seq_file *seq)
 {
-	struct bonding *bond = PDE_DATA(file_inode(seq->file));
+	struct bonding *bond = pde_data(file_inode(seq->file));
 	const struct bond_opt_value *optval;
 	struct slave *curr, *primary;
 	int i;
@@ -173,7 +173,7 @@ static void bond_info_show_master(struct seq_file *seq)
 static void bond_info_show_slave(struct seq_file *seq,
 				 const struct slave *slave)
 {
-	struct bonding *bond = PDE_DATA(file_inode(seq->file));
+	struct bonding *bond = pde_data(file_inode(seq->file));
 
 	seq_printf(seq, "\nSlave Interface: %s\n", slave->dev->name);
 	seq_printf(seq, "MII Status: %s\n", bond_slave_link_status(slave->link));
diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 65dd8cff1b01..9904d2a168ec 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -4673,7 +4673,7 @@ static ssize_t proc_write(struct file *file,
 static int proc_status_open(struct inode *inode, struct file *file)
 {
 	struct proc_data *data;
-	struct net_device *dev = PDE_DATA(inode);
+	struct net_device *dev = pde_data(inode);
 	struct airo_info *apriv = dev->ml_priv;
 	CapabilityRid cap_rid;
 	StatusRid status_rid;
@@ -4757,7 +4757,7 @@ static int proc_stats_rid_open(struct inode *inode,
 				u16 rid)
 {
 	struct proc_data *data;
-	struct net_device *dev = PDE_DATA(inode);
+	struct net_device *dev = pde_data(inode);
 	struct airo_info *apriv = dev->ml_priv;
 	StatsRid stats;
 	int i, j;
@@ -4820,7 +4820,7 @@ static inline int sniffing_mode(struct airo_info *ai)
 static void proc_config_on_close(struct inode *inode, struct file *file)
 {
 	struct proc_data *data = file->private_data;
-	struct net_device *dev = PDE_DATA(inode);
+	struct net_device *dev = pde_data(inode);
 	struct airo_info *ai = dev->ml_priv;
 	char *line;
 
@@ -5031,7 +5031,7 @@ static const char *get_rmode(__le16 mode)
 static int proc_config_open(struct inode *inode, struct file *file)
 {
 	struct proc_data *data;
-	struct net_device *dev = PDE_DATA(inode);
+	struct net_device *dev = pde_data(inode);
 	struct airo_info *ai = dev->ml_priv;
 	int i;
 	__le16 mode;
@@ -5121,7 +5121,7 @@ static int proc_config_open(struct inode *inode, struct file *file)
 static void proc_SSID_on_close(struct inode *inode, struct file *file)
 {
 	struct proc_data *data = file->private_data;
-	struct net_device *dev = PDE_DATA(inode);
+	struct net_device *dev = pde_data(inode);
 	struct airo_info *ai = dev->ml_priv;
 	SsidRid SSID_rid;
 	int i;
@@ -5157,7 +5157,7 @@ static void proc_SSID_on_close(struct inode *inode, struct file *file)
 static void proc_APList_on_close(struct inode *inode, struct file *file)
 {
 	struct proc_data *data = file->private_data;
-	struct net_device *dev = PDE_DATA(inode);
+	struct net_device *dev = pde_data(inode);
 	struct airo_info *ai = dev->ml_priv;
 	APListRid *APList_rid = &ai->APList;
 	int i;
@@ -5281,7 +5281,7 @@ static int set_wep_tx_idx(struct airo_info *ai, u16 index, int perm, int lock)
 static void proc_wepkey_on_close(struct inode *inode, struct file *file)
 {
 	struct proc_data *data;
-	struct net_device *dev = PDE_DATA(inode);
+	struct net_device *dev = pde_data(inode);
 	struct airo_info *ai = dev->ml_priv;
 	int i, rc;
 	char key[16];
@@ -5332,7 +5332,7 @@ static void proc_wepkey_on_close(struct inode *inode, struct file *file)
 static int proc_wepkey_open(struct inode *inode, struct file *file)
 {
 	struct proc_data *data;
-	struct net_device *dev = PDE_DATA(inode);
+	struct net_device *dev = pde_data(inode);
 	struct airo_info *ai = dev->ml_priv;
 	char *ptr;
 	WepKeyRid wkr;
@@ -5380,7 +5380,7 @@ static int proc_wepkey_open(struct inode *inode, struct file *file)
 static int proc_SSID_open(struct inode *inode, struct file *file)
 {
 	struct proc_data *data;
-	struct net_device *dev = PDE_DATA(inode);
+	struct net_device *dev = pde_data(inode);
 	struct airo_info *ai = dev->ml_priv;
 	int i;
 	char *ptr;
@@ -5424,7 +5424,7 @@ static int proc_SSID_open(struct inode *inode, struct file *file)
 static int proc_APList_open(struct inode *inode, struct file *file)
 {
 	struct proc_data *data;
-	struct net_device *dev = PDE_DATA(inode);
+	struct net_device *dev = pde_data(inode);
 	struct airo_info *ai = dev->ml_priv;
 	int i;
 	char *ptr;
@@ -5463,7 +5463,7 @@ static int proc_APList_open(struct inode *inode, struct file *file)
 static int proc_BSSList_open(struct inode *inode, struct file *file)
 {
 	struct proc_data *data;
-	struct net_device *dev = PDE_DATA(inode);
+	struct net_device *dev = pde_data(inode);
 	struct airo_info *ai = dev->ml_priv;
 	char *ptr;
 	BSSListRid BSSList_rid;
diff --git a/drivers/net/wireless/intersil/hostap/hostap_ap.c b/drivers/net/wireless/intersil/hostap/hostap_ap.c
index 8bcc1cdcb75b..462ccc7d7d1a 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_ap.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_ap.c
@@ -69,7 +69,7 @@ static void prism2_send_mgmt(struct net_device *dev,
 #if !defined(PRISM2_NO_PROCFS_DEBUG) && defined(CONFIG_PROC_FS)
 static int ap_debug_proc_show(struct seq_file *m, void *v)
 {
-	struct ap_data *ap = PDE_DATA(file_inode(m->file));
+	struct ap_data *ap = pde_data(file_inode(m->file));
 
 	seq_printf(m, "BridgedUnicastFrames=%u\n", ap->bridged_unicast);
 	seq_printf(m, "BridgedMulticastFrames=%u\n", ap->bridged_multicast);
@@ -320,7 +320,7 @@ void hostap_deauth_all_stas(struct net_device *dev, struct ap_data *ap,
 
 static int ap_control_proc_show(struct seq_file *m, void *v)
 {
-	struct ap_data *ap = PDE_DATA(file_inode(m->file));
+	struct ap_data *ap = pde_data(file_inode(m->file));
 	char *policy_txt;
 	struct mac_entry *entry;
 
@@ -352,20 +352,20 @@ static int ap_control_proc_show(struct seq_file *m, void *v)
 
 static void *ap_control_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	struct ap_data *ap = PDE_DATA(file_inode(m->file));
+	struct ap_data *ap = pde_data(file_inode(m->file));
 	spin_lock_bh(&ap->mac_restrictions.lock);
 	return seq_list_start_head(&ap->mac_restrictions.mac_list, *_pos);
 }
 
 static void *ap_control_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	struct ap_data *ap = PDE_DATA(file_inode(m->file));
+	struct ap_data *ap = pde_data(file_inode(m->file));
 	return seq_list_next(v, &ap->mac_restrictions.mac_list, _pos);
 }
 
 static void ap_control_proc_stop(struct seq_file *m, void *v)
 {
-	struct ap_data *ap = PDE_DATA(file_inode(m->file));
+	struct ap_data *ap = pde_data(file_inode(m->file));
 	spin_unlock_bh(&ap->mac_restrictions.lock);
 }
 
@@ -554,20 +554,20 @@ static int prism2_ap_proc_show(struct seq_file *m, void *v)
 
 static void *prism2_ap_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	struct ap_data *ap = PDE_DATA(file_inode(m->file));
+	struct ap_data *ap = pde_data(file_inode(m->file));
 	spin_lock_bh(&ap->sta_table_lock);
 	return seq_list_start_head(&ap->sta_list, *_pos);
 }
 
 static void *prism2_ap_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	struct ap_data *ap = PDE_DATA(file_inode(m->file));
+	struct ap_data *ap = pde_data(file_inode(m->file));
 	return seq_list_next(v, &ap->sta_list, _pos);
 }
 
 static void prism2_ap_proc_stop(struct seq_file *m, void *v)
 {
-	struct ap_data *ap = PDE_DATA(file_inode(m->file));
+	struct ap_data *ap = pde_data(file_inode(m->file));
 	spin_unlock_bh(&ap->sta_table_lock);
 }
 
diff --git a/drivers/net/wireless/intersil/hostap/hostap_download.c b/drivers/net/wireless/intersil/hostap/hostap_download.c
index 7c6a5a6d1d45..3672291ced5c 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_download.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_download.c
@@ -227,7 +227,7 @@ static int prism2_download_aux_dump_proc_open(struct inode *inode, struct file *
 				   sizeof(struct prism2_download_aux_dump));
 	if (ret == 0) {
 		struct seq_file *m = file->private_data;
-		m->private = PDE_DATA(inode);
+		m->private = pde_data(inode);
 	}
 	return ret;
 }
diff --git a/drivers/net/wireless/intersil/hostap/hostap_proc.c b/drivers/net/wireless/intersil/hostap/hostap_proc.c
index 51c847d98755..61f68786056f 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_proc.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_proc.c
@@ -97,20 +97,20 @@ static int prism2_wds_proc_show(struct seq_file *m, void *v)
 
 static void *prism2_wds_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	local_info_t *local = PDE_DATA(file_inode(m->file));
+	local_info_t *local = pde_data(file_inode(m->file));
 	read_lock_bh(&local->iface_lock);
 	return seq_list_start(&local->hostap_interfaces, *_pos);
 }
 
 static void *prism2_wds_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	local_info_t *local = PDE_DATA(file_inode(m->file));
+	local_info_t *local = pde_data(file_inode(m->file));
 	return seq_list_next(v, &local->hostap_interfaces, _pos);
 }
 
 static void prism2_wds_proc_stop(struct seq_file *m, void *v)
 {
-	local_info_t *local = PDE_DATA(file_inode(m->file));
+	local_info_t *local = pde_data(file_inode(m->file));
 	read_unlock_bh(&local->iface_lock);
 }
 
@@ -123,7 +123,7 @@ static const struct seq_operations prism2_wds_proc_seqops = {
 
 static int prism2_bss_list_proc_show(struct seq_file *m, void *v)
 {
-	local_info_t *local = PDE_DATA(file_inode(m->file));
+	local_info_t *local = pde_data(file_inode(m->file));
 	struct list_head *ptr = v;
 	struct hostap_bss_info *bss;
 
@@ -151,21 +151,21 @@ static int prism2_bss_list_proc_show(struct seq_file *m, void *v)
 static void *prism2_bss_list_proc_start(struct seq_file *m, loff_t *_pos)
 	__acquires(&local->lock)
 {
-	local_info_t *local = PDE_DATA(file_inode(m->file));
+	local_info_t *local = pde_data(file_inode(m->file));
 	spin_lock_bh(&local->lock);
 	return seq_list_start_head(&local->bss_list, *_pos);
 }
 
 static void *prism2_bss_list_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	local_info_t *local = PDE_DATA(file_inode(m->file));
+	local_info_t *local = pde_data(file_inode(m->file));
 	return seq_list_next(v, &local->bss_list, _pos);
 }
 
 static void prism2_bss_list_proc_stop(struct seq_file *m, void *v)
 	__releases(&local->lock)
 {
-	local_info_t *local = PDE_DATA(file_inode(m->file));
+	local_info_t *local = pde_data(file_inode(m->file));
 	spin_unlock_bh(&local->lock);
 }
 
@@ -198,7 +198,7 @@ static int prism2_crypt_proc_show(struct seq_file *m, void *v)
 static ssize_t prism2_pda_proc_read(struct file *file, char __user *buf,
 				    size_t count, loff_t *_pos)
 {
-	local_info_t *local = PDE_DATA(file_inode(file));
+	local_info_t *local = pde_data(file_inode(file));
 	size_t off;
 
 	if (local->pda == NULL || *_pos >= PRISM2_PDA_SIZE)
@@ -272,7 +272,7 @@ static int prism2_io_debug_proc_read(char *page, char **start, off_t off,
 #ifndef PRISM2_NO_STATION_MODES
 static int prism2_scan_results_proc_show(struct seq_file *m, void *v)
 {
-	local_info_t *local = PDE_DATA(file_inode(m->file));
+	local_info_t *local = pde_data(file_inode(m->file));
 	unsigned long entry;
 	int i, len;
 	struct hfa384x_hostscan_result *scanres;
@@ -322,7 +322,7 @@ static int prism2_scan_results_proc_show(struct seq_file *m, void *v)
 
 static void *prism2_scan_results_proc_start(struct seq_file *m, loff_t *_pos)
 {
-	local_info_t *local = PDE_DATA(file_inode(m->file));
+	local_info_t *local = pde_data(file_inode(m->file));
 	spin_lock_bh(&local->lock);
 
 	/* We have a header (pos 0) + N results to show (pos 1...N) */
@@ -333,7 +333,7 @@ static void *prism2_scan_results_proc_start(struct seq_file *m, loff_t *_pos)
 
 static void *prism2_scan_results_proc_next(struct seq_file *m, void *v, loff_t *_pos)
 {
-	local_info_t *local = PDE_DATA(file_inode(m->file));
+	local_info_t *local = pde_data(file_inode(m->file));
 
 	++*_pos;
 	if (*_pos > local->last_scan_results_count)
@@ -343,7 +343,7 @@ static void *prism2_scan_results_proc_next(struct seq_file *m, void *v, loff_t *
 
 static void prism2_scan_results_proc_stop(struct seq_file *m, void *v)
 {
-	local_info_t *local = PDE_DATA(file_inode(m->file));
+	local_info_t *local = pde_data(file_inode(m->file));
 	spin_unlock_bh(&local->lock);
 }
 
diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index 0f5009c47cd0..1c2fa763eecd 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -2746,7 +2746,7 @@ static ssize_t int_proc_write(struct file *file, const char __user *buffer,
 		nr = nr * 10 + c;
 		p++;
 	} while (--len);
-	*(int *)PDE_DATA(file_inode(file)) = nr;
+	*(int *)pde_data(file_inode(file)) = nr;
 	return count;
 }
 
diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
index 88e1f9a0faaf..22fb11da519b 100644
--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -109,7 +109,7 @@ static int nubus_proc_rsrc_show(struct seq_file *m, void *v)
 	struct inode *inode = m->private;
 	struct nubus_proc_pde_data *pde_data;
 
-	pde_data = PDE_DATA(inode);
+	pde_data = pde_data(inode);
 	if (!pde_data)
 		return 0;
 
diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index cf91cb024be3..1e4a5663d011 100644
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -168,14 +168,14 @@ static int led_proc_show(struct seq_file *m, void *v)
 
 static int led_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, led_proc_show, PDE_DATA(inode));
+	return single_open(file, led_proc_show, pde_data(inode));
 }
 
 
 static ssize_t led_proc_write(struct file *file, const char __user *buf,
 	size_t count, loff_t *pos)
 {
-	void *data = PDE_DATA(file_inode(file));
+	void *data = pde_data(file_inode(file));
 	char *cur, lbuf[32];
 	int d;
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index cb18f8a13ab6..9c7edec64f7e 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -21,14 +21,14 @@ static int proc_initialized;	/* = 0 */
 
 static loff_t proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
-	struct pci_dev *dev = PDE_DATA(file_inode(file));
+	struct pci_dev *dev = pde_data(file_inode(file));
 	return fixed_size_llseek(file, off, whence, dev->cfg_size);
 }
 
 static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 				 size_t nbytes, loff_t *ppos)
 {
-	struct pci_dev *dev = PDE_DATA(file_inode(file));
+	struct pci_dev *dev = pde_data(file_inode(file));
 	unsigned int pos = *ppos;
 	unsigned int cnt, size;
 
@@ -114,7 +114,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 				  size_t nbytes, loff_t *ppos)
 {
 	struct inode *ino = file_inode(file);
-	struct pci_dev *dev = PDE_DATA(ino);
+	struct pci_dev *dev = pde_data(ino);
 	int pos = *ppos;
 	int size = dev->cfg_size;
 	int cnt, ret;
@@ -196,7 +196,7 @@ struct pci_filp_private {
 static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 			       unsigned long arg)
 {
-	struct pci_dev *dev = PDE_DATA(file_inode(file));
+	struct pci_dev *dev = pde_data(file_inode(file));
 #ifdef HAVE_PCI_MMAP
 	struct pci_filp_private *fpriv = file->private_data;
 #endif /* HAVE_PCI_MMAP */
@@ -244,7 +244,7 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 #ifdef HAVE_PCI_MMAP
 static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	struct pci_dev *dev = PDE_DATA(file_inode(file));
+	struct pci_dev *dev = pde_data(file_inode(file));
 	struct pci_filp_private *fpriv = file->private_data;
 	int i, ret, write_combine = 0, res_bit = IORESOURCE_MEM;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 882e994658f1..277214c8da8b 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -882,14 +882,14 @@ static int dispatch_proc_show(struct seq_file *m, void *v)
 
 static int dispatch_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, dispatch_proc_show, PDE_DATA(inode));
+	return single_open(file, dispatch_proc_show, pde_data(inode));
 }
 
 static ssize_t dispatch_proc_write(struct file *file,
 			const char __user *userbuf,
 			size_t count, loff_t *pos)
 {
-	struct ibm_struct *ibm = PDE_DATA(file_inode(file));
+	struct ibm_struct *ibm = pde_data(file_inode(file));
 	char *kernbuf;
 	int ret;
 
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 352508d30467..f113dec98e21 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -1368,7 +1368,7 @@ static int lcd_proc_show(struct seq_file *m, void *v)
 
 static int lcd_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, lcd_proc_show, PDE_DATA(inode));
+	return single_open(file, lcd_proc_show, pde_data(inode));
 }
 
 static int set_lcd_brightness(struct toshiba_acpi_dev *dev, int value)
@@ -1404,7 +1404,7 @@ static int set_lcd_status(struct backlight_device *bd)
 static ssize_t lcd_proc_write(struct file *file, const char __user *buf,
 			      size_t count, loff_t *pos)
 {
-	struct toshiba_acpi_dev *dev = PDE_DATA(file_inode(file));
+	struct toshiba_acpi_dev *dev = pde_data(file_inode(file));
 	char cmd[42];
 	size_t len;
 	int levels;
@@ -1469,13 +1469,13 @@ static int video_proc_show(struct seq_file *m, void *v)
 
 static int video_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, video_proc_show, PDE_DATA(inode));
+	return single_open(file, video_proc_show, pde_data(inode));
 }
 
 static ssize_t video_proc_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *pos)
 {
-	struct toshiba_acpi_dev *dev = PDE_DATA(file_inode(file));
+	struct toshiba_acpi_dev *dev = pde_data(file_inode(file));
 	char *buffer;
 	char *cmd;
 	int lcd_out = -1, crt_out = -1, tv_out = -1;
@@ -1580,13 +1580,13 @@ static int fan_proc_show(struct seq_file *m, void *v)
 
 static int fan_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, fan_proc_show, PDE_DATA(inode));
+	return single_open(file, fan_proc_show, pde_data(inode));
 }
 
 static ssize_t fan_proc_write(struct file *file, const char __user *buf,
 			      size_t count, loff_t *pos)
 {
-	struct toshiba_acpi_dev *dev = PDE_DATA(file_inode(file));
+	struct toshiba_acpi_dev *dev = pde_data(file_inode(file));
 	char cmd[42];
 	size_t len;
 	int value;
@@ -1628,13 +1628,13 @@ static int keys_proc_show(struct seq_file *m, void *v)
 
 static int keys_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, keys_proc_show, PDE_DATA(inode));
+	return single_open(file, keys_proc_show, pde_data(inode));
 }
 
 static ssize_t keys_proc_write(struct file *file, const char __user *buf,
 			       size_t count, loff_t *pos)
 {
-	struct toshiba_acpi_dev *dev = PDE_DATA(file_inode(file));
+	struct toshiba_acpi_dev *dev = pde_data(file_inode(file));
 	char cmd[42];
 	size_t len;
 	int value;
diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
index 1ae458c02656..55ae72a2818b 100644
--- a/drivers/pnp/isapnp/proc.c
+++ b/drivers/pnp/isapnp/proc.c
@@ -22,7 +22,7 @@ static loff_t isapnp_proc_bus_lseek(struct file *file, loff_t off, int whence)
 static ssize_t isapnp_proc_bus_read(struct file *file, char __user * buf,
 				    size_t nbytes, loff_t * ppos)
 {
-	struct pnp_dev *dev = PDE_DATA(file_inode(file));
+	struct pnp_dev *dev = pde_data(file_inode(file));
 	int pos = *ppos;
 	int cnt, size = 256;
 
diff --git a/drivers/pnp/pnpbios/proc.c b/drivers/pnp/pnpbios/proc.c
index a806830e3a40..0f0d819b157f 100644
--- a/drivers/pnp/pnpbios/proc.c
+++ b/drivers/pnp/pnpbios/proc.c
@@ -173,13 +173,13 @@ static int pnpbios_proc_show(struct seq_file *m, void *v)
 
 static int pnpbios_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, pnpbios_proc_show, PDE_DATA(inode));
+	return single_open(file, pnpbios_proc_show, pde_data(inode));
 }
 
 static ssize_t pnpbios_proc_write(struct file *file, const char __user *buf,
 				  size_t count, loff_t *pos)
 {
-	void *data = PDE_DATA(file_inode(file));
+	void *data = pde_data(file_inode(file));
 	struct pnp_bios_node *node;
 	int boot = (long)data >> 8;
 	u8 nodenum = (long)data;
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index d6982d355739..95aee1ad1383 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -49,7 +49,7 @@ static DEFINE_MUTEX(global_host_template_mutex);
 static ssize_t proc_scsi_host_write(struct file *file, const char __user *buf,
                            size_t count, loff_t *ppos)
 {
-	struct Scsi_Host *shost = PDE_DATA(file_inode(file));
+	struct Scsi_Host *shost = pde_data(file_inode(file));
 	ssize_t ret = -ENOMEM;
 	char *page;
     
@@ -79,7 +79,7 @@ static int proc_scsi_show(struct seq_file *m, void *v)
 
 static int proc_scsi_host_open(struct inode *inode, struct file *file)
 {
-	return single_open_size(file, proc_scsi_show, PDE_DATA(inode),
+	return single_open_size(file, proc_scsi_show, pde_data(inode),
 				4 * PAGE_SIZE);
 }
 
diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index 64de9f1b874c..431d5a7d737e 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -1117,7 +1117,7 @@ static int rndis_proc_show(struct seq_file *m, void *v)
 static ssize_t rndis_proc_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos)
 {
-	rndis_params *p = PDE_DATA(file_inode(file));
+	rndis_params *p = pde_data(file_inode(file));
 	u32 speed = 0;
 	int i, fl_speed = 0;
 
@@ -1161,7 +1161,7 @@ static ssize_t rndis_proc_write(struct file *file, const char __user *buffer,
 
 static int rndis_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, rndis_proc_show, PDE_DATA(inode));
+	return single_open(file, rndis_proc_show, pde_data(inode));
 }
 
 static const struct proc_ops rndis_proc_ops = {
diff --git a/drivers/zorro/proc.c b/drivers/zorro/proc.c
index 1c9ae08225d8..f916bf60b312 100644
--- a/drivers/zorro/proc.c
+++ b/drivers/zorro/proc.c
@@ -30,7 +30,7 @@ proc_bus_zorro_lseek(struct file *file, loff_t off, int whence)
 static ssize_t
 proc_bus_zorro_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 {
-	struct zorro_dev *z = PDE_DATA(file_inode(file));
+	struct zorro_dev *z = pde_data(file_inode(file));
 	struct ConfigDev cd;
 	loff_t pos = *ppos;
 
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 065a28bfa3f1..e1b863449296 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -227,7 +227,7 @@ static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
 static void *afs_proc_cell_volumes_start(struct seq_file *m, loff_t *_pos)
 	__acquires(cell->proc_lock)
 {
-	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
+	struct afs_cell *cell = pde_data(file_inode(m->file));
 
 	rcu_read_lock();
 	return seq_hlist_start_head_rcu(&cell->proc_volumes, *_pos);
@@ -236,7 +236,7 @@ static void *afs_proc_cell_volumes_start(struct seq_file *m, loff_t *_pos)
 static void *afs_proc_cell_volumes_next(struct seq_file *m, void *v,
 					loff_t *_pos)
 {
-	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
+	struct afs_cell *cell = pde_data(file_inode(m->file));
 
 	return seq_hlist_next_rcu(v, &cell->proc_volumes, _pos);
 }
@@ -322,7 +322,7 @@ static void *afs_proc_cell_vlservers_start(struct seq_file *m, loff_t *_pos)
 {
 	struct afs_vl_seq_net_private *priv = m->private;
 	struct afs_vlserver_list *vllist;
-	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
+	struct afs_cell *cell = pde_data(file_inode(m->file));
 	loff_t pos = *_pos;
 
 	rcu_read_lock();
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 72bfac2d6dce..ddddf00f94c9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2834,7 +2834,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 static void *ext4_mb_seq_groups_start(struct seq_file *seq, loff_t *pos)
 {
-	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	struct super_block *sb = pde_data(file_inode(seq->file));
 	ext4_group_t group;
 
 	if (*pos < 0 || *pos >= ext4_get_groups_count(sb))
@@ -2845,7 +2845,7 @@ static void *ext4_mb_seq_groups_start(struct seq_file *seq, loff_t *pos)
 
 static void *ext4_mb_seq_groups_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	struct super_block *sb = pde_data(file_inode(seq->file));
 	ext4_group_t group;
 
 	++*pos;
@@ -2857,7 +2857,7 @@ static void *ext4_mb_seq_groups_next(struct seq_file *seq, void *v, loff_t *pos)
 
 static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 {
-	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	struct super_block *sb = pde_data(file_inode(seq->file));
 	ext4_group_t group = (ext4_group_t) ((unsigned long) v);
 	int i;
 	int err, buddy_loaded = 0;
@@ -2985,7 +2985,7 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 static void *ext4_mb_seq_structs_summary_start(struct seq_file *seq, loff_t *pos)
 __acquires(&EXT4_SB(sb)->s_mb_rb_lock)
 {
-	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	struct super_block *sb = pde_data(file_inode(seq->file));
 	unsigned long position;
 
 	read_lock(&EXT4_SB(sb)->s_mb_rb_lock);
@@ -2998,7 +2998,7 @@ __acquires(&EXT4_SB(sb)->s_mb_rb_lock)
 
 static void *ext4_mb_seq_structs_summary_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	struct super_block *sb = pde_data(file_inode(seq->file));
 	unsigned long position;
 
 	++*pos;
@@ -3010,7 +3010,7 @@ static void *ext4_mb_seq_structs_summary_next(struct seq_file *seq, void *v, lof
 
 static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, void *v)
 {
-	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	struct super_block *sb = pde_data(file_inode(seq->file));
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	unsigned long position = ((unsigned long) v);
 	struct ext4_group_info *grp;
@@ -3058,7 +3058,7 @@ static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, void *v)
 static void ext4_mb_seq_structs_summary_stop(struct seq_file *seq, void *v)
 __releases(&EXT4_SB(sb)->s_mb_rb_lock)
 {
-	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	struct super_block *sb = pde_data(file_inode(seq->file));
 
 	read_unlock(&EXT4_SB(sb)->s_mb_rb_lock);
 }
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 35302bc192eb..2726db7a139a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1210,7 +1210,7 @@ static const struct seq_operations jbd2_seq_info_ops = {
 
 static int jbd2_seq_info_open(struct inode *inode, struct file *file)
 {
-	journal_t *journal = PDE_DATA(inode);
+	journal_t *journal = pde_data(inode);
 	struct jbd2_stats_proc_session *s;
 	int rc, size;
 
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 15c2e55d2ed2..4df857acb394 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -125,7 +125,7 @@ EXPORT_SYMBOL_GPL(proc_create_net_data);
  * @parent: The parent directory in which to create.
  * @ops: The seq_file ops with which to read the file.
  * @write: The write method with which to 'modify' the file.
- * @data: Data for retrieval by PDE_DATA().
+ * @data: Data for retrieval by pde_data().
  *
  * Create a network namespaced proc file in the @parent directory with the
  * specified @name and @mode that allows reading of a file that displays a
@@ -140,7 +140,7 @@ EXPORT_SYMBOL_GPL(proc_create_net_data);
  * modified by the @write function.  @write should return 0 on success.
  *
  * The @data value is accessible from the @show and @write functions by calling
- * PDE_DATA() on the file inode.  The network namespace must be accessed by
+ * pde_data() on the file inode.  The network namespace must be accessed by
  * calling seq_file_net() on the seq_file struct.
  */
 struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode,
@@ -217,7 +217,7 @@ EXPORT_SYMBOL_GPL(proc_create_net_single);
  * @parent: The parent directory in which to create.
  * @show: The seqfile show method with which to read the file.
  * @write: The write method with which to 'modify' the file.
- * @data: Data for retrieval by PDE_DATA().
+ * @data: Data for retrieval by pde_data().
  *
  * Create a network-namespaced proc file in the @parent directory with the
  * specified @name and @mode that allows reading of a file that displays a
@@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(proc_create_net_single);
  * modified by the @write function.  @write should return 0 on success.
  *
  * The @data value is accessible from the @show and @write functions by calling
- * PDE_DATA() on the file inode.  The network namespace must be accessed by
+ * pde_data() on the file inode.  The network namespace must be accessed by
  * calling seq_file_single_net() on the seq_file struct.
  */
 struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mode,
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index b32fb0ef3308..bfc752ee6c99 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -120,8 +120,6 @@ static inline void *pde_data(const struct inode *inode)
 	return inode->i_private;
 }
 
-#define PDE_DATA(i)	pde_data(i)
-
 extern void *proc_get_parent_data(const struct inode *);
 extern void proc_remove(struct proc_dir_entry *);
 extern void remove_proc_entry(const char *, struct proc_dir_entry *);
@@ -194,7 +192,7 @@ static inline struct proc_dir_entry *proc_mkdir_mode(const char *name,
 
 static inline void proc_set_size(struct proc_dir_entry *de, loff_t size) {}
 static inline void proc_set_user(struct proc_dir_entry *de, kuid_t uid, kgid_t gid) {}
-static inline void *PDE_DATA(const struct inode *inode) {BUG(); return NULL;}
+static inline void *pde_data(const struct inode *inode) {BUG(); return NULL;}
 static inline void *proc_get_parent_data(const struct inode *inode) { BUG(); return NULL; }
 
 static inline void proc_remove(struct proc_dir_entry *de) {}
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 72dbb44a4573..88cc16444b43 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -209,7 +209,7 @@ static const struct file_operations __name ## _fops = {			\
 #define DEFINE_PROC_SHOW_ATTRIBUTE(__name)				\
 static int __name ## _open(struct inode *inode, struct file *file)	\
 {									\
-	return single_open(file, __name ## _show, PDE_DATA(inode));	\
+	return single_open(file, __name ## _show, pde_data(inode));	\
 }									\
 									\
 static const struct proc_ops __name ## _proc_ops = {			\
diff --git a/ipc/util.c b/ipc/util.c
index d48d8cfa1f3f..9d24bb6dda98 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -894,7 +894,7 @@ static int sysvipc_proc_open(struct inode *inode, struct file *file)
 	if (!iter)
 		return -ENOMEM;
 
-	iter->iface = PDE_DATA(inode);
+	iter->iface = pde_data(inode);
 	iter->ns    = get_ipc_ns(current->nsproxy->ipc_ns);
 	iter->pid_ns = get_pid_ns(task_active_pid_ns(current));
 
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index ee595ec09778..623b8136e9af 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -137,7 +137,7 @@ static inline int irq_select_affinity_usr(unsigned int irq)
 static ssize_t write_irq_affinity(int type, struct file *file,
 		const char __user *buffer, size_t count, loff_t *pos)
 {
-	unsigned int irq = (int)(long)PDE_DATA(file_inode(file));
+	unsigned int irq = (int)(long)pde_data(file_inode(file));
 	cpumask_var_t new_value;
 	int err;
 
@@ -190,12 +190,12 @@ static ssize_t irq_affinity_list_proc_write(struct file *file,
 
 static int irq_affinity_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, irq_affinity_proc_show, PDE_DATA(inode));
+	return single_open(file, irq_affinity_proc_show, pde_data(inode));
 }
 
 static int irq_affinity_list_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, irq_affinity_list_proc_show, PDE_DATA(inode));
+	return single_open(file, irq_affinity_list_proc_show, pde_data(inode));
 }
 
 static const struct proc_ops irq_affinity_proc_ops = {
@@ -265,7 +265,7 @@ static ssize_t default_affinity_write(struct file *file,
 
 static int default_affinity_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, default_affinity_show, PDE_DATA(inode));
+	return single_open(file, default_affinity_show, pde_data(inode));
 }
 
 static const struct proc_ops default_affinity_proc_ops = {
diff --git a/kernel/resource.c b/kernel/resource.c
index 5ad3eba619ba..9c08d6e9eef2 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -99,7 +99,7 @@ enum { MAX_IORES_LEVEL = 5 };
 static void *r_start(struct seq_file *m, loff_t *pos)
 	__acquires(resource_lock)
 {
-	struct resource *p = PDE_DATA(file_inode(m->file));
+	struct resource *p = pde_data(file_inode(m->file));
 	loff_t l = 0;
 	read_lock(&resource_lock);
 	for (p = p->child; p && l < *pos; p = r_next(m, p, &l))
@@ -115,7 +115,7 @@ static void r_stop(struct seq_file *m, void *v)
 
 static int r_show(struct seq_file *m, void *v)
 {
-	struct resource *root = PDE_DATA(file_inode(m->file));
+	struct resource *root = pde_data(file_inode(m->file));
 	struct resource *r = v, *p;
 	unsigned long long start, end;
 	int width = root->end < 0x10000 ? 4 : 8;
diff --git a/net/atm/proc.c b/net/atm/proc.c
index 4369ffa3302a..9bf736290e48 100644
--- a/net/atm/proc.c
+++ b/net/atm/proc.c
@@ -108,7 +108,7 @@ static int __vcc_walk(struct sock **sock, int family, int *bucket, loff_t l)
 static inline void *vcc_walk(struct seq_file *seq, loff_t l)
 {
 	struct vcc_state *state = seq->private;
-	int family = (uintptr_t)(PDE_DATA(file_inode(seq->file)));
+	int family = (uintptr_t)(pde_data(file_inode(seq->file)));
 
 	return __vcc_walk(&state->sk, family, &state->bucket, l) ?
 	       state : NULL;
@@ -324,7 +324,7 @@ static ssize_t proc_dev_atm_read(struct file *file, char __user *buf,
 	page = get_zeroed_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
-	dev = PDE_DATA(file_inode(file));
+	dev = pde_data(file_inode(file));
 	if (!dev->ops->proc_read)
 		length = -EINVAL;
 	else {
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 1661979b6a6e..ee319779781e 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -611,7 +611,7 @@ EXPORT_SYMBOL(bt_sock_wait_ready);
 static void *bt_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(seq->private->l->lock)
 {
-	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
+	struct bt_sock_list *l = pde_data(file_inode(seq->file));
 
 	read_lock(&l->lock);
 	return seq_hlist_start_head(&l->head, *pos);
@@ -619,7 +619,7 @@ static void *bt_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *bt_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
+	struct bt_sock_list *l = pde_data(file_inode(seq->file));
 
 	return seq_hlist_next(v, &l->head, pos);
 }
@@ -627,14 +627,14 @@ static void *bt_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static void bt_seq_stop(struct seq_file *seq, void *v)
 	__releases(seq->private->l->lock)
 {
-	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
+	struct bt_sock_list *l = pde_data(file_inode(seq->file));
 
 	read_unlock(&l->lock);
 }
 
 static int bt_seq_show(struct seq_file *seq, void *v)
 {
-	struct bt_sock_list *l = PDE_DATA(file_inode(seq->file));
+	struct bt_sock_list *l = pde_data(file_inode(seq->file));
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "sk               RefCnt Rmem   Wmem   User   Inode  Parent");
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 508f67de0b80..0ba4473074ba 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -193,7 +193,7 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 {
 	char ifname[IFNAMSIZ];
 	struct net *net = m->private;
-	struct sock *sk = (struct sock *)PDE_DATA(m->file->f_inode);
+	struct sock *sk = (struct sock *)pde_data(m->file->f_inode);
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 
diff --git a/net/can/proc.c b/net/can/proc.c
index b3099f0a3cb8..bbce97825f13 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -305,7 +305,7 @@ static inline void can_rcvlist_proc_show_one(struct seq_file *m, int idx,
 static int can_rcvlist_proc_show(struct seq_file *m, void *v)
 {
 	/* double cast to prevent GCC warning */
-	int idx = (int)(long)PDE_DATA(m->file->f_inode);
+	int idx = (int)(long)pde_data(m->file->f_inode);
 	struct net_device *dev;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct net *net = m->private;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index eae73efa9245..2ce776a6dd5d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3360,7 +3360,7 @@ EXPORT_SYMBOL(neigh_seq_stop);
 
 static void *neigh_stat_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
+	struct neigh_table *tbl = pde_data(file_inode(seq->file));
 	int cpu;
 
 	if (*pos == 0)
@@ -3377,7 +3377,7 @@ static void *neigh_stat_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *neigh_stat_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
+	struct neigh_table *tbl = pde_data(file_inode(seq->file));
 	int cpu;
 
 	for (cpu = *pos; cpu < nr_cpu_ids; ++cpu) {
@@ -3397,7 +3397,7 @@ static void neigh_stat_seq_stop(struct seq_file *seq, void *v)
 
 static int neigh_stat_seq_show(struct seq_file *seq, void *v)
 {
-	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
+	struct neigh_table *tbl = pde_data(file_inode(seq->file));
 	struct neigh_statistics *st = v;
 
 	if (v == SEQ_START_TOKEN) {
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index a3d74e2704c4..68eb848fcef3 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -545,7 +545,7 @@ static ssize_t pgctrl_write(struct file *file, const char __user *buf,
 
 static int pgctrl_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, pgctrl_show, PDE_DATA(inode));
+	return single_open(file, pgctrl_show, pde_data(inode));
 }
 
 static const struct proc_ops pktgen_proc_ops = {
@@ -1810,7 +1810,7 @@ static ssize_t pktgen_if_write(struct file *file,
 
 static int pktgen_if_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, pktgen_if_show, PDE_DATA(inode));
+	return single_open(file, pktgen_if_show, pde_data(inode));
 }
 
 static const struct proc_ops pktgen_if_proc_ops = {
@@ -1947,7 +1947,7 @@ static ssize_t pktgen_thread_write(struct file *file,
 
 static int pktgen_thread_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, pktgen_thread_show, PDE_DATA(inode));
+	return single_open(file, pktgen_thread_show, pde_data(inode));
 }
 
 static const struct proc_ops pktgen_thread_proc_ops = {
diff --git a/net/ipv4/netfilter/ipt_CLUSTERIP.c b/net/ipv4/netfilter/ipt_CLUSTERIP.c
index 8fd1aba8af31..96deecc729d1 100644
--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -773,7 +773,7 @@ static int clusterip_proc_open(struct inode *inode, struct file *file)
 
 	if (!ret) {
 		struct seq_file *sf = file->private_data;
-		struct clusterip_config *c = PDE_DATA(inode);
+		struct clusterip_config *c = pde_data(inode);
 
 		sf->private = c;
 
@@ -785,7 +785,7 @@ static int clusterip_proc_open(struct inode *inode, struct file *file)
 
 static int clusterip_proc_release(struct inode *inode, struct file *file)
 {
-	struct clusterip_config *c = PDE_DATA(inode);
+	struct clusterip_config *c = pde_data(inode);
 	int ret;
 
 	ret = seq_release(inode, file);
@@ -799,7 +799,7 @@ static int clusterip_proc_release(struct inode *inode, struct file *file)
 static ssize_t clusterip_proc_write(struct file *file, const char __user *input,
 				size_t size, loff_t *ofs)
 {
-	struct clusterip_config *c = PDE_DATA(file_inode(file));
+	struct clusterip_config *c = pde_data(file_inode(file));
 #define PROC_WRITELEN	10
 	char buffer[PROC_WRITELEN+1];
 	unsigned long nodenum;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index bb446e60cf58..cf74c009846e 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -970,7 +970,7 @@ struct proto raw_prot = {
 static struct sock *raw_get_first(struct seq_file *seq)
 {
 	struct sock *sk;
-	struct raw_hashinfo *h = PDE_DATA(file_inode(seq->file));
+	struct raw_hashinfo *h = pde_data(file_inode(seq->file));
 	struct raw_iter_state *state = raw_seq_private(seq);
 
 	for (state->bucket = 0; state->bucket < RAW_HTABLE_SIZE;
@@ -986,7 +986,7 @@ static struct sock *raw_get_first(struct seq_file *seq)
 
 static struct sock *raw_get_next(struct seq_file *seq, struct sock *sk)
 {
-	struct raw_hashinfo *h = PDE_DATA(file_inode(seq->file));
+	struct raw_hashinfo *h = pde_data(file_inode(seq->file));
 	struct raw_iter_state *state = raw_seq_private(seq);
 
 	do {
@@ -1015,7 +1015,7 @@ static struct sock *raw_get_idx(struct seq_file *seq, loff_t pos)
 void *raw_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(&h->lock)
 {
-	struct raw_hashinfo *h = PDE_DATA(file_inode(seq->file));
+	struct raw_hashinfo *h = pde_data(file_inode(seq->file));
 
 	read_lock(&h->lock);
 	return *pos ? raw_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
@@ -1038,7 +1038,7 @@ EXPORT_SYMBOL_GPL(raw_seq_next);
 void raw_seq_stop(struct seq_file *seq, void *v)
 	__releases(&h->lock)
 {
-	struct raw_hashinfo *h = PDE_DATA(file_inode(seq->file));
+	struct raw_hashinfo *h = pde_data(file_inode(seq->file));
 
 	read_unlock(&h->lock);
 }
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 29a57bd159f0..92d87d84d9fb 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2965,7 +2965,7 @@ static unsigned short seq_file_family(const struct seq_file *seq)
 #endif
 
 	/* Iterated from proc fs */
-	afinfo = PDE_DATA(file_inode(seq->file));
+	afinfo = pde_data(file_inode(seq->file));
 	return afinfo->family;
 }
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 933ed26eefa2..08d63c470d81 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2938,7 +2938,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 	if (state->bpf_seq_afinfo)
 		afinfo = state->bpf_seq_afinfo;
 	else
-		afinfo = PDE_DATA(file_inode(seq->file));
+		afinfo = pde_data(file_inode(seq->file));
 
 	for (state->bucket = start; state->bucket <= afinfo->udp_table->mask;
 	     ++state->bucket) {
@@ -2971,7 +2971,7 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 	if (state->bpf_seq_afinfo)
 		afinfo = state->bpf_seq_afinfo;
 	else
-		afinfo = PDE_DATA(file_inode(seq->file));
+		afinfo = pde_data(file_inode(seq->file));
 
 	do {
 		sk = sk_next(sk);
@@ -3028,7 +3028,7 @@ void udp_seq_stop(struct seq_file *seq, void *v)
 	if (state->bpf_seq_afinfo)
 		afinfo = state->bpf_seq_afinfo;
 	else
-		afinfo = PDE_DATA(file_inode(seq->file));
+		afinfo = pde_data(file_inode(seq->file));
 
 	if (state->bucket <= afinfo->udp_table->mask)
 		spin_unlock_bh(&afinfo->udp_table->hash[state->bucket].lock);
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 25524e393349..54a489f16b17 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1517,7 +1517,7 @@ EXPORT_SYMBOL_GPL(xt_unregister_table);
 #ifdef CONFIG_PROC_FS
 static void *xt_table_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	u8 af = (unsigned long)PDE_DATA(file_inode(seq->file));
+	u8 af = (unsigned long)pde_data(file_inode(seq->file));
 	struct net *net = seq_file_net(seq);
 	struct xt_pernet *xt_net;
 
@@ -1529,7 +1529,7 @@ static void *xt_table_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *xt_table_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	u8 af = (unsigned long)PDE_DATA(file_inode(seq->file));
+	u8 af = (unsigned long)pde_data(file_inode(seq->file));
 	struct net *net = seq_file_net(seq);
 	struct xt_pernet *xt_net;
 
@@ -1540,7 +1540,7 @@ static void *xt_table_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 
 static void xt_table_seq_stop(struct seq_file *seq, void *v)
 {
-	u_int8_t af = (unsigned long)PDE_DATA(file_inode(seq->file));
+	u_int8_t af = (unsigned long)pde_data(file_inode(seq->file));
 
 	mutex_unlock(&xt[af].mutex);
 }
@@ -1584,7 +1584,7 @@ static void *xt_mttg_seq_next(struct seq_file *seq, void *v, loff_t *ppos,
 		[MTTG_TRAV_NFP_UNSPEC] = MTTG_TRAV_NFP_SPEC,
 		[MTTG_TRAV_NFP_SPEC]   = MTTG_TRAV_DONE,
 	};
-	uint8_t nfproto = (unsigned long)PDE_DATA(file_inode(seq->file));
+	uint8_t nfproto = (unsigned long)pde_data(file_inode(seq->file));
 	struct nf_mttg_trav *trav = seq->private;
 
 	if (ppos != NULL)
@@ -1633,7 +1633,7 @@ static void *xt_mttg_seq_start(struct seq_file *seq, loff_t *pos,
 
 static void xt_mttg_seq_stop(struct seq_file *seq, void *v)
 {
-	uint8_t nfproto = (unsigned long)PDE_DATA(file_inode(seq->file));
+	uint8_t nfproto = (unsigned long)pde_data(file_inode(seq->file));
 	struct nf_mttg_trav *trav = seq->private;
 
 	switch (trav->class) {
diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 9c5cfd74a0ee..0859b8f76764 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -1052,7 +1052,7 @@ static struct xt_match hashlimit_mt_reg[] __read_mostly = {
 static void *dl_seq_start(struct seq_file *s, loff_t *pos)
 	__acquires(htable->lock)
 {
-	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->file));
+	struct xt_hashlimit_htable *htable = pde_data(file_inode(s->file));
 	unsigned int *bucket;
 
 	spin_lock_bh(&htable->lock);
@@ -1069,7 +1069,7 @@ static void *dl_seq_start(struct seq_file *s, loff_t *pos)
 
 static void *dl_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->file));
+	struct xt_hashlimit_htable *htable = pde_data(file_inode(s->file));
 	unsigned int *bucket = v;
 
 	*pos = ++(*bucket);
@@ -1083,7 +1083,7 @@ static void *dl_seq_next(struct seq_file *s, void *v, loff_t *pos)
 static void dl_seq_stop(struct seq_file *s, void *v)
 	__releases(htable->lock)
 {
-	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->file));
+	struct xt_hashlimit_htable *htable = pde_data(file_inode(s->file));
 	unsigned int *bucket = v;
 
 	if (!IS_ERR(bucket))
@@ -1125,7 +1125,7 @@ static void dl_seq_print(struct dsthash_ent *ent, u_int8_t family,
 static int dl_seq_real_show_v2(struct dsthash_ent *ent, u_int8_t family,
 			       struct seq_file *s)
 {
-	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->file));
+	struct xt_hashlimit_htable *ht = pde_data(file_inode(s->file));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1140,7 +1140,7 @@ static int dl_seq_real_show_v2(struct dsthash_ent *ent, u_int8_t family,
 static int dl_seq_real_show_v1(struct dsthash_ent *ent, u_int8_t family,
 			       struct seq_file *s)
 {
-	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->file));
+	struct xt_hashlimit_htable *ht = pde_data(file_inode(s->file));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1155,7 +1155,7 @@ static int dl_seq_real_show_v1(struct dsthash_ent *ent, u_int8_t family,
 static int dl_seq_real_show(struct dsthash_ent *ent, u_int8_t family,
 			    struct seq_file *s)
 {
-	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->file));
+	struct xt_hashlimit_htable *ht = pde_data(file_inode(s->file));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1169,7 +1169,7 @@ static int dl_seq_real_show(struct dsthash_ent *ent, u_int8_t family,
 
 static int dl_seq_show_v2(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->file));
+	struct xt_hashlimit_htable *htable = pde_data(file_inode(s->file));
 	unsigned int *bucket = (unsigned int *)v;
 	struct dsthash_ent *ent;
 
@@ -1183,7 +1183,7 @@ static int dl_seq_show_v2(struct seq_file *s, void *v)
 
 static int dl_seq_show_v1(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->file));
+	struct xt_hashlimit_htable *htable = pde_data(file_inode(s->file));
 	unsigned int *bucket = v;
 	struct dsthash_ent *ent;
 
@@ -1197,7 +1197,7 @@ static int dl_seq_show_v1(struct seq_file *s, void *v)
 
 static int dl_seq_show(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->file));
+	struct xt_hashlimit_htable *htable = pde_data(file_inode(s->file));
 	unsigned int *bucket = v;
 	struct dsthash_ent *ent;
 
diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index 0446307516cd..7ddb9a78e3fc 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -551,7 +551,7 @@ static int recent_seq_open(struct inode *inode, struct file *file)
 	if (st == NULL)
 		return -ENOMEM;
 
-	st->table    = PDE_DATA(inode);
+	st->table    = pde_data(inode);
 	return 0;
 }
 
@@ -559,7 +559,7 @@ static ssize_t
 recent_mt_proc_write(struct file *file, const char __user *input,
 		     size_t size, loff_t *loff)
 {
-	struct recent_table *t = PDE_DATA(file_inode(file));
+	struct recent_table *t = pde_data(file_inode(file));
 	struct recent_entry *e;
 	char buf[sizeof("+b335:1d35:1e55:dead:c0de:1715:5afe:c0de")];
 	const char *c = buf;
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index b87565b64928..c2ba9d4cd2c7 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1433,7 +1433,7 @@ static bool use_gss_proxy(struct net *net)
 static ssize_t write_gssp(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
-	struct net *net = PDE_DATA(file_inode(file));
+	struct net *net = pde_data(file_inode(file));
 	char tbuf[20];
 	unsigned long i;
 	int res;
@@ -1461,7 +1461,7 @@ static ssize_t write_gssp(struct file *file, const char __user *buf,
 static ssize_t read_gssp(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
 {
-	struct net *net = PDE_DATA(file_inode(file));
+	struct net *net = pde_data(file_inode(file));
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
 	unsigned long p = *ppos;
 	char tbuf[10];
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 59641803472c..bb1177395b99 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1536,7 +1536,7 @@ static ssize_t write_flush(struct file *file, const char __user *buf,
 static ssize_t cache_read_procfs(struct file *filp, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
-	struct cache_detail *cd = PDE_DATA(file_inode(filp));
+	struct cache_detail *cd = pde_data(file_inode(filp));
 
 	return cache_read(filp, buf, count, ppos, cd);
 }
@@ -1544,14 +1544,14 @@ static ssize_t cache_read_procfs(struct file *filp, char __user *buf,
 static ssize_t cache_write_procfs(struct file *filp, const char __user *buf,
 				  size_t count, loff_t *ppos)
 {
-	struct cache_detail *cd = PDE_DATA(file_inode(filp));
+	struct cache_detail *cd = pde_data(file_inode(filp));
 
 	return cache_write(filp, buf, count, ppos, cd);
 }
 
 static __poll_t cache_poll_procfs(struct file *filp, poll_table *wait)
 {
-	struct cache_detail *cd = PDE_DATA(file_inode(filp));
+	struct cache_detail *cd = pde_data(file_inode(filp));
 
 	return cache_poll(filp, wait, cd);
 }
@@ -1560,21 +1560,21 @@ static long cache_ioctl_procfs(struct file *filp,
 			       unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	struct cache_detail *cd = PDE_DATA(inode);
+	struct cache_detail *cd = pde_data(inode);
 
 	return cache_ioctl(inode, filp, cmd, arg, cd);
 }
 
 static int cache_open_procfs(struct inode *inode, struct file *filp)
 {
-	struct cache_detail *cd = PDE_DATA(inode);
+	struct cache_detail *cd = pde_data(inode);
 
 	return cache_open(inode, filp, cd);
 }
 
 static int cache_release_procfs(struct inode *inode, struct file *filp)
 {
-	struct cache_detail *cd = PDE_DATA(inode);
+	struct cache_detail *cd = pde_data(inode);
 
 	return cache_release(inode, filp, cd);
 }
@@ -1591,14 +1591,14 @@ static const struct proc_ops cache_channel_proc_ops = {
 
 static int content_open_procfs(struct inode *inode, struct file *filp)
 {
-	struct cache_detail *cd = PDE_DATA(inode);
+	struct cache_detail *cd = pde_data(inode);
 
 	return content_open(inode, filp, cd);
 }
 
 static int content_release_procfs(struct inode *inode, struct file *filp)
 {
-	struct cache_detail *cd = PDE_DATA(inode);
+	struct cache_detail *cd = pde_data(inode);
 
 	return content_release(inode, filp, cd);
 }
@@ -1612,14 +1612,14 @@ static const struct proc_ops content_proc_ops = {
 
 static int open_flush_procfs(struct inode *inode, struct file *filp)
 {
-	struct cache_detail *cd = PDE_DATA(inode);
+	struct cache_detail *cd = pde_data(inode);
 
 	return open_flush(inode, filp, cd);
 }
 
 static int release_flush_procfs(struct inode *inode, struct file *filp)
 {
-	struct cache_detail *cd = PDE_DATA(inode);
+	struct cache_detail *cd = pde_data(inode);
 
 	return release_flush(inode, filp, cd);
 }
@@ -1627,7 +1627,7 @@ static int release_flush_procfs(struct inode *inode, struct file *filp)
 static ssize_t read_flush_procfs(struct file *filp, char __user *buf,
 			    size_t count, loff_t *ppos)
 {
-	struct cache_detail *cd = PDE_DATA(file_inode(filp));
+	struct cache_detail *cd = pde_data(file_inode(filp));
 
 	return read_flush(filp, buf, count, ppos, cd);
 }
@@ -1636,7 +1636,7 @@ static ssize_t write_flush_procfs(struct file *filp,
 				  const char __user *buf,
 				  size_t count, loff_t *ppos)
 {
-	struct cache_detail *cd = PDE_DATA(file_inode(filp));
+	struct cache_detail *cd = pde_data(file_inode(filp));
 
 	return write_flush(filp, buf, count, ppos, cd);
 }
diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index c964b48eaaba..52908f9e6eab 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -66,7 +66,7 @@ static int rpc_proc_show(struct seq_file *seq, void *v) {
 
 static int rpc_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, rpc_proc_show, PDE_DATA(inode));
+	return single_open(file, rpc_proc_show, pde_data(inode));
 }
 
 static const struct proc_ops rpc_proc_ops = {
diff --git a/sound/core/info.c b/sound/core/info.c
index a451b24199c3..782fba87cc04 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -234,7 +234,7 @@ static int snd_info_entry_mmap(struct file *file, struct vm_area_struct *vma)
 
 static int snd_info_entry_open(struct inode *inode, struct file *file)
 {
-	struct snd_info_entry *entry = PDE_DATA(inode);
+	struct snd_info_entry *entry = pde_data(inode);
 	struct snd_info_private_data *data;
 	int mode, err;
 
@@ -365,7 +365,7 @@ static int snd_info_seq_show(struct seq_file *seq, void *p)
 
 static int snd_info_text_entry_open(struct inode *inode, struct file *file)
 {
-	struct snd_info_entry *entry = PDE_DATA(inode);
+	struct snd_info_entry *entry = pde_data(inode);
 	struct snd_info_private_data *data;
 	int err;
 
-- 
2.11.0

