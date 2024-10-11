Return-Path: <linux-fsdevel+bounces-31758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB6C99ABE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 20:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541CE286A8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8691D1E67;
	Fri, 11 Oct 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="s4n74iM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04341D0949
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672883; cv=none; b=ZKc4dzoqrILondeEzUkOtoMlS1b5+48dI9+3b1RvYwuYvOoDDB0qzOMm64iY2S+jIKU/cphzZJnIr66E7w67NTygl+WXrmBci7Ys2+twh6hPvsZeFsds1QZ3xRVRsZUmWI/Klg/9Zqx/Pndosg70PrDr9VhglqtykoX1geSPqoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672883; c=relaxed/simple;
	bh=TVcoi08YdOSb8oDH8EN+lfvTR+VBW0n8+wvckAnUAa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUfMfqcsN0F4OnPmc2iP9wvdGxhXsDRQMhYBXTxNJbZX+2r8BMNaXS/0Gn6q6WsX2GYM+ilVG6+4bSXmkmIrjh5768SwWaBg7q3XtBGbpppYbHMoIz8oMu4YIHn88sdDnQkZBgA59mVsPQcZstt/PEUR7rCyGDaiSc6JQsBtQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=s4n74iM3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4612da0fso1816368f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672876; x=1729277676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZnC+NzMxbBNE8bYS/olhN0qtTPuhjTkO3+y4T7Jrac=;
        b=s4n74iM3kF2n0V+Jrcjc+f89xyxk6aoiJJqLONaAsFy1sxtAFGpnqlidtOp5Ma1DMm
         9Bpr6ZGnqR3n9hc1lcZGqYYTC1gJaCSJHNuoZpQPzXQZti1frSWJLV3UNQhjLT4jnfyu
         CjnrjffrEqUUdrAcbKtoeDd93FymRH+dMXYIbRTaEaWpkzpfr5HumlFDxms+NPXIg24w
         IvZcVc1WN2F3khJamFgrnl2lqA3TOYGug+Utr/L0cf68GlEiTcByFFosAlsFdh4z3qGn
         37VBLFONaLUNiPOiQ5dSw53CaVtfbF3MPq7Zsoti51lJQYm9duWFlMPgb+xDEqmaTG5O
         0stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672876; x=1729277676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZnC+NzMxbBNE8bYS/olhN0qtTPuhjTkO3+y4T7Jrac=;
        b=VtmUigBssrDKOjcOXzFcTDHN4Pauqmsn6LhD+3cN1Hm2km5JLmiEM9sFsyr2FHqXlu
         1P8ZLqZEBC48H/6gq8LEiilemkFpFhIWRQwl1xUvrI18TxNJ0gsSykLJZ/cO7H1pYBDO
         hwc8D0rn08J4FRvDzeVhW/WH6ONbTJIhF3UFLeqPAZ0rsaBhpG2Q0jR9ayT0K9s1oLGq
         mN9dDeyPLeOe6Nkmo/dEFcqhTPKc5OZHA74O8qatgZNFLrMHQSpH9tU6EQwZbWWsKryW
         eEGhZpPEuwVnIV7CDZuA1tsKIX01Wmwgz0zsVkyqe6x++dmAGaACjh+gkCow+oKOGEQK
         gIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUigcMaFxzhUhz/bdG+lEkDihJ3ZI1/K5khlUjcA2hLd0oq/Jnu1/TCjMROccxbrPg5wPLxDEytZ2IuX5v@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/5godRjfHZ1Hij3gomBhjj+Y2zavuXcLUmzXrBlY+ft+76V/
	MyjAtPchuBVjrdSepBPmNYYcdDdKGyadmj4VlmAbf/uEH7or6TZYROsA42ft1y0=
X-Google-Smtp-Source: AGHT+IHF5ftxwy6C2IV6BhdzepwOwmc8pV/1K2VFvT4bOGIqEF+YlIwsiJG8XtWohgCM+DxnW6PhCw==
X-Received: by 2002:a5d:4b4f:0:b0:37c:ccba:8c93 with SMTP id ffacd0b85a97d-37d551d5520mr2941090f8f.11.1728672875839;
        Fri, 11 Oct 2024 11:54:35 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:34 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:04 +0200
