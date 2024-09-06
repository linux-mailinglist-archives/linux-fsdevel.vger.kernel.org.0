Return-Path: <linux-fsdevel+bounces-28865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B619B96FABB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 20:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D364D1C247A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338B1E8B71;
	Fri,  6 Sep 2024 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nnsOydt4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9661DC19A
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646062; cv=none; b=FpQtzjzEjoOwOUP30TIF/DYsZE5vw/W8GGyXbVpCJ15KZSuol6K6YdflnKFlOVbgywDu5jI98MJmlfb0fn/KMQBbOUtWwVgRn4ovFDIzqvSI8Ke8FwdHCFVIhCTuU8NR33UPJKPifc06i+6DheCtLKek4d1SZnUwkHEP/f7IIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646062; c=relaxed/simple;
	bh=F6WmlmmY0spovDRaA8lXEdueYHjzPGso8gVnqhP91BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SPSf5v+adZbOFaihtZ353QbxDlcjQOWL5Tp2y+SC91mlF9pOK1VKe1DGObNtBUQrbWOfQgQBEeNvmZKlhCSRHu5tdVqrqOMFzKXcJQj5/Yfl7jSS5+CWXNh8k0/3nys47d4qlVDg2lM2R0ZjPZHyD4MOqcbbL31i9GhBjrF4MIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nnsOydt4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c962e5adso1279103f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725646055; x=1726250855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK96uv9eKLDeTlIQhh/fKGLa/VFkoaksWn7FtY1AcZo=;
        b=nnsOydt4PedSAxsS7Cf+P1XNgWQAYih9devngILxGpPphCKeG4jFyGCJ5hXypXBeeW
         eFEx5+AJ//rSgmDedbncVCWGcW/ItdUg0LCjs+L+s3xLiUfcYKSnkg2EJrmgVfoWWutc
         RlDKCHkibmb1nZ0TJK00wP5gZfCHgAC2EZdkjDKRh+sZefW0kcb2sgU0QHRLFm7duYyY
         s7T4oYwnkPy3TXe9sf0jBzQjqogTB81Twf7nV3ulMAcIFfKjvzHCQ6RMqZaepx+TIp9K
         9Ur0Lq0whri8VQzQ2HEHyiXVmyRkjMSkDC5SSHd5bTWcdviiGiH5vgMMhySnCcTJ0Bxd
         YNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646055; x=1726250855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK96uv9eKLDeTlIQhh/fKGLa/VFkoaksWn7FtY1AcZo=;
        b=XrffDRebZ+SVgQx0In/KnN4pYqmyaxfeteZAd9af+ipU2hEjp426VkQIQHX0M7Og5f
         plC8Vtgcmsb6Nkmq/OvOi2tzWbAV3uafo2cnNuQSM8mxWzSEVeMIOank3i43RELAAZf8
         u6Hhk8UN8MEy/b8P42crQn2tY8fTzdmNghd3Ky7NtrWf14nLPbYYi1xeCcyjJquMYneJ
         WEQehido+Puyw+S9SF8H0okl/QhNRq3VGdzkgOQhAbATheFsa2YXogKpNxRV8nDst697
         /XHV6LX7lvNNAPzgwkbcgx7brir3+pyfj4mkxVFXwrQmi/KAPbx2PYbTBnjuQsMV/hkT
         o4sA==
X-Forwarded-Encrypted: i=1; AJvYcCWDcCKHNnXJhhHhfLX+INWay4iVlQq9zuSy8oQ7NcCGnLk3dnzc4UWXz02QLaBrNoE3zOETR+lG0IKyvkPP@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWfm67oxo+Ig4rImcUwZy/9OS1AYAc3OSuEtkevtFyixI3hAC
	b65mjstBY2Jq2yrliDumSsSQNGqghX6YdTP6PqcTK/pasDslrqRqHI4jAvV/3J8=
X-Google-Smtp-Source: AGHT+IFNnFi+iNZr/gLZxl0msjOlrxK1y6R8Gx064dfoAI0bn/k4Exq5m+nNN2sV79/mCjcSHI5GEg==
X-Received: by 2002:a05:6000:d1:b0:374:c1ea:2d40 with SMTP id ffacd0b85a97d-377998aaeabmr6581808f8f.1.1725646054981;
        Fri, 06 Sep 2024 11:07:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cac8543dbsm5880485e9.42.2024.09.06.11.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:07:34 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 06 Sep 2024 20:07:09 +0200
