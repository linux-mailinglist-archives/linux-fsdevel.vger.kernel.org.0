Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624D1559EEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiFXQ5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 12:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiFXQ5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36804E3A7;
        Fri, 24 Jun 2022 09:57:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EB6562330;
        Fri, 24 Jun 2022 16:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD79C341CF;
        Fri, 24 Jun 2022 16:57:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QyXh3mOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656089819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cqTVYxT02aH0Hi5oh8DFErIu3yaefhZJw7FOYWYohNs=;
        b=QyXh3mOnD3mh/tK36SUB8M2y7b3Bc7aV19s7fMyN0G/baE8LjIAVBbCvCI+pKaD7yt+Twp
        rF8cPOcxjkxhOfzxPRoBPgKl2y/5g6SAIqjdc8YzBHdDkMzomIPvT8oRF3ovWhytZ7He2b
        ryf6YKGZtN4Zle2LVgQiuZm5df1+8Zk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 94a18d9a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 24 Jun 2022 16:56:58 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 2/6] fs: do not set no_llseek in fops
Date:   Fri, 24 Jun 2022 18:56:27 +0200
Message-Id: <20220624165631.2124632-3-Jason@zx2c4.com>
In-Reply-To: <20220624165631.2124632-1-Jason@zx2c4.com>
References: <20220624165631.2124632-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vfs_llseek already does something with this, and it makes it difficult
to distinguish between llseek being supported and not.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 .../watchdog/convert_drivers_to_kernel_api.rst  |  1 -
 arch/parisc/kernel/perf.c                       |  1 -
 arch/powerpc/kernel/eeh.c                       |  4 ----
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c       |  1 -
 arch/powerpc/platforms/cell/spufs/file.c        | 17 -----------------
 arch/powerpc/platforms/powernv/eeh-powernv.c    |  1 -
 arch/powerpc/platforms/pseries/dtl.c            |  1 -
 arch/s390/hypfs/hypfs_dbfs.c                    |  1 -
 arch/s390/hypfs/inode.c                         |  1 -
 arch/s390/kernel/debug.c                        |  1 -
 arch/s390/kernel/perf_cpum_cf.c                 |  1 -
 arch/s390/kernel/sysinfo.c                      |  1 -
 arch/s390/pci/pci_clp.c                         |  1 -
 arch/um/drivers/harddog_kern.c                  |  1 -
 arch/um/drivers/hostaudio_kern.c                |  2 --
 arch/x86/kernel/cpu/mce/dev-mcelog.c            |  1 -
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c       |  1 -
 drivers/acpi/apei/erst-dbg.c                    |  1 -
 drivers/auxdisplay/charlcd.c                    |  1 -
 drivers/block/mtip32xx/mtip32xx.c               |  3 ---
 drivers/block/pktcdvd.c                         |  1 -
 drivers/bluetooth/hci_vhci.c                    |  1 -
 drivers/bus/moxtet.c                            |  2 --
 drivers/char/agp/frontend.c                     |  1 -
 drivers/char/applicom.c                         |  1 -
 drivers/char/ds1620.c                           |  1 -
 drivers/char/dtlk.c                             |  1 -
 drivers/char/hpet.c                             |  1 -
 drivers/char/ipmi/ipmi_watchdog.c               |  1 -
 drivers/char/pc8736x_gpio.c                     |  1 -
 drivers/char/pcmcia/cm4000_cs.c                 |  1 -
 drivers/char/pcmcia/cm4040_cs.c                 |  1 -
 drivers/char/pcmcia/scr24x_cs.c                 |  1 -
 drivers/char/ppdev.c                            |  1 -
 drivers/char/scx200_gpio.c                      |  1 -
 drivers/char/sonypi.c                           |  1 -
 drivers/char/tb0219.c                           |  1 -
 drivers/char/tpm/tpm-dev.c                      |  1 -
 drivers/char/tpm/tpm_vtpm_proxy.c               |  1 -
 drivers/char/tpm/tpmrm-dev.c                    |  1 -
 drivers/char/virtio_console.c                   |  1 -
 drivers/counter/counter-chrdev.c                |  1 -
 drivers/firewire/core-cdev.c                    |  1 -
 drivers/firmware/efi/capsule-loader.c           |  1 -
 drivers/firmware/efi/test/efi_test.c            |  1 -
 drivers/firmware/turris-mox-rwtm.c              |  1 -
 drivers/gnss/core.c                             |  1 -
 drivers/gpio/gpio-mockup.c                      |  1 -
 drivers/gpio/gpiolib-cdev.c                     |  1 -
 drivers/gpu/drm/drm_file.c                      |  1 -
 drivers/gpu/drm/i915/i915_perf.c                |  1 -
 drivers/gpu/drm/msm/msm_perf.c                  |  1 -
 drivers/gpu/drm/msm/msm_rd.c                    |  1 -
 drivers/hid/uhid.c                              |  1 -
 drivers/hwmon/asus_atk0110.c                    |  1 -
 drivers/hwmon/fschmd.c                          |  1 -
 drivers/hwmon/w83793.c                          |  1 -
 drivers/hwtracing/coresight/coresight-etb10.c   |  1 -
 .../hwtracing/coresight/coresight-tmc-core.c    |  1 -
 drivers/hwtracing/intel_th/msu.c                |  1 -
 drivers/hwtracing/stm/core.c                    |  1 -
 drivers/i2c/i2c-dev.c                           |  1 -
 drivers/infiniband/core/ucma.c                  |  1 -
 drivers/infiniband/core/user_mad.c              |  2 --
 drivers/infiniband/core/uverbs_main.c           |  4 ----
 drivers/infiniband/hw/hfi1/fault.c              |  1 -
 drivers/infiniband/hw/mlx5/devx.c               |  2 --
 drivers/input/evdev.c                           |  1 -
 drivers/input/joydev.c                          |  1 -
 drivers/input/keyboard/applespi.c               |  1 -
 drivers/input/misc/uinput.c                     |  1 -
 drivers/input/serio/userio.c                    |  1 -
 drivers/isdn/capi/capi.c                        |  1 -
 drivers/isdn/mISDN/timerdev.c                   |  1 -
 drivers/leds/uleds.c                            |  1 -
 drivers/macintosh/adb.c                         |  1 -
 drivers/macintosh/smu.c                         |  1 -
 drivers/media/cec/core/cec-api.c                |  1 -
 drivers/media/mc/mc-devnode.c                   |  1 -
 drivers/media/rc/lirc_dev.c                     |  1 -
 drivers/media/usb/uvc/uvc_debugfs.c             |  1 -
 drivers/media/v4l2-core/v4l2-dev.c              |  1 -
 drivers/message/fusion/mptctl.c                 |  1 -
 drivers/misc/lis3lv02d/lis3lv02d.c              |  1 -
 drivers/misc/mei/main.c                         |  1 -
 drivers/misc/phantom.c                          |  1 -
 drivers/mmc/core/block.c                        |  1 -
 drivers/mtd/ubi/cdev.c                          |  2 --
 drivers/mtd/ubi/debug.c                         |  1 -
 drivers/net/netdevsim/fib.c                     |  1 -
 drivers/net/tap.c                               |  1 -
 drivers/net/tun.c                               |  1 -
 .../wireless/broadcom/brcm80211/brcmfmac/core.c |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c     |  1 -
 drivers/pinctrl/pinmux.c                        |  1 -
 drivers/platform/chrome/cros_ec_debugfs.c       |  1 -
 drivers/platform/chrome/wilco_ec/debugfs.c      |  1 -
 drivers/platform/chrome/wilco_ec/event.c        |  1 -
 drivers/platform/chrome/wilco_ec/telemetry.c    |  1 -
 .../platform/surface/surface_aggregator_cdev.c  |  1 -
 drivers/platform/surface/surface_dtx.c          |  1 -
 drivers/pps/pps.c                               |  1 -
 drivers/rtc/dev.c                               |  1 -
 drivers/rtc/rtc-m41t80.c                        |  1 -
 drivers/s390/char/fs3270.c                      |  1 -
 drivers/s390/char/sclp_ctl.c                    |  1 -
 drivers/s390/char/tape_char.c                   |  1 -
 drivers/s390/char/uvdevice.c                    |  1 -
 drivers/s390/char/vmcp.c                        |  1 -
 drivers/s390/char/vmlogrdr.c                    |  1 -
 drivers/s390/char/zcore.c                       |  2 --
 drivers/s390/cio/chsc_sch.c                     |  1 -
 drivers/s390/cio/css.c                          |  1 -
 drivers/s390/crypto/pkey_api.c                  |  1 -
 drivers/s390/crypto/zcrypt_api.c                |  1 -
 drivers/sbus/char/openprom.c                    |  1 -
 drivers/sbus/char/uctrl.c                       |  1 -
 drivers/scsi/sg.c                               |  1 -
 drivers/spi/spidev.c                            |  1 -
 drivers/staging/pi433/pi433_if.c                |  1 -
 .../intel/int340x_thermal/acpi_thermal_rel.c    |  1 -
 drivers/tty/tty_io.c                            |  3 ---
 drivers/usb/gadget/function/f_fs.c              |  2 --
 drivers/usb/gadget/legacy/inode.c               |  2 --
 drivers/usb/gadget/legacy/raw_gadget.c          |  1 -
 drivers/usb/gadget/udc/atmel_usba_udc.c         |  1 -
 drivers/usb/misc/ftdi-elan.c                    |  1 -
 drivers/usb/misc/ldusb.c                        |  1 -
 drivers/usb/mon/mon_bin.c                       |  1 -
 drivers/usb/mon/mon_stat.c                      |  1 -
 drivers/usb/mon/mon_text.c                      |  2 --
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c  |  2 --
 drivers/vfio/pci/mlx5/main.c                    |  2 --
 drivers/watchdog/acquirewdt.c                   |  1 -
 drivers/watchdog/advantechwdt.c                 |  1 -
 drivers/watchdog/alim1535_wdt.c                 |  1 -
 drivers/watchdog/alim7101_wdt.c                 |  1 -
 drivers/watchdog/ar7_wdt.c                      |  1 -
 drivers/watchdog/at91rm9200_wdt.c               |  1 -
 drivers/watchdog/ath79_wdt.c                    |  1 -
 drivers/watchdog/cpu5wdt.c                      |  1 -
 drivers/watchdog/cpwd.c                         |  1 -
 drivers/watchdog/eurotechwdt.c                  |  1 -
 drivers/watchdog/gef_wdt.c                      |  1 -
 drivers/watchdog/geodewdt.c                     |  1 -
 drivers/watchdog/ib700wdt.c                     |  1 -
 drivers/watchdog/ibmasr.c                       |  1 -
 drivers/watchdog/indydog.c                      |  1 -
 drivers/watchdog/it8712f_wdt.c                  |  1 -
 drivers/watchdog/m54xx_wdt.c                    |  1 -
 drivers/watchdog/machzwd.c                      |  1 -
 drivers/watchdog/mixcomwd.c                     |  1 -
 drivers/watchdog/mtx-1_wdt.c                    |  1 -
 drivers/watchdog/nv_tco.c                       |  1 -
 drivers/watchdog/pc87413_wdt.c                  |  1 -
 drivers/watchdog/pcwd.c                         |  2 --
 drivers/watchdog/pcwd_pci.c                     |  2 --
 drivers/watchdog/pcwd_usb.c                     |  2 --
 drivers/watchdog/pika_wdt.c                     |  1 -
 drivers/watchdog/rc32434_wdt.c                  |  1 -
 drivers/watchdog/rdc321x_wdt.c                  |  1 -
 drivers/watchdog/riowd.c                        |  1 -
 drivers/watchdog/sa1100_wdt.c                   |  1 -
 drivers/watchdog/sb_wdog.c                      |  1 -
 drivers/watchdog/sbc60xxwdt.c                   |  1 -
 drivers/watchdog/sbc7240_wdt.c                  |  1 -
 drivers/watchdog/sbc8360.c                      |  1 -
 drivers/watchdog/sbc_epx_c3.c                   |  1 -
 drivers/watchdog/sbc_fitpc2_wdt.c               |  1 -
 drivers/watchdog/sc1200wdt.c                    |  1 -
 drivers/watchdog/sc520_wdt.c                    |  1 -
 drivers/watchdog/sch311x_wdt.c                  |  1 -
 drivers/watchdog/scx200_wdt.c                   |  1 -
 drivers/watchdog/smsc37b787_wdt.c               |  1 -
 drivers/watchdog/w83877f_wdt.c                  |  1 -
 drivers/watchdog/w83977f_wdt.c                  |  1 -
 drivers/watchdog/wafer5823wdt.c                 |  1 -
 drivers/watchdog/wdrtas.c                       |  2 --
 drivers/watchdog/wdt.c                          |  2 --
 drivers/watchdog/wdt285.c                       |  1 -
 drivers/watchdog/wdt977.c                       |  1 -
 drivers/watchdog/wdt_pci.c                      |  2 --
 drivers/xen/evtchn.c                            |  1 -
 drivers/xen/mcelog.c                            |  1 -
 drivers/xen/xenbus/xenbus_dev_frontend.c        |  1 -
 fs/debugfs/file.c                               |  1 -
 fs/dlm/debug_fs.c                               |  1 -
 fs/efivarfs/file.c                              |  1 -
 fs/fsopen.c                                     |  1 -
 fs/fuse/control.c                               |  4 ----
 fs/fuse/dev.c                                   |  1 -
 fs/nsfs.c                                       |  1 -
 fs/pipe.c                                       |  1 -
 fs/ubifs/debug.c                                |  2 --
 include/linux/debugfs.h                         |  1 -
 kernel/bpf/bpf_iter.c                           |  1 -
 kernel/events/core.c                            |  1 -
 kernel/power/user.c                             |  1 -
 kernel/relay.c                                  |  1 -
 kernel/time/posix-clock.c                       |  1 -
 kernel/trace/trace.c                            |  3 ---
 mm/huge_memory.c                                |  1 -
 net/mac80211/rc80211_minstrel_ht_debugfs.c      |  2 --
 net/rfkill/core.c                               |  1 -
 net/socket.c                                    |  1 -
 net/sunrpc/cache.c                              |  4 ----
 net/sunrpc/rpc_pipe.c                           |  1 -
 scripts/coccinelle/api/stream_open.cocci        |  1 -
 sound/core/control.c                            |  1 -
 sound/core/oss/mixer_oss.c                      |  1 -
 sound/core/oss/pcm_oss.c                        |  1 -
 sound/core/pcm_native.c                         |  2 --
 sound/core/rawmidi.c                            |  1 -
 sound/core/seq/seq_clientmgr.c                  |  1 -
 sound/core/timer.c                              |  1 -
 sound/oss/dmasound/dmasound_core.c              |  3 ---
 virt/kvm/kvm_main.c                             |  1 -
 217 files changed, 273 deletions(-)

