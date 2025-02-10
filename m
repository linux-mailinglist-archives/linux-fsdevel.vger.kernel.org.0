Return-Path: <linux-fsdevel+bounces-41361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683DFA2E389
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A833A51F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73F18FDAB;
	Mon, 10 Feb 2025 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="ivOoYCZA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dfLPigPJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D10189F3B;
	Mon, 10 Feb 2025 05:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164896; cv=none; b=R0ESS6AFhGOrdlcg56HmYu0RpvjfG5qI2kjdmyKKjge7XuFqSfVPB+UvL+hYkAwprd1bysHWNCNtE+kblPJb62FCqdyoIvX4kB5sEzegMsCwru0j/5tJUfcRK8fWDVS38aL/IudZbToUn4PkjGBQhjky89+Ri7aO+RXRB4mOM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164896; c=relaxed/simple;
	bh=8sBdao39rqPtj0qqBqQa0VyzFSzGAlMm8tY/KtKCl+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBMzfRLKvFc6RyntyBlfl91Gk22Otnzo3ljfoTnNHZhAGMeXvgQLcYzPyvQX0p7eX6C6Xz1e2iOEQn5P03u8cZjilFRY/N1ZZ04gujk0l6rUWqlYWdHYEQA+CypvEXsTtz1N+OPcxyN/Uw2YMCSMfrnOmnbvH0OoEn7ikLj1YX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=ivOoYCZA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dfLPigPJ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 78760114015B;
	Mon, 10 Feb 2025 00:21:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 10 Feb 2025 00:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739164891; x=
	1739251291; bh=Kk+y5mX6c8MoDY23nTDa8Ad1glUaWz68MCNHbyTDo/o=; b=i
	vOoYCZAkNPWjsvZ0FYuTg3YwxpN6vOY7ELdfgM5KfNL3ovjdwUvEPaqLpN5ceBvu
	qcZyGnwL0IlhUs3mb+59u4k41G55lO+pf20sQcMCzWq6cW51Nq6qOKT3MW6whrtm
	HQzHlLD/uCvnDf5rrQY/e3G36zg6/MnONPLucvLB8WisaSy6B5YQ1bDzuvdfZ4Jm
	t8f14LyC6/RWlRYnBzHcRj3GWQeDXgUQPsMwrQOk6fLP+P3PeZW3ticltTY1jBPk
	OEsyFXddN5z6zIheg9Y83Ijbzci/tGbUtfTdHGumHFoKGpIZBFn5D+ph6uQqtUvd
	ff2ebBxoZSwOYrPZiSNXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1739164891; x=1739251291; bh=K
	k+y5mX6c8MoDY23nTDa8Ad1glUaWz68MCNHbyTDo/o=; b=dfLPigPJdjkou4KLD
	RUZ2bz2pV4wYNQomXh0Cd0O9MaOXz+Ob3tUFHmHuNmLu/dyrdoP/GTrLSTVBY3nO
	SKKjCGj53Ks0Ioztl3o5QYj3snd7IMiF7Wf1edQV+COYbDAa+8pxhRwhMF6cGcHX
	5GqR/TY+p8rTnWnM0rE37SaG7MxmXpF9WYd4ijj89UcrQVpNqmja1o488YnmzD8q
	ssphkGWOCCrvV8vnNG2y8IjNYsKay5ETWq893kEYjaHui42S8/TNBz7hUe12E7w9
	56SdudEVFSW+3I2O//y0U8b+6e8yCaet8lQorzNwVgzi2NnhtLtvEs33MSgCP5w+
	N+s1g==
X-ME-Sender: <xms:24ypZ_1nRSktPYT-L7aOPbVaaeK59tIWjvYa4n7rxFQEKeQxp4ybjg>
    <xme:24ypZ-GwLHmo_XodVBFi-lkjka-XKgommhsEdmoGU6QYPGMfhbOEO8yZk9RD7we4p
    4Uu2CTR8zXgyVHnb18>
X-ME-Received: <xmr:24ypZ_7NveNG_ls__0VGFOOBzJMYpKQ8UcOkiwSOKToqsKFQcIj8bB5W3rYPYfVCmPt-NemjX4tAAhh0bbcHmciz-Y1J60XQ-VnB0fyOzvD8QUI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudevteffveeuuddtkedtvedtteeutdefvdeg
    hffhjeeiveegvdetvdejteejleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhrvghgkhhhse
    hlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhrtghpthhtoheprhhoshht
    vgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdr
    uhhkpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-ME-Proxy: <xmx:24ypZ01V7u0hVpReZbY5F04YBBpDfaWT1-BWar-a2OZce01NzforKw>
    <xmx:24ypZyFEXRTBTQofNttP3Cq206Hz2osb9n-4B2jBKj0jwLubJNQTkw>
    <xmx:24ypZ19EPmTaZgwpJ7GCTRilCoXDLYZ6q3E7bCx85MVFwvv1m-87cA>
    <xmx:24ypZ_kHInyoaB7ejDy08N5dUAkxa9GIu1gAM0WqoGsJUmLqbVA3rg>
    <xmx:24ypZ68gkbW-HypWRM451LOuUsGhOVCzrR9utJMRad4y0YWvU_oBpQZX>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 00:21:29 -0500 (EST)
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
Subject: [RFC PATCH 6/6] debugfs: Replace debugfs_node #define with struct wrapping dentry
Date: Sun,  9 Feb 2025 21:20:26 -0800
Message-ID: <20250210052039.144513-7-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>
References: <20250210052039.144513-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the temporary #define debugfs_node with a proper struct
debugfs_node. Update debugfs internals to use the new struct.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 drivers/acpi/apei/apei-internal.h             |   2 +-
 drivers/crypto/caam/debugfs.h                 |   2 +-
 .../intel/qat/qat_common/adf_heartbeat.h      |   2 +-
 .../intel/qat/qat_common/adf_telemetry.h      |   2 +-
 drivers/dma/dmaengine.h                       |   2 +-
 drivers/gpu/drm/drm_internal.h                |   2 +-
 drivers/gpu/drm/i915/gt/intel_gt_debugfs.h    |   2 +-
 .../drm/i915/gt/intel_gt_engines_debugfs.h    |   2 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.h |   2 +-
 drivers/gpu/drm/i915/gt/intel_sseu_debugfs.h  |   2 +-
 .../gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.h |   2 +-
 .../gpu/drm/i915/gt/uc/intel_guc_debugfs.h    |   2 +-
 .../drm/i915/gt/uc/intel_guc_log_debugfs.h    |   2 +-
 .../gpu/drm/i915/gt/uc/intel_huc_debugfs.h    |   2 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h |   2 +-
 drivers/gpu/drm/i915/i915_debugfs_params.h    |   2 +-
 drivers/gpu/drm/imagination/pvr_debugfs.h     |   2 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.h    |   2 +-
 drivers/gpu/drm/imagination/pvr_params.h      |   2 +-
 drivers/gpu/drm/ttm/ttm_module.h              |   2 +-
 drivers/gpu/drm/xe/xe_gsc_debugfs.h           |   2 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.h   |   2 +-
 drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.h   |   2 +-
 drivers/gpu/drm/xe/xe_guc_debugfs.h           |   2 +-
 drivers/gpu/drm/xe/xe_huc_debugfs.h           |   2 +-
 drivers/gpu/drm/xe/xe_uc_debugfs.h            |   2 +-
 drivers/gpu/host1x/dev.h                      |   2 +-
 .../platform/nxp/imx8-isi/imx8-isi-core.h     |   2 +-
 .../platform/rockchip/rkisp1/rkisp1-common.h  |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |   2 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.h |   2 +-
 drivers/net/wireless/broadcom/b43/debugfs.h   |   2 +-
 .../net/wireless/broadcom/b43legacy/debugfs.h |   2 +-
 drivers/pinctrl/core.h                        |   2 +-
 drivers/pinctrl/pinconf.h                     |   2 +-
 drivers/pinctrl/pinmux.h                      |   2 +-
 drivers/usb/typec/ucsi/ucsi.h                 |   2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss.h    |   2 +-
 fs/debugfs/file.c                             | 117 +++++-----
 fs/debugfs/inode.c                            | 206 ++++++++++--------
 fs/debugfs/internal.h                         |   6 +
 include/drm/drm_connector.h                   |   2 +-
 include/drm/drm_debugfs.h                     |   2 +-
 include/drm/drm_file.h                        |   2 +-
 include/drm/drm_panel.h                       |   2 +-
 include/drm/ttm/ttm_resource.h                |   2 +-
 include/linux/backing-dev-defs.h              |   2 +-
 include/linux/clk-provider.h                  |   2 +-
 include/linux/dcache.h                        |   2 -
 include/linux/debugfs.h                       | 153 +++++++------
 include/linux/fault-inject.h                  |   2 +-
 include/linux/irqdesc.h                       |   2 +-
 include/linux/soundwire/sdw.h                 |   2 +-
 include/linux/xattr.h                         |   2 +-
 include/media/v4l2-async.h                    |   2 +-
 include/media/v4l2-dev.h                      |   2 +-
 sound/pci/hda/cs35l56_hda.h                   |   2 +-
 sound/soc/sof/sof-client.h                    |   2 +-
 60 files changed, 313 insertions(+), 281 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 360bfab92ebb..8dc0059e6506 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -118,7 +118,7 @@ int apei_exec_collect_resources(struct apei_exec_context *ctx,
 				struct apei_resources *resources);
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct debugfs_node *apei_get_debugfs_dir(void);
 
 static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
