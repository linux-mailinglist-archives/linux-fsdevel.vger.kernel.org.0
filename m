Return-Path: <linux-fsdevel+bounces-31770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876E099AC42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6649B2589C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 19:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484291F7094;
	Fri, 11 Oct 2024 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="p0A8yWx3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0951D1518
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672902; cv=none; b=fT//kuiBliNqHp+yOFYV43R5+kKmt6Z7Yp3ReTroBcvM/3fU2pcVRu/koGUQ+M+TUAL/KL8PPb7LBt02IF0XzINGErdh/jQyFXjx+XVkJiWV2/ePjILCtdtoFO/ugbBA48CG7i4E6+lgZ8Lo8jmvw5L78bNNyVML3PW3JXuMybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672902; c=relaxed/simple;
	bh=e1gtd88RzjTEdKgz5vKtdQEHaWC6suwW5itfB3BJQME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRFu0fRF6aCaR0/qBtudzgt5aOIAksUG4MCM2wkojLufgE/dc0uyHEUvox8SdS60dlxSopmZP0pQQx3bJ8bMYwIX3xeVaAy4vMUZN6kgMKNQcSDEI1pPF4bOCFh/1+OxBV0/edqhuAByoLKkJ2jFLh0wMCIP2XKBngofvycNG6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=p0A8yWx3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43123368ea9so4095495e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672892; x=1729277692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H45D+zQ4RlZo87PnQlpnl9k3Po/Ceaj5Q2WfHuVjsjY=;
        b=p0A8yWx3OoCljbbWdvX+WqHz0Dsg4ejsm68SeCsnGKpsZFz2+z3AKNhmuuSuLzw6ug
         rxIGcld16NVdxN8Iesbd8WECOerZq7tppUBoA63LMzXXUJMNz2RINMu29sBhXUlpjTE4
         7GP70BrfbWKynZb4G/AYt0W+mKoOUvRl0xw9YGmasyNdTv0q3HDI3mfFgXUZTwNiYp2f
         txunhWxzSiieJ+XxFLzo+jM225ZQwUz19bTeOVpJwGRR7GiCISJUhxhnfltGpOtfeean
         +bio2aDx0J+o3orHOxRZWeQkD6iYhlYnDhgm1WXWX28kpmw6gdZQbzGPemT42yQiFlNB
         3DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672892; x=1729277692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H45D+zQ4RlZo87PnQlpnl9k3Po/Ceaj5Q2WfHuVjsjY=;
        b=W5Wx+pPMKKjVD7ohskMul5hmoZLVRC5etGNknN43+1WxZ05YznWOy814IGtBrl2qca
         sh7F2zDL/x2jfMVCr5BDPH8cauxvz0YqQfdy4z6U0AMG9ZAn9IRfqBiVvCYeKnF4Tmd4
         WCQqK4l4Bly0K2wsl0fd7Qw7N7U7e3y3edlRarXI2kvTPoCiw/M653BoRk4/b+IItO+2
         RELLUdjqaZcL8vygZySsCT/C5iQoiS8fTvXHEAzYIWas+1KJXs3oT5Qgia5Y5B974FNk
         z8Ep/tRAGKynQp30xNyZkNzE3946h3kI9m4Ga8DPJmAj+LTyrhUB8SOy61btShRug4xo
         AwsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFdT49UH5vijeUZoiY/u0SZeUOjC2r38PuiK4/2iXduqBHJVvQvm5jc0/VUwX83CFMILhj9J3KzaNf8Qen@vger.kernel.org
X-Gm-Message-State: AOJu0YyxWH8Igolz0td3UkBPJdf57eibRwXUy7FtWbPFfO0XXOi6/AVw
	xWf+DBB7M5SGdHSCWpCCxg3HiFGYeW0Vvv4JezoG6DJEKo6qg5B8oXCw80DYbWg=
X-Google-Smtp-Source: AGHT+IGoTXSLCWNbiKvBBCB8iuDTBloAvzoGmWYaf2ibRIfcx4PwXi3/91OEiktNbtQQzvwdztwuZg==
X-Received: by 2002:a05:600c:190f:b0:431:251a:9dc9 with SMTP id 5b1f17b1804b1-431256099fdmr3480875e9.25.1728672892069;
        Fri, 11 Oct 2024 11:54:52 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:15 +0200