diff --git a/Documentation/watchdog/convert_drivers_to_kernel_api.rst b/Documentation/watchdog/convert_drivers_to_kernel_api.rst
index a1c3f038ce0e..e83609a5d007 100644
--- a/Documentation/watchdog/convert_drivers_to_kernel_api.rst
+++ b/Documentation/watchdog/convert_drivers_to_kernel_api.rst
@@ -75,7 +75,6 @@ Example conversion::
 
   -static const struct file_operations s3c2410wdt_fops = {
   -       .owner          = THIS_MODULE,
-  -       .llseek         = no_llseek,
   -       .write          = s3c2410wdt_write,
   -       .unlocked_ioctl = s3c2410wdt_ioctl,
   -       .open           = s3c2410wdt_open,
diff --git a/arch/parisc/kernel/perf.c b/arch/parisc/kernel/perf.c
index d46b6709ec56..eaf8e5f5b346 100644
--- a/arch/parisc/kernel/perf.c
+++ b/arch/parisc/kernel/perf.c
@@ -466,7 +466,6 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 
 static const struct file_operations perf_fops = {
-	.llseek = no_llseek,
 	.read = perf_read,
 	.write = perf_write,
 	.unlocked_ioctl = perf_ioctl,
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index ab316e155ea9..2be57b3968d7 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1689,7 +1689,6 @@ static ssize_t eeh_force_recover_write(struct file *filp,
 
 static const struct file_operations eeh_force_recover_fops = {
 	.open	= simple_open,
-	.llseek	= no_llseek,
 	.write	= eeh_force_recover_write,
 };
 
@@ -1733,7 +1732,6 @@ static ssize_t eeh_dev_check_write(struct file *filp,
 
 static const struct file_operations eeh_dev_check_fops = {
 	.open	= simple_open,
-	.llseek	= no_llseek,
 	.write	= eeh_dev_check_write,
 	.read   = eeh_debugfs_dev_usage,
 };
@@ -1853,7 +1851,6 @@ static ssize_t eeh_dev_break_write(struct file *filp,
 
 static const struct file_operations eeh_dev_break_fops = {
 	.open	= simple_open,
-	.llseek	= no_llseek,
 	.write	= eeh_dev_break_write,
 	.read   = eeh_debugfs_dev_usage,
 };
@@ -1900,7 +1897,6 @@ static ssize_t eeh_dev_can_recover(struct file *filp,
 
 static const struct file_operations eeh_dev_can_recover_fops = {
 	.open	= simple_open,
-	.llseek	= no_llseek,
 	.write	= eeh_dev_can_recover,
 	.read   = eeh_debugfs_dev_usage,
 };
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 968f5b727273..5142cfe8b75a 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -647,7 +647,6 @@ static int mpc52xx_wdt_release(struct inode *inode, struct file *file)
 
 static const struct file_operations mpc52xx_wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= mpc52xx_wdt_write,
 	.unlocked_ioctl = mpc52xx_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 62d90a5e23d1..7f25a4bbeb90 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -453,7 +453,6 @@ static const struct file_operations spufs_cntl_fops = {
 	.release = spufs_cntl_release,
 	.read = simple_attr_read,
 	.write = simple_attr_write,
-	.llseek	= no_llseek,
 	.mmap = spufs_cntl_mmap,
 };
 
@@ -634,7 +633,6 @@ static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_mbox_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_mbox_read,
-	.llseek	= no_llseek,
 };
 
 static ssize_t spufs_mbox_stat_read(struct file *file, char __user *buf,
@@ -664,7 +662,6 @@ static ssize_t spufs_mbox_stat_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_mbox_stat_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_mbox_stat_read,
-	.llseek = no_llseek,
 };
 
 /* low-level ibox access function */
@@ -769,7 +766,6 @@ static const struct file_operations spufs_ibox_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_ibox_read,
 	.poll	= spufs_ibox_poll,
-	.llseek = no_llseek,
 };
 
 static ssize_t spufs_ibox_stat_read(struct file *file, char __user *buf,
@@ -797,7 +793,6 @@ static ssize_t spufs_ibox_stat_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_ibox_stat_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_ibox_stat_read,
-	.llseek = no_llseek,
 };
 
 /* low-level mailbox write */
@@ -901,7 +896,6 @@ static const struct file_operations spufs_wbox_fops = {
 	.open	= spufs_pipe_open,
 	.write	= spufs_wbox_write,
 	.poll	= spufs_wbox_poll,
-	.llseek = no_llseek,
 };
 
 static ssize_t spufs_wbox_stat_read(struct file *file, char __user *buf,
@@ -929,7 +923,6 @@ static ssize_t spufs_wbox_stat_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_wbox_stat_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_wbox_stat_read,
-	.llseek = no_llseek,
 };
 
 static int spufs_signal1_open(struct inode *inode, struct file *file)
@@ -1056,7 +1049,6 @@ static const struct file_operations spufs_signal1_fops = {
 	.read = spufs_signal1_read,
 	.write = spufs_signal1_write,
 	.mmap = spufs_signal1_mmap,
-	.llseek = no_llseek,
 };
 
 static const struct file_operations spufs_signal1_nosched_fops = {
@@ -1064,7 +1056,6 @@ static const struct file_operations spufs_signal1_nosched_fops = {
 	.release = spufs_signal1_release,
 	.write = spufs_signal1_write,
 	.mmap = spufs_signal1_mmap,
-	.llseek = no_llseek,
 };
 
 static int spufs_signal2_open(struct inode *inode, struct file *file)
@@ -1195,7 +1186,6 @@ static const struct file_operations spufs_signal2_fops = {
 	.read = spufs_signal2_read,
 	.write = spufs_signal2_write,
 	.mmap = spufs_signal2_mmap,
-	.llseek = no_llseek,
 };
 
 static const struct file_operations spufs_signal2_nosched_fops = {
@@ -1203,7 +1193,6 @@ static const struct file_operations spufs_signal2_nosched_fops = {
 	.release = spufs_signal2_release,
 	.write = spufs_signal2_write,
 	.mmap = spufs_signal2_mmap,
-	.llseek = no_llseek,
 };
 
 /*
@@ -1343,7 +1332,6 @@ static const struct file_operations spufs_mss_fops = {
 	.open	 = spufs_mss_open,
 	.release = spufs_mss_release,
 	.mmap	 = spufs_mss_mmap,
-	.llseek  = no_llseek,
 };
 
 static vm_fault_t
@@ -1401,7 +1389,6 @@ static const struct file_operations spufs_psmap_fops = {
 	.open	 = spufs_psmap_open,
 	.release = spufs_psmap_release,
 	.mmap	 = spufs_psmap_mmap,
-	.llseek  = no_llseek,
 };
 
 
@@ -1744,7 +1731,6 @@ static const struct file_operations spufs_mfc_fops = {
 	.flush	 = spufs_mfc_flush,
 	.fsync	 = spufs_mfc_fsync,
 	.mmap	 = spufs_mfc_mmap,
-	.llseek  = no_llseek,
 };
 
 static int spufs_npc_set(void *data, u64 val)
@@ -2114,7 +2100,6 @@ static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_dma_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_dma_info_read,
-	.llseek = no_llseek,
 };
 
 static void spufs_get_proxydma_info(struct spu_context *ctx,
@@ -2171,7 +2156,6 @@ static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_proxydma_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_proxydma_info_read,
-	.llseek = no_llseek,
 };
 
 static int spufs_show_tid(struct seq_file *s, void *private)
@@ -2454,7 +2438,6 @@ static const struct file_operations spufs_switch_log_fops = {
 	.read		= spufs_switch_log_read,
 	.poll		= spufs_switch_log_poll,
 	.release	= spufs_switch_log_release,
-	.llseek		= no_llseek,
 };
 
 /**
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index a83cb679dd59..2b8807aed774 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -99,7 +99,6 @@ static ssize_t pnv_eeh_ei_write(struct file *filp,
 
 static const struct file_operations pnv_eeh_ei_fops = {
 	.open	= simple_open,
-	.llseek	= no_llseek,
 	.write	= pnv_eeh_ei_write,
 };
 
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 352af5b14a0f..28ff6eac0fe8 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -315,7 +315,6 @@ static const struct file_operations dtl_fops = {
 	.open		= dtl_file_open,
 	.release	= dtl_file_release,
 	.read		= dtl_file_read,
-	.llseek		= no_llseek,
 };
 
 static struct dentry *dtl_dir;
diff --git a/arch/s390/hypfs/hypfs_dbfs.c b/arch/s390/hypfs/hypfs_dbfs.c
index f4c7dbfaf8ee..82129cd9e456 100644
--- a/arch/s390/hypfs/hypfs_dbfs.c
+++ b/arch/s390/hypfs/hypfs_dbfs.c
@@ -74,7 +74,6 @@ static long dbfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations dbfs_ops = {
 	.read		= dbfs_read,
-	.llseek		= no_llseek,
 	.unlocked_ioctl = dbfs_ioctl,
 };
 
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 5c97f48cea91..779faac7e693 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -443,7 +443,6 @@ static const struct file_operations hypfs_file_ops = {
 	.release	= hypfs_release,
 	.read_iter	= hypfs_read_iter,
 	.write_iter	= hypfs_write_iter,
-	.llseek		= no_llseek,
 };
 
 static struct file_system_type hypfs_type = {
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 4331c7e6e1c0..9b7e351c99c7 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -163,7 +163,6 @@ static const struct file_operations debug_file_ops = {
 	.write	 = debug_input,
 	.open	 = debug_open,
 	.release = debug_close,
-	.llseek  = no_llseek,
 };
 
 static struct dentry *debug_debugfs_root_entry;
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 483ab5e10164..1bdae1416648 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -1235,7 +1235,6 @@ static const struct file_operations cfset_fops = {
 	.release = cfset_release,
 	.unlocked_ioctl	= cfset_ioctl,
 	.compat_ioctl = cfset_ioctl,
-	.llseek = no_llseek
 };
 
 static struct miscdevice cfset_dev = {
diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index b5e364358ce4..b4ce167a5ff5 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -495,7 +495,6 @@ static const struct file_operations stsi_##fc##_##s1##_##s2##_fs_ops = {       \
 	.open		= stsi_open_##fc##_##s1##_##s2,			       \
 	.release	= stsi_release,					       \
 	.read		= stsi_read,					       \
-	.llseek		= no_llseek,					       \
 };
 
 static int stsi_release(struct inode *inode, struct file *file)
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 375e0a5120bc..1afaeefcb563 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -650,7 +650,6 @@ static const struct file_operations clp_misc_fops = {
 	.release = clp_misc_release,
 	.unlocked_ioctl = clp_misc_ioctl,
 	.compat_ioctl = clp_misc_ioctl,
-	.llseek = no_llseek,
 };
 
 static struct miscdevice clp_misc_device = {
diff --git a/arch/um/drivers/harddog_kern.c b/arch/um/drivers/harddog_kern.c
index e6d4f43deba8..1534d01a4cbb 100644
--- a/arch/um/drivers/harddog_kern.c
+++ b/arch/um/drivers/harddog_kern.c
@@ -168,7 +168,6 @@ static const struct file_operations harddog_fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= harddog_open,
 	.release	= harddog_release,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice harddog_miscdev = {
diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index 5b064d360cb7..42f3dc46f454 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -291,7 +291,6 @@ static int hostmixer_release(struct inode *inode, struct file *file)
 
 static const struct file_operations hostaudio_fops = {
 	.owner          = THIS_MODULE,
-	.llseek         = no_llseek,
 	.read           = hostaudio_read,
 	.write          = hostaudio_write,
 	.poll           = hostaudio_poll,
@@ -304,7 +303,6 @@ static const struct file_operations hostaudio_fops = {
 
 static const struct file_operations hostmixer_fops = {
 	.owner          = THIS_MODULE,
-	.llseek         = no_llseek,
 	.unlocked_ioctl	= hostmixer_ioctl_mixdev,
 	.open           = hostmixer_open_mixdev,
 	.release        = hostmixer_release,
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 100fbeebdc72..44e9f22c7e87 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -332,7 +332,6 @@ static const struct file_operations mce_chrdev_ops = {
 	.poll			= mce_chrdev_poll,
 	.unlocked_ioctl		= mce_chrdev_ioctl,
 	.compat_ioctl		= compat_ptr_ioctl,
-	.llseek			= no_llseek,
 };
 
 static struct miscdevice mce_chrdev_device = {
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index db813f819ad6..c4ae66b46d59 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1546,7 +1546,6 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
 
 static const struct file_operations pseudo_lock_dev_fops = {
 	.owner =	THIS_MODULE,
-	.llseek =	no_llseek,
 	.read =		NULL,
 	.write =	NULL,
 	.open =		pseudo_lock_dev_open,
diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index 8bc71cdc2270..246076341e8c 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -199,7 +199,6 @@ static const struct file_operations erst_dbg_ops = {
 	.read		= erst_dbg_read,
 	.write		= erst_dbg_write,
 	.unlocked_ioctl	= erst_dbg_ioctl,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice erst_dbg_dev = {
diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 6d309e4971b6..3bb6411fd4c6 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -524,7 +524,6 @@ static const struct file_operations charlcd_fops = {
 	.write   = charlcd_write,
 	.open    = charlcd_open,
 	.release = charlcd_release,
-	.llseek  = no_llseek,
 };
 
 static struct miscdevice charlcd_dev = {
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 27386a572ba4..735b75f10664 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2367,21 +2367,18 @@ static const struct file_operations mtip_device_status_fops = {
 	.owner  = THIS_MODULE,
 	.open   = simple_open,
 	.read   = mtip_hw_read_device_status,
-	.llseek = no_llseek,
 };
 
 static const struct file_operations mtip_regs_fops = {
 	.owner  = THIS_MODULE,
 	.open   = simple_open,
 	.read   = mtip_hw_read_registers,
-	.llseek = no_llseek,
 };
 
 static const struct file_operations mtip_flags_fops = {
 	.owner  = THIS_MODULE,
 	.open   = simple_open,
 	.read   = mtip_hw_read_flags,
-	.llseek = no_llseek,
 };
 
 static int mtip_hw_debugfs_init(struct driver_data *dd)
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 789093375344..a2d9d698a1df 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2866,7 +2866,6 @@ static const struct file_operations pkt_ctl_fops = {
 	.compat_ioctl	= pkt_ctl_compat_ioctl,
 #endif
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice pkt_misc = {
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index c443c3b0a4da..0d34ce0559d3 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -583,7 +583,6 @@ static const struct file_operations vhci_fops = {
 	.poll		= vhci_poll,
 	.open		= vhci_open,
 	.release	= vhci_release,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice vhci_miscdev = {
diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 5eb0fe73ddc4..2381ea90a687 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -484,7 +484,6 @@ static const struct file_operations input_fops = {
 	.owner	= THIS_MODULE,
 	.open	= moxtet_debug_open,
 	.read	= input_read,
-	.llseek	= no_llseek,
 };
 
 static ssize_t output_read(struct file *file, char __user *buf, size_t len,
@@ -549,7 +548,6 @@ static const struct file_operations output_fops = {
 	.open	= moxtet_debug_open,
 	.read	= output_read,
 	.write	= output_write,
-	.llseek	= no_llseek,
 };
 
 static int moxtet_register_debugfs(struct moxtet *moxtet)
diff --git a/drivers/char/agp/frontend.c b/drivers/char/agp/frontend.c
index 321118a9cfa5..06871c71ceb8 100644
--- a/drivers/char/agp/frontend.c
+++ b/drivers/char/agp/frontend.c
@@ -1033,7 +1033,6 @@ static long agp_ioctl(struct file *file,
 static const struct file_operations agp_fops =
 {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.unlocked_ioctl	= agp_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= compat_agp_ioctl,
diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index 36203d3fa6ea..6873aec24031 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -111,7 +111,6 @@ static irqreturn_t ac_interrupt(int, void *);
 
 static const struct file_operations ac_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.read = ac_read,
 	.write = ac_write,
 	.unlocked_ioctl = ac_ioctl,
diff --git a/drivers/char/ds1620.c b/drivers/char/ds1620.c
index cf89a9631107..b2147958a1a4 100644
--- a/drivers/char/ds1620.c
+++ b/drivers/char/ds1620.c
@@ -353,7 +353,6 @@ static const struct file_operations ds1620_fops = {
 	.open		= ds1620_open,
 	.read		= ds1620_read,
 	.unlocked_ioctl	= ds1620_unlocked_ioctl,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice ds1620_miscdev = {
diff --git a/drivers/char/dtlk.c b/drivers/char/dtlk.c
index 6946c1cad9f6..06071538c74f 100644
--- a/drivers/char/dtlk.c
+++ b/drivers/char/dtlk.c
@@ -107,7 +107,6 @@ static const struct file_operations dtlk_fops =
 	.unlocked_ioctl	= dtlk_ioctl,
 	.open		= dtlk_open,
 	.release	= dtlk_release,
-	.llseek		= no_llseek,
 };
 
 /* local prototypes */
diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index ee71376f174b..4b950f1d8537 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -696,7 +696,6 @@ hpet_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations hpet_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.read = hpet_read,
 	.poll = hpet_poll,
 	.unlocked_ioctl = hpet_ioctl,
diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 5b4e677929ca..7765c35c50ed 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -903,7 +903,6 @@ static const struct file_operations ipmi_wdog_fops = {
 	.open    = ipmi_open,
 	.release = ipmi_close,
 	.fasync  = ipmi_fasync,
-	.llseek  = no_llseek,
 };
 
 static struct miscdevice ipmi_wdog_miscdev = {
diff --git a/drivers/char/pc8736x_gpio.c b/drivers/char/pc8736x_gpio.c
index c39a836ebd15..5f4696813cea 100644
--- a/drivers/char/pc8736x_gpio.c
+++ b/drivers/char/pc8736x_gpio.c
@@ -235,7 +235,6 @@ static const struct file_operations pc8736x_gpio_fileops = {
 	.open	= pc8736x_gpio_open,
 	.write	= nsc_gpio_write,
 	.read	= nsc_gpio_read,
-	.llseek = no_llseek,
 };
 
 static void __init pc8736x_init_shadow(void)
diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index adaec8fd4b16..78578d701ea4 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1852,7 +1852,6 @@ static const struct file_operations cm4000_fops = {
 	.unlocked_ioctl	= cmm_ioctl,
 	.open	= cmm_open,
 	.release= cmm_close,
-	.llseek = no_llseek,
 };
 
 static const struct pcmcia_device_id cm4000_ids[] = {
diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index 827711911da4..19a138d6f304 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -627,7 +627,6 @@ static const struct file_operations reader_fops = {
 	.open		= cm4040_open,
 	.release	= cm4040_close,
 	.poll		= cm4040_poll,
-	.llseek		= no_llseek,
 };
 
 static const struct pcmcia_device_id cm4040_ids[] = {
diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
index 1bdce08fae3d..eb4eec542775 100644
--- a/drivers/char/pcmcia/scr24x_cs.c
+++ b/drivers/char/pcmcia/scr24x_cs.c
@@ -219,7 +219,6 @@ static const struct file_operations scr24x_fops = {
 	.write		= scr24x_write,
 	.open		= scr24x_open,
 	.release	= scr24x_release,
-	.llseek		= no_llseek,
 };
 
 static int scr24x_config_check(struct pcmcia_device *link, void *priv_data)
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 38b46c7d1737..1ac66ef87d8b 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -777,7 +777,6 @@ static struct class *ppdev_class;
 
 static const struct file_operations pp_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= pp_read,
 	.write		= pp_write,
 	.poll		= pp_poll,
diff --git a/drivers/char/scx200_gpio.c b/drivers/char/scx200_gpio.c
index 9f701dcba95c..700e6affea6f 100644
--- a/drivers/char/scx200_gpio.c
+++ b/drivers/char/scx200_gpio.c
@@ -68,7 +68,6 @@ static const struct file_operations scx200_gpio_fileops = {
 	.read    = nsc_gpio_read,
 	.open    = scx200_gpio_open,
 	.release = scx200_gpio_release,
-	.llseek  = no_llseek,
 };
 
 static struct cdev scx200_gpio_cdev;  /* use 1 cdev for all pins */
diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 27e301a6bb7a..c6cce2b1d4e0 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1054,7 +1054,6 @@ static const struct file_operations sonypi_misc_fops = {
 	.release	= sonypi_misc_release,
 	.fasync		= sonypi_misc_fasync,
 	.unlocked_ioctl	= sonypi_misc_ioctl,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice sonypi_misc_device = {
diff --git a/drivers/char/tb0219.c b/drivers/char/tb0219.c
index 1f36be14978f..13c20b6594c3 100644
--- a/drivers/char/tb0219.c
+++ b/drivers/char/tb0219.c
@@ -249,7 +249,6 @@ static const struct file_operations tb0219_fops = {
 	.write		= tanbac_tb0219_write,
 	.open		= tanbac_tb0219_open,
 	.release	= tanbac_tb0219_release,
-	.llseek		= no_llseek,
 };
 
 static void tb0219_restart(char *command)
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index e2c0baa69fef..97c94b5e9340 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -59,7 +59,6 @@ static int tpm_release(struct inode *inode, struct file *file)
 
 const struct file_operations tpm_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.open = tpm_open,
 	.read = tpm_common_read,
 	.write = tpm_common_write,
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 5c865987ba5c..dc68210125d3 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -243,7 +243,6 @@ static int vtpm_proxy_fops_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations vtpm_proxy_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.read = vtpm_proxy_fops_read,
 	.write = vtpm_proxy_fops_write,
 	.poll = vtpm_proxy_fops_poll,
diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
index eef0fb06ea83..c25df7ea064e 100644
--- a/drivers/char/tpm/tpmrm-dev.c
+++ b/drivers/char/tpm/tpmrm-dev.c
@@ -46,7 +46,6 @@ static int tpmrm_release(struct inode *inode, struct file *file)
 
 const struct file_operations tpmrm_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.open = tpmrm_open,
 	.read = tpm_common_read,
 	.write = tpm_common_write,
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9fa3c76a267f..9af5cc188a4a 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1103,7 +1103,6 @@ static const struct file_operations port_fops = {
 	.poll  = port_fops_poll,
 	.release = port_fops_release,
 	.fasync = port_fops_fasync,
-	.llseek = no_llseek,
 };
 
 /*
diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index 69d340be9c93..ec87583efd80 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -420,7 +420,6 @@ static int counter_chrdev_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations counter_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.read = counter_chrdev_read,
 	.poll = counter_chrdev_poll,
 	.unlocked_ioctl = counter_chrdev_ioctl,
diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 9c89f7d53e99..6f1517dd6c89 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1803,7 +1803,6 @@ static __poll_t fw_device_op_poll(struct file *file, poll_table * pt)
 
 const struct file_operations fw_device_ops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.open		= fw_device_op_open,
 	.read		= fw_device_op_read,
 	.unlocked_ioctl	= fw_device_op_ioctl,
diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 4dde8edd53b6..704640200435 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -326,7 +326,6 @@ static const struct file_operations efi_capsule_fops = {
 	.write = efi_capsule_write,
 	.flush = efi_capsule_flush,
 	.release = efi_capsule_release,
-	.llseek = no_llseek,
 };
 
 static struct miscdevice efi_capsule_misc = {
diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index 47d67bb0a516..9e2628728aad 100644
--- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -750,7 +750,6 @@ static const struct file_operations efi_test_fops = {
 	.unlocked_ioctl	= efi_test_ioctl,
 	.open		= efi_test_open,
 	.release	= efi_test_close,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice efi_test_dev = {
diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index c2d34dc8ba46..dbb12e90ea0a 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -428,7 +428,6 @@ static const struct file_operations do_sign_fops = {
 	.open	= rwtm_debug_open,
 	.read	= do_sign_read,
 	.write	= do_sign_write,
-	.llseek	= no_llseek,
 };
 
 static int rwtm_register_debugfs(struct mox_rwtm *rwtm)
diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index e6f94501cb28..547935b7d326 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -206,7 +206,6 @@ static const struct file_operations gnss_fops = {
 	.read		= gnss_read,
 	.write		= gnss_write,
 	.poll		= gnss_poll,
-	.llseek		= no_llseek,
 };
 
 static struct class *gnss_class;
diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 8943cea92764..fce11aa57e91 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -337,7 +337,6 @@ static const struct file_operations gpio_mockup_debugfs_ops = {
 	.open = gpio_mockup_debugfs_open,
 	.read = gpio_mockup_debugfs_read,
 	.write = gpio_mockup_debugfs_write,
-	.llseek = no_llseek,
 	.release = single_release,
 };
 
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f5aa5f93342a..c8622265a824 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2537,7 +2537,6 @@ static const struct file_operations gpio_fileops = {
 	.poll = lineinfo_watch_poll,
 	.read = lineinfo_watch_read,
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.unlocked_ioctl = gpio_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = gpio_ioctl_compat,
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index ed25168619fc..59f1871a00c5 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -126,7 +126,6 @@ bool drm_dev_needs_global_mutex(struct drm_device *dev)
  *             .compat_ioctl = drm_compat_ioctl, // NULL if CONFIG_COMPAT=n
  *             .poll = drm_poll,
  *             .read = drm_read,
- *             .llseek = no_llseek,
  *             .mmap = drm_gem_mmap,
  *     };
  *
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 1577ab6754db..2cc0673c90bc 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -3374,7 +3374,6 @@ static int i915_perf_release(struct inode *inode, struct file *file)
 
 static const struct file_operations fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.release	= i915_perf_release,
 	.poll		= i915_perf_poll,
 	.read		= i915_perf_read,
diff --git a/drivers/gpu/drm/msm/msm_perf.c b/drivers/gpu/drm/msm/msm_perf.c
index 3d3da79fec2a..d3c7889aaf26 100644
--- a/drivers/gpu/drm/msm/msm_perf.c
+++ b/drivers/gpu/drm/msm/msm_perf.c
@@ -192,7 +192,6 @@ static const struct file_operations perf_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = perf_open,
 	.read = perf_read,
-	.llseek = no_llseek,
 	.release = perf_release,
 };
 
diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index a92ffde53f0b..acf3a82dd7d2 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -229,7 +229,6 @@ static const struct file_operations rd_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = rd_open,
 	.read = rd_read,
-	.llseek = no_llseek,
 	.release = rd_release,
 };
 
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 2a918aeb0af1..946591af8564 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -804,7 +804,6 @@ static const struct file_operations uhid_fops = {
 	.read		= uhid_char_read,
 	.write		= uhid_char_write,
 	.poll		= uhid_char_poll,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice uhid_misc = {
diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index ff64a39d56de..565e716fc210 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -783,7 +783,6 @@ static const struct file_operations atk_debugfs_ggrp_fops = {
 	.read		= atk_debugfs_ggrp_read,
 	.open		= atk_debugfs_ggrp_open,
 	.release	= atk_debugfs_ggrp_release,
-	.llseek		= no_llseek,
 };
 
 static void atk_debugfs_init(struct atk_data *data)
diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index c26195e3aad7..88933890057b 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -948,7 +948,6 @@ static long watchdog_ioctl(struct file *filp, unsigned int cmd,
 
 static const struct file_operations watchdog_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.open = watchdog_open,
 	.release = watchdog_release,
 	.write = watchdog_write,
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 0a65d164c8f0..54af37cae1da 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1451,7 +1451,6 @@ static long watchdog_ioctl(struct file *filp, unsigned int cmd,
 
 static const struct file_operations watchdog_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.open = watchdog_open,
 	.release = watchdog_close,
 	.write = watchdog_write,
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index efa39820acec..e83430e794ec 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -652,7 +652,6 @@ static const struct file_operations etb_fops = {
 	.open		= etb_open,
 	.read		= etb_read,
 	.release	= etb_release,
-	.llseek		= no_llseek,
 };
 
 #define coresight_etb10_reg(name, offset)		\
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index d0276af82494..a315bb2a76e0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -215,7 +215,6 @@ static const struct file_operations tmc_fops = {
 	.open		= tmc_open,
 	.read		= tmc_read,
 	.release	= tmc_release,
-	.llseek		= no_llseek,
 };
 
 static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 70a07b4e9967..562f694c63f9 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1659,7 +1659,6 @@ static const struct file_operations intel_th_msc_fops = {
 	.release	= intel_th_msc_release,
 	.read		= intel_th_msc_read,
 	.mmap		= intel_th_msc_mmap,
-	.llseek		= no_llseek,
 	.owner		= THIS_MODULE,
 };
 
diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 2712e699ba08..69413a33c125 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -839,7 +839,6 @@ static const struct file_operations stm_fops = {
 	.mmap		= stm_char_mmap,
 	.unlocked_ioctl	= stm_char_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
-	.llseek		= no_llseek,
 };
 
 static void stm_device_release(struct device *dev)
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index ab0adaa130da..37a9d3954fc0 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -625,7 +625,6 @@ static int i2cdev_release(struct inode *inode, struct file *file)
 
 static const struct file_operations i2cdev_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= i2cdev_read,
 	.write		= i2cdev_write,
 	.unlocked_ioctl	= i2cdev_ioctl,
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 9d6ac9dff39a..e7b4fdc41924 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1818,7 +1818,6 @@ static const struct file_operations ucma_fops = {
 	.release = ucma_close,
 	.write	 = ucma_write,
 	.poll    = ucma_poll,
-	.llseek	 = no_llseek,
 };
 
 static struct miscdevice ucma_misc = {
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 98cb594cd9a6..e521c25723ba 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -1068,7 +1068,6 @@ static const struct file_operations umad_fops = {
 #endif
 	.open		= ib_umad_open,
 	.release	= ib_umad_close,
-	.llseek		= no_llseek,
 };
 
 static int ib_umad_sm_open(struct inode *inode, struct file *filp)
@@ -1136,7 +1135,6 @@ static const struct file_operations umad_sm_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = ib_umad_sm_open,
 	.release = ib_umad_sm_close,
-	.llseek	 = no_llseek,
 };
 
 static struct ib_umad_port *get_port(struct ib_device *ibdev,
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index d54434088727..a79e458aeaff 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -344,7 +344,6 @@ const struct file_operations uverbs_event_fops = {
 	.poll    = ib_uverbs_comp_event_poll,
 	.release = uverbs_uobject_fd_release,
 	.fasync  = ib_uverbs_comp_event_fasync,
-	.llseek	 = no_llseek,
 };
 
 const struct file_operations uverbs_async_event_fops = {
@@ -353,7 +352,6 @@ const struct file_operations uverbs_async_event_fops = {
 	.poll    = ib_uverbs_async_event_poll,
 	.release = uverbs_async_event_release,
 	.fasync  = ib_uverbs_async_event_fasync,
-	.llseek	 = no_llseek,
 };
 
 void ib_uverbs_comp_handler(struct ib_cq *cq, void *cq_context)
@@ -982,7 +980,6 @@ static const struct file_operations uverbs_fops = {
 	.write	 = ib_uverbs_write,
 	.open	 = ib_uverbs_open,
 	.release = ib_uverbs_close,
-	.llseek	 = no_llseek,
 	.unlocked_ioctl = ib_uverbs_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 };
@@ -993,7 +990,6 @@ static const struct file_operations uverbs_mmap_fops = {
 	.mmap    = ib_uverbs_mmap,
 	.open	 = ib_uverbs_open,
 	.release = ib_uverbs_close,
-	.llseek	 = no_llseek,
 	.unlocked_ioctl = ib_uverbs_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 };
diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index 3af77a0840ab..a6f41f806d8e 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -203,7 +203,6 @@ static const struct file_operations __fault_opcodes_fops = {
 	.open = fault_opcodes_open,
 	.read = fault_opcodes_read,
 	.write = fault_opcodes_write,
-	.llseek = no_llseek
 };
 
 void hfi1_fault_exit_debugfs(struct hfi1_ibdev *ibd)
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 2a2a9e9afc9d..6ccf268aedd8 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2631,7 +2631,6 @@ static const struct file_operations devx_async_cmd_event_fops = {
 	.read	 = devx_async_cmd_event_read,
 	.poll    = devx_async_cmd_event_poll,
 	.release = uverbs_uobject_fd_release,
-	.llseek	 = no_llseek,
 };
 
 static ssize_t devx_async_event_read(struct file *filp, char __user *buf,
@@ -2746,7 +2745,6 @@ static const struct file_operations devx_async_event_fops = {
 	.read	 = devx_async_event_read,
 	.poll    = devx_async_event_poll,
 	.release = uverbs_uobject_fd_release,
-	.llseek	 = no_llseek,
 };
 
 static void devx_async_cmd_event_destroy_uobj(struct ib_uobject *uobj,
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 95f90699d2b1..53af04107aa3 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -1301,7 +1301,6 @@ static const struct file_operations evdev_fops = {
 	.compat_ioctl	= evdev_ioctl_compat,
 #endif
 	.fasync		= evdev_fasync,
-	.llseek		= no_llseek,
 };
 
 /*
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index b45ddb457002..67c499cb8131 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -718,7 +718,6 @@ static const struct file_operations joydev_fops = {
 	.compat_ioctl	= joydev_compat_ioctl,
 #endif
 	.fasync		= joydev_fasync,
-	.llseek		= no_llseek,
 };
 
 /*
diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index d1f5354d5ea2..72b4745ae39b 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1007,7 +1007,6 @@ static const struct file_operations applespi_tp_dim_fops = {
 	.owner = THIS_MODULE,
 	.open = applespi_tp_dim_open,
 	.read = applespi_tp_dim_read,
-	.llseek = no_llseek,
 };
 
 static void report_finger_data(struct input_dev *input, int slot,
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index f2593133e524..a67e88eff5ee 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -1084,7 +1084,6 @@ static const struct file_operations uinput_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= uinput_compat_ioctl,
 #endif
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice uinput_misc = {
diff --git a/drivers/input/serio/userio.c b/drivers/input/serio/userio.c
index 9ab5c45c3a9f..d4890d984a59 100644
--- a/drivers/input/serio/userio.c
+++ b/drivers/input/serio/userio.c
@@ -267,7 +267,6 @@ static const struct file_operations userio_fops = {
 	.read		= userio_char_read,
 	.write		= userio_char_write,
 	.poll		= userio_char_poll,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice userio_misc = {
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 0f00be62438d..7b16171653c0 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1022,7 +1022,6 @@ static int capi_release(struct inode *inode, struct file *file)
 static const struct file_operations capi_fops =
 {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= capi_read,
 	.write		= capi_write,
 	.poll		= capi_poll,
diff --git a/drivers/isdn/mISDN/timerdev.c b/drivers/isdn/mISDN/timerdev.c
index abdf36ac3bee..9d40b888b5e2 100644
--- a/drivers/isdn/mISDN/timerdev.c
+++ b/drivers/isdn/mISDN/timerdev.c
@@ -266,7 +266,6 @@ static const struct file_operations mISDN_fops = {
 	.unlocked_ioctl	= mISDN_ioctl,
 	.open		= mISDN_open,
 	.release	= mISDN_close,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice mISDNtimer = {
diff --git a/drivers/leds/uleds.c b/drivers/leds/uleds.c
index 7320337b22d2..e078d60dee89 100644
--- a/drivers/leds/uleds.c
+++ b/drivers/leds/uleds.c
@@ -200,7 +200,6 @@ static const struct file_operations uleds_fops = {
 	.read		= uleds_read,
 	.write		= uleds_write,
 	.poll		= uleds_poll,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice uleds_misc = {
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 439fab4eaa85..d783244290cf 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -840,7 +840,6 @@ static ssize_t adb_write(struct file *file, const char __user *buf,
 
 static const struct file_operations adb_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= adb_read,
 	.write		= adb_write,
 	.open		= adb_open,
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index b495bfa77896..537aacf6a8d4 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -1314,7 +1314,6 @@ static int smu_release(struct inode *inode, struct file *file)
 
 
 static const struct file_operations smu_device_fops = {
-	.llseek		= no_llseek,
 	.read		= smu_read,
 	.write		= smu_write,
 	.poll		= smu_fpoll,
diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
index 67dc79ef1705..8bf2b0a31c60 100644
--- a/drivers/media/cec/core/cec-api.c
+++ b/drivers/media/cec/core/cec-api.c
@@ -695,5 +695,4 @@ const struct file_operations cec_devnode_fops = {
 	.compat_ioctl = cec_ioctl,
 	.release = cec_release,
 	.poll = cec_poll,
-	.llseek = no_llseek,
 };
diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index 680fbb3a9340..6a2726d391e0 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -205,7 +205,6 @@ static const struct file_operations media_devnode_fops = {
 #endif /* CONFIG_COMPAT */
 	.release = media_release,
 	.poll = media_poll,
-	.llseek = no_llseek,
 };
 
 int __must_check media_devnode_register(struct media_device *mdev,
diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index 765375bda0c6..5fdc2fc2081b 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -700,7 +700,6 @@ static const struct file_operations lirc_fops = {
 	.poll		= lirc_poll,
 	.open		= lirc_open,
 	.release	= lirc_close,
-	.llseek		= no_llseek,
 };
 
 static void lirc_release_device(struct device *ld)
diff --git a/drivers/media/usb/uvc/uvc_debugfs.c b/drivers/media/usb/uvc/uvc_debugfs.c
index 1a1258d4ffca..14fa41cb8148 100644
--- a/drivers/media/usb/uvc/uvc_debugfs.c
+++ b/drivers/media/usb/uvc/uvc_debugfs.c
@@ -59,7 +59,6 @@ static int uvc_debugfs_stats_release(struct inode *inode, struct file *file)
 static const struct file_operations uvc_debugfs_stats_fops = {
 	.owner = THIS_MODULE,
 	.open = uvc_debugfs_stats_open,
-	.llseek = no_llseek,
 	.read = uvc_debugfs_stats_read,
 	.release = uvc_debugfs_stats_release,
 };
diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index d00237ee4cae..9b2e652d7524 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -483,7 +483,6 @@ static const struct file_operations v4l2_fops = {
 #endif
 	.release = v4l2_release,
 	.poll = v4l2_poll,
-	.llseek = no_llseek,
 };
 
 /**
diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index f9ee957072c3..294b63849955 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -2694,7 +2694,6 @@ mptctl_hp_targetinfo(MPT_ADAPTER *ioc, unsigned long arg)
 
 static const struct file_operations mptctl_fops = {
 	.owner =	THIS_MODULE,
-	.llseek =	no_llseek,
 	.fasync = 	mptctl_fasync,
 	.unlocked_ioctl = mptctl_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 3a7808b796b1..54343aab994b 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -669,7 +669,6 @@ static int lis3lv02d_misc_fasync(int fd, struct file *file, int on)
 
 static const struct file_operations lis3lv02d_misc_fops = {
 	.owner   = THIS_MODULE,
-	.llseek  = no_llseek,
 	.read    = lis3lv02d_misc_read,
 	.open    = lis3lv02d_misc_open,
 	.release = lis3lv02d_misc_release,
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 786f7c8f7f61..386e3bf7194b 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1174,7 +1174,6 @@ static const struct file_operations mei_fops = {
 	.poll = mei_poll,
 	.fsync = mei_fsync,
 	.fasync = mei_fasync,
-	.llseek = no_llseek
 };
 
 /**
diff --git a/drivers/misc/phantom.c b/drivers/misc/phantom.c
index ce72e46a2e73..88b697434534 100644
--- a/drivers/misc/phantom.c
+++ b/drivers/misc/phantom.c
@@ -276,7 +276,6 @@ static const struct file_operations phantom_file_ops = {
 	.unlocked_ioctl = phantom_ioctl,
 	.compat_ioctl = phantom_compat_ioctl,
 	.poll = phantom_poll,
-	.llseek = no_llseek,
 };
 
 static irqreturn_t phantom_isr(int irq, void *data)
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f4a1281658db..64e5457256bd 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2629,7 +2629,6 @@ static const struct file_operations mmc_rpmb_fileops = {
 	.release = mmc_rpmb_chrdev_release,
 	.open = mmc_rpmb_chrdev_open,
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.unlocked_ioctl = mmc_rpmb_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = mmc_rpmb_ioctl_compat,
diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
index cc9a28cf9d82..53add6fabc96 100644
--- a/drivers/mtd/ubi/cdev.c
+++ b/drivers/mtd/ubi/cdev.c
@@ -1094,7 +1094,6 @@ const struct file_operations ubi_vol_cdev_operations = {
 /* UBI character device operations */
 const struct file_operations ubi_cdev_operations = {
 	.owner          = THIS_MODULE,
-	.llseek         = no_llseek,
 	.unlocked_ioctl = ubi_cdev_ioctl,
 	.compat_ioctl   = compat_ptr_ioctl,
 };
@@ -1104,5 +1103,4 @@ const struct file_operations ubi_ctrl_cdev_operations = {
 	.owner          = THIS_MODULE,
 	.unlocked_ioctl = ctrl_cdev_ioctl,
 	.compat_ioctl   = compat_ptr_ioctl,
-	.llseek		= no_llseek,
 };
diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 31d427ee191a..e0e40d704f81 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -382,7 +382,6 @@ static const struct file_operations dfs_fops = {
 	.read   = dfs_file_read,
 	.write  = dfs_file_write,
 	.open	= simple_open,
-	.llseek = no_llseek,
 	.owner  = THIS_MODULE,
 };
 
diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index c8f398f5bc5b..ef4ff4c28673 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -1400,7 +1400,6 @@ static ssize_t nsim_nexthop_bucket_activity_write(struct file *file,
 static const struct file_operations nsim_nexthop_bucket_activity_fops = {
 	.open = simple_open,
 	.write = nsim_nexthop_bucket_activity_write,
-	.llseek = no_llseek,
 	.owner = THIS_MODULE,
 };
 
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index c3d42062559d..325f16855eeb 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1139,7 +1139,6 @@ static const struct file_operations tap_fops = {
 	.read_iter	= tap_read_iter,
 	.write_iter	= tap_write_iter,
 	.poll		= tap_poll,
-	.llseek		= no_llseek,
 	.unlocked_ioctl	= tap_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 };
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 87a635aac008..ba4d7f6a7d3c 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3470,7 +3470,6 @@ static void tun_chr_show_fdinfo(struct seq_file *m, struct file *file)
 
 static const struct file_operations tun_fops = {
 	.owner	= THIS_MODULE,
-	.llseek = no_llseek,
 	.read_iter  = tun_chr_read_iter,
 	.write_iter = tun_chr_write_iter,
 	.poll	= tun_chr_poll,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 87aef211b35f..9f2a1a558a3b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1184,7 +1184,6 @@ static ssize_t bus_reset_write(struct file *file, const char __user *user_buf,
 
 static const struct file_operations bus_reset_fops = {
 	.open	= simple_open,
-	.llseek	= no_llseek,
 	.write	= bus_reset_write,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 61f9136a333d..df8cccdceacc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2789,7 +2789,6 @@ static int iwl_mvm_d3_test_release(struct inode *inode, struct file *file)
 }
 
 const struct file_operations iwl_dbgfs_d3_test_ops = {
-	.llseek = no_llseek,
 	.open = iwl_mvm_d3_test_open,
 	.read = iwl_mvm_d3_test_read,
 	.release = iwl_mvm_d3_test_release,
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index f94d43b082d9..48b6524e51f3 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -769,7 +769,6 @@ static const struct file_operations pinmux_select_ops = {
 	.owner = THIS_MODULE,
 	.open = pinmux_select_open,
 	.write = pinmux_select,
-	.llseek = no_llseek,
 	.release = single_release,
 };
 
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 0dbceee87a4b..b67016df063d 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -294,7 +294,6 @@ static const struct file_operations cros_ec_console_log_fops = {
 	.owner = THIS_MODULE,
 	.open = cros_ec_console_log_open,
 	.read = cros_ec_console_log_read,
-	.llseek = no_llseek,
 	.poll = cros_ec_console_log_poll,
 	.release = cros_ec_console_log_release,
 };
diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index a812788a0bdc..77b1cf3efd28 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -155,7 +155,6 @@ static const struct file_operations fops_raw = {
 	.owner = THIS_MODULE,
 	.read = raw_read,
 	.write = raw_write,
-	.llseek = no_llseek,
 };
 
 #define CMD_KB_CHROME		0x88
diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index 814518509739..c82886ccc655 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -404,7 +404,6 @@ static const struct file_operations event_fops = {
 	.poll  = event_poll,
 	.read = event_read,
 	.release = event_release,
-	.llseek = no_llseek,
 	.owner = THIS_MODULE,
 };
 
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index 60da7a29f2ff..54f4e6c75b6e 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -330,7 +330,6 @@ static const struct file_operations telem_fops = {
 	.write = telem_write,
 	.read = telem_read,
 	.release = telem_release,
-	.llseek = no_llseek,
 	.owner = THIS_MODULE,
 };
 
diff --git a/drivers/platform/surface/surface_aggregator_cdev.c b/drivers/platform/surface/surface_aggregator_cdev.c
index 30fb50fde450..885e07de02f0 100644
--- a/drivers/platform/surface/surface_aggregator_cdev.c
+++ b/drivers/platform/surface/surface_aggregator_cdev.c
@@ -670,7 +670,6 @@ static const struct file_operations ssam_controller_fops = {
 	.fasync         = ssam_cdev_fasync,
 	.unlocked_ioctl = ssam_cdev_device_ioctl,
 	.compat_ioctl   = ssam_cdev_device_ioctl,
-	.llseek         = no_llseek,
 };
 
 
diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/surface/surface_dtx.c
index 1203b9a82993..1a10cd371353 100644
--- a/drivers/platform/surface/surface_dtx.c
+++ b/drivers/platform/surface/surface_dtx.c
@@ -555,7 +555,6 @@ static const struct file_operations surface_dtx_fops = {
 	.fasync         = surface_dtx_fasync,
 	.unlocked_ioctl = surface_dtx_ioctl,
 	.compat_ioctl   = surface_dtx_ioctl,
-	.llseek         = no_llseek,
 };
 
 
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 22a65ad4e46e..4f4a4db7b14f 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -319,7 +319,6 @@ static int pps_cdev_release(struct inode *inode, struct file *file)
 
 static const struct file_operations pps_cdev_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.poll		= pps_cdev_poll,
 	.fasync		= pps_cdev_fasync,
 	.compat_ioctl	= pps_cdev_compat_ioctl,
diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
index 69325aeede1a..eb22a291a48f 100644
--- a/drivers/rtc/dev.c
+++ b/drivers/rtc/dev.c
@@ -523,7 +523,6 @@ static int rtc_dev_release(struct inode *inode, struct file *file)
 
 static const struct file_operations rtc_dev_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= rtc_dev_read,
 	.poll		= rtc_dev_poll,
 	.unlocked_ioctl	= rtc_dev_ioctl,
diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index d868458cd40e..aa919e8ca167 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -850,7 +850,6 @@ static const struct file_operations wdt_fops = {
 	.write	= wdt_write,
 	.open	= wdt_open,
 	.release = wdt_release,
-	.llseek = no_llseek,
 };
 
 static struct miscdevice wdt_dev = {
diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 4c4683d8784a..69c6ca5b86f9 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -522,7 +522,6 @@ static const struct file_operations fs3270_fops = {
 	.compat_ioctl	 = fs3270_ioctl,	/* ioctl */
 	.open		 = fs3270_open,		/* open */
 	.release	 = fs3270_close,	/* release */
-	.llseek		= no_llseek,
 };
 
 static void fs3270_create_cb(int minor)
diff --git a/drivers/s390/char/sclp_ctl.c b/drivers/s390/char/sclp_ctl.c
index 248b5db3eaa8..dd6051602070 100644
--- a/drivers/s390/char/sclp_ctl.c
+++ b/drivers/s390/char/sclp_ctl.c
@@ -115,7 +115,6 @@ static const struct file_operations sclp_ctl_fops = {
 	.open = nonseekable_open,
 	.unlocked_ioctl = sclp_ctl_ioctl,
 	.compat_ioctl = sclp_ctl_ioctl,
-	.llseek = no_llseek,
 };
 
 /*
diff --git a/drivers/s390/char/tape_char.c b/drivers/s390/char/tape_char.c
index cc8237afeffa..89778d922d9f 100644
--- a/drivers/s390/char/tape_char.c
+++ b/drivers/s390/char/tape_char.c
@@ -52,7 +52,6 @@ static const struct file_operations tape_fops =
 #endif
 	.open = tapechar_open,
 	.release = tapechar_release,
-	.llseek = no_llseek,
 };
 
 static int tapechar_major = TAPECHAR_MAJOR;
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 66505d7166a6..bb279b2c4b2c 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -228,7 +228,6 @@ static long uvio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 static const struct file_operations uvio_dev_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = uvio_ioctl,
-	.llseek = no_llseek,
 };
 
 static struct miscdevice uvio_dev_miscdev = {
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 4cebfaaa22b4..c7a0b07848c1 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -242,7 +242,6 @@ static const struct file_operations vmcp_fops = {
 	.write		= vmcp_write,
 	.unlocked_ioctl	= vmcp_ioctl,
 	.compat_ioctl	= vmcp_ioctl,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice vmcp_dev = {
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index ed970ecfafdf..b06b5067c8a6 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -96,7 +96,6 @@ static const struct file_operations vmlogrdr_fops = {
 	.open    = vmlogrdr_open,
 	.release = vmlogrdr_release,
 	.read    = vmlogrdr_read,
-	.llseek  = no_llseek,
 };
 
 
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 516783ba950f..983414728049 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -161,7 +161,6 @@ static const struct file_operations zcore_reipl_fops = {
 	.write		= zcore_reipl_write,
 	.open		= zcore_reipl_open,
 	.release	= zcore_reipl_release,
-	.llseek		= no_llseek,
 };
 
 static ssize_t zcore_hsa_read(struct file *filp, char __user *buf,
@@ -196,7 +195,6 @@ static const struct file_operations zcore_hsa_fops = {
 	.write		= zcore_hsa_write,
 	.read		= zcore_hsa_read,
 	.open		= nonseekable_open,
-	.llseek		= no_llseek,
 };
 
 static int __init check_sdias(void)
diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 962dfa25a310..15d0dd3ea18c 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -923,7 +923,6 @@ static const struct file_operations chsc_fops = {
 	.release = chsc_release,
 	.unlocked_ioctl = chsc_ioctl,
 	.compat_ioctl = chsc_ioctl,
-	.llseek = no_llseek,
 };
 
 static struct miscdevice chsc_misc_device = {
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 913b6ddd040b..f61bff1ddc41 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -1334,7 +1334,6 @@ static ssize_t cio_settle_write(struct file *file, const char __user *buf,
 static const struct proc_ops cio_settle_proc_ops = {
 	.proc_open	= nonseekable_open,
 	.proc_write	= cio_settle_write,
-	.proc_lseek	= no_llseek,
 };
 
 static int __init cio_settle_init(void)
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 7329caa7d467..1a35898b0b82 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -2065,7 +2065,6 @@ static const struct attribute_group *pkey_attr_groups[] = {
 static const struct file_operations pkey_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nonseekable_open,
-	.llseek		= no_llseek,
 	.unlocked_ioctl = pkey_unlocked_ioctl,
 };
 
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index f94b43ce9a65..3408d5c39078 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -2007,7 +2007,6 @@ static const struct file_operations zcrypt_fops = {
 #endif
 	.open		= zcrypt_open,
 	.release	= zcrypt_release,
-	.llseek		= no_llseek,
 };
 
 /*
diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 30b9751aad30..b0fd70c40a26 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -687,7 +687,6 @@ static int openprom_release(struct inode * inode, struct file * file)
 
 static const struct file_operations openprom_fops = {
 	.owner =	THIS_MODULE,
-	.llseek =	no_llseek,
 	.unlocked_ioctl = openprom_ioctl,
 	.compat_ioctl =	openprom_compat_ioctl,
 	.open =		openprom_open,
diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 05de0ce79cb9..888a63ebaa94 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -221,7 +221,6 @@ static irqreturn_t uctrl_interrupt(int irq, void *dev_id)
 
 static const struct file_operations uctrl_fops = {
 	.owner =	THIS_MODULE,
-	.llseek =	no_llseek,
 	.unlocked_ioctl =	uctrl_ioctl,
 	.open =		uctrl_open,
 };
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 118c7b4a8af2..cd14d0eea50d 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1424,7 +1424,6 @@ static const struct file_operations sg_fops = {
 	.mmap = sg_mmap,
 	.release = sg_release,
 	.fasync = sg_fasync,
-	.llseek = no_llseek,
 };
 
 static struct class *sg_sysfs_class;
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index b2775d82d2d7..b09d34870c86 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -670,7 +670,6 @@ static const struct file_operations spidev_fops = {
 	.compat_ioctl = spidev_compat_ioctl,
 	.open =		spidev_open,
 	.release =	spidev_release,
-	.llseek =	no_llseek,
 };
 
 /*-------------------------------------------------------------------------*/
diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 941aaa7eab2e..0480aef15654 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1097,7 +1097,6 @@ static const struct file_operations pi433_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.open =		pi433_open,
 	.release =	pi433_release,
-	.llseek =	no_llseek,
 };
 
 static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
index 01b80331eab6..d3bc6835dc5a 100644
--- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
@@ -346,7 +346,6 @@ static const struct file_operations acpi_thermal_rel_fops = {
 	.open		= acpi_thermal_rel_open,
 	.release	= acpi_thermal_rel_release,
 	.unlocked_ioctl	= acpi_thermal_rel_ioctl,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice acpi_thermal_rel_misc_device = {
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8fec1d8648f5..ee99beb194ce 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -469,7 +469,6 @@ static void tty_show_fdinfo(struct seq_file *m, struct file *file)
 }
 
 static const struct file_operations tty_fops = {
-	.llseek		= no_llseek,
 	.read_iter	= tty_read,
 	.write_iter	= tty_write,
 	.splice_read	= generic_file_splice_read,
@@ -484,7 +483,6 @@ static const struct file_operations tty_fops = {
 };
 
 static const struct file_operations console_fops = {
-	.llseek		= no_llseek,
 	.read_iter	= tty_read,
 	.write_iter	= redirected_tty_write,
 	.splice_read	= generic_file_splice_read,
@@ -498,7 +496,6 @@ static const struct file_operations console_fops = {
 };
 
 static const struct file_operations hung_up_tty_fops = {
-	.llseek		= no_llseek,
 	.read_iter	= hung_up_tty_read,
 	.write_iter	= hung_up_tty_write,
 	.poll		= hung_up_tty_poll,
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index e0fa4b186ec6..11fdd1e465af 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -693,7 +693,6 @@ static __poll_t ffs_ep0_poll(struct file *file, poll_table *wait)
 }
 
 static const struct file_operations ffs_ep0_operations = {
-	.llseek =	no_llseek,
 
 	.open =		ffs_ep0_open,
 	.write =	ffs_ep0_write,
@@ -1368,7 +1367,6 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 }
 
 static const struct file_operations ffs_epfile_operations = {
-	.llseek =	no_llseek,
 
 	.open =		ffs_epfile_open,
 	.write_iter =	ffs_epfile_write_iter,
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 79990597c39f..b5adbc2d33d4 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -697,7 +697,6 @@ static const struct file_operations ep_io_operations = {
 
 	.open =		ep_open,
 	.release =	ep_release,
-	.llseek =	no_llseek,
 	.unlocked_ioctl = ep_ioctl,
 	.read_iter =	ep_read_iter,
 	.write_iter =	ep_write_iter,
@@ -1922,7 +1921,6 @@ gadget_dev_open (struct inode *inode, struct file *fd)
 }
 
 static const struct file_operations ep0_operations = {
-	.llseek =	no_llseek,
 
 	.open =		gadget_dev_open,
 	.read =		ep0_read,
diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 241740024c50..6902dc5589f0 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -1280,7 +1280,6 @@ static const struct file_operations raw_fops = {
 	.unlocked_ioctl =	raw_ioctl,
 	.compat_ioctl =		raw_ioctl,
 	.release =		raw_release,
-	.llseek =		no_llseek,
 };
 
 static struct miscdevice raw_misc_device = {
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index ae2bfbac603e..a447865e230b 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -188,7 +188,6 @@ static int regs_dbg_release(struct inode *inode, struct file *file)
 static const struct file_operations queue_dbg_fops = {
 	.owner		= THIS_MODULE,
 	.open		= queue_dbg_open,
-	.llseek		= no_llseek,
 	.read		= queue_dbg_read,
 	.release	= queue_dbg_release,
 };
diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
index b2f980409d0b..a985d2502898 100644
--- a/drivers/usb/misc/ftdi-elan.c
+++ b/drivers/usb/misc/ftdi-elan.c
@@ -1132,7 +1132,6 @@ static ssize_t ftdi_elan_write(struct file *file,
 
 static const struct file_operations ftdi_elan_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.read = ftdi_elan_read,
 	.write = ftdi_elan_write,
 	.open = ftdi_elan_open,
diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index dcc88df72df4..60504d088b39 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -627,7 +627,6 @@ static const struct file_operations ld_usb_fops = {
 	.open =		ld_usb_open,
 	.release =	ld_usb_release,
 	.poll =		ld_usb_poll,
-	.llseek =	no_llseek,
 };
 
 /*
diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index f48a23adbc35..2c5785aa1126 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1277,7 +1277,6 @@ static int mon_bin_mmap(struct file *filp, struct vm_area_struct *vma)
 static const struct file_operations mon_fops_binary = {
 	.owner =	THIS_MODULE,
 	.open =		mon_bin_open,
-	.llseek =	no_llseek,
 	.read =		mon_bin_read,
 	/* .write =	mon_text_write, */
 	.poll =		mon_bin_poll,
diff --git a/drivers/usb/mon/mon_stat.c b/drivers/usb/mon/mon_stat.c
index 98ab0cc473d6..f31cddeed734 100644
--- a/drivers/usb/mon/mon_stat.c
+++ b/drivers/usb/mon/mon_stat.c
@@ -62,7 +62,6 @@ static int mon_stat_release(struct inode *inode, struct file *file)
 const struct file_operations mon_fops_stat = {
 	.owner =	THIS_MODULE,
 	.open =		mon_stat_open,
-	.llseek =	no_llseek,
 	.read =		mon_stat_read,
 	/* .write =	mon_stat_write, */
 	/* .poll =		mon_stat_poll, */
diff --git a/drivers/usb/mon/mon_text.c b/drivers/usb/mon/mon_text.c
index 39cb14164652..14512cd9f7ff 100644
--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -685,7 +685,6 @@ static int mon_text_release(struct inode *inode, struct file *file)
 static const struct file_operations mon_fops_text_t = {
 	.owner =	THIS_MODULE,
 	.open =		mon_text_open,
-	.llseek =	no_llseek,
 	.read =		mon_text_read_t,
 	.release =	mon_text_release,
 };
@@ -693,7 +692,6 @@ static const struct file_operations mon_fops_text_t = {
 static const struct file_operations mon_fops_text_u = {
 	.owner =	THIS_MODULE,
 	.open =		mon_text_open,
-	.llseek =	no_llseek,
 	.read =		mon_text_read_u,
 	.release =	mon_text_release,
 };
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 4def43f5f7b6..3ac94db5250c 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -739,7 +739,6 @@ static const struct file_operations hisi_acc_vf_resume_fops = {
 	.owner = THIS_MODULE,
 	.write = hisi_acc_vf_resume_write,
 	.release = hisi_acc_vf_release_file,
-	.llseek = no_llseek,
 };
 
 static struct hisi_acc_vf_migration_file *
@@ -806,7 +805,6 @@ static const struct file_operations hisi_acc_vf_save_fops = {
 	.owner = THIS_MODULE,
 	.read = hisi_acc_vf_save_read,
 	.release = hisi_acc_vf_release_file,
-	.llseek = no_llseek,
 };
 
 static struct hisi_acc_vf_migration_file *
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index 0558d0649ddb..bccab6d466d3 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -220,7 +220,6 @@ static const struct file_operations mlx5vf_save_fops = {
 	.read = mlx5vf_save_read,
 	.poll = mlx5vf_save_poll,
 	.release = mlx5vf_release_file,
-	.llseek = no_llseek,
 };
 
 static struct mlx5_vf_migration_file *
@@ -338,7 +337,6 @@ static const struct file_operations mlx5vf_resume_fops = {
 	.owner = THIS_MODULE,
 	.write = mlx5vf_resume_write,
 	.release = mlx5vf_release_file,
-	.llseek = no_llseek,
 };
 
 static struct mlx5_vf_migration_file *
diff --git a/drivers/watchdog/acquirewdt.c b/drivers/watchdog/acquirewdt.c
index bc6f333565d3..de5f456f72cf 100644
--- a/drivers/watchdog/acquirewdt.c
+++ b/drivers/watchdog/acquirewdt.c
@@ -218,7 +218,6 @@ static int acq_close(struct inode *inode, struct file *file)
 
 static const struct file_operations acq_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= acq_write,
 	.unlocked_ioctl	= acq_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/advantechwdt.c b/drivers/watchdog/advantechwdt.c
index 554fe85da50e..52264a08b890 100644
--- a/drivers/watchdog/advantechwdt.c
+++ b/drivers/watchdog/advantechwdt.c
@@ -217,7 +217,6 @@ static int advwdt_close(struct inode *inode, struct file *file)
 
 static const struct file_operations advwdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= advwdt_write,
 	.unlocked_ioctl	= advwdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/alim1535_wdt.c b/drivers/watchdog/alim1535_wdt.c
index bfb9a91ca1df..1ecbd1ac5c3a 100644
--- a/drivers/watchdog/alim1535_wdt.c
+++ b/drivers/watchdog/alim1535_wdt.c
@@ -359,7 +359,6 @@ static int __init ali_find_watchdog(void)
 
 static const struct file_operations ali_fops = {
 	.owner		=	THIS_MODULE,
-	.llseek		=	no_llseek,
 	.write		=	ali_write,
 	.unlocked_ioctl =	ali_ioctl,
 	.compat_ioctl	= 	compat_ptr_ioctl,
diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
index 4ff7f5afb7aa..9c7cf939ba3d 100644
--- a/drivers/watchdog/alim7101_wdt.c
+++ b/drivers/watchdog/alim7101_wdt.c
@@ -289,7 +289,6 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations wdt_fops = {
 	.owner		=	THIS_MODULE,
-	.llseek		=	no_llseek,
 	.write		=	fop_write,
 	.open		=	fop_open,
 	.release	=	fop_close,
diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
index 743e171d97a3..6fc07afdaf5c 100644
--- a/drivers/watchdog/ar7_wdt.c
+++ b/drivers/watchdog/ar7_wdt.c
@@ -250,7 +250,6 @@ static const struct file_operations ar7_wdt_fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= ar7_wdt_open,
 	.release	= ar7_wdt_release,
-	.llseek		= no_llseek,
 };
 
 static struct miscdevice ar7_wdt_miscdev = {
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index 6d751eb8191d..980d45285459 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -211,7 +211,6 @@ static ssize_t at91_wdt_write(struct file *file, const char *data,
 
 static const struct file_operations at91wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.unlocked_ioctl	= at91_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= at91_wdt_open,
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 0f18f06a21b6..88e410365eb9 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -231,7 +231,6 @@ static long ath79_wdt_ioctl(struct file *file, unsigned int cmd,
 
 static const struct file_operations ath79_wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= ath79_wdt_write,
 	.unlocked_ioctl	= ath79_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
index 688b112e712b..8c6f528db110 100644
--- a/drivers/watchdog/cpu5wdt.c
+++ b/drivers/watchdog/cpu5wdt.c
@@ -185,7 +185,6 @@ static ssize_t cpu5wdt_write(struct file *file, const char __user *buf,
 
 static const struct file_operations cpu5wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.unlocked_ioctl	= cpu5wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= cpu5wdt_open,
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 1eafe0b4d71c..8956935f7258 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -507,7 +507,6 @@ static const struct file_operations cpwd_fops = {
 	.write =		cpwd_write,
 	.read =			cpwd_read,
 	.release =		cpwd_release,
-	.llseek =		no_llseek,
 };
 
 static int cpwd_probe(struct platform_device *op)
diff --git a/drivers/watchdog/eurotechwdt.c b/drivers/watchdog/eurotechwdt.c
index ce682942662c..8955e8222578 100644
--- a/drivers/watchdog/eurotechwdt.c
+++ b/drivers/watchdog/eurotechwdt.c
@@ -368,7 +368,6 @@ static int eurwdt_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations eurwdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= eurwdt_write,
 	.unlocked_ioctl	= eurwdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index df5406aa7d25..e3a3165784dc 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -245,7 +245,6 @@ static int gef_wdt_release(struct inode *inode, struct file *file)
 
 static const struct file_operations gef_wdt_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.write = gef_wdt_write,
 	.unlocked_ioctl = gef_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/geodewdt.c b/drivers/watchdog/geodewdt.c
index 0b699c783d57..f4bb0076737c 100644
--- a/drivers/watchdog/geodewdt.c
+++ b/drivers/watchdog/geodewdt.c
@@ -196,7 +196,6 @@ static long geodewdt_ioctl(struct file *file, unsigned int cmd,
 
 static const struct file_operations geodewdt_fops = {
 	.owner          = THIS_MODULE,
-	.llseek         = no_llseek,
 	.write          = geodewdt_write,
 	.unlocked_ioctl = geodewdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/ib700wdt.c b/drivers/watchdog/ib700wdt.c
index a0ddedc362fc..a199eeb17fab 100644
--- a/drivers/watchdog/ib700wdt.c
+++ b/drivers/watchdog/ib700wdt.c
@@ -256,7 +256,6 @@ static int ibwdt_close(struct inode *inode, struct file *file)
 
 static const struct file_operations ibwdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= ibwdt_write,
 	.unlocked_ioctl	= ibwdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/ibmasr.c b/drivers/watchdog/ibmasr.c
index 4a22fe152086..10b269bf5720 100644
--- a/drivers/watchdog/ibmasr.c
+++ b/drivers/watchdog/ibmasr.c
@@ -341,7 +341,6 @@ static int asr_release(struct inode *inode, struct file *file)
 
 static const struct file_operations asr_fops = {
 	.owner =		THIS_MODULE,
-	.llseek =		no_llseek,
 	.write =		asr_write,
 	.unlocked_ioctl =	asr_ioctl,
 	.compat_ioctl =		compat_ptr_ioctl,
diff --git a/drivers/watchdog/indydog.c b/drivers/watchdog/indydog.c
index 9857bb74a723..d3092d261345 100644
--- a/drivers/watchdog/indydog.c
+++ b/drivers/watchdog/indydog.c
@@ -149,7 +149,6 @@ static int indydog_notify_sys(struct notifier_block *this,
 
 static const struct file_operations indydog_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= indydog_write,
 	.unlocked_ioctl	= indydog_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/it8712f_wdt.c b/drivers/watchdog/it8712f_wdt.c
index 3ce6a58bd81e..b776e6766c9d 100644
--- a/drivers/watchdog/it8712f_wdt.c
+++ b/drivers/watchdog/it8712f_wdt.c
@@ -341,7 +341,6 @@ static int it8712f_wdt_release(struct inode *inode, struct file *file)
 
 static const struct file_operations it8712f_wdt_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.write = it8712f_wdt_write,
 	.unlocked_ioctl = it8712f_wdt_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
diff --git a/drivers/watchdog/m54xx_wdt.c b/drivers/watchdog/m54xx_wdt.c
index f388a769dbd3..f4fa6a4f78d2 100644
--- a/drivers/watchdog/m54xx_wdt.c
+++ b/drivers/watchdog/m54xx_wdt.c
@@ -181,7 +181,6 @@ static int m54xx_wdt_release(struct inode *inode, struct file *file)
 
 static const struct file_operations m54xx_wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= m54xx_wdt_write,
 	.unlocked_ioctl	= m54xx_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
index 73f2221f6222..73d641486909 100644
--- a/drivers/watchdog/machzwd.c
+++ b/drivers/watchdog/machzwd.c
@@ -359,7 +359,6 @@ static int zf_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations zf_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= zf_write,
 	.unlocked_ioctl = zf_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/mixcomwd.c b/drivers/watchdog/mixcomwd.c
index d387bad377c4..70d9cf84c342 100644
--- a/drivers/watchdog/mixcomwd.c
+++ b/drivers/watchdog/mixcomwd.c
@@ -224,7 +224,6 @@ static long mixcomwd_ioctl(struct file *file,
 
 static const struct file_operations mixcomwd_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= mixcomwd_write,
 	.unlocked_ioctl	= mixcomwd_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index ea1bbf5ee528..163acad554de 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -177,7 +177,6 @@ static ssize_t mtx1_wdt_write(struct file *file, const char *buf,
 
 static const struct file_operations mtx1_wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.unlocked_ioctl	= mtx1_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= mtx1_wdt_open,
diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index f6902a337422..3a11504ff94c 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -264,7 +264,6 @@ static long nv_tco_ioctl(struct file *file, unsigned int cmd,
 
 static const struct file_operations nv_tco_fops = {
 	.owner =		THIS_MODULE,
-	.llseek =		no_llseek,
 	.write =		nv_tco_write,
 	.unlocked_ioctl =	nv_tco_ioctl,
 	.compat_ioctl =		compat_ptr_ioctl,
diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index 9f9a340427fc..7b22369ea8bb 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -470,7 +470,6 @@ static int pc87413_notify_sys(struct notifier_block *this,
 
 static const struct file_operations pc87413_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= pc87413_write,
 	.unlocked_ioctl	= pc87413_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
index a793b03a785d..1a4282235aac 100644
--- a/drivers/watchdog/pcwd.c
+++ b/drivers/watchdog/pcwd.c
@@ -749,7 +749,6 @@ static int pcwd_temp_close(struct inode *inode, struct file *file)
 
 static const struct file_operations pcwd_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= pcwd_write,
 	.unlocked_ioctl	= pcwd_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
@@ -765,7 +764,6 @@ static struct miscdevice pcwd_miscdev = {
 
 static const struct file_operations pcwd_temp_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= pcwd_temp_read,
 	.open		= pcwd_temp_open,
 	.release	= pcwd_temp_close,
diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index 54d86fcb1837..a489b426f2ba 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -643,7 +643,6 @@ static int pcipcwd_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations pcipcwd_fops = {
 	.owner =	THIS_MODULE,
-	.llseek =	no_llseek,
 	.write =	pcipcwd_write,
 	.unlocked_ioctl = pcipcwd_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
@@ -659,7 +658,6 @@ static struct miscdevice pcipcwd_miscdev = {
 
 static const struct file_operations pcipcwd_temp_fops = {
 	.owner =	THIS_MODULE,
-	.llseek =	no_llseek,
 	.read =		pcipcwd_temp_read,
 	.open =		pcipcwd_temp_open,
 	.release =	pcipcwd_temp_release,
diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 1bdaf17c1d38..49793234e80b 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -547,7 +547,6 @@ static int usb_pcwd_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations usb_pcwd_fops = {
 	.owner =	THIS_MODULE,
-	.llseek =	no_llseek,
 	.write =	usb_pcwd_write,
 	.unlocked_ioctl = usb_pcwd_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
@@ -563,7 +562,6 @@ static struct miscdevice usb_pcwd_miscdev = {
 
 static const struct file_operations usb_pcwd_temperature_fops = {
 	.owner =	THIS_MODULE,
-	.llseek =	no_llseek,
 	.read =		usb_pcwd_temperature_read,
 	.open =		usb_pcwd_temperature_open,
 	.release =	usb_pcwd_temperature_release,
diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index a98abd0d3146..f68cd031e899 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -209,7 +209,6 @@ static long pikawdt_ioctl(struct file *file,
 
 static const struct file_operations pikawdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.open		= pikawdt_open,
 	.release	= pikawdt_release,
 	.write		= pikawdt_write,
diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
index e74802f3a32e..161bbbac40e6 100644
--- a/drivers/watchdog/rc32434_wdt.c
+++ b/drivers/watchdog/rc32434_wdt.c
@@ -242,7 +242,6 @@ static long rc32434_wdt_ioctl(struct file *file, unsigned int cmd,
 
 static const struct file_operations rc32434_wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= rc32434_wdt_write,
 	.unlocked_ioctl	= rc32434_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/rdc321x_wdt.c b/drivers/watchdog/rdc321x_wdt.c
index f0c94ea51c3e..da989ee8e25e 100644
--- a/drivers/watchdog/rdc321x_wdt.c
+++ b/drivers/watchdog/rdc321x_wdt.c
@@ -197,7 +197,6 @@ static ssize_t rdc321x_wdt_write(struct file *file, const char __user *buf,
 
 static const struct file_operations rdc321x_wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.unlocked_ioctl	= rdc321x_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= rdc321x_wdt_open,
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index 747e346ed06c..3c48dce7b4ef 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -160,7 +160,6 @@ static ssize_t riowd_write(struct file *file, const char __user *buf,
 
 static const struct file_operations riowd_fops = {
 	.owner =		THIS_MODULE,
-	.llseek =		no_llseek,
 	.unlocked_ioctl =	riowd_ioctl,
 	.compat_ioctl	=	compat_ptr_ioctl,
 	.open =			riowd_open,
diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
index 2d0a06a158a8..45359677483a 100644
--- a/drivers/watchdog/sa1100_wdt.c
+++ b/drivers/watchdog/sa1100_wdt.c
@@ -164,7 +164,6 @@ static long sa1100dog_ioctl(struct file *file, unsigned int cmd,
 
 static const struct file_operations sa1100dog_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= sa1100dog_write,
 	.unlocked_ioctl	= sa1100dog_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
index 504be461f992..eaa68b54cf56 100644
--- a/drivers/watchdog/sb_wdog.c
+++ b/drivers/watchdog/sb_wdog.c
@@ -234,7 +234,6 @@ static int sbwdog_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations sbwdog_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= sbwdog_write,
 	.unlocked_ioctl	= sbwdog_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/sbc60xxwdt.c b/drivers/watchdog/sbc60xxwdt.c
index 7b974802dfc7..e9bf12918ed8 100644
--- a/drivers/watchdog/sbc60xxwdt.c
+++ b/drivers/watchdog/sbc60xxwdt.c
@@ -275,7 +275,6 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= fop_write,
 	.open		= fop_open,
 	.release	= fop_close,
diff --git a/drivers/watchdog/sbc7240_wdt.c b/drivers/watchdog/sbc7240_wdt.c
index d640b26e18a6..21a1f0b32070 100644
--- a/drivers/watchdog/sbc7240_wdt.c
+++ b/drivers/watchdog/sbc7240_wdt.c
@@ -205,7 +205,6 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations wdt_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.write = fop_write,
 	.open = fop_open,
 	.release = fop_close,
diff --git a/drivers/watchdog/sbc8360.c b/drivers/watchdog/sbc8360.c
index 4f8b9912fc51..a9fd1615b4c3 100644
--- a/drivers/watchdog/sbc8360.c
+++ b/drivers/watchdog/sbc8360.c
@@ -301,7 +301,6 @@ static int sbc8360_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations sbc8360_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.write = sbc8360_write,
 	.open = sbc8360_open,
 	.release = sbc8360_close,
diff --git a/drivers/watchdog/sbc_epx_c3.c b/drivers/watchdog/sbc_epx_c3.c
index 5e3a9ddb952e..1d291dc0a4a6 100644
--- a/drivers/watchdog/sbc_epx_c3.c
+++ b/drivers/watchdog/sbc_epx_c3.c
@@ -153,7 +153,6 @@ static int epx_c3_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations epx_c3_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= epx_c3_write,
 	.unlocked_ioctl	= epx_c3_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/sbc_fitpc2_wdt.c b/drivers/watchdog/sbc_fitpc2_wdt.c
index 13db71e16583..0e262eb208f0 100644
--- a/drivers/watchdog/sbc_fitpc2_wdt.c
+++ b/drivers/watchdog/sbc_fitpc2_wdt.c
@@ -183,7 +183,6 @@ static int fitpc2_wdt_release(struct inode *inode, struct file *file)
 
 static const struct file_operations fitpc2_wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= fitpc2_wdt_write,
 	.unlocked_ioctl	= fitpc2_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index f22ebe89fe13..76a58715f665 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -304,7 +304,6 @@ static struct notifier_block sc1200wdt_notifier = {
 
 static const struct file_operations sc1200wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= sc1200wdt_write,
 	.unlocked_ioctl = sc1200wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/sc520_wdt.c b/drivers/watchdog/sc520_wdt.c
index ca65468f4b9c..e849e1af267b 100644
--- a/drivers/watchdog/sc520_wdt.c
+++ b/drivers/watchdog/sc520_wdt.c
@@ -331,7 +331,6 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= fop_write,
 	.open		= fop_open,
 	.release	= fop_close,
diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
index d8b77fe10eba..fd8e99393a12 100644
--- a/drivers/watchdog/sch311x_wdt.c
+++ b/drivers/watchdog/sch311x_wdt.c
@@ -334,7 +334,6 @@ static int sch311x_wdt_close(struct inode *inode, struct file *file)
 
 static const struct file_operations sch311x_wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= sch311x_wdt_write,
 	.unlocked_ioctl	= sch311x_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/scx200_wdt.c b/drivers/watchdog/scx200_wdt.c
index 7b5e18323f3f..4dd8549e3674 100644
--- a/drivers/watchdog/scx200_wdt.c
+++ b/drivers/watchdog/scx200_wdt.c
@@ -198,7 +198,6 @@ static long scx200_wdt_ioctl(struct file *file, unsigned int cmd,
 
 static const struct file_operations scx200_wdt_fops = {
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 	.write = scx200_wdt_write,
 	.unlocked_ioctl = scx200_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/smsc37b787_wdt.c b/drivers/watchdog/smsc37b787_wdt.c
index 7463df479d11..97ca500ec8a8 100644
--- a/drivers/watchdog/smsc37b787_wdt.c
+++ b/drivers/watchdog/smsc37b787_wdt.c
@@ -502,7 +502,6 @@ static int wb_smsc_wdt_notify_sys(struct notifier_block *this,
 
 static const struct file_operations wb_smsc_wdt_fops = {
 	.owner	  = THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= wb_smsc_wdt_write,
 	.unlocked_ioctl	= wb_smsc_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/w83877f_wdt.c b/drivers/watchdog/w83877f_wdt.c
index f2650863fd02..1937084c182c 100644
--- a/drivers/watchdog/w83877f_wdt.c
+++ b/drivers/watchdog/w83877f_wdt.c
@@ -299,7 +299,6 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= fop_write,
 	.open		= fop_open,
 	.release	= fop_close,
diff --git a/drivers/watchdog/w83977f_wdt.c b/drivers/watchdog/w83977f_wdt.c
index fd64ae77780a..37d40bd19c02 100644
--- a/drivers/watchdog/w83977f_wdt.c
+++ b/drivers/watchdog/w83977f_wdt.c
@@ -443,7 +443,6 @@ static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= wdt_write,
 	.unlocked_ioctl	= wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/wafer5823wdt.c b/drivers/watchdog/wafer5823wdt.c
index a8a1ed215e1e..291109349e73 100644
--- a/drivers/watchdog/wafer5823wdt.c
+++ b/drivers/watchdog/wafer5823wdt.c
@@ -227,7 +227,6 @@ static int wafwdt_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations wafwdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= wafwdt_write,
 	.unlocked_ioctl	= wafwdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
index c00627825de8..d4fe0bc82211 100644
--- a/drivers/watchdog/wdrtas.c
+++ b/drivers/watchdog/wdrtas.c
@@ -469,7 +469,6 @@ static int wdrtas_reboot(struct notifier_block *this,
 
 static const struct file_operations wdrtas_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= wdrtas_write,
 	.unlocked_ioctl	= wdrtas_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
@@ -485,7 +484,6 @@ static struct miscdevice wdrtas_miscdev = {
 
 static const struct file_operations wdrtas_temp_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= wdrtas_temp_read,
 	.open		= wdrtas_temp_open,
 	.release	= wdrtas_temp_close,
diff --git a/drivers/watchdog/wdt.c b/drivers/watchdog/wdt.c
index 183876156243..3980d60bacd8 100644
--- a/drivers/watchdog/wdt.c
+++ b/drivers/watchdog/wdt.c
@@ -520,7 +520,6 @@ static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= wdt_write,
 	.unlocked_ioctl	= wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
@@ -536,7 +535,6 @@ static struct miscdevice wdt_miscdev = {
 
 static const struct file_operations wdt_temp_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= wdt_temp_read,
 	.open		= wdt_temp_open,
 	.release	= wdt_temp_release,
diff --git a/drivers/watchdog/wdt285.c b/drivers/watchdog/wdt285.c
index 110249e5f642..c394b70b682e 100644
--- a/drivers/watchdog/wdt285.c
+++ b/drivers/watchdog/wdt285.c
@@ -178,7 +178,6 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 
 static const struct file_operations watchdog_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= watchdog_write,
 	.unlocked_ioctl	= watchdog_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/wdt977.c b/drivers/watchdog/wdt977.c
index c9b8e863f70f..4f449ac4dda4 100644
--- a/drivers/watchdog/wdt977.c
+++ b/drivers/watchdog/wdt977.c
@@ -419,7 +419,6 @@ static int wdt977_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations wdt977_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= wdt977_write,
 	.unlocked_ioctl	= wdt977_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index d5e56b601351..dc5f29560e9b 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -563,7 +563,6 @@ static int wdtpci_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations wdtpci_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= wdtpci_write,
 	.unlocked_ioctl	= wdtpci_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
@@ -579,7 +578,6 @@ static struct miscdevice wdtpci_miscdev = {
 
 static const struct file_operations wdtpci_temp_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= wdtpci_temp_read,
 	.open		= wdtpci_temp_open,
 	.release	= wdtpci_temp_release,
diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index c99415a70051..987ef813eb2b 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -671,7 +671,6 @@ static const struct file_operations evtchn_fops = {
 	.fasync  = evtchn_fasync,
 	.open    = evtchn_open,
 	.release = evtchn_release,
-	.llseek	 = no_llseek,
 };
 
 static struct miscdevice evtchn_miscdev = {
diff --git a/drivers/xen/mcelog.c b/drivers/xen/mcelog.c
index e9ac3b8c4167..4f65b641c054 100644
--- a/drivers/xen/mcelog.c
+++ b/drivers/xen/mcelog.c
@@ -182,7 +182,6 @@ static const struct file_operations xen_mce_chrdev_ops = {
 	.read			= xen_mce_chrdev_read,
 	.poll			= xen_mce_chrdev_poll,
 	.unlocked_ioctl		= xen_mce_chrdev_ioctl,
-	.llseek			= no_llseek,
 };
 
 static struct miscdevice xen_mce_chrdev_device = {
diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 597af455a522..ce759f081208 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -700,7 +700,6 @@ const struct file_operations xen_xenbus_fops = {
 	.open = xenbus_file_open,
 	.release = xenbus_file_release,
 	.poll = xenbus_file_poll,
-	.llseek = no_llseek,
 };
 EXPORT_SYMBOL_GPL(xen_xenbus_fops);
 
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 950c63fa4d0b..4e2ea06677f4 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1056,7 +1056,6 @@ static const struct file_operations u32_array_fops = {
 	.open	 = u32_array_open,
 	.release = u32_array_release,
 	.read	 = u32_array_read,
-	.llseek  = no_llseek,
 };
 
 /**
diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 8fb04ebbafb5..179732b98e5d 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -856,7 +856,6 @@ static ssize_t dlm_rawmsg_write(struct file *fp, const char __user *user_buf,
 static const struct file_operations dlm_rawmsg_fops = {
 	.open	= simple_open,
 	.write	= dlm_rawmsg_write,
-	.llseek	= no_llseek,
 };
 
 void *dlm_create_debug_comms_file(int nodeid, void *data)
diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index d57ee15874f9..92234b2ba7fd 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -110,5 +110,4 @@ const struct file_operations efivarfs_file_operations = {
 	.open	= simple_open,
 	.read	= efivarfs_file_read,
 	.write	= efivarfs_file_write,
-	.llseek	= no_llseek,
 };
diff --git a/fs/fsopen.c b/fs/fsopen.c
index fc9d2d9fd234..3a28a51442ec 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -78,7 +78,6 @@ static int fscontext_release(struct inode *inode, struct file *file)
 const struct file_operations fscontext_fops = {
 	.read		= fscontext_read,
 	.release	= fscontext_release,
-	.llseek		= no_llseek,
 };
 
 /*
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 7cede9a3bc96..29e97201de1d 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -187,27 +187,23 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 static const struct file_operations fuse_ctl_abort_ops = {
 	.open = nonseekable_open,
 	.write = fuse_conn_abort_write,
-	.llseek = no_llseek,
 };
 
 static const struct file_operations fuse_ctl_waiting_ops = {
 	.open = nonseekable_open,
 	.read = fuse_conn_waiting_read,
-	.llseek = no_llseek,
 };
 
 static const struct file_operations fuse_conn_max_background_ops = {
 	.open = nonseekable_open,
 	.read = fuse_conn_max_background_read,
 	.write = fuse_conn_max_background_write,
-	.llseek = no_llseek,
 };
 
 static const struct file_operations fuse_conn_congestion_threshold_ops = {
 	.open = nonseekable_open,
 	.read = fuse_conn_congestion_threshold_read,
 	.write = fuse_conn_congestion_threshold_write,
-	.llseek = no_llseek,
 };
 
 static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0e537e580dc1..d5c8fe83f71b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2290,7 +2290,6 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 const struct file_operations fuse_dev_operations = {
 	.owner		= THIS_MODULE,
 	.open		= fuse_dev_open,
-	.llseek		= no_llseek,
 	.read_iter	= fuse_dev_read,
 	.splice_read	= fuse_dev_splice_read,
 	.write_iter	= fuse_dev_write,
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 800c1d0eb0d0..676dabe95e21 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -19,7 +19,6 @@ static struct vfsmount *nsfs_mnt;
 static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			unsigned long arg);
 static const struct file_operations ns_file_operations = {
-	.llseek		= no_llseek,
 	.unlocked_ioctl = ns_ioctl,
 };
 
diff --git a/fs/pipe.c b/fs/pipe.c
index 74ae9fafd25a..f7ca1eec9ac5 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1217,7 +1217,6 @@ static int fifo_open(struct inode *inode, struct file *filp)
 
 const struct file_operations pipefifo_fops = {
 	.open		= fifo_open,
-	.llseek		= no_llseek,
 	.read_iter	= pipe_read,
 	.write_iter	= pipe_write,
 	.poll		= pipe_poll,
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index fc718f6178f2..eca93dd14eac 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2802,7 +2802,6 @@ static const struct file_operations dfs_fops = {
 	.read = dfs_file_read,
 	.write = dfs_file_write,
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 };
 
 /**
@@ -2947,7 +2946,6 @@ static const struct file_operations dfs_global_fops = {
 	.read = dfs_global_file_read,
 	.write = dfs_global_file_write,
 	.owner = THIS_MODULE,
-	.llseek = no_llseek,
 };
 
 /**
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index c869f1e73d75..17bd8dbd850d 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -57,7 +57,6 @@ static const struct file_operations __fops = {				\
 	.release = simple_attr_release,					\
 	.read	 = debugfs_attr_read,					\
 	.write	 = debugfs_attr_write,					\
-	.llseek  = no_llseek,						\
 }
 
 typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index d5d96ceca105..b5d3f5b732f5 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -274,7 +274,6 @@ static int iter_release(struct inode *inode, struct file *file)
 
 const struct file_operations bpf_iter_fops = {
 	.open		= iter_open,
-	.llseek		= no_llseek,
 	.read		= bpf_seq_read,
 	.release	= iter_release,
 };
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80782cddb1da..3afeb6060f2f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6376,7 +6376,6 @@ static int perf_fasync(int fd, struct file *filp, int on)
 }
 
 static const struct file_operations perf_fops = {
-	.llseek			= no_llseek,
 	.release		= perf_release,
 	.read			= perf_read,
 	.poll			= perf_poll,
diff --git a/kernel/power/user.c b/kernel/power/user.c
index ad241b4ff64c..835958a31485 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -430,7 +430,6 @@ static const struct file_operations snapshot_fops = {
 	.release = snapshot_release,
 	.read = snapshot_read,
 	.write = snapshot_write,
-	.llseek = no_llseek,
 	.unlocked_ioctl = snapshot_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = snapshot_compat_ioctl,
diff --git a/kernel/relay.c b/kernel/relay.c
index 6a611e779e95..d4dd1574e807 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1242,7 +1242,6 @@ const struct file_operations relay_file_operations = {
 	.poll		= relay_file_poll,
 	.mmap		= relay_file_mmap,
 	.read		= relay_file_read,
-	.llseek		= no_llseek,
 	.release	= relay_file_release,
 	.splice_read	= relay_file_splice_read,
 };
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 77c0c2370b6d..0c217fb0b784 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -148,7 +148,6 @@ static int posix_clock_release(struct inode *inode, struct file *fp)
 
 static const struct file_operations posix_clock_file_operations = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= posix_clock_read,
 	.poll		= posix_clock_poll,
 	.unlocked_ioctl	= posix_clock_ioctl,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a8cfac0611bc..c2ce4dfa521b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7574,7 +7574,6 @@ static const struct file_operations tracing_pipe_fops = {
 	.read		= tracing_read_pipe,
 	.splice_read	= tracing_splice_read_pipe,
 	.release	= tracing_release_pipe,
-	.llseek		= no_llseek,
 };
 
 static const struct file_operations tracing_entries_fops = {
@@ -7639,7 +7638,6 @@ static const struct file_operations snapshot_raw_fops = {
 	.read		= tracing_buffers_read,
 	.release	= tracing_buffers_release,
 	.splice_read	= tracing_buffers_splice_read,
-	.llseek		= no_llseek,
 };
 
 #endif /* CONFIG_TRACER_SNAPSHOT */
@@ -8317,7 +8315,6 @@ static const struct file_operations tracing_buffers_fops = {
 	.poll		= tracing_buffers_poll,
 	.release	= tracing_buffers_release,
 	.splice_read	= tracing_buffers_splice_read,
-	.llseek		= no_llseek,
 };
 
 static ssize_t
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 834f288b3769..8229acd14c04 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3072,7 +3072,6 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 static const struct file_operations split_huge_pages_fops = {
 	.owner	 = THIS_MODULE,
 	.write	 = split_huge_pages_write,
-	.llseek  = no_llseek,
 };
 
 static int __init split_huge_pages_debugfs(void)
diff --git a/net/mac80211/rc80211_minstrel_ht_debugfs.c b/net/mac80211/rc80211_minstrel_ht_debugfs.c
index 25b8a67a63a4..85149c774505 100644
--- a/net/mac80211/rc80211_minstrel_ht_debugfs.c
+++ b/net/mac80211/rc80211_minstrel_ht_debugfs.c
@@ -187,7 +187,6 @@ static const struct file_operations minstrel_ht_stat_fops = {
 	.open = minstrel_ht_stats_open,
 	.read = minstrel_stats_read,
 	.release = minstrel_stats_release,
-	.llseek = no_llseek,
 };
 
 static char *
@@ -323,7 +322,6 @@ static const struct file_operations minstrel_ht_stat_csv_fops = {
 	.open = minstrel_ht_stats_csv_open,
 	.read = minstrel_stats_read,
 	.release = minstrel_stats_release,
-	.llseek = no_llseek,
 };
 
 void
diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index dac4fdc7488a..d9bc96546d53 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -1379,7 +1379,6 @@ static const struct file_operations rfkill_fops = {
 	.release	= rfkill_fop_release,
 	.unlocked_ioctl	= rfkill_fop_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
-	.llseek		= no_llseek,
 };
 
 #define RFKILL_NAME "rfkill"
diff --git a/net/socket.c b/net/socket.c
index 2bc8773d9dc5..12e13c89d5c6 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -150,7 +150,6 @@ static void sock_show_fdinfo(struct seq_file *m, struct file *f)
 
 static const struct file_operations socket_file_ops = {
 	.owner =	THIS_MODULE,
-	.llseek =	no_llseek,
 	.read_iter =	sock_read_iter,
 	.write_iter =	sock_write_iter,
 	.poll =		sock_poll,
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index c3c693b51c94..912fd630eb2d 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1596,7 +1596,6 @@ static int cache_release_procfs(struct inode *inode, struct file *filp)
 }
 
 static const struct proc_ops cache_channel_proc_ops = {
-	.proc_lseek	= no_llseek,
 	.proc_read	= cache_read_procfs,
 	.proc_write	= cache_write_procfs,
 	.proc_poll	= cache_poll_procfs,
@@ -1662,7 +1661,6 @@ static const struct proc_ops cache_flush_proc_ops = {
 	.proc_read	= read_flush_procfs,
 	.proc_write	= write_flush_procfs,
 	.proc_release	= release_flush_procfs,
-	.proc_lseek	= no_llseek,
 };
 
 static void remove_cache_proc_entries(struct cache_detail *cd)
@@ -1815,7 +1813,6 @@ static int cache_release_pipefs(struct inode *inode, struct file *filp)
 
 const struct file_operations cache_file_operations_pipefs = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= cache_read_pipefs,
 	.write		= cache_write_pipefs,
 	.poll		= cache_poll_pipefs,
@@ -1881,7 +1878,6 @@ const struct file_operations cache_flush_operations_pipefs = {
 	.read		= read_flush_pipefs,
 	.write		= write_flush_pipefs,
 	.release	= release_flush_pipefs,
-	.llseek		= no_llseek,
 };
 
 int sunrpc_cache_register_pipefs(struct dentry *parent,
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 0b6034fab9ab..e9272ba88d08 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -385,7 +385,6 @@ rpc_pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations rpc_pipe_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= rpc_pipe_read,
 	.write		= rpc_pipe_write,
 	.poll		= rpc_pipe_poll,
diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
index df00d6619b06..50ab60c81f13 100644
--- a/scripts/coccinelle/api/stream_open.cocci
+++ b/scripts/coccinelle/api/stream_open.cocci
@@ -131,7 +131,6 @@ identifier llseek_f;
 identifier fops0.fops;
 @@
   struct file_operations fops = {
-    .llseek = no_llseek,
   };
 
 @ has_noop_llseek @
diff --git a/sound/core/control.c b/sound/core/control.c
index a25c0d64d104..5c8fd44af0ca 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -2128,7 +2128,6 @@ static const struct file_operations snd_ctl_f_ops =
 	.read =		snd_ctl_read,
 	.open =		snd_ctl_open,
 	.release =	snd_ctl_release,
-	.llseek =	no_llseek,
 	.poll =		snd_ctl_poll,
 	.unlocked_ioctl =	snd_ctl_ioctl,
 	.compat_ioctl =	snd_ctl_ioctl_compat,
diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 9620115cfdc0..63351b6ef5fa 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -426,7 +426,6 @@ static const struct file_operations snd_mixer_oss_f_ops =
 	.owner =	THIS_MODULE,
 	.open =		snd_mixer_oss_open,
 	.release =	snd_mixer_oss_release,
-	.llseek =	no_llseek,
 	.unlocked_ioctl =	snd_mixer_oss_ioctl,
 	.compat_ioctl =	snd_mixer_oss_ioctl_compat,
 };
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 90c3a367d7de..1e057bccf3af 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -3126,7 +3126,6 @@ static const struct file_operations snd_pcm_oss_f_reg =
 	.write =	snd_pcm_oss_write,
 	.open =		snd_pcm_oss_open,
 	.release =	snd_pcm_oss_release,
-	.llseek =	no_llseek,
 	.poll =		snd_pcm_oss_poll,
 	.unlocked_ioctl =	snd_pcm_oss_ioctl,
 	.compat_ioctl =	snd_pcm_oss_ioctl_compat,
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 4adaee62ef33..e8d1d27ffa4d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -4107,7 +4107,6 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.write_iter =		snd_pcm_writev,
 		.open =			snd_pcm_playback_open,
 		.release =		snd_pcm_release,
-		.llseek =		no_llseek,
 		.poll =			snd_pcm_poll,
 		.unlocked_ioctl =	snd_pcm_ioctl,
 		.compat_ioctl = 	snd_pcm_ioctl_compat,
@@ -4121,7 +4120,6 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.read_iter =		snd_pcm_readv,
 		.open =			snd_pcm_capture_open,
 		.release =		snd_pcm_release,
-		.llseek =		no_llseek,
 		.poll =			snd_pcm_poll,
 		.unlocked_ioctl =	snd_pcm_ioctl,
 		.compat_ioctl = 	snd_pcm_ioctl_compat,
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index befa9809ff00..a21d51f8e45e 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1711,7 +1711,6 @@ static const struct file_operations snd_rawmidi_f_ops = {
 	.write =	snd_rawmidi_write,
 	.open =		snd_rawmidi_open,
 	.release =	snd_rawmidi_release,
-	.llseek =	no_llseek,
 	.poll =		snd_rawmidi_poll,
 	.unlocked_ioctl =	snd_rawmidi_ioctl,
 	.compat_ioctl =	snd_rawmidi_ioctl_compat,
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 2e9d695d336c..1205a3ca0437 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2512,7 +2512,6 @@ static const struct file_operations snd_seq_f_ops =
 	.write =	snd_seq_write,
 	.open =		snd_seq_open,
 	.release =	snd_seq_release,
-	.llseek =	no_llseek,
 	.poll =		snd_seq_poll,
 	.unlocked_ioctl =	snd_seq_ioctl,
 	.compat_ioctl =	snd_seq_ioctl_compat,
diff --git a/sound/core/timer.c b/sound/core/timer.c
index b3214baa8919..51700e230048 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2276,7 +2276,6 @@ static const struct file_operations snd_timer_f_ops =
 	.read =		snd_timer_user_read,
 	.open =		snd_timer_user_open,
 	.release =	snd_timer_user_release,
-	.llseek =	no_llseek,
 	.poll =		snd_timer_user_poll,
 	.unlocked_ioctl =	snd_timer_user_ioctl,
 	.compat_ioctl =	snd_timer_user_ioctl_compat,
diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index 164335d3c200..59f72c50cb49 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -380,7 +380,6 @@ static long mixer_unlocked_ioctl(struct file *file, u_int cmd, u_long arg)
 static const struct file_operations mixer_fops =
 {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.unlocked_ioctl	= mixer_unlocked_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= mixer_open,
@@ -1154,7 +1153,6 @@ static long sq_unlocked_ioctl(struct file *file, u_int cmd, u_long arg)
 static const struct file_operations sq_fops =
 {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.write		= sq_write,
 	.poll		= sq_poll,
 	.unlocked_ioctl	= sq_unlocked_ioctl,
@@ -1350,7 +1348,6 @@ static ssize_t state_read(struct file *file, char __user *buf, size_t count,
 
 static const struct file_operations state_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= state_read,
 	.open		= state_open,
 	.release	= state_release,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a49df8988cd6..b18b9ecc0082 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5405,7 +5405,6 @@ static const struct file_operations stat_fops_per_vm = {
 	.release = kvm_debugfs_release,
 	.read = simple_attr_read,
 	.write = simple_attr_write,
-	.llseek = no_llseek,
 };
 
 static int vm_stat_get(void *_offset, u64 *val)
-- 
2.35.1

