Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC7F559EFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 19:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiFXQ44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 12:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiFXQ4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:56:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076D44755A;
        Fri, 24 Jun 2022 09:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9302DB82AC2;
        Fri, 24 Jun 2022 16:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFD6C34114;
        Fri, 24 Jun 2022 16:56:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ELXMhTKt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656089808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zt7CvLerIkDFUFr5xqe1nRU2goCLIECoRv7t2CiE4YQ=;
        b=ELXMhTKt8QQ9KR74mGDqDIAcB6aZ4VmuFu6ntuG1d1/ZeiDjhASZNcab+K5M8nZLv9akfW
        jEYLwAdMPQpi++6lBrVEPbPrCQjbvweYBIHMOJXY7zi4MNhmP4A3Ki1nHwmtgDnI6Z3LKR
        JGNVY+cdyI7LHZ6MPsAerfD5lfuudZQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 328089cf (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 24 Jun 2022 16:56:48 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 0/6] cleanup llseek and splice
Date:   Fri, 24 Jun 2022 18:56:25 +0200
Message-Id: <20220624165631.2124632-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The goal of this patchset is to enable splicing to internal pipes for
select chardevs where it makes sense to do so. In the process, however,
it was revealed that many regular files are problematic here. The key
insight is that splicing to internal pipes is okay so long as the splice
operation is rewindable. That means these devices need to be llseekable.

So the series first tries to make llseek a bit tamer, fixing up the
long-standing tension between llseek==NULL vs llseek==no_llseek vs
~FMODE_LSEEK.

Along the way the series also fixes related bugs in ksmbd, dma-buf, and
vfio.

Finally, with FMODE_LSEEK as good information, the series is able to
adjust internal pipe splicing to use that.

Jason A. Donenfeld (6):
  ksmbd: use vfs_llseek instead of dereferencing NULL
  fs: do not set no_llseek in fops
  fs: clear FMODE_LSEEK if no llseek function
  fs: check FMODE_LSEEK to control internal pipe splicing
  dma-buf: remove useless FMODE_LSEEK flag
  vfio: do not set FMODE_LSEEK flag

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
 drivers/dma-buf/dma-buf.c                       |  1 -
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
 drivers/vfio/vfio.c                             |  2 +-
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
 fs/file_table.c                                 |  2 ++
 fs/fsopen.c                                     |  1 -
 fs/fuse/control.c                               |  4 ----
 fs/fuse/dev.c                                   |  1 -
 fs/ksmbd/vfs.c                                  |  4 ++--
 fs/nsfs.c                                       |  1 -
 fs/open.c                                       |  2 ++
 fs/pipe.c                                       |  1 -
 fs/splice.c                                     | 10 ++++------
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
 223 files changed, 11 insertions(+), 283 deletions(-)

-- 
2.35.1

