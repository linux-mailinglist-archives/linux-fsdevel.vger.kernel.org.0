Return-Path: <linux-fsdevel+bounces-41360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C24A2E387
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABAB166315
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5117418D63E;
	Mon, 10 Feb 2025 05:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="fVoTYa41";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="amvleE3k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BF91A08A8;
	Mon, 10 Feb 2025 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164894; cv=none; b=KjDe0cmzGFE2NZy1A7lCjKYAMzJ/hsNk/Nvv9fMyNqJA3xUBortOzpZ5JrcuknMD3Pn7f5uO+G+mypBvST5X2R3UZv5r07+o+Z+6ma+OL60sRYw+B+1OmhoIqKiPvAJDawxV1FZQIZqn0fDLoGo63DX/TAqVdLGuR0MZ1Ig54hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164894; c=relaxed/simple;
	bh=oeaEm1EvFWlt+NRHMhWHlr0S0VT1YcnCVBBozaQQddE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UORlDLOzjrYu2OOpTrcC2RN/rZ0HYiQYl1sLyKqBeUglvTDdthIcG4hi6DqLxFC8I0Tcm2H5+3JR7i7zXv09eV6cLPH+EQxFkuQRIkApuRprEf46Z1jdeY3mOD/lU5KztdsqWkXjauP9tzGsbDVMMwXgSKWxpNyNwtHd4qMRCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=fVoTYa41; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=amvleE3k; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C40721140098;
	Mon, 10 Feb 2025 00:21:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 10 Feb 2025 00:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739164888; x=1739251288; bh=qv8fZR/LUmj9HFqT+K9y+CUWj13IvJAY
	/RZI9dEXrKY=; b=fVoTYa41lKciab7DoxqYBgwqRzY2M7NYwvvV4xzOfJnKNBq2
	Q7nqaf0iQY/F4rLoLr9IbybR5bxt+gnrd4DxsiATu0jBDRi37VrRsNtS/dCRse7T
	yO93nybGx/eAiaFDnJumUGpP/i+kj7S+Y+namu27fIw9yO4aj+qalH46ZvxmfrH+
	+EnBI7gOMApqqB8jz5YEsVQYIWN5yyQ9O5Jay47fzhs7wRe9MzAVwrxWALjvGeAU
	mIS9Zi6Tuxa7jiPzKAtRnHyGGXxEVPQlokv81sUhd4dV052dEm8ABWPpOMdb9FJK
	2P8FkFmuXFTEuwFdIaSWmFmmTg2liho2N7WHgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739164888; x=
	1739251288; bh=qv8fZR/LUmj9HFqT+K9y+CUWj13IvJAY/RZI9dEXrKY=; b=a
	mvleE3k39ioOXEXFVkDNYN54ReDfeysmvyz1ZaOoKnBKw+HK+SoFSNVrQkHVjXYm
	bdM5gw2DbFua0GigApQeBeh+BDVwLaELXA7+/VPAyyiZ/3Fuuww5Rww8pPsYWb0c
	i6TUK0BUbC0ewpun8ZqV6YUIdNPwiUDpTslCSppMOKr5890EtrTaAEZvJJZOexce
	N5ag495D80j4OkKJOdJtXZUerUuJmMU8ZCdUcrm6Zxf3QhvGF3bYvqPRbNuKmutm
	1uUfKG9eBF5qJ0AHDao0BYlCZJIw9/ge5iau32lRHKvG5VsYG7iek2v34UgxbnyO
	mviXmiTiIoAGFbHK0+p5g==
X-ME-Sender: <xms:2IypZwnm5DBgR2twilFojk-g5gArDdf-HkMTmfa97tP6WBNm_BauOg>
    <xme:2IypZ_0jZJ67ele66zh_zYgiDMDkMkSoFib4C63tR8syGqZBtK7czVGb1utARi6yx
    X50VLUSggWDu7tAiyk>
X-ME-Received: <xmr:2IypZ-r4lPOVZ1CUmJrOI9cT_jeZTlSrJobB-aFDSeuhVBQMBOpr5w0_zlE8AbuQ01NSiagQseCRCdGUkSGuAEpzacRll2RFpe0KmCOBK-sGHXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepffgrvhhiugcutfgvrghvvghruceomhgvsegurghvihgurhgvrghvvg
    hrrdgtohhmqeenucggtffrrghtthgvrhhnpefhgedtgfejteeiieejlefftdetueevgedu
    lefgleevvdevudduvedvudffudegteenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmvgesuggrvhhiughrvggrvhgvrhdrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrhgvghhkhh
    eslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesuggrvhhiughrvggrvhgvrhdrtghomhdprhgtphhtthhopehrohhs
    thgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhg
    rdhukhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghotggtihesihhnrhhirgdrfhhr
X-ME-Proxy: <xmx:2IypZ8mjqzb8nNNrbh5KuSUnanXSGrNxsHOsxgdHcaG8isVbytxVqg>
    <xmx:2IypZ-0WywMKlL_nqrAqQ0mMHtM_WacGzb9r1K_ZkK-NHwesDQYUgQ>
    <xmx:2IypZztNdD1MRsLHIFMJj28Rvnw818dPpg4zS0eBLFFVhKLBloOX6w>
    <xmx:2IypZ6V16XZ3xbNTCrZ6EYmXudmYQKNLDXwVYXSehxSwV9Cvc0JkRw>
    <xmx:2IypZ3s-iWDLDTtY4glZ6URWN6AyQqKC0hAIwIwc0fmsmcLaK6B8ilg0>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 00:21:26 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: David Reaver <me@davidreaver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/6] debugfs: Manual fixes for incomplete Coccinelle conversions
Date: Sun,  9 Feb 2025 21:20:25 -0800
Message-ID: <20250210052039.144513-6-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>
References: <20250210052039.144513-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix incomplete or incorrect conversions from dentry to debugfs_node.

This commit handles cases where Coccinelle could not fully convert the
code. Any remaining dentry references in debugfs-related code should now be
intentional and necessary.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 arch/arm/mach-omap2/pm-debug.c                |   2 +-
 arch/powerpc/include/asm/kvm_ppc.h            |   2 +-
 arch/powerpc/include/asm/vas.h                |   2 +-
 arch/powerpc/sysdev/xive/xive-internal.h      |   2 +-
 arch/s390/kernel/debug.c                      |   6 +-
 drivers/accel/habanalabs/common/habanalabs.h  |   2 +-
 drivers/block/drbd/drbd_debugfs.c             |   2 +-
 drivers/clk/davinci/pll.c                     |   2 +-
 drivers/crypto/caam/caamalg_qi2.h             |   2 +-
 .../intel/qat/qat_common/adf_heartbeat.h      |  13 +-
 drivers/cxl/cxlmem.h                          |   2 +-
 drivers/cxl/mem.c                             |  12 +-
 drivers/firmware/arm_scmi/raw_mode.h          |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |   9 +-
 drivers/gpu/drm/drm_debugfs.c                 |   4 +-
 drivers/gpu/drm/i915/gt/intel_gt_debugfs.h    |   1 +
 drivers/gpu/drm/msm/dp/dp_debug.h             |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/gsp.h |  10 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/r535.c    |   8 +-
 drivers/gpu/drm/omapdrm/dss/dss.h             |   2 +-
 drivers/gpu/drm/xe/xe_gt_debugfs.c            |   2 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c   |  23 ++-
 drivers/gpu/host1x/dev.h                      |   2 +-
 drivers/hwmon/asus_atk0110.c                  |   2 +-
 drivers/infiniband/hw/hfi1/verbs.h            |   4 +-
 drivers/infiniband/hw/hns/hns_roce_debugfs.h  |   4 +-
 drivers/infiniband/hw/ocrdma/ocrdma.h         |   2 +-
 .../media/platform/chips-media/coda/coda.h    |   3 +-
 .../media/platform/raspberrypi/rp1-cfe/csi2.h |   2 +-
 .../platform/raspberrypi/rp1-cfe/pisp-fe.h    |   2 +-
 .../st/sti/c8sectpfe/c8sectpfe-core.h         |   2 +-
 .../media/test-drivers/visl/visl-debugfs.c    |   2 +-
 drivers/media/test-drivers/visl/visl.h        |   2 +-
 drivers/memory/tegra/tegra124-emc.c           |   2 +-
 drivers/memory/tegra/tegra186-emc.c           |   2 +-
 drivers/memory/tegra/tegra20-emc.c            |   2 +-
 drivers/memory/tegra/tegra210-emc.h           |   2 +-
 drivers/memory/tegra/tegra30-emc.c            |   2 +-
 drivers/misc/cxl/cxl.h                        |   4 +-
 drivers/mtd/ubi/debug.c                       |  42 ++--
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |   2 +-
 drivers/net/ethernet/huawei/hinic/hinic_dev.h |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |   2 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/debugfs.c |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   5 +-
 .../mellanox/mlx5/core/en_accel/ktls.h        |   4 +-
 drivers/net/ethernet/netronome/nfp/nfp_net.h  |   4 +-
 .../ethernet/netronome/nfp/nfp_net_debugfs.c  |   2 +-
 drivers/net/ethernet/qualcomm/qca_spi.h       |   2 +-
 drivers/net/netdevsim/netdevsim.h             |   2 +-
 drivers/net/wireless/ath/ath11k/spectral.h    |   6 +-
 drivers/net/wireless/ath/ath9k/common-debug.h |  16 +-
 .../net/wireless/ath/ath9k/common-spectral.h  |   5 +-
 drivers/net/wireless/ath/ath9k/debug.h        |   2 +-
 drivers/net/wireless/ath/wcn36xx/debug.c      |   4 +-
 drivers/net/wireless/ath/wcn36xx/debug.h      |   2 +-
 .../net/wireless/intel/iwlwifi/dvm/debugfs.c  |   5 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   2 +-
 drivers/net/wireless/marvell/libertas/dev.h   |   4 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   2 +-
 drivers/net/wireless/realtek/rtlwifi/debug.c  |   2 +-
 drivers/net/wireless/rsi/rsi_debugfs.h        |   2 +-
 drivers/net/wireless/ti/wl1251/wl1251.h       | 188 +++++++++---------
 drivers/net/wireless/ti/wlcore/wlcore.h       |   2 +-
 drivers/power/supply/axp288_fuel_gauge.c      |   2 +-
 drivers/remoteproc/remoteproc_internal.h      |   4 +-
 drivers/s390/block/dasd.c                     |  26 +--
 drivers/scsi/bfa/bfad_drv.h                   |   2 +-
 drivers/scsi/lpfc/lpfc.h                      |   2 +-
 drivers/scsi/lpfc/lpfc_debugfs.c              |  40 ++--
 drivers/scsi/qla2xxx/qla_def.h                |   5 -
 drivers/soc/qcom/qcom_aoss.c                  |   4 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss.h    |   1 +
 fs/bcachefs/bcachefs.h                        |   4 +-
 fs/ceph/super.h                               |   4 +-
 fs/ubifs/debug.c                              |  62 +++---
 fs/ubifs/debug.h                              |  22 +-
 fs/xfs/scrub/stats.h                          |   6 +-
 fs/xfs/xfs_mount.h                            |   2 +-
 fs/xfs/xfs_super.h                            |   3 +-
 include/drm/drm_bridge.h                      |   2 +-
 include/drm/drm_connector.h                   |   3 +-
 include/drm/drm_debugfs.h                     |   2 +
 include/drm/drm_encoder.h                     |   2 +-
 include/drm/drm_file.h                        |   1 +
 include/drm/drm_panel.h                       |   3 +-
 include/drm/ttm/ttm_resource.h                |   3 +-
 include/linux/clk-provider.h                  |   3 +-
 include/linux/closure.h                       |   2 +-
 include/linux/fault-inject.h                  |   2 +-
 include/linux/irqdesc.h                       |   5 +-
 include/media/cec.h                           |   2 +-
 include/media/v4l2-async.h                    |   5 +-
 include/net/mac80211.h                        |  12 +-
 include/soc/tegra/mc.h                        |   2 +-
 include/sound/soc-dapm.h                      |   3 +-
 include/sound/soc.h                           |   2 +-
 kernel/gcov/fs.c                              |   2 +-
 kernel/trace/trace.h                          |   2 +-
 lib/notifier-error-inject.h                   |   7 +-
 net/mac80211/debugfs_netdev.c                 |  10 +-
 net/mac80211/ieee80211_i.h                    |  14 +-
 net/mac80211/key.h                            |   4 +-
 net/sunrpc/debugfs.c                          |   5 +-
 net/wireless/debugfs.c                        |   2 +-
 sound/soc/mediatek/mt8195/mt8195-afe-common.h |   2 +-
 sound/soc/sof/sof-client-ipc-flood-test.c     |   2 +-
 virt/kvm/kvm_main.c                           |   3 +-
 113 files changed, 406 insertions(+), 368 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index e6f29101bb46..1f4ea53a6b7d 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -187,7 +187,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
 	if (strncmp(pwrdm->name, "dpll", 4) == 0)
 		return 0;
 
-	d = debugfs_create_dir(pwrdm->name, (struct dentry *)dir);
+	d = debugfs_create_dir(pwrdm->name, (struct debugfs_node *)dir);
 	debugfs_create_file("suspend", S_IRUGO|S_IWUSR, d, pwrdm,
 			    &pwrdm_suspend_fops);
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index ca3829d47ab7..a1ed51f3ba57 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -318,7 +318,7 @@ struct kvmppc_ops {
 	int (*enable_dawr1)(struct kvm *kvm);
 	bool (*hash_v3_possible)(void);
 	int (*create_vm_debugfs)(struct kvm *kvm);
-	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
+	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct debugfs_node *debugfs_dentry);
 };
 
 extern struct kvmppc_ops *kvmppc_hv_ops;
diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index c36f71e01c0f..2f441d2bac2a 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -84,7 +84,7 @@ struct vas_window {
 	enum vas_cop_type cop;
 	struct vas_user_win_ref task_ref;
 	char *dbgname;
-	struct dentry *dbgdir;
+	struct debugfs_node *dbgdir;
 };
 
 /*
diff --git a/arch/powerpc/sysdev/xive/xive-internal.h b/arch/powerpc/sysdev/xive/xive-internal.h
index fe6d95d54af9..7e60bdbd034e 100644
--- a/arch/powerpc/sysdev/xive/xive-internal.h
+++ b/arch/powerpc/sysdev/xive/xive-internal.h
@@ -58,7 +58,7 @@ struct xive_ops {
 	void	(*put_ipi)(unsigned int cpu, struct xive_cpu *xc);
 #endif
 	int	(*debug_show)(struct seq_file *m, void *private);
-	int	(*debug_create)(struct dentry *xive_dir);
+	int	(*debug_create)(struct debugfs_node *xive_dir);
 	const char *name;
 };
 
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index b59401b28f0d..be1e22d10f86 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -253,7 +253,7 @@ static debug_info_t *debug_info_alloc(const char *name, int pages_per_area,
 	rc->entry_size	   = sizeof(debug_entry_t) + buf_size;
 	strscpy(rc->name, name, sizeof(rc->name));
 	memset(rc->views, 0, DEBUG_MAX_VIEWS * sizeof(struct debug_view *));
-	memset(rc->debugfs_entries, 0, DEBUG_MAX_VIEWS * sizeof(struct dentry *));
+	memset(rc->debugfs_entries, 0, DEBUG_MAX_VIEWS * sizeof(struct debugfs_node *));
 	refcount_set(&(rc->ref_count), 0);
 
 	return rc;
@@ -660,15 +660,17 @@ static int debug_open(struct inode *inode, struct file *file)
 {
 	debug_info_t *debug_info;
 	file_private_info_t *p_info;
+	struct debugfs_node *node;
 	int i, rc = 0;
 
 	mutex_lock(&debug_mutex);
 	debug_info = file_inode(file)->i_private;
+	node = debugfs_node_from_dentry(file->f_path.dentry);
 	/* find debug view */
 	for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
 		if (!debug_info->views[i])
 			continue;
