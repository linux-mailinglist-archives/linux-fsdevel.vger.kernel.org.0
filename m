Return-Path: <linux-fsdevel+bounces-36243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A28F9E016C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 13:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2CF28105A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7CA205E36;
	Mon,  2 Dec 2024 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0vDN1SuR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051F2040B6
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140976; cv=none; b=iNIIm2aLnTHAYDFr+isST62CQSrqEB2d/UM32da3TqHtp9BW2Er0ic8Sqa5V5hKBKtETNhv6cinWlKTey5uJw7kZ/SKxOQ++Tsq1B9L5WucP1qLBQQ1xCL5hM1ivrEcRLeCc6ycT1T1dLz2Eh5efNMHUSYj2o5P7+bhNmblJsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140976; c=relaxed/simple;
	bh=ROTvJ0Yd+ruiUat4sX5vxOMtnWR7c6X2Q7M75jA57vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mzVirRAQ/s8Imh6j5ALjfFu9SHbMUMnSbVv/chuOAC6NUNnzXnkmvr9M8QzUHLAcvpXPFDAUckskIF5TCNJhlYO663GFAQfc97q+LsLtkBx+z1+hMr5d0YePBq/Tao2vG7FijrVa5i187171JH1z2zQQgy2prAzf1lHHU0xVh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0vDN1SuR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43494a20379so33534665e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 04:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733140971; x=1733745771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEsGyUMJRC5EIXHWCuaafkTJXMkTib5fTjMr637WgyE=;
        b=0vDN1SuRUYT/6wqqFm9lr4Q7khtq+BxyslvI7Q5lCxuRbDMMtwsOIRhJE5d0UzDrSX
         Y+DaPbI5LCHgbaQK2DBP/PO3lFiwCL0FA6JwlCRMhZF7+g4MJy4z+v2/cC6cgITP11R1
         xkkWufEdSjuX4bB+dGMI1V9LR2IFMctTJ9TcvihDEisV6HJYqdYk4VLcufdtjttwwcxV
         KbYpXFY3n+Bgki12SFLdju/hdMJ5I9APqGGB5lJwmfQU0q5ut1z+NgEGa/y/aDq55HYx
         6Myf+2WDQNmqATz9jWb21qSCJSDFXH7JPYRx2mtVk9rOY7WT6jVWANZci/9LfR9t1FoQ
         eltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140971; x=1733745771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEsGyUMJRC5EIXHWCuaafkTJXMkTib5fTjMr637WgyE=;
        b=P8E5CvUSQkWPQa8KKrsQg+dKr2uoeYEO5eXcHf1GPRCwd0cAxKHmOvEe0jipsNUxvS
         jEpVq3spm+hc+qMYVvSEQBL/F2c+FGC87jqhdPxmUsAwlUa+bfoKcERbufxZWotYmlIA
         4ZCJO33yEqUcFaSasH1ZlmPQi7FF5OXdbAqsAvyDTXjBlRu1iDhq8lnVry0hKmElgKS0
         u/zU9UuABTsZhVnYpbmbNm3+s8jihvk4ARjhDdpjFoeSXEzjvMiYBII4BMvkIkVU4M9A
         rpaKA9t7LAJfVIvy0e5S7AS+eGG4BjJ+o64Bo18SSGfi19lvyOwjtRkm48vTFWB9cKBp
         irIA==
X-Forwarded-Encrypted: i=1; AJvYcCX5uMZfqL1fV4OJg4qsEDbYQcN2oLCZdFF/ZkHIzjY/y819KqWucQ0vLcawUKIzQhe2qwpmR323No8VAR1+@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPtmPCc2tuWjELrVq/F4EXwb5qoXa3PXIWbmYOUmdVe+HedI+
	Ro5WjRQyijHRxCvdykriJnQ3mTpwMbcChxQPDC6fqfEGfsJhOX01hNFGNEB+2GI=
X-Gm-Gg: ASbGncvR7l21EQg6gYmLUp+3jGdil8MguaIKrZnxiqs8sNpiFDm/iZgW6OfxO6jNrQp
	c5GZpKTLJsAcpP5QEESHpivWY7JD+DgDAc+VnAV7r2Zjr1C4KAqTOvytbVw53lDmpRhkvMo/dag
	WAeoMoziojGntZuOOY5HZU5+5s464llb2VpAUCiqmzB736ygxAqNlEcGTOkJKM7zESx7RFPj8LX
	Srln4Uw4pY8MkEExqRb8nkvuuj4xI/MjSyl5f++
