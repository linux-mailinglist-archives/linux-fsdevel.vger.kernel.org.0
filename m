Return-Path: <linux-fsdevel+bounces-31762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB4C99AC15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A157CB24D93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 19:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7315B1D0BAC;
	Fri, 11 Oct 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FuVVJ4gn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEDB1D0DE2
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672890; cv=none; b=Rugve5B6tksomy+dwsTCC0c4BI3tAqNPfUby0OtX1IM1eoO3HRPa7dep8CrkgcXEo1g0hXp2kN0ikkrAsckfXfKr/aofEToL4BewF6g5DQuQcPtJqFsFSe+AfjgBPphDVah5hdC8nW29Jt0fGMcn5xAOQ0jVPkMngwg7FeNnt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672890; c=relaxed/simple;
	bh=NTpnGYJWRKUfD2+EdtJmRcavDBWB/vbpL4lKlrJIiuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mtEGICREGthUpDlmwyZ8gJxmw82CqqtN9pA6ejJDA3mnDqSrBtl3QwG1glJAzChvxhfaLhPEQxolW9ePJXaCYmlvnIktMtPJfsG/Timukqo0ev7SrmZOh1uSMgzOCh+JMRO31DJlYZZfc8OigodyzJLFF550AlDf0OdQNgLk/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FuVVJ4gn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d5aedd177so518420f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672881; x=1729277681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvGNvxvKM8eiH1ZuQL0JBic8eLP1K1xp7NCDrQaUBYs=;
        b=FuVVJ4gnPKq5xTqYItIXn8PImt5plWOvk+oynyYHUz/A4qhI9U8oAKL8gmyotcZhuY
         6Qovssg3HWwLbO0JzCiz/JkV/SdntkAo2AntUa0yZhY1WHCyU99Gi7D/60DyswtzWCpv
         nP8glFOxzCn81vXgU4ysSZMl0ktvIB68UpN10+0NSZ1mKVGHK+Aq4JvwyhEzfX3UUSf3
         4bk8iyw41aGWZJgRdJSEv6DL+QsGz05y6TXU9XOLYFXbiAmfTLPfHxCN5dEH6nBcTmOn
         iPOoH4RXL5tGy4moEUIEPPed2fEnqP666l8E89ZDtAF95GsPX52y8lHGvX/x+FwA5pEz
         ASrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672881; x=1729277681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvGNvxvKM8eiH1ZuQL0JBic8eLP1K1xp7NCDrQaUBYs=;
        b=iNZum2L5fhbO8dycmkIRgEO+qhRo/E7EH2jukQN9kyqFHsZm1pLXW5ta04YKSahknK
         etUG8Xmy9/nHHgEXNej+2/rx8pCEwnieUwQj/l19UcgYoqsgr9mttE1XVhpLkrbRe7C7
         VoLXu8XBD7P3ZdQBUPW+IsFty/jBvwuS2EAks27okTtmTseazXk7ltyK/VkYbv4UiLco
         yVKhbx1e5VDaL+w5ESo6OxpD7hq5AHUiGG3cnaxjqZBlBm4dkNdOmnduD/A8NoDATpx3
         9TMeHHUPlDnEFPi0I+ZDKgx8lwupne+Zk/AiIYzrnx5rXgabWABSSV02BKEKNFmpPPXT
         EuEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOnHGLh+D8hanKwLADmRp3KFHUGRDFgMWPpSXAsFY5JxpuQlNYB2biw434Dz1ttIQw29aSxWCTinZiibqx@vger.kernel.org
X-Gm-Message-State: AOJu0YxadQsUcE7KHMeipNNjMSy99HW6bnitFho6DDcgo0OiV5L5GCKu
	w2JKJVuVm4l8BbF59faqcOxR5W2Khvu+1+o+db3jVdAmHrEztZE2CCcdmNpVB3Y=
X-Google-Smtp-Source: AGHT+IFBiRHpA/2anQVcoQGSuXpNm6xFEP3FrWrt3y5o67BcMn10hdldcHKEx3xYiIax2LY/pbI/Mw==
X-Received: by 2002:a5d:6e43:0:b0:37c:cee0:96e6 with SMTP id ffacd0b85a97d-37d551fc08dmr3069018f8f.27.1728672881110;
        Fri, 11 Oct 2024 11:54:41 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:08 +0200
