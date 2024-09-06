Return-Path: <linux-fsdevel+bounces-28866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CA096FAC1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 20:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1071F26392
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 18:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FA01D88A5;
	Fri,  6 Sep 2024 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YMw8NPoK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D431D79AD
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646062; cv=none; b=Hcwqsed2ahqqkD/eNNs/FP0ihjxOSXDQOLmmS76qkW97vmh2tFE9RIy03KqlvIYoEFnLbQin+XvMu1B1zgjxMF1Qhc1Aik705VVYw9czHjKxLwiS5gqIgqmfZS+1JrKi7aH9YRN2MfUzem56Ov6QKcUhDelE3ihi8BMFaTzR9ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646062; c=relaxed/simple;
	bh=JVdVrx0FnUTyRnq+hiu1CZ+DyKk5ObLwZC5htzeydyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLp4nnQdJ1kG+VRpqV3skU+g8cT6KSw5B9fU/FR0Uj7cTCc0Hf1zk8O/KCkVzmd95ctIYexHwh5iSHg37N9Qe9corGY1PTMP0UllJp0PuVFyXIU7bQWlE0/ITEbOvT8RlrjZJFwIDn5jJ0HmuDByywB8YkEk3QfH1zQxsU/+DXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YMw8NPoK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42c828c8863so18796225e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725646057; x=1726250857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpVWTUUDAOZK9LGZBVwykwMkpObCR6Xfwl9xNzH9Khg=;
        b=YMw8NPoK0Fudzs7Rp+4duU12QPCYHlng9g6CCvRtvD+pj29LUm2kxLoYcxtHaKMPW2
         s/JcMLXMXwPrTtpjXZKGzWub6yz2AwG71rJpKoWAx6eHHAiVjN5n2O55O4iZ8aNl64fH
         h6MiYd2r/DQSzhSiAxze3HQ+yjRyNZVpdc9OZMHcSyiLauXJDoNyG/BCEMuw56DZiIe2
         SzU/41zCQMMEJ8nqIGJu28kpfeyl8BwyUN6Hlkj6nJ51DONFPvC1g3/kG+J/rP2jmMiN
         NJwuIttgg7Uzx8I4HKXGWRXTz5aQt1n5aRGjX82zNJpb1c5SOeIFACQBCdWtp7SpMVaB
         FXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646057; x=1726250857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpVWTUUDAOZK9LGZBVwykwMkpObCR6Xfwl9xNzH9Khg=;
        b=iMfxyhMHC1Bulxw2zyFHqgpHtinl6jRVUhZKglt929L6gI5Mph2BUliHW+LTXuysHN
         qjLrEQG/1hv5YYjuRtHoXVtbLrikNBxz5NXEpuyyHROOTyVLYJBUE06tJqhd/B+ZXojK
         8HANYRtkzo017rwuAa46y189nj5VQU4zYjtwcUYP+5LtMjxnIr1Z1So7elhggjbPE4vD
         nq/+B5EwI83Q6N+iUclFIc4GfLUV6eObDt5gw7GaTsqKswpgdgAkxFWzC7ecnxll6DWP
         gcj74CB8RN4wI2coZuzM52LLG3tuPlvibS/d950BQa+8/h7Qra95riTcvuqSJKvC3enP
         CWqw==
X-Forwarded-Encrypted: i=1; AJvYcCWjHhOaai97cJN9aBPW3k+QnGgxwMBg6okTKPH8+Z9X7jGuIPndchBoNJ42w6xHsgLOqmgAgvGlAh1qrkhA@vger.kernel.org
X-Gm-Message-State: AOJu0YxIwihBFTTsAwI6vrmBpcj7eBVGaxiotPY940F0oUoKazfBHFnU
	XQd35BNu6w5I3Pzjp5OtKntsUFo1bTPGMJvWcHz3u9yFMLnDHhn7G/UkZ3fCHVc=
X-Google-Smtp-Source: AGHT+IE4D13SKaKrjgK+zWJUNMvo2+61hmlHrbSD9XLo0k1kFCAF0E/9HCVWnw+8+kL4xTuwdegUhQ==
X-Received: by 2002:a05:600c:190f:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-42c9f98a7eamr25758165e9.19.1725646056769;
        Fri, 06 Sep 2024 11:07:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cac8543dbsm5880485e9.42.2024.09.06.11.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:07:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 06 Sep 2024 20:07:10 +0200
