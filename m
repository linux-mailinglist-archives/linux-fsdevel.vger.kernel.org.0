Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C227B33A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 21:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfG3T0F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 15:26:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45921 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfG3T0F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:26:05 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M1q4e-1hujcA2vwe-002JAF; Tue, 30 Jul 2019 21:26:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 00/29] compat_ioctl.c removal, part 1/3
Date:   Tue, 30 Jul 2019 21:25:11 +0200
Message-Id: <20190730192552.4014288-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cTb2RJedViSh/ocjcq1r7oTRZJhH2qvOjtz2vJEr98hdKN8JR/N
 wNCdFzVg5dEe98TzcC1paxA5Op/shXYpRoNasGMJGLP4yXtkqCissFk1mzJDV531mUddmx5
 n9F5rMpPA1I7ASf6teZejH3bUjsLp8NQ2fGywcBGj1rQ+9ltB0VPTa33MudDXfngl3+D5Du
 0Pi3LM1ydmDSmk7pGVV/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6WYH7XZUDDg=:s2UOKhdbDfDZa760DAQTEW
 yil+yH7GaOQFNgevgvFueiAlOfggZcB1Eg7trlu0UWXwhy8Vek0ezlI7obD2InAzX1QuFl46h
 turxTG9VOQy1DAxmF3GB1fdlNwxCPNZkcApqdLYhoF8A8yzF6Bz0EH6x7POxIjBZXSKIls2dM
 Bts+KwyIwV5LJAaM2plZucHx0CIheS+gmxS6dCFb5C2blCUvnFX/uzyAdP42wjwhoYRd8Qq+M
 arOECAJWNyZQ5lvcDKzf+T2mdCd/zuTO9DL67am7yXNu0vShMVI95FDupVAV5/nTYpemLvAHZ
 gu+BdhxdhocG+mRQ8y1pp+u5oVJ7W0qEhnAZAi0xXM2VsJKNAoxQKoMPX+8uj70vU0jCWJsqa
 ZLNIgShHF/wYNujA3L2dyPQH96uNry/KwUOAeMySJK8jGMwrn4it7p+oPUvvS3tbpQzWqtpea
 /opSZWIHI94cKNBangD42IG3Uv3auIiEZyTxkKZ+pNkhTUN30fuWitdr3M1EVvzk89q7IA5Wd
 0X8JGryEr1QTBvVHzDmhCJAMBzaLV6RjbEDuCGzHKK4c0gyXZQi7QUN4Kab8BBsaAknBZig2C
 X0Fkn1aG+4zqFYUWhkkhbpuUzI23QsJb9fu3LYBgodEDL7ax51Uq1t3oZc1OWJyVbypLf1CPw
 c1hPy6ZZ4Wg07N7iK87ZjfTvVC5fbsdA185sqMgqVZh+i2S7XEoc33OHDrQteUpn4F8Sod+Yr
 9OVmSDDoW6RbzrrcDRpuoXUHJVkOAE9U0E+ACQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

This is the first of three set of patches for a series intended to
completely remove fs/compat_ioctl.c in favor of handling all
compat ioctl commands directly in drivers.

Most of these patches have been reviewed in the past. Al Viro
added some more in his private tree, and I subsequently rebased
my patches around his.

I would hope to get parts 2 and 3 of the series into the next
kernel merge window. Al, let me know if you have any concerns
about this first set. If you prefer a pull request, you can 
get the same patches from

https://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git compat-ioctl-v5-part1

There is also a compat-ioctl-v5 branch that contains the other
two parts, with a total of 52 patches that seemed a little too
much to post at once. My plan is to have everything up to
ffdecfc187e4 ("scsi: sd: enable compat ioctls for sed-opal")
in linux-5.4. The final five patches are for the SCSI ioctls
and contain at least one bug that was reported by the 0-day bot,
so I'd leave them for a later kernel, unless you want to
take a stab at fixing them.

      Arnd

Al Viro (6):
  fix compat handling of FICLONERANGE, FIDEDUPERANGE and FS_IOC_FIEMAP
  FIGETBSZ: fix compat
  compat: itanic doesn't have one
  do_vfs_ioctl(): use saner types
  compat: move FS_IOC_RESVSP_32 handling to fs/ioctl.c
  compat_sys_ioctl(): make parallel to do_vfs_ioctl()