X-Google-Smtp-Source: AGHT+IGGvCQ+UQ3Gz+sFnJwX+0j17r5lPzFWBw9hCLQAKsSSM8aNBNxk7Vxt475KPIwUN1cEjvQLSw==
X-Received: by 2002:a05:600c:3585:b0:42f:7e87:3438 with SMTP id 5b1f17b1804b1-434a9d4ff94mr219950105e9.0.1733140968936;
        Mon, 02 Dec 2024 04:02:48 -0800 (PST)
Received: from [127.0.1.1] ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm152396095e9.8.2024.12.02.04.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:02:48 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 02 Dec 2024 13:02:23 +0100
Subject: [PATCH RESEND v7 07/17] firmware: qcom: scm: add calls for
 creating, preparing and importing keys
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-wrapped-keys-v7-7-67c3ca3f3282@linaro.org>
References: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>
In-Reply-To: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Asutosh Das <quic_asutoshd@quicinc.com>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8105;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=iHvq6iDlNKonVx5gQ2c2tHZaOwqk7ZK6GmSQUyzlGxM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTaHTkbQUmO8rR7TlwBjsVv+pAdkGOHURn8Kyt
 gn2lFrWAHOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ02h0wAKCRARpy6gFHHX
 cv2ED/0Y74IPZuyaqMDggcPamep1hRbZ1e70ccf4F82LpeyvNGtwjWIe9bOUOccNNXGFAazQNRO
 M0v9u036osn6tsRIuqpFSQ1jFnb/FUVLSxcp2lI4Q83qOsGzXH8SycN4U7aPKdIRVw9A36+vCm6
 m/0+L7Xu91Shq77pEHIHuqjdBAEYyt/iMxQMCvHQfinj9Kw/yVNx+ZNkhVqjKojQiGUXvhldqI9
 Wt8qZg5tdAC6Hfz71Xbq5dWHgZBwUCOBJN6czCD/f9rsfTvtz1EaO29i7FccOvp+X6z1o3wiD58
 HodAlcrC+LfVtACsONNQUz30/wucJbEojQ6Rk8FnnXqXivERxYoKsk7VIj/+lNdmiqaLc0P4buR
 +/rKL60YvGEI9bCazu9q0BFOyjV4djbtFIFU+W0DXJ0DcMcOgurOMDtr63y+UpqN5eAr1MdzNMX
 gNsErL29RkWSQV/bcLe2XashBE6PXe6beD8qxmYJYvoW+v0+zpw2L8/O8y6mhid52NOL21ZH1hI
 aJj1Cvdy2qEdjA19/hVIeX03xQ1Fjh+NiEgLfUPh3pJ6gTVTlqiEzQQ/4TfuXws+jz5MFnF+i3y
 arj+MFPRnZi3wmb+Cz9TxMn6XEH0uTV2MeV2+hpU25jjZ0HrAsp4/+LvOQfah2FHQkIuWY+SA+Q
 Dm+y3KAcj6z029Q==
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

[Bartosz:
  improve kerneldocs,
  fix hex values coding style,
  rewrite commit message]

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c       | 161 +++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |   3 +
 include/linux/firmware/qcom/qcom_scm.h |   5 +
 3 files changed, 169 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index d523ce671997e..14ba2c798f4d7 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1344,6 +1344,167 @@ int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
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
index 55547ed27edd9..097369d38b84e 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -129,6 +129,9 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
 #define QCOM_SCM_ES_INVALIDATE_ICE_KEY	0x03
 #define QCOM_SCM_ES_CONFIG_SET_ICE_KEY	0x04
 #define QCOM_SCM_ES_DERIVE_SW_SECRET	0x07
+#define QCOM_SCM_ES_GENERATE_ICE_KEY	0x08
+#define QCOM_SCM_ES_PREPARE_ICE_KEY	0x09
+#define QCOM_SCM_ES_IMPORT_ICE_KEY	0x0a
 
 #define QCOM_SCM_SVC_HDCP		0x11
 #define QCOM_SCM_HDCP_INVOKE		0x01
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index b843678bc3ee4..9a585c1af959d 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -107,6 +107,11 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
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
2.45.2