Subject: [PATCH v6 07/17] firmware: qcom: scm: add calls for creating,
 preparing and importing keys
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-wrapped-keys-v6-7-d59e61bc0cb4@linaro.org>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
In-Reply-To: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8044;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=tjTi3NnBcjQt/ZMB4Kr+h5doMimC8w9rg6A7//9M0ag=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm20TXck6cmAV0sLH8p2Pc2IA4d0hnYB8Z6cxYy
 PNekODCXq6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZttE1wAKCRARpy6gFHHX
 crWoD/4x0eVwL6CDs4Ge92SC9Y/BXErNbQedHzI5AummqQ7tA6IyJmL7rJQKHnhgbMje6jhX8hu
 4BUOVLlKr5NhaAnbJNxLjCO5JuP7uRvczkPYkniMNjXM9lB3DqoP7s3gMvOlCOLcnaHFa+1rLKt
 L9X6DnxK5rAXQMkbzU46Pyr1Gqx/5sowPI1mbtEfKS+LPHm1nEflTAvlae7N76j9Mot1E+uyI+S
 fwtSJL4aly1GrDch9rnXjRW7Q6b2rlnMbe3WiQIIiGsgFXo1r0F8WqJHMF5DiYmd6Cy7gSOg3vA
 /An+tR0wJL0JNxMKLCqTFEBkqJTL+HsU6e6D0JOvFV83+1eygQVqUoYsbUJgCkov6H6ZAnlkSTK
 QgHcbQcbBySmLLLU7DDaGubK8hw8vRM51LNVD4prD52s6u4HZPmbFdQSOYnYhk0lyY2mycyjFEi
 W6L/5O3rmWe/KcKFvnbfMOBbBm9QNG2PPyI/e1IzK+u7Epko6W0mz03yUBghxe+Gj+fIbsUueBG
 eKRugUbW5apg/NBHWEkZsJwkvq9OoLpn4sOCv9xWBFoEDkU5YBVUmNu0PEO7+4wFlIZAlhjCXdw
 0Yz7HN7C9BygdfQqCpctxpChR99/RGzEG7+jvU3Y6pfNvn2IiW/vsj17apOJsSpOyTUvPyT3KM2
 0kESGLd6r+zXf7A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Storage encryption has two IOCTLs for creating, importing and preparing
keys for encryption. For wrapped keys, these IOCTLs need to interface
with Qualcomm's Trustzone. Add the following keys:

generate_key:
  This is used to generate and return a longterm wrapped key. Trustzone
  achieves this by generating a key and then wrapping it using the
  Hawrdware Key Manager (HWKM), returning a wrapped keyblob.

import_key:
  The functionality is similar to generate, but here: a raw key is
  imported into the HWKM and a longterm wrapped keyblob is returned.

prepare_key:
  The longterm wrapped key from the import or generate calls is made
  further secure by rewrapping it with a per-boot, ephemeral wrapped key
  before installing it in the kernel for programming into ICE.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
[Bartosz:
  improve kerneldocs,
  fix hex values coding style,
  rewrite commit message]
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c       | 161 +++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |   3 +
 include/linux/firmware/qcom/qcom_scm.h |   5 +
 3 files changed, 169 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index ad3f9e9ed35d..27d8cb481ed7 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1317,6 +1317,167 @@ int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
 }
 EXPORT_SYMBOL_GPL(qcom_scm_derive_sw_secret);
 
