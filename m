Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64CD21145B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 22:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgGAUXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 16:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgGAUX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:23:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED65EC08C5DD;
        Wed,  1 Jul 2020 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yEYdn639qiNled9eHW+YAWlGBsztWpHG5PfOfZX6iss=; b=fLCZWTJ5tTvh7ItBU1pAhItrvO
        NB+9AtvOsh0pcsG8jfroIj0RysWi+cG9HfmVV0tW1xBUBQtHTQHJsrkydRmXQfgERsa0KB0h7u7FC
        SJH51SxiH7AT6Nwz3Gjxi0a8AojII1VdIFY2+6HurAyv1Qmz84lCcxnL4a950B/mXPwjWf4Gx60de
        jaQfp1OwRABrRHb7iXmJRwrUJObsvrRykcPEY9iY4zz3YmeesnNqCOBdLJ8MR2Hk+yk+FTz9ye3Xw
        u7bVNB/5mIzio9Mtl4eu12UYm/Fn2BcC4og7Lqym4Zuwta0Ou1dOcm9ftzCfsrYifSdpM7eVzi1hE
        vvYE/+hg==;
Received: from [2001:4bb8:18c:3b3b:379a:a079:66b5:89c3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjGK-0002Sg-8C; Wed, 01 Jul 2020 20:23:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/23] proc: switch over direct seq_read method calls to seq_read_iter
Date:   Wed,  1 Jul 2020 22:09:46 +0200
Message-Id: <20200701200951.3603160-19-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701200951.3603160-1-hch@lst.de>
References: <20200701200951.3603160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch over all instances used directly as methods using these sed
expressions:

sed -i -e 's/\.proc_read\(\s*=\s*\)seq_read/\.proc_read_iter\1seq_read_iter/g'

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/kernel/srm_env.c                        |  2 +-
 arch/arm/mm/alignment.c                            |  2 +-
 arch/powerpc/kernel/rtas-proc.c                    | 10 +++++-----
 arch/powerpc/mm/numa.c                             |  2 +-
 arch/powerpc/platforms/pseries/lpar.c              |  4 ++--
 arch/powerpc/platforms/pseries/lparcfg.c           |  2 +-
 arch/sh/mm/alignment.c                             |  2 +-
 arch/sparc/kernel/led.c                            |  2 +-
 arch/um/kernel/exitcode.c                          |  2 +-
 arch/um/kernel/process.c                           |  2 +-
 arch/x86/kernel/cpu/mtrr/if.c                      |  2 +-
 arch/x86/platform/uv/tlb_uv.c                      |  2 +-
 drivers/acpi/battery.c                             |  2 +-
 drivers/acpi/proc.c                                |  2 +-
 drivers/hwmon/dell-smm-hwmon.c                     |  2 +-
 drivers/ide/ide-proc.c                             |  2 +-
 drivers/input/input.c                              |  4 ++--
 drivers/macintosh/via-pmu.c                        |  2 +-
 drivers/md/md.c                                    |  2 +-
 drivers/misc/sgi-gru/gruprocfs.c                   |  6 +++---
 drivers/net/wireless/intel/ipw2x00/libipw_module.c |  2 +-
 .../net/wireless/intersil/hostap/hostap_download.c |  2 +-
 drivers/parisc/led.c                               |  2 +-
 drivers/platform/x86/thinkpad_acpi.c               |  2 +-
 drivers/platform/x86/toshiba_acpi.c                |  8 ++++----
 drivers/pnp/pnpbios/proc.c                         |  2 +-
 drivers/s390/block/dasd_proc.c                     |  2 +-
 drivers/s390/cio/blacklist.c                       |  2 +-
 drivers/scsi/scsi_devinfo.c                        |  2 +-
 drivers/scsi/scsi_proc.c                           |  4 ++--
 drivers/scsi/sg.c                                  |  4 ++--
 .../staging/rtl8192u/ieee80211/ieee80211_module.c  |  2 +-
 drivers/usb/gadget/function/rndis.c                |  2 +-
 drivers/video/fbdev/via/viafbdev.c                 | 14 +++++++-------
 fs/cifs/cifs_debug.c                               | 14 +++++++-------
 fs/cifs/dfs_cache.c                                |  2 +-
 fs/fscache/object-list.c                           |  2 +-
 fs/jbd2/journal.c                                  |  2 +-
 fs/jfs/jfs_debug.c                                 |  2 +-
 fs/nfsd/nfsctl.c                                   |  2 +-
 fs/nfsd/stats.c                                    |  2 +-
 fs/proc/cpuinfo.c                                  |  2 +-
 fs/proc/generic.c                                  |  4 ++--
 fs/proc/proc_net.c                                 |  4 ++--
 fs/proc/stat.c                                     |  2 +-
 include/linux/seq_file.h                           |  2 +-
 ipc/util.c                                         |  2 +-
 kernel/irq/proc.c                                  |  6 +++---
 kernel/kallsyms.c                                  |  2 +-
 kernel/latencytop.c                                |  2 +-
 kernel/locking/lockdep_proc.c                      |  2 +-
 kernel/module.c                                    |  2 +-
 kernel/profile.c                                   |  2 +-
 kernel/sched/psi.c                                 |  6 +++---
 lib/dynamic_debug.c                                |  2 +-
 mm/slab_common.c                                   |  2 +-
 mm/swapfile.c                                      |  2 +-
 net/atm/mpoa_proc.c                                |  2 +-
 net/core/pktgen.c                                  |  6 +++---
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  2 +-
 net/ipv4/route.c                                   |  4 ++--
 net/netfilter/xt_recent.c                          |  2 +-
 net/sunrpc/cache.c                                 |  2 +-
 net/sunrpc/stats.c                                 |  2 +-
 sound/core/info.c                                  |  2 +-
 65 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/arch/alpha/kernel/srm_env.c b/arch/alpha/kernel/srm_env.c
