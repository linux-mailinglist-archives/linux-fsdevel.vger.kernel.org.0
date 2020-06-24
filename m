Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FFE207916
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404987AbgFXQ31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404975AbgFXQ3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:29:22 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46C8C061573;
        Wed, 24 Jun 2020 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RAJIFgEUAXZN1sNPKsmj9FyojCagKg94zBqkjXc/7xE=; b=oPRZ3gSH0GP45kAplufgi9JD/V
        4pPG3+bvlIterGN7uIJGXnOS87OlCprHE3e3MoQeqAtbu/vIcmk5pkOqRldebZrCZzxTij3HNsh9I
        f54GjOJArEoneDC6FIIrkAayvEuK6ql3aWdjI4wiavzElen959HVzKqmKa1WBmPDD9tV/C83qLcLF
        nm3/1kOj0fuzFoifGP7zX1e12eT6CLcB1nFZatw6twePMVwQAegXL54ZUbJrnJkHDgUtdAQpP8d6R
        spP52TvIAE0npCv4aInA35JqPz6seUSblg/3fJVle2HU8Lgg+nx/rBQLeX9MoWGESVxZXPv4yy7SE
        7Uba1igg==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo8Gk-0006nh-HM; Wed, 24 Jun 2020 16:29:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC] stop using ->read and ->write for kernel access
Date:   Wed, 24 Jun 2020 18:28:50 +0200
Message-Id: <20200624162901.1814136-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al and Linus,

as part of removing set_fs entirely (for which I have a working
prototype), we need to stop calling ->read and ->write with kernel
pointers under set_fs.

My previous "clean up kernel_{read,write} & friends v5" series, on which
this one builds, consolidate those calls into the __ḵernel_{read,write}
helpers.  This series goes further and removes the option to call
->read and ->write with kernel pointers entirely.  The replacement
options are either the existing ->read_iter and ->write_iter methods
which cope with kvecs and kernel pointers just fine and are used by
many instances including all the "real" file systems.  For for other
files like devices they are not suitable.  Fortunately we don't really
do pure kernel reads and writes to any of those.  Traditionally the only
real exception has been splice, which could be used every file for the
last few years, although initially it was optional.

So in addition to some more cleanup like moving the seq_file code to
the iter interface this series introduces a new uptr_t type for a
"universal" pointer that can point to either user or kernel memory
in a properly tagged way, and then adds new read_uptr an write_uptr
ops based on that.  It then converts over the sysctl code as 5.8 added
new code that actually does a kernel_write to it.  Any driver that really
wants splice to work can also be converted over to it, although I haven't
run into one yet.

A git branch is available here:

    git://git.infradead.org/users/hch/misc.git uptr

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/uptr