Arnd Bergmann (23):
  ceph: fix compat_ioctl for ceph_dir_operations
  compat_ioctl: drop FIOQSIZE table entry
  compat_ioctl: pppoe: fix PPPOEIOCSFWD handling
  compat_ioctl: add compat_ptr_ioctl()
  compat_ioctl: move rtc handling into rtc-dev.c
  compat_ioctl: move drivers to compat_ptr_ioctl
  compat_ioctl: move more drivers to compat_ptr_ioctl
  compat_ioctl: use correct compat_ptr() translation in drivers
  compat_ioctl: move tape handling into drivers
  compat_ioctl: move ATYFB_CLK handling to atyfb driver
  compat_ioctl: move isdn/capi ioctl translation into driver
  compat_ioctl: move rfcomm handlers into driver
  compat_ioctl: move hci_sock handlers into driver
  compat_ioctl: remove HCIUART handling
  compat_ioctl: remove HIDIO translation
  compat_ioctl: remove translation for sound ioctls
  compat_ioctl: remove IGNORE_IOCTL()
  compat_ioctl: remove /dev/random commands
  compat_ioctl: remove joystick ioctl translation
  compat_ioctl: remove PCI ioctl translation
  compat_ioctl: remove /dev/raw ioctl translation
  compat_ioctl: remove last RAID handling code
  compat_ioctl: remove unused convert_in_user macro

 arch/um/drivers/hostaudio_kern.c            |   1 +
 drivers/android/binder.c                    |   2 +-
 drivers/char/ppdev.c                        |  12 +-
 drivers/char/random.c                       |   1 +
 drivers/char/tpm/tpm_vtpm_proxy.c           |  12 +-
 drivers/crypto/qat/qat_common/adf_ctl_drv.c |   2 +-
 drivers/dma-buf/dma-buf.c                   |   4 +-
 drivers/dma-buf/sw_sync.c                   |   2 +-
 drivers/dma-buf/sync_file.c                 |   2 +-
 drivers/firewire/core-cdev.c                |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c    |   2 +-
 drivers/hid/hidraw.c                        |   4 +-
 drivers/hid/usbhid/hiddev.c                 |  11 +-
 drivers/hwtracing/stm/core.c                |  12 +-
 drivers/ide/ide-tape.c                      |  27 +-
 drivers/iio/industrialio-core.c             |   2 +-
 drivers/infiniband/core/uverbs_main.c       |   4 +-
 drivers/isdn/capi/capi.c                    |  31 ++
 drivers/media/rc/lirc_dev.c                 |   4 +-
 drivers/mfd/cros_ec_dev.c                   |   4 +-
 drivers/misc/cxl/flash.c                    |   8 +-
 drivers/misc/genwqe/card_dev.c              |  23 +-
 drivers/misc/mei/main.c                     |  22 +-
 drivers/misc/vmw_vmci/vmci_host.c           |   2 +-
 drivers/mtd/ubi/cdev.c                      |  36 +-
 drivers/net/ppp/pppoe.c                     |   3 +
 drivers/net/ppp/pppox.c                     |  13 +
 drivers/net/ppp/pptp.c                      |   3 +
 drivers/net/tap.c                           |  12 +-
 drivers/nvdimm/bus.c                        |   4 +-
 drivers/nvme/host/core.c                    |   2 +-
 drivers/pci/switch/switchtec.c              |   2 +-
 drivers/platform/x86/wmi.c                  |   2 +-
 drivers/rpmsg/rpmsg_char.c                  |   4 +-
 drivers/rtc/dev.c                           |  13 +-
 drivers/rtc/rtc-vr41xx.c                    |  10 +
 drivers/s390/char/tape_char.c               |  41 +-
 drivers/sbus/char/display7seg.c             |   2 +-
 drivers/sbus/char/envctrl.c                 |   4 +-
 drivers/scsi/3w-xxxx.c                      |   4 +-
 drivers/scsi/cxlflash/main.c                |   2 +-
 drivers/scsi/esas2r/esas2r_main.c           |   2 +-
 drivers/scsi/megaraid/megaraid_mm.c         |  28 +-
 drivers/scsi/pmcraid.c                      |   4 +-
 drivers/scsi/st.c                           |  28 +-
 drivers/staging/android/ion/ion.c           |   4 +-
 drivers/staging/pi433/pi433_if.c            |  12 +-
 drivers/staging/vme/devices/vme_user.c      |   2 +-
 drivers/tee/tee_core.c                      |   2 +-
 drivers/usb/class/cdc-wdm.c                 |   2 +-
 drivers/usb/class/usbtmc.c                  |   4 +-
 drivers/usb/core/devio.c                    |  16 +-
 drivers/usb/gadget/function/f_fs.c          |  12 +-
 drivers/vfio/vfio.c                         |  39 +-
 drivers/vhost/net.c                         |  12 +-
 drivers/vhost/scsi.c                        |  12 +-
 drivers/vhost/test.c                        |  12 +-
 drivers/vhost/vsock.c                       |  12 +-
 drivers/video/fbdev/aty/atyfb_base.c        |  12 +-
 drivers/virt/fsl_hypervisor.c               |   2 +-
 fs/btrfs/super.c                            |   2 +-
 fs/ceph/dir.c                               |   1 +
 fs/ceph/file.c                              |   2 +-
 fs/ceph/super.h                             |   1 +
 fs/compat_ioctl.c                           | 567 +-------------------
 fs/fat/file.c                               |  13 +-
 fs/fuse/dev.c                               |   2 +-
 fs/ioctl.c                                  |  80 ++-
 fs/notify/fanotify/fanotify_user.c          |   2 +-
 fs/userfaultfd.c                            |   2 +-
 include/linux/falloc.h                      |  20 +
 include/linux/fs.h                          |   7 +
 include/linux/if_pppox.h                    |   3 +
 include/linux/mtio.h                        |  59 ++
 net/bluetooth/hci_sock.c                    |  21 +-
 net/bluetooth/rfcomm/sock.c                 |  14 +-
 net/l2tp/l2tp_ppp.c                         |   3 +
 net/rfkill/core.c                           |   2 +-
 sound/core/oss/pcm_oss.c                    |   4 +
 sound/oss/dmasound/dmasound_core.c          |   2 +
 80 files changed, 434 insertions(+), 953 deletions(-)
 create mode 100644 include/linux/mtio.h

-- 
2.20.0