+/**
+ * qcom_scm_generate_ice_key() - Generate a wrapped key for encryption.
+ * @lt_key: the wrapped key returned after key generation
+ * @lt_key_size: size of the wrapped key to be returned.
+ *
+ * Generate a key using the built-in HW module in the SoC. Wrap the key using
+ * the platform-specific Key Encryption Key and return to the caller.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int qcom_scm_generate_ice_key(u8 *lt_key, size_t lt_key_size)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_ES,
+		.cmd =  QCOM_SCM_ES_GENERATE_ICE_KEY,
+		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
+		.args[1] = lt_key_size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	int ret;
+
+	void *lt_key_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       lt_key_size,
+							       GFP_KERNEL);
+	if (!lt_key_buf)
+		return -ENOMEM;
+
+	desc.args[0] = qcom_tzmem_to_phys(lt_key_buf);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (!ret)
+		memcpy(lt_key, lt_key_buf, lt_key_size);
+
+	memzero_explicit(lt_key_buf, lt_key_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_generate_ice_key);
+
+/**
+ * qcom_scm_prepare_ice_key() - Get the per-boot ephemeral wrapped key
+ * @lt_key: the longterm wrapped key
+ * @lt_key_size: size of the wrapped key
+ * @eph_key: ephemeral wrapped key to be returned
+ * @eph_key_size: size of the ephemeral wrapped key
+ *
+ * Qualcomm wrapped keys (longterm keys) are rewrapped with a per-boot
+ * ephemeral key for added protection. These are ephemeral in nature as
+ * they are valid only for that boot.
+ *
+ * Retrieve the key wrapped with the per-boot ephemeral key and return it to
+ * the caller.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int qcom_scm_prepare_ice_key(const u8 *lt_key, size_t lt_key_size,
+			     u8 *eph_key, size_t eph_key_size)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_ES,
+		.cmd =  QCOM_SCM_ES_PREPARE_ICE_KEY,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RO,
+					 QCOM_SCM_VAL, QCOM_SCM_RW,
+					 QCOM_SCM_VAL),
+		.args[1] = lt_key_size,
+		.args[3] = eph_key_size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	int ret;
+
+	void *lt_key_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       lt_key_size,
+							       GFP_KERNEL);
+	if (!lt_key_buf)
+		return -ENOMEM;
+
+	void *eph_key_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+								eph_key_size,
+								GFP_KERNEL);
+	if (!eph_key_buf) {
+		ret = -ENOMEM;
+		goto out_free_longterm;
+	}
+
+	memcpy(lt_key_buf, lt_key, lt_key_size);
+	desc.args[0] = qcom_tzmem_to_phys(lt_key_buf);
+	desc.args[2] = qcom_tzmem_to_phys(eph_key_buf);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (!ret)
+		memcpy(eph_key, eph_key_buf, eph_key_size);
+
+	memzero_explicit(eph_key_buf, eph_key_size);
+
+out_free_longterm:
+	memzero_explicit(lt_key_buf, lt_key_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_prepare_ice_key);
+
+/**
+ * qcom_scm_import_ice_key() - Import a wrapped key for encryption
+ * @imp_key: the raw key that is imported
+ * @imp_key_size: size of the key to be imported
+ * @lt_key: the wrapped key to be returned
+ * @lt_key_size: size of the wrapped key
+ *
+ * Import a raw key and return a long-term wrapped key to the caller.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int qcom_scm_import_ice_key(const u8 *imp_key, size_t imp_key_size,
+			    u8 *lt_key, size_t lt_key_size)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_ES,
+		.cmd =  QCOM_SCM_ES_IMPORT_ICE_KEY,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RO,
+					 QCOM_SCM_VAL, QCOM_SCM_RW,
+					 QCOM_SCM_VAL),
+		.args[1] = imp_key_size,
+		.args[3] = lt_key_size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	int ret;
+
+	void *imp_key_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+								imp_key_size,
+								GFP_KERNEL);
+	if (!imp_key_buf)
+		return -ENOMEM;
+
+	void *lt_key_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       lt_key_size,
+							       GFP_KERNEL);
+	if (!lt_key_buf) {
+		ret = -ENOMEM;
+		goto out_free_longterm;
+	}
+
+	memcpy(imp_key_buf, imp_key, imp_key_size);
+	desc.args[0] = qcom_tzmem_to_phys(imp_key_buf);
+	desc.args[2] = qcom_tzmem_to_phys(lt_key_buf);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (!ret)
+		memcpy(lt_key, lt_key_buf, lt_key_size);
+
+	memzero_explicit(lt_key_buf, lt_key_size);
+
+out_free_longterm:
+	memzero_explicit(imp_key_buf, imp_key_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_import_ice_key);
+
 /**
  * qcom_scm_hdcp_available() - Check if secure environment supports HDCP.
  *
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 5a98b90ece32..85f46ae7bd37 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -128,6 +128,9 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
 #define QCOM_SCM_ES_INVALIDATE_ICE_KEY	0x03
 #define QCOM_SCM_ES_CONFIG_SET_ICE_KEY	0x04
 #define QCOM_SCM_ES_DERIVE_SW_SECRET	0x07
+#define QCOM_SCM_ES_GENERATE_ICE_KEY	0x08
+#define QCOM_SCM_ES_PREPARE_ICE_KEY	0x09
+#define QCOM_SCM_ES_IMPORT_ICE_KEY	0x0a
 
 #define QCOM_SCM_SVC_HDCP		0x11
 #define QCOM_SCM_HDCP_INVOKE		0x01
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 0ef4415e2023..b5ab39b35490 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -105,6 +105,11 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 			 enum qcom_scm_ice_cipher cipher, u32 data_unit_size);
 int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
 			      u8 *sw_secret, size_t sw_secret_size);
+int qcom_scm_generate_ice_key(u8 *lt_key, size_t lt_key_size);
+int qcom_scm_prepare_ice_key(const u8 *lt_key, size_t lt_key_size,
+			     u8 *eph_key, size_t eph_size);
+int qcom_scm_import_ice_key(const u8 *imp_key, size_t imp_size,
+			    u8 *lt_key, size_t lt_key_size);
 
 bool qcom_scm_hdcp_available(void);
 int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);

-- 
2.43.0