Subject: [PATCH v7 09/17] soc: qcom: ice: add HWKM support to the ICE
 driver
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-9-e3f7a752059b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9572;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=JLFG06y2/CVmmFjvX7qoJO0lgzWocHfOpOak0flGkYo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRfZrb1iPof5VSEAFaweN9V67nZlKlXvIT5l
 mb4JDKqcEGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0XwAKCRARpy6gFHHX
 ckF+D/4/aOLiX8hPp2gLDvruhIs8jUH+HhEzOeWHciDZ6eSVZMCq0pQYnVJTFWSkPTBHtqj92tb
 E2pXCORkPeaSWPxllo4Culhn4ZnQ7sqCBSj4H/KMh4nncMpqzhJYa9PyW+N12WKn+MKQt2tJr7A
 82psPAxjevYV+zwxyrXCQcZhTXjpA8V3IsfAi3SHqaPgL4NDf/zwoH1nUUXJgUi8FHPGjeNnPVE
 RMOMw6NmN2NTQ7wrvt8BVfEe1M0uleVziiOgoukqij5YIQUg4iXhBGp7B/D/jbhb4PFjBOrgQwf
 bn2o83MhS8JlEUBpGanjcZ7VXWWXj4aMbpIwYZDMmE3JsE6LqiSdMnECzW6eZX9rGfKZm6OO+Cg
 AKh+WuKeSFQh8S9AEzLwiksVTXWF813eCEoGwc7jeBKWb9n/5jXRx4o7A1SDyn8/k2kSufs9CAz
 TzpseGhUktFPXr9q97H6/w82YFabqXwCMUYmNJlU2CaoXQ7CzsuZGv3yMD3N4dPYkZJSmGfQvTv
 JqY9C+vIKmPrOrecRDaXOpVHHA6nAmcu4Qovy8jZHoNVSH4mcY2RTjcU+V6zVY7fmySoSkjeI+B
 AXisxiWsMgirLiDHzowjtzSIMBZeZ+Ei9kWQ7AUR8vHzxF8T3imurZ90C1oZmb/uhV9BhK1sr40
 z23KO6zQN05LMLg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Qualcomm's ICE (Inline Crypto Engine) contains a proprietary key
management hardware called Hardware Key Manager (HWKM). Add HWKM support
to the ICE driver if it is available on the platform. HWKM primarily
provides hardware wrapped key support where the ICE (storage) keys are
not available in software and instead protected in hardware.

When HWKM software support is not fully available (from Trustzone), there
can be a scenario where the ICE hardware supports HWKM, but it cannot be
used for wrapped keys. In this case, raw keys have to be used without
using the HWKM. We query the TZ at run-time to find out whether wrapped
keys support is available.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/soc/qcom/ice.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++--
 include/soc/qcom/ice.h |   1 +
 2 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 4393262a1bf2..667d993694ac 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -27,6 +27,40 @@
 #define QCOM_ICE_REG_FUSE_SETTING		0x0010
 #define QCOM_ICE_REG_BIST_STATUS		0x0070
 #define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
+#define QCOM_ICE_REG_CONTROL			0x0
+/* QCOM ICE HWKM registers */
+#define QCOM_ICE_REG_HWKM_TZ_KM_CTL			0x1000
+#define QCOM_ICE_REG_HWKM_TZ_KM_STATUS			0x1004
+#define QCOM_ICE_REG_HWKM_BANK0_BANKN_IRQ_STATUS	0x2008
+#define QCOM_ICE_REG_HWKM_BANK0_BBAC_0			0x5000
+#define QCOM_ICE_REG_HWKM_BANK0_BBAC_1			0x5004
+#define QCOM_ICE_REG_HWKM_BANK0_BBAC_2			0x5008
+#define QCOM_ICE_REG_HWKM_BANK0_BBAC_3			0x500C
+#define QCOM_ICE_REG_HWKM_BANK0_BBAC_4			0x5010
+
+/* QCOM ICE HWKM reg vals */
+#define QCOM_ICE_HWKM_BIST_DONE_V1		BIT(16)
+#define QCOM_ICE_HWKM_BIST_DONE_V2		BIT(9)
+#define QCOM_ICE_HWKM_BIST_DONE(ver)		QCOM_ICE_HWKM_BIST_DONE_V##ver
+
+#define QCOM_ICE_HWKM_CRYPTO_BIST_DONE_V1		BIT(14)
+#define QCOM_ICE_HWKM_CRYPTO_BIST_DONE_V2		BIT(7)
+#define QCOM_ICE_HWKM_CRYPTO_BIST_DONE(v)		QCOM_ICE_HWKM_CRYPTO_BIST_DONE_V##v
+
+#define QCOM_ICE_HWKM_BOOT_CMD_LIST1_DONE		BIT(2)
+#define QCOM_ICE_HWKM_BOOT_CMD_LIST0_DONE		BIT(1)
+#define QCOM_ICE_HWKM_KT_CLEAR_DONE			BIT(0)
+
+#define QCOM_ICE_HWKM_BIST_VAL(v)	(QCOM_ICE_HWKM_BIST_DONE(v) |		\
+					QCOM_ICE_HWKM_CRYPTO_BIST_DONE(v) |	\
+					QCOM_ICE_HWKM_BOOT_CMD_LIST1_DONE |	\
+					QCOM_ICE_HWKM_BOOT_CMD_LIST0_DONE |	\
+					QCOM_ICE_HWKM_KT_CLEAR_DONE)
+
+#define QCOM_ICE_HWKM_V1_STANDARD_MODE_VAL	(BIT(0) | BIT(1) | BIT(2))
+#define QCOM_ICE_HWKM_V2_STANDARD_MODE_MASK	GENMASK(31, 1)
+#define QCOM_ICE_HWKM_DISABLE_CRC_CHECKS_VAL	(BIT(1) | BIT(2))
+#define QCOM_ICE_HWKM_RSP_FIFO_CLEAR_VAL	BIT(3)
 
 /* BIST ("built-in self-test") status flags */
 #define QCOM_ICE_BIST_STATUS_MASK		GENMASK(31, 28)