Subject: [PATCH v7 16/17] ufs: host: add a callback for deriving software
 secrets and use it
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-16-e3f7a752059b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2513;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=8izsipyIaDBdSDiSjvy9mf21cushU27meDYZO8QM7MY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRhwyf+sbRZiDFPfQnZmkfF4U7jfh05yXQav
 c1LkPJCdPeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0YQAKCRARpy6gFHHX
 cqB7D/95mHJd7lZyDeS8zmIiYEZFW6SUNcNDYRflN999g4QScsSRTKlq3MTcag3Ca8ltNUoJIug
 39wPTbq1I/X4YXzUshJpgGyNrzQuSZLcNlz/0CdD8URU1pLkFmPyY4MiXpu3oh+NQ/o67QYtiMJ
 v43/AALUcHRtWLYflg1ZxUAqMPXsG4WK8RtjPxdauvJY1FKhOPEs3hhMpnrAsj5IIbHbot1IxOR
 0eyjVtaIbciJa2EnmaMwjUIBNeIBG2O0p4NTSbIwyX3i+wqvemAx4yBWK+RyzKfrCaVhz6a8KcB
 ov8vJP4nCLNxST6gtuasJ1jiOpE+uqWjm5ec3TBerQiy8tVH/PvTI3EXKSCgacHeeyiF0vhe+ji
 wR4YvxwSm0y8XK+4lYYv2vOW/viQ4eF3IjxGR64O8g5P1z1OSIeSp2jJ0aTipkSh72yTCm2hMoy
 eoiYN+G9pZimXdoq1h3ouQz2PExiECAIYS/NE6bsZ3vihyhgExQ24oFpoAhGVPgeK8ma3ReFC2F
 g+9Iv64HG9yUE1X/w86/vby7nlQ32V464qHqdz7PdMJ3IzZLQCvDhAJCtyHC2iTc/Y5ZeJwfoL1
 8lDEtDIK1LNhbGnL0ICafGD5S6YgALrTCClSAxesU0bMYwYiALDVzXhzi4R2slJHNHXjiN0WHRd
 2IlGSJY+nTTII6w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Add a new UFS core callback for deriving software secrets from hardware
wrapped keys and implement it in QCom UFS.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 15 +++++++++++++++
 include/ufs/ufshcd.h        |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 880df3a8955a..862e02bf8f64 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -182,9 +182,23 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
 		return qcom_ice_evict_key(host->ice, slot);
 }
 
+/*
+ * Derive a software secret from a hardware wrapped key. The key is unwrapped in
+ * hardware from trustzone and a software key/secret is then derived from it.
+ */
+static int ufs_qcom_ice_derive_sw_secret(struct ufs_hba *hba, const u8 wkey[],
+					 unsigned int wkey_size,
+					 u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_derive_sw_secret(host->ice, wkey, wkey_size, sw_secret);
+}
+
 #else
 
 #define ufs_qcom_ice_program_key NULL
+#define ufs_qcom_ice_derive_sw_secret NULL
 
 static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
 {
@@ -1832,6 +1846,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.device_reset		= ufs_qcom_device_reset,
 	.config_scaling_param = ufs_qcom_config_scaling_param,
 	.program_key		= ufs_qcom_ice_program_key,
+	.derive_sw_secret	= ufs_qcom_ice_derive_sw_secret,
 	.reinit_notify		= ufs_qcom_reinit_notify,
 	.mcq_config_resource	= ufs_qcom_mcq_config_resource,
 	.get_hba_mac		= ufs_qcom_get_hba_mac,
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index d74a26a36f5b..c172c1dd9209 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -323,6 +323,7 @@ struct ufs_pwr_mode_info {
  * @device_reset: called to issue a reset pulse on the UFS device
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
+ * @derive_sw_secret: derive sw secret from a wrapped key
  * @fill_crypto_prdt: initialize crypto-related fields in the PRDT
  * @event_notify: called to notify important events
  * @reinit_notify: called to notify reinit of UFSHCD during max gear switch

-- 
2.43.0