diff --git a/drivers/crypto/caam/debugfs.h b/drivers/crypto/caam/debugfs.h
index b39d45b70903..12cb335f0de4 100644
--- a/drivers/crypto/caam/debugfs.h
+++ b/drivers/crypto/caam/debugfs.h
@@ -5,7 +5,7 @@
 #define CAAM_DEBUGFS_H
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct caam_drv_private;
 struct caam_perfmon;
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h b/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
index 7546882ca1e5..bc4fc8543e2c 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat.h
@@ -8,7 +8,7 @@
 
 struct adf_accel_dev;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 #define ADF_CFG_HB_TIMER_MIN_MS 200
 #define ADF_CFG_HB_TIMER_DEFAULT_MS 500
diff --git a/drivers/crypto/intel/qat/qat_common/adf_telemetry.h b/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
index 078e8be4ee43..cd567ed2c82d 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_telemetry.h
@@ -13,7 +13,7 @@
 struct adf_accel_dev;
 struct adf_tl_dbg_counter;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 #define ADF_TL_SL_CNT_COUNT		\
 	(sizeof(struct icp_qat_fw_init_admin_slice_cnt) / sizeof(__u8))
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index f3c4b3747fa7..6e51fd821330 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -191,7 +191,7 @@ dmaengine_get_debugfs_root(struct dma_device *dma_dev) {
 }
 #else
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 static inline struct debugfs_node *
 dmaengine_get_debugfs_root(struct dma_device *dma_dev)
 {
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index 087950b52596..7c440b0d40bc 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -36,7 +36,7 @@
 #define DRM_IF_VERSION(maj, min) (maj << 16 | min)
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct dma_buf;
 struct iosys_map;
 struct drm_connector;
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
index 03d425886e25..624ea2785549 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
@@ -9,7 +9,7 @@
 #include <linux/file.h>
 
 struct intel_gt;
-#define debugfs_node dentry
+struct debugfs_node;
 
 #define __GT_DEBUGFS_ATTRIBUTE_FOPS(__name)				\
 static const struct file_operations __name ## _fops = {			\
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_engines_debugfs.h b/drivers/gpu/drm/i915/gt/intel_gt_engines_debugfs.h
index 1347d896d7a3..ac51807768cc 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_engines_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_engines_debugfs.h
@@ -8,7 +8,7 @@
 
 struct intel_gt;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 void intel_gt_engines_debugfs_register(struct intel_gt *gt,
 				       struct debugfs_node *root);
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.h b/drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.h
index c34d595bba56..be9b61afde21 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_pm_debugfs.h
@@ -8,7 +8,7 @@
 
 struct intel_gt;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct drm_printer;
 
 void intel_gt_pm_debugfs_register(struct intel_gt *gt,
diff --git a/drivers/gpu/drm/i915/gt/intel_sseu_debugfs.h b/drivers/gpu/drm/i915/gt/intel_sseu_debugfs.h
index 8eb79cb148b3..c9ac2aeee5e9 100644
--- a/drivers/gpu/drm/i915/gt/intel_sseu_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/intel_sseu_debugfs.h
@@ -9,7 +9,7 @@
 
 struct intel_gt;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct seq_file;
 
 int intel_sseu_status(struct seq_file *m, struct intel_gt *gt);
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.h b/drivers/gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.h
index f5678acf77c3..f31b4b96d41a 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_gsc_uc_debugfs.h
@@ -8,7 +8,7 @@
 
 struct intel_gsc_uc;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 void intel_gsc_uc_debugfs_register(struct intel_gsc_uc *gsc,
 				   struct debugfs_node *root);
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.h b/drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.h
index c9a5ea91a43b..714eb9fcb21c 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_debugfs.h
@@ -8,7 +8,7 @@
 
 struct intel_guc;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 void intel_guc_debugfs_register(struct intel_guc *guc,
 				struct debugfs_node *root);
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.h b/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.h
index 44c81d40e692..083925010061 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.h
@@ -8,7 +8,7 @@
 
 struct intel_guc_log;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 void intel_guc_log_debugfs_register(struct intel_guc_log *log,
 				    struct debugfs_node *root);
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.h b/drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.h
index 3120bc60e1aa..16c7f3f6f900 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_huc_debugfs.h
@@ -8,7 +8,7 @@
 
 struct intel_huc;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 void intel_huc_debugfs_register(struct intel_huc *huc,
 				struct debugfs_node *root);
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h b/drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h
index b6d56a1d1b77..80ce3289827c 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_uc_debugfs.h
@@ -8,7 +8,7 @@
 
 struct intel_uc;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 void intel_uc_debugfs_register(struct intel_uc *uc,
 			       struct debugfs_node *gt_root);
diff --git a/drivers/gpu/drm/i915/i915_debugfs_params.h b/drivers/gpu/drm/i915/i915_debugfs_params.h
index a64cf27ece5d..10b89c55521c 100644
--- a/drivers/gpu/drm/i915/i915_debugfs_params.h
+++ b/drivers/gpu/drm/i915/i915_debugfs_params.h
@@ -7,7 +7,7 @@
 #define __I915_DEBUGFS_PARAMS__
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct drm_i915_private;
 
 struct debugfs_node *i915_debugfs_params(struct drm_i915_private *i915);
diff --git a/drivers/gpu/drm/imagination/pvr_debugfs.h b/drivers/gpu/drm/imagination/pvr_debugfs.h
index dab4b40bd0ea..359f9f42c8a8 100644
--- a/drivers/gpu/drm/imagination/pvr_debugfs.h
+++ b/drivers/gpu/drm/imagination/pvr_debugfs.h
@@ -13,7 +13,7 @@ struct pvr_device;
 
 /* Forward declaration from <linux/dcache.h>. */
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 struct pvr_debugfs_entry {
 	const char *name;
diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.h b/drivers/gpu/drm/imagination/pvr_fw_trace.h
index 0f088f7d4715..5b53d5a80a5e 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.h
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.h
@@ -68,7 +68,7 @@ void pvr_fw_trace_fini(struct pvr_device *pvr_dev);
 #if defined(CONFIG_DEBUG_FS)
 /* Forward declaration from <linux/dcache.h>. */
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 void pvr_fw_trace_mask_update(struct pvr_device *pvr_dev, u32 old_mask,
 			      u32 new_mask);
diff --git a/drivers/gpu/drm/imagination/pvr_params.h b/drivers/gpu/drm/imagination/pvr_params.h
index a186e5da0849..372fe4c63823 100644
--- a/drivers/gpu/drm/imagination/pvr_params.h
+++ b/drivers/gpu/drm/imagination/pvr_params.h
@@ -65,7 +65,7 @@ struct pvr_device;
 
 /* Forward declaration from <linux/dcache.h>. */
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 void pvr_params_debugfs_init(struct pvr_device *pvr_dev,
 			     struct debugfs_node *dir);
diff --git a/drivers/gpu/drm/ttm/ttm_module.h b/drivers/gpu/drm/ttm/ttm_module.h
index a33f48f7bc29..e74fa76b8912 100644
--- a/drivers/gpu/drm/ttm/ttm_module.h
+++ b/drivers/gpu/drm/ttm/ttm_module.h
@@ -34,7 +34,7 @@
 #define TTM_PFX "[TTM] "
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct ttm_device;
 
 extern struct debugfs_node *ttm_debugfs_root;
diff --git a/drivers/gpu/drm/xe/xe_gsc_debugfs.h b/drivers/gpu/drm/xe/xe_gsc_debugfs.h
index 02f14eca14b8..9a292200678d 100644
--- a/drivers/gpu/drm/xe/xe_gsc_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_gsc_debugfs.h
@@ -7,7 +7,7 @@
 #define _XE_GSC_DEBUGFS_H_
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct xe_gsc;
 
 void xe_gsc_debugfs_register(struct xe_gsc *gsc, struct debugfs_node *parent);
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.h b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.h
index 3f8be90e1494..11b0e8d01b11 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.h
@@ -8,7 +8,7 @@
 
 struct xe_gt;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 #ifdef CONFIG_PCI_IOV
 void xe_gt_sriov_pf_debugfs_register(struct xe_gt *gt,
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.h b/drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.h
index f772717cb19f..bce428e10a83 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_vf_debugfs.h
@@ -8,7 +8,7 @@
 
 struct xe_gt;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 void xe_gt_sriov_vf_debugfs_register(struct xe_gt *gt,
 				     struct debugfs_node *root);
diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.h b/drivers/gpu/drm/xe/xe_guc_debugfs.h
index 89b0ad43bdbd..7a87a608dbf5 100644
--- a/drivers/gpu/drm/xe/xe_guc_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_guc_debugfs.h
@@ -7,7 +7,7 @@
 #define _XE_GUC_DEBUGFS_H_
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct xe_guc;
 
 void xe_guc_debugfs_register(struct xe_guc *guc, struct debugfs_node *parent);
diff --git a/drivers/gpu/drm/xe/xe_huc_debugfs.h b/drivers/gpu/drm/xe/xe_huc_debugfs.h
index 7fc23627c305..1dbf07be3921 100644
--- a/drivers/gpu/drm/xe/xe_huc_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_huc_debugfs.h
@@ -7,7 +7,7 @@
 #define _XE_HUC_DEBUGFS_H_
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct xe_huc;
 
 void xe_huc_debugfs_register(struct xe_huc *huc, struct debugfs_node *parent);
diff --git a/drivers/gpu/drm/xe/xe_uc_debugfs.h b/drivers/gpu/drm/xe/xe_uc_debugfs.h
index 7373c5c97774..7f31fa8634c0 100644
--- a/drivers/gpu/drm/xe/xe_uc_debugfs.h
+++ b/drivers/gpu/drm/xe/xe_uc_debugfs.h
@@ -7,7 +7,7 @@
 #define _XE_UC_DEBUGFS_H_
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct xe_uc;
 
 void xe_uc_debugfs_register(struct xe_uc *uc, struct debugfs_node *parent);
diff --git a/drivers/gpu/host1x/dev.h b/drivers/gpu/host1x/dev.h
index 5deea78f8c6f..c0c9f4575a35 100644
--- a/drivers/gpu/host1x/dev.h
+++ b/drivers/gpu/host1x/dev.h
@@ -28,7 +28,7 @@ struct host1x_job;
 struct push_buffer;
 struct output;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 struct host1x_channel_ops {
 	int (*init)(struct host1x_channel *channel, struct host1x *host,
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
index 43b14290e948..b4918662536f 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
@@ -28,7 +28,7 @@
 
 struct clk_bulk_data;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct device;
 struct media_intf_devnode;
 struct regmap;
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index 97f2c02585d2..38e94b7955d5 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -24,7 +24,7 @@
 #include "rkisp1-regs.h"
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct regmap;
 
 /*
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 3c656370aed1..b5d77cced286 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -698,7 +698,7 @@ struct port_info {
 };
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct work_struct;
 
 enum {                                 /* adapter flags */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
index b092a94f68b5..f3473e2a788f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
@@ -11,7 +11,7 @@
 #include "eswitch.h"
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct mlx5_flow_table;
 struct mlx5_flow_group;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index adf2870db071..7abeeef362d7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -330,7 +330,7 @@ enum {
 };
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct mlx5_qos_domain;
 
 struct mlx5_eswitch {
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.h b/drivers/net/ethernet/netronome/nfp/nfp_main.h
index 61cbd85bd992..83ea5565dee4 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.h
@@ -17,7 +17,7 @@
 #include <net/devlink.h>
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct device;
 struct pci_dev;
 
diff --git a/drivers/net/wireless/broadcom/b43/debugfs.h b/drivers/net/wireless/broadcom/b43/debugfs.h
index 762cdb114a3d..d9f4011f5419 100644
--- a/drivers/net/wireless/broadcom/b43/debugfs.h
+++ b/drivers/net/wireless/broadcom/b43/debugfs.h
@@ -21,7 +21,7 @@ enum b43_dyndbg {		/* Dynamic debugging features */
 #ifdef CONFIG_B43_DEBUG
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 #define B43_NR_LOGGED_TXSTATUS	100
 
diff --git a/drivers/net/wireless/broadcom/b43legacy/debugfs.h b/drivers/net/wireless/broadcom/b43legacy/debugfs.h
index 350f3b4c40f6..c02cb4297852 100644
--- a/drivers/net/wireless/broadcom/b43legacy/debugfs.h
+++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.h
@@ -18,7 +18,7 @@ enum b43legacy_dyndbg { /* Dynamic debugging features */
 #ifdef CONFIG_B43LEGACY_DEBUG
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 #define B43legacy_NR_LOGGED_TXSTATUS	100
 
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 718582f840bb..a02a78c22f87 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -17,7 +17,7 @@
 #include <linux/pinctrl/machine.h>
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct device;
 struct device_node;
 struct module;
diff --git a/drivers/pinctrl/pinconf.h b/drivers/pinctrl/pinconf.h
index d041365f2b6b..2438e599b447 100644
--- a/drivers/pinctrl/pinconf.h
+++ b/drivers/pinctrl/pinconf.h
@@ -13,7 +13,7 @@
 #include <linux/errno.h>
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct device_node;
 struct seq_file;
 
diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
index ceae33f3e637..878f8d6198ed 100644
--- a/drivers/pinctrl/pinmux.h
+++ b/drivers/pinctrl/pinmux.h
@@ -13,7 +13,7 @@
 #include <linux/types.h>
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct seq_file;
 
 struct pinctrl_dev;
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 83f5fdf52f96..a4569a00bd7b 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -20,7 +20,7 @@ struct ucsi;
 struct ucsi_altmode;
 struct ucsi_connector;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 /* UCSI offsets (Bytes) */
 #define UCSI_VERSION			0
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.h b/drivers/video/fbdev/omap2/omapfb/dss/dss.h
index 7f7ce807f70c..9af98085be92 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.h
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.h
@@ -319,7 +319,7 @@ static inline void sdi_uninit_port(struct device_node *port)
 #ifdef CONFIG_FB_OMAP2_DSS_DSI
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct file_operations;
 
 int dsi_init_platform_driver(void) __init;
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 69e9ddcb113d..2abfb8459ace 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -568,11 +568,12 @@ ssize_t debugfs_attr_write_signed(struct file *file, const char __user *buf,
 }
 EXPORT_SYMBOL_GPL(debugfs_attr_write_signed);
 
-static struct dentry *debugfs_create_mode_unsafe(const char *name, umode_t mode,
-					struct dentry *parent, void *value,
-					const struct file_operations *fops,
-					const struct file_operations *fops_ro,
-					const struct file_operations *fops_wo)
+static struct debugfs_node *
+debugfs_create_mode_unsafe(const char *name, umode_t mode,
+			   struct debugfs_node *parent, void *value,
+			   const struct file_operations *fops,
+			   const struct file_operations *fops_ro,
+			   const struct file_operations *fops_wo)
 {
 	/* if there are no write bits set, make read only */
 	if (!(mode & S_IWUGO))
@@ -604,8 +605,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u8_wo, NULL, debugfs_u8_set, "%llu\n");
  * debugfs_create_u8 - create a debugfs file that is used to read and write an unsigned 8-bit value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
@@ -614,7 +615,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u8_wo, NULL, debugfs_u8_set, "%llu\n");
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
  */
-void debugfs_create_u8(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_u8(const char *name, umode_t mode, struct debugfs_node *parent,
 		       u8 *value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u8,
@@ -640,8 +641,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u16_wo, NULL, debugfs_u16_set, "%llu\n");
  * debugfs_create_u16 - create a debugfs file that is used to read and write an unsigned 16-bit value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
@@ -650,7 +651,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u16_wo, NULL, debugfs_u16_set, "%llu\n");
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
  */
-void debugfs_create_u16(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_u16(const char *name, umode_t mode, struct debugfs_node *parent,
 			u16 *value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u16,
@@ -676,8 +677,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u32_wo, NULL, debugfs_u32_set, "%llu\n");
  * debugfs_create_u32 - create a debugfs file that is used to read and write an unsigned 32-bit value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
@@ -686,7 +687,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u32_wo, NULL, debugfs_u32_set, "%llu\n");
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
  */
-void debugfs_create_u32(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_u32(const char *name, umode_t mode, struct debugfs_node *parent,
 			u32 *value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u32,
@@ -713,8 +714,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
  * debugfs_create_u64 - create a debugfs file that is used to read and write an unsigned 64-bit value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
@@ -723,7 +724,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
  */
-void debugfs_create_u64(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_u64(const char *name, umode_t mode, struct debugfs_node *parent,
 			u64 *value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u64,
@@ -752,8 +753,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ulong_wo, NULL, debugfs_ulong_set, "%llu\n");
  * an unsigned long value.
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
@@ -762,7 +763,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ulong_wo, NULL, debugfs_ulong_set, "%llu\n");
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
  */
-void debugfs_create_ulong(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_ulong(const char *name, umode_t mode, struct debugfs_node *parent,
 			  unsigned long *value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_ulong,
@@ -801,13 +802,13 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_x64_wo, NULL, debugfs_u64_set, "0x%016llx\n");
  * debugfs_create_x8 - create a debugfs file that is used to read and write an unsigned 8-bit value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
-void debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_x8(const char *name, umode_t mode, struct debugfs_node *parent,
 		       u8 *value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x8,
@@ -819,13 +820,13 @@ EXPORT_SYMBOL_GPL(debugfs_create_x8);
  * debugfs_create_x16 - create a debugfs file that is used to read and write an unsigned 16-bit value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
-void debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_x16(const char *name, umode_t mode, struct debugfs_node *parent,
 			u16 *value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x16,
@@ -837,13 +838,13 @@ EXPORT_SYMBOL_GPL(debugfs_create_x16);
  * debugfs_create_x32 - create a debugfs file that is used to read and write an unsigned 32-bit value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
-void debugfs_create_x32(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_x32(const char *name, umode_t mode, struct debugfs_node *parent,
 			u32 *value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x32,
@@ -855,13 +856,13 @@ EXPORT_SYMBOL_GPL(debugfs_create_x32);
  * debugfs_create_x64 - create a debugfs file that is used to read and write an unsigned 64-bit value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
-void debugfs_create_x64(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_x64(const char *name, umode_t mode, struct debugfs_node *parent,
 			u64 *value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x64,
@@ -889,14 +890,14 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_size_t_wo, NULL, debugfs_size_t_set, "%llu\n");
  * debugfs_create_size_t - create a debugfs file that is used to read and write an size_t value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
 void debugfs_create_size_t(const char *name, umode_t mode,
-			   struct dentry *parent, size_t *value)
+			   struct debugfs_node *parent, size_t *value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_size_t,
 				   &fops_size_t_ro, &fops_size_t_wo);
@@ -925,14 +926,14 @@ DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(fops_atomic_t_wo, NULL, debugfs_atomic_t_set,
  * write an atomic_t value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
 void debugfs_create_atomic_t(const char *name, umode_t mode,
-			     struct dentry *parent, atomic_t *value)
+			     struct debugfs_node *parent, atomic_t *value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_atomic_t,
 				   &fops_atomic_t_ro, &fops_atomic_t_wo);
@@ -1006,8 +1007,8 @@ static const struct file_operations fops_bool_wo = {
  * debugfs_create_bool - create a debugfs file that is used to read and write a boolean value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
@@ -1016,7 +1017,7 @@ static const struct file_operations fops_bool_wo = {
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
  */
-void debugfs_create_bool(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_bool(const char *name, umode_t mode, struct debugfs_node *parent,
 			 bool *value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_bool,
@@ -1134,8 +1135,8 @@ static const struct file_operations fops_str_wo = {
  * debugfs_create_str - create a debugfs file that is used to read and write a string value
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
@@ -1145,7 +1146,7 @@ static const struct file_operations fops_str_wo = {
  * set, it can be read from, and written to.
  */
 void debugfs_create_str(const char *name, umode_t mode,
-			struct dentry *parent, char **value)
+			struct debugfs_node *parent, char **value)
 {
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_str,
 				   &fops_str_ro, &fops_str_wo);
@@ -1196,8 +1197,8 @@ static const struct file_operations fops_blob = {
  * a binary blob
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @blob: a pointer to a struct debugfs_blob_wrapper which contains a pointer
  *        to the blob data and the size of the data.
@@ -1206,7 +1207,7 @@ static const struct file_operations fops_blob = {
  * @blob->data as a binary blob. If the @mode variable is so set it can be
  * read from and written to.
  *
- * This function will return a pointer to a dentry if it succeeds.  This
+ * This function will return a pointer to a debugfs_node if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
  * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
@@ -1215,8 +1216,8 @@ static const struct file_operations fops_blob = {
  * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
  * be returned.
  */
-struct dentry *debugfs_create_blob(const char *name, umode_t mode,
-				   struct dentry *parent,
+struct debugfs_node *debugfs_create_blob(const char *name, umode_t mode,
+				   struct debugfs_node *parent,
 				   struct debugfs_blob_wrapper *blob)
 {
 	return debugfs_create_file_unsafe(name, mode & 0644, parent, blob, &fops_blob);
@@ -1292,8 +1293,8 @@ static const struct file_operations u32_array_fops = {
  * array.
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have.
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @array: wrapper struct containing data pointer and size of the array.
  *
@@ -1303,7 +1304,7 @@ static const struct file_operations u32_array_fops = {
  * Once array is created its size can not be changed.
  */
 void debugfs_create_u32_array(const char *name, umode_t mode,
-			      struct dentry *parent,
+			      struct debugfs_node *parent,
 			      struct debugfs_u32_array *array)
 {
 	debugfs_create_file_unsafe(name, mode, parent, array, &u32_array_fops);
@@ -1370,8 +1371,8 @@ DEFINE_SHOW_ATTRIBUTE(debugfs_regset32);
  * debugfs_create_regset32 - create a debugfs file that returns register values
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @regset: a pointer to a struct debugfs_regset32, which contains a pointer
  *          to an array of register definitions, the array size and the base
@@ -1382,7 +1383,7 @@ DEFINE_SHOW_ATTRIBUTE(debugfs_regset32);
  * is so set it can be read from. Writing is not supported.
  */
 void debugfs_create_regset32(const char *name, umode_t mode,
-			     struct dentry *parent,
+			     struct debugfs_node *parent,
 			     struct debugfs_regset32 *regset)
 {
 	debugfs_create_file(name, mode, parent, regset, &debugfs_regset32_fops);
@@ -1416,13 +1417,13 @@ static const struct file_operations debugfs_devm_entry_ops = {
  *
  * @dev: device related to this debugfs file.
  * @name: name of the debugfs file.
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *	directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *	directory debugfs_node if set.  If this parameter is %NULL, then the
  *	file will be created in the root of the debugfs filesystem.
  * @read_fn: function pointer called to print the seq_file content.
  */
 void debugfs_create_devm_seqfile(struct device *dev, const char *name,
-				 struct dentry *parent,
+				 struct debugfs_node *parent,
 				 int (*read_fn)(struct seq_file *s, void *data))
 {
 	struct debugfs_devm_entry *entry;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 6892538d9d49..7f0ba38ad0d6 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -37,6 +37,11 @@ static int debugfs_mount_count;
 static bool debugfs_registered;
 static unsigned int debugfs_allow __ro_after_init = DEFAULT_DEBUGFS_ALLOW_BITS;
 
+static inline struct debugfs_node *dentry_to_node(struct dentry *dentry)
+{
+	return container_of(dentry, struct debugfs_node, dentry);
+}
+
 /*
  * Don't allow access attributes to be changed whilst the kernel is locked down
  * so that we can use the file mode as part of a heuristic to determine whether
@@ -327,67 +332,70 @@ MODULE_ALIAS_FS("debugfs");
 /**
  * debugfs_lookup() - look up an existing debugfs file
  * @name: a pointer to a string containing the name of the file to look up.
- * @parent: a pointer to the parent dentry of the file.
+ * @parent: a pointer to the parent debugfs_node of the file.
  *
- * This function will return a pointer to a dentry if it succeeds.  If the file
- * doesn't exist or an error occurs, %NULL will be returned.  The returned
- * dentry must be passed to dput() when it is no longer needed.
+ * This function will return a pointer to a debugfs_node if it succeeds.
+ * If the file doesn't exist or an error occurs, %NULL will be returned.
+ * The returned debugfs_node must be passed to debugfs_node_put() when
+ * it is no longer needed.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
+struct debugfs_node *debugfs_lookup(const char *name, struct debugfs_node *parent)
 {
+	struct debugfs_node *node;
 	struct dentry *dentry;
 
 	if (!debugfs_initialized() || IS_ERR_OR_NULL(name) || IS_ERR(parent))
 		return NULL;
 
 	if (!parent)
-		parent = debugfs_mount->mnt_root;
+		parent = dentry_to_node(debugfs_mount->mnt_root);
 
-	dentry = lookup_positive_unlocked(name, parent, strlen(name));
-	if (IS_ERR(dentry))
+	dentry = lookup_positive_unlocked(name, &parent->dentry, strlen(name));
+	node = dentry_to_node(dentry);
+	if (IS_ERR(node))
 		return NULL;
-	return dentry;
+	return node;
 }
 EXPORT_SYMBOL_GPL(debugfs_lookup);
 
 char *debugfs_node_path_raw(struct debugfs_node *node, char *buf, size_t buflen)
 {
-	return dentry_path_raw(node, buf, buflen);
+	return dentry_path_raw(&node->dentry, buf, buflen);
 }
 EXPORT_SYMBOL_GPL(debugfs_node_path_raw);
 
 struct debugfs_node *debugfs_node_get(struct debugfs_node *node)
 {
-	return dget(node);
+	return dentry_to_node(dget(&node->dentry));
 }
 EXPORT_SYMBOL_GPL(debugfs_node_get);
 
 void debugfs_node_put(struct debugfs_node *node)
 {
-	dput(node);
+	dput(&node->dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_node_put);
 
 struct inode *debugfs_node_inode(struct debugfs_node *node)
 {
-	return d_inode(node);
+	return d_inode(&node->dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_node_inode);
 
 struct debugfs_node *debugfs_node_from_dentry(struct dentry *dentry)
 {
 	if (dentry->d_sb->s_op == &debugfs_super_operations)
-		return dentry;
+		return dentry_to_node(dentry);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(debugfs_node_from_dentry);
 
 struct dentry *debugfs_node_dentry(struct debugfs_node *node)
 {
-	return node;
+	return &node->dentry;
 }
 EXPORT_SYMBOL_GPL(debugfs_node_dentry);
 
@@ -504,25 +512,34 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	return end_creating(dentry);
 }
 
-struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
-					struct dentry *parent, void *data,
+struct debugfs_node *debugfs_create_file_full(const char *name, umode_t mode,
+					struct debugfs_node *parent, void *data,
 					const void *aux,
 					const struct file_operations *fops)
 {
-	return __debugfs_create_file(name, mode, parent, data, aux,
-				&debugfs_full_proxy_file_operations,
-				fops);
+	struct dentry *dentry;
+
+	dentry = __debugfs_create_file(name, mode, &parent->dentry,
+				       data, aux,
+				       &debugfs_full_proxy_file_operations,
+				       fops);
+	return dentry_to_node(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_full);
 
-struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
-					struct dentry *parent, void *data,
+struct debugfs_node *debugfs_create_file_short(const char *name, umode_t mode,
+					struct debugfs_node *parent, void *data,
 					const void *aux,
 					const struct debugfs_short_fops *fops)
 {
-	return __debugfs_create_file(name, mode, parent, data, aux,
-				&debugfs_full_short_proxy_file_operations,
-				fops);
+
+	struct dentry *dentry;
+
+	dentry = __debugfs_create_file(name, mode, &parent->dentry,
+				       data, aux,
+				       &debugfs_full_short_proxy_file_operations,
+				       fops);
+	return dentry_to_node(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_short);
 
@@ -530,9 +547,10 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_short);
  * debugfs_create_file_unsafe - create a file in the debugfs filesystem
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have.
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is NULL, then the
- *          file will be created in the root of the debugfs filesystem.
+ * @parent: a pointer to the parent debugfs_node for this file. This
+ *          should be a directory debugfs_node if set. If this parameter
+ *          is NULL, then the file will be created in the root of the
+ *          debugfs filesystem.
  * @data: a pointer to something that the caller will want to get to later
  *        on.  The inode.i_private pointer will point to this value on
  *        the open() call.
@@ -553,14 +571,17 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_short);
  * DEFINE_DEBUGFS_ATTRIBUTE() is protected against file removals and
  * thus, may be used here.
  */
-struct dentry *debugfs_create_file_unsafe(const char *name, umode_t mode,
-				   struct dentry *parent, void *data,
+struct debugfs_node *debugfs_create_file_unsafe(const char *name, umode_t mode,
+				   struct debugfs_node *parent, void *data,
 				   const struct file_operations *fops)
 {
+	struct dentry *dentry;
+
+	dentry = __debugfs_create_file(name, mode, &parent->dentry, data,
+				       NULL, &debugfs_open_proxy_file_operations,
+				       fops);
 
-	return __debugfs_create_file(name, mode, parent, data, NULL,
-				&debugfs_open_proxy_file_operations,
-				fops);
+	return dentry_to_node(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_unsafe);
 
@@ -568,9 +589,10 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_unsafe);
  * debugfs_create_file_size - create a file in the debugfs filesystem
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have.
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is NULL, then the
- *          file will be created in the root of the debugfs filesystem.
+ * @parent: a pointer to the parent debugfs_node for this file. This
+ *          should be a directory debugfs_node if set. If this parameter
+ *          is NULL, then the file will be created in the root of the
+ *          debugfs filesystem.
  * @data: a pointer to something that the caller will want to get to later
  *        on.  The inode.i_private pointer will point to this value on
  *        the open() call.
@@ -584,14 +606,14 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_unsafe);
  * recommended to be used instead.)
  */
 void debugfs_create_file_size(const char *name, umode_t mode,
-			      struct dentry *parent, void *data,
+			      struct debugfs_node *parent, void *data,
 			      const struct file_operations *fops,
 			      loff_t file_size)
 {
-	struct dentry *de = debugfs_create_file(name, mode, parent, data, fops);
+	struct debugfs_node *de = debugfs_create_file(name, mode, parent, data, fops);
 
 	if (!IS_ERR(de))
-		d_inode(de)->i_size = file_size;
+		d_inode(&de->dentry)->i_size = file_size;
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_size);
 
@@ -599,33 +621,35 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_size);
  * debugfs_create_dir - create a directory in the debugfs filesystem
  * @name: a pointer to a string containing the name of the directory to
  *        create.
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is NULL, then the
- *          directory will be created in the root of the debugfs filesystem.
+ * @parent: a pointer to the parent debugfs_node for this file. This
+ *          should be a directory debugfs_node if set. If this parameter
+ *          is NULL, then the directory will be created in the root of
+ *          the debugfs filesystem.
  *
  * This function creates a directory in debugfs with the given name.
  *
- * This function will return a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the debugfs_remove() function when the file is
- * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
- * returned.
+ * This function will return a pointer to a debugfs_node if it succeeds.
+ * This pointer must be passed to the debugfs_remove() function when the
+ * file is to be removed (no automatic cleanup happens if your module is
+ * unloaded, you are responsible here.) If an error occurs,
+ * ERR_PTR(-ERROR) will be returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  *
- * NOTE: it's expected that most callers should _ignore_ the errors returned
- * by this function. Other debugfs functions handle the fact that the "dentry"
- * passed to them could be an error and they don't crash in that case.
- * Drivers should generally work fine even if debugfs fails to init anyway.
+ * NOTE: it's expected that most callers should _ignore_ the errors
+ * returned by this function. Other debugfs functions handle the fact
+ * that the "debugfs_node" passed to them could be an error and they
+ * don't crash in that case. Drivers should generally work fine even if
+ * debugfs fails to init anyway.
  */
-struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
+struct debugfs_node *debugfs_create_dir(const char *name, struct debugfs_node *parent)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry = start_creating(name, &parent->dentry);
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
-		return dentry;
+		return dentry_to_node(dentry);
 
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
 		failed_creating(dentry);
@@ -636,7 +660,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create directory '%s'\n",
 		       name);
-		return failed_creating(dentry);
+		return dentry_to_node(failed_creating(dentry));
 	}
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
@@ -648,16 +672,17 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return dentry_to_node(end_creating(dentry));
 }
 EXPORT_SYMBOL_GPL(debugfs_create_dir);
 
 /**
  * debugfs_create_automount - create automount point in the debugfs filesystem
  * @name: a pointer to a string containing the name of the file to create.
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is NULL, then the
- *          file will be created in the root of the debugfs filesystem.
+ * @parent: a pointer to the parent debugfs_node for this file. This
+ *          should be a directory debugfs_node if set. If this parameter
+ *          is NULL, then the file will be created in the root of the
+ *          debugfs filesystem.
  * @f: function to be called when pathname resolution steps on that one.
  * @data: opaque argument to pass to f().
  *
@@ -703,27 +728,28 @@ EXPORT_SYMBOL(debugfs_create_automount);
  * debugfs_create_symlink- create a symbolic link in the debugfs filesystem
  * @name: a pointer to a string containing the name of the symbolic link to
  *        create.
- * @parent: a pointer to the parent dentry for this symbolic link.  This
- *          should be a directory dentry if set.  If this parameter is NULL,
- *          then the symbolic link will be created in the root of the debugfs
- *          filesystem.
+ * @parent: a pointer to the parent debugfs_node for this symbolic link.
+ *          This should be a directory debugfs_node if set. If this
+ *          parameter is NULL, then the symbolic link will be created in
+ *          the root of the debugfs filesystem.
  * @target: a pointer to a string containing the path to the target of the
  *          symbolic link.
  *
  * This function creates a symbolic link with the given name in debugfs that
  * links to the given target path.
  *
- * This function will return a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the debugfs_remove() function when the symbolic
- * link is to be removed (no automatic cleanup happens if your module is
- * unloaded, you are responsible here.)  If an error occurs, ERR_PTR(-ERROR)
- * will be returned.
+ * This function will return a pointer to a debugfs_node if it succeeds.
+ * This pointer must be passed to the debugfs_remove() function when the
+ * symbolic link is to be removed (no automatic cleanup happens if your
+ * module is unloaded, you are responsible here.) If an error occurs,
+ * ERR_PTR(-ERROR) will be returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
-				      const char *target)
+struct debugfs_node *debugfs_create_symlink(const char *name,
+					    struct debugfs_node *parent,
+					    const char *target)
 {
 	struct dentry *dentry;
 	struct inode *inode;
@@ -731,10 +757,10 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 	if (!link)
 		return ERR_PTR(-ENOMEM);
 
-	dentry = start_creating(name, parent);
+	dentry = start_creating(name, &parent->dentry);
 	if (IS_ERR(dentry)) {
 		kfree(link);
-		return dentry;
+		return dentry_to_node(dentry);
 	}
 
 	inode = debugfs_get_inode(dentry->d_sb);
@@ -742,13 +768,13 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 		pr_err("out of free dentries, can not create symlink '%s'\n",
 		       name);
 		kfree(link);
-		return failed_creating(dentry);
+		return dentry_to_node(failed_creating(dentry));
 	}
 	inode->i_mode = S_IFLNK | S_IRWXUGO;
 	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
 	d_instantiate(dentry, inode);
-	return end_creating(dentry);
+	return dentry_to_node(end_creating(dentry));
 }
 EXPORT_SYMBOL_GPL(debugfs_create_symlink);
 
@@ -806,7 +832,7 @@ static void __debugfs_file_removed(struct dentry *dentry)
 		while ((c = list_first_entry_or_null(&fsd->cancellations,
 						     typeof(*c), list))) {
 			list_del_init(&c->list);
-			c->cancel(dentry, c->cancel_data);
+			c->cancel(dentry_to_node(dentry), c->cancel_data);
 		}
 		mutex_unlock(&fsd->cancellations_mtx);
 
@@ -823,8 +849,9 @@ static void remove_one(struct dentry *victim)
 
 /**
  * debugfs_remove - recursively removes a directory
- * @dentry: a pointer to a the dentry of the directory to be removed.  If this
- *          parameter is NULL or an error value, nothing will be done.
+ * @node: a pointer to a the debugfs_node of the directory to be
+ *        removed. If this parameter is NULL or an error value, nothing
+ *        will be done.
  *
  * This function recursively removes a directory tree in debugfs that
  * was previously created with a call to another debugfs function
@@ -834,13 +861,13 @@ static void remove_one(struct dentry *victim)
  * removed, no automatic cleanup of files will happen when a module is
  * removed, you are responsible here.
  */
-void debugfs_remove(struct dentry *dentry)
+void debugfs_remove(struct debugfs_node *node)
 {
-	if (IS_ERR_OR_NULL(dentry))
+	if (IS_ERR_OR_NULL(node))
 		return;
 
 	simple_pin_fs(&debug_fs_type, &debugfs_mount, &debugfs_mount_count);
-	simple_recursive_removal(dentry, remove_one);
+	simple_recursive_removal(&node->dentry, remove_one);
 	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 }
 EXPORT_SYMBOL_GPL(debugfs_remove);
@@ -848,28 +875,28 @@ EXPORT_SYMBOL_GPL(debugfs_remove);
 /**
  * debugfs_lookup_and_remove - lookup a directory or file and recursively remove it
  * @name: a pointer to a string containing the name of the item to look up.
- * @parent: a pointer to the parent dentry of the item.
+ * @parent: a pointer to the parent debugfs_node of the item.
  *
  * This is the equlivant of doing something like
  * debugfs_remove(debugfs_lookup(..)) but with the proper reference counting
  * handled for the directory being looked up.
  */
-void debugfs_lookup_and_remove(const char *name, struct dentry *parent)
+void debugfs_lookup_and_remove(const char *name, struct debugfs_node *parent)
 {
-	struct dentry *dentry;
+	struct debugfs_node *node;
 
-	dentry = debugfs_lookup(name, parent);
-	if (!dentry)
+	node = debugfs_lookup(name, parent);
+	if (!node)
 		return;
 
-	debugfs_remove(dentry);
-	dput(dentry);
+	debugfs_remove(node);
+	dput(&node->dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
 
 /**
  * debugfs_change_name - rename a file/directory in the debugfs filesystem
- * @dentry: dentry of an object to be renamed.
+ * @node: debugfs_node of an object to be renamed.
  * @fmt: format for new name
  *
  * This function renames a file/directory in debugfs.  The target must not
@@ -880,11 +907,12 @@ EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-int __printf(2, 3) debugfs_change_name(struct dentry *dentry, const char *fmt, ...)
+int __printf(2, 3) debugfs_change_name(struct debugfs_node *node, const char *fmt, ...)
 {
 	int error = 0;
 	const char *new_name;
 	struct name_snapshot old_name;
+	struct dentry *dentry = &node->dentry;
 	struct dentry *parent, *target;
 	struct inode *dir;
 	va_list ap;
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 93483fe84425..c7a9a62dfcd0 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -7,10 +7,16 @@
 
 #ifndef _DEBUGFS_INTERNAL_H_
 #define _DEBUGFS_INTERNAL_H_
+
+#include <linux/debugfs.h>
 #include <linux/list.h>
 
 struct file_operations;
 
+struct debugfs_node {
+	struct dentry dentry;
+};
+
 struct debugfs_inode_info {
 	struct inode vfs_inode;
 	union {
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 7b1e2ad2d285..0b6726c56c69 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -34,7 +34,7 @@
 
 #include <uapi/drm/drm_mode.h>
 
-#define debugfs_node dentry
+struct debugfs_node;
 struct drm_connector_helper_funcs;
 struct drm_modeset_acquire_ctx;
 struct drm_device;
diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
index efce45002f86..b411a7ca51f1 100644
--- a/include/drm/drm_debugfs.h
+++ b/include/drm/drm_debugfs.h
@@ -37,7 +37,7 @@
 
 #include <drm/drm_gpuvm.h>
 
-#define debugfs_node dentry
+struct debugfs_node;
 
 /**
  * DRM_DEBUGFS_GPUVA_INFO - &drm_info_list entry to dump a GPU VA space
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 3703ae656970..824cb3326ff1 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -38,7 +38,7 @@
 
 #include <drm/drm_prime.h>
 
-#define debugfs_node dentry
+struct debugfs_node;
 struct dma_fence;
 struct drm_file;
 struct drm_device;
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 47aa6c0b2853..8c22e618e4a9 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -32,7 +32,7 @@
 
 struct backlight_device;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct device_node;
 struct drm_connector;
 struct drm_device;
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index 5e3d3a927341..ecfdd32fd4ee 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -38,7 +38,7 @@
 #define TTM_MAX_BO_PRIORITY	4U
 #define TTM_NUM_MEM_TYPES 8
 
-#define debugfs_node dentry
+struct debugfs_node;
 struct dmem_cgroup_device;
 struct ttm_device;
 struct ttm_resource_manager;
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 03c80b739a1a..a7ab65f0ce6d 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -17,7 +17,7 @@
 struct page;
 struct device;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 /*
  * Bits in bdi_writeback.state
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5f765a58a66a..e38419722159 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -38,7 +38,7 @@ struct clk;
 struct clk_hw;
 struct clk_core;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 /**
  * struct clk_rate_request - Structure encoding the clk constraints that
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4b0c11cd3d50..4afb60365675 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -127,8 +127,6 @@ struct dentry {
 	} d_u;
 };
 
-#define debugfs_node dentry
-
 /*
  * dentry->d_lock spinlock nesting subclasses:
  *
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 738a990f99cd..f2549e04bf08 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -20,8 +20,7 @@
 
 struct device;
 struct file_operations;
-
-#define debugfs_node dentry
+struct debugfs_node;
 
 struct debugfs_blob_wrapper {
 	void *data;
@@ -45,7 +44,7 @@ struct debugfs_u32_array {
 	u32 n_elements;
 };
 
-extern struct dentry *arch_debugfs_dir;
+extern struct debugfs_node *arch_debugfs_dir;
 
 #define DEFINE_DEBUGFS_ATTRIBUTE_XSIGNED(__fops, __get, __set, __fmt, __is_signed)	\
 static int __fops ## _open(struct inode *inode, struct file *file)	\
@@ -77,7 +76,7 @@ struct debugfs_short_fops {
 
 #if defined(CONFIG_DEBUG_FS)
 
-struct dentry *debugfs_lookup(const char *name, struct dentry *parent);
+struct debugfs_node *debugfs_lookup(const char *name, struct debugfs_node *parent);
 
 char *debugfs_node_path_raw(struct debugfs_node *node, char *buf, size_t buflen);
 
@@ -91,12 +90,12 @@ struct debugfs_node *debugfs_node_from_dentry(struct dentry *dentry);
 
 struct dentry *debugfs_node_dentry(struct debugfs_node *node);
 
-struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
-					struct dentry *parent, void *data,
+struct debugfs_node *debugfs_create_file_full(const char *name, umode_t mode,
+					struct debugfs_node *parent, void *data,
 					const void *aux,
 					const struct file_operations *fops);
-struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
-					 struct dentry *parent, void *data,
+struct debugfs_node *debugfs_create_file_short(const char *name, umode_t mode,
+					 struct debugfs_node *parent, void *data,
 					 const void *aux,
 					 const struct debugfs_short_fops *fops);
 
@@ -104,8 +103,8 @@ struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
  * debugfs_create_file - create a file in the debugfs filesystem
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have.
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @data: a pointer to something that the caller will want to get to later
  *        on.  The inode.i_private pointer will point to this value on
@@ -118,7 +117,7 @@ struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
  * to create a directory, the debugfs_create_dir() function is
  * recommended to be used instead.)
  *
- * This function will return a pointer to a dentry if it succeeds.  This
+ * This function will return a pointer to a debugfs_node if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
  * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
@@ -132,7 +131,7 @@ struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
  * so no module reference or release are needed.
  *
  * NOTE: it's expected that most callers should _ignore_ the errors returned
- * by this function. Other debugfs functions handle the fact that the "dentry"
+ * by this function. Other debugfs functions handle the fact that the "debugfs_node"
  * passed to them could be an error and they don't crash in that case.
  * Drivers should generally work fine even if debugfs fails to init anyway.
  */
@@ -152,18 +151,18 @@ struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
 		 struct debugfs_short_fops *: debugfs_create_file_short)	\
 		(name, mode, parent, data, aux, fops)
 
-struct dentry *debugfs_create_file_unsafe(const char *name, umode_t mode,
-				   struct dentry *parent, void *data,
+struct debugfs_node *debugfs_create_file_unsafe(const char *name, umode_t mode,
+				   struct debugfs_node *parent, void *data,
 				   const struct file_operations *fops);
 
 void debugfs_create_file_size(const char *name, umode_t mode,
-			      struct dentry *parent, void *data,
+			      struct debugfs_node *parent, void *data,
 			      const struct file_operations *fops,
 			      loff_t file_size);
 
-struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
+struct debugfs_node *debugfs_create_dir(const char *name, struct debugfs_node *parent);
 
-struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
+struct debugfs_node *debugfs_create_symlink(const char *name, struct debugfs_node *parent,
 				      const char *dest);
 
 struct dentry *debugfs_create_automount(const char *name,
@@ -171,10 +170,10 @@ struct dentry *debugfs_create_automount(const char *name,
 					debugfs_automount_t f,
 					void *data);
 
-void debugfs_remove(struct dentry *dentry);
+void debugfs_remove(struct debugfs_node *debugfs_node);
 #define debugfs_remove_recursive debugfs_remove
 
-void debugfs_lookup_and_remove(const char *name, struct dentry *parent);
+void debugfs_lookup_and_remove(const char *name, struct debugfs_node *parent);
 
 const struct file_operations *debugfs_real_fops(const struct file *filp);
 const void *debugfs_get_aux(const struct file *file);
@@ -189,52 +188,52 @@ ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
 ssize_t debugfs_attr_write_signed(struct file *file, const char __user *buf,
 			size_t len, loff_t *ppos);
 
-int debugfs_change_name(struct dentry *dentry, const char *fmt, ...) __printf(2, 3);
+int debugfs_change_name(struct debugfs_node *dentry, const char *fmt, ...) __printf(2, 3);
 
-void debugfs_create_u8(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_u8(const char *name, umode_t mode, struct debugfs_node *parent,
 		       u8 *value);
-void debugfs_create_u16(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_u16(const char *name, umode_t mode, struct debugfs_node *parent,
 			u16 *value);
-void debugfs_create_u32(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_u32(const char *name, umode_t mode, struct debugfs_node *parent,
 			u32 *value);
-void debugfs_create_u64(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_u64(const char *name, umode_t mode, struct debugfs_node *parent,
 			u64 *value);
-void debugfs_create_ulong(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_ulong(const char *name, umode_t mode, struct debugfs_node *parent,
 			  unsigned long *value);
-void debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_x8(const char *name, umode_t mode, struct debugfs_node *parent,
 		       u8 *value);
-void debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_x16(const char *name, umode_t mode, struct debugfs_node *parent,
 			u16 *value);
-void debugfs_create_x32(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_x32(const char *name, umode_t mode, struct debugfs_node *parent,
 			u32 *value);
-void debugfs_create_x64(const char *name, umode_t mode, struct dentry *parent,
+void debugfs_create_x64(const char *name, umode_t mode, struct debugfs_node *parent,
 			u64 *value);
 void debugfs_create_size_t(const char *name, umode_t mode,
-			   struct dentry *parent, size_t *value);
+			   struct debugfs_node *parent, size_t *value);
 void debugfs_create_atomic_t(const char *name, umode_t mode,
-			     struct dentry *parent, atomic_t *value);
-void debugfs_create_bool(const char *name, umode_t mode, struct dentry *parent,
+			     struct debugfs_node *parent, atomic_t *value);
+void debugfs_create_bool(const char *name, umode_t mode, struct debugfs_node *parent,
 			 bool *value);
 void debugfs_create_str(const char *name, umode_t mode,
-			struct dentry *parent, char **value);
+			struct debugfs_node *parent, char **value);
 
-struct dentry *debugfs_create_blob(const char *name, umode_t mode,
-				  struct dentry *parent,
+struct debugfs_node *debugfs_create_blob(const char *name, umode_t mode,
+				  struct debugfs_node *parent,
 				  struct debugfs_blob_wrapper *blob);
 
 void debugfs_create_regset32(const char *name, umode_t mode,
-			     struct dentry *parent,
+			     struct debugfs_node *parent,
 			     struct debugfs_regset32 *regset);
 
 void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
 			  int nregs, void __iomem *base, char *prefix);
 
 void debugfs_create_u32_array(const char *name, umode_t mode,
-			      struct dentry *parent,
+			      struct debugfs_node *parent,
 			      struct debugfs_u32_array *array);
 
 void debugfs_create_devm_seqfile(struct device *dev, const char *name,
-				 struct dentry *parent,
+				 struct debugfs_node *parent,
 				 int (*read_fn)(struct seq_file *s, void *data));
 
 bool debugfs_initialized(void);
@@ -256,7 +255,7 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
  */
 struct debugfs_cancellation {
 	struct list_head list;
-	void (*cancel)(struct dentry *, void *);
+	void (*cancel)(struct debugfs_node *, void *);
 	void *cancel_data;
 };
 
@@ -277,8 +276,8 @@ debugfs_leave_cancellation(struct file *file,
  * want to duplicate the design decision mistakes of procfs and devfs again.
  */
 
-static inline struct dentry *debugfs_lookup(const char *name,
-					    struct dentry *parent)
+static inline struct debugfs_node *debugfs_lookup(const char *name,
+					    struct debugfs_node *parent)
 {
 	return ERR_PTR(-ENODEV);
 }
@@ -320,15 +319,15 @@ static inline struct dentry *debugfs_create_file_aux(const char *name,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct dentry *debugfs_create_file(const char *name, umode_t mode,
-					struct dentry *parent, void *data,
+static inline struct debugfs_node *debugfs_create_file(const char *name, umode_t mode,
+					struct debugfs_node *parent, void *data,
 					const void *fops)
 {
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct dentry *debugfs_create_file_unsafe(const char *name,
-					umode_t mode, struct dentry *parent,
+static inline struct debugfs_node *debugfs_create_file_unsafe(const char *name,
+					umode_t mode, struct debugfs_node *parent,
 					void *data,
 					const struct file_operations *fops)
 {
@@ -336,19 +335,19 @@ static inline struct dentry *debugfs_create_file_unsafe(const char *name,
 }
 
 static inline void debugfs_create_file_size(const char *name, umode_t mode,
-					    struct dentry *parent, void *data,
+					    struct debugfs_node *parent, void *data,
 					    const struct file_operations *fops,
 					    loff_t file_size)
 { }
 
-static inline struct dentry *debugfs_create_dir(const char *name,
-						struct dentry *parent)
+static inline struct debugfs_node *debugfs_create_dir(const char *name,
+						struct debugfs_node *parent)
 {
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct dentry *debugfs_create_symlink(const char *name,
-						    struct dentry *parent,
+static inline struct debugfs_node *debugfs_create_symlink(const char *name,
+						    struct debugfs_node *parent,
 						    const char *dest)
 {
 	return ERR_PTR(-ENODEV);
@@ -362,25 +361,25 @@ static inline struct dentry *debugfs_create_automount(const char *name,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline void debugfs_remove(struct dentry *dentry)
+static inline void debugfs_remove(struct debugfs_node *debugfs_node)
 { }
 
-static inline void debugfs_remove_recursive(struct dentry *dentry)
+static inline void debugfs_remove_recursive(struct debugfs_node *debugfs_node)
 { }
 
 static inline void debugfs_lookup_and_remove(const char *name,
-					     struct dentry *parent)
+					     struct debugfs_node *parent)
 { }
 
 const struct file_operations *debugfs_real_fops(const struct file *filp);
 void *debugfs_get_aux(const struct file *file);
 
-static inline int debugfs_file_get(struct dentry *dentry)
+static inline int debugfs_file_get(struct debugfs_node *debugfs_node)
 {
 	return 0;
 }
 
-static inline void debugfs_file_put(struct dentry *dentry)
+static inline void debugfs_file_put(struct debugfs_node *debugfs_node)
 { }
 
 static inline ssize_t debugfs_attr_read(struct file *file, char __user *buf,
@@ -403,66 +402,66 @@ static inline ssize_t debugfs_attr_write_signed(struct file *file,
 	return -ENODEV;
 }
 
-static inline int __printf(2, 3) debugfs_change_name(struct dentry *dentry,
+static inline int __printf(2, 3) debugfs_change_name(struct debugfs_node *dentry,
 					const char *fmt, ...)
 {
 	return -ENODEV;
 }
 
 static inline void debugfs_create_u8(const char *name, umode_t mode,
-				     struct dentry *parent, u8 *value) { }
+				     struct debugfs_node *parent, u8 *value) { }
 
 static inline void debugfs_create_u16(const char *name, umode_t mode,
-				      struct dentry *parent, u16 *value) { }
+				      struct debugfs_node *parent, u16 *value) { }
 
 static inline void debugfs_create_u32(const char *name, umode_t mode,
-				      struct dentry *parent, u32 *value) { }
+				      struct debugfs_node *parent, u32 *value) { }
 
 static inline void debugfs_create_u64(const char *name, umode_t mode,
-				      struct dentry *parent, u64 *value) { }
+				      struct debugfs_node *parent, u64 *value) { }
 
 static inline void debugfs_create_ulong(const char *name, umode_t mode,
-					struct dentry *parent,
+					struct debugfs_node *parent,
 					unsigned long *value) { }
 
 static inline void debugfs_create_x8(const char *name, umode_t mode,
-				     struct dentry *parent, u8 *value) { }
+				     struct debugfs_node *parent, u8 *value) { }
 
 static inline void debugfs_create_x16(const char *name, umode_t mode,
-				      struct dentry *parent, u16 *value) { }
+				      struct debugfs_node *parent, u16 *value) { }
 
 static inline void debugfs_create_x32(const char *name, umode_t mode,
-				      struct dentry *parent, u32 *value) { }
+				      struct debugfs_node *parent, u32 *value) { }
 
 static inline void debugfs_create_x64(const char *name, umode_t mode,
-				      struct dentry *parent, u64 *value) { }
+				      struct debugfs_node *parent, u64 *value) { }
 
 static inline void debugfs_create_size_t(const char *name, umode_t mode,
-					 struct dentry *parent, size_t *value)
+					 struct debugfs_node *parent, size_t *value)
 { }
 
 static inline void debugfs_create_atomic_t(const char *name, umode_t mode,
-					   struct dentry *parent,
+					   struct debugfs_node *parent,
 					   atomic_t *value)
 { }
 
 static inline void debugfs_create_bool(const char *name, umode_t mode,
-				       struct dentry *parent, bool *value) { }
+				       struct debugfs_node *parent, bool *value) { }
 
 static inline void debugfs_create_str(const char *name, umode_t mode,
-				      struct dentry *parent,
+				      struct debugfs_node *parent,
 				      char **value)
 { }
 
-static inline struct dentry *debugfs_create_blob(const char *name, umode_t mode,
-				  struct dentry *parent,
+static inline struct debugfs_node *debugfs_create_blob(const char *name, umode_t mode,
+				  struct debugfs_node *parent,
 				  struct debugfs_blob_wrapper *blob)
 {
 	return ERR_PTR(-ENODEV);
 }
 
 static inline void debugfs_create_regset32(const char *name, umode_t mode,
-					   struct dentry *parent,
+					   struct debugfs_node *parent,
 					   struct debugfs_regset32 *regset)
 {
 }
@@ -478,14 +477,14 @@ static inline bool debugfs_initialized(void)
 }
 
 static inline void debugfs_create_u32_array(const char *name, umode_t mode,
-					    struct dentry *parent,
+					    struct debugfs_node *parent,
 					    struct debugfs_u32_array *array)
 {
 }
 
 static inline void debugfs_create_devm_seqfile(struct device *dev,
 					       const char *name,
-					       struct dentry *parent,
+					       struct debugfs_node *parent,
 					       int (*read_fn)(struct seq_file *s,
 							      void *data))
 {
@@ -524,14 +523,14 @@ static inline ssize_t debugfs_read_file_str(struct file *file,
  * unsigned long value, formatted in hexadecimal
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
+ * @parent: a pointer to the parent debugfs_node for this file.  This should be a
+ *          directory debugfs_node if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
 static inline void debugfs_create_xul(const char *name, umode_t mode,
-				      struct dentry *parent,
+				      struct debugfs_node *parent,
 				      unsigned long *value)
 {
 	if (sizeof(*value) == sizeof(u32))
diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 6691f57aa18c..d5ba99bf101e 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -6,7 +6,7 @@
 #include <linux/types.h>
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct kmem_cache;
 
 #ifdef CONFIG_FAULT_INJECTION
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 19edde4e6307..239a2ceb1844 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -16,7 +16,7 @@ struct module;
 struct irq_desc;
 struct irq_domain;
 struct pt_regs;
-#define debugfs_node dentry
+struct debugfs_node;
 
 /**
  * struct irqstat - interrupt statistics
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 2da002eb5767..c8e7a77201d0 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -17,7 +17,7 @@
 #include <sound/sdca.h>
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct fwnode_handle;
 
 struct sdw_bus;
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 2acfcfa25c44..b86834dc3ff4 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -25,7 +25,7 @@
 
 struct inode;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 static inline bool is_posix_acl_xattr(const char *name)
 {
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index fcabc643d095..080de979a3e5 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -12,7 +12,7 @@
 #include <linux/mutex.h>
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 struct device;
 struct device_node;
 struct v4l2_device;
diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
index f4a53b8dd96f..49dd66fcf746 100644
--- a/include/media/v4l2-dev.h
+++ b/include/media/v4l2-dev.h
@@ -63,7 +63,7 @@ struct video_device;
 struct v4l2_device;
 struct v4l2_ctrl_handler;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 /**
  * enum v4l2_video_device_flags - Flags used by &struct video_device
diff --git a/sound/pci/hda/cs35l56_hda.h b/sound/pci/hda/cs35l56_hda.h
index f1db0ee219aa..61ad06aafc68 100644
--- a/sound/pci/hda/cs35l56_hda.h
+++ b/sound/pci/hda/cs35l56_hda.h
@@ -18,7 +18,7 @@
 #include <sound/cs35l56.h>
 
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 struct cs35l56_hda {
 	struct cs35l56_base base;
diff --git a/sound/soc/sof/sof-client.h b/sound/soc/sof/sof-client.h
index d38b7329b587..bc6c7f3b399b 100644
--- a/sound/soc/sof/sof-client.h
+++ b/sound/soc/sof/sof-client.h
@@ -12,7 +12,7 @@ struct sof_ipc_fw_version;
 struct sof_ipc_cmd_hdr;
 struct snd_sof_dev;
 struct dentry;
-#define debugfs_node dentry
+struct debugfs_node;
 
 struct sof_ipc4_fw_module;
 