Subject: [PATCH v6 06/17] firmware: qcom: scm: add a call for deriving the
 software secret
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-wrapped-keys-v6-6-d59e61bc0cb4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4695;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=FTvRtL/RLwS4HkzjvjWqJX0Cg7SHXC+nIRJ4hA5E6bY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm20TXKV3SBl8MoJjzjyF/6RhXiZcRNVj6Tu8/o
 ohyiU56AW2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZttE1wAKCRARpy6gFHHX
 clcfEACAt2Xb6F3yrVLhXPP+1wTdV+USTlkefxmlqcXZSb9fRpZ6sWJ3TBVVunDtOA1elXXyVOJ
 1YVJOvicLWv8Ii2zS+vZ791XkMvTQvgLk1EIiVRNEKzvS/RnELAJPw3UFPancunms1RrPYDdx32
 5fbUEVfSS8uOlhYYJ5Bn0UK4w4KVXRoSN46f6QHp4MltvEJtd8MssJ6Qyuc6ToP/iM7JRFvH1M7
 PyJPnT1TAOQnhqoBF+b4wl3tMn2LkZqpW5NNwsuIkbnRLZhD+OcSHF+5acalQsDBoBRr0s0W/Hr
 R4NTR4I9PvAai5iu123uqXBSLIhe9fc0UEtnGv/1HkuohR+LnWzNUNdtrMjEvZwu8yijxycPLLg
 APGCOMgBwRL1pDhsGvV46VfOqe+1jmZaRcEhcXh1fMrvPpEX6dURBKYiZyn+biHNLpawssLF11C
 ZNqT3j3elCQ9ea8lUTmQVNGKUHbZPRUJiTqIkV9BsopeO3Ou2kWB7Dv/YWjEsu6NduPrLcaVH2r
 L+4yefaDnRulk9b5cSaEVV8IEb5XqU6hw5bN3dLKUjRjsQjUBOsA+oR5aAtpeZfwZLQat78MkB5
 9/acO/3y0gpO8zMZa19RGj/J0qrKm0cvncHARAvSNwFAtdh9EOQig6g4XjNd5YXqzzE80NqYKye
 vGV3fDl4qoe1vZg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Inline storage encryption may require deriving a software secret from
storage keys added to the kernel.

For raw keys, this can be directly done in the kernel as keys are not
encrypted in memory.

However, hardware wrapped keys can only be unwrapped by the HW wrapping
entity. In case of Qualcomm's wrapped key solution, this is done by the
Hardware Key Manager (HWKM) from Trustzone.

Add a new SCM call which provides a hook to the software secret crypto
profile API provided by the block layer.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c       | 65 ++++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |  1 +
 include/linux/firmware/qcom/qcom_scm.h |  2 ++
 3 files changed, 68 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 10986cb11ec0..ad3f9e9ed35d 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1252,6 +1252,71 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 }
 EXPORT_SYMBOL_GPL(qcom_scm_ice_set_key);
 
+/**
+ * qcom_scm_derive_sw_secret() - Derive software secret from wrapped key
+ * @wkey: the hardware wrapped key inaccessible to software
+ * @wkey_size: size of the wrapped key
+ * @sw_secret: the secret to be derived which is exactly the secret size
+ * @sw_secret_size: size of the sw_secret
+ *
+ * Derive a software secret from a hardware wrapped key for software crypto
+ * operations.
+ * For wrapped keys, the key needs to be unwrapped, in order to derive a
+ * software secret, which can be done in the hardware from a secure execution
+ * environment.
+ *
+ * For more information on sw secret, please refer to "Hardware-wrapped keys"
+ * section of Documentation/block/inline-encryption.rst.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
+			      u8 *sw_secret, size_t sw_secret_size)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_ES,
+		.cmd =  QCOM_SCM_ES_DERIVE_SW_SECRET,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RW,
+					 QCOM_SCM_VAL, QCOM_SCM_RW,
+					 QCOM_SCM_VAL),
+		.args[1] = wkey_size,
+		.args[3] = sw_secret_size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	int ret;
+
+	void *wkey_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							    wkey_size,
+							    GFP_KERNEL);
+	if (!wkey_buf)
+		return -ENOMEM;
+
+	void *secret_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       sw_secret_size,
+							       GFP_KERNEL);
+	if (!secret_buf) {
+		ret = -ENOMEM;
+		goto out_free_wrapped;
+	}
+
+	memcpy(wkey_buf, wkey, wkey_size);
+	desc.args[0] = qcom_tzmem_to_phys(wkey_buf);
+	desc.args[2] = qcom_tzmem_to_phys(secret_buf);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (!ret)
+		memcpy(sw_secret, secret_buf, sw_secret_size);
+
+	memzero_explicit(secret_buf, sw_secret_size);
+
+out_free_wrapped:
+	memzero_explicit(wkey_buf, wkey_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_derive_sw_secret);
+
 /**
  * qcom_scm_hdcp_available() - Check if secure environment supports HDCP.
  *
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 685b8f59e7a6..5a98b90ece32 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -127,6 +127,7 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
 #define QCOM_SCM_SVC_ES			0x10	/* Enterprise Security */
 #define QCOM_SCM_ES_INVALIDATE_ICE_KEY	0x03
 #define QCOM_SCM_ES_CONFIG_SET_ICE_KEY	0x04
+#define QCOM_SCM_ES_DERIVE_SW_SECRET	0x07
 
 #define QCOM_SCM_SVC_HDCP		0x11
 #define QCOM_SCM_HDCP_INVOKE		0x01
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 9f14976399ab..0ef4415e2023 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -103,6 +103,8 @@ bool qcom_scm_ice_available(void);
 int qcom_scm_ice_invalidate_key(u32 index);
 int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 			 enum qcom_scm_ice_cipher cipher, u32 data_unit_size);
+int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
+			      u8 *sw_secret, size_t sw_secret_size);
 
 bool qcom_scm_hdcp_available(void);
 int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);

-- 
2.43.0