Subject: [PATCH v7 05/17] ice, ufs, mmc: use the blk_crypto_key struct when
 programming the key
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-5-e3f7a752059b@linaro.org>
References: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
In-Reply-To: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Asutosh Das <quic_asutoshd@quicinc.com>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9551;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=I7Y+KQKzlXr1sMzaRDIfaMwDopJDttwwaTz2q/TpDsE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRdiOyTz9952m6q9xkxcxzv5R+NuuY425uuP
 OZyG30oqOCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0XQAKCRARpy6gFHHX
 cl3OD/4kJqfrmCHLUkuFbrjWMCbspjq53py6mnP6O8OqR0vXrvBsCuNYRAnLYHzQVo7s1ZcK31j
 A60GPeW7V9FlAw5gxHCWUkFYnPngMZCuLmrzicpBzg1Bfizq7BGdNLkXPj0VOIUP+J7WOSzCPSG
 p2uEisbzWamNpSd/h4Rpt3whOeMYFSBYp/4JIfB89EPCeqhz+5YSOGETtXqVwpCtFfqM1neM69g
 Z6DKCh6ew4BVBEEm/xQCIhBUI5AVW6HfDvOU5GOFyRY1u2SjhwRQnuMVJScU8PzLGOqPv3wGejN
 jTeDbzUrJJQI5nDjUK6n/gaxQ9YDkLeOR8oslD2UTSW4NDYIumd5bDFhnS2Kx9RXt87BQV9HbxP
 nwSNWHsksBQbFfZvdjO/jBqJ6MUNtWDY8VmC+whvmrpSCi2/0ot2hOGgnQUSgEsHewtFxkaqA5M
 SYQUYNFbZ7XNSG9IHYRj3Pn0wfL/VIQkYyHmq9NzopneTWIaUT/1qxEe0hK+THN5cfEffVIWc9h
 CKQ0xWvVqEukh40O4QkAw/9i6M9Ek0Zua34mxPoavEyjm+pNrSVAPpJNIPldLBFh4Ct/CmbJT0E
 p10ilYlAyg/TucqzYILf+qwjU35xjpaErDrmV55TRJjHPgUrp0AXsy+TcU7gw+1yOK5RdtY+WHz
 jlHMDFxePBkxvRA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

The program key ops in the storage controller does not pass on the
blk_crypto_key structure to ICE, this is okay with raw keys of standard
AES XTS sizes. However, wrapped keyblobs can be of any size and in
preparation for that, modify the ICE and storage controller APIs to
accept blk_crypto_key which can carry larger keys and indicate their
size.

Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mmc/host/cqhci-crypto.c  | 7 ++++---
 drivers/mmc/host/cqhci.h         | 2 ++
 drivers/mmc/host/sdhci-msm.c     | 6 ++++--
 drivers/soc/qcom/ice.c           | 6 +++---
 drivers/ufs/core/ufshcd-crypto.c | 7 ++++---
 drivers/ufs/host/ufs-qcom.c      | 6 ++++--
 include/soc/qcom/ice.h           | 5 +++--
 include/ufs/ufshcd.h             | 1 +
 8 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/cqhci-crypto.c b/drivers/mmc/host/cqhci-crypto.c