-		else if (debug_info->debugfs_entries[i] == file->f_path.dentry)
+		else if (debug_info->debugfs_entries[i] == node)
 			goto found; /* found view ! */
 	}
 	/* no entry found */
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 6f27ce4fa01b..ca5ee6bb5b02 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -2405,7 +2405,7 @@ struct hl_debugfs_entry {
  * @i2c_len: generic u8 debugfs file for length value to use in i2c_data_read.
  */
 struct hl_dbg_device_entry {
-	struct dentry			*root;
+	struct debugfs_node		*root;
 	struct hl_device		*hdev;
 	struct hl_debugfs_entry		*entry_arr;
 	struct list_head		file_list;
diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 2a52a47b6a9e..6e4332627636 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -481,7 +481,7 @@ void drbd_debugfs_resource_add(struct drbd_resource *resource)
 	resource->debugfs_res_in_flight_summary = dentry;
 }
 
-static void drbd_debugfs_remove(struct dentry **dp)
+static void drbd_debugfs_remove(struct debugfs_node **dp)
 {
 	debugfs_remove(*dp);
 	*dp = NULL;
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 92ca8031e80f..19f16b89dd5b 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -189,7 +189,7 @@ static int davinci_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 #ifdef CONFIG_DEBUG_FS
-static void davinci_pll_debug_init(struct clk_hw *hw, struct dentry *dentry);
+static void davinci_pll_debug_init(struct clk_hw *hw, struct debugfs_node *dentry);
 #else
 #define davinci_pll_debug_init NULL
 #endif
diff --git a/drivers/crypto/caam/caamalg_qi2.h b/drivers/crypto/caam/caamalg_qi2.h
index 61d1219a202f..e4a9f4583a83 100644
--- a/drivers/crypto/caam/caamalg_qi2.h
+++ b/drivers/crypto/caam/caamalg_qi2.h
@@ -64,7 +64,7 @@ struct dpaa2_caam_priv {
 	struct iommu_domain *domain;
 
 	struct dpaa2_caam_priv_per_cpu __percpu *ppriv;
-	struct dentry *dfs_root;
+	struct debugfs_node *dfs_root;
 };
 
 /**
diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h b/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
index 16fdfb48b196..7546882ca1e5 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
@@ -8,6 +8,7 @@
 
 struct adf_accel_dev;
 struct dentry;
+#define debugfs_node dentry
 
 #define ADF_CFG_HB_TIMER_MIN_MS 200
 #define ADF_CFG_HB_TIMER_DEFAULT_MS 500
@@ -39,13 +40,13 @@ struct adf_heartbeat {
 		void *virt_addr;
 	} dma;
 	struct {
-		struct dentry *base_dir;
-		struct dentry *status;
-		struct dentry *cfg;
-		struct dentry *sent;
-		struct dentry *failed;
+		struct debugfs_node *base_dir;
+		struct debugfs_node *status;
+		struct debugfs_node *cfg;
+		struct debugfs_node *sent;
+		struct debugfs_node *failed;
 #ifdef CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION
-		struct dentry *inject_error;
+		struct debugfs_node *inject_error;
 #endif
 	} dbgfs;
 };
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..9600f082e8e5 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -870,6 +870,6 @@ struct cxl_hdm {
 };
 
 struct seq_file;
-struct dentry *cxl_debugfs_create_dir(const char *dir);
+struct debugfs_node *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2f03a4d5606e..16c52a17eea2 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -110,7 +110,7 @@ static int cxl_mem_probe(struct device *dev)
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *endpoint_parent;
 	struct cxl_dport *dport;
-	struct dentry *dentry;
+	struct debugfs_node *node;
 	int rc;
 
 	if (!cxlds->media_ready)
@@ -127,17 +127,17 @@ static int cxl_mem_probe(struct device *dev)
 	if (work_pending(&cxlmd->detach_work))
 		return -EBUSY;
 
-	dentry = cxl_debugfs_create_dir(dev_name(dev));
-	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
+	node = cxl_debugfs_create_dir(dev_name(dev));
+	debugfs_create_devm_seqfile(dev, "dpamem", node, cxl_mem_dpa_show);
 
 	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+		debugfs_create_file("inject_poison", 0200, node, cxlmd,
 				    &cxl_poison_inject_fops);
 	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+		debugfs_create_file("clear_poison", 0200, node, cxlmd,
 				    &cxl_poison_clear_fops);
 
-	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
+	rc = devm_add_action_or_reset(dev, remove_debugfs, node);
 	if (rc)
 		return rc;
 
diff --git a/drivers/firmware/arm_scmi/raw_mode.h b/drivers/firmware/arm_scmi/raw_mode.h
index 8af756a83fd1..4e4acc4503b0 100644
--- a/drivers/firmware/arm_scmi/raw_mode.h
+++ b/drivers/firmware/arm_scmi/raw_mode.h
@@ -18,7 +18,7 @@ enum {
 };
 
 void *scmi_raw_mode_init(const struct scmi_handle *handle,
-			 struct dentry *top_dentry, int instance_id,
+			 struct debugfs_node *top_dentry, int instance_id,
 			 u8 *channels, int num_chans,
 			 const struct scmi_desc *desc, int tx_max_msg);
 void scmi_raw_mode_cleanup(void *raw);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 52c16bfeccaa..a0791a9276b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1101,10 +1101,13 @@ void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_ras *ras = container_of(control, struct amdgpu_ras,
 					      eeprom_control);
-	struct dentry *de = ras->de_ras_eeprom_table;
+	struct debugfs_node *de = ras->de_ras_eeprom_table;
+	struct inode *de_inode;
 
-	if (de)
-		d_inode(de)->i_size = amdgpu_ras_debugfs_table_size(control);
+	if (de) {
+		de_inode = debugfs_node_inode(de);
+		de_inode->i_size = amdgpu_ras_debugfs_table_size(control);
+	}
 }
 
 static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index a5ee622f90d7..aa87239d2cc6 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -616,9 +616,9 @@ static const struct file_operations _f##_infoframe_fops = { \
 }; \
 \
 static int create_hdmi_## _f ## _infoframe_file(struct drm_connector *connector, \
-						struct dentry *parent) \
+						struct debugfs_node *parent) \
 { \
-	struct dentry *file; \
+	struct debugfs_node *file; \
 	\
 	file = debugfs_create_file(#_f, 0400, parent, connector, &_f ## _infoframe_fops); \
 	if (IS_ERR(file)) \
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
index 82475823a7e4..03d425886e25 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
@@ -9,6 +9,7 @@
 #include <linux/file.h>
 
 struct intel_gt;
+#define debugfs_node dentry
 
 #define __GT_DEBUGFS_ATTRIBUTE_FOPS(__name)				\
 static const struct file_operations __name ## _fops = {			\
diff --git a/drivers/gpu/drm/msm/dp/dp_debug.h b/drivers/gpu/drm/msm/dp/dp_debug.h
index 8a69b3891d5e..ccbc6476d9a7 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.h
+++ b/drivers/gpu/drm/msm/dp/dp_debug.h
@@ -28,7 +28,7 @@
 int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
 		  struct msm_dp_link *link,
 		  struct drm_connector *connector,
-		  struct dentry *root,
+		  struct debugfs_node *root,
 		  bool is_edp);
 
 #else
diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
index 5c5f4607fcc9..c5c205f65875 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
@@ -229,11 +229,11 @@ struct nvkm_gsp {
 	 * in memory until the dentry is deleted.
 	 */
 	struct {
-		struct dentry *parent;
-		struct dentry *init;
-		struct dentry *rm;
-		struct dentry *intr;
-		struct dentry *pmu;
+		struct debugfs_node *parent;
+		struct debugfs_node *init;
+		struct debugfs_node *rm;
+		struct debugfs_node *intr;
+		struct debugfs_node *pmu;
 	} debugfs;
 	struct debugfs_blob_wrapper blob_init;
 	struct debugfs_blob_wrapper blob_intr;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index 9155c5d25c64..6eaabfb239ea 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -2264,10 +2264,10 @@ r535_gsp_libos_debugfs_init(struct nvkm_gsp *gsp)
 		goto error;
 	}
 
-	i_size_write(d_inode(gsp->debugfs.init), gsp->blob_init.size);
-	i_size_write(d_inode(gsp->debugfs.intr), gsp->blob_intr.size);
-	i_size_write(d_inode(gsp->debugfs.rm), gsp->blob_rm.size);
-	i_size_write(d_inode(gsp->debugfs.pmu), gsp->blob_pmu.size);
+	i_size_write(debugfs_node_inode(gsp->debugfs.init), gsp->blob_init.size);
+	i_size_write(debugfs_node_inode(gsp->debugfs.intr), gsp->blob_intr.size);
+	i_size_write(debugfs_node_inode(gsp->debugfs.rm), gsp->blob_rm.size);
+	i_size_write(debugfs_node_inode(gsp->debugfs.pmu), gsp->blob_pmu.size);
 
 	r535_gsp_msg_ntfy_add(gsp, NV_VGPU_MSG_EVENT_UCODE_LIBOS_PRINT,
 			      r535_gsp_msg_libos_print, gsp);
diff --git a/drivers/gpu/drm/omapdrm/dss/dss.h b/drivers/gpu/drm/omapdrm/dss/dss.h
index a8b231ed4f4b..d524ed1990fd 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.h
+++ b/drivers/gpu/drm/omapdrm/dss/dss.h
@@ -247,7 +247,7 @@ struct dss_device {
 	const struct dss_features *feat;
 
 	struct {
-		struct dentry *root;
+		struct debugfs_node *root;
 		struct dss_debugfs_entry *clk;
 		struct dss_debugfs_entry *dss;
 	} debugfs;
diff --git a/drivers/gpu/drm/xe/xe_gt_debugfs.c b/drivers/gpu/drm/xe/xe_gt_debugfs.c
index 6e5cbb23d5c9..3bc631d11f9d 100644
--- a/drivers/gpu/drm/xe/xe_gt_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_debugfs.c
@@ -75,7 +75,7 @@ int xe_gt_debugfs_simple_show(struct seq_file *m, void *data)
 {
 	struct drm_printer p = drm_seq_file_printer(m);
 	struct drm_info_node *node = m->private;
-	struct dentry *parent = node->dent->d_parent;
+	struct dentry *parent = debugfs_node_dentry(node->dent)->d_parent;
 	struct xe_gt *gt = parent->d_inode->i_private;
 	int (*print)(struct xe_gt *, struct drm_printer *) = node->info_ent->data;
 
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
index b0a32211d892..5d65472e6ecf 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
@@ -32,17 +32,20 @@
  *      │   ├── vfN	# d_inode->i_private = VFID(N)
  */
 
-static void *extract_priv(struct dentry *d)
+static void *extract_priv(struct debugfs_node *d)
 {
-	return d->d_inode->i_private;
+	return debugfs_node_inode(d)->i_private;
 }
 
-static struct xe_gt *extract_gt(struct dentry *d)
+static struct xe_gt *extract_gt(struct debugfs_node *d)
 {
-	return extract_priv(d->d_parent);
+	struct dentry *dentry = debugfs_node_dentry(d);
+	struct debugfs_node *parent = debugfs_node_from_dentry(dentry->d_parent);
+
+	return extract_priv(parent);
 }
 
-static unsigned int extract_vfid(struct dentry *d)
+static unsigned int extract_vfid(struct debugfs_node *d)
 {
 	return extract_priv(d) == extract_gt(d) ? PFID : (uintptr_t)extract_priv(d);
 }
@@ -332,7 +335,7 @@ static const struct {
 static ssize_t control_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
 {
 	struct dentry *dent = file_dentry(file);
-	struct debugfs_node *parent = dent->d_parent;
+	struct debugfs_node *parent = debugfs_node_from_dentry(dent->d_parent);
 	struct xe_gt *gt = extract_gt(parent);
 	struct xe_device *xe = gt_to_xe(gt);
 	unsigned int vfid = extract_vfid(parent);
@@ -400,7 +403,7 @@ static ssize_t guc_state_read(struct file *file, char __user *buf,
 			      size_t count, loff_t *pos)
 {
 	struct dentry *dent = file_dentry(file);
-	struct debugfs_node *parent = dent->d_parent;
+	struct debugfs_node *parent = debugfs_node_from_dentry(dent->d_parent);
 	struct xe_gt *gt = extract_gt(parent);
 	unsigned int vfid = extract_vfid(parent);
 
@@ -411,7 +414,7 @@ static ssize_t guc_state_write(struct file *file, const char __user *buf,
 			       size_t count, loff_t *pos)
 {
 	struct dentry *dent = file_dentry(file);
-	struct debugfs_node *parent = dent->d_parent;
+	struct debugfs_node *parent = debugfs_node_from_dentry(dent->d_parent);
 	struct xe_gt *gt = extract_gt(parent);
 	unsigned int vfid = extract_vfid(parent);
 
@@ -438,7 +441,7 @@ static ssize_t config_blob_read(struct file *file, char __user *buf,
 				size_t count, loff_t *pos)
 {
 	struct dentry *dent = file_dentry(file);
-	struct debugfs_node *parent = dent->d_parent;
+	struct debugfs_node *parent = debugfs_node_from_dentry(dent->d_parent);
 	struct xe_gt *gt = extract_gt(parent);
 	unsigned int vfid = extract_vfid(parent);
 	ssize_t ret;
@@ -466,7 +469,7 @@ static ssize_t config_blob_write(struct file *file, const char __user *buf,
 				 size_t count, loff_t *pos)
 {
 	struct dentry *dent = file_dentry(file);
-	struct debugfs_node *parent = dent->d_parent;
+	struct debugfs_node *parent = debugfs_node_from_dentry(dent->d_parent);
 	struct xe_gt *gt = extract_gt(parent);
 	unsigned int vfid = extract_vfid(parent);
 	ssize_t ret;
diff --git a/drivers/gpu/host1x/dev.h b/drivers/gpu/host1x/dev.h
index afd56f7ec84c..5deea78f8c6f 100644
--- a/drivers/gpu/host1x/dev.h
+++ b/drivers/gpu/host1x/dev.h
@@ -53,7 +53,7 @@ struct host1x_pushbuffer_ops {
 };
 
 struct host1x_debug_ops {
-	void (*debug_init)(struct dentry *de);
+	void (*debug_init)(struct debugfs_node *de);
 	void (*show_channel_cdma)(struct host1x *host,
 				  struct host1x_channel *ch,
 				  struct output *o);
diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index f1862b8c37c8..57db75aa8a11 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -130,7 +130,7 @@ struct atk_data {
 	const struct attribute_group *attr_groups[2];
 
 	struct {
-		struct dentry *root;
+		struct debugfs_node *root;
 		u32 id;
 	} debugfs;
 };
diff --git a/drivers/infiniband/hw/hfi1/verbs.h b/drivers/infiniband/hw/hfi1/verbs.h
index 070e4f0babe8..e8c0ff01353f 100644
--- a/drivers/infiniband/hw/hfi1/verbs.h
+++ b/drivers/infiniband/hw/hfi1/verbs.h
@@ -253,9 +253,9 @@ struct hfi1_ibdev {
 
 #ifdef CONFIG_DEBUG_FS
 	/* per HFI debugfs */
-	struct dentry *hfi1_ibdev_dbg;
+	struct debugfs_node *hfi1_ibdev_dbg;
 	/* per HFI symlinks to above */
-	struct dentry *hfi1_ibdev_link;
+	struct debugfs_node *hfi1_ibdev_link;
 #ifdef CONFIG_FAULT_INJECTION
 	struct fault *fault;
 #endif
diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.h b/drivers/infiniband/hw/hns/hns_roce_debugfs.h
index 98e87bd3161e..c1638d3b40da 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.h
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.h
@@ -13,13 +13,13 @@ struct hns_debugfs_seqfile {
 };
 
 struct hns_sw_stat_debugfs {
-	struct dentry *root;
+	struct debugfs_node *root;
 	struct hns_debugfs_seqfile sw_stat;
 };
 
 /* Debugfs for device */
 struct hns_roce_dev_debugfs {
-	struct dentry *root;
+	struct debugfs_node *root;
 	struct hns_sw_stat_debugfs sw_stat_root;
 };
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma.h b/drivers/infiniband/hw/ocrdma/ocrdma.h
index 5eb61c110090..ed144844276a 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma.h
@@ -306,7 +306,7 @@ struct ocrdma_dev {
 	struct ocrdma_stats rx_dbg_stats;
 	struct ocrdma_stats driver_stats;
 	struct ocrdma_stats reset_stats;
-	struct dentry *dir;
+	struct debugfs_node *dir;
 	atomic_t async_err_stats[OCRDMA_MAX_ASYNC_ERRORS];
 	atomic_t cqe_err_stats[OCRDMA_MAX_CQE_ERR];
 	struct ocrdma_pd_resource_mgr *pd_mgr;
diff --git a/drivers/media/platform/chips-media/coda/coda.h b/drivers/media/platform/chips-media/coda/coda.h
index 06b992fa36ea..ca29a43d0747 100644
--- a/drivers/media/platform/chips-media/coda/coda.h
+++ b/drivers/media/platform/chips-media/coda/coda.h
@@ -308,7 +308,8 @@ void coda_write_base(struct coda_ctx *ctx, struct coda_q_data *q_data,
 		     struct vb2_v4l2_buffer *buf, unsigned int reg_y);
 
 int coda_alloc_aux_buf(struct coda_dev *dev, struct coda_aux_buf *buf,
-		       size_t size, const char *name, struct dentry *parent);
+		       size_t size, const char *name,
+		       struct debugfs_node *parent);
 void coda_free_aux_buf(struct coda_dev *dev, struct coda_aux_buf *buf);
 
 int coda_encoder_queue_init(void *priv, struct vb2_queue *src_vq,
diff --git a/drivers/media/platform/raspberrypi/rp1-cfe/csi2.h b/drivers/media/platform/raspberrypi/rp1-cfe/csi2.h
index a8ee5de565fb..4c8379233bb0 100644
--- a/drivers/media/platform/raspberrypi/rp1-cfe/csi2.h
+++ b/drivers/media/platform/raspberrypi/rp1-cfe/csi2.h
@@ -83,7 +83,7 @@ void csi2_start_channel(struct csi2_device *csi2, unsigned int channel,
 void csi2_stop_channel(struct csi2_device *csi2, unsigned int channel);
 void csi2_open_rx(struct csi2_device *csi2);
 void csi2_close_rx(struct csi2_device *csi2);
-int csi2_init(struct csi2_device *csi2, struct dentry *debugfs);
+int csi2_init(struct csi2_device *csi2, struct debugfs_node *debugfs);
 void csi2_uninit(struct csi2_device *csi2);
 
 #endif
diff --git a/drivers/media/platform/raspberrypi/rp1-cfe/pisp-fe.h b/drivers/media/platform/raspberrypi/rp1-cfe/pisp-fe.h
index 54d506e19cf2..e8d654abd5e0 100644
--- a/drivers/media/platform/raspberrypi/rp1-cfe/pisp-fe.h
+++ b/drivers/media/platform/raspberrypi/rp1-cfe/pisp-fe.h
@@ -47,7 +47,7 @@ void pisp_fe_submit_job(struct pisp_fe_device *fe, struct vb2_buffer **vb2_bufs,
 			struct pisp_fe_config *cfg);
 void pisp_fe_start(struct pisp_fe_device *fe);
 void pisp_fe_stop(struct pisp_fe_device *fe);
-int pisp_fe_init(struct pisp_fe_device *fe, struct dentry *debugfs);
+int pisp_fe_init(struct pisp_fe_device *fe, struct debugfs_node *debugfs);
 void pisp_fe_uninit(struct pisp_fe_device *fe);
 
 #endif
diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h
index c1b124c6ef12..333fcf792297 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h
@@ -73,7 +73,7 @@ struct c8sectpfei {
 	struct device *dev;
 	struct pinctrl *pinctrl;
 
-	struct dentry *root;
+	struct debugfs_node *root;
 	struct debugfs_regset32	*regset;
 	struct completion fw_ack;
 	atomic_t fw_loaded;
diff --git a/drivers/media/test-drivers/visl/visl-debugfs.c b/drivers/media/test-drivers/visl/visl-debugfs.c
index b332614a1325..fb9164029cf4 100644
--- a/drivers/media/test-drivers/visl/visl-debugfs.c
+++ b/drivers/media/test-drivers/visl/visl-debugfs.c
@@ -59,7 +59,7 @@ void visl_trace_bitstream(struct visl_ctx *ctx, struct visl_run *run)
 	memcpy(blob->blob.data, vaddr, data_sz);
 
 	dentry = debugfs_create_blob(name, 0444, ctx->dev->bitstream_debugfs,
-				     &blob->blob);
+				   &blob->blob);
 	if (IS_ERR(dentry))
 		goto err_debugfs;
 
diff --git a/drivers/media/test-drivers/visl/visl.h b/drivers/media/test-drivers/visl/visl.h
index 2cdba86e6ca2..816c6398d82b 100644
--- a/drivers/media/test-drivers/visl/visl.h
+++ b/drivers/media/test-drivers/visl/visl.h
@@ -133,7 +133,7 @@ enum visl_codec {
 
 struct visl_blob {
 	struct list_head list;
-	struct dentry *dentry;
+	struct debugfs_node *dentry;
 	struct debugfs_blob_wrapper blob;
 };
 
diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 03f1daa2d132..aae54b819633 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -496,7 +496,7 @@ struct tegra_emc {
 	unsigned int num_timings;
 
 	struct {
-		struct dentry *root;
+		struct debugfs_node *root;
 		unsigned long min_rate;
 		unsigned long max_rate;
 	} debugfs;
diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index bc807d7fcd4e..693c7f9c8b84 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -27,7 +27,7 @@ struct tegra186_emc {
 	unsigned int num_dvfs;
 
 	struct {
-		struct dentry *root;
+		struct debugfs_node *root;
 		unsigned long min_rate;
 		unsigned long max_rate;
 	} debugfs;
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 9b7d30a21a5b..3647902658c5 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -207,7 +207,7 @@ struct tegra_emc {
 	unsigned int num_timings;
 
 	struct {
-		struct dentry *root;
+		struct debugfs_node *root;
 		unsigned long min_rate;
 		unsigned long max_rate;
 	} debugfs;
diff --git a/drivers/memory/tegra/tegra210-emc.h b/drivers/memory/tegra/tegra210-emc.h
index 8988bcf15290..90b802142445 100644
--- a/drivers/memory/tegra/tegra210-emc.h
+++ b/drivers/memory/tegra/tegra210-emc.h
@@ -925,7 +925,7 @@ struct tegra210_emc {
 	unsigned long resume_rate;
 
 	struct {
-		struct dentry *root;
+		struct debugfs_node *root;
 		unsigned long min_rate;
 		unsigned long max_rate;
 		unsigned int temperature;
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 921dce1b8bc6..49b92e03c9d0 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -378,7 +378,7 @@ struct tegra_emc {
 	bool dll_on : 1;
 
 	struct {
-		struct dentry *root;
+		struct debugfs_node *root;
 		unsigned long min_rate;
 		unsigned long max_rate;
 	} debugfs;
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index d889799046bc..130e890e31a8 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -637,8 +637,8 @@ struct cxl_service_layer_ops {
 	int (*attach_afu_directed)(struct cxl_context *ctx, u64 wed, u64 amr);
 	int (*attach_dedicated_process)(struct cxl_context *ctx, u64 wed, u64 amr);
 	void (*update_dedicated_ivtes)(struct cxl_context *ctx);
-	void (*debugfs_add_adapter_regs)(struct cxl *adapter, struct dentry *dir);
-	void (*debugfs_add_afu_regs)(struct cxl_afu *afu, struct dentry *dir);
+	void (*debugfs_add_adapter_regs)(struct cxl *adapter, struct debugfs_node *dir);
+	void (*debugfs_add_afu_regs)(struct cxl_afu *afu, struct debugfs_node *dir);
 	void (*psl_irq_dump_registers)(struct cxl_context *ctx);
 	void (*err_irq_dump_registers)(struct cxl *adapter);
 	void (*debugfs_stop_trace)(struct cxl *adapter);
diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 885b311379d4..78cb7801818b 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -330,6 +330,7 @@ static ssize_t dfs_file_read(struct file *file, char __user *user_buf,
 {
 	unsigned long ubi_num = (unsigned long)file->private_data;
 	struct dentry *dent = file->f_path.dentry;
+	struct debugfs_node *node = debugfs_node_from_dentry(dent);
 	struct ubi_device *ubi;
 	struct ubi_debug_info *d;
 	char buf[16];
@@ -340,34 +341,34 @@ static ssize_t dfs_file_read(struct file *file, char __user *user_buf,
 		return -ENODEV;
 	d = &ubi->dbg;
 
-	if (dent == d->dfs_chk_gen)
+	if (node == d->dfs_chk_gen)
 		val = d->chk_gen;
-	else if (dent == d->dfs_chk_io)
+	else if (node == d->dfs_chk_io)
 		val = d->chk_io;
-	else if (dent == d->dfs_chk_fastmap)
+	else if (node == d->dfs_chk_fastmap)
 		val = d->chk_fastmap;
-	else if (dent == d->dfs_disable_bgt)
+	else if (node == d->dfs_disable_bgt)
 		val = d->disable_bgt;
-	else if (dent == d->dfs_emulate_bitflips)
+	else if (node == d->dfs_emulate_bitflips)
 		val = d->emulate_bitflips;
-	else if (dent == d->dfs_emulate_io_failures)
+	else if (node == d->dfs_emulate_io_failures)
 		val = d->emulate_io_failures;
-	else if (dent == d->dfs_emulate_failures) {
+	else if (node == d->dfs_emulate_failures) {
 		snprintf(buf, sizeof(buf), "0x%04x\n", d->emulate_failures);
 		count = simple_read_from_buffer(user_buf, count, ppos,
 						buf, strlen(buf));
 		goto out;
-	} else if (dent == d->dfs_emulate_power_cut) {
+	} else if (node == d->dfs_emulate_power_cut) {
 		snprintf(buf, sizeof(buf), "%u\n", d->emulate_power_cut);
 		count = simple_read_from_buffer(user_buf, count, ppos,
 						buf, strlen(buf));
 		goto out;
-	} else if (dent == d->dfs_power_cut_min) {
+	} else if (node == d->dfs_power_cut_min) {
 		snprintf(buf, sizeof(buf), "%u\n", d->power_cut_min);
 		count = simple_read_from_buffer(user_buf, count, ppos,
 						buf, strlen(buf));
 		goto out;
-	} else if (dent == d->dfs_power_cut_max) {
+	} else if (node == d->dfs_power_cut_max) {
 		snprintf(buf, sizeof(buf), "%u\n", d->power_cut_max);
 		count = simple_read_from_buffer(user_buf, count, ppos,
 						buf, strlen(buf));
@@ -397,6 +398,7 @@ static ssize_t dfs_file_write(struct file *file, const char __user *user_buf,
 {
 	unsigned long ubi_num = (unsigned long)file->private_data;
 	struct dentry *dent = file->f_path.dentry;
+	struct debugfs_node *node = debugfs_node_from_dentry(dent);
 	struct ubi_device *ubi;
 	struct ubi_debug_info *d;
 	size_t buf_size;
@@ -414,19 +416,19 @@ static ssize_t dfs_file_write(struct file *file, const char __user *user_buf,
 		goto out;
 	}
 
-	if (dent == d->dfs_emulate_failures) {
+	if (node == d->dfs_emulate_failures) {
 		if (kstrtouint(buf, 0, &d->emulate_failures) != 0)
 			count = -EINVAL;
 		goto out;
-	} else if (dent == d->dfs_power_cut_min) {
+	} else if (node == d->dfs_power_cut_min) {
 		if (kstrtouint(buf, 0, &d->power_cut_min) != 0)
 			count = -EINVAL;
 		goto out;
-	} else if (dent == d->dfs_power_cut_max) {
+	} else if (node == d->dfs_power_cut_max) {
 		if (kstrtouint(buf, 0, &d->power_cut_max) != 0)
 			count = -EINVAL;
 		goto out;
-	} else if (dent == d->dfs_emulate_power_cut) {
+	} else if (node == d->dfs_emulate_power_cut) {
 		if (kstrtoint(buf, 0, &val) != 0)
 			count = -EINVAL;
 		else
@@ -443,17 +445,17 @@ static ssize_t dfs_file_write(struct file *file, const char __user *user_buf,
 		goto out;
 	}
 
-	if (dent == d->dfs_chk_gen)
+	if (node == d->dfs_chk_gen)
 		d->chk_gen = val;
-	else if (dent == d->dfs_chk_io)
+	else if (node == d->dfs_chk_io)
 		d->chk_io = val;
-	else if (dent == d->dfs_chk_fastmap)
+	else if (node == d->dfs_chk_fastmap)
 		d->chk_fastmap = val;
-	else if (dent == d->dfs_disable_bgt)
+	else if (node == d->dfs_disable_bgt)
 		d->disable_bgt = val;
-	else if (dent == d->dfs_emulate_bitflips)
+	else if (node == d->dfs_emulate_bitflips)
 		d->emulate_bitflips = val;
-	else if (dent == d->dfs_emulate_io_failures)
+	else if (node == d->dfs_emulate_io_failures)
 		d->emulate_io_failures = val;
 	else
 		count = -EINVAL;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index 3985b465683c..0952d161cd8c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -128,7 +128,7 @@ static const struct hbg_dbg_info hbg_dbg_infos[] = {
 
 static void hbg_debugfs_uninit(void *data)
 {
-	debugfs_remove_recursive((struct dentry *)data);
+	debugfs_remove_recursive((struct debugfs_node *)data);
 }
 
 void hbg_debugfs_init(struct hbg_priv *priv)
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_dev.h b/drivers/net/ethernet/huawei/hinic/hinic_dev.h
index 7ce49031c76a..fcf906d06166 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_dev.h
@@ -72,7 +72,7 @@ struct hinic_debug_priv {
 	struct hinic_dev	*dev;
 	void			*object;
 	enum hinic_dbg_type	type;
-	struct dentry		*root;
+	struct debugfs_node	*root;
 	int			field_id[64];
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 0a1250fbeaa4..ada8a1bb3746 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -573,7 +573,7 @@ struct ice_pf {
 	struct debugfs_node *ice_debugfs_pf;
 	struct debugfs_node *ice_debugfs_pf_fwlog;
 	/* keep track of all the dentrys for FW log modules */
-	struct dentry **ice_debugfs_pf_fwlog_modules;
+	struct debugfs_node **ice_debugfs_pf_fwlog_modules;
 	struct ice_vfs vfs;
 	DECLARE_BITMAP(features, ICE_F_MAX);
 	DECLARE_BITMAP(state, ICE_STATE_NBITS);
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 86b3494737c6..850642b3cf80 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -106,11 +106,12 @@ ice_fwlog_print_module_cfg(struct ice_hw *hw, int module, struct seq_file *s)
 static int ice_find_module_by_dentry(struct ice_pf *pf, struct dentry *d)
 {
 	int i, module;
+	struct debugfs_node *node = debugfs_node_from_dentry(d);
 
 	module = -1;
 	/* find the module based on the dentry */
 	for (i = 0; i < ICE_NR_FW_LOG_MODULES; i++) {
-		if (d == pf->ice_debugfs_pf_fwlog_modules[i]) {
+		if (node == pf->ice_debugfs_pf_fwlog_modules[i]) {
 			module = i;
 			break;
 		}
@@ -585,7 +586,7 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 {
 	const char *name = pci_name(pf->pdev);
 	struct debugfs_node *fw_modules_dir;
-	struct dentry **fw_modules;
+	struct debugfs_node **fw_modules;
 	int i;
 
 	/* only support fw log commands on PF 0 */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index 92d36a7f03f8..353c1019c84c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -219,7 +219,7 @@ mlx5_cmdif_alloc_stats(struct xarray *stats_xa, int opcode)
 void mlx5_cmdif_debugfs_init(struct mlx5_core_dev *dev)
 {
 	struct mlx5_cmd_stats *stats;
-	struct dentry **cmd;
+	struct debugfs_node **cmd;
 	const char *namep;
 	int i;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index 1e8b7d330701..1d145fec7762 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -147,7 +147,7 @@ void mlx5e_destroy_flow_steering(struct mlx5e_flow_steering *fs, bool ntuple,
 struct mlx5e_flow_steering *mlx5e_fs_init(const struct mlx5e_profile *profile,
 					  struct mlx5_core_dev *mdev,
 					  bool state_destroy,
-					  struct dentry *dfs_root);
+					  struct debugfs_node *dfs_root);
 void mlx5e_fs_cleanup(struct mlx5e_flow_steering *fs);
 struct mlx5e_vlan_table *mlx5e_fs_get_vlan(struct mlx5e_flow_steering *fs);
 struct mlx5e_tc_table *mlx5e_fs_get_tc(struct mlx5e_flow_steering *fs);
@@ -203,7 +203,7 @@ int mlx5e_fs_vlan_rx_kill_vid(struct mlx5e_flow_steering *fs,
 			      __be16 proto, u16 vid);
 void mlx5e_fs_init_l2_addr(struct mlx5e_flow_steering *fs, struct net_device *netdev);
 
-struct dentry *mlx5e_fs_get_debugfs_root(struct mlx5e_flow_steering *fs);
+struct debugfs_node *mlx5e_fs_get_debugfs_root(struct mlx5e_flow_steering *fs);
 
 #define fs_err(fs, fmt, ...) \
 	mlx5_core_err(mlx5e_fs_get_mdev(fs), fmt, ##__VA_ARGS__)
@@ -218,4 +218,3 @@ struct dentry *mlx5e_fs_get_debugfs_root(struct mlx5e_flow_steering *fs);
 	mlx5_core_warn_once(mlx5e_fs_get_mdev(fs), fmt, ##__VA_ARGS__)
 
 #endif /* __MLX5E_FLOW_STEER_H__ */
-
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
index 07a04a142a2e..a51cb06183cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
@@ -78,8 +78,8 @@ struct mlx5e_tls_sw_stats {
 };
 
 struct mlx5e_tls_debugfs {
-	struct dentry *dfs;
-	struct dentry *dfs_tx;
+	struct debugfs_node *dfs;
+	struct debugfs_node *dfs_tx;
 };
 
 struct mlx5e_tls {
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net.h b/drivers/net/ethernet/netronome/nfp/nfp_net.h
index 19e25380273e..7d8d250aadb9 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net.h
@@ -1028,7 +1028,7 @@ void nfp_net_debugfs_create(void);
 void nfp_net_debugfs_destroy(void);
 struct debugfs_node *nfp_net_debugfs_device_add(struct pci_dev *pdev);
 void nfp_net_debugfs_vnic_add(struct nfp_net *nn, struct debugfs_node *ddir);
-void nfp_net_debugfs_dir_clean(struct dentry **dir);
+void nfp_net_debugfs_dir_clean(struct debugfs_node **dir);
 #else
 static inline void nfp_net_debugfs_create(void)
 {
@@ -1048,7 +1048,7 @@ nfp_net_debugfs_vnic_add(struct nfp_net *nn, struct debugfs_node *ddir)
 {
 }
 
-static inline void nfp_net_debugfs_dir_clean(struct dentry **dir)
+static inline void nfp_net_debugfs_dir_clean(struct debugfs_node **dir)
 {
 }
 #endif /* CONFIG_NFP_DEBUG */
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c b/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
index fb7df43f30cf..f2587bba7355 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
@@ -163,7 +163,7 @@ struct debugfs_node *nfp_net_debugfs_device_add(struct pci_dev *pdev)
 	return debugfs_create_dir(pci_name(pdev), nfp_dir);
 }
 
-void nfp_net_debugfs_dir_clean(struct dentry **dir)
+void nfp_net_debugfs_dir_clean(struct debugfs_node **dir)
 {
 	debugfs_remove_recursive(*dir);
 	*dir = NULL;
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/ethernet/qualcomm/qca_spi.h
index 90b290f94c27..ee558d6254f5 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -85,7 +85,7 @@ struct qcaspi {
 	u16 reset_count;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *device_root;
+	struct debugfs_node *device_root;
 #endif
 
 	/* user configurable options */
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index a1b920eb6844..57a22c30a59a 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -134,7 +134,7 @@ struct netdevsim {
 		u32 sleep;
 		u32 __ports[2][NSIM_UDP_TUNNEL_N_PORTS];
 		u32 (*ports)[NSIM_UDP_TUNNEL_N_PORTS];
-		struct dentry *ddir;
+		struct debugfs_node *ddir;
 		struct debugfs_u32_array dfs_ports[2];
 	} udp_ports;
 
diff --git a/drivers/net/wireless/ath/ath11k/spectral.h b/drivers/net/wireless/ath/ath11k/spectral.h
index 789cff7c64a7..2598a47c67fe 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.h
+++ b/drivers/net/wireless/ath/ath11k/spectral.h
@@ -29,9 +29,9 @@ struct ath11k_spectral {
 	/* Protects enabled */
 	spinlock_t lock;
 	struct rchan *rfs_scan;	/* relay(fs) channel for spectral scan */
-	struct dentry *scan_ctl;
-	struct dentry *scan_count;
-	struct dentry *scan_bins;
+	struct debugfs_node *scan_ctl;
+	struct debugfs_node *scan_count;
+	struct debugfs_node *scan_bins;
 	enum ath11k_spectral_mode mode;
 	u16 count;
 	u8 fft_size;
diff --git a/drivers/net/wireless/ath/ath9k/common-debug.h b/drivers/net/wireless/ath/ath9k/common-debug.h
index 2938b5b96b07..76dd1a875758 100644
--- a/drivers/net/wireless/ath/ath9k/common-debug.h
+++ b/drivers/net/wireless/ath/ath9k/common-debug.h
@@ -65,23 +65,23 @@ struct ath_rx_stats {
 };
 
 #ifdef CONFIG_ATH9K_COMMON_DEBUG
-void ath9k_cmn_debug_modal_eeprom(struct dentry *debugfs_phy,
+void ath9k_cmn_debug_modal_eeprom(struct debugfs_node *debugfs_phy,
 				  struct ath_hw *ah);
-void ath9k_cmn_debug_base_eeprom(struct dentry *debugfs_phy,
+void ath9k_cmn_debug_base_eeprom(struct debugfs_node *debugfs_phy,
 				 struct ath_hw *ah);
 void ath9k_cmn_debug_stat_rx(struct ath_rx_stats *rxstats,
 			     struct ath_rx_status *rs);
-void ath9k_cmn_debug_recv(struct dentry *debugfs_phy,
+void ath9k_cmn_debug_recv(struct debugfs_node *debugfs_phy,
 			  struct ath_rx_stats *rxstats);
-void ath9k_cmn_debug_phy_err(struct dentry *debugfs_phy,
+void ath9k_cmn_debug_phy_err(struct debugfs_node *debugfs_phy,
 			     struct ath_rx_stats *rxstats);
 #else
-static inline void ath9k_cmn_debug_modal_eeprom(struct dentry *debugfs_phy,
+static inline void ath9k_cmn_debug_modal_eeprom(struct debugfs_node *debugfs_phy,
 						struct ath_hw *ah)
 {
 }
 
-static inline void ath9k_cmn_debug_base_eeprom(struct dentry *debugfs_phy,
+static inline void ath9k_cmn_debug_base_eeprom(struct debugfs_node *debugfs_phy,
 					       struct ath_hw *ah)
 {
 }
@@ -91,12 +91,12 @@ static inline void ath9k_cmn_debug_stat_rx(struct ath_rx_stats *rxstats,
 {
 }
 
-static inline void ath9k_cmn_debug_recv(struct dentry *debugfs_phy,
+static inline void ath9k_cmn_debug_recv(struct debugfs_node *debugfs_phy,
 					struct ath_rx_stats *rxstats)
 {
 }
 
-static inline void ath9k_cmn_debug_phy_err(struct dentry *debugfs_phy,
+static inline void ath9k_cmn_debug_phy_err(struct debugfs_node *debugfs_phy,
 					   struct ath_rx_stats *rxstats)
 {
 }
diff --git a/drivers/net/wireless/ath/ath9k/common-spectral.h b/drivers/net/wireless/ath/ath9k/common-spectral.h
index 011d8ab8b974..d7990a899b6b 100644
--- a/drivers/net/wireless/ath/ath9k/common-spectral.h
+++ b/drivers/net/wireless/ath/ath9k/common-spectral.h
@@ -169,7 +169,8 @@ static inline u8 spectral_bitmap_weight(u8 *bins)
 }
 
 #ifdef CONFIG_ATH9K_COMMON_SPECTRAL
-void ath9k_cmn_spectral_init_debug(struct ath_spec_scan_priv *spec_priv, struct dentry *debugfs_phy);
+void ath9k_cmn_spectral_init_debug(struct ath_spec_scan_priv *spec_priv,
+				   struct debugfs_node *debugfs_phy);
 void ath9k_cmn_spectral_deinit_debug(struct ath_spec_scan_priv *spec_priv);
 
 void ath9k_cmn_spectral_scan_trigger(struct ath_common *common,
@@ -181,7 +182,7 @@ int ath_cmn_process_fft(struct ath_spec_scan_priv *spec_priv, struct ieee80211_h
 		    struct ath_rx_status *rs, u64 tsf);
 #else
 static inline void ath9k_cmn_spectral_init_debug(struct ath_spec_scan_priv *spec_priv,
-						 struct dentry *debugfs_phy)
+						 struct debugfs_node *debugfs_phy)
 {
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/debug.h b/drivers/net/wireless/ath/ath9k/debug.h
index 932001c8ec14..a679b8366d9a 100644
--- a/drivers/net/wireless/ath/ath9k/debug.h
+++ b/drivers/net/wireless/ath/ath9k/debug.h
@@ -272,7 +272,7 @@ void ath9k_get_et_strings(struct ieee80211_hw *hw,
 void ath9k_sta_add_debugfs(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta,
-			   struct dentry *dir);
+			   struct debugfs_node *dir);
 void ath9k_debug_stat_ant(struct ath_softc *sc,
 			  struct ath_hw_antcomb_conf *div_ant_conf,
 			  int main_rssi_avg, int alt_rssi_avg);
diff --git a/drivers/net/wireless/ath/wcn36xx/debug.c b/drivers/net/wireless/ath/wcn36xx/debug.c
index 07520cd4f28e..d71dd9f76467 100644
--- a/drivers/net/wireless/ath/wcn36xx/debug.c
+++ b/drivers/net/wireless/ath/wcn36xx/debug.c
@@ -179,10 +179,10 @@ static const struct file_operations fops_wcn36xx_firmware_feat_caps = {
 		d = debugfs_create_file(__stringify(name),	\
 					mode, dfs->rootdir,	\
 					priv_data, fop);	\
-		dfs->file_##name.dentry = d;			\
+		dfs->file_##name.node = d;			\
 		if (IS_ERR(d)) {				\
 			wcn36xx_warn("Create the debugfs entry failed");\
-			dfs->file_##name.dentry = NULL;		\
+			dfs->file_##name.node = NULL;		\
 		}						\
 	} while (0)
 
diff --git a/drivers/net/wireless/ath/wcn36xx/debug.h b/drivers/net/wireless/ath/wcn36xx/debug.h
index fe3d7f29168a..d53897a4a6b8 100644
--- a/drivers/net/wireless/ath/wcn36xx/debug.h
+++ b/drivers/net/wireless/ath/wcn36xx/debug.h
@@ -23,7 +23,7 @@
 
 #ifdef CONFIG_WCN36XX_DEBUGFS
 struct wcn36xx_dfs_file {
-	struct dentry *dentry;
+	struct debugfs_node *node;
 	u32 value;
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
index 523d27589024..be142518d55d 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
@@ -2369,9 +2369,10 @@ void iwl_dbgfs_register(struct iwl_priv *priv, struct debugfs_node *dbgfs_dir)
 	 */
 	if (priv->mac80211_registered) {
 		char buf[100];
-		struct debugfs_node *mac80211_dir, *dev_dir;
+		struct dentry *dev_dir;
+		struct debugfs_node *mac80211_dir;
 
-		dev_dir = dbgfs_dir->d_parent;
+		dev_dir = debugfs_node_dentry(dbgfs_dir)->d_parent;
 		mac80211_dir = priv->hw->wiphy->debugfsdir;
 
 		snprintf(buf, 100, "../../%pd2", dev_dir);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 048877fa7c71..b55ceebdd0c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -189,7 +189,7 @@ void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
 			const struct iwl_fw_runtime_ops *ops, void *ops_ctx,
 			const struct iwl_dump_sanitize_ops *sanitize_ops,
 			void *sanitize_ctx,
-			struct dentry *dbgfs_dir);
+			struct debugfs_node *dbgfs_dir);
 
 static inline void iwl_fw_runtime_free(struct iwl_fw_runtime *fwrt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index 34eca1a568ea..1a209ee6eedf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -144,7 +144,7 @@ struct iwl_op_mode_ops {
 	struct iwl_op_mode *(*start)(struct iwl_trans *trans,
 				     const struct iwl_cfg *cfg,
 				     const struct iwl_fw *fw,
-				     struct dentry *dbgfs_dir);
+				     struct debugfs_node *dbgfs_dir);
 	void (*stop)(struct iwl_op_mode *op_mode);
 	void (*rx)(struct iwl_op_mode *op_mode, struct napi_struct *napi,
 		   struct iwl_rx_cmd_buffer *rxb);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index fa44ce62eb57..add11bb039c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -2194,8 +2194,9 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	 */
 	if (!IS_ERR(mvm->debugfs_dir)) {
 		char buf[100];
+		struct dentry *dir = debugfs_node_dentry(mvm->debugfs_dir);
 
-		snprintf(buf, 100, "../../%pd2", mvm->debugfs_dir->d_parent);
+		snprintf(buf, 100, "../../%pd2", dir->d_parent);
 		debugfs_create_symlink("iwlwifi", mvm->hw->wiphy->debugfsdir,
 				       buf);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 984f407f7027..9478d4564bcd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1273,7 +1273,7 @@ static void iwl_mvm_trig_link_selection(struct wiphy *wiphy,
 
 static struct iwl_op_mode *
 iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
-		      const struct iwl_fw *fw, struct dentry *dbgfs_dir)
+		      const struct iwl_fw *fw, struct debugfs_node *dbgfs_dir)
 {
 	struct ieee80211_hw *hw;
 	struct iwl_op_mode *op_mode;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index c917ed4c19bc..1c2fc2fb2699 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3311,7 +3311,7 @@ static const struct file_operations iwl_dbgfs_monitor_data_ops = {
 /* Create the debugfs files and directories */
 void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans)
 {
-	struct dentry *dir = trans->dbgfs_dir;
+	struct debugfs_node *dir = trans->dbgfs_dir;
 
 	DEBUGFS_ADD_FILE(rx_queue, dir, 0400);
 	DEBUGFS_ADD_FILE(tx_queue, dir, 0400);
diff --git a/drivers/net/wireless/marvell/libertas/dev.h b/drivers/net/wireless/marvell/libertas/dev.h
index d5fd3068e128..37532824764f 100644
--- a/drivers/net/wireless/marvell/libertas/dev.h
+++ b/drivers/net/wireless/marvell/libertas/dev.h
@@ -65,9 +65,9 @@ struct lbs_private {
 	struct debugfs_node *debugfs_dir;
 	struct debugfs_node *debugfs_debug;
 	struct debugfs_node *debugfs_files[6];
-	struct dentry *events_dir;
+	struct debugfs_node *events_dir;
 	struct debugfs_node *debugfs_events_files[6];
-	struct dentry *regs_dir;
+	struct debugfs_node *regs_dir;
 	struct debugfs_node *debugfs_regs_files[6];
 
 	/* Hardware debugging */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 5a73fafbd611..1d9c9ae51f58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -743,7 +743,7 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id);
 
 #ifdef CONFIG_MTK_DEBUG
-int mt7996_mtk_init_debugfs(struct mt7996_phy *phy, struct dentry *dir);
+int mt7996_mtk_init_debugfs(struct mt7996_phy *phy, struct debugfs_node *dir);
 #endif
 
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index 0b2286993bf6..3a7e5350c17e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -436,7 +436,7 @@ void rtl_debug_add_one(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	struct dentry *parent;
+	struct debugfs_node *parent;
 
 	snprintf(rtlpriv->dbg.debugfs_name, 18, "%pMF", rtlefuse->dev_addr);
 
diff --git a/drivers/net/wireless/rsi/rsi_debugfs.h b/drivers/net/wireless/rsi/rsi_debugfs.h
index e24f0e6a22b0..c4b375655ae9 100644
--- a/drivers/net/wireless/rsi/rsi_debugfs.h
+++ b/drivers/net/wireless/rsi/rsi_debugfs.h
@@ -39,7 +39,7 @@ struct rsi_dbg_files {
 
 struct rsi_debugfs {
 	struct debugfs_node *subdir;
-	struct dentry *rsi_files[MAX_DEBUGFS_ENTRIES];
+	struct debugfs_node *rsi_files[MAX_DEBUGFS_ENTRIES];
 };
 int rsi_init_dbgfs(struct rsi_hw *adapter);
 void rsi_remove_dbgfs(struct rsi_hw *adapter);
diff --git a/drivers/net/wireless/ti/wl1251/wl1251.h b/drivers/net/wireless/ti/wl1251/wl1251.h
index 7f108d6809ea..bda49d0d652b 100644
--- a/drivers/net/wireless/ti/wl1251/wl1251.h
+++ b/drivers/net/wireless/ti/wl1251/wl1251.h
@@ -146,102 +146,102 @@ struct wl1251_debugfs {
 	struct debugfs_node *rootdir;
 	struct debugfs_node *fw_statistics;
 
-	struct dentry *tx_internal_desc_overflow;
-
-	struct dentry *rx_out_of_mem;
-	struct dentry *rx_hdr_overflow;
-	struct dentry *rx_hw_stuck;
-	struct dentry *rx_dropped;
-	struct dentry *rx_fcs_err;
-	struct dentry *rx_xfr_hint_trig;
-	struct dentry *rx_path_reset;
-	struct dentry *rx_reset_counter;
-
-	struct dentry *dma_rx_requested;
-	struct dentry *dma_rx_errors;
-	struct dentry *dma_tx_requested;
-	struct dentry *dma_tx_errors;
-
-	struct dentry *isr_cmd_cmplt;
-	struct dentry *isr_fiqs;
-	struct dentry *isr_rx_headers;
-	struct dentry *isr_rx_mem_overflow;
-	struct dentry *isr_rx_rdys;
-	struct dentry *isr_irqs;
-	struct dentry *isr_tx_procs;
-	struct dentry *isr_decrypt_done;
-	struct dentry *isr_dma0_done;
-	struct dentry *isr_dma1_done;
-	struct dentry *isr_tx_exch_complete;
-	struct dentry *isr_commands;
-	struct dentry *isr_rx_procs;
-	struct dentry *isr_hw_pm_mode_changes;
-	struct dentry *isr_host_acknowledges;
-	struct dentry *isr_pci_pm;
-	struct dentry *isr_wakeups;
-	struct dentry *isr_low_rssi;
-
-	struct dentry *wep_addr_key_count;
-	struct dentry *wep_default_key_count;
+	struct debugfs_node *tx_internal_desc_overflow;
+
+	struct debugfs_node *rx_out_of_mem;
+	struct debugfs_node *rx_hdr_overflow;
+	struct debugfs_node *rx_hw_stuck;
+	struct debugfs_node *rx_dropped;
+	struct debugfs_node *rx_fcs_err;
+	struct debugfs_node *rx_xfr_hint_trig;
+	struct debugfs_node *rx_path_reset;
+	struct debugfs_node *rx_reset_counter;
+
+	struct debugfs_node *dma_rx_requested;
+	struct debugfs_node *dma_rx_errors;
+	struct debugfs_node *dma_tx_requested;
+	struct debugfs_node *dma_tx_errors;
+
+	struct debugfs_node *isr_cmd_cmplt;
+	struct debugfs_node *isr_fiqs;
+	struct debugfs_node *isr_rx_headers;
+	struct debugfs_node *isr_rx_mem_overflow;
+	struct debugfs_node *isr_rx_rdys;
+	struct debugfs_node *isr_irqs;
+	struct debugfs_node *isr_tx_procs;
+	struct debugfs_node *isr_decrypt_done;
+	struct debugfs_node *isr_dma0_done;
+	struct debugfs_node *isr_dma1_done;
+	struct debugfs_node *isr_tx_exch_complete;
+	struct debugfs_node *isr_commands;
+	struct debugfs_node *isr_rx_procs;
+	struct debugfs_node *isr_hw_pm_mode_changes;
+	struct debugfs_node *isr_host_acknowledges;
+	struct debugfs_node *isr_pci_pm;
+	struct debugfs_node *isr_wakeups;
+	struct debugfs_node *isr_low_rssi;
+
+	struct debugfs_node *wep_addr_key_count;
+	struct debugfs_node *wep_default_key_count;
 	/* skipping wep.reserved */
-	struct dentry *wep_key_not_found;
-	struct dentry *wep_decrypt_fail;
-	struct dentry *wep_packets;
-	struct dentry *wep_interrupt;
-
-	struct dentry *pwr_ps_enter;
-	struct dentry *pwr_elp_enter;
-	struct dentry *pwr_missing_bcns;
-	struct dentry *pwr_wake_on_host;
-	struct dentry *pwr_wake_on_timer_exp;
-	struct dentry *pwr_tx_with_ps;
-	struct dentry *pwr_tx_without_ps;
-	struct dentry *pwr_rcvd_beacons;
-	struct dentry *pwr_power_save_off;
-	struct dentry *pwr_enable_ps;
-	struct dentry *pwr_disable_ps;
-	struct dentry *pwr_fix_tsf_ps;
+	struct debugfs_node *wep_key_not_found;
+	struct debugfs_node *wep_decrypt_fail;
+	struct debugfs_node *wep_packets;
+	struct debugfs_node *wep_interrupt;
+
+	struct debugfs_node *pwr_ps_enter;
+	struct debugfs_node *pwr_elp_enter;
+	struct debugfs_node *pwr_missing_bcns;
+	struct debugfs_node *pwr_wake_on_host;
+	struct debugfs_node *pwr_wake_on_timer_exp;
+	struct debugfs_node *pwr_tx_with_ps;
+	struct debugfs_node *pwr_tx_without_ps;
+	struct debugfs_node *pwr_rcvd_beacons;
+	struct debugfs_node *pwr_power_save_off;
+	struct debugfs_node *pwr_enable_ps;
+	struct debugfs_node *pwr_disable_ps;
+	struct debugfs_node *pwr_fix_tsf_ps;
 	/* skipping cont_miss_bcns_spread for now */
-	struct dentry *pwr_rcvd_awake_beacons;
-
-	struct dentry *mic_rx_pkts;
-	struct dentry *mic_calc_failure;
-
-	struct dentry *aes_encrypt_fail;
-	struct dentry *aes_decrypt_fail;
-	struct dentry *aes_encrypt_packets;
-	struct dentry *aes_decrypt_packets;
-	struct dentry *aes_encrypt_interrupt;
-	struct dentry *aes_decrypt_interrupt;
-
-	struct dentry *event_heart_beat;
-	struct dentry *event_calibration;
-	struct dentry *event_rx_mismatch;
-	struct dentry *event_rx_mem_empty;
-	struct dentry *event_rx_pool;
-	struct dentry *event_oom_late;
-	struct dentry *event_phy_transmit_error;
-	struct dentry *event_tx_stuck;
-
-	struct dentry *ps_pspoll_timeouts;
-	struct dentry *ps_upsd_timeouts;
-	struct dentry *ps_upsd_max_sptime;
-	struct dentry *ps_upsd_max_apturn;
-	struct dentry *ps_pspoll_max_apturn;
-	struct dentry *ps_pspoll_utilization;
-	struct dentry *ps_upsd_utilization;
-
-	struct dentry *rxpipe_rx_prep_beacon_drop;
-	struct dentry *rxpipe_descr_host_int_trig_rx_data;
-	struct dentry *rxpipe_beacon_buffer_thres_host_int_trig_rx_data;
-	struct dentry *rxpipe_missed_beacon_host_int_trig_rx_data;
-	struct dentry *rxpipe_tx_xfr_host_int_trig_rx_data;
-
-	struct dentry *tx_queue_len;
-	struct dentry *tx_queue_status;
-
-	struct dentry *retry_count;
-	struct dentry *excessive_retries;
+	struct debugfs_node *pwr_rcvd_awake_beacons;
+
+	struct debugfs_node *mic_rx_pkts;
+	struct debugfs_node *mic_calc_failure;
+
+	struct debugfs_node *aes_encrypt_fail;
+	struct debugfs_node *aes_decrypt_fail;
+	struct debugfs_node *aes_encrypt_packets;
+	struct debugfs_node *aes_decrypt_packets;
+	struct debugfs_node *aes_encrypt_interrupt;
+	struct debugfs_node *aes_decrypt_interrupt;
+
+	struct debugfs_node *event_heart_beat;
+	struct debugfs_node *event_calibration;
+	struct debugfs_node *event_rx_mismatch;
+	struct debugfs_node *event_rx_mem_empty;
+	struct debugfs_node *event_rx_pool;
+	struct debugfs_node *event_oom_late;
+	struct debugfs_node *event_phy_transmit_error;
+	struct debugfs_node *event_tx_stuck;
+
+	struct debugfs_node *ps_pspoll_timeouts;
+	struct debugfs_node *ps_upsd_timeouts;
+	struct debugfs_node *ps_upsd_max_sptime;
+	struct debugfs_node *ps_upsd_max_apturn;
+	struct debugfs_node *ps_pspoll_max_apturn;
+	struct debugfs_node *ps_pspoll_utilization;
+	struct debugfs_node *ps_upsd_utilization;
+
+	struct debugfs_node *rxpipe_rx_prep_beacon_drop;
+	struct debugfs_node *rxpipe_descr_host_int_trig_rx_data;
+	struct debugfs_node *rxpipe_beacon_buffer_thres_host_int_trig_rx_data;
+	struct debugfs_node *rxpipe_missed_beacon_host_int_trig_rx_data;
+	struct debugfs_node *rxpipe_tx_xfr_host_int_trig_rx_data;
+
+	struct debugfs_node *tx_queue_len;
+	struct debugfs_node *tx_queue_status;
+
+	struct debugfs_node *retry_count;
+	struct debugfs_node *excessive_retries;
 };
 
 struct wl1251_if_operations {
diff --git a/drivers/net/wireless/ti/wlcore/wlcore.h b/drivers/net/wireless/ti/wlcore/wlcore.h
index 1f8511bf9bb3..f5d49d4b3963 100644
--- a/drivers/net/wireless/ti/wlcore/wlcore.h
+++ b/drivers/net/wireless/ti/wlcore/wlcore.h
@@ -76,7 +76,7 @@ struct wlcore_ops {
 			    struct sk_buff *skb);
 	u32 (*ap_get_mimo_wide_rate_mask)(struct wl1271 *wl,
 					  struct wl12xx_vif *wlvif);
-	int (*debugfs_init)(struct wl1271 *wl, struct dentry *rootdir);
+	int (*debugfs_init)(struct wl1271 *wl, struct debugfs_node *rootdir);
 	int (*handle_static_data)(struct wl1271 *wl,
 				  struct wl1271_static_data *static_data);
 	int (*scan_start)(struct wl1271 *wl, struct wl12xx_vif *wlvif,
diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index a3d71fc72064..a1f94c8944c2 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -123,7 +123,7 @@ struct axp288_fg_info {
 	int max_volt;
 	int pwr_op;
 	int low_cap;
-	struct dentry *debug_file;
+	struct debugfs_node *debug_file;
 
 	char valid;                 /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index ec2b32c65989..5ddbd53e105a 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -19,7 +19,7 @@ struct rproc;
 
 struct rproc_debug_trace {
 	struct rproc *rproc;
-	struct dentry *tfile;
+	struct debugfs_node *tfile;
 	struct list_head node;
 	struct rproc_mem_entry trace_mem;
 };
@@ -63,7 +63,7 @@ int rproc_of_parse_firmware(struct device *dev, int index,
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
 
 /* from remoteproc_debugfs.c */
-void rproc_remove_trace_file(struct dentry *tfile);
+void rproc_remove_trace_file(struct debugfs_node *tfile);
 struct debugfs_node *rproc_create_trace_file(const char *name, struct rproc *rproc,
 				       struct rproc_debug_trace *trace);
 void rproc_delete_debug_dir(struct rproc *rproc);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 3ed642f4f00d..3eac93582600 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -40,7 +40,7 @@
  */
 debug_info_t *dasd_debug_area;
 EXPORT_SYMBOL(dasd_debug_area);
-static struct dentry *dasd_debugfs_root_entry;
+static struct debugfs_node *dasd_debugfs_root_entry;
 struct dasd_discipline *dasd_diag_discipline_pointer;
 EXPORT_SYMBOL(dasd_diag_discipline_pointer);
 void dasd_int_handler(struct ccw_device *, unsigned long, struct irb *);
@@ -63,9 +63,9 @@ static void dasd_return_cqr_cb(struct dasd_ccw_req *, void *);
 static void dasd_device_timeout(struct timer_list *);
 static void dasd_block_timeout(struct timer_list *);
 static void __dasd_process_erp(struct dasd_device *, struct dasd_ccw_req *);
-static void dasd_profile_init(struct dasd_profile *, struct dentry *);
+static void dasd_profile_init(struct dasd_profile *, struct debugfs_node *);
 static void dasd_profile_exit(struct dasd_profile *);
-static void dasd_hosts_init(struct dentry *, struct dasd_device *);
+static void dasd_hosts_init(struct debugfs_node *, struct dasd_device *);
 static void dasd_hosts_exit(struct dasd_device *);
 static int dasd_handle_autoquiesce(struct dasd_device *, struct dasd_ccw_req *,
 				   unsigned int);
@@ -205,10 +205,10 @@ static int dasd_state_known_to_new(struct dasd_device *device)
 	return 0;
 }
 
-static struct dentry *dasd_debugfs_setup(const char *name,
-					 struct dentry *base_dentry)
+static struct debugfs_node *dasd_debugfs_setup(const char *name,
+					 struct debugfs_node *base_dentry)
 {
-	struct dentry *pde;
+	struct debugfs_node *pde;
 
 	if (!base_dentry)
 		return NULL;
@@ -646,7 +646,7 @@ unsigned int dasd_global_profile_level = DASD_PROFILE_OFF;
 struct dasd_profile dasd_global_profile = {
 	.lock = __SPIN_LOCK_UNLOCKED(dasd_global_profile.lock),
 };
-static struct dentry *dasd_debugfs_global_entry;
+static struct debugfs_node *dasd_debugfs_global_entry;
 
 /*
  * Add profiling information for cqr before execution.
@@ -1049,10 +1049,10 @@ static const struct file_operations dasd_stats_raw_fops = {
 };
 
 static void dasd_profile_init(struct dasd_profile *profile,
-			      struct dentry *base_dentry)
+			      struct debugfs_node *base_dentry)
 {
 	umode_t mode;
-	struct dentry *pde;
+	struct debugfs_node *pde;
 
 	if (!base_dentry)
 		return;
@@ -1083,7 +1083,7 @@ static void dasd_statistics_removeroot(void)
 
 static void dasd_statistics_createroot(void)
 {
-	struct dentry *pde;
+	struct debugfs_node *pde;
 
 	dasd_debugfs_root_entry = NULL;
 	pde = debugfs_create_dir("dasd", NULL);
@@ -1119,7 +1119,7 @@ static void dasd_statistics_removeroot(void)
 }
 
 static void dasd_profile_init(struct dasd_profile *profile,
-			      struct dentry *base_dentry)
+			      struct debugfs_node *base_dentry)
 {
 	return;
 }
@@ -1159,10 +1159,10 @@ static void dasd_hosts_exit(struct dasd_device *device)
 	device->hosts_dentry = NULL;
 }
 
-static void dasd_hosts_init(struct dentry *base_dentry,
+static void dasd_hosts_init(struct debugfs_node *base_dentry,
 			    struct dasd_device *device)
 {
-	struct dentry *pde;
+	struct debugfs_node *pde;
 	umode_t mode;
 
 	if (!base_dentry)
diff --git a/drivers/scsi/bfa/bfad_drv.h b/drivers/scsi/bfa/bfad_drv.h
index 542dcf9663a5..02ee1e500301 100644
--- a/drivers/scsi/bfa/bfad_drv.h
+++ b/drivers/scsi/bfa/bfad_drv.h
@@ -234,7 +234,7 @@ struct bfad_s {
 	/* debugfs specific data */
 	char *regdata;
 	u32 reglen;
-	struct dentry *bfad_dentry_files[5];
+	struct debugfs_node *bfad_dentry_files[5];
 	struct list_head	free_aen_q;
 	struct list_head	active_aen_q;
 	struct bfa_aen_entry_s	aen_list[BFA_AEN_MAX_ENTRY];
diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 248a457bef61..cfd518da22cf 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1366,7 +1366,7 @@ struct lpfc_hba {
 
 	struct debugfs_node *debug_nvmeio_trc;
 	struct lpfc_debugfs_nvmeio_trc *nvmeio_trc;
-	struct dentry *debug_hdwqinfo;
+	struct debugfs_node *debug_hdwqinfo;
 #ifdef LPFC_HDWQ_LOCK_STAT
 	struct debugfs_node *debug_lockstat;
 #endif
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 1b28a4bed80c..4d1cad7bb461 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2376,31 +2376,32 @@ lpfc_debugfs_dif_err_read(struct file *file, char __user *buf,
 	size_t nbytes, loff_t *ppos)
 {
 	struct dentry *dent = file->f_path.dentry;
+	struct debugfs_node *node = debugfs_node_from_dentry(dent);
 	struct lpfc_hba *phba = file->private_data;
 	char cbuf[32];
 	uint64_t tmp = 0;
 	int cnt = 0;
 
-	if (dent == phba->debug_writeGuard)
+	if (node == phba->debug_writeGuard)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wgrd_cnt);
-	else if (dent == phba->debug_writeApp)
+	else if (node == phba->debug_writeApp)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wapp_cnt);
-	else if (dent == phba->debug_writeRef)
+	else if (node == phba->debug_writeRef)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wref_cnt);
-	else if (dent == phba->debug_readGuard)
+	else if (node == phba->debug_readGuard)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rgrd_cnt);
-	else if (dent == phba->debug_readApp)
+	else if (node == phba->debug_readApp)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rapp_cnt);
-	else if (dent == phba->debug_readRef)
+	else if (node == phba->debug_readRef)
 		cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rref_cnt);
-	else if (dent == phba->debug_InjErrNPortID)
+	else if (node == phba->debug_InjErrNPortID)
 		cnt = scnprintf(cbuf, 32, "0x%06x\n",
 				phba->lpfc_injerr_nportid);
-	else if (dent == phba->debug_InjErrWWPN) {
+	else if (node == phba->debug_InjErrWWPN) {
 		memcpy(&tmp, &phba->lpfc_injerr_wwpn, sizeof(struct lpfc_name));
 		tmp = cpu_to_be64(tmp);
 		cnt = scnprintf(cbuf, 32, "0x%016llx\n", tmp);
-	} else if (dent == phba->debug_InjErrLBA) {
+	} else if (node == phba->debug_InjErrLBA) {
 		if (phba->lpfc_injerr_lba == (sector_t)(-1))
 			cnt = scnprintf(cbuf, 32, "off\n");
 		else
@@ -2418,6 +2419,7 @@ lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
 	size_t nbytes, loff_t *ppos)
 {
 	struct dentry *dent = file->f_path.dentry;
+	struct debugfs_node *node = debugfs_node_from_dentry(dent);
 	struct lpfc_hba *phba = file->private_data;
 	char dstbuf[33];
 	uint64_t tmp = 0;
@@ -2428,7 +2430,7 @@ lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
 	if (copy_from_user(dstbuf, buf, size))
 		return -EFAULT;
 
-	if (dent == phba->debug_InjErrLBA) {
+	if (node == phba->debug_InjErrLBA) {
 		if ((dstbuf[0] == 'o') && (dstbuf[1] == 'f') &&
 		    (dstbuf[2] == 'f'))
 			tmp = (uint64_t)(-1);
@@ -2437,23 +2439,23 @@ lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
 	if ((tmp == 0) && (kstrtoull(dstbuf, 0, &tmp)))
 		return -EINVAL;
 
-	if (dent == phba->debug_writeGuard)
+	if (node == phba->debug_writeGuard)
 		phba->lpfc_injerr_wgrd_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_writeApp)
+	else if (node == phba->debug_writeApp)
 		phba->lpfc_injerr_wapp_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_writeRef)
+	else if (node == phba->debug_writeRef)
 		phba->lpfc_injerr_wref_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_readGuard)
+	else if (node == phba->debug_readGuard)
 		phba->lpfc_injerr_rgrd_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_readApp)
+	else if (node == phba->debug_readApp)
 		phba->lpfc_injerr_rapp_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_readRef)
+	else if (node == phba->debug_readRef)
 		phba->lpfc_injerr_rref_cnt = (uint32_t)tmp;
-	else if (dent == phba->debug_InjErrLBA)
+	else if (node == phba->debug_InjErrLBA)
 		phba->lpfc_injerr_lba = (sector_t)tmp;
-	else if (dent == phba->debug_InjErrNPortID)
+	else if (node == phba->debug_InjErrNPortID)
 		phba->lpfc_injerr_nportid = (uint32_t)(tmp & Mask_DID);
-	else if (dent == phba->debug_InjErrWWPN) {
+	else if (node == phba->debug_InjErrWWPN) {
 		tmp = cpu_to_be64(tmp);
 		memcpy(&phba->lpfc_injerr_wwpn, &tmp, sizeof(struct lpfc_name));
 	} else
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 19feba0ec5ad..fb6af5fede0a 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -34,11 +34,6 @@
 
 #include <uapi/scsi/fc/fc_els.h>
 
-#define QLA_DFS_DEFINE_DENTRY(_debugfs_file_name) \
-	struct dentry *dfs_##_debugfs_file_name
-#define QLA_DFS_ROOT_DEFINE_DENTRY(_debugfs_file_name) \
-	struct dentry *qla_dfs_##_debugfs_file_name
-
 /* Big endian Fibre Channel S_ID (source ID) or D_ID (destination ID). */
 typedef struct {
 	uint8_t domain;
diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index c745cd9830f1..c0735ecae4a7 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -506,6 +506,7 @@ static ssize_t qmp_debugfs_write(struct file *file, const char __user *user_buf,
 				 size_t count, loff_t *pos)
 {
 	const struct qmp_debugfs_entry *entry = NULL;
+	struct debugfs_node *node;
 	struct qmp *qmp = file->private_data;
 	char buf[QMP_MSG_LEN];
 	unsigned int uint_val;
@@ -515,7 +516,8 @@ static ssize_t qmp_debugfs_write(struct file *file, const char __user *user_buf,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(qmp->debugfs_files); i++) {
-		if (qmp->debugfs_files[i] == file->f_path.dentry) {
+		node = debugfs_node_from_dentry(file->f_path.dentry);
+		if (qmp->debugfs_files[i] == node) {
 			entry = &qmp_debugfs_entries[i];
 			break;
 		}
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.h b/drivers/video/fbdev/omap2/omapfb/dss/dss.h
index a33a43f26829..7f7ce807f70c 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.h
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.h
@@ -319,6 +319,7 @@ static inline void sdi_uninit_port(struct device_node *port)
 #ifdef CONFIG_FB_OMAP2_DSS_DSI
 
 struct dentry;
+#define debugfs_node dentry
 struct file_operations;
 
 int dsi_init_platform_driver(void) __init;
diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 161cf2f05d2a..52978e5fd439 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -1056,8 +1056,8 @@ struct bch_fs {
 	struct semaphore	online_fsck_mutex;
 
 	/* DEBUG JUNK */
-	struct dentry		*fs_debug_dir;
-	struct dentry		*btree_debug_dir;
+	struct debugfs_node	*fs_debug_dir;
+	struct debugfs_node	*btree_debug_dir;
 	struct btree_debug	btree_debug[BTREE_ID_NR];
 	struct btree		*verify_data;
 	struct btree_node	*verify_ondisk;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 5cba6475f1d0..e34330c1fb7b 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -146,10 +146,10 @@ struct ceph_fs_client {
 	spinlock_t async_unlink_conflict_lock;
 
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_dentry_lru, *debugfs_caps;
+	struct debugfs_node *debugfs_dentry_lru, *debugfs_caps;
 	struct debugfs_node *debugfs_congestion_kb;
 	struct debugfs_node *debugfs_bdi;
-	struct dentry *debugfs_mdsc, *debugfs_mdsmap;
+	struct debugfs_node *debugfs_mdsc, *debugfs_mdsmap;
 	struct debugfs_node *debugfs_status;
 	struct debugfs_node *debugfs_mds_sessions;
 	struct debugfs_node *debugfs_metrics_dir;
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index a98784f4425d..08757c398ec1 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2708,23 +2708,24 @@ static ssize_t dfs_file_read(struct file *file, char __user *u, size_t count,
 			     loff_t *ppos)
 {
 	struct dentry *dent = file->f_path.dentry;
+	struct debugfs_node *node = debugfs_node_from_dentry(dent);
 	struct ubifs_info *c = file->private_data;
 	struct ubifs_debug_info *d = c->dbg;
 	int val;
 
-	if (dent == d->dfs_chk_gen)
+	if (node == d->dfs_chk_gen)
 		val = d->chk_gen;
-	else if (dent == d->dfs_chk_index)
+	else if (node == d->dfs_chk_index)
 		val = d->chk_index;
-	else if (dent == d->dfs_chk_orph)
+	else if (node == d->dfs_chk_orph)
 		val = d->chk_orph;
-	else if (dent == d->dfs_chk_lprops)
+	else if (node == d->dfs_chk_lprops)
 		val = d->chk_lprops;
-	else if (dent == d->dfs_chk_fs)
+	else if (node == d->dfs_chk_fs)
 		val = d->chk_fs;
-	else if (dent == d->dfs_tst_rcvry)
+	else if (node == d->dfs_tst_rcvry)
 		val = d->tst_rcvry;
-	else if (dent == d->dfs_ro_error)
+	else if (node == d->dfs_ro_error)
 		val = c->ro_error;
 	else
 		return -EINVAL;
@@ -2764,17 +2765,18 @@ static ssize_t dfs_file_write(struct file *file, const char __user *u,
 	struct ubifs_info *c = file->private_data;
 	struct ubifs_debug_info *d = c->dbg;
 	struct dentry *dent = file->f_path.dentry;
+	struct debugfs_node *node = debugfs_node_from_dentry(dent);
 	int val;
 
-	if (file->f_path.dentry == d->dfs_dump_lprops) {
+	if (node == d->dfs_dump_lprops) {
 		ubifs_dump_lprops(c);
 		return count;
 	}
-	if (file->f_path.dentry == d->dfs_dump_budg) {
+	if (node == d->dfs_dump_budg) {
 		ubifs_dump_budg(c, &c->bi);
 		return count;
 	}
-	if (file->f_path.dentry == d->dfs_dump_tnc) {
+	if (node == d->dfs_dump_tnc) {
 		mutex_lock(&c->tnc_mutex);
 		ubifs_dump_tnc(c);
 		mutex_unlock(&c->tnc_mutex);
@@ -2785,19 +2787,19 @@ static ssize_t dfs_file_write(struct file *file, const char __user *u,
 	if (val < 0)
 		return val;
 
-	if (dent == d->dfs_chk_gen)
+	if (node == d->dfs_chk_gen)
 		d->chk_gen = val;
-	else if (dent == d->dfs_chk_index)
+	else if (node == d->dfs_chk_index)
 		d->chk_index = val;
-	else if (dent == d->dfs_chk_orph)
+	else if (node == d->dfs_chk_orph)
 		d->chk_orph = val;
-	else if (dent == d->dfs_chk_lprops)
+	else if (node == d->dfs_chk_lprops)
 		d->chk_lprops = val;
-	else if (dent == d->dfs_chk_fs)
+	else if (node == d->dfs_chk_fs)
 		d->chk_fs = val;
-	else if (dent == d->dfs_tst_rcvry)
+	else if (node == d->dfs_tst_rcvry)
 		d->tst_rcvry = val;
-	else if (dent == d->dfs_ro_error)
+	else if (node == d->dfs_ro_error)
 		c->ro_error = !!val;
 	else
 		return -EINVAL;
@@ -2902,19 +2904,20 @@ static ssize_t dfs_global_file_read(struct file *file, char __user *u,
 				    size_t count, loff_t *ppos)
 {
 	struct dentry *dent = file->f_path.dentry;
+	struct debugfs_node *node = debugfs_node_from_dentry(dent);
 	int val;
 
-	if (dent == dfs_chk_gen)
+	if (node == dfs_chk_gen)
 		val = ubifs_dbg.chk_gen;
-	else if (dent == dfs_chk_index)
+	else if (node == dfs_chk_index)
 		val = ubifs_dbg.chk_index;
-	else if (dent == dfs_chk_orph)
+	else if (node == dfs_chk_orph)
 		val = ubifs_dbg.chk_orph;
-	else if (dent == dfs_chk_lprops)
+	else if (node == dfs_chk_lprops)
 		val = ubifs_dbg.chk_lprops;
-	else if (dent == dfs_chk_fs)
+	else if (node == dfs_chk_fs)
 		val = ubifs_dbg.chk_fs;
-	else if (dent == dfs_tst_rcvry)
+	else if (node == dfs_tst_rcvry)
 		val = ubifs_dbg.tst_rcvry;
 	else
 		return -EINVAL;
@@ -2926,23 +2929,24 @@ static ssize_t dfs_global_file_write(struct file *file, const char __user *u,
 				     size_t count, loff_t *ppos)
 {
 	struct dentry *dent = file->f_path.dentry;
+	struct debugfs_node *node = debugfs_node_from_dentry(dent);
 	int val;
 
 	val = interpret_user_input(u, count);
 	if (val < 0)
 		return val;
 
-	if (dent == dfs_chk_gen)
+	if (node == dfs_chk_gen)
 		ubifs_dbg.chk_gen = val;
-	else if (dent == dfs_chk_index)
+	else if (node == dfs_chk_index)
 		ubifs_dbg.chk_index = val;
-	else if (dent == dfs_chk_orph)
+	else if (node == dfs_chk_orph)
 		ubifs_dbg.chk_orph = val;
-	else if (dent == dfs_chk_lprops)
+	else if (node == dfs_chk_lprops)
 		ubifs_dbg.chk_lprops = val;
-	else if (dent == dfs_chk_fs)
+	else if (node == dfs_chk_fs)
 		ubifs_dbg.chk_fs = val;
-	else if (dent == dfs_tst_rcvry)
+	else if (node == dfs_tst_rcvry)
 		ubifs_dbg.tst_rcvry = val;
 	else
 		return -EINVAL;
diff --git a/fs/ubifs/debug.h b/fs/ubifs/debug.h
index d425861e6b82..b8fffabcfe43 100644
--- a/fs/ubifs/debug.h
+++ b/fs/ubifs/debug.h
@@ -105,17 +105,17 @@ struct ubifs_debug_info {
 	unsigned int tst_rcvry:1;
 
 	char dfs_dir_name[UBIFS_DFS_DIR_LEN];
-	struct dentry *dfs_dir;
-	struct dentry *dfs_dump_lprops;
-	struct dentry *dfs_dump_budg;
-	struct dentry *dfs_dump_tnc;
-	struct dentry *dfs_chk_gen;
-	struct dentry *dfs_chk_index;
-	struct dentry *dfs_chk_orph;
-	struct dentry *dfs_chk_lprops;
-	struct dentry *dfs_chk_fs;
-	struct dentry *dfs_tst_rcvry;
-	struct dentry *dfs_ro_error;
+	struct debugfs_node *dfs_dir;
+	struct debugfs_node *dfs_dump_lprops;
+	struct debugfs_node *dfs_dump_budg;
+	struct debugfs_node *dfs_dump_tnc;
+	struct debugfs_node *dfs_chk_gen;
+	struct debugfs_node *dfs_chk_index;
+	struct debugfs_node *dfs_chk_orph;
+	struct debugfs_node *dfs_chk_lprops;
+	struct debugfs_node *dfs_chk_fs;
+	struct debugfs_node *dfs_tst_rcvry;
+	struct debugfs_node *dfs_ro_error;
 };
 
 /**
diff --git a/fs/xfs/scrub/stats.h b/fs/xfs/scrub/stats.h
index b358ad8d8b90..df56db591ba8 100644
--- a/fs/xfs/scrub/stats.h
+++ b/fs/xfs/scrub/stats.h
@@ -6,6 +6,8 @@
 #ifndef __XFS_SCRUB_STATS_H__
 #define __XFS_SCRUB_STATS_H__
 
+#include <linux/debugfs.h>
+
 struct xchk_stats_run {
 	u64			scrub_ns;
 	u64			repair_ns;
@@ -17,13 +19,13 @@ struct xchk_stats_run {
 #ifdef CONFIG_XFS_ONLINE_SCRUB_STATS
 struct xchk_stats;
 
-int __init xchk_global_stats_setup(struct dentry *parent);
+int __init xchk_global_stats_setup(struct debugfs_node *parent);
 void xchk_global_stats_teardown(void);
 
 int xchk_mount_stats_alloc(struct xfs_mount *mp);
 void xchk_mount_stats_free(struct xfs_mount *mp);
 
-void xchk_stats_register(struct xchk_stats *cs, struct dentry *parent);
+void xchk_stats_register(struct xchk_stats *cs, struct debugfs_node *parent);
 void xchk_stats_unregister(struct xchk_stats *cs);
 
 void xchk_stats_merge(struct xfs_mount *mp, const struct xfs_scrub_metadata *sm,
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index c4d2682d797c..dba74e0ac932 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -249,7 +249,7 @@ typedef struct xfs_mount {
 	uint64_t		m_resblks_avail;/* available reserved blocks */
 	uint64_t		m_resblks_save;	/* reserved blks @ remount,ro */
 	struct delayed_work	m_reclaim_work;	/* background inode reclaim */
-	struct debugfs_node *m_debugfs;	/* debugfs parent */
+	struct debugfs_node	*m_debugfs;	/* debugfs parent */
 	struct xfs_kobj		m_kobj;
 	struct xfs_kobj		m_error_kobj;
 	struct xfs_kobj		m_error_meta_kobj;
diff --git a/fs/xfs/xfs_super.h b/fs/xfs/xfs_super.h
index c0e85c1e42f2..aad16764deb3 100644
--- a/fs/xfs/xfs_super.h
+++ b/fs/xfs/xfs_super.h
@@ -99,6 +99,7 @@ extern struct workqueue_struct *xfs_discard_wq;
 
 #define XFS_M(sb)		((struct xfs_mount *)((sb)->s_fs_info))
 
-struct dentry *xfs_debugfs_mkdir(const char *name, struct dentry *parent);
+struct debugfs_node *xfs_debugfs_mkdir(const char *name,
+				       struct debugfs_node *parent);
 
 #endif	/* __XFS_SUPER_H__ */
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 496dbbd2ad7e..77a1649e5586 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -734,7 +734,7 @@ struct drm_bridge_funcs {
 	 *
 	 * Allows bridges to create bridge-specific debugfs files.
 	 */
-	void (*debugfs_init)(struct drm_bridge *bridge, struct dentry *root);
+	void (*debugfs_init)(struct drm_bridge *bridge, struct debugfs_node *root);
 };
 
 /**
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 9f63215edaea..7b1e2ad2d285 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -34,6 +34,7 @@
 
 #include <uapi/drm/drm_mode.h>
 
+#define debugfs_node dentry
 struct drm_connector_helper_funcs;
 struct drm_modeset_acquire_ctx;
 struct drm_device;
@@ -1576,7 +1577,7 @@ struct drm_connector_funcs {
 	 *
 	 * Allows connectors to create connector-specific debugfs files.
 	 */
-	void (*debugfs_init)(struct drm_connector *connector, struct dentry *root);
+	void (*debugfs_init)(struct drm_connector *connector, struct debugfs_node *root);
 };
 
 /**
diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
index e795aa93a132..efce45002f86 100644
--- a/include/drm/drm_debugfs.h
+++ b/include/drm/drm_debugfs.h
@@ -37,6 +37,8 @@
 
 #include <drm/drm_gpuvm.h>
 
+#define debugfs_node dentry
+
 /**
  * DRM_DEBUGFS_GPUVA_INFO - &drm_info_list entry to dump a GPU VA space
  * @show: the &drm_info_list's show callback
diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index 50845e231366..28384b37b841 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -87,7 +87,7 @@ struct drm_encoder_funcs {
 	 *
 	 * Allows encoders to create encoder-specific debugfs files.
 	 */
-	void (*debugfs_init)(struct drm_encoder *encoder, struct dentry *root);
+	void (*debugfs_init)(struct drm_encoder *encoder, struct debugfs_node *root);
 };
 
 /**
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 6cb6144dc9e1..3703ae656970 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -38,6 +38,7 @@
 
 #include <drm/drm_prime.h>
 
+#define debugfs_node dentry
 struct dma_fence;
 struct drm_file;
 struct drm_device;
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 4030eae6ee90..47aa6c0b2853 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -24,6 +24,7 @@
 #ifndef __DRM_PANEL_H__
 #define __DRM_PANEL_H__
 
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/list.h>
@@ -144,7 +145,7 @@ struct drm_panel_funcs {
 	 *
 	 * Allows panels to create panels-specific debugfs files.
 	 */
-	void (*debugfs_init)(struct drm_panel *panel, struct dentry *root);
+	void (*debugfs_init)(struct drm_panel *panel, struct debugfs_node *root);
 };
 
 struct drm_panel_follower_funcs {
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index ee688d0c029b..5e3d3a927341 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -38,6 +38,7 @@
 #define TTM_MAX_BO_PRIORITY	4U
 #define TTM_NUM_MEM_TYPES 8
 
+#define debugfs_node dentry
 struct dmem_cgroup_device;
 struct ttm_device;
 struct ttm_resource_manager;
@@ -504,6 +505,6 @@ void ttm_kmap_iter_linear_io_fini(struct ttm_kmap_iter_linear_io *iter_io,
 				  struct ttm_resource *mem);
 
 void ttm_resource_manager_create_debugfs(struct ttm_resource_manager *man,
-					 struct dentry * parent,
+					 struct debugfs_node * parent,
 					 const char *name);
 #endif
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d543a20bc150..5f765a58a66a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -6,6 +6,7 @@
 #ifndef __LINUX_CLK_PROVIDER_H
 #define __LINUX_CLK_PROVIDER_H
 
+#include <linux/debugfs.h>
 #include <linux/of.h>
 #include <linux/of_clk.h>
 
@@ -266,7 +267,7 @@ struct clk_ops {
 					  struct clk_duty *duty);
 	int		(*init)(struct clk_hw *hw);
 	void		(*terminate)(struct clk_hw *hw);
-	void		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
+	void		(*debug_init)(struct clk_hw *hw, struct debugfs_node *dentry);
 };
 
 /**
diff --git a/include/linux/closure.h b/include/linux/closure.h
index 880fe85e35e9..b98b6067368a 100644
--- a/include/linux/closure.h
+++ b/include/linux/closure.h
@@ -105,7 +105,7 @@
 struct closure;
 struct closure_syncer;
 typedef void (closure_fn) (struct work_struct *);
-extern struct dentry *bcache_debug;
+extern struct debugfs_node *bcache_debug;
 
 struct closure_waitlist {
 	struct llist_head	list;
diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index cfbffb130c0c..6691f57aa18c 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -34,7 +34,7 @@ struct fault_attr {
 
 	unsigned long count;
 	struct ratelimit_state ratelimit_state;
-	struct dentry *dname;
+	struct debugfs_node *dname;
 };
 
 enum fault_flags {
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index fd091c35d572..19edde4e6307 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -16,6 +16,7 @@ struct module;
 struct irq_desc;
 struct irq_domain;
 struct pt_regs;
+#define debugfs_node dentry
 
 /**
  * struct irqstat - interrupt statistics
@@ -61,7 +62,7 @@ struct irqstat {
  * @kobj:		kobject used to represent this struct in sysfs
  * @request_mutex:	mutex to protect request/free before locking desc->lock
  * @dir:		/proc/irq/ procfs entry
- * @debugfs_file:	dentry for the debugfs file
+ * @debugfs_file:	debugfs_node for the debugfs file
  * @name:		flow handler name for /proc/interrupts output
  */
 struct irq_desc {
@@ -103,7 +104,7 @@ struct irq_desc {
 	struct proc_dir_entry	*dir;
 #endif
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
-	struct dentry		*debugfs_file;
+	struct debugfs_node	*debugfs_file;
 	const char		*dev_name;
 #endif
 #ifdef CONFIG_SPARSE_IRQ
diff --git a/include/media/cec.h b/include/media/cec.h
index 0c8e86115b6f..0c172c059927 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -290,7 +290,7 @@ struct cec_adapter {
 	struct cec_pin *pin;
 #endif
 
-	struct dentry *cec_dir;
+	struct debugfs_node *cec_dir;
 
 	u32 sequence;
 
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index f26c323e9c96..fcabc643d095 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 
 struct dentry;
+#define debugfs_node dentry
 struct device;
 struct device_node;
 struct v4l2_device;
@@ -140,9 +141,9 @@ struct v4l2_async_subdev_endpoint {
 /**
  * v4l2_async_debug_init - Initialize debugging tools.
  *
- * @debugfs_dir: pointer to the parent debugfs &struct dentry
+ * @debugfs_dir: pointer to the parent debugfs &struct debugfs_node
  */
-void v4l2_async_debug_init(struct dentry *debugfs_dir);
+void v4l2_async_debug_init(struct debugfs_node *debugfs_dir);
 
 /**
  * v4l2_async_nf_init - Initialize a notifier.
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 3443ac47384a..8896fdc00ecb 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2010,7 +2010,7 @@ enum ieee80211_neg_ttlm_res {
  *	restrictions.
  * @hw_queue: hardware queue for each AC
  * @cab_queue: content-after-beacon (DTIM beacon really) queue, AP mode only
- * @debugfs_dir: debugfs dentry, can be used by drivers to create own per
+ * @debugfs_dir: debugfs_node, can be used by drivers to create own per
  *	interface debug files. Note that it will be NULL for the virtual
  *	monitor interface (if that is requested.)
  * @probe_req_reg: probe requests should be reported to mac80211 for this
@@ -4570,15 +4570,15 @@ struct ieee80211_ops {
 	void (*link_add_debugfs)(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *link_conf,
-				 struct dentry *dir);
+				 struct debugfs_node *dir);
 	void (*sta_add_debugfs)(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
-				struct dentry *dir);
+				struct debugfs_node *dir);
 	void (*link_sta_add_debugfs)(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_link_sta *link_sta,
-				     struct dentry *dir);
+				     struct debugfs_node *dir);
 #endif
 	void (*sta_notify)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			enum sta_notify_cmd, struct ieee80211_sta *sta);
@@ -7010,7 +7010,7 @@ struct rate_control_ops {
 	const char *name;
 	void *(*alloc)(struct ieee80211_hw *hw);
 	void (*add_debugfs)(struct ieee80211_hw *hw, void *priv,
-			    struct dentry *debugfsdir);
+			    struct debugfs_node *debugfsdir);
 	void (*free)(void *priv);
 
 	void *(*alloc_sta)(void *priv, struct ieee80211_sta *sta, gfp_t gfp);
@@ -7034,7 +7034,7 @@ struct rate_control_ops {
 			 struct ieee80211_tx_rate_control *txrc);
 
 	void (*add_sta_debugfs)(void *priv, void *priv_sta,
-				struct dentry *dir);
+				struct debugfs_node *dir);
 
 	u32 (*get_expected_throughput)(void *priv_sta);
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 6ee4c59db620..64c440123757 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -223,7 +223,7 @@ struct tegra_mc {
 	spinlock_t lock;
 
 	struct {
-		struct dentry *root;
+		struct debugfs_node *root;
 	} debugfs;
 };
 
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index bb8445b7a384..cd876d2d3060 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_SND_SOC_DAPM_H
 #define __LINUX_SND_SOC_DAPM_H
 
+#include <linux/debugfs.h>
 #include <linux/types.h>
 #include <sound/control.h>
 #include <sound/soc-topology.h>
@@ -498,7 +499,7 @@ int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
 
 /* dapm sys fs - used by the core */
 extern struct attribute *soc_dapm_dev_attrs[];
-void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm, struct dentry *parent);
+void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm, struct debugfs_node *parent);
 
 /* dapm audio pin control and status */
 int snd_soc_dapm_enable_pin(struct snd_soc_dapm_context *dapm, const char *pin);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 03abd4d3f501..c2fcc98fb1de 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1202,7 +1202,7 @@ struct snd_soc_pcm_runtime {
 	struct delayed_work delayed_work;
 	void (*close_delayed_work_func)(struct snd_soc_pcm_runtime *rtd);
 #ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_dpcm_root;
+	struct debugfs_node *debugfs_dpcm_root;
 #endif
 
 	unsigned int id; /* 0-based and monotonic increasing */
diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index ed65d02010e0..8290ea6391ef 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -57,7 +57,7 @@ struct gcov_node {
 	struct gcov_info **loaded_info;
 	struct gcov_info *unloaded_info;
 	struct debugfs_node *dentry;
-	struct dentry **links;
+	struct debugfs_node **links;
 	int num_loaded;
 	char name[];
 };
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9c21ba45b7af..62c4decfa9ee 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -387,7 +387,7 @@ struct trace_array {
 	raw_spinlock_t		start_lock;
 	const char		*system_names;
 	struct list_head	err_log;
-	struct dentry		*dir;
+	struct dentry 		*dir;
 	struct dentry		*options;
 	struct dentry		*percpu_dir;
 	struct eventfs_inode	*event_dir;
diff --git a/lib/notifier-error-inject.h b/lib/notifier-error-inject.h
index a08c4d14a26f..4b66b0667c79 100644
--- a/lib/notifier-error-inject.h
+++ b/lib/notifier-error-inject.h
@@ -20,6 +20,7 @@ struct notifier_err_inject {
 
 extern struct debugfs_node *notifier_err_inject_dir;
 
-extern struct debugfs_node *notifier_err_inject_init(const char *name,
-		struct dentry *parent, struct notifier_err_inject *err_inject,
-		int priority);
+extern struct debugfs_node *
+notifier_err_inject_init(const char *name, struct debugfs_node *parent,
+			 struct notifier_err_inject *err_inject,
+			 int priority);
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 5bb5792982e3..81937c2d4ffa 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -981,15 +981,15 @@ static void add_files(struct ieee80211_sub_if_data *sdata)
 #define DEBUGFS_ADD(dentry, name) DEBUGFS_ADD_MODE(dentry, name, 0400)
 
 static void add_link_files(struct ieee80211_link_data *link,
-			   struct dentry *dentry)
+			   struct debugfs_node *node)
 {
-	DEBUGFS_ADD(dentry, txpower);
-	DEBUGFS_ADD(dentry, user_power_level);
-	DEBUGFS_ADD(dentry, ap_power_level);
+	DEBUGFS_ADD(node, txpower);
+	DEBUGFS_ADD(node, user_power_level);
+	DEBUGFS_ADD(node, ap_power_level);
 
 	switch (link->sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
-		DEBUGFS_ADD_MODE(dentry, smps, 0600);
+		DEBUGFS_ADD_MODE(node, smps, 0600);
 		break;
 	default:
 		break;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 25d02130f443..dab7b4ec3bc8 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1186,11 +1186,11 @@ struct ieee80211_sub_if_data {
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct {
-		struct dentry *subdir_stations;
-		struct dentry *default_unicast_key;
-		struct dentry *default_multicast_key;
-		struct dentry *default_mgmt_key;
-		struct dentry *default_beacon_key;
+		struct debugfs_node *subdir_stations;
+		struct debugfs_node *default_unicast_key;
+		struct debugfs_node *default_multicast_key;
+		struct debugfs_node *default_mgmt_key;
+		struct debugfs_node *default_beacon_key;
 	} debugfs;
 #endif
 
@@ -1594,8 +1594,8 @@ struct ieee80211_local {
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct local_debugfsdentries {
-		struct dentry *rcdir;
-		struct dentry *keys;
+		struct debugfs_node *rcdir;
+		struct debugfs_node *keys;
 	} debugfs;
 	bool force_tx_status;
 #endif
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index 1fa0f4f78962..dc43dca93780 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -121,8 +121,8 @@ struct ieee80211_key {
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct {
-		struct dentry *stalink;
-		struct dentry *dir;
+		struct debugfs_node *stalink;
+		struct debugfs_node *dir;
 		int cnt;
 	} debugfs;
 #endif
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index aa82b2ca499d..f2d64a2e64b0 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -126,11 +126,14 @@ static int do_xprt_debugfs(struct rpc_clnt *clnt, struct rpc_xprt *xprt, void *n
 	char name[24]; /* enough for "../../rpc_xprt/ + 8 hex digits + NULL */
 	char link[9]; /* enough for 8 hex digits + NULL */
 	int *nump = numv;
+	struct dentry *dentry;
 
 	if (IS_ERR_OR_NULL(xprt->debugfs))
 		return 0;
+
+	dentry = debugfs_node_dentry(xprt->debugfs);
 	len = snprintf(name, sizeof(name), "../../rpc_xprt/%s",
-		       xprt->debugfs->d_name.name);
+		       dentry->d_name.name);
 	if (len >= sizeof(name))
 		return -1;
 	if (*nump == 0)
diff --git a/net/wireless/debugfs.c b/net/wireless/debugfs.c
index b9822e13a414..c07af2468881 100644
--- a/net/wireless/debugfs.c
+++ b/net/wireless/debugfs.c
@@ -102,7 +102,7 @@ static const struct file_operations ht40allow_map_ops = {
 
 void cfg80211_debugfs_rdev_add(struct cfg80211_registered_device *rdev)
 {
-	struct dentry *phyd = rdev->wiphy.debugfsdir;
+	struct debugfs_node *phyd = rdev->wiphy.debugfsdir;
 
 	DEBUGFS_ADD(rts_threshold);
 	DEBUGFS_ADD(fragmentation_threshold);
diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-common.h b/sound/soc/mediatek/mt8195/mt8195-afe-common.h
index f93f439e2bd9..6023d6ae5258 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-common.h
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-common.h
@@ -128,7 +128,7 @@ struct mt8195_afe_private {
 	struct regmap *topckgen;
 	int pm_runtime_bypass_reg_ctl;
 #ifdef CONFIG_DEBUG_FS
-	struct dentry **debugfs_dentry;
+	struct debugfs_node **debugfs_dentry;
 #endif
 	int afe_on_ref_cnt;
 	int top_cg_ref_cnt[MT8195_TOP_CG_NUM];
diff --git a/sound/soc/sof/sof-client-ipc-flood-test.c b/sound/soc/sof/sof-client-ipc-flood-test.c
index 443d36294c99..efc76f42ac83 100644
--- a/sound/soc/sof/sof-client-ipc-flood-test.c
+++ b/sound/soc/sof/sof-client-ipc-flood-test.c
@@ -29,7 +29,7 @@
 
 struct sof_ipc_flood_priv {
 	struct debugfs_node *dfs_root;
-	struct dentry *dfs_link[2];
+	struct debugfs_node *dfs_link[2];
 	char *buf;
 };
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ca7fdbbf9fa3..a2e308709265 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6209,7 +6209,8 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 		char *tmp, *p = kmalloc(PATH_MAX, GFP_KERNEL);
 
 		if (p) {
-			tmp = dentry_path_raw(kvm->debugfs_dentry, p, PATH_MAX);
+			tmp = debugfs_node_path_raw(kvm->debugfs_dentry, p,
+						    PATH_MAX);
 			if (!IS_ERR(tmp))
 				add_uevent_var(env, "STATS_PATH=%s", tmp);
 			kfree(p);

