Return-Path: <linux-fsdevel+bounces-31764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC5B99AC0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 20:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04DD1F26193
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832491EABCC;
	Fri, 11 Oct 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YGEPzfb9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A21D0F59
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672892; cv=none; b=HWi/RAZ3G+inMRVX0T8S9hFHi0NKLA9VDdtnpW1tY52FNfZMPTrv/y7BFy/YN0rJNv/2m9lRxL3mBR4bXntdCBzYEMO+sIAAGyr9cab7jbuGI0SuHFpJoitHl4XSHUIyU4Yf+2h8QwH2VII0YRSbw3fuBzv0KZrceJuxO1v2uxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672892; c=relaxed/simple;
	bh=wC7lUFFVw6i5pD4m+S44Bapqg7NrEsGMwXCT+lkMbUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=owmASgFIUwkxVepii4jeNKF/dVTPdA85bcFrrlhE3Xvt9gG5wqCLd+TLlAw7PJD1RabbFIO4XGEY8ueYueFVHYLa44X8e8e3+EuZhGYtGZcnJ4Nqe70+mvMXFNFgouZY+cEP5ohpcoshTBD9fR3Ha10Ax0oflHUdWgm+fmeOnlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YGEPzfb9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d5689eea8so544836f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 11:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672884; x=1729277684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0u8mjP/FvHaKnOr2WniRzKdKpxXEx+zf1lsmESkVxDw=;
        b=YGEPzfb9Tnbrg+OnL61Y8+pFtI53CBtgjO869Ygy42ovTHo8BnDbVgxgmL9pHp761m
         yhymxVsT4KnUrVu8x9htwH5rFHM5dsr7VOZVDIm7xCX4aQUfhj+gKmWnEZyIs6DQ3zNf
         4o4/HaVMtLVbaKNnV3WLnPSyWYgd+0RZCg47+65TF1ilUqLuxow6xbWv3H2WqxBVK9aD
         kzlmG2foeI4kZvJwBQ/pIlx+TX6Lif10F/flnnwl/R8y2VjmoX67iCZqwm7C+HjewS0Z
         9JoertEcop2jDjr64Cwa67ENQKsIyViyVWaqutpUKI8cWwJgHIohfSFS8dV8o1uCvZ2x
         4/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672884; x=1729277684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0u8mjP/FvHaKnOr2WniRzKdKpxXEx+zf1lsmESkVxDw=;
        b=sn9+/V7oNjoG6Ebw9not4DjKELp7JRorNYeuCFxmvppDZddi5tB70Am/RhNwomr6L9
         gVggfw4tmuM7qLObapm/sF90PVrudctVibby+duw9Uyvz81QbI0nw8wtRKN7nlGP1Wyo
         uG79KRuhEd3hsF9I89AkCAhgYqCYcuJrJt4DvuuvLKpcXJXo86LxblNqsXvceqp9YVLP
         1PJpEooCFdyn3v8op1Ga2t9kAcyx1VtLRG7pk7tQmEpG6aEyCFmDoPUEafoVXhXwSexy
         NJ+rjYcEZij45trAAegHX+UfhT7PiuU3kzz9Aa8g6gUYniup8Tm7EuZgt9k/CZRJrVeb
         VKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1NGPV5lSx/bKKAAKyCGAP99ZJ02cOLlkgF9/+OcRL/VaAiYpGBj9OMjieUf6eX00lBmXakhT9WjVr7T2O@vger.kernel.org
X-Gm-Message-State: AOJu0YwcsM3qo+4wfP/006ShuKlDoPo1aDEu37/OGKnBccqCQYRMrpnP
	qLxdzfufDwBI3FAKz1dyAGGqiyrJaUPM8H22GO8dEM2kcAo0u1BsHVSl741ddcY=
X-Google-Smtp-Source: AGHT+IH1ZEZ/7K1RL6NY3hRr68OPCF3nlykrOE/eyidOTtcz9XwgxBg0jO7R0QDlGgGMcJojiSg1tw==
X-Received: by 2002:adf:e9c1:0:b0:37d:5130:b384 with SMTP id ffacd0b85a97d-37d5521143amr2528447f8f.35.1728672884142;
        Fri, 11 Oct 2024 11:54:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:10 +0200