index 6652982410ec..91da6de1d650 100644
--- a/drivers/mmc/host/cqhci-crypto.c
+++ b/drivers/mmc/host/cqhci-crypto.c
@@ -32,6 +32,7 @@ cqhci_host_from_crypto_profile(struct blk_crypto_profile *profile)
 }
 
 static int cqhci_crypto_program_key(struct cqhci_host *cq_host,
+				    const struct blk_crypto_key *bkey,
 				    const union cqhci_crypto_cfg_entry *cfg,
 				    int slot)
 {
@@ -39,7 +40,7 @@ static int cqhci_crypto_program_key(struct cqhci_host *cq_host,
 	int i;
 
 	if (cq_host->ops->program_key)
-		return cq_host->ops->program_key(cq_host, cfg, slot);
+		return cq_host->ops->program_key(cq_host, bkey, cfg, slot);
 
 	/* Clear CFGE */
 	cqhci_writel(cq_host, 0, slot_offset + 16 * sizeof(cfg->reg_val[0]));
@@ -99,7 +100,7 @@ static int cqhci_crypto_keyslot_program(struct blk_crypto_profile *profile,
 		memcpy(cfg.crypto_key, key->raw, key->size);
 	}
 
-	err = cqhci_crypto_program_key(cq_host, &cfg, slot);
+	err = cqhci_crypto_program_key(cq_host, key, &cfg, slot);
 
 	memzero_explicit(&cfg, sizeof(cfg));
 	return err;
@@ -113,7 +114,7 @@ static int cqhci_crypto_clear_keyslot(struct cqhci_host *cq_host, int slot)
 	 */
 	union cqhci_crypto_cfg_entry cfg = {};
 
-	return cqhci_crypto_program_key(cq_host, &cfg, slot);
+	return cqhci_crypto_program_key(cq_host, NULL, &cfg, slot);
 }
 
 static int cqhci_crypto_keyslot_evict(struct blk_crypto_profile *profile,
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index fab9d74445ba..06099fd32f23 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/wait.h>
 #include <linux/irqreturn.h>
+#include <linux/blk-crypto.h>
 #include <asm/io.h>
 
 /* registers */
@@ -291,6 +292,7 @@ struct cqhci_host_ops {
 	void (*post_disable)(struct mmc_host *mmc);
 #ifdef CONFIG_MMC_CRYPTO
 	int (*program_key)(struct cqhci_host *cq_host,
+			   const struct blk_crypto_key *bkey,
 			   const union cqhci_crypto_cfg_entry *cfg, int slot);
 #endif
 	void (*set_tran_desc)(struct cqhci_host *cq_host, u8 **desc,
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e00208535bd1..b8770524c008 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1859,6 +1859,7 @@ static __maybe_unused int sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
  * vendor-specific SCM calls for this; it doesn't support the standard way.
  */
 static int sdhci_msm_program_key(struct cqhci_host *cq_host,
+				 const struct blk_crypto_key *bkey,
 				 const union cqhci_crypto_cfg_entry *cfg,
 				 int slot)
 {
@@ -1866,6 +1867,7 @@ static int sdhci_msm_program_key(struct cqhci_host *cq_host,
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	union cqhci_crypto_cap_entry cap;
+	u8 ice_key_size;
 
 	/* Only AES-256-XTS has been tested so far. */
 	cap = cq_host->crypto_cap_array[cfg->crypto_cap_idx];
@@ -1873,11 +1875,11 @@ static int sdhci_msm_program_key(struct cqhci_host *cq_host,
 		cap.key_size != CQHCI_CRYPTO_KEY_SIZE_256)
 		return -EINVAL;
 
+	ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
 	if (cfg->config_enable & CQHCI_CRYPTO_CONFIGURATION_ENABLE)
 		return qcom_ice_program_key(msm_host->ice,
 					    QCOM_ICE_CRYPTO_ALG_AES_XTS,
-					    QCOM_ICE_CRYPTO_KEY_SIZE_256,
-					    cfg->crypto_key,
+					    ice_key_size, bkey,
 					    cfg->data_unit_size, slot);
 	else
 		return qcom_ice_evict_key(msm_host->ice, slot);
diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 50be7a9274a1..4393262a1bf2 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -164,8 +164,8 @@ EXPORT_SYMBOL_GPL(qcom_ice_suspend);
 
 int qcom_ice_program_key(struct qcom_ice *ice,
 			 u8 algorithm_id, u8 key_size,
-			 const u8 crypto_key[], u8 data_unit_size,
-			 int slot)
+			 const struct blk_crypto_key *bkey,
+			 u8 data_unit_size, int slot)
 {
 	struct device *dev = ice->dev;
 	union {
@@ -184,7 +184,7 @@ int qcom_ice_program_key(struct qcom_ice *ice,
 		return -EINVAL;
 	}
 
-	memcpy(key.bytes, crypto_key, AES_256_XTS_KEY_SIZE);
+	memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
 
 	/* The SCM call requires that the key words are encoded in big endian */
 	for (i = 0; i < ARRAY_SIZE(key.words); i++)
diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index 7d3a3e228db0..33083e0cad6e 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -18,6 +18,7 @@ static const struct ufs_crypto_alg_entry {
 };
 
 static int ufshcd_program_key(struct ufs_hba *hba,
+			      const struct blk_crypto_key *bkey,
 			      const union ufs_crypto_cfg_entry *cfg, int slot)
 {
 	int i;
@@ -27,7 +28,7 @@ static int ufshcd_program_key(struct ufs_hba *hba,
 	ufshcd_hold(hba);
 
 	if (hba->vops && hba->vops->program_key) {
-		err = hba->vops->program_key(hba, cfg, slot);
+		err = hba->vops->program_key(hba, bkey, cfg, slot);
 		goto out;
 	}
 
@@ -89,7 +90,7 @@ static int ufshcd_crypto_keyslot_program(struct blk_crypto_profile *profile,
 		memcpy(cfg.crypto_key, key->raw, key->size);
 	}
 
-	err = ufshcd_program_key(hba, &cfg, slot);
+	err = ufshcd_program_key(hba, key, &cfg, slot);
 
 	memzero_explicit(&cfg, sizeof(cfg));
 	return err;
@@ -107,7 +108,7 @@ static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
 	 */
 	union ufs_crypto_cfg_entry cfg = {};
 
-	return ufshcd_program_key(hba, &cfg, slot);
+	return ufshcd_program_key(hba, NULL, &cfg, slot);
 }
 
 /*
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index a5a0646bb80a..2f317a4c3edf 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -150,6 +150,7 @@ static inline int ufs_qcom_ice_suspend(struct ufs_qcom_host *host)
 }
 
 static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
+				    const struct blk_crypto_key *bkey,
 				    const union ufs_crypto_cfg_entry *cfg,
 				    int slot)
 {
@@ -157,6 +158,7 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
 	union ufs_crypto_cap_entry cap;
 	bool config_enable =
 		cfg->config_enable & UFS_CRYPTO_CONFIGURATION_ENABLE;
+	u8 ice_key_size;
 
 	/* Only AES-256-XTS has been tested so far. */
 	cap = hba->crypto_cap_array[cfg->crypto_cap_idx];
@@ -164,11 +166,11 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
 	    cap.key_size != UFS_CRYPTO_KEY_SIZE_256)
 		return -EOPNOTSUPP;
 
+	ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
 	if (config_enable)
 		return qcom_ice_program_key(host->ice,
 					    QCOM_ICE_CRYPTO_ALG_AES_XTS,
-					    QCOM_ICE_CRYPTO_KEY_SIZE_256,
-					    cfg->crypto_key,
+					    ice_key_size, bkey,
 					    cfg->data_unit_size, slot);
 	else
 		return qcom_ice_evict_key(host->ice, slot);
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index 5870a94599a2..9dd835dba2a7 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -7,6 +7,7 @@
 #define __QCOM_ICE_H__
 
 #include <linux/types.h>
+#include <linux/blk-crypto.h>
 
 struct qcom_ice;
 
@@ -30,8 +31,8 @@ int qcom_ice_resume(struct qcom_ice *ice);
 int qcom_ice_suspend(struct qcom_ice *ice);
 int qcom_ice_program_key(struct qcom_ice *ice,
 			 u8 algorithm_id, u8 key_size,
-			 const u8 crypto_key[], u8 data_unit_size,
-			 int slot);
+			 const struct blk_crypto_key *bkey,
+			 u8 data_unit_size, int slot);
 int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
 struct qcom_ice *of_qcom_ice_get(struct device *dev);
 #endif /* __QCOM_ICE_H__ */
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index a95282b9f743..331b1ed171da 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -370,6 +370,7 @@ struct ufs_hba_variant_ops {
 				struct devfreq_dev_profile *profile,
 				struct devfreq_simple_ondemand_data *data);
 	int	(*program_key)(struct ufs_hba *hba,
+			       const struct blk_crypto_key *bkey,
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	int	(*fill_crypto_prdt)(struct ufs_hba *hba,
 				    const struct bio_crypt_ctx *crypt_ctx,

-- 
2.43.0