@@ -35,6 +69,9 @@
 #define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
 #define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
 
+#define QCOM_ICE_HWKM_REG_OFFSET	0x8000
+#define HWKM_OFFSET(reg)		((reg) + QCOM_ICE_HWKM_REG_OFFSET)
+
 #define qcom_ice_writel(engine, val, reg)	\
 	writel((val), (engine)->base + (reg))
 
@@ -47,6 +84,9 @@ struct qcom_ice {
 	struct device_link *link;
 
 	struct clk *core_clk;
+	u8 hwkm_version;
+	bool use_hwkm;
+	bool hwkm_init_complete;
 };
 
 static bool qcom_ice_check_supported(struct qcom_ice *ice)
@@ -64,8 +104,21 @@ static bool qcom_ice_check_supported(struct qcom_ice *ice)
 		return false;
 	}
 
-	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
-		 major, minor, step);
+	if (major >= 4 || (major == 3 && minor == 2 && step >= 1))
+		ice->hwkm_version = 2;
+	else if (major == 3 && minor == 2)
+		ice->hwkm_version = 1;
+	else
+		ice->hwkm_version = 0;
+
+	if (ice->hwkm_version == 0)
+		ice->use_hwkm = false;
+
+	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d, HWKM v%d\n",
+		 major, minor, step, ice->hwkm_version);
+
+	if (!ice->use_hwkm)
+		dev_info(dev, "QC ICE HWKM (Hardware Key Manager) not used/supported");
 
 	/* If fuses are blown, ICE might not work in the standard way. */
 	regval = qcom_ice_readl(ice, QCOM_ICE_REG_FUSE_SETTING);
@@ -114,27 +167,106 @@ static void qcom_ice_optimization_enable(struct qcom_ice *ice)
  * fails, so we needn't do it in software too, and (c) properly testing
  * storage encryption requires testing the full storage stack anyway,
  * and not relying on hardware-level self-tests.
+ *
+ * However, we still care about if HWKM BIST failed (when supported) as
+ * important functionality would fail later, so disable hwkm on failure.
  */
 static int qcom_ice_wait_bist_status(struct qcom_ice *ice)
 {
 	u32 regval;
+	u32 bist_done_val;
 	int err;
 
 	err = readl_poll_timeout(ice->base + QCOM_ICE_REG_BIST_STATUS,
 				 regval, !(regval & QCOM_ICE_BIST_STATUS_MASK),
 				 50, 5000);
-	if (err)
+	if (err) {
 		dev_err(ice->dev, "Timed out waiting for ICE self-test to complete\n");
+		return err;
+	}
 
+	if (ice->use_hwkm) {
+		bist_done_val = ice->hwkm_version == 1 ?
+				QCOM_ICE_HWKM_BIST_VAL(1) :
+				QCOM_ICE_HWKM_BIST_VAL(2);
+		if (qcom_ice_readl(ice,
+				   HWKM_OFFSET(QCOM_ICE_REG_HWKM_TZ_KM_STATUS)) !=
+				   bist_done_val) {
+			dev_err(ice->dev, "HWKM BIST error\n");
+			ice->use_hwkm = false;
+			err = -ENODEV;
+		}
+	}
 	return err;
 }
 