Subject: [PATCH v7 11/17] soc: qcom: ice: add support for generating,
 importing and preparing keys
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-11-e3f7a752059b@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4965;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ciruhrjlh43fjK+ND3M17yWqfZ0RTp7EaHfWHpnTh4g=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRfTqx4BdYELiNNpk1Zlh7wjQu+Wrzp1cHlF
 FyLhzMDA7mJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0XwAKCRARpy6gFHHX
 cpvgD/42p0nolBK1V0X0jLdCrdlmMtp2er/38UpoIJPyhuqztIwKVH/bOGYN3R5cKCvZ7+pqoBr
 oxnrDf0ZlrdtlljIFfOTYW4DZAYAdoDaBvAED9IUaHqnGRjRL2SGcGSAVdP19lFkLJcxljKbCyn
 lvyn92kuwmcjbjV5jdGiKktsoVfOUAgu2aJJlrnk6LvLZZtvV/tq0PxSAKliBsy8/Wvm29nmmGP
 AkUqWDSl+WHvnpRSEl64YxrVQquxubPSvpg6tEUhTJi5+ZlzLbEhoK7ZyjmlYqar6qH8ZEAd8hK
 /8pDAEycE6z8uG60Z/B4qV/2xNyvbN65GdTxIOgqpv2/FQHT2bG2OYhiorAstaRhDOgDLCMjdX+
 nvV2jLmVIAU/0QORbLDyn87nMpNNuXY8seDbx98/vChyzEIHetKvWVPzjV/z8gk8ftqHCy2M8iW
 r2FiygcP/emRWac0gmJlQ89O7oIHtMiv0jMH5s1dkAsQi0xvtngZm8+QORzQmOTuPVnU0GXsQGD
 SAhSE43ST2H0TZfA/kGSygDSZNv+sNl1pukX4pgoht0VtzBrhXS+rjRjqZom5AV8A5quaZ7qeXr
 A34iFwYuKg/QDDIwexIWkmhgQgDNc3IjY2z9RkKhtDrZjtmtRbpXhn3buTNEq/biSl0B3A4FJd/
 y+2q/gG9R33MNhA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

With the new SCM calls that interface with TrustZone and allow us to use
the Hardware Key Manager functionality, we can now add support for
hardware wrapped keys to the Qualcomm ICE SoC driver.

Upcoming patches will connect that layer with the block layer ioctls.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/soc/qcom/ice.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/ice.h |  8 +++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 1f22453ab332..56270f41a7cb 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -22,6 +22,13 @@
 
 #define AES_256_XTS_KEY_SIZE			64
 
+/*
+ * Wrapped key sizes that HWKM expects and manages is different for different
+ * versions of the hardware.
+ */
+#define QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(v)	\
+	((v) == 1 ? 68 : 100)
+
 /* QCOM ICE registers */
 #define QCOM_ICE_REG_VERSION			0x0008
 #define QCOM_ICE_REG_FUSE_SETTING		0x0010
@@ -455,6 +462,80 @@ int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
 }
 EXPORT_SYMBOL_GPL(qcom_ice_derive_sw_secret);
 
+/**
+ * qcom_ice_generate_key() - Generate a wrapped key for inline encryption
+ * @ice: ICE driver data
+ * @lt_key: long-term wrapped key to be generated, which is
+ *          BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in size.
+ *
+ * Make a scm call into trustzone to generate a wrapped key for storage
+ * encryption using hwkm.
+ *
+ * Returns: 0 on success, -errno on failure.
+ */
+int qcom_ice_generate_key(struct qcom_ice *ice,
+			  u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	size_t wk_size = QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version);
+
+	if (!qcom_scm_generate_ice_key(lt_key, wk_size))
+		return wk_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_generate_key);
+
+/**
+ * qcom_ice_prepare_key() - Prepare a long-term wrapped key for inline encryption
+ * @ice: ICE driver data
+ * @lt_key: longterm wrapped key that was generated or imported.
+ * @lt_key_size: size of the longterm wrapped_key
+ * @eph_key: wrapped key returned which has been wrapped with a per-boot ephemeral key,
+ *           size of which is BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in size.
+ *
+ * Make a scm call into trustzone to prepare a wrapped key for storage
+ * encryption by rewrapping the longterm wrapped key with a per boot ephemeral
+ * key using hwkm.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int qcom_ice_prepare_key(struct qcom_ice *ice, const u8 *lt_key, size_t lt_key_size,
+			 u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	size_t wk_size = QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version);
+
+	if (!qcom_scm_prepare_ice_key(lt_key, lt_key_size, eph_key, wk_size))
+		return wk_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_prepare_key);
+
+/**
+ * qcom_ice_import_key() - Import a raw key for inline encryption
+ * ice: ICE driver data
+ * @imp_key: raw key that has to be imported
+ * @imp_key_size: size of the imported key
+ * @lt_key: longterm wrapped key that is imported, which is
+ *          BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in size.
+ *
+ * Make a scm call into trustzone to import a raw key for storage encryption
+ * and generate a longterm wrapped key using hwkm.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int qcom_ice_import_key(struct qcom_ice *ice, const u8 *imp_key, size_t imp_key_size,
+			u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	size_t wk_size = QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version);
+
+	if (!qcom_scm_import_ice_key(imp_key, imp_key_size, lt_key, wk_size))
+		return wk_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_import_key);
+
 static struct qcom_ice *qcom_ice_create(struct device *dev,
 					void __iomem *base)
 {
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index dabe0d3a1fd0..dcf277d196ff 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -39,5 +39,13 @@ bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
 int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
 			      unsigned int wkey_size,
 			      u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
+int qcom_ice_generate_key(struct qcom_ice *ice,
+			  u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+int qcom_ice_prepare_key(struct qcom_ice *ice,
+			 const u8 *lt_key, size_t lt_key_size,
+			 u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+int qcom_ice_import_key(struct qcom_ice *ice,
+			const u8 *imp_key, size_t imp_key_size,
+			u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
 struct qcom_ice *of_qcom_ice_get(struct device *dev);
 #endif /* __QCOM_ICE_H__ */

-- 
2.43.0


