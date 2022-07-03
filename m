Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9DE5648EE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 20:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiGCSR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 14:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiGCSRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19B7F6273
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Jul 2022 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656872269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lcoCOTNI/c2xMDQPP9RujhixREWIYemMGEf8/CcX3xg=;
        b=XAnKg4FsILJAnnnXwgzDMZlv9/0xzyWixml7f1oCkOQwuaXTmy/E42gzdXE0oFqQ58BkZb
        yUgAKkEgT+b/fCyPav9lGejY7R7qLJBzhPY9WmxZpCe14HGwp/Yi1P+6BMIkboLr358aJF
        BOXmRYKTx00vwDdAjibz1d2B/4YQp9E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-Xh0d7RAMNq25dIDTpI-RTA-1; Sun, 03 Jul 2022 14:17:47 -0400
X-MC-Unique: Xh0d7RAMNq25dIDTpI-RTA-1
Received: by mail-ej1-f69.google.com with SMTP id z7-20020a170906434700b007108b59c212so1425696ejm.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Jul 2022 11:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lcoCOTNI/c2xMDQPP9RujhixREWIYemMGEf8/CcX3xg=;
        b=6m91+A79zXZNFOWnSHyLaKJC6zMPRdthLLd77ZgW2nU37OSMXv3D2RlUvpqlQwBdt8
         cMNJbTBi2THwAz57pE/QFYlNfb/7dfmHHyYYk/XaWKmwtv9xoLbaBoYIMafxj9dkamm/
         pFd0IkccjG96/InhzJIcHn+W4Z0QBij65d/giU2hm0Sj+dNA+PH82QR4s3m4hCLRJeGa
         dRo7ZybiSslhCOTcVB5xKMexyhEfT1W7Ql+fOxMiCOg35P5Qqhm+MKZYjAycRvOur2G1
         pKfN7MecZUOdNNzXxhZFSsKe4xRrpI20wSD9crw838CMrS/tKEKvoubAtU20LYauzhDN
         49zQ==
X-Gm-Message-State: AJIora+SyiLmZgL654hfH8Ka5eroQfjTh3OlY+isWkTxf+yHHA7JAcje
        cvuWz6UksX1r3asdWQiQyVhJJ+VadyOQ5Onm32qGhu3y+fwA9ReX2NXLyyp2moKMT5HWOfW+bMt
        DVgaylDEO89F1O7rCOne28VXkAw==
X-Received: by 2002:a05:6402:452:b0:434:a373:f9f8 with SMTP id p18-20020a056402045200b00434a373f9f8mr33637400edw.290.1656872265121;
        Sun, 03 Jul 2022 11:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tJKZXqd9iqETO+4UvGJNNjm+dMKL1fPBWAKkarcKXTG5eh0CvAXQpdvzTPL/jCdqHugxHJMA==
X-Received: by 2002:a05:6402:452:b0:434:a373:f9f8 with SMTP id p18-20020a056402045200b00434a373f9f8mr33637341edw.290.1656872264299;
        Sun, 03 Jul 2022 11:17:44 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b0042617ba638esm18959371edt.24.2022.07.03.11.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:17:43 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 1/2] treewide: idr: align IDR and IDA APIs
Date:   Sun,  3 Jul 2022 20:17:38 +0200
Message-Id: <20220703181739.387584-1-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For allocating IDs the ID allocator (IDA) provides the following
functions: ida_alloc(), ida_alloc_range(), ida_alloc_min() and
ida_alloc_max() whereas for IDRs only idr_alloc() is available.

In contrast to ida_alloc(), idr_alloc() behaves like ida_alloc_range(),
which takes MIN and MAX arguments to define the bounds within an ID
should be allocated - ida_alloc() instead implicitly uses the maximal
bounds possible for MIN and MAX without taking those arguments.

In order to align the IDR and IDA APIs this patch provides
implementations for idr_alloc(), idr_alloc_range(), idr_alloc_min() and
idr_alloc_max(), which are analogue to the IDA API.

As a result of this change users of the original idr_alloc() function
must adjust to the new API.

The original idr_alloc() occurs 182 times. This patch converts them to

idr_alloc()		37 times
idr_alloc_range()	63 times
idr_alloc_min()		42 times
idr_alloc_max()		40 times

which shows that just ~1/3 of the callers need the full set of
arguments and therefore ~2/3 of the calls can be simplified.

In order to do this conversion the following script was used:

```
	#!/bin/bash

	REGEX_SYM="[][()0-9a-zA-Z&>_\*\.\-]"

	REGEX_GREP_BASE="idr_alloc_range\(${REGEX_SYM}{1,}[, ]{1,}${REGEX_SYM}{1,}"
	REGEX_GREP_RANGE="${REGEX_GREP_BASE}[, ]{1,}0[, ]{1,}0"
	REGEX_GREP_MIN="${REGEX_GREP_BASE}[, ]{1,}${REGEX_SYM}{1,}[, ]{1,}0"
	REGEX_GREP_MAX="${REGEX_GREP_BASE}[, ]{1,}0[, ]{1,}${REGEX_SYM}{1,}"

	REGEX_SED_BASE="s/idr_alloc_range(\(${REGEX_SYM}\{1,\}[, ]\{1,\}${REGEX_SYM}\{1,\}\)"
	REGEX_SED_RANGE="${REGEX_SED_BASE}[, ]\{1,\}0[, ]\{1,\}0/idr_alloc(\1/g"
	REGEX_SED_MIN="${REGEX_SED_BASE}\([, ]\{1,\}${REGEX_SYM}\{1,\}\)[, ]\{1,\}0/idr_alloc_min(\1\2/g"
	REGEX_SED_MAX="${REGEX_SED_BASE}[, ]\{1,\}0\([, ]\{1,\}${REGEX_SYM}\{1,\}\)/idr_alloc_max(\1\2/g"

	# Replace all occurences of idr_alloc() with idr_alloc_range()
	for ff in $(grep -REHli "idr_alloc\(" --exclude-dir=include --exclude-dir=lib --exclude-dir=Documentation)
	do
		sed -i 's/idr_alloc(/idr_alloc_range(/g' $ff
	done

	# Find all occurences of idr_alloc_range() where @start and @end are 0, replace
	# it with idr_alloc() and remove @start and @end parameters.
	for ff in $(grep -REHli "${REGEX_GREP_RANGE}")
	do
		sed -i "$REGEX_SED_RANGE" $ff
	done

	# Find all occurences of idr_alloc_range() where only @end is 0, replace it
	# with idr_alloc_min() and remove the @end parameter.
	for ff in $(grep -REHli "${REGEX_GREP_MIN}")
	do
		sed -i "$REGEX_SED_MIN" $ff
	done

	# Find all occurences of idr_alloc_range() where only @start is 0, replace it
	# with idr_alloc_max() and remove the @start parameter.
	for ff in $(grep -REHli "${REGEX_GREP_MAX}")
	do
		sed -i "$REGEX_SED_MAX" $ff
	done
```

Statements spanning multiple lines as well as indentation were done by
hand.