Diffstat:
 Documentation/filesystems/seq_file.rst                            |    2 
 Documentation/process/clang-format.rst                            |    4 
 Documentation/translations/it_IT/process/clang-format.rst         |    4 
 arch/alpha/kernel/srm_env.c                                       |    2 
 arch/arm/mm/alignment.c                                           |    2 
 arch/arm/mm/ptdump_debugfs.c                                      |    2 
 arch/arm64/kvm/vgic/vgic-debug.c                                  |    2 
 arch/c6x/platforms/pll.c                                          |    2 
 arch/mips/cavium-octeon/oct_ilm.c                                 |    2 
 arch/mips/kernel/segment.c                                        |    2 
 arch/mips/ralink/bootrom.c                                        |    2 
 arch/powerpc/kernel/rtas-proc.c                                   |   10 -
 arch/powerpc/kvm/book3s_xive_native.c                             |    2 
 arch/powerpc/kvm/timing.c                                         |    2 
 arch/powerpc/mm/numa.c                                            |    2 
 arch/powerpc/mm/ptdump/bats.c                                     |    2 
 arch/powerpc/mm/ptdump/hashpagetable.c                            |    2 
 arch/powerpc/mm/ptdump/ptdump.c                                   |    2 
 arch/powerpc/mm/ptdump/segment_regs.c                             |    2 
 arch/powerpc/platforms/cell/spufs/file.c                          |    8 -
 arch/powerpc/platforms/pseries/hvCall_inst.c                      |    2 
 arch/powerpc/platforms/pseries/lpar.c                             |    4 
 arch/powerpc/platforms/pseries/lparcfg.c                          |    2 
 arch/s390/kernel/diag.c                                           |    2 
 arch/s390/mm/dump_pagetables.c                                    |    2 
 arch/s390/pci/pci_debug.c                                         |    2 
 arch/sh/mm/alignment.c                                            |    2 
 arch/sh/mm/asids-debugfs.c                                        |    2 
 arch/sh/mm/cache-debugfs.c                                        |    2 
 arch/sh/mm/pmb.c                                                  |    2 
 arch/sh/mm/tlb-debugfs.c                                          |    2 
 arch/sparc/kernel/led.c                                           |    2 
 arch/um/kernel/exitcode.c                                         |    2 
 arch/um/kernel/process.c                                          |    2 
 arch/x86/kernel/cpu/mce/severity.c                                |    2 
 arch/x86/kernel/cpu/mtrr/if.c                                     |    2 
 arch/x86/mm/pat/memtype.c                                         |    2 
 arch/x86/mm/pat/set_memory.c                                      |    2 
 arch/x86/platform/uv/tlb_uv.c                                     |    2 
 arch/x86/xen/p2m.c                                                |    2 
 block/blk-mq-debugfs.c                                            |    2 
 drivers/acpi/battery.c                                            |    2 
 drivers/acpi/proc.c                                               |    2 
 drivers/base/power/wakeup.c                                       |    2 
 drivers/block/aoe/aoeblk.c                                        |    2 
 drivers/block/drbd/drbd_debugfs.c                                 |   10 -
 drivers/block/nbd.c                                               |    4 
 drivers/block/pktcdvd.c                                           |    2 
 drivers/block/rsxx/core.c                                         |    4 
 drivers/bus/mvebu-mbus.c                                          |    4 
 drivers/char/tpm/eventlog/common.c                                |    2 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c                 |    2 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c                 |    2 
 drivers/crypto/amlogic/amlogic-gxl-core.c                         |    2 
 drivers/crypto/caam/dpseci-debugfs.c                              |    2 
 drivers/crypto/cavium/zip/zip_main.c                              |    6 
 drivers/crypto/hisilicon/qm.c                                     |    2 
 drivers/crypto/qat/qat_common/adf_cfg.c                           |    2 
 drivers/crypto/qat/qat_common/adf_transport_debug.c               |    4 
 drivers/firmware/tegra/bpmp-debugfs.c                             |    2 
 drivers/gpio/gpiolib.c                                            |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c                          |    4 
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c                   |    2 
 drivers/gpu/drm/arm/malidp_drv.c                                  |    2 
 drivers/gpu/drm/armada/armada_debugfs.c                           |    2 
 drivers/gpu/drm/drm_debugfs.c                                     |    6 
 drivers/gpu/drm/drm_debugfs_crc.c                                 |    2 
 drivers/gpu/drm/drm_mipi_dbi.c                                    |    2 
 drivers/gpu/drm/i915/display/intel_display_debugfs.c              |   16 +-
 drivers/gpu/drm/i915/gt/debugfs_gt.h                              |    2 
 drivers/gpu/drm/i915/i915_debugfs_params.c                        |   12 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c                      |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                          |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                       |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                           |    4 
 drivers/gpu/drm/msm/msm_debugfs.c                                 |    2 
 drivers/gpu/drm/nouveau/nouveau_debugfs.c                         |    2 
 drivers/gpu/drm/omapdrm/dss/dss.c                                 |    2 
 drivers/gpu/host1x/debug.c                                        |    4 
 drivers/gpu/vga/vga_switcheroo.c                                  |    2 
 drivers/hid/hid-picolcd_debugfs.c                                 |    2 
 drivers/hid/hid-wiimote-debug.c                                   |    2 
 drivers/hwmon/dell-smm-hwmon.c                                    |    2 
 drivers/ide/ide-proc.c                                            |    4 
 drivers/infiniband/hw/cxgb4/device.c                              |    4 
 drivers/infiniband/hw/qib/qib_debugfs.c                           |    2 
 drivers/infiniband/ulp/ipoib/ipoib_fs.c                           |    4 
 drivers/input/input.c                                             |    4 
 drivers/macintosh/via-pmu.c                                       |    2 
 drivers/md/bcache/closure.c                                       |    2 
 drivers/md/md.c                                                   |    2 
 drivers/media/cec/core/cec-core.c                                 |    2 
 drivers/media/pci/saa7164/saa7164-core.c                          |    2 
 drivers/memory/emif.c                                             |    4 
 drivers/memory/tegra/tegra124-emc.c                               |    2 
 drivers/memory/tegra/tegra186-emc.c                               |    2 
 drivers/memory/tegra/tegra20-emc.c                                |    2 
 drivers/memory/tegra/tegra30-emc.c                                |    2 
 drivers/mfd/ab3100-core.c                                         |    2 
 drivers/mfd/ab3100-otp.c                                          |    2 
 drivers/mfd/ab8500-debugfs.c                                      |   14 -
 drivers/mfd/tps65010.c                                            |    2 
 drivers/misc/habanalabs/debugfs.c                                 |    2 
 drivers/misc/sgi-gru/gruprocfs.c                                  |    6 
 drivers/mmc/core/mmc_test.c                                       |    2 
 drivers/mtd/mtdcore.c                                             |    4 
 drivers/mtd/ubi/debug.c                                           |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c                |   38 ++---
 drivers/net/ethernet/chelsio/cxgb4/l2t.c                          |    2 
 drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c               |    8 -
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c          |    6 
 drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c                  |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c           |    2 
 drivers/net/wireless/ath/ath5k/debug.c                            |    2 
 drivers/net/wireless/ath/wil6210/debugfs.c                        |   14 -
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c          |    2 
 drivers/net/wireless/intel/ipw2x00/libipw_module.c                |    2 
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c                   |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                   |    2 
 drivers/net/wireless/intersil/hostap/hostap_download.c            |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c               |    2 
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c               |    2 
 drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c              |    4 
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               |    4 
 drivers/net/wireless/mediatek/mt7601u/debugfs.c                   |    4 
 drivers/net/wireless/realtek/rtlwifi/debug.c                      |    2 
 drivers/net/wireless/realtek/rtw88/debug.c                        |    4 
 drivers/net/wireless/rsi/rsi_91x_debugfs.c                        |    4 
 drivers/net/xen-netback/xenbus.c                                  |    2 
 drivers/nvme/host/fabrics.c                                       |    2 
 drivers/parisc/led.c                                              |    2 
 drivers/pci/controller/pci-tegra.c                                |    2 
 drivers/platform/x86/asus-wmi.c                                   |    2 
 drivers/platform/x86/intel_pmc_core.c                             |    2 
 drivers/platform/x86/intel_telemetry_debugfs.c                    |    4 
 drivers/platform/x86/thinkpad_acpi.c                              |    2 
 drivers/platform/x86/toshiba_acpi.c                               |    8 -
 drivers/pnp/pnpbios/proc.c                                        |    2 
 drivers/power/supply/da9030_battery.c                             |    2 
 drivers/pwm/core.c                                                |    2 
 drivers/ras/cec.c                                                 |    2 
 drivers/ras/debugfs.c                                             |    2 
 drivers/s390/block/dasd.c                                         |    2 
 drivers/s390/block/dasd_proc.c                                    |    2 
 drivers/s390/cio/blacklist.c                                      |    2 
 drivers/s390/cio/qdio_debug.c                                     |    2 
 drivers/scsi/hisi_sas/hisi_sas_main.c                             |   32 ++--
 drivers/scsi/qedf/qedf_dbg.h                                      |    2 
 drivers/scsi/qedi/qedi_dbg.h                                      |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                    |   12 -
 drivers/scsi/scsi_devinfo.c                                       |    2 
 drivers/scsi/scsi_proc.c                                          |    4 
 drivers/scsi/sg.c                                                 |    4 
 drivers/scsi/snic/snic_debugfs.c                                  |    4 
 drivers/sh/intc/virq-debugfs.c                                    |    2 
 drivers/soc/qcom/cmd-db.c                                         |    2 
 drivers/soc/qcom/socinfo.c                                        |    4 
 drivers/soc/ti/knav_dma.c                                         |    2 
 drivers/soc/ti/knav_qmss_queue.c                                  |    2 
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c             |    2 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c |    4 
 drivers/usb/chipidea/debug.c                                      |    4 
 drivers/usb/dwc2/debugfs.c                                        |    2 
 drivers/usb/dwc3/debugfs.c                                        |    8 -
 drivers/usb/gadget/function/rndis.c                               |    2 
 drivers/usb/gadget/udc/lpc32xx_udc.c                              |    2 
 drivers/usb/gadget/udc/renesas_usb3.c                             |    2 
 drivers/usb/host/xhci-debugfs.c                                   |    6 
 drivers/usb/mtu3/mtu3_debugfs.c                                   |    8 -
 drivers/usb/musb/musb_debugfs.c                                   |    4 
 drivers/video/fbdev/via/viafbdev.c                                |   14 -
 drivers/visorbus/visorbus_main.c                                  |    2 
 drivers/xen/xenfs/xensyms.c                                       |    2 
 fs/cifs/cifs_debug.c                                              |   14 -
 fs/cifs/dfs_cache.c                                               |    2 
 fs/debugfs/file.c                                                 |    4 
 fs/dlm/debug_fs.c                                                 |    8 -
 fs/file_table.c                                                   |    7 
 fs/fscache/object-list.c                                          |    2 
 fs/gfs2/glock.c                                                   |    6 
 fs/internal.h                                                     |   10 +
 fs/jbd2/journal.c                                                 |    2 
 fs/jfs/jfs_debug.c                                                |    2 
 fs/nfsd/nfs4state.c                                               |    4 
 fs/nfsd/nfsctl.c                                                  |   12 -
 fs/nfsd/stats.c                                                   |    2 
 fs/ocfs2/cluster/netdebug.c                                       |    6 
 fs/ocfs2/dlm/dlmdebug.c                                           |    2 
 fs/ocfs2/dlmglue.c                                                |    2 
 fs/open.c                                                         |    8 -
 fs/openpromfs/inode.c                                             |    2 
 fs/orangefs/orangefs-debugfs.c                                    |    2 
 fs/proc/array.c                                                   |    2 
 fs/proc/base.c                                                    |   24 +--
 fs/proc/cpuinfo.c                                                 |    2 
 fs/proc/fd.c                                                      |    2 
 fs/proc/generic.c                                                 |    4 
 fs/proc/inode.c                                                   |   28 +++
 fs/proc/proc_net.c                                                |    4 
 fs/proc/proc_sysctl.c                                             |   41 +++--
 fs/proc/stat.c                                                    |    2 
 fs/proc/task_mmu.c                                                |    8 -
 fs/proc/task_nommu.c                                              |    2 
 fs/proc_namespace.c                                               |    6 
 fs/read_write.c                                                   |   49 ++++--
 fs/seq_file.c                                                     |   34 ++--
 fs/splice.c                                                       |   40 +++--
 include/linux/fs.h                                                |   10 +
 include/linux/proc_fs.h                                           |    1 
 include/linux/seq_file.h                                          |    7 
 include/linux/uptr.h                                              |   72 ++++++++++
 ipc/util.c                                                        |    2 
 kernel/bpf/inode.c                                                |    2 
 kernel/fail_function.c                                            |    2 
 kernel/gcov/fs.c                                                  |    2 
 kernel/irq/debugfs.c                                              |    2 
 kernel/irq/proc.c                                                 |    6 
 kernel/kallsyms.c                                                 |    2 
 kernel/kcsan/debugfs.c                                            |    2 
 kernel/latencytop.c                                               |    2 
 kernel/locking/lockdep_proc.c                                     |    2 
 kernel/module.c                                                   |    2 
 kernel/profile.c                                                  |    2 
 kernel/sched/debug.c                                              |    2 
 kernel/sched/psi.c                                                |    6 
 kernel/time/test_udelay.c                                         |    2 
 kernel/trace/ftrace.c                                             |   16 +-
 kernel/trace/trace.c                                              |   20 +-
 kernel/trace/trace_dynevent.c                                     |    2 
 kernel/trace/trace_events.c                                       |   10 -
 kernel/trace/trace_events_hist.c                                  |    4 
 kernel/trace/trace_events_synth.c                                 |    2 
 kernel/trace/trace_events_trigger.c                               |    2 
 kernel/trace/trace_kprobe.c                                       |    4 
 kernel/trace/trace_printk.c                                       |    2 
 kernel/trace/trace_stack.c                                        |    4 
 kernel/trace/trace_stat.c                                         |    2 
 kernel/trace/trace_uprobe.c                                       |    4 
 lib/debugobjects.c                                                |    2 
 lib/dynamic_debug.c                                               |    4 
 lib/error-inject.c                                                |    2 
 lib/kunit/debugfs.c                                               |    2 
 mm/kmemleak.c                                                     |    2 
 mm/slab_common.c                                                  |    2 
 mm/swapfile.c                                                     |    2 
 net/6lowpan/debugfs.c                                             |    2 
 net/atm/mpoa_proc.c                                               |    2 
 net/batman-adv/debugfs.c                                          |    4 
 net/bluetooth/6lowpan.c                                           |    2 
 net/core/pktgen.c                                                 |    6 
 net/hsr/hsr_debugfs.c                                             |    2 
 net/ipv4/netfilter/ipt_CLUSTERIP.c                                |    2 
 net/ipv4/route.c                                                  |    4 
 net/l2tp/l2tp_debugfs.c                                           |    2 
 net/netfilter/xt_recent.c                                         |    2 
 net/sunrpc/cache.c                                                |    4 
 net/sunrpc/debugfs.c                                              |    4 
 net/sunrpc/rpc_pipe.c                                             |    2 
 net/sunrpc/stats.c                                                |    2 
 security/apparmor/apparmorfs.c                                    |   10 -
 security/integrity/ima/ima_fs.c                                   |    6 
 security/selinux/selinuxfs.c                                      |    2 
 security/smack/smackfs.c                                          |   20 +-
 sound/core/info.c                                                 |    2 
 264 files changed, 700 insertions(+), 549 deletions(-)