index 528d2be5818298..8ad9c100ef7612 100644
--- a/arch/alpha/kernel/srm_env.c
+++ b/arch/alpha/kernel/srm_env.c
@@ -121,7 +121,7 @@ static ssize_t srm_env_proc_write(struct file *file, const char __user *buffer,
 
 static const struct proc_ops srm_env_proc_ops = {
 	.proc_open	= srm_env_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= srm_env_proc_write,
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 81a627e6e1c599..412cab88402acd 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -164,7 +164,7 @@ static ssize_t alignment_proc_write(struct file *file, const char __user *buffer
 
 static const struct proc_ops alignment_proc_ops = {
 	.proc_open	= alignment_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= alignment_proc_write,
diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index 2d33f342a29307..3aace56aacc1df 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -161,7 +161,7 @@ static int poweron_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops ppc_rtas_poweron_proc_ops = {
 	.proc_open	= poweron_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= ppc_rtas_poweron_write,
 	.proc_release	= single_release,
@@ -174,7 +174,7 @@ static int progress_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops ppc_rtas_progress_proc_ops = {
 	.proc_open	= progress_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= ppc_rtas_progress_write,
 	.proc_release	= single_release,
@@ -187,7 +187,7 @@ static int clock_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops ppc_rtas_clock_proc_ops = {
 	.proc_open	= clock_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= ppc_rtas_clock_write,
 	.proc_release	= single_release,
@@ -200,7 +200,7 @@ static int tone_freq_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops ppc_rtas_tone_freq_proc_ops = {
 	.proc_open	= tone_freq_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= ppc_rtas_tone_freq_write,
 	.proc_release	= single_release,
@@ -213,7 +213,7 @@ static int tone_volume_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops ppc_rtas_tone_volume_proc_ops = {
 	.proc_open	= tone_volume_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= ppc_rtas_tone_volume_write,
 	.proc_release	= single_release,
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 9fcf2d19583004..2f3aef6c0b513b 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1672,7 +1672,7 @@ static ssize_t topology_write(struct file *file, const char __user *buf,
 }
 
 static const struct proc_ops topology_proc_ops = {
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= topology_write,
 	.proc_open	= topology_open,
 	.proc_release	= single_release,
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index fd26f3d21d7b4b..2b13a67d60e206 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -584,7 +584,7 @@ static int vcpudispatch_stats_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops vcpudispatch_stats_proc_ops = {
 	.proc_open	= vcpudispatch_stats_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= vcpudispatch_stats_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
@@ -628,7 +628,7 @@ static int vcpudispatch_stats_freq_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops vcpudispatch_stats_freq_proc_ops = {
 	.proc_open	= vcpudispatch_stats_freq_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= vcpudispatch_stats_freq_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index b8d28ab881789d..35eb0e4b8fd31a 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -699,7 +699,7 @@ static int lparcfg_open(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops lparcfg_proc_ops = {
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= lparcfg_write,
 	.proc_open	= lparcfg_open,
 	.proc_release	= single_release,
diff --git a/arch/sh/mm/alignment.c b/arch/sh/mm/alignment.c
index fb517b82a87b10..66115241ad93a4 100644
--- a/arch/sh/mm/alignment.c
+++ b/arch/sh/mm/alignment.c
@@ -154,7 +154,7 @@ static ssize_t alignment_proc_write(struct file *file,
 
 static const struct proc_ops alignment_proc_ops = {
 	.proc_open	= alignment_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= alignment_proc_write,
diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index bd48575172c323..a0b893d216c443 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -106,7 +106,7 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
 
 static const struct proc_ops led_proc_ops = {
 	.proc_open	= led_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= led_proc_write,
diff --git a/arch/um/kernel/exitcode.c b/arch/um/kernel/exitcode.c
index 43edc2aa57e4fb..95184d271a47cf 100644
--- a/arch/um/kernel/exitcode.c
+++ b/arch/um/kernel/exitcode.c
@@ -57,7 +57,7 @@ static ssize_t exitcode_proc_write(struct file *file,
 
 static const struct proc_ops exitcode_proc_ops = {
 	.proc_open	= exitcode_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= exitcode_proc_write,
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index e3a2cf92a3738b..f3e4bd48f6d5b6 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -312,7 +312,7 @@ static ssize_t sysemu_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops sysemu_proc_ops = {
 	.proc_open	= sysemu_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= sysemu_proc_write,
diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index a5c506f6da7fa1..f5743b5ecaf232 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -398,7 +398,7 @@ static int mtrr_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops mtrr_proc_ops = {
 	.proc_open		= mtrr_open,
-	.proc_read		= seq_read,
+	.proc_read_iter		= seq_read_iter,
 	.proc_lseek		= seq_lseek,
 	.proc_write		= mtrr_write,
 	.proc_ioctl		= mtrr_ioctl,
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 0ac96ca304c7b5..cd6ee86283e6e1 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -1670,7 +1670,7 @@ static int tunables_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops uv_ptc_proc_ops = {
 	.proc_open	= ptc_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= ptc_proc_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 366c389175d844..c8e5972ad6c952 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1204,7 +1204,7 @@ static int acpi_battery_alarm_proc_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops acpi_battery_alarm_proc_ops = {
 	.proc_open	= acpi_battery_alarm_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= acpi_battery_write_alarm,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 7892980b3ce4d3..774da498c77265 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -136,7 +136,7 @@ acpi_system_wakeup_device_open_fs(struct inode *inode, struct file *file)
 
 static const struct proc_ops acpi_system_wakeup_device_proc_ops = {
 	.proc_open	= acpi_system_wakeup_device_open_fs,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= acpi_system_write_wakeup_device,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 16be012a95ed84..29ac388429620f 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -597,7 +597,7 @@ static int i8k_open_fs(struct inode *inode, struct file *file)
 
 static const struct proc_ops i8k_proc_ops = {
 	.proc_open	= i8k_open_fs,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_ioctl	= i8k_ioctl,
diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 8ea282a3a19f0d..a0b56737152fb5 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -383,7 +383,7 @@ static ssize_t ide_settings_proc_write(struct file *file, const char __user *buf
 
 static const struct proc_ops ide_settings_proc_ops = {
 	.proc_open	= ide_settings_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= ide_settings_proc_write,
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 3cfd2c18eebd9d..c8180d7f92d576 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1220,7 +1220,7 @@ static int input_proc_devices_open(struct inode *inode, struct file *file)
 static const struct proc_ops input_devices_proc_ops = {
 	.proc_open	= input_proc_devices_open,
 	.proc_poll	= input_proc_devices_poll,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
 };
@@ -1282,7 +1282,7 @@ static int input_proc_handlers_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops input_handlers_proc_ops = {
 	.proc_open	= input_proc_handlers_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
 };
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 73e6ae88fafd4e..9415eddb419402 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -973,7 +973,7 @@ static ssize_t pmu_options_proc_write(struct file *file,
 
 static const struct proc_ops pmu_options_proc_ops = {
 	.proc_open	= pmu_options_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= pmu_options_proc_write,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f567f536b529bd..0bae6c1523cec6 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8301,7 +8301,7 @@ static __poll_t mdstat_poll(struct file *filp, poll_table *wait)
 
 static const struct proc_ops mdstat_proc_ops = {
 	.proc_open	= md_seq_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
 	.proc_poll	= mdstat_poll,
diff --git a/drivers/misc/sgi-gru/gruprocfs.c b/drivers/misc/sgi-gru/gruprocfs.c
index 97b8b38ab47dfd..fc9498ec797762 100644
--- a/drivers/misc/sgi-gru/gruprocfs.c
+++ b/drivers/misc/sgi-gru/gruprocfs.c
@@ -257,7 +257,7 @@ static int options_open(struct inode *inode, struct file *file)
 /* *INDENT-OFF* */
 static const struct proc_ops statistics_proc_ops = {
 	.proc_open	= statistics_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= statistics_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
@@ -265,7 +265,7 @@ static const struct proc_ops statistics_proc_ops = {
 
 static const struct proc_ops mcs_statistics_proc_ops = {
 	.proc_open	= mcs_statistics_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= mcs_statistics_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
@@ -273,7 +273,7 @@ static const struct proc_ops mcs_statistics_proc_ops = {
 
 static const struct proc_ops options_proc_ops = {
 	.proc_open	= options_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= options_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_module.c b/drivers/net/wireless/intel/ipw2x00/libipw_module.c
index 43bab92a4148f2..1929db6921d7e0 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_module.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_module.c
@@ -242,7 +242,7 @@ static ssize_t debug_level_proc_write(struct file *file,
 
 static const struct proc_ops debug_level_proc_ops = {
 	.proc_open	= debug_level_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= debug_level_proc_write,
diff --git a/drivers/net/wireless/intersil/hostap/hostap_download.c b/drivers/net/wireless/intersil/hostap/hostap_download.c
index 7c6a5a6d1d45d8..8980fd57b2eda4 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_download.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_download.c
@@ -234,7 +234,7 @@ static int prism2_download_aux_dump_proc_open(struct inode *inode, struct file *
 
 static const struct proc_ops prism2_download_aux_dump_proc_ops = {
 	.proc_open		= prism2_download_aux_dump_proc_open,
-	.proc_read		= seq_read,
+	.proc_read_iter		= seq_read_iter,
 	.proc_lseek		= seq_lseek,
 	.proc_release		= seq_release_private,
 };
diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index 36c6613f7a36b7..d75df3977926b3 100644
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -232,7 +232,7 @@ static ssize_t led_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops led_proc_ops = {
 	.proc_open	= led_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= led_proc_write,
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ff7f0a4f247563..f571d6254e7c34 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -901,7 +901,7 @@ static ssize_t dispatch_proc_write(struct file *file,
 
 static const struct proc_ops dispatch_proc_ops = {
 	.proc_open	= dispatch_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= dispatch_proc_write,
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 1ddab5a6dead6d..770477bb407d49 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -1428,7 +1428,7 @@ static ssize_t lcd_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops lcd_proc_ops = {
 	.proc_open	= lcd_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= lcd_proc_write,
@@ -1534,7 +1534,7 @@ static ssize_t video_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops video_proc_ops = {
 	.proc_open	= video_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= video_proc_write,
@@ -1611,7 +1611,7 @@ static ssize_t fan_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops fan_proc_ops = {
 	.proc_open	= fan_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= fan_proc_write,
@@ -1655,7 +1655,7 @@ static ssize_t keys_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops keys_proc_ops = {
 	.proc_open	= keys_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= keys_proc_write,
diff --git a/drivers/pnp/pnpbios/proc.c b/drivers/pnp/pnpbios/proc.c
index a806830e3a407f..10d0181c4430ab 100644
--- a/drivers/pnp/pnpbios/proc.c
+++ b/drivers/pnp/pnpbios/proc.c
@@ -212,7 +212,7 @@ static ssize_t pnpbios_proc_write(struct file *file, const char __user *buf,
 
 static const struct proc_ops pnpbios_proc_ops = {
 	.proc_open	= pnpbios_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= pnpbios_proc_write,
diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
index 62a859ea67f893..278f0dccc85ff1 100644
--- a/drivers/s390/block/dasd_proc.c
+++ b/drivers/s390/block/dasd_proc.c
@@ -322,7 +322,7 @@ static ssize_t dasd_stats_proc_write(struct file *file,
 
 static const struct proc_ops dasd_stats_proc_ops = {
 	.proc_open	= dasd_stats_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= dasd_stats_proc_write,
diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
index 4dd2eb63485699..05f58c453b060c 100644
--- a/drivers/s390/cio/blacklist.c
+++ b/drivers/s390/cio/blacklist.c
@@ -401,7 +401,7 @@ cio_ignore_proc_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops cio_ignore_proc_ops = {
 	.proc_open	= cio_ignore_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release_private,
 	.proc_write	= cio_ignore_write,
diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index eed31021e7885c..87fb440ddfc5d8 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -738,7 +738,7 @@ static ssize_t proc_scsi_devinfo_write(struct file *file,
 
 static const struct proc_ops scsi_devinfo_proc_ops = {
 	.proc_open	= proc_scsi_devinfo_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= proc_scsi_devinfo_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index d6982d3557396b..81601a9e79c4db 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -86,7 +86,7 @@ static int proc_scsi_host_open(struct inode *inode, struct file *file)
 static const struct proc_ops proc_scsi_ops = {
 	.proc_open	= proc_scsi_host_open,
 	.proc_release	= single_release,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= proc_scsi_host_write
 };
@@ -438,7 +438,7 @@ static int proc_scsi_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops scsi_scsi_proc_ops = {
 	.proc_open	= proc_scsi_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= proc_scsi_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 20472aaaf630a4..c5d482190066bc 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2328,7 +2328,7 @@ static ssize_t sg_proc_write_adio(struct file *filp, const char __user *buffer,
 			          size_t count, loff_t *off);
 static const struct proc_ops adio_proc_ops = {
 	.proc_open	= sg_proc_single_open_adio,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= sg_proc_write_adio,
 	.proc_release	= single_release,
@@ -2339,7 +2339,7 @@ static ssize_t sg_proc_write_dressz(struct file *filp,
 		const char __user *buffer, size_t count, loff_t *off);
 static const struct proc_ops dressz_proc_ops = {
 	.proc_open	= sg_proc_single_open_dressz,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= sg_proc_write_dressz,
 	.proc_release	= single_release,
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index a5a1b14f5a40c5..e198779db6fc2e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -265,7 +265,7 @@ static int open_debug_level(struct inode *inode, struct file *file)
 
 static const struct proc_ops debug_level_proc_ops = {
 	.proc_open	= open_debug_level,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= write_debug_level,
 	.proc_release	= single_release,
diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index 64de9f1b874c55..562781b95101d3 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -1166,7 +1166,7 @@ static int rndis_proc_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops rndis_proc_ops = {
 	.proc_open	= rndis_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= rndis_proc_write,
diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 22deb340a0484f..6cf91191de7f15 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -1175,7 +1175,7 @@ static ssize_t viafb_dvp0_proc_write(struct file *file,
 
 static const struct proc_ops viafb_dvp0_proc_ops = {
 	.proc_open	= viafb_dvp0_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= viafb_dvp0_proc_write,
@@ -1239,7 +1239,7 @@ static ssize_t viafb_dvp1_proc_write(struct file *file,
 
 static const struct proc_ops viafb_dvp1_proc_ops = {
 	.proc_open	= viafb_dvp1_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= viafb_dvp1_proc_write,
@@ -1273,7 +1273,7 @@ static ssize_t viafb_dfph_proc_write(struct file *file,
 
 static const struct proc_ops viafb_dfph_proc_ops = {
 	.proc_open	= viafb_dfph_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= viafb_dfph_proc_write,
@@ -1307,7 +1307,7 @@ static ssize_t viafb_dfpl_proc_write(struct file *file,
 
 static const struct proc_ops viafb_dfpl_proc_ops = {
 	.proc_open	= viafb_dfpl_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= viafb_dfpl_proc_write,
@@ -1442,7 +1442,7 @@ static ssize_t viafb_vt1636_proc_write(struct file *file,
 
 static const struct proc_ops viafb_vt1636_proc_ops = {
 	.proc_open	= viafb_vt1636_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= viafb_vt1636_proc_write,
@@ -1519,7 +1519,7 @@ static ssize_t viafb_iga1_odev_proc_write(struct file *file,
 
 static const struct proc_ops viafb_iga1_odev_proc_ops = {
 	.proc_open	= viafb_iga1_odev_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= viafb_iga1_odev_proc_write,
@@ -1558,7 +1558,7 @@ static ssize_t viafb_iga2_odev_proc_write(struct file *file,
 
 static const struct proc_ops viafb_iga2_odev_proc_ops = {
 	.proc_open	= viafb_iga2_odev_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= viafb_iga2_odev_proc_write,
diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index fc98b97b396a44..65eb425cc3adf0 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -615,7 +615,7 @@ static int cifs_stats_proc_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops cifs_stats_proc_ops = {
 	.proc_open	= cifs_stats_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= cifs_stats_proc_write,
@@ -644,7 +644,7 @@ static int name##_open(struct inode *inode, struct file *file) \
 \
 static const struct proc_ops cifs_##name##_proc_fops = { \
 	.proc_open	= name##_open, \
-	.proc_read	= seq_read, \
+	.proc_read_iter	= seq_read_iter, \
 	.proc_lseek	= seq_lseek, \
 	.proc_release	= single_release, \
 	.proc_write	= name##_write, \
@@ -778,7 +778,7 @@ static ssize_t cifsFYI_proc_write(struct file *file, const char __user *buffer,
 
 static const struct proc_ops cifsFYI_proc_ops = {
 	.proc_open	= cifsFYI_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= cifsFYI_proc_write,
@@ -809,7 +809,7 @@ static ssize_t cifs_linux_ext_proc_write(struct file *file,
 
 static const struct proc_ops cifs_linux_ext_proc_ops = {
 	.proc_open	= cifs_linux_ext_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= cifs_linux_ext_proc_write,
@@ -840,7 +840,7 @@ static ssize_t cifs_lookup_cache_proc_write(struct file *file,
 
 static const struct proc_ops cifs_lookup_cache_proc_ops = {
 	.proc_open	= cifs_lookup_cache_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= cifs_lookup_cache_proc_write,
@@ -871,7 +871,7 @@ static ssize_t traceSMB_proc_write(struct file *file, const char __user *buffer,
 
 static const struct proc_ops traceSMB_proc_ops = {
 	.proc_open	= traceSMB_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= traceSMB_proc_write,
@@ -982,7 +982,7 @@ static ssize_t cifs_security_flags_proc_write(struct file *file,
 
 static const struct proc_ops cifs_security_flags_proc_ops = {
 	.proc_open	= cifs_security_flags_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= cifs_security_flags_proc_write,
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index df81c718d2faec..a4fe155fc92a7a 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -214,7 +214,7 @@ static int dfscache_proc_open(struct inode *inode, struct file *file)
 
 const struct proc_ops dfscache_proc_ops = {
 	.proc_open	= dfscache_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= dfscache_proc_write,
diff --git a/fs/fscache/object-list.c b/fs/fscache/object-list.c
index e106a1a1600d82..fab5a4197f50c3 100644
--- a/fs/fscache/object-list.c
+++ b/fs/fscache/object-list.c
@@ -408,7 +408,7 @@ static int fscache_objlist_release(struct inode *inode, struct file *file)
 
 const struct proc_ops fscache_objlist_proc_ops = {
 	.proc_open	= fscache_objlist_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= fscache_objlist_release,
 };
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e4944436e733d0..db661b953c4378 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1080,7 +1080,7 @@ static int jbd2_seq_info_release(struct inode *inode, struct file *file)
 
 static const struct proc_ops jbd2_info_proc_ops = {
 	.proc_open	= jbd2_seq_info_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= jbd2_seq_info_release,
 };
diff --git a/fs/jfs/jfs_debug.c b/fs/jfs/jfs_debug.c
index 44b62b3c322e9a..235df6bac1d71a 100644
--- a/fs/jfs/jfs_debug.c
+++ b/fs/jfs/jfs_debug.c
@@ -45,7 +45,7 @@ static ssize_t jfs_loglevel_proc_write(struct file *file,
 
 static const struct proc_ops jfs_loglevel_proc_ops = {
 	.proc_open	= jfs_loglevel_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= jfs_loglevel_proc_write,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 1b36a8ba82d204..a73899dfc09b9d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -159,7 +159,7 @@ static int exports_proc_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops exports_proc_ops = {
 	.proc_open	= exports_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
 };
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index b1bc582b0493e4..1076f87715ad88 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -86,7 +86,7 @@ static int nfsd_proc_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops nfsd_proc_ops = {
 	.proc_open	= nfsd_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 };
diff --git a/fs/proc/cpuinfo.c b/fs/proc/cpuinfo.c
index d0989a443c77df..419760fd77bdd8 100644
--- a/fs/proc/cpuinfo.c
+++ b/fs/proc/cpuinfo.c
@@ -19,7 +19,7 @@ static int cpuinfo_open(struct inode *inode, struct file *file)
 static const struct proc_ops cpuinfo_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= cpuinfo_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
 };
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 2f9fa179194d72..4323b28db5643a 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -590,7 +590,7 @@ static int proc_seq_release(struct inode *inode, struct file *file)
 static const struct proc_ops proc_seq_ops = {
 	/* not permanent -- can call into arbitrary seq_operations */
 	.proc_open	= proc_seq_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= proc_seq_release,
 };
@@ -621,7 +621,7 @@ static int proc_single_open(struct inode *inode, struct file *file)
 static const struct proc_ops proc_single_ops = {
 	/* not permanent -- can call into arbitrary ->single_show */
 	.proc_open	= proc_single_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 };
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index dba63b2429f05f..8274f4fc4d4338 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -92,7 +92,7 @@ static int seq_release_net(struct inode *ino, struct file *f)
 
 static const struct proc_ops proc_net_seq_ops = {
 	.proc_open	= seq_open_net,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= proc_simple_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release_net,
@@ -204,7 +204,7 @@ static int single_release_net(struct inode *ino, struct file *f)
 
 static const struct proc_ops proc_net_single_ops = {
 	.proc_open	= single_open_net,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= proc_simple_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release_net,
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 46b3293015fe61..4695b6de315129 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -226,7 +226,7 @@ static int stat_open(struct inode *inode, struct file *file)
 static const struct proc_ops stat_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= stat_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 };
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 0c9e9c8607e788..04f342179f5572 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -187,7 +187,7 @@ static int __name ## _open(struct inode *inode, struct file *file)	\
 									\
 static const struct proc_ops __name ## _proc_ops = {			\
 	.proc_open	= __name ## _open,				\
-	.proc_read	= seq_read,					\
+	.proc_read_iter	= seq_read_iter,					\
 	.proc_lseek	= seq_lseek,					\
 	.proc_release	= single_release,				\
 }
diff --git a/ipc/util.c b/ipc/util.c
index cfa0045e748d55..189c835108afc8 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -887,7 +887,7 @@ static int sysvipc_proc_release(struct inode *inode, struct file *file)
 static const struct proc_ops sysvipc_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= sysvipc_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= sysvipc_proc_release,
 };
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 32c071d7bc0338..6c541898f614c4 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -200,7 +200,7 @@ static int irq_affinity_list_proc_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops irq_affinity_proc_ops = {
 	.proc_open	= irq_affinity_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= irq_affinity_proc_write,
@@ -208,7 +208,7 @@ static const struct proc_ops irq_affinity_proc_ops = {
 
 static const struct proc_ops irq_affinity_list_proc_ops = {
 	.proc_open	= irq_affinity_list_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= irq_affinity_list_proc_write,
@@ -270,7 +270,7 @@ static int default_affinity_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops default_affinity_proc_ops = {
 	.proc_open	= default_affinity_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= default_affinity_write,
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 16c8c605f4b0fa..90facda3b723ab 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -699,7 +699,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 
 static const struct proc_ops kallsyms_proc_ops = {
 	.proc_open	= kallsyms_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release_private,
 };
diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 166d7bf49666b0..543c7f552c45ce 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -257,7 +257,7 @@ static int lstats_open(struct inode *inode, struct file *filp)
 
 static const struct proc_ops lstats_proc_ops = {
 	.proc_open	= lstats_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= lstats_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 5525cd3ba0c83c..60c725f53c26d7 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -669,7 +669,7 @@ static int lock_stat_release(struct inode *inode, struct file *file)
 static const struct proc_ops lock_stat_proc_ops = {
 	.proc_open	= lock_stat_open,
 	.proc_write	= lock_stat_write,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= lock_stat_release,
 };
diff --git a/kernel/module.c b/kernel/module.c
index 0c6573b98c3662..eb2f8424f3da04 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4388,7 +4388,7 @@ static int modules_open(struct inode *inode, struct file *file)
 static const struct proc_ops modules_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= modules_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
 };
diff --git a/kernel/profile.c b/kernel/profile.c
index 6f69a4195d5630..101090397235ae 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -444,7 +444,7 @@ static ssize_t prof_cpu_mask_proc_write(struct file *file,
 
 static const struct proc_ops prof_cpu_mask_proc_ops = {
 	.proc_open	= prof_cpu_mask_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= prof_cpu_mask_proc_write,
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 8f45cdb6463b88..6795170140a031 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1305,7 +1305,7 @@ static int psi_fop_release(struct inode *inode, struct file *file)
 
 static const struct proc_ops psi_io_proc_ops = {
 	.proc_open	= psi_io_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= psi_io_write,
 	.proc_poll	= psi_fop_poll,
@@ -1314,7 +1314,7 @@ static const struct proc_ops psi_io_proc_ops = {
 
 static const struct proc_ops psi_memory_proc_ops = {
 	.proc_open	= psi_memory_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= psi_memory_write,
 	.proc_poll	= psi_fop_poll,
@@ -1323,7 +1323,7 @@ static const struct proc_ops psi_memory_proc_ops = {
 
 static const struct proc_ops psi_cpu_proc_ops = {
 	.proc_open	= psi_cpu_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= psi_cpu_write,
 	.proc_poll	= psi_fop_poll,
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 76750e73dcaf9d..2317d29e16def9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -878,7 +878,7 @@ static const struct file_operations ddebug_proc_fops = {
 
 static const struct proc_ops proc_fops = {
 	.proc_open = ddebug_proc_open,
-	.proc_read = seq_read,
+	.proc_read_iter = seq_read_iter,
 	.proc_lseek = seq_lseek,
 	.proc_release = seq_release_private,
 	.proc_write = ddebug_proc_write
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 37d48a56431d04..5cf40d2d721c0b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1584,7 +1584,7 @@ static int slabinfo_open(struct inode *inode, struct file *file)
 static const struct proc_ops slabinfo_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= slabinfo_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= slabinfo_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 987276c557d1f1..2e50f52a14c7c2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2835,7 +2835,7 @@ static int swaps_open(struct inode *inode, struct file *file)
 static const struct proc_ops swaps_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= swaps_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
 	.proc_poll	= swaps_poll,
diff --git a/net/atm/mpoa_proc.c b/net/atm/mpoa_proc.c
index 829db9eba0cb95..fe8f822c7750a6 100644
--- a/net/atm/mpoa_proc.c
+++ b/net/atm/mpoa_proc.c
@@ -55,7 +55,7 @@ static int parse_qos(const char *buff);
 
 static const struct proc_ops mpc_proc_ops = {
 	.proc_open	= proc_mpc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= proc_mpc_write,
 	.proc_release	= seq_release,
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index b53b6d38c4dff8..200b976202d0d1 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -537,7 +537,7 @@ static int pgctrl_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops pktgen_proc_ops = {
 	.proc_open	= pgctrl_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= pgctrl_write,
 	.proc_release	= single_release,
@@ -1709,7 +1709,7 @@ static int pktgen_if_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops pktgen_if_proc_ops = {
 	.proc_open	= pktgen_if_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= pktgen_if_write,
 	.proc_release	= single_release,
@@ -1846,7 +1846,7 @@ static int pktgen_thread_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops pktgen_thread_proc_ops = {
 	.proc_open	= pktgen_thread_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_write	= pktgen_thread_write,
 	.proc_release	= single_release,
diff --git a/net/ipv4/netfilter/ipt_CLUSTERIP.c b/net/ipv4/netfilter/ipt_CLUSTERIP.c
index f8755a4ae9d4bd..67472389c9c395 100644
--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -806,7 +806,7 @@ static ssize_t clusterip_proc_write(struct file *file, const char __user *input,
 
 static const struct proc_ops clusterip_proc_ops = {
 	.proc_open	= clusterip_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= clusterip_proc_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= clusterip_proc_release,
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 1d7076b78e630b..4d5f26478f1001 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -239,7 +239,7 @@ static int rt_cache_seq_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops rt_cache_proc_ops = {
 	.proc_open	= rt_cache_seq_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
 };
@@ -330,7 +330,7 @@ static int rt_cpu_seq_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops rt_cpu_proc_ops = {
 	.proc_open	= rt_cpu_seq_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
 };
diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index 19bef176145eb9..f9cc00f7486058 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -618,7 +618,7 @@ recent_mt_proc_write(struct file *file, const char __user *input,
 
 static const struct proc_ops recent_mt_proc_ops = {
 	.proc_open	= recent_seq_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= recent_mt_proc_write,
 	.proc_release	= seq_release_private,
 	.proc_lseek	= seq_lseek,
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index e5c01697c3f1d6..3671c464e0d30f 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1623,7 +1623,7 @@ static int content_release_procfs(struct inode *inode, struct file *filp)
 
 static const struct proc_ops content_proc_ops = {
 	.proc_open	= content_open_procfs,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= content_release_procfs,
 };
diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index c964b48eaabae4..95b56f0e5a01e8 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -71,7 +71,7 @@ static int rpc_proc_open(struct inode *inode, struct file *file)
 
 static const struct proc_ops rpc_proc_ops = {
 	.proc_open	= rpc_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 };
diff --git a/sound/core/info.c b/sound/core/info.c
index 8c6bc5241df50c..6e2a35a37b5e6b 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -426,7 +426,7 @@ static const struct proc_ops snd_info_text_entry_ops =
 	.proc_release	= snd_info_text_entry_release,
 	.proc_write	= snd_info_text_entry_write,
 	.proc_lseek	= seq_lseek,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 };
 
 static struct snd_info_entry *create_subdir(struct module *mod,
-- 
2.26.2