This patch was compile-time tested building a x86_64 kernel with
`make allyesconfig'.

Additionally, idr-test from tools/testing/radix-tree/ completed
successfully:

	vvv Ignore these warnings
	assertion failed at idr.c:269
	assertion failed at idr.c:206
	^^^ Warnings over
	IDA: 75339420 of 75339420 tests passed

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
This patch is based on Linus' master branch, there is one known conflict with
next/master in file drivers/net/ethernet/mellanox/mlxsw/spectrum_pgt.c which
introduces another usage of the old idr_alloc().
---
 arch/powerpc/kvm/book3s_hv_nested.c           |  4 +-
 arch/x86/kvm/hyperv.c                         |  4 +-
 arch/x86/kvm/xen.c                            |  4 +-
 drivers/atm/nicstar.c                         |  4 +-
 drivers/block/drbd/drbd_main.c                |  7 +-
 drivers/block/loop.c                          |  4 +-
 drivers/block/nbd.c                           |  6 +-
 drivers/block/zram/zram_drv.c                 |  2 +-
 drivers/char/tpm/tpm-chip.c                   |  2 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c   |  2 +-
 drivers/dca/dca-sysfs.c                       |  2 +-
 drivers/firewire/core-cdev.c                  |  2 +-
 drivers/firewire/core-device.c                |  4 +-
 drivers/firmware/arm_scmi/bus.c               |  4 +-
 drivers/firmware/arm_scmi/driver.c            | 16 ++---
 drivers/fpga/dfl.c                            |  2 +-
 drivers/gpio/gpio-aggregator.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 12 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       | 20 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  2 +-
 drivers/gpu/drm/display/drm_dp_aux_dev.c      |  2 +-
 drivers/gpu/drm/drm_auth.c                    |  4 +-
 drivers/gpu/drm/drm_connector.c               |  2 +-
 drivers/gpu/drm/drm_context.c                 |  4 +-
 drivers/gpu/drm/drm_drv.c                     | 10 +--
 drivers/gpu/drm/drm_gem.c                     |  4 +-
 drivers/gpu/drm/drm_lease.c                   |  8 +--
 drivers/gpu/drm/drm_mode_object.c             |  4 +-
 drivers/gpu/drm/drm_syncobj.c                 |  4 +-
 .../drm/i915/gem/selftests/i915_gem_context.c |  4 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c             |  2 +-
 drivers/gpu/drm/i915/gvt/vgpu.c               |  4 +-
 drivers/gpu/drm/i915/i915_perf.c              |  5 +-
 drivers/gpu/drm/i915/selftests/i915_perf.c    |  2 +-
 drivers/gpu/drm/qxl/qxl_cmd.c                 |  2 +-
 drivers/gpu/drm/qxl/qxl_release.c             |  2 +-
 drivers/gpu/drm/sis/sis_mm.c                  |  2 +-
 drivers/gpu/drm/tegra/drm.c                   |  2 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c             |  4 +-
 drivers/gpu/drm/vc4/vc4_perfmon.c             |  4 +-
 drivers/gpu/drm/vgem/vgem_fence.c             |  2 +-
 drivers/gpu/drm/via/via_mm.c                  |  2 +-
 drivers/gpu/drm/vmwgfx/ttm_object.c           |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c      |  2 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
 drivers/i2c/i2c-core-base.c                   |  7 +-
 drivers/i3c/master.c                          |  2 +-
 drivers/interconnect/core.c                   |  2 +-
 drivers/md/dm.c                               |  4 +-
 drivers/memstick/core/memstick.c              |  2 +-
 drivers/memstick/core/ms_block.c              |  2 +-
 drivers/memstick/core/mspro_block.c           |  2 +-
 drivers/misc/c2port/core.c                    |  2 +-
 drivers/misc/cardreader/rtsx_pcr.c            |  2 +-
 drivers/misc/cxl/context.c                    |  4 +-
 drivers/misc/cxl/main.c                       |  2 +-
 .../habanalabs/common/command_submission.c    |  2 +-
 drivers/misc/habanalabs/common/context.c      |  2 +-
 .../misc/habanalabs/common/habanalabs_drv.c   |  6 +-
 drivers/misc/habanalabs/common/memory.c       |  4 +-
 drivers/misc/habanalabs/common/memory_mgr.c   |  2 +-
 drivers/misc/mei/main.c                       |  2 +-
 drivers/misc/ocxl/afu_irq.c                   |  4 +-
 drivers/misc/ocxl/context.c                   |  4 +-
 drivers/misc/ocxl/file.c                      |  2 +-
 drivers/misc/tifm_core.c                      |  2 +-
 drivers/mtd/mtdcore.c                         |  4 +-
 drivers/mtd/ubi/block.c                       |  2 +-
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  4 +-
 .../mellanox/mlxsw/spectrum_policer.c         |  4 +-
 .../ethernet/mellanox/mlxsw/spectrum_router.c |  4 +-
 .../net/ethernet/netronome/nfp/flower/main.c  |  5 +-
 drivers/net/ppp/ppp_generic.c                 |  4 +-
 drivers/net/tap.c                             |  2 +-
 drivers/net/wireless/ath/ath10k/htt_tx.c      |  4 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c     |  5 +-
 drivers/net/wireless/ath/ath11k/dbring.c      |  2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c       | 14 ++--
 drivers/net/wireless/ath/ath11k/dp_tx.c       |  4 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  5 +-
 drivers/net/wireless/marvell/mwifiex/main.c   |  4 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 drivers/net/wireless/mediatek/mt76/tx.c       |  6 +-
 drivers/of/overlay.c                          |  2 +-
 drivers/pci/endpoint/pci-ep-cfs.c             |  2 +-
 drivers/power/supply/bq2415x_charger.c        |  2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c    |  2 +-
 drivers/power/supply/ds2782_battery.c         |  2 +-
 drivers/powercap/powercap_sys.c               |  2 +-
 drivers/pps/pps.c                             |  4 +-
 drivers/ptp/ptp_ocp.c                         |  2 +-
 drivers/remoteproc/remoteproc_core.c          |  2 +-
 drivers/reset/reset-ti-sci.c                  |  2 +-
 drivers/rpmsg/qcom_glink_native.c             |  6 +-
 drivers/rpmsg/virtio_rpmsg_bus.c              |  2 +-
 drivers/scsi/bfa/bfad_im.c                    |  2 +-
 drivers/scsi/ch.c                             |  2 +-
 drivers/scsi/cxlflash/ocxl_hw.c               |  2 +-
 drivers/scsi/lpfc/lpfc_init.c                 |  2 +-
 drivers/scsi/scsi_transport_iscsi.c           |  3 +-
 drivers/scsi/sg.c                             |  2 +-
 drivers/scsi/st.c                             |  2 +-
 drivers/soc/qcom/apr.c                        |  2 +-
 drivers/spi/spi.c                             | 12 ++--
 drivers/staging/greybus/uart.c                |  2 +-
 drivers/staging/pi433/pi433_if.c              |  2 +-
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  3 +-
 drivers/target/iscsi/iscsi_target.c           |  2 +-
 drivers/tee/optee/supp.c                      |  2 +-
 drivers/tee/tee_shm.c                         |  4 +-
 drivers/tty/rpmsg_tty.c                       |  2 +-
 drivers/tty/serial/mps2-uart.c                |  2 +-
 drivers/uio/uio.c                             |  2 +-
 drivers/usb/class/cdc-acm.c                   |  2 +-
 drivers/usb/core/hcd.c                        |  2 +-
 drivers/usb/host/xhci-dbgtty.c                |  2 +-
 drivers/usb/serial/usb-serial.c               |  5 +-
 drivers/vdpa/vdpa_user/vduse_dev.c            |  2 +-
 fs/cifs/cifs_swn.c                            |  2 +-
 fs/dlm/lock.c                                 |  2 +-
 fs/dlm/recover.c                              |  2 +-
 fs/erofs/super.c                              |  4 +-
 fs/nfs/nfs4client.c                           |  2 +-
 fs/ocfs2/cluster/tcp.c                        |  2 +-
 include/linux/idr.h                           | 68 ++++++++++++++++++-
 ipc/util.c                                    |  4 +-
 kernel/cgroup/cgroup.c                        |  2 +-
 kernel/events/core.c                          |  2 +-
 kernel/irq/timings.c                          |  2 +-
 kernel/pid.c                                  |  4 +-
 kernel/workqueue.c                            |  4 +-
 lib/idr.c                                     |  6 +-
 mm/memcontrol.c                               |  4 +-
 mm/vmscan.c                                   |  2 +-
 net/9p/client.c                               |  6 +-
 net/bluetooth/hci_core.c                      |  4 +-
 net/core/net_namespace.c                      |  2 +-
 net/mac80211/cfg.c                            | 10 +--
 net/mac80211/tx.c                             |  4 +-
 net/tipc/topsrv.c                             |  2 +-
 security/apparmor/secid.c                     |  2 +-
 sound/ac97/bus.c                              |  2 +-
 sound/soc/qcom/qdsp6/q6apm.c                  |  2 +-
 sound/soc/qcom/qdsp6/topology.c               |  9 +--
 tools/testing/radix-tree/idr-test.c           | 56 +++++++--------
 148 files changed, 356 insertions(+), 282 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 0644732d1a25..3ebba1512f1f 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -665,8 +665,8 @@ static struct kvm_nested_guest *__find_nested(struct kvm *kvm, int lpid)
 
 static bool __prealloc_nested(struct kvm *kvm, int lpid)
 {
-	if (idr_alloc(&kvm->arch.kvm_nested_guest_idr,
-				NULL, lpid, lpid + 1, GFP_KERNEL) != lpid)
+	if (idr_alloc_range(&kvm->arch.kvm_nested_guest_idr, NULL,
+			    lpid, lpid + 1, GFP_KERNEL) != lpid)
 		return false;
 	return true;
 }
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index e2e95a6fccfd..db762513b596 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2390,8 +2390,8 @@ static int kvm_hv_eventfd_assign(struct kvm *kvm, u32 conn_id, int fd)
 		return PTR_ERR(eventfd);
 
 	mutex_lock(&hv->hv_lock);
-	ret = idr_alloc(&hv->conn_to_evt, eventfd, conn_id, conn_id + 1,
-			GFP_KERNEL_ACCOUNT);
+	ret = idr_alloc_range(&hv->conn_to_evt, eventfd, conn_id, conn_id + 1,
+			      GFP_KERNEL_ACCOUNT);
 	mutex_unlock(&hv->hv_lock);
 
 	if (ret >= 0)
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 610beba35907..186b1c40d919 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1707,8 +1707,8 @@ static int kvm_xen_eventfd_assign(struct kvm *kvm,
 	}
 
 	mutex_lock(&kvm->lock);
-	ret = idr_alloc(&kvm->arch.xen.evtchn_ports, evtchnfd, port, port + 1,
-			GFP_KERNEL);
+	ret = idr_alloc_range(&kvm->arch.xen.evtchn_ports, evtchnfd, port,
+			      port + 1, GFP_KERNEL);
 	mutex_unlock(&kvm->lock);
 	if (ret >= 0)
 		return 0;
diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index 1a50de39f5b5..02f45b1d48cc 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -1016,11 +1016,11 @@ static void push_rxbufs(ns_dev * card, struct sk_buff *skb)
 				card->lbfqc += 2;
 		}
 
-		id1 = idr_alloc(&card->idr, handle1, 0, 0, GFP_ATOMIC);
+		id1 = idr_alloc(&card->idr, handle1, GFP_ATOMIC);
 		if (id1 < 0)
 			goto out;
 
-		id2 = idr_alloc(&card->idr, handle2, 0, 0, GFP_ATOMIC);
+		id2 = idr_alloc(&card->idr, handle2, GFP_ATOMIC);
 		if (id2 < 0)
 			goto out;
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 2887350ae010..2b4d89909d49 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2729,7 +2729,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	device->read_requests = RB_ROOT;
 	device->write_requests = RB_ROOT;
 
-	id = idr_alloc(&drbd_devices, device, minor, minor + 1, GFP_KERNEL);
+	id = idr_alloc_range(&drbd_devices, device, minor, minor + 1, GFP_KERNEL);
 	if (id < 0) {
 		if (id == -ENOSPC)
 			err = ERR_MINOR_OR_VOLUME_EXISTS;
@@ -2737,7 +2737,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	}
 	kref_get(&device->kref);
 
-	id = idr_alloc(&resource->devices, device, vnr, vnr + 1, GFP_KERNEL);
+	id = idr_alloc_range(&resource->devices, device, vnr, vnr + 1, GFP_KERNEL);
 	if (id < 0) {
 		if (id == -ENOSPC)
 			err = ERR_MINOR_OR_VOLUME_EXISTS;
@@ -2757,7 +2757,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 		list_add(&peer_device->peer_devices, &device->peer_devices);
 		kref_get(&device->kref);
 
-		id = idr_alloc(&connection->peer_devices, peer_device, vnr, vnr + 1, GFP_KERNEL);
+		id = idr_alloc_range(&connection->peer_devices, peer_device, vnr, vnr + 1,
+				    GFP_KERNEL);
 		if (id < 0) {
 			if (id == -ENOSPC)
 				err = ERR_INVALID_REQUEST;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 084f9b8a0ba3..6df3d2ed2a2c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1951,11 +1951,11 @@ static int loop_add(int i)
 
 	/* allocate id, if @id >= 0, we're requesting that specific id */
 	if (i >= 0) {
-		err = idr_alloc(&loop_index_idr, lo, i, i + 1, GFP_KERNEL);
+		err = idr_alloc_range(&loop_index_idr, lo, i, i + 1, GFP_KERNEL);
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&loop_index_idr, lo, GFP_KERNEL);
 	}
 	mutex_unlock(&loop_ctl_mutex);
 	if (err < 0)
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 07f3c139a3d7..854d155dff7c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1763,12 +1763,12 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 
 	mutex_lock(&nbd_index_mutex);
 	if (index >= 0) {
-		err = idr_alloc(&nbd_index_idr, nbd, index, index + 1,
-				GFP_KERNEL);
+		err = idr_alloc_range(&nbd_index_idr, nbd, index, index + 1,
+				      GFP_KERNEL);
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&nbd_index_idr, nbd, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&nbd_index_idr, nbd, GFP_KERNEL);
 		if (err >= 0)
 			index = err;
 	}
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b8549c61ff2c..c65efbef323d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1890,7 +1890,7 @@ static int zram_add(void)
 	if (!zram)
 		return -ENOMEM;
 
-	ret = idr_alloc(&zram_index_idr, zram, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&zram_index_idr, zram, GFP_KERNEL);
 	if (ret < 0)
 		goto out_free_dev;
 	device_id = ret;
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 783d65fc71f0..4adc3ea9b7ca 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -326,7 +326,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	chip->ops = ops;
 
 	mutex_lock(&idr_lock);
-	rc = idr_alloc(&dev_nums_idr, NULL, 0, TPM_NUM_DEVICES, GFP_KERNEL);
+	rc = idr_alloc_max(&dev_nums_idr, NULL, TPM_NUM_DEVICES, GFP_KERNEL);
 	mutex_unlock(&idr_lock);
 	if (rc < 0) {
 		dev_err(pdev, "No available tpm device numbers\n");
diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 97d54c1465c2..68d1d5ea5476 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -147,7 +147,7 @@ static int hpre_alloc_req_id(struct hpre_ctx *ctx)
 	int id;
 
 	spin_lock_irqsave(&ctx->req_lock, flags);
-	id = idr_alloc(&ctx->req_idr, NULL, 0, QM_Q_DEPTH, GFP_ATOMIC);
+	id = idr_alloc_max(&ctx->req_idr, NULL, QM_Q_DEPTH, GFP_ATOMIC);
 	spin_unlock_irqrestore(&ctx->req_lock, flags);
 
 	return id;
diff --git a/drivers/dca/dca-sysfs.c b/drivers/dca/dca-sysfs.c
index 21ebd0af268b..c91994ff8a6c 100644
--- a/drivers/dca/dca-sysfs.c
+++ b/drivers/dca/dca-sysfs.c
@@ -40,7 +40,7 @@ int dca_sysfs_add_provider(struct dca_provider *dca, struct device *dev)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&dca_idr_lock);
 
-	ret = idr_alloc(&dca_idr, dca, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(&dca_idr, dca, GFP_NOWAIT);
 	if (ret >= 0)
 		dca->id = ret;
 
diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 9c89f7d53e99..b33201b75898 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -485,7 +485,7 @@ static int add_client_resource(struct client *client,
 	if (client->in_shutdown)
 		ret = -ECANCELED;
 	else
-		ret = idr_alloc(&client->resource_idr, resource, 0, 0,
+		ret = idr_alloc(&client->resource_idr, resource,
 				GFP_NOWAIT);
 	if (ret >= 0) {
 		resource->handle = ret;
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index adddd8c45d0c..5c599658a5d5 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -1024,8 +1024,8 @@ static void fw_device_init(struct work_struct *work)
 
 	fw_device_get(device);
 	down_write(&fw_device_rwsem);
-	minor = idr_alloc(&fw_device_idr, device, 0, 1 << MINORBITS,
-			GFP_KERNEL);
+	minor = idr_alloc_max(&fw_device_idr, device, 1 << MINORBITS,
+			      GFP_KERNEL);
 	up_write(&fw_device_rwsem);
 
 	if (minor < 0)
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index f6fe723ab869..dfb867958a46 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -236,8 +236,8 @@ int scmi_protocol_register(const struct scmi_protocol *proto)
 	}
 
 	spin_lock(&protocol_lock);
-	ret = idr_alloc(&scmi_protocols, (void *)proto,
-			proto->id, proto->id + 1, GFP_ATOMIC);
+	ret = idr_alloc_range(&scmi_protocols, (void *)proto,
+			      proto->id, proto->id + 1, GFP_ATOMIC);
 	spin_unlock(&protocol_lock);
 	if (ret != proto->id) {
 		pr_err("unable to allocate SCMI idr slot for 0x%x - err %d\n",
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c1922bd650ae..a8f1996de7c8 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1333,8 +1333,8 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	if (ret)
 		goto clean;
 
-	ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1,
-			GFP_KERNEL);
+	ret = idr_alloc_range(&info->protocols, pi, proto->id, proto->id + 1,
+			      GFP_KERNEL);
 	if (ret != proto->id)
 		goto clean;
 
@@ -1798,7 +1798,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
 	}
 
 idr_alloc:
-	ret = idr_alloc(idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL);
+	ret = idr_alloc_range(idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL);
 	if (ret != prot_id) {
 		dev_err(dev, "unable to allocate SCMI idr slot err %d\n", ret);
 		return ret;
@@ -1992,9 +1992,9 @@ int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 		}
 		INIT_LIST_HEAD(phead);
 
-		ret = idr_alloc(&scmi_requested_devices, (void *)phead,
-				id_table->protocol_id,
-				id_table->protocol_id + 1, GFP_KERNEL);
+		ret = idr_alloc_range(&scmi_requested_devices, (void *)phead,
+				      id_table->protocol_id,
+				      id_table->protocol_id + 1, GFP_KERNEL);
 		if (ret != id_table->protocol_id) {
 			pr_err("Failed to save SCMI device - ret:%d\n", ret);
 			kfree(rdev);
@@ -2197,8 +2197,8 @@ static int scmi_probe(struct platform_device *pdev)
 		 * Save this valid DT protocol descriptor amongst
 		 * @active_protocols for this SCMI instance/
 		 */
-		ret = idr_alloc(&info->active_protocols, child,
-				prot_id, prot_id + 1, GFP_KERNEL);
+		ret = idr_alloc_range(&info->active_protocols, child,
+				      prot_id, prot_id + 1, GFP_KERNEL);
 		if (ret != prot_id) {
 			dev_err(dev, "SCMI protocol %d already activated. Skip\n",
 				prot_id);
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 6bff39ff21a0..68fcb7f55046 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -104,7 +104,7 @@ static int dfl_id_alloc(enum dfl_id_type type, struct device *dev)
 
 	WARN_ON(type >= DFL_ID_MAX);
 	mutex_lock(&dfl_id_mutex);
-	id = idr_alloc(&dfl_devs[type].id, dev, 0, 0, GFP_KERNEL);
+	id = idr_alloc(&dfl_devs[type].id, dev, GFP_KERNEL);
 	mutex_unlock(&dfl_id_mutex);
 
 	return id;
diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 0cb2664085cf..672e9c5ac9c7 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -131,7 +131,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	}
 
 	mutex_lock(&gpio_aggregator_lock);
-	id = idr_alloc(&gpio_aggregator_idr, aggr, 0, 0, GFP_KERNEL);
+	id = idr_alloc(&gpio_aggregator_idr, aggr, GFP_KERNEL);
 	mutex_unlock(&gpio_aggregator_lock);
 
 	if (id < 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 714178f1b6c6..543c2d728855 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -285,7 +285,7 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
 			goto error_free;
 
 		mutex_lock(&fpriv->bo_list_lock);
-		r = idr_alloc(&fpriv->bo_list_handles, list, 1, 0, GFP_KERNEL);
+		r = idr_alloc_min(&fpriv->bo_list_handles, list, 1, GFP_KERNEL);
 		mutex_unlock(&fpriv->bo_list_lock);
 		if (r < 0) {
 			goto error_put_list;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 7dc92ef36b2b..88abbc02c858 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -450,7 +450,7 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
 		return -ENOMEM;
 
 	mutex_lock(&mgr->lock);
-	r = idr_alloc(&mgr->ctx_handles, ctx, 1, AMDGPU_VM_MAX_NUM_CTX, GFP_KERNEL);
+	r = idr_alloc_range(&mgr->ctx_handles, ctx, 1, AMDGPU_VM_MAX_NUM_CTX, GFP_KERNEL);
 	if (r < 0) {
 		mutex_unlock(&mgr->lock);
 		kfree(ctx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 69a70a0aaed9..0912709a1dae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -274,8 +274,8 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 	amdgpu_mes_lock(&adev->mes);
 
 	/* add the mes process to idr list */
-	r = idr_alloc(&adev->mes.pasid_idr, process, pasid, pasid + 1,
-		      GFP_KERNEL);
+	r = idr_alloc_range(&adev->mes.pasid_idr, process, pasid, pasid + 1,
+			    GFP_KERNEL);
 	if (r < 0) {
 		DRM_ERROR("failed to lock pasid=%d\n", pasid);
 		goto clean_up_ctx;
@@ -419,8 +419,8 @@ int amdgpu_mes_add_gang(struct amdgpu_device *adev, int pasid,
 	}
 
 	/* add the mes gang to idr list */
-	r = idr_alloc(&adev->mes.gang_id_idr, gang, 1, 0,
-		      GFP_KERNEL);
+	r = idr_alloc_min(&adev->mes.gang_id_idr, gang, 1,
+			  GFP_KERNEL);
 	if (r < 0) {
 		DRM_ERROR("failed to allocate idr for gang\n");
 		goto clean_up_ctx;
@@ -637,8 +637,8 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 
 	/* add the mes gang to idr list */
 	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
-	r = idr_alloc(&adev->mes.queue_id_idr, queue, 1, 0,
-		      GFP_ATOMIC);
+	r = idr_alloc_min(&adev->mes.queue_id_idr, queue, 1,
+			  GFP_ATOMIC);
 	if (r < 0) {
 		spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
 		goto clean_up_mqd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1c7016958d6d..b1249855bab0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2127,8 +2127,8 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 
 	/* Restore previous IDR handle */
 	pr_debug("Restoring old IDR handle for the BO");
-	idr_handle = idr_alloc(&pdd->alloc_idr, *kgd_mem, bo_priv->idr_handle,
-			       bo_priv->idr_handle + 1, GFP_KERNEL);
+	idr_handle = idr_alloc_range(&pdd->alloc_idr, *kgd_mem, bo_priv->idr_handle,
+				     bo_priv->idr_handle + 1, GFP_KERNEL);
 
 	if (idr_handle < 0) {
 		pr_err("Could not allocate idr\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 4df9c36146ba..672ede6bc763 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -106,8 +106,8 @@ static int allocate_event_notification_slot(struct kfd_process *p,
 	}
 
 	if (restore_id) {
-		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
-				GFP_KERNEL);
+		id = idr_alloc_range(&p->event_idr, ev, *restore_id, *restore_id + 1,
+				     GFP_KERNEL);
 	} else {
 		/*
 		 * Compatibility with old user mode: Only use signal slots
@@ -115,8 +115,8 @@ static int allocate_event_notification_slot(struct kfd_process *p,
 		 * KFD_SIGNAL_EVENT_LIMIT. This also allows future increase
 		 * of the event limit without breaking user mode.
 		 */
-		id = idr_alloc(&p->event_idr, ev, 0, p->signal_mapped_size / 8,
-				GFP_KERNEL);
+		id = idr_alloc_max(&p->event_idr, ev, p->signal_mapped_size / 8,
+				   GFP_KERNEL);
 	}
 	if (id < 0)
 		return id;
@@ -219,17 +219,17 @@ static int create_other_event(struct kfd_process *p, struct kfd_event *ev, const
 	int id;
 
 	if (restore_id)
-		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
-			GFP_KERNEL);
+		id = idr_alloc_range(&p->event_idr, ev, *restore_id, *restore_id + 1,
+				     GFP_KERNEL);
 	else
 		/* Cast KFD_LAST_NONSIGNAL_EVENT to uint32_t. This allows an
 		 * intentional integer overflow to -1 without a compiler
 		 * warning. idr_alloc treats a negative value as "maximum
 		 * signed integer".
 		 */
-		id = idr_alloc(&p->event_idr, ev, KFD_FIRST_NONSIGNAL_EVENT_ID,
-				(uint32_t)KFD_LAST_NONSIGNAL_EVENT_ID + 1,
-				GFP_KERNEL);
+		id = idr_alloc_range(&p->event_idr, ev, KFD_FIRST_NONSIGNAL_EVENT_ID,
+				     (uint32_t)KFD_LAST_NONSIGNAL_EVENT_ID + 1,
+				     GFP_KERNEL);
 
 	if (id < 0)
 		return id;
@@ -249,7 +249,7 @@ int kfd_event_init_process(struct kfd_process *p)
 	/* Allocate event ID 0. It is used for a fast path to ignore bogus events
 	 * that are sent by the CP without a context ID
 	 */
-	id = idr_alloc(&p->event_idr, NULL, 0, 1, GFP_KERNEL);
+	id = idr_alloc_max(&p->event_idr, NULL, 1, GFP_KERNEL);
 	if (id < 0) {
 		idr_destroy(&p->event_idr);
 		mutex_destroy(&p->event_mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e3d64ec8c353..a1032f0dc9c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1669,7 +1669,7 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 int kfd_process_device_create_obj_handle(struct kfd_process_device *pdd,
 					void *mem)
 {
-	return idr_alloc(&pdd->alloc_idr, mem, 0, 0, GFP_KERNEL);
+	return idr_alloc(&pdd->alloc_idr, mem, GFP_KERNEL);
 }
 
 /* Translate specific handle from process local memory idr
diff --git a/drivers/gpu/drm/display/drm_dp_aux_dev.c b/drivers/gpu/drm/display/drm_dp_aux_dev.c
index 098e482e65a2..a59446e3f558 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_dev.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_dev.c
@@ -83,7 +83,7 @@ static struct drm_dp_aux_dev *alloc_drm_dp_aux_dev(struct drm_dp_aux *aux)
 	kref_init(&aux_dev->refcount);
 
 	mutex_lock(&aux_idr_mutex);
-	index = idr_alloc(&aux_idr, aux_dev, 0, DRM_AUX_MINORS, GFP_KERNEL);
+	index = idr_alloc_max(&aux_idr, aux_dev, DRM_AUX_MINORS, GFP_KERNEL);
 	mutex_unlock(&aux_idr_mutex);
 	if (index < 0) {
 		kfree(aux_dev);
diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index 6e433d465f41..fc793af28659 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -98,8 +98,8 @@ int drm_getmagic(struct drm_device *dev, void *data, struct drm_file *file_priv)
 
 	mutex_lock(&dev->master_mutex);
 	if (!file_priv->magic) {
-		ret = idr_alloc(&file_priv->master->magic_map, file_priv,
-				1, 0, GFP_KERNEL);
+		ret = idr_alloc_min(&file_priv->master->magic_map, file_priv, 1,
+				    GFP_KERNEL);
 		if (ret >= 0)
 			file_priv->magic = ret;
 	}
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 1c48d162c77e..710321bf3c84 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2912,7 +2912,7 @@ struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
 	tg->dev = dev;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
-	ret = idr_alloc(&dev->mode_config.tile_idr, tg, 1, 0, GFP_KERNEL);
+	ret = idr_alloc_min(&dev->mode_config.tile_idr, tg, 1, GFP_KERNEL);
 	if (ret >= 0) {
 		tg->id = ret;
 	} else {
diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
index c6e6a3e7219a..8f460ab16129 100644
--- a/drivers/gpu/drm/drm_context.c
+++ b/drivers/gpu/drm/drm_context.c
@@ -82,8 +82,8 @@ static int drm_legacy_ctxbitmap_next(struct drm_device * dev)
 	int ret;
 
 	mutex_lock(&dev->struct_mutex);
-	ret = idr_alloc(&dev->ctx_idr, NULL, DRM_RESERVED_CONTEXTS, 0,
-			GFP_KERNEL);
+	ret = idr_alloc_min(&dev->ctx_idr, NULL, DRM_RESERVED_CONTEXTS,
+			    GFP_KERNEL);
 	mutex_unlock(&dev->struct_mutex);
 	return ret;
 }
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 8214a0b1ab7f..f12974dcbae7 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -124,11 +124,11 @@ static int drm_minor_alloc(struct drm_device *dev, unsigned int type)
 
 	idr_preload(GFP_KERNEL);
 	spin_lock_irqsave(&drm_minor_lock, flags);
-	r = idr_alloc(&drm_minors_idr,
-		      NULL,
-		      64 * type,
-		      64 * (type + 1),
-		      GFP_NOWAIT);
+	r = idr_alloc_range(&drm_minors_idr,
+			    NULL,
+			    64 * type,
+			    64 * (type + 1),
+			    GFP_NOWAIT);
 	spin_unlock_irqrestore(&drm_minor_lock, flags);
 	idr_preload_end();
 
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index eb0c2d041f13..bd3299962f9c 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -377,7 +377,7 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
 	idr_preload(GFP_KERNEL);
 	spin_lock(&file_priv->table_lock);
 
-	ret = idr_alloc(&file_priv->object_idr, obj, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc_min(&file_priv->object_idr, obj, 1, GFP_NOWAIT);
 
 	spin_unlock(&file_priv->table_lock);
 	idr_preload_end();
@@ -841,7 +841,7 @@ drm_gem_flink_ioctl(struct drm_device *dev, void *data,
 	}
 
 	if (!obj->name) {
-		ret = idr_alloc(&dev->object_name_idr, obj, 1, 0, GFP_KERNEL);
+		ret = idr_alloc_min(&dev->object_name_idr, obj, 1, GFP_KERNEL);
 		if (ret < 0)
 			goto err;
 
diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index d72c2fac0ff1..3160fa0e4024 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -237,7 +237,7 @@ static struct drm_master *drm_lease_create(struct drm_master *lessor, struct idr
 	}
 
 	/* Insert the new lessee into the tree */
-	id = idr_alloc(&(drm_lease_owner(lessor)->lessee_idr), lessee, 1, 0, GFP_KERNEL);
+	id = idr_alloc_min(&(drm_lease_owner(lessor)->lessee_idr), lessee, 1, GFP_KERNEL);
 	if (id < 0) {
 		error = id;
 		goto out_lessee;
@@ -428,7 +428,7 @@ static int fill_object_idr(struct drm_device *dev,
 		 * really want is a 'leased/not-leased' result, for
 		 * which any non-NULL pointer will work fine.
 		 */
-		ret = idr_alloc(leases, &drm_lease_idr_object , object_id, object_id + 1, GFP_KERNEL);
+		ret = idr_alloc_range(leases, &drm_lease_idr_object, object_id, object_id + 1, GFP_KERNEL);
 		if (ret < 0) {
 			DRM_DEBUG_LEASE("Object %d cannot be inserted into leases (%d)\n",
 					object_id, ret);
@@ -437,14 +437,14 @@ static int fill_object_idr(struct drm_device *dev,
 		if (obj->type == DRM_MODE_OBJECT_CRTC && !universal_planes) {
 			struct drm_crtc *crtc = obj_to_crtc(obj);
 
-			ret = idr_alloc(leases, &drm_lease_idr_object, crtc->primary->base.id, crtc->primary->base.id + 1, GFP_KERNEL);
+			ret = idr_alloc_range(leases, &drm_lease_idr_object, crtc->primary->base.id, crtc->primary->base.id + 1, GFP_KERNEL);
 			if (ret < 0) {
 				DRM_DEBUG_LEASE("Object primary plane %d cannot be inserted into leases (%d)\n",
 						object_id, ret);
 				goto out_free_objects;
 			}
 			if (crtc->cursor) {
-				ret = idr_alloc(leases, &drm_lease_idr_object, crtc->cursor->base.id, crtc->cursor->base.id + 1, GFP_KERNEL);
+				ret = idr_alloc_range(leases, &drm_lease_idr_object, crtc->cursor->base.id, crtc->cursor->base.id + 1, GFP_KERNEL);
 				if (ret < 0) {
 					DRM_DEBUG_LEASE("Object cursor plane %d cannot be inserted into leases (%d)\n",
 							object_id, ret);
diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index ba1608effc0f..01692c47acea 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -45,8 +45,8 @@ int __drm_mode_object_add(struct drm_device *dev, struct drm_mode_object *obj,
 	WARN_ON(!dev->driver->load && dev->registered && !obj_free_cb);
 
 	mutex_lock(&dev->mode_config.idr_mutex);
-	ret = idr_alloc(&dev->mode_config.object_idr, register_obj ? obj : NULL,
-			1, 0, GFP_KERNEL);
+	ret = idr_alloc_min(&dev->mode_config.object_idr,
+			    register_obj ? obj : NULL, 1, GFP_KERNEL);
 	if (ret >= 0) {
 		/*
 		 * Set up the object linking under the protection of the idr
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 7e48dcd1bee4..6c08efac430d 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -539,7 +539,7 @@ int drm_syncobj_get_handle(struct drm_file *file_private,
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&file_private->syncobj_table_lock);
-	ret = idr_alloc(&file_private->syncobj_idr, syncobj, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc_min(&file_private->syncobj_idr, syncobj, 1, GFP_NOWAIT);
 	spin_unlock(&file_private->syncobj_table_lock);
 
 	idr_preload_end();
@@ -666,7 +666,7 @@ static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&file_private->syncobj_table_lock);
-	ret = idr_alloc(&file_private->syncobj_idr, syncobj, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc_min(&file_private->syncobj_idr, syncobj, 1, GFP_NOWAIT);
 	spin_unlock(&file_private->syncobj_table_lock);
 	idr_preload_end();
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
index 93a67422ca3b..77600e064029 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
@@ -540,8 +540,8 @@ static int file_add_object(struct file *file, struct drm_i915_gem_object *obj)
 	GEM_BUG_ON(obj->base.handle_count);
 
 	/* tie the object to the drm_file for easy reaping */
-	err = idr_alloc(&to_drm_file(file)->object_idr,
-			&obj->base, 1, 0, GFP_KERNEL);
+	err = idr_alloc_min(&to_drm_file(file)->object_idr, &obj->base, 1,
+			    GFP_KERNEL);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index 01e54b45c5c1..a58bf1447234 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -462,7 +462,7 @@ int intel_vgpu_query_plane(struct intel_vgpu *vgpu, void *args)
 
 	dmabuf_obj->vgpu = vgpu;
 
-	ret = idr_alloc(&vgpu->object_idr, dmabuf_obj, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc_min(&vgpu->object_idr, dmabuf_obj, 1, GFP_NOWAIT);
 	if (ret < 0)
 		goto out_free_info;
 	gfx_plane_info->dmabuf_id = ret;
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 46da19b3225d..f2b32029abdf 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -378,8 +378,8 @@ static struct intel_vgpu *__intel_gvt_create_vgpu(struct intel_gvt *gvt,
 	if (!vgpu)
 		return ERR_PTR(-ENOMEM);
 
-	ret = idr_alloc(&gvt->vgpu_idr, vgpu, IDLE_VGPU_IDR + 1, GVT_MAX_VGPU,
-		GFP_KERNEL);
+	ret = idr_alloc_range(&gvt->vgpu_idr, vgpu, IDLE_VGPU_IDR + 1, GVT_MAX_VGPU,
+			      GFP_KERNEL);
 	if (ret < 0)
 		goto out_free_vgpu;
 
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 1577ab6754db..4bb327f5d3a6 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4211,9 +4211,8 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
 	}
 
 	/* Config id 0 is invalid, id 1 for kernel stored test config. */
-	oa_config->id = idr_alloc(&perf->metrics_idr,
-				  oa_config, 2,
-				  0, GFP_KERNEL);
+	oa_config->id = idr_alloc_min(&perf->metrics_idr, oa_config, 2,
+				      GFP_KERNEL);
 	if (oa_config->id < 0) {
 		DRM_DEBUG("Failed to create sysfs entry for OA config\n");
 		err = oa_config->id;
diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm/i915/selftests/i915_perf.c
index 88db2e3d81d0..e7355594e7d4 100644
--- a/drivers/gpu/drm/i915/selftests/i915_perf.c
+++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
@@ -32,7 +32,7 @@ alloc_empty_config(struct i915_perf *perf)
 
 	mutex_lock(&perf->metrics_lock);
 
-	oa_config->id = idr_alloc(&perf->metrics_idr, oa_config, 2, 0, GFP_KERNEL);
+	oa_config->id = idr_alloc_min(&perf->metrics_idr, oa_config, 2, GFP_KERNEL);
 	if (oa_config->id < 0)  {
 		mutex_unlock(&perf->metrics_lock);
 		i915_oa_config_put(oa_config);
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 7b00c955cd82..3d8297949912 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -433,7 +433,7 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 again:
 	idr_preload(GFP_ATOMIC);
 	spin_lock(&qdev->surf_id_idr_lock);
-	idr_ret = idr_alloc(&qdev->surf_id_idr, NULL, 1, 0, GFP_NOWAIT);
+	idr_ret = idr_alloc_min(&qdev->surf_id_idr, NULL, 1, GFP_NOWAIT);
 	spin_unlock(&qdev->surf_id_idr_lock);
 	idr_preload_end();
 	if (idr_ret < 0)
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 368d26da0d6a..34aa7c9c3191 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -101,7 +101,7 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&qdev->release_idr_lock);
-	handle = idr_alloc(&qdev->release_idr, release, 1, 0, GFP_NOWAIT);
+	handle = idr_alloc_min(&qdev->release_idr, release, 1, GFP_NOWAIT);
 	release->base.seqno = ++qdev->release_seqno;
 	spin_unlock(&qdev->release_idr_lock);
 	idr_preload_end();
diff --git a/drivers/gpu/drm/sis/sis_mm.c b/drivers/gpu/drm/sis/sis_mm.c
index e51d4289a3d0..c8dfb10707a0 100644
--- a/drivers/gpu/drm/sis/sis_mm.c
+++ b/drivers/gpu/drm/sis/sis_mm.c
@@ -131,7 +131,7 @@ static int sis_drm_alloc(struct drm_device *dev, struct drm_file *file,
 	if (retval)
 		goto fail_alloc;
 
-	retval = idr_alloc(&dev_priv->object_idr, item, 1, 0, GFP_KERNEL);
+	retval = idr_alloc_min(&dev_priv->object_idr, item, 1, GFP_KERNEL);
 	if (retval < 0)
 		goto fail_idr;
 	user_key = retval;
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 9464f522e257..4d777c563efa 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -443,7 +443,7 @@ static int tegra_client_open(struct tegra_drm_file *fpriv,
 		return err;
 	}
 
-	err = idr_alloc(&fpriv->legacy_contexts, context, 1, 0, GFP_KERNEL);
+	err = idr_alloc_min(&fpriv->legacy_contexts, context, 1, GFP_KERNEL);
 	if (err < 0) {
 		client->ops->close_channel(context);
 		pm_runtime_put(client->base.dev);
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index f6a88abccc7d..b19cd0179364 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -149,8 +149,8 @@ int v3d_perfmon_create_ioctl(struct drm_device *dev, void *data,
 	mutex_init(&perfmon->lock);
 
 	mutex_lock(&v3d_priv->perfmon.lock);
-	ret = idr_alloc(&v3d_priv->perfmon.idr, perfmon, V3D_PERFMONID_MIN,
-			V3D_PERFMONID_MAX, GFP_KERNEL);
+	ret = idr_alloc_range(&v3d_priv->perfmon.idr, perfmon, V3D_PERFMONID_MIN,
+			      V3D_PERFMONID_MAX, GFP_KERNEL);
 	mutex_unlock(&v3d_priv->perfmon.lock);
 
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
index 79a74184d732..0a1cb8a00858 100644
--- a/drivers/gpu/drm/vc4/vc4_perfmon.c
+++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
@@ -178,8 +178,8 @@ int vc4_perfmon_create_ioctl(struct drm_device *dev, void *data,
 	refcount_set(&perfmon->refcnt, 1);
 
 	mutex_lock(&vc4file->perfmon.lock);
-	ret = idr_alloc(&vc4file->perfmon.idr, perfmon, VC4_PERFMONID_MIN,
-			VC4_PERFMONID_MAX, GFP_KERNEL);
+	ret = idr_alloc_range(&vc4file->perfmon.idr, perfmon, VC4_PERFMONID_MIN,
+			      VC4_PERFMONID_MAX, GFP_KERNEL);
 	mutex_unlock(&vc4file->perfmon.lock);
 
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index c2a879734d40..cb76ceab663e 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -169,7 +169,7 @@ int vgem_fence_attach_ioctl(struct drm_device *dev,
 	/* Record the fence in our idr for later signaling */
 	if (ret == 0) {
 		mutex_lock(&vfile->fence_mutex);
-		ret = idr_alloc(&vfile->fence_idr, fence, 1, 0, GFP_KERNEL);
+		ret = idr_alloc_min(&vfile->fence_idr, fence, 1, GFP_KERNEL);
 		mutex_unlock(&vfile->fence_mutex);
 		if (ret > 0) {
 			arg->out_fence = ret;
diff --git a/drivers/gpu/drm/via/via_mm.c b/drivers/gpu/drm/via/via_mm.c
index c9afa1a51f23..31cb14c75891 100644
--- a/drivers/gpu/drm/via/via_mm.c
+++ b/drivers/gpu/drm/via/via_mm.c
@@ -152,7 +152,7 @@ int via_mem_alloc(struct drm_device *dev, void *data,
 	if (retval)
 		goto fail_alloc;
 
-	retval = idr_alloc(&dev_priv->object_idr, item, 1, 0, GFP_KERNEL);
+	retval = idr_alloc_min(&dev_priv->object_idr, item, 1, GFP_KERNEL);
 	if (retval < 0)
 		goto fail_idr;
 	user_key = retval;
diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 26a55fef1ab5..b34d10a6f85e 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -172,7 +172,7 @@ int ttm_base_object_init(struct ttm_object_file *tfile,
 	kref_init(&base->refcount);
 	idr_preload(GFP_KERNEL);
 	spin_lock(&tdev->object_lock);
-	ret = idr_alloc(&tdev->idr, base, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc_min(&tdev->idr, base, 1, GFP_NOWAIT);
 	spin_unlock(&tdev->object_lock);
 	idr_preload_end();
 	if (ret < 0)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index a7d62a4eb47b..605b0668eeb1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -190,7 +190,7 @@ int vmw_resource_alloc_id(struct vmw_resource *res)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&dev_priv->resource_lock);
 
-	ret = idr_alloc(idr, res, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc_min(idr, res, 1, GFP_NOWAIT);
 	if (ret >= 0)
 		res->id = ret;
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 867ad8bb9b0c..0a56eeb4b89e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1318,7 +1318,7 @@ get_perf_etr_buf_cpu_wide(struct tmc_drvdata *drvdata,
 
 	/* Now that we have a buffer, add it to the IDR. */
 	mutex_lock(&drvdata->idr_mutex);
-	ret = idr_alloc(&drvdata->idr, etr_buf, pid, pid + 1, GFP_KERNEL);
+	ret = idr_alloc_range(&drvdata->idr, etr_buf, pid, pid + 1, GFP_KERNEL);
 	mutex_unlock(&drvdata->idr_mutex);
 
 	/* Another event with this session ID has allocated this buffer. */
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index d43db2c3876e..784ed5cf834d 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1540,7 +1540,7 @@ static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
 	int id;
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1, GFP_KERNEL);
+	id = idr_alloc_range(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
 		return id == -ENOSPC ? -EBUSY : id;
@@ -1576,8 +1576,9 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	}
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adapter,
-		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
+	id = idr_alloc_min(&i2c_adapter_idr, adapter,
+			   __i2c_first_dynamic_bus_num,
+			   GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
 		return id;
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7850287dfe7a..094c885dd161 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -430,7 +430,7 @@ static int i3c_bus_init(struct i3c_bus *i3cbus)
 	i3cbus->mode = I3C_BUS_MODE_PURE;
 
 	mutex_lock(&i3c_core_lock);
-	ret = idr_alloc(&i3c_bus_idr, i3cbus, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&i3c_bus_idr, i3cbus, GFP_KERNEL);
 	mutex_unlock(&i3c_core_lock);
 
 	if (ret < 0)
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 808f6e7a8048..eb8e38cddcb9 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -800,7 +800,7 @@ static struct icc_node *icc_node_create_nolock(int id)
 	if (!node)
 		return ERR_PTR(-ENOMEM);
 
-	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
+	id = idr_alloc_range(&icc_idr, node, id, id + 1, GFP_KERNEL);
 	if (id < 0) {
 		WARN(1, "%s: couldn't get idr\n", __func__);
 		kfree(node);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2b75f1ef7386..94feda226f47 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1831,7 +1831,7 @@ static int specific_minor(int minor)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&_minor_lock);
 
-	r = idr_alloc(&_minor_idr, MINOR_ALLOCED, minor, minor + 1, GFP_NOWAIT);
+	r = idr_alloc_range(&_minor_idr, MINOR_ALLOCED, minor, minor + 1, GFP_NOWAIT);
 
 	spin_unlock(&_minor_lock);
 	idr_preload_end();
@@ -1847,7 +1847,7 @@ static int next_free_minor(int *minor)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&_minor_lock);
 
-	r = idr_alloc(&_minor_idr, MINOR_ALLOCED, 0, 1 << MINORBITS, GFP_NOWAIT);
+	r = idr_alloc_max(&_minor_idr, MINOR_ALLOCED, 1 << MINORBITS, GFP_NOWAIT);
 
 	spin_unlock(&_minor_lock);
 	idr_preload_end();
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 660df7d269fa..c11dbc453af4 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -514,7 +514,7 @@ int memstick_add_host(struct memstick_host *host)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&memstick_host_lock);
 
-	rc = idr_alloc(&memstick_host_idr, host, 0, 0, GFP_NOWAIT);
+	rc = idr_alloc(&memstick_host_idr, host, GFP_NOWAIT);
 	if (rc >= 0)
 		host->id = rc;
 
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 3993bdd4b519..065a0cd0d1d6 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2081,7 +2081,7 @@ static int msb_init_disk(struct memstick_dev *card)
 	unsigned long capacity;
 
 	mutex_lock(&msb_disk_lock);
-	msb->disk_id = idr_alloc(&msb_disk_idr, card, 0, 256, GFP_KERNEL);
+	msb->disk_id = idr_alloc_max(&msb_disk_idr, card, 256, GFP_KERNEL);
 	mutex_unlock(&msb_disk_lock);
 
 	if (msb->disk_id  < 0)
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 725ba74ded30..0447f626b7d8 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1161,7 +1161,7 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 	msb->page_size = be16_to_cpu(sys_info->unit_size);
 
 	mutex_lock(&mspro_block_disk_lock);
-	disk_id = idr_alloc(&mspro_block_disk_idr, card, 0, 256, GFP_KERNEL);
+	disk_id = idr_alloc_max(&mspro_block_disk_idr, card, 256, GFP_KERNEL);
 	mutex_unlock(&mspro_block_disk_lock);
 	if (disk_id < 0)
 		return disk_id;
diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
index fb9a1b49ff6d..62f599e2bfb3 100644
--- a/drivers/misc/c2port/core.c
+++ b/drivers/misc/c2port/core.c
@@ -905,7 +905,7 @@ struct c2port_device *c2port_device_register(char *name,
 
 	idr_preload(GFP_KERNEL);
 	spin_lock_irq(&c2port_idr_lock);
-	ret = idr_alloc(&c2port_idr, c2dev, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(&c2port_idr, c2dev, GFP_NOWAIT);
 	spin_unlock_irq(&c2port_idr_lock);
 	idr_preload_end();
 
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 2a2619e3c72c..001d8bafee0c 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1489,7 +1489,7 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&rtsx_pci_lock);
-	ret = idr_alloc(&rtsx_pci_idr, pcr, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(&rtsx_pci_idr, pcr, GFP_NOWAIT);
 	if (ret >= 0)
 		pcr->id = ret;
 	spin_unlock(&rtsx_pci_lock);
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index e627b4056623..20f38dfed8a7 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -91,8 +91,8 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
 	 */
 	mutex_lock(&afu->contexts_lock);
 	idr_preload(GFP_KERNEL);
-	i = idr_alloc(&ctx->afu->contexts_idr, ctx, 0,
-		      ctx->afu->num_procs, GFP_NOWAIT);
+	i = idr_alloc_max(&ctx->afu->contexts_idr, ctx, ctx->afu->num_procs,
+			  GFP_NOWAIT);
 	idr_preload_end();
 	mutex_unlock(&afu->contexts_lock);
 	if (i < 0)
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index c1fbf6f588f7..f0cc1010c753 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -199,7 +199,7 @@ static int cxl_alloc_adapter_nr(struct cxl *adapter)
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&adapter_idr_lock);
-	i = idr_alloc(&cxl_adapter_idr, adapter, 0, 0, GFP_NOWAIT);
+	i = idr_alloc(&cxl_adapter_idr, adapter, GFP_NOWAIT);
 	spin_unlock(&adapter_idr_lock);
 	idr_preload_end();
 	if (i < 0)
diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index fb30b7de4aab..cb320cff88fd 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1834,7 +1834,7 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	mgr = &hpriv->ctx->sig_mgr;
 
 	spin_lock(&mgr->lock);
-	hdl_id = idr_alloc(&mgr->handles, handle, 1, 0, GFP_ATOMIC);
+	hdl_id = idr_alloc_min(&mgr->handles, handle, 1, GFP_ATOMIC);
 	spin_unlock(&mgr->lock);
 
 	if (hdl_id < 0) {
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index ed2cfd0c6e99..d9b41e1efc7d 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -144,7 +144,7 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 	}
 
 	mutex_lock(&mgr->ctx_lock);
-	rc = idr_alloc(&mgr->ctx_handles, ctx, 1, 0, GFP_KERNEL);
+	rc = idr_alloc_min(&mgr->ctx_handles, ctx, 1, GFP_KERNEL);
 	mutex_unlock(&mgr->ctx_lock);
 
 	if (rc < 0) {
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 37edb69a7255..9730cb3c3669 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -377,11 +377,11 @@ static int create_hdev(struct hl_device **dev, struct pci_dev *pdev)
 	/* Always save 2 numbers, 1 for main device and 1 for control.
 	 * They must be consecutive
 	 */
-	main_id = idr_alloc(&hl_devs_idr, hdev, 0, HL_MAX_MINORS, GFP_KERNEL);
+	main_id = idr_alloc_max(&hl_devs_idr, hdev, HL_MAX_MINORS, GFP_KERNEL);
 
 	if (main_id >= 0)
-		ctrl_id = idr_alloc(&hl_devs_idr, hdev, main_id + 1,
-					main_id + 2, GFP_KERNEL);
+		ctrl_id = idr_alloc_range(&hl_devs_idr, hdev, main_id + 1,
+					  main_id + 2, GFP_KERNEL);
 
 	mutex_unlock(&hl_devs_idr_lock);
 
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 663dd7e589d4..8fad3a260eb7 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -169,8 +169,8 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	}
 
 	spin_lock(&vm->idr_lock);
-	handle = idr_alloc(&vm->phys_pg_pack_handles, phys_pg_pack, 1, 0,
-				GFP_ATOMIC);
+	handle = idr_alloc_min(&vm->phys_pg_pack_handles, phys_pg_pack, 1,
+			       GFP_ATOMIC);
 	spin_unlock(&vm->idr_lock);
 
 	if (handle < 0) {
diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index ea5f2bd31b0a..44ee56d23520 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -158,7 +158,7 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 		return NULL;
 
 	spin_lock(&mmg->lock);
-	rc = idr_alloc(&mmg->handles, buf, 1, 0, GFP_ATOMIC);
+	rc = idr_alloc_min(&mmg->handles, buf, 1, GFP_ATOMIC);
 	spin_unlock(&mmg->lock);
 	if (rc < 0) {
 		dev_err(mmg->dev,
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 786f7c8f7f61..7f63566f9bed 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1189,7 +1189,7 @@ static int mei_minor_get(struct mei_device *dev)
 	int ret;
 
 	mutex_lock(&mei_minor_lock);
-	ret = idr_alloc(&mei_idr, dev, 0, MEI_MAX_DEVS, GFP_KERNEL);
+	ret = idr_alloc_max(&mei_idr, dev, MEI_MAX_DEVS, GFP_KERNEL);
 	if (ret >= 0)
 		dev->minor = ret;
 	else if (ret == -ENOSPC)
diff --git a/drivers/misc/ocxl/afu_irq.c b/drivers/misc/ocxl/afu_irq.c
index a06920b7e049..2fd35ea4345c 100644
--- a/drivers/misc/ocxl/afu_irq.c
+++ b/drivers/misc/ocxl/afu_irq.c
@@ -118,8 +118,8 @@ int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id)
 
 	mutex_lock(&ctx->irq_lock);
 
-	irq->id = idr_alloc(&ctx->irq_idr, irq, 0, MAX_IRQ_PER_CONTEXT,
-			GFP_KERNEL);
+	irq->id = idr_alloc_max(&ctx->irq_idr, irq, MAX_IRQ_PER_CONTEXT,
+				GFP_KERNEL);
 	if (irq->id < 0) {
 		rc = -ENOSPC;
 		goto err_unlock;
diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index 9eb0d93b01c6..ab420850f5a0 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -16,8 +16,8 @@ int ocxl_context_alloc(struct ocxl_context **context, struct ocxl_afu *afu,
 
 	ctx->afu = afu;
 	mutex_lock(&afu->contexts_lock);
-	pasid = idr_alloc(&afu->contexts_idr, ctx, afu->pasid_base,
-			afu->pasid_base + afu->pasid_max, GFP_KERNEL);
+	pasid = idr_alloc_range(&afu->contexts_idr, ctx, afu->pasid_base,
+				afu->pasid_base + afu->pasid_max, GFP_KERNEL);
 	if (pasid < 0) {
 		mutex_unlock(&afu->contexts_lock);
 		kfree(ctx);
diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 6777c419a8da..93dc30cc4e0d 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -35,7 +35,7 @@ static int allocate_minor(struct ocxl_file_info *info)
 	int minor;
 
 	mutex_lock(&minors_idr_lock);
-	minor = idr_alloc(&minors_idr, info, 0, OCXL_NUM_MINORS, GFP_KERNEL);
+	minor = idr_alloc_max(&minors_idr, info, OCXL_NUM_MINORS, GFP_KERNEL);
 	mutex_unlock(&minors_idr_lock);
 	return minor;
 }
diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
index a3098fea3bf7..ff39354db5c2 100644
--- a/drivers/misc/tifm_core.c
+++ b/drivers/misc/tifm_core.c
@@ -194,7 +194,7 @@ int tifm_add_adapter(struct tifm_adapter *fm)
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&tifm_adapter_lock);
-	rc = idr_alloc(&tifm_adapter_idr, fm, 0, 0, GFP_NOWAIT);
+	rc = idr_alloc(&tifm_adapter_idr, fm, GFP_NOWAIT);
 	if (rc >= 0)
 		fm->id = rc;
 	spin_unlock(&tifm_adapter_lock);
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 9eb0680db312..d55642723b0c 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -603,9 +603,9 @@ int add_mtd_device(struct mtd_info *mtd)
 	if (np)
 		ofidx = of_alias_get_id(np, "mtd");
 	if (ofidx >= 0)
-		i = idr_alloc(&mtd_idr, mtd, ofidx, ofidx + 1, GFP_KERNEL);
+		i = idr_alloc_range(&mtd_idr, mtd, ofidx, ofidx + 1, GFP_KERNEL);
 	else
-		i = idr_alloc(&mtd_idr, mtd, 0, 0, GFP_KERNEL);
+		i = idr_alloc(&mtd_idr, mtd, GFP_KERNEL);
 	if (i < 0) {
 		error = i;
 		goto fail_locked;
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index a78fdf3b30f7..8893993f3606 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -423,7 +423,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	gd->fops = &ubiblock_ops;
 	gd->major = ubiblock_major;
 	gd->minors = 1;
-	gd->first_minor = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, GFP_KERNEL);
+	gd->first_minor = idr_alloc(&ubiblock_minor_idr, dev, GFP_KERNEL);
 	if (gd->first_minor < 0) {
 		dev_err(disk_to_dev(gd),
 			"block: dynamic minor allocation failed");
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index c6a58343d81d..034c6cc5f928 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -1124,8 +1124,8 @@ ice_vc_fdir_insert_entry(struct ice_vf *vf,
 	int i;
 
 	/* alloc ID corresponding with conf */
-	i = idr_alloc(&vf->fdir.fdir_rule_idr, conf, 0,
-		      ICE_FDIR_MAX_FLTRS, GFP_KERNEL);
+	i = idr_alloc_max(&vf->fdir.fdir_rule_idr, conf, ICE_FDIR_MAX_FLTRS,
+			  GFP_KERNEL);
 	if (i < 0)
 		return -EINVAL;
 	*id = i;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_policer.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_policer.c
index 39052e5c12fd..356222c4d765 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_policer.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_policer.c
@@ -119,8 +119,8 @@ mlxsw_sp_policer_single_rate_index_alloc(struct mlxsw_sp_policer_family *family,
 	int id;
 
 	mutex_lock(&family->lock);
-	id = idr_alloc(&family->policer_idr, policer, family->start_index,
-		       family->end_index, GFP_KERNEL);
+	id = idr_alloc_range(&family->policer_idr, policer, family->start_index,
+			     family->end_index, GFP_KERNEL);
 	mutex_unlock(&family->lock);
 
 	if (id < 0)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 0d8a0068e4ca..545c70197d9a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -8587,8 +8587,8 @@ static int mlxsw_sp_rif_mac_profile_index_alloc(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_router *router = mlxsw_sp->router;
 	int id;
 
-	id = idr_alloc(&router->rif_mac_profiles_idr, profile, 0,
-		       max_rif_mac_profiles, GFP_KERNEL);
+	id = idr_alloc_max(&router->rif_mac_profiles_idr, profile,
+			   max_rif_mac_profiles, GFP_KERNEL);
 
 	if (id >= 0) {
 		profile->id = id;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.c b/drivers/net/ethernet/netronome/nfp/flower/main.c
index 4d960a9641b3..6c8901e73bb0 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.c
@@ -65,8 +65,9 @@ nfp_flower_get_internal_port_id(struct nfp_app *app, struct net_device *netdev)
 
 	idr_preload(GFP_ATOMIC);
 	spin_lock_bh(&priv->internal_ports.lock);
-	id = idr_alloc(&priv->internal_ports.port_ids, netdev,
-		       NFP_MIN_INT_PORT_ID, NFP_MAX_INT_PORT_ID, GFP_ATOMIC);
+	id = idr_alloc_range(&priv->internal_ports.port_ids, netdev,
+			     NFP_MIN_INT_PORT_ID, NFP_MAX_INT_PORT_ID,
+			     GFP_ATOMIC);
 	spin_unlock_bh(&priv->internal_ports.lock);
 	idr_preload_end();
 
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4a365f15533e..2272174b29fd 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -3562,7 +3562,7 @@ static int unit_set(struct idr *p, void *ptr, int n)
 {
 	int unit;
 
-	unit = idr_alloc(p, ptr, n, n + 1, GFP_KERNEL);
+	unit = idr_alloc_range(p, ptr, n, n + 1, GFP_KERNEL);
 	if (unit == -ENOSPC)
 		unit = -EINVAL;
 	return unit;
@@ -3571,7 +3571,7 @@ static int unit_set(struct idr *p, void *ptr, int n)
 /* get new free unit number and associate pointer with it */
 static int unit_get(struct idr *p, void *ptr, int min)
 {
-	return idr_alloc(p, ptr, min, 0, GFP_KERNEL);
+	return idr_alloc_min(p, ptr, min, GFP_KERNEL);
 }
 
 /* put unit number back to a pool */
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index c3d42062559d..ea022a443745 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -423,7 +423,7 @@ int tap_get_minor(dev_t major, struct tap_dev *tap)
 	}
 
 	spin_lock(&tap_major->minor_lock);
-	retval = idr_alloc(&tap_major->minor_idr, tap, 1, TAP_NUM_DEVS, GFP_ATOMIC);
+	retval = idr_alloc_range(&tap_major->minor_idr, tap, 1, TAP_NUM_DEVS, GFP_ATOMIC);
 	if (retval >= 0) {
 		tap->minor = retval;
 	} else if (retval == -ENOSPC) {
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 9842a4b2f78f..25f841b4fcb2 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -201,8 +201,8 @@ int ath10k_htt_tx_alloc_msdu_id(struct ath10k_htt *htt, struct sk_buff *skb)
 	int ret;
 
 	spin_lock_bh(&htt->tx_lock);
-	ret = idr_alloc(&htt->pending_tx, skb, 0,
-			htt->max_num_pending_tx, GFP_ATOMIC);
+	ret = idr_alloc_max(&htt->pending_tx, skb, htt->max_num_pending_tx,
+			    GFP_ATOMIC);
 	spin_unlock_bh(&htt->tx_lock);
 
 	ath10k_dbg(ar, ATH10K_DBG_HTT, "htt tx alloc msdu_id %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 7efbe03fbca8..e15ab6415b09 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -3054,8 +3054,9 @@ ath10k_wmi_mgmt_tx_alloc_msdu_id(struct ath10k *ar, struct sk_buff *skb,
 	pkt_addr->paddr = paddr;
 
 	spin_lock_bh(&ar->data_lock);
-	ret = idr_alloc(&wmi->mgmt_pending_tx, pkt_addr, 0,
-			wmi->mgmt_max_num_pending_tx, GFP_ATOMIC);
+	ret = idr_alloc_max(&wmi->mgmt_pending_tx, pkt_addr,
+			    wmi->mgmt_max_num_pending_tx,
+			    GFP_ATOMIC);
 	spin_unlock_bh(&ar->data_lock);
 
 	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi mgmt tx alloc msdu_id ret %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index 2107ec05d14f..157e31a6e4bc 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -65,7 +65,7 @@ static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 		goto err;
 
 	spin_lock_bh(&ring->idr_lock);
-	buf_id = idr_alloc(&ring->bufs_idr, buff, 0, ring->bufs_max, GFP_ATOMIC);
+	buf_id = idr_alloc_max(&ring->bufs_idr, buff, ring->bufs_max, GFP_ATOMIC);
 	spin_unlock_bh(&ring->idr_lock);
 	if (buf_id < 0) {
 		ret = -ENOBUFS;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 049774cc158c..6b79f52a1cd9 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -389,8 +389,9 @@ int ath11k_dp_rxbufs_replenish(struct ath11k_base *ab, int mac_id,
 			goto fail_free_skb;
 
 		spin_lock_bh(&rx_ring->idr_lock);
-		buf_id = idr_alloc(&rx_ring->bufs_idr, skb, 0,
-				   rx_ring->bufs_max * 3, GFP_ATOMIC);
+		buf_id = idr_alloc_max(&rx_ring->bufs_idr, skb,
+				       rx_ring->bufs_max * 3,
+				       GFP_ATOMIC);
 		spin_unlock_bh(&rx_ring->idr_lock);
 		if (buf_id < 0)
 			goto fail_dma_unmap;
@@ -2859,8 +2860,8 @@ static struct sk_buff *ath11k_dp_rx_alloc_mon_status_buf(struct ath11k_base *ab,
 		goto fail_free_skb;
 
 	spin_lock_bh(&rx_ring->idr_lock);
-	*buf_id = idr_alloc(&rx_ring->bufs_idr, skb, 0,
-			    rx_ring->bufs_max, GFP_ATOMIC);
+	*buf_id = idr_alloc_max(&rx_ring->bufs_idr, skb, rx_ring->bufs_max,
+				GFP_ATOMIC);
 	spin_unlock_bh(&rx_ring->idr_lock);
 	if (*buf_id < 0)
 		goto fail_dma_unmap;
@@ -3384,8 +3385,9 @@ static int ath11k_dp_rx_h_defrag_reo_reinject(struct ath11k *ar, struct dp_rx_ti
 		return -ENOMEM;
 
 	spin_lock_bh(&rx_refill_ring->idr_lock);
-	buf_id = idr_alloc(&rx_refill_ring->bufs_idr, defrag_skb, 0,
-			   rx_refill_ring->bufs_max * 3, GFP_ATOMIC);
+	buf_id = idr_alloc_max(&rx_refill_ring->bufs_idr, defrag_skb,
+			       rx_refill_ring->bufs_max * 3,
+			       GFP_ATOMIC);
 	spin_unlock_bh(&rx_refill_ring->idr_lock);
 	if (buf_id < 0) {
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index c17a2620aad7..a81cd7045e92 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -124,8 +124,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	tx_ring = &dp->tx_ring[ti.ring_id];
 
 	spin_lock_bh(&tx_ring->tx_idr_lock);
-	ret = idr_alloc(&tx_ring->txbuf_idr, skb, 0,
-			DP_TX_IDR_SIZE - 1, GFP_ATOMIC);
+	ret = idr_alloc_max(&tx_ring->txbuf_idr, skb, DP_TX_IDR_SIZE - 1,
+			    GFP_ATOMIC);
 	spin_unlock_bh(&tx_ring->tx_idr_lock);
 
 	if (unlikely(ret < 0)) {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ee1590b16eff..d47d7f905230 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5478,8 +5478,9 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 	ATH11K_SKB_CB(skb)->ar = ar;
 
 	spin_lock_bh(&ar->txmgmt_idr_lock);
-	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
-			   ATH11K_TX_MGMT_NUM_PENDING_MAX, GFP_ATOMIC);
+	buf_id = idr_alloc_max(&ar->txmgmt_idr, skb,
+			       ATH11K_TX_MGMT_NUM_PENDING_MAX,
+			       GFP_ATOMIC);
 	spin_unlock_bh(&ar->txmgmt_idr_lock);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index ace7371c4773..7d46ede7e6ab 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -867,8 +867,8 @@ mwifiex_clone_skb_for_tx_status(struct mwifiex_private *priv,
 		int id;
 
 		spin_lock_bh(&priv->ack_status_lock);
-		id = idr_alloc(&priv->ack_status_frames, orig_skb,
-			       1, 0x10, GFP_ATOMIC);
+		id = idr_alloc_range(&priv->ack_status_frames, orig_skb,
+				     1, 0x10, GFP_ATOMIC);
 		spin_unlock_bh(&priv->ack_status_lock);
 
 		if (id >= 0) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4e8997c45c1b..162ed80dd9e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1411,7 +1411,7 @@ mt76_token_get(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
 	int token;
 
 	spin_lock_bh(&dev->token_lock);
-	token = idr_alloc(&dev->token, *ptxwi, 0, dev->token_size, GFP_ATOMIC);
+	token = idr_alloc_max(&dev->token, *ptxwi, dev->token_size, GFP_ATOMIC);
 	spin_unlock_bh(&dev->token_lock);
 
 	return token;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 1d08d99e298c..13b105cb0419 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -131,8 +131,8 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
 
 	spin_lock_bh(&dev->status_lock);
 
-	pid = idr_alloc(&wcid->pktid, skb, MT_PACKET_ID_FIRST,
-			MT_PACKET_ID_MASK, GFP_ATOMIC);
+	pid = idr_alloc_range(&wcid->pktid, skb, MT_PACKET_ID_FIRST,
+			      MT_PACKET_ID_MASK, GFP_ATOMIC);
 	if (pid < 0) {
 		pid = MT_PACKET_ID_NO_SKB;
 		goto out;
@@ -721,7 +721,7 @@ int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
 
 	spin_lock_bh(&dev->token_lock);
 
-	token = idr_alloc(&dev->token, *ptxwi, 0, dev->token_size, GFP_ATOMIC);
+	token = idr_alloc_max(&dev->token, *ptxwi, dev->token_size, GFP_ATOMIC);
 	if (token >= 0)
 		dev->token_count++;
 
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 4044ddcb02c6..7cf58d208530 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -1005,7 +1005,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	 * ovcs resources, implicitly set by kzalloc() of ovcs
 	 */
 
-	ovcs->id = idr_alloc(&ovcs_idr, ovcs, 1, 0, GFP_KERNEL);
+	ovcs->id = idr_alloc_min(&ovcs_idr, ovcs, 1, GFP_KERNEL);
 	if (ovcs->id <= 0) {
 		ret = ovcs->id;
 		goto err_free_ovcs;
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d4850bdd837f..81df9549bd8c 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -562,7 +562,7 @@ static struct config_group *pci_epf_make(struct config_group *group,
 		return ERR_PTR(-ENOMEM);
 
 	mutex_lock(&functions_mutex);
-	index = idr_alloc(&functions_idr, epf_group, 0, 0, GFP_KERNEL);
+	index = idr_alloc(&functions_idr, epf_group, GFP_KERNEL);
 	mutex_unlock(&functions_mutex);
 	if (index < 0) {
 		err = index;
diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 5724001e66b9..4bce687e9d83 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -1540,7 +1540,7 @@ static int bq2415x_probe(struct i2c_client *client,
 
 	/* Get new ID for the new device */
 	mutex_lock(&bq2415x_id_mutex);
-	num = idr_alloc(&bq2415x_id, client, 0, 0, GFP_KERNEL);
+	num = idr_alloc(&bq2415x_id, client, GFP_KERNEL);
 	mutex_unlock(&bq2415x_id_mutex);
 	if (num < 0)
 		return num;
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index cf38cbfe13e9..06dc57e0ba74 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -146,7 +146,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 
 	/* Get new ID for the new battery device */
 	mutex_lock(&battery_mutex);
-	num = idr_alloc(&battery_id, client, 0, 0, GFP_KERNEL);
+	num = idr_alloc(&battery_id, client, GFP_KERNEL);
 	mutex_unlock(&battery_mutex);
 	if (num < 0)
 		return num;
diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
index 9ae273fde7a2..048001b7b050 100644
--- a/drivers/power/supply/ds2782_battery.c
+++ b/drivers/power/supply/ds2782_battery.c
@@ -390,7 +390,7 @@ static int ds278x_battery_probe(struct i2c_client *client,
 
 	/* Get an ID for this battery */
 	mutex_lock(&battery_lock);
-	ret = idr_alloc(&battery_id, client, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&battery_id, client, GFP_KERNEL);
 	mutex_unlock(&battery_lock);
 	if (ret < 0)
 		goto fail_id;
diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index f0654a932b37..434c2eea51c6 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -519,7 +519,7 @@ struct powercap_zone *powercap_register_zone(
 
 	mutex_lock(&control_type->lock);
 	/* Using idr to get the unique id */
-	result = idr_alloc(power_zone->parent_idr, NULL, 0, 0, GFP_KERNEL);
+	result = idr_alloc(power_zone->parent_idr, NULL, GFP_KERNEL);
 	if (result < 0)
 		goto err_idr_alloc;
 
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 22a65ad4e46e..cb73b3cc6bac 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -351,10 +351,10 @@ int pps_register_cdev(struct pps_device *pps)
 
 	mutex_lock(&pps_idr_lock);
 	/*
-	 * Get new ID for the new PPS source.  After idr_alloc() calling
+	 * Get new ID for the new PPS source. After idr_alloc_max() calling
 	 * the new source will be freely available into the kernel.
 	 */
-	err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
+	err = idr_alloc_max(&pps_idr, pps, PPS_MAX_SOURCES, GFP_KERNEL);
 	if (err < 0) {
 		if (err == -ENOSPC) {
 			pr_err("%s: too many PPS sources in the system\n",
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4519ef42b458..10853d551ddc 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3503,7 +3503,7 @@ ptp_ocp_device_init(struct ptp_ocp *bp, struct pci_dev *pdev)
 	int err;
 
 	mutex_lock(&ptp_ocp_lock);
-	err = idr_alloc(&ptp_ocp_idr, bp, 0, 0, GFP_KERNEL);
+	err = idr_alloc(&ptp_ocp_idr, bp, GFP_KERNEL);
 	mutex_unlock(&ptp_ocp_lock);
 	if (err < 0) {
 		dev_err(&pdev->dev, "idr_alloc failed: %d\n", err);
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 02a04ab34a23..38f16dc4df06 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -365,7 +365,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	 * TODO: assign a notifyid for rvdev updates as well
 	 * TODO: support predefined notifyids (via resource table)
 	 */
-	ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&rproc->notifyids, rvring, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(dev, "idr_alloc failed: %d\n", ret);
 		return ret;
diff --git a/drivers/reset/reset-ti-sci.c b/drivers/reset/reset-ti-sci.c
index b799aefad547..56309bb536bc 100644
--- a/drivers/reset/reset-ti-sci.c
+++ b/drivers/reset/reset-ti-sci.c
@@ -206,7 +206,7 @@ static int ti_sci_reset_of_xlate(struct reset_controller_dev *rcdev,
 	control->reset_mask = reset_spec->args[1];
 	mutex_init(&control->lock);
 
-	return idr_alloc(&data->idr, control, 0, 0, GFP_KERNEL);
+	return idr_alloc(&data->idr, control, GFP_KERNEL);
 }
 
 static const struct of_device_id ti_sci_reset_of_match[] = {
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 07586514991f..23e7a7cc15e0 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -974,8 +974,8 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
 		intent->size = le32_to_cpu(msg->intents[i].size);
 
 		spin_lock_irqsave(&channel->intent_lock, flags);
-		ret = idr_alloc(&channel->riids, intent,
-				intent->id, intent->id + 1, GFP_ATOMIC);
+		ret = idr_alloc_range(&channel->riids, intent,
+				      intent->id, intent->id + 1, GFP_ATOMIC);
 		spin_unlock_irqrestore(&channel->intent_lock, flags);
 
 		if (ret < 0)
@@ -1479,7 +1479,7 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
 	}
 
 	spin_lock_irqsave(&glink->idr_lock, flags);
-	ret = idr_alloc(&glink->rcids, channel, rcid, rcid + 1, GFP_ATOMIC);
+	ret = idr_alloc_range(&glink->rcids, channel, rcid, rcid + 1, GFP_ATOMIC);
 	if (ret < 0) {
 		dev_err(glink->dev, "Unable to insert channel into rcid list\n");
 		spin_unlock_irqrestore(&glink->idr_lock, flags);
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 905ac7910c98..5e582aaad676 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -239,7 +239,7 @@ static struct rpmsg_endpoint *__rpmsg_create_ept(struct virtproc_info *vrp,
 	mutex_lock(&vrp->endpoints_lock);
 
 	/* bind the endpoint to an rpmsg address (and allocate one if needed) */
-	id = idr_alloc(&vrp->endpoints, ept, id_min, id_max, GFP_KERNEL);
+	id = idr_alloc_range(&vrp->endpoints, ept, id_min, id_max, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(dev, "idr_alloc failed: %d\n", id);
 		goto free_ept;
diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index c335f7a188d2..9d5eefd409e5 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -538,7 +538,7 @@ bfad_im_scsi_host_alloc(struct bfad_s *bfad, struct bfad_im_port_s *im_port,
 	int error;
 
 	mutex_lock(&bfad_mutex);
-	error = idr_alloc(&bfad_im_port_index, im_port, 0, 0, GFP_KERNEL);
+	error = idr_alloc(&bfad_im_port_index, im_port, GFP_KERNEL);
 	if (error < 0) {
 		mutex_unlock(&bfad_mutex);
 		printk(KERN_WARNING "idr_alloc failure\n");
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index 908854869864..474c71d0463f 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -900,7 +900,7 @@ static int ch_probe(struct device *dev)
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&ch_index_lock);
-	ret = idr_alloc(&ch_index_idr, ch, 0, CH_MAX_DEVS + 1, GFP_NOWAIT);
+	ret = idr_alloc_max(&ch_index_idr, ch, CH_MAX_DEVS + 1, GFP_NOWAIT);
 	spin_unlock(&ch_index_lock);
 	idr_preload_end();
 
diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 244fc27215dc..3b2dd3f0caec 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -495,7 +495,7 @@ static void *ocxlflash_dev_context_init(struct pci_dev *pdev, void *afu_cookie)
 	}
 
 	idr_preload(GFP_KERNEL);
-	rc = idr_alloc(&afu->idr, ctx, 0, afu->max_pasid, GFP_NOWAIT);
+	rc = idr_alloc_max(&afu->idr, ctx, afu->max_pasid, GFP_NOWAIT);
 	idr_preload_end();
 	if (unlikely(rc < 0)) {
 		dev_err(dev, "%s: idr_alloc failed rc=%d\n", __func__, rc);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 750dd1e9f2cc..554f9231ef16 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4894,7 +4894,7 @@ lpfc_get_instance(void)
 {
 	int ret;
 
-	ret = idr_alloc(&lpfc_hba_index, NULL, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&lpfc_hba_index, NULL, GFP_KERNEL);
 	return ret < 0 ? -1 : ret;
 }
 
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 5d21f07456c6..df86285773ad 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -217,7 +217,8 @@ iscsi_create_endpoint(int dd_size)
 	 * First endpoint id should be 1 to comply with user space
 	 * applications (iscsid).
 	 */
-	id = idr_alloc(&iscsi_ep_idr, ep, 1, -1, GFP_NOIO);
+	id = idr_alloc_min(&iscsi_ep_idr, ep, 1, GFP_NOIO);
+
 	if (id < 0) {
 		mutex_unlock(&iscsi_ep_idr_mutex);
 		printk(KERN_ERR "Could not allocate endpoint ID. Error %d.\n",
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 118c7b4a8af2..52632741ef94 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1450,7 +1450,7 @@ sg_alloc(struct scsi_device *scsidp)
 	idr_preload(GFP_KERNEL);
 	write_lock_irqsave(&sg_index_lock, iflags);
 
-	error = idr_alloc(&sg_index_idr, sdp, 0, SG_MAX_DEVS, GFP_NOWAIT);
+	error = idr_alloc_max(&sg_index_idr, sdp, SG_MAX_DEVS, GFP_NOWAIT);
 	if (error < 0) {
 		if (error == -ENOSPC) {
 			sdev_printk(KERN_WARNING, scsidp,
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 850172a2b8f1..02dc4f24a839 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4343,7 +4343,7 @@ static int st_probe(struct device *dev)
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&st_index_lock);
-	error = idr_alloc(&st_index_idr, tpnt, 0, ST_MAX_TAPES + 1, GFP_NOWAIT);
+	error = idr_alloc_max(&st_index_idr, tpnt, ST_MAX_TAPES + 1, GFP_NOWAIT);
 	spin_unlock(&st_index_lock);
 	idr_preload_end();
 	if (error < 0) {
diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 3caabd873322..ae5417dc74e9 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -457,7 +457,7 @@ static int apr_add_device(struct device *dev, struct device_node *np,
 	adev->dev.driver = NULL;
 
 	spin_lock(&apr->svcs_lock);
-	idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
+	idr_alloc_range(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
 	spin_unlock(&apr->svcs_lock);
 
 	of_property_read_string_index(np, "qcom,protection-domain",
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ea09d1b42bf6..a42df3949408 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2939,8 +2939,8 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if (ctlr->bus_num >= 0) {
 		/* devices with a fixed bus num must check-in with the num */
 		mutex_lock(&board_lock);
-		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
-			ctlr->bus_num + 1, GFP_KERNEL);
+		id = idr_alloc_range(&spi_master_idr, ctlr, ctlr->bus_num,
+				     ctlr->bus_num + 1, GFP_KERNEL);
 		mutex_unlock(&board_lock);
 		if (WARN(id < 0, "couldn't get idr"))
 			return id == -ENOSPC ? -EBUSY : id;
@@ -2951,8 +2951,8 @@ int spi_register_controller(struct spi_controller *ctlr)
 		if (id >= 0) {
 			ctlr->bus_num = id;
 			mutex_lock(&board_lock);
-			id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
-				       ctlr->bus_num + 1, GFP_KERNEL);
+			id = idr_alloc_range(&spi_master_idr, ctlr, ctlr->bus_num,
+					     ctlr->bus_num + 1, GFP_KERNEL);
 			mutex_unlock(&board_lock);
 			if (WARN(id < 0, "couldn't get idr"))
 				return id == -ENOSPC ? -EBUSY : id;
@@ -2966,8 +2966,8 @@ int spi_register_controller(struct spi_controller *ctlr)
 			first_dynamic++;
 
 		mutex_lock(&board_lock);
-		id = idr_alloc(&spi_master_idr, ctlr, first_dynamic,
-			       0, GFP_KERNEL);
+		id = idr_alloc_min(&spi_master_idr, ctlr, first_dynamic,
+				   GFP_KERNEL);
 		mutex_unlock(&board_lock);
 		if (WARN(id < 0, "couldn't get idr"))
 			return id;
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index dc4ed0ff1ae2..074f12fce1a5 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -362,7 +362,7 @@ static int alloc_minor(struct gb_tty *gb_tty)
 	int minor;
 
 	mutex_lock(&table_lock);
-	minor = idr_alloc(&tty_minors, gb_tty, 0, GB_NUM_MINORS, GFP_KERNEL);
+	minor = idr_alloc_max(&tty_minors, gb_tty, GB_NUM_MINORS, GFP_KERNEL);
 	mutex_unlock(&table_lock);
 	if (minor >= 0)
 		gb_tty->minor = minor;
diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 941aaa7eab2e..a82748263cda 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1063,7 +1063,7 @@ static int pi433_get_minor(struct pi433_device *device)
 	int retval = -ENOMEM;
 
 	mutex_lock(&minor_lock);
-	retval = idr_alloc(&pi433_idr, device, 0, N_PI433_MINORS, GFP_KERNEL);
+	retval = idr_alloc_max(&pi433_idr, device, N_PI433_MINORS, GFP_KERNEL);
 	if (retval >= 0) {
 		device->minor = retval;
 		retval = 0;
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 845b20e4d05a..1f465eb4149a 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -198,8 +198,7 @@ get_msg_context(struct vchiq_mmal_instance *instance)
 	 * message is being replied to.
 	 */
 	mutex_lock(&instance->context_map_lock);
-	handle = idr_alloc(&instance->context_map, msg_context,
-			   0, 0, GFP_KERNEL);
+	handle = idr_alloc(&instance->context_map, msg_context, GFP_KERNEL);
 	mutex_unlock(&instance->context_map_lock);
 
 	if (handle < 0) {
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index e368f038ff5c..4f3dafe6f680 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -138,7 +138,7 @@ struct iscsi_tiqn *iscsit_add_tiqn(unsigned char *buf)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&tiqn_lock);
 
-	ret = idr_alloc(&tiqn_idr, NULL, 0, 0, GFP_NOWAIT);
+	ret = idr_alloc(&tiqn_idr, NULL, GFP_NOWAIT);
 	if (ret < 0) {
 		pr_err("idr_alloc() failed for tiqn->tiqn_index\n");
 		spin_unlock(&tiqn_lock);
diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 322a543b8c27..7889b7f209c3 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -172,7 +172,7 @@ static struct optee_supp_req  *supp_pop_entry(struct optee_supp *supp,
 		return ERR_PTR(-EINVAL);
 	}
 
-	*id = idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
+	*id = idr_alloc_min(&supp->idr, req, 1, GFP_KERNEL);
 	if (*id < 0)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index f2b1bcefcadd..b930229dce2a 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -161,7 +161,7 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
 	int id;
 
 	mutex_lock(&teedev->mutex);
-	id = idr_alloc(&teedev->idr, NULL, 1, 0, GFP_KERNEL);
+	id = idr_alloc_min(&teedev->idr, NULL, 1, GFP_KERNEL);
 	mutex_unlock(&teedev->mutex);
 	if (id < 0)
 		return ERR_PTR(id);
@@ -327,7 +327,7 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 	int id;
 
 	mutex_lock(&teedev->mutex);
-	id = idr_alloc(&teedev->idr, NULL, 1, 0, GFP_KERNEL);
+	id = idr_alloc_min(&teedev->idr, NULL, 1, GFP_KERNEL);
 	mutex_unlock(&teedev->mutex);
 	if (id < 0)
 		return ERR_PTR(id);
diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
index 29db413bbc03..afdd5454ca0f 100644
--- a/drivers/tty/rpmsg_tty.c
+++ b/drivers/tty/rpmsg_tty.c
@@ -138,7 +138,7 @@ static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_lock(&idr_lock);
-	ret = idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KERNEL);
+	ret = idr_alloc_max(&tty_idr, cport, MAX_TTY_RPMSG, GFP_KERNEL);
 	mutex_unlock(&idr_lock);
 
 	if (ret < 0) {
diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 5e9429dcc51f..44ad5573bdd8 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -537,7 +537,7 @@ static int mps2_of_get_port(struct platform_device *pdev,
 	if (id < 0)
 		id = idr_alloc_cyclic(&ports_idr, (void *)mps_port, 0, MPS2_MAX_PORTS, GFP_KERNEL);
 	else
-		id = idr_alloc(&ports_idr, (void *)mps_port, id, MPS2_MAX_PORTS, GFP_KERNEL);
+		id = idr_alloc_range(&ports_idr, (void *)mps_port, id, MPS2_MAX_PORTS, GFP_KERNEL);
 
 	if (id < 0)
 		return id;
diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 43afbb7c5ab9..7cdc6b98d514 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -403,7 +403,7 @@ static int uio_get_minor(struct uio_device *idev)
 	int retval;
 
 	mutex_lock(&minor_lock);
-	retval = idr_alloc(&uio_idr, idev, 0, UIO_MAX_DEVICES, GFP_KERNEL);
+	retval = idr_alloc_max(&uio_idr, idev, UIO_MAX_DEVICES, GFP_KERNEL);
 	if (retval >= 0) {
 		idev->minor = retval;
 		retval = 0;
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 9b9aea24d58c..682476828ad5 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -89,7 +89,7 @@ static int acm_alloc_minor(struct acm *acm)
 	int minor;
 
 	mutex_lock(&acm_minors_lock);
-	minor = idr_alloc(&acm_minors, acm, 0, ACM_TTY_MINORS, GFP_KERNEL);
+	minor = idr_alloc_max(&acm_minors, acm, ACM_TTY_MINORS, GFP_KERNEL);
 	mutex_unlock(&acm_minors_lock);
 
 	return minor;
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 06eea8848ccc..10847f2817c4 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -924,7 +924,7 @@ static int usb_register_bus(struct usb_bus *bus)
 	int busnum;
 
 	mutex_lock(&usb_bus_idr_lock);
-	busnum = idr_alloc(&usb_bus_idr, bus, 1, USB_MAXBUS, GFP_KERNEL);
+	busnum = idr_alloc_range(&usb_bus_idr, bus, 1, USB_MAXBUS, GFP_KERNEL);
 	if (busnum < 0) {
 		pr_err("%s: failed to get bus number\n", usbcore_name);
 		goto error_find_busnum;
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index d3acc0829ee5..1c29c4ffd6a3 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -417,7 +417,7 @@ static int xhci_dbc_tty_register_device(struct xhci_dbc *dbc)
 	xhci_dbc_tty_init_port(dbc, port);
 
 	mutex_lock(&dbc_tty_minors_lock);
-	port->minor = idr_alloc(&dbc_tty_minors, port, 0, 64, GFP_KERNEL);
+	port->minor = idr_alloc_max(&dbc_tty_minors, port, 64, GFP_KERNEL);
 	mutex_unlock(&dbc_tty_minors_lock);
 
 	if (port->minor < 0) {
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 24101bd7fcad..9249b3ca6112 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -92,8 +92,9 @@ static int allocate_minors(struct usb_serial *serial, int num_ports)
 	mutex_lock(&table_lock);
 	for (i = 0; i < num_ports; ++i) {
 		port = serial->port[i];
-		minor = idr_alloc(&serial_minors, port, 0,
-					USB_SERIAL_TTY_MINORS, GFP_KERNEL);
+		minor = idr_alloc_max(&serial_minors, port,
+				      USB_SERIAL_TTY_MINORS,
+				      GFP_KERNEL);
 		if (minor < 0)
 			goto error;
 		port->minor = minor;
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 3bc27de58f46..cc391759862a 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1339,7 +1339,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 		spin_lock_init(&dev->vqs[i].irq_lock);
 	}
 
-	ret = idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL);
+	ret = idr_alloc_range(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL);
 	if (ret < 0)
 		goto err_idr;
 
diff --git a/fs/cifs/cifs_swn.c b/fs/cifs/cifs_swn.c
index 1e4c7cc5287f..560f59f7da6e 100644
--- a/fs/cifs/cifs_swn.c
+++ b/fs/cifs/cifs_swn.c
@@ -328,7 +328,7 @@ static struct cifs_swn_reg *cifs_get_swn_reg(struct cifs_tcon *tcon)
 
 	kref_init(&reg->ref_count);
 
-	reg->id = idr_alloc(&cifs_swnreg_idr, reg, 1, 0, GFP_ATOMIC);
+	reg->id = idr_alloc_min(&cifs_swnreg_idr, reg, 1, GFP_ATOMIC);
 	if (reg->id < 0) {
 		cifs_dbg(FYI, "%s: failed to allocate registration id\n", __func__);
 		ret = reg->id;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 226822f49d30..c6c61e80afc4 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1217,7 +1217,7 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 
 	idr_preload(GFP_NOFS);
 	spin_lock(&ls->ls_lkbidr_spin);
-	rv = idr_alloc(&ls->ls_lkbidr, lkb, start, end, GFP_NOWAIT);
+	rv = idr_alloc_range(&ls->ls_lkbidr, lkb, start, end, GFP_NOWAIT);
 	if (rv >= 0)
 		lkb->lkb_id = rv;
 	spin_unlock(&ls->ls_lkbidr_spin);
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index ccff1791803f..9b6428c5d7eb 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -315,7 +315,7 @@ static int recover_idr_add(struct dlm_rsb *r)
 		rv = -1;
 		goto out_unlock;
 	}
-	rv = idr_alloc(&ls->ls_recover_idr, r, 1, 0, GFP_NOWAIT);
+	rv = idr_alloc_min(&ls->ls_recover_idr, r, 1, GFP_NOWAIT);
 	if (rv < 0)
 		goto out_unlock;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 95addc5c9d34..055619b919b1 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -307,7 +307,7 @@ static int erofs_scan_devices(struct super_block *sb,
 				break;
 			}
 
-			err = idr_alloc(&sbi->devs->tree, dif, 0, 0, GFP_KERNEL);
+			err = idr_alloc(&sbi->devs->tree, dif, GFP_KERNEL);
 			if (err < 0) {
 				kfree(dif);
 				break;
@@ -550,7 +550,7 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 			return -ENOMEM;
 		}
 		down_write(&ctx->devs->rwsem);
-		ret = idr_alloc(&ctx->devs->tree, dif, 0, 0, GFP_KERNEL);
+		ret = idr_alloc(&ctx->devs->tree, dif, GFP_KERNEL);
 		up_write(&ctx->devs->rwsem);
 		if (ret < 0) {
 			kfree(dif->path);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 47a6cf892c95..0f992090e30a 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -34,7 +34,7 @@ static int nfs_get_cb_ident_idr(struct nfs_client *clp, int minorversion)
 		return ret;
 	idr_preload(GFP_KERNEL);
 	spin_lock(&nn->nfs_client_lock);
-	ret = idr_alloc(&nn->cb_ident_idr, clp, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc_min(&nn->cb_ident_idr, clp, 1, GFP_NOWAIT);
 	if (ret >= 0)
 		clp->cl_cb_ident = ret;
 	spin_unlock(&nn->nfs_client_lock);
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index f660c0dbdb63..462952dd3273 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -292,7 +292,7 @@ static int o2net_prep_nsw(struct o2net_node *nn, struct o2net_status_wait *nsw)
 	int ret;
 
 	spin_lock(&nn->nn_lock);
-	ret = idr_alloc(&nn->nn_status_idr, nsw, 0, 0, GFP_ATOMIC);
+	ret = idr_alloc(&nn->nn_status_idr, nsw, GFP_ATOMIC);
 	if (ret >= 0) {
 		nsw->ns_id = ret;
 		list_add_tail(&nsw->ns_node_item, &nn->nn_status_list);
diff --git a/include/linux/idr.h b/include/linux/idr.h
index a0dce14090a9..57094351c521 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -111,7 +111,7 @@ static inline void idr_set_cursor(struct idr *idr, unsigned int val)
 
 void idr_preload(gfp_t gfp_mask);
 
-int idr_alloc(struct idr *, void *ptr, int start, int end, gfp_t);
+int idr_alloc_range(struct idr *, void *ptr, int start, int end, gfp_t);
 int __must_check idr_alloc_u32(struct idr *, void *ptr, u32 *id,
 				unsigned long max, gfp_t);
 int idr_alloc_cyclic(struct idr *, void *ptr, int start, int end, gfp_t);
@@ -124,6 +124,72 @@ void *idr_get_next_ul(struct idr *, unsigned long *nextid);
 void *idr_replace(struct idr *, void *, unsigned long id);
 void idr_destroy(struct idr *);
 
+/**
+ * idr_alloc() - Allocate an ID.
+ * @idr: IDR handle.
+ * @ptr: Pointer to be associated with the new ID.
+ * @gfp: Memory allocation flags.
+ *
+ * Allocates an unused ID in the range between 0 (inclusive) and INT_MAX
+ * (inclusive).
+ *
+ * The caller should provide their own locking to ensure that two
+ * concurrent modifications to the IDR are not possible.  Read-only
+ * accesses to the IDR may be done under the RCU read lock or may
+ * exclude simultaneous writers.
+ *
+ * Return: The newly allocated ID, -ENOMEM if memory allocation failed,
+ * or -ENOSPC if no free IDs could be found.
+ */
+static inline int idr_alloc(struct idr *idr, void *ptr, gfp_t gfp)
+{
+	return idr_alloc_range(idr, ptr, 0, 0, gfp);
+}
+
+/**
+ * idr_alloc_min() - Allocate an ID.
+ * @idr: IDR handle.
+ * @ptr: Pointer to be associated with the new ID.
+ * @start: The minimum ID (inclusive).
+ * @gfp: Memory allocation flags.
+ *
+ * Allocates an unused ID in the range between @start and INT_MAX (inclusive).
+ *
+ * The caller should provide their own locking to ensure that two
+ * concurrent modifications to the IDR are not possible.  Read-only
+ * accesses to the IDR may be done under the RCU read lock or may
+ * exclude simultaneous writers.
+ *
+ * Return: The newly allocated ID, -ENOMEM if memory allocation failed,
+ * or -ENOSPC if no free IDs could be found.
+ */
+static inline int idr_alloc_min(struct idr *idr, void *ptr, int start, gfp_t gfp)
+{
+	return idr_alloc_range(idr, ptr, start, 0, gfp);
+}
+
+/**
+ * idr_alloc_max() - Allocate an ID.
+ * @idr: IDR handle.
+ * @ptr: Pointer to be associated with the new ID.
+ * @end: The maximum ID (exclusive)
+ * @gfp: Memory allocation flags.
+ *
+ * Allocates an unused ID in the range between 0 (inclusive) and @end.
+ *
+ * The caller should provide their own locking to ensure that two
+ * concurrent modifications to the IDR are not possible.  Read-only
+ * accesses to the IDR may be done under the RCU read lock or may
+ * exclude simultaneous writers.
+ *
+ * Return: The newly allocated ID, -ENOMEM if memory allocation failed,
+ * or -ENOSPC if no free IDs could be found.
+ */
+static inline int idr_alloc_max(struct idr *idr, void *ptr, int end, gfp_t gfp)
+{
+	return idr_alloc_range(idr, ptr, 0, end, gfp);
+}
+
 /**
  * idr_init_base() - Initialise an IDR.
  * @idr: IDR handle.
diff --git a/ipc/util.c b/ipc/util.c
index a2208d0f26b2..bdfd7c0b3796 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -252,8 +252,8 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 		}
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
-		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
-				0, GFP_NOWAIT);
+		idx = idr_alloc_min(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
+				    GFP_NOWAIT);
 	}
 	if (idx >= 0)
 		new->id = (new->seq << ipcmni_seq_shift()) + idx;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccddb734..a3d2ef7f1e91 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -323,7 +323,7 @@ static int cgroup_idr_alloc(struct idr *idr, void *ptr, int start, int end,
 
 	idr_preload(gfp_mask);
 	spin_lock_bh(&cgroup_idr_lock);
-	ret = idr_alloc(idr, ptr, start, end, gfp_mask & ~__GFP_DIRECT_RECLAIM);
+	ret = idr_alloc_range(idr, ptr, start, end, gfp_mask & ~__GFP_DIRECT_RECLAIM);
 	spin_unlock_bh(&cgroup_idr_lock);
 	idr_preload_end();
 	return ret;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80782cddb1da..a7fc7a8e3961 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11065,7 +11065,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		if (type >= 0)
 			max = type;
 
-		ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
+		ret = idr_alloc_min(&pmu_idr, pmu, max, GFP_KERNEL);
 		if (ret < 0)
 			goto free_pdc;
 
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index c43e2ac2f8de..b14b7f2f432d 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -622,7 +622,7 @@ int irq_timings_alloc(int irq)
 		return -ENOMEM;
 
 	idr_preload(GFP_KERNEL);
-	id = idr_alloc(&irqt_stats, s, irq, irq + 1, GFP_NOWAIT);
+	id = idr_alloc_range(&irqt_stats, s, irq, irq + 1, GFP_NOWAIT);
 	idr_preload_end();
 
 	if (id < 0) {
diff --git a/kernel/pid.c b/kernel/pid.c
index 2fc0a16ec77b..1461644c49c4 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -209,8 +209,8 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 		spin_lock_irq(&pidmap_lock);
 
 		if (tid) {
-			nr = idr_alloc(&tmp->idr, NULL, tid,
-				       tid + 1, GFP_ATOMIC);
+			nr = idr_alloc_range(&tmp->idr, NULL, tid,
+					     tid + 1, GFP_ATOMIC);
 			/*
 			 * If ENOSPC is returned it means that the PID is
 			 * alreay in use. Return EEXIST in that case.
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ea50f6be843..ef4ac66ce9c2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -555,8 +555,8 @@ static int worker_pool_assign_id(struct worker_pool *pool)
 
 	lockdep_assert_held(&wq_pool_mutex);
 
-	ret = idr_alloc(&worker_pool_idr, pool, 0, WORK_OFFQ_POOL_NONE,
-			GFP_KERNEL);
+	ret = idr_alloc_max(&worker_pool_idr, pool, WORK_OFFQ_POOL_NONE,
+			    GFP_KERNEL);
 	if (ret >= 0) {
 		pool->id = ret;
 		return 0;
diff --git a/lib/idr.c b/lib/idr.c
index f4ab4f4aa3c7..e179bf643c9e 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -57,7 +57,7 @@ int idr_alloc_u32(struct idr *idr, void *ptr, u32 *nextid,
 EXPORT_SYMBOL_GPL(idr_alloc_u32);
 
 /**
- * idr_alloc() - Allocate an ID.
+ * idr_alloc_range() - Allocate an ID.
  * @idr: IDR handle.
  * @ptr: Pointer to be associated with the new ID.
  * @start: The minimum ID (inclusive).
@@ -76,7 +76,7 @@ EXPORT_SYMBOL_GPL(idr_alloc_u32);
  * Return: The newly allocated ID, -ENOMEM if memory allocation failed,
  * or -ENOSPC if no free IDs could be found.
  */
-int idr_alloc(struct idr *idr, void *ptr, int start, int end, gfp_t gfp)
+int idr_alloc_range(struct idr *idr, void *ptr, int start, int end, gfp_t gfp)
 {
 	u32 id = start;
 	int ret;
@@ -90,7 +90,7 @@ int idr_alloc(struct idr *idr, void *ptr, int start, int end, gfp_t gfp)
 
 	return id;
 }
-EXPORT_SYMBOL_GPL(idr_alloc);
+EXPORT_SYMBOL_GPL(idr_alloc_range);
 
 /**
  * idr_alloc_cyclic() - Allocate an ID cyclically.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 618c366a2f07..aa9cb41a8f75 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5120,8 +5120,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (!memcg)
 		return ERR_PTR(error);
 
-	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
+	memcg->id.id = idr_alloc_range(&mem_cgroup_idr, NULL,
+				       1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
 		goto fail;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f7d9a683e3a7..6a2b42a88e9b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -360,7 +360,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
-	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
+	id = idr_alloc(&shrinker_idr, shrinker, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
 
diff --git a/net/9p/client.c b/net/9p/client.c
index 8bba0d9cf975..9a60af6324b3 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -285,10 +285,10 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 	idr_preload(GFP_NOFS);
 	spin_lock_irq(&c->lock);
 	if (type == P9_TVERSION)
-		tag = idr_alloc(&c->reqs, req, P9_NOTAG, P9_NOTAG + 1,
-				GFP_NOWAIT);
+		tag = idr_alloc_range(&c->reqs, req, P9_NOTAG, P9_NOTAG + 1,
+				      GFP_NOWAIT);
 	else
-		tag = idr_alloc(&c->reqs, req, 0, P9_NOTAG, GFP_NOWAIT);
+		tag = idr_alloc_max(&c->reqs, req, P9_NOTAG, GFP_NOWAIT);
 	req->tc.tag = tag;
 	spin_unlock_irq(&c->lock);
 	idr_preload_end();
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 59a5c1341c26..e4eb3d4b0728 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1902,8 +1902,8 @@ bool hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor,
 
 	min = HCI_MIN_ADV_MONITOR_HANDLE;
 	max = HCI_MIN_ADV_MONITOR_HANDLE + HCI_MAX_ADV_MONITOR_NUM_HANDLES;
-	handle = idr_alloc(&hdev->adv_monitors_idr, monitor, min, max,
-			   GFP_KERNEL);
+	handle = idr_alloc_range(&hdev->adv_monitors_idr, monitor, min, max,
+				 GFP_KERNEL);
 	if (handle < 0) {
 		*err = handle;
 		return false;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 0ec2f5906a27..604232a4f2c1 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -187,7 +187,7 @@ static int alloc_netid(struct net *net, struct net *peer, int reqid)
 		max = reqid + 1;
 	}
 
-	return idr_alloc(&net->netns_ids, peer, min, max, GFP_ATOMIC);
+	return idr_alloc_range(&net->netns_ids, peer, min, max, GFP_ATOMIC);
 }
 
 /* This function is used by idr_for_each(). If net is equal to peer, the
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f7896f257e1b..841c7877058b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -325,9 +325,9 @@ static int ieee80211_add_nan_func(struct wiphy *wiphy,
 
 	spin_lock_bh(&sdata->u.nan.func_lock);
 
-	ret = idr_alloc(&sdata->u.nan.function_inst_ids,
-			nan_func, 1, sdata->local->hw.max_nan_de_entries + 1,
-			GFP_ATOMIC);
+	ret = idr_alloc_range(&sdata->u.nan.function_inst_ids,
+			      nan_func, 1, sdata->local->hw.max_nan_de_entries + 1,
+			      GFP_ATOMIC);
 	spin_unlock_bh(&sdata->u.nan.func_lock);
 
 	if (ret < 0)
@@ -3732,8 +3732,8 @@ int ieee80211_attach_ack_skb(struct ieee80211_local *local, struct sk_buff *skb,
 		return -ENOMEM;
 
 	spin_lock_irqsave(&local->ack_status_lock, spin_flags);
-	id = idr_alloc(&local->ack_status_frames, ack_skb,
-		       1, 0x2000, GFP_ATOMIC);
+	id = idr_alloc_range(&local->ack_status_frames, ack_skb,
+			     1, 0x2000, GFP_ATOMIC);
 	spin_unlock_irqrestore(&local->ack_status_lock, spin_flags);
 
 	if (id < 0) {
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0e4efc08c762..675bf6291e4d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2509,8 +2509,8 @@ static u16 ieee80211_store_ack_skb(struct ieee80211_local *local,
 		int id;
 
 		spin_lock_irqsave(&local->ack_status_lock, flags);
-		id = idr_alloc(&local->ack_status_frames, ack_skb,
-			       1, 0x2000, GFP_ATOMIC);
+		id = idr_alloc_range(&local->ack_status_frames, ack_skb,
+				     1, 0x2000, GFP_ATOMIC);
 		spin_unlock_irqrestore(&local->ack_status_lock, flags);
 
 		if (id >= 0) {
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 5522865deae9..8edb25a456ee 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -194,7 +194,7 @@ static struct tipc_conn *tipc_conn_alloc(struct tipc_topsrv *s)
 	INIT_WORK(&con->rwork, tipc_conn_recv_work);
 
 	spin_lock_bh(&s->idr_lock);
-	ret = idr_alloc(&s->conn_idr, con, 0, 0, GFP_ATOMIC);
+	ret = idr_alloc(&s->conn_idr, con, GFP_ATOMIC);
 	if (ret < 0) {
 		kfree(con);
 		spin_unlock_bh(&s->idr_lock);
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index ce545f99259e..d2fca8aff08a 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -128,7 +128,7 @@ int aa_alloc_secid(struct aa_label *label, gfp_t gfp)
 
 	idr_preload(gfp);
 	spin_lock_irqsave(&secid_lock, flags);
-	ret = idr_alloc(&aa_secids, label, AA_FIRST_SECID, 0, GFP_ATOMIC);
+	ret = idr_alloc_min(&aa_secids, label, AA_FIRST_SECID, GFP_ATOMIC);
 	spin_unlock_irqrestore(&secid_lock, flags);
 	idr_preload_end();
 
diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 0d31a6d71468..04f37db167a3 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -313,7 +313,7 @@ static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
 	int ret;
 
 	mutex_lock(&ac97_controllers_mutex);
-	ret = idr_alloc(&ac97_adapter_idr, ac97_ctrl, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&ac97_adapter_idr, ac97_ctrl, GFP_KERNEL);
 	ac97_ctrl->nr = ret;
 	if (ret >= 0) {
 		dev_set_name(&ac97_ctrl->adap, "ac97-%d", ret);
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index f424d7aa389a..18c7fc0f25c4 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -72,7 +72,7 @@ static struct audioreach_graph *q6apm_get_audioreach_graph(struct q6apm *apm, ui
 	}
 
 	mutex_lock(&apm->lock);
-	id = idr_alloc(&apm->graph_idr, graph, graph_id, graph_id + 1, GFP_KERNEL);
+	id = idr_alloc_range(&apm->graph_idr, graph, graph_id, graph_id + 1, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(apm->dev, "Unable to allocate graph id (%d)\n", graph_id);
 		kfree(graph);
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index bd649c232a06..af6092d51ba5 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -44,7 +44,7 @@ static struct audioreach_graph_info *audioreach_tplg_alloc_graph_info(struct q6a
 	INIT_LIST_HEAD(&info->sg_list);
 
 	mutex_lock(&apm->lock);
-	ret = idr_alloc(&apm->graph_info_idr, info, graph_id, graph_id + 1, GFP_KERNEL);
+	ret = idr_alloc_range(&apm->graph_info_idr, info, graph_id, graph_id + 1, GFP_KERNEL);
 	mutex_unlock(&apm->lock);
 
 	if (ret < 0) {
@@ -94,7 +94,7 @@ static struct audioreach_sub_graph *audioreach_tplg_alloc_sub_graph(struct q6apm
 	INIT_LIST_HEAD(&sg->container_list);
 
 	mutex_lock(&apm->lock);
-	ret = idr_alloc(&apm->sub_graphs_idr, sg, sub_graph_id, sub_graph_id + 1, GFP_KERNEL);
+	ret = idr_alloc_range(&apm->sub_graphs_idr, sg, sub_graph_id, sub_graph_id + 1, GFP_KERNEL);
 	mutex_unlock(&apm->lock);
 
 	if (ret < 0) {
@@ -136,7 +136,8 @@ static struct audioreach_container *audioreach_tplg_alloc_container(struct q6apm
 	INIT_LIST_HEAD(&cont->modules_list);
 
 	mutex_lock(&apm->lock);
-	ret = idr_alloc(&apm->containers_idr, cont, container_id, container_id + 1, GFP_KERNEL);
+	ret = idr_alloc_range(&apm->containers_idr, cont, container_id, container_id + 1,
+			      GFP_KERNEL);
 	mutex_unlock(&apm->lock);
 
 	if (ret < 0) {
@@ -181,7 +182,7 @@ static struct audioreach_module *audioreach_tplg_alloc_module(struct q6apm *apm,
 				       AR_MODULE_DYNAMIC_INSTANCE_ID_START,
 				       AR_MODULE_DYNAMIC_INSTANCE_ID_END, GFP_KERNEL);
 	} else {
-		ret = idr_alloc(&apm->modules_idr, mod, module_id, module_id + 1, GFP_KERNEL);
+		ret = idr_alloc_range(&apm->modules_idr, mod, module_id, module_id + 1, GFP_KERNEL);
 	}
 	mutex_unlock(&apm->lock);
 
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index ca24f6839d50..2a17430c7357 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -61,7 +61,7 @@ void idr_replace_test(void)
 {
 	DEFINE_IDR(idr);
 
-	idr_alloc(&idr, (void *)-1, 10, 11, GFP_KERNEL);
+	idr_alloc_range(&idr, (void *)-1, 10, 11, GFP_KERNEL);
 	idr_replace(&idr, &idr, 10);
 
 	idr_destroy(&idr);
@@ -80,18 +80,18 @@ void idr_null_test(void)
 
 	assert(idr_is_empty(&idr));
 
-	assert(idr_alloc(&idr, NULL, 0, 0, GFP_KERNEL) == 0);
+	assert(idr_alloc(&idr, NULL, GFP_KERNEL) == 0);
 	assert(!idr_is_empty(&idr));
 	idr_remove(&idr, 0);
 	assert(idr_is_empty(&idr));
 
-	assert(idr_alloc(&idr, NULL, 0, 0, GFP_KERNEL) == 0);
+	assert(idr_alloc(&idr, NULL, GFP_KERNEL) == 0);
 	assert(!idr_is_empty(&idr));
 	idr_destroy(&idr);
 	assert(idr_is_empty(&idr));
 
 	for (i = 0; i < 10; i++) {
-		assert(idr_alloc(&idr, NULL, 0, 0, GFP_KERNEL) == i);
+		assert(idr_alloc(&idr, NULL, GFP_KERNEL) == i);
 	}
 
 	assert(idr_replace(&idr, DUMMY_PTR, 3) == NULL);
@@ -99,7 +99,7 @@ void idr_null_test(void)
 	assert(idr_replace(&idr, NULL, 4) == DUMMY_PTR);
 	assert(idr_replace(&idr, DUMMY_PTR, 11) == ERR_PTR(-ENOENT));
 	idr_remove(&idr, 5);
-	assert(idr_alloc(&idr, NULL, 0, 0, GFP_KERNEL) == 5);
+	assert(idr_alloc(&idr, NULL, GFP_KERNEL) == 5);
 	idr_remove(&idr, 5);
 
 	for (i = 0; i < 9; i++) {
@@ -111,7 +111,7 @@ void idr_null_test(void)
 	idr_remove(&idr, 9);
 	assert(idr_is_empty(&idr));
 
-	assert(idr_alloc(&idr, NULL, 0, 0, GFP_KERNEL) == 0);
+	assert(idr_alloc(&idr, NULL, GFP_KERNEL) == 0);
 	assert(idr_replace(&idr, DUMMY_PTR, 3) == ERR_PTR(-ENOENT));
 	assert(idr_replace(&idr, DUMMY_PTR, 0) == NULL);
 	assert(idr_replace(&idr, NULL, 0) == DUMMY_PTR);
@@ -120,7 +120,7 @@ void idr_null_test(void)
 	assert(idr_is_empty(&idr));
 
 	for (i = 1; i < 10; i++) {
-		assert(idr_alloc(&idr, NULL, 1, 0, GFP_KERNEL) == i);
+		assert(idr_alloc_min(&idr, NULL, 1, GFP_KERNEL) == i);
 	}
 
 	idr_destroy(&idr);
@@ -136,7 +136,7 @@ void idr_nowait_test(void)
 
 	for (i = 0; i < 3; i++) {
 		struct item *item = item_create(i, 0);
-		assert(idr_alloc(&idr, item, i, i + 1, GFP_NOWAIT) == i);
+		assert(idr_alloc_range(&idr, item, i, i + 1, GFP_NOWAIT) == i);
 	}
 
 	idr_preload_end();
@@ -156,7 +156,7 @@ void idr_get_next_test(int base)
 
 	for(i = 0; indices[i]; i++) {
 		struct item *item = item_create(indices[i], 0);
-		assert(idr_alloc(&idr, item, indices[i], indices[i+1],
+		assert(idr_alloc_range(&idr, item, indices[i], indices[i+1],
 				 GFP_KERNEL) == indices[i]);
 	}
 
@@ -226,32 +226,32 @@ static void idr_align_test(struct idr *idr)
 	void *entry;
 
 	for (i = 0; i < 9; i++) {
-		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i);
+		BUG_ON(idr_alloc(idr, &name[i], GFP_KERNEL) != i);
 		idr_for_each_entry(idr, entry, id);
 	}
 	idr_destroy(idr);
 
 	for (i = 1; i < 10; i++) {
-		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i - 1);
+		BUG_ON(idr_alloc(idr, &name[i], GFP_KERNEL) != i - 1);
 		idr_for_each_entry(idr, entry, id);
 	}
 	idr_destroy(idr);
 
 	for (i = 2; i < 11; i++) {
-		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i - 2);
+		BUG_ON(idr_alloc(idr, &name[i], GFP_KERNEL) != i - 2);
 		idr_for_each_entry(idr, entry, id);
 	}
 	idr_destroy(idr);
 
 	for (i = 3; i < 12; i++) {
-		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i - 3);
+		BUG_ON(idr_alloc(idr, &name[i], GFP_KERNEL) != i - 3);
 		idr_for_each_entry(idr, entry, id);
 	}
 	idr_destroy(idr);
 
 	for (i = 0; i < 8; i++) {
-		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != 0);
-		BUG_ON(idr_alloc(idr, &name[i + 1], 0, 0, GFP_KERNEL) != 1);
+		BUG_ON(idr_alloc(idr, &name[i], GFP_KERNEL) != 0);
+		BUG_ON(idr_alloc_range(idr, &name[i + 1], 0, 0, GFP_KERNEL) != 1);
 		idr_for_each_entry(idr, entry, id);
 		idr_remove(idr, 1);
 		idr_for_each_entry(idr, entry, id);
@@ -260,7 +260,7 @@ static void idr_align_test(struct idr *idr)
 	}
 
 	for (i = 0; i < 8; i++) {
-		BUG_ON(idr_alloc(idr, NULL, 0, 0, GFP_KERNEL) != 0);
+		BUG_ON(idr_alloc(idr, NULL, GFP_KERNEL) != 0);
 		idr_for_each_entry(idr, entry, id);
 		idr_replace(idr, &name[i], 0);
 		idr_for_each_entry(idr, entry, id);
@@ -269,8 +269,8 @@ static void idr_align_test(struct idr *idr)
 	}
 
 	for (i = 0; i < 8; i++) {
-		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != 0);
-		BUG_ON(idr_alloc(idr, NULL, 0, 0, GFP_KERNEL) != 1);
+		BUG_ON(idr_alloc(idr, &name[i], GFP_KERNEL) != 0);
+		BUG_ON(idr_alloc(idr, NULL, GFP_KERNEL) != 1);
 		idr_remove(idr, 1);
 		idr_for_each_entry(idr, entry, id);
 		idr_replace(idr, &name[i + 1], 0);
@@ -288,7 +288,7 @@ static void *idr_throbber(void *arg)
 
 	rcu_register_thread();
 	do {
-		idr_alloc(&find_idr, xa_mk_value(id), id, id + 1, GFP_KERNEL);
+		idr_alloc_range(&find_idr, xa_mk_value(id), id, id + 1, GFP_KERNEL);
 		idr_remove(&find_idr, id);
 	} while (time(NULL) < start + 10);
 	rcu_unregister_thread();
@@ -305,7 +305,7 @@ void idr_find_test_1(int anchor_id, int throbber_id)
 	pthread_t throbber;
 	time_t start = time(NULL);
 
-	BUG_ON(idr_alloc(&find_idr, xa_mk_value(anchor_id), anchor_id,
+	BUG_ON(idr_alloc_range(&find_idr, xa_mk_value(anchor_id), anchor_id,
 				anchor_id + 1, GFP_KERNEL) != anchor_id);
 
 	pthread_create(&throbber, NULL, idr_throbber, &throbber_id);
@@ -344,10 +344,10 @@ void idr_checks(void)
 
 	for (i = 0; i < 10000; i++) {
 		struct item *item = item_create(i, 0);
-		assert(idr_alloc(&idr, item, 0, 20000, GFP_KERNEL) == i);
+		assert(idr_alloc_max(&idr, item, 20000, GFP_KERNEL) == i);
 	}
 
-	assert(idr_alloc(&idr, DUMMY_PTR, 5, 30, GFP_KERNEL) < 0);
+	assert(idr_alloc_range(&idr, DUMMY_PTR, 5, 30, GFP_KERNEL) < 0);
 
 	for (i = 0; i < 5000; i++)
 		item_idr_remove(&idr, i);
@@ -362,19 +362,19 @@ void idr_checks(void)
 	idr_remove(&idr, 3);
 	idr_remove(&idr, 0);
 
-	assert(idr_alloc(&idr, DUMMY_PTR, 0, 0, GFP_KERNEL) == 0);
+	assert(idr_alloc(&idr, DUMMY_PTR, GFP_KERNEL) == 0);
 	idr_remove(&idr, 1);
 	for (i = 1; i < RADIX_TREE_MAP_SIZE; i++)
-		assert(idr_alloc(&idr, DUMMY_PTR, 0, 0, GFP_KERNEL) == i);
+		assert(idr_alloc(&idr, DUMMY_PTR, GFP_KERNEL) == i);
 	idr_remove(&idr, 1 << 30);
 	idr_destroy(&idr);
 
 	for (i = INT_MAX - 3UL; i < INT_MAX + 1UL; i++) {
 		struct item *item = item_create(i, 0);
-		assert(idr_alloc(&idr, item, i, i + 10, GFP_KERNEL) == i);
+		assert(idr_alloc_range(&idr, item, i, i + 10, GFP_KERNEL) == i);
 	}
-	assert(idr_alloc(&idr, DUMMY_PTR, i - 2, i, GFP_KERNEL) == -ENOSPC);
-	assert(idr_alloc(&idr, DUMMY_PTR, i - 2, i + 10, GFP_KERNEL) == -ENOSPC);
+	assert(idr_alloc_range(&idr, DUMMY_PTR, i - 2, i, GFP_KERNEL) == -ENOSPC);
+	assert(idr_alloc_range(&idr, DUMMY_PTR, i - 2, i + 10, GFP_KERNEL) == -ENOSPC);
 
 	idr_for_each(&idr, item_idr_free, &idr);
 	idr_destroy(&idr);
@@ -401,7 +401,7 @@ void idr_checks(void)
 
 	for (i = 1; i < 10000; i++) {
 		struct item *item = item_create(i, 0);
-		assert(idr_alloc(&idr, item, 1, 20000, GFP_KERNEL) == i);
+		assert(idr_alloc_range(&idr, item, 1, 20000, GFP_KERNEL) == i);
 	}
 
 	idr_for_each(&idr, item_idr_free, &idr);
-- 
2.36.1