+static void qcom_ice_enable_standard_mode(struct qcom_ice *ice)
+{
+	u32 val = 0;
+
+	/*
+	 * When ICE is in standard (hwkm) mode, it supports HW wrapped
+	 * keys, and when it is in legacy mode, it only supports standard
+	 * (non HW wrapped) keys.
+	 *
+	 * Put ICE in standard mode, ICE defaults to legacy mode.
+	 * Legacy mode - ICE HWKM slave not supported.
+	 * Standard mode - ICE HWKM slave supported.
+	 *
+	 * Depending on the version of HWKM, it is controlled by different
+	 * registers in ICE.
+	 */
+	if (ice->hwkm_version >= 2) {
+		val = qcom_ice_readl(ice, QCOM_ICE_REG_CONTROL);
+		val = val & QCOM_ICE_HWKM_V2_STANDARD_MODE_MASK;
+		qcom_ice_writel(ice, val, QCOM_ICE_REG_CONTROL);
+	} else {
+		qcom_ice_writel(ice, QCOM_ICE_HWKM_V1_STANDARD_MODE_VAL,
+				HWKM_OFFSET(QCOM_ICE_REG_HWKM_TZ_KM_CTL));
+	}
+}
+
+static void qcom_ice_hwkm_init(struct qcom_ice *ice)
+{
+	/* Disable CRC checks. This HWKM feature is not used. */
+	qcom_ice_writel(ice, QCOM_ICE_HWKM_DISABLE_CRC_CHECKS_VAL,
+			HWKM_OFFSET(QCOM_ICE_REG_HWKM_TZ_KM_CTL));
+
+	/*
+	 * Give register bank of the HWKM slave access to read and modify
+	 * the keyslots in ICE HWKM slave. Without this, trustzone will not
+	 * be able to program keys into ICE.
+	 */
+	qcom_ice_writel(ice, GENMASK(31, 0), HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_0));
+	qcom_ice_writel(ice, GENMASK(31, 0), HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_1));
+	qcom_ice_writel(ice, GENMASK(31, 0), HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_2));
+	qcom_ice_writel(ice, GENMASK(31, 0), HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_3));
+	qcom_ice_writel(ice, GENMASK(31, 0), HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_4));
+
+	/* Clear HWKM response FIFO before doing anything */
+	qcom_ice_writel(ice, QCOM_ICE_HWKM_RSP_FIFO_CLEAR_VAL,
+			HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BANKN_IRQ_STATUS));
+	ice->hwkm_init_complete = true;
+}
+
 int qcom_ice_enable(struct qcom_ice *ice)
 {
+	int err;
+
 	qcom_ice_low_power_mode_enable(ice);
 	qcom_ice_optimization_enable(ice);
 
-	return qcom_ice_wait_bist_status(ice);
+	if (ice->use_hwkm)
+		qcom_ice_enable_standard_mode(ice);
+
+	err = qcom_ice_wait_bist_status(ice);
+	if (err)
+		return err;
+
+	if (ice->use_hwkm)
+		qcom_ice_hwkm_init(ice);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(qcom_ice_enable);
 
@@ -150,6 +282,10 @@ int qcom_ice_resume(struct qcom_ice *ice)
 		return err;
 	}
 
+	if (ice->use_hwkm) {
+		qcom_ice_enable_standard_mode(ice);
+		qcom_ice_hwkm_init(ice);
+	}
 	return qcom_ice_wait_bist_status(ice);
 }
 EXPORT_SYMBOL_GPL(qcom_ice_resume);
@@ -157,6 +293,7 @@ EXPORT_SYMBOL_GPL(qcom_ice_resume);
 int qcom_ice_suspend(struct qcom_ice *ice)
 {
 	clk_disable_unprepare(ice->core_clk);
+	ice->hwkm_init_complete = false;
 
 	return 0;
 }
@@ -206,6 +343,12 @@ int qcom_ice_evict_key(struct qcom_ice *ice, int slot)
 }
 EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
 
+bool qcom_ice_hwkm_supported(struct qcom_ice *ice)
+{
+	return ice->use_hwkm;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
+
 static struct qcom_ice *qcom_ice_create(struct device *dev,
 					void __iomem *base)
 {
@@ -240,6 +383,7 @@ static struct qcom_ice *qcom_ice_create(struct device *dev,
 		engine->core_clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(engine->core_clk))
 		return ERR_CAST(engine->core_clk);
+	engine->use_hwkm = qcom_scm_has_wrapped_key_support();
 
 	if (!qcom_ice_check_supported(engine))
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index 9dd835dba2a7..1f52e82e3e1c 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -34,5 +34,6 @@ int qcom_ice_program_key(struct qcom_ice *ice,
 			 const struct blk_crypto_key *bkey,
 			 u8 data_unit_size, int slot);
 int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
+bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
 struct qcom_ice *of_qcom_ice_get(struct device *dev);
 #endif /* __QCOM_ICE_H__ */

-- 
2.43.0


