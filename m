Return-Path: <linux-fsdevel+bounces-28874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2347D96FB10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 20:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD8AB262BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1D21C17E;
	Fri,  6 Sep 2024 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PWyAzTdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A41D7E4C
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646077; cv=none; b=Q7m0GB/z7vHQV0CCIkJS32IoST8rBcTcqRsq3sIqSA5yV4LrzQpyBIJisDcCLRbAzWJAeUgL+bP38Fx7my2L3NsZ7za/Y714RjOTLQdNdOHZ/a6qiJOsyuikbCX6oauZLNlk3eNxRUMIhnmd3Il63o7n/MLPdxQEXeTG8Yr1zDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646077; c=relaxed/simple;
	bh=Ke8dL87SoQga2X6uwSVl5aJs+yqrMe/gn621psUMM4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tm15KgzM6FHjitffgmYgkzKfaw0Ex5cqQp95qATWnmLKQpngS3aKt+SmRfedsybZerdGFjivbYim4UL74RXJk2ZMpDuEpEv0O5TV1HFtGxuYleQsqKQBgA6nxj4vrOGUcNnDuxIRA9i3UFvQG6eBqikqmS6XQRK70Yl4sTBrVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PWyAzTdE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42c94eb9822so17970205e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725646069; x=1726250869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3Qc6a6yfPpcSLUHB6jxwWREt+1D13kZPgELOkHHTnU=;
        b=PWyAzTdEHmn0KohlO+QwnUMr4le5SBCWwuUpqeNGnPa24e/Vz7Ez96jADnekMATy2m
         zXV2YDxjcjS5XBZcVUoAVyzpNqTtm3jhr3yIql5ztW9qLbYK1/3gFAfzstTKO2bKhZkK
         NoYPyISKOF6opC/HouC9hDYGnJjbzRDZv4gCJQjLlMhDuP+xD8MRYj/cki5ssOFhUK/M
         ZyiGkPaAVZ40fStG2ln/gxKFGENBnuLhFkIEz+C0acKt5Ovyvy2u0GJesn3OxrI+JKs3
         g30+Y4PP3YPttedwH+/EBWyHaGUb9fkZMeFmzMN0Hv+S57tHPg0fTUmoORmT9co3zYQf
         XsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646069; x=1726250869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3Qc6a6yfPpcSLUHB6jxwWREt+1D13kZPgELOkHHTnU=;
        b=rSjol4/sK4p8kMJhqKm7LgL6WUiR9LGsmuUqrDVWXlUsvxVuSAhAQdBrBhOcILesNa
         R+3gNUE7ddsfUpguLCT0VNLzOs4yW4p3XZG/Af6XPtCfX95jWoepjqwPRIwgNIo95ZRd
         li1WQbk8sM9ztvnSTAV6fkLy7FV8y0SisKjSPJTL4Yj4DERF9F3x7xOiczj7uJ5DUoSA
         XEQlK6xm1Kt3YxD/A7J0wbTENqzCyY8QQFdKHvXinFx97mbbwsoP3p5nYELOkgBpgayZ
         1K4Yg97BeoenCLMgrWe/SQxEKpJ3Mds69xs94KBGjOoYshJgkE+zBrMMImeg7bFuu4Yn
         +cmA==
X-Forwarded-Encrypted: i=1; AJvYcCWe5fI2r65JpKzuBCkasKPgnLC4SikSsFUc9cj2juj5Igfat4Ima3yHZFUGrubx+2FGgNskK11ljUFd7A4u@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5VP8X7NqgeqmLu+px35jus4Z0k+uEBkXGOfxwgToNSGytPRt
	BXlMSAjDBsy3rpdCOnwHGFSW1xFui3pQMD/ZvA2/0rcHKzFI6wASyZydufeMjGw=
X-Google-Smtp-Source: AGHT+IHgRW1dDAdY7k4cr6NNJiquQTX64Ku0dg+CwFId7m35sGNplTQSRD/ouEe6SnGIcdLsGvugaA==
X-Received: by 2002:a05:600c:19c8:b0:428:ea8e:b4a0 with SMTP id 5b1f17b1804b1-42c9f97e290mr25247045e9.14.1725646069578;
        Fri, 06 Sep 2024 11:07:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cac8543dbsm5880485e9.42.2024.09.06.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:07:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 06 Sep 2024 20:07:18 +0200
Subject: [PATCH v6 15/17] ufs: host: add support for wrapped keys in QCom
 UFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-wrapped-keys-v6-15-d59e61bc0cb4@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=7XeLQBTLqSRLELujYdPFagEOBSA1g3e0jp8VcC7sT4M=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm20TaxOfovewpS13ECe1kzE6x8LSUpZm6atLPL
 H0luCevms+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZttE2gAKCRARpy6gFHHX
 coKzD/4sWo0+WuhWpypP64fHAtwVevfl3J83/sWXt724EJc6iEVIuwj5jVSJ9R2Bjb5O1GKuLah
 29AJTkCfiXmUrsCVkEIZFwYYKUJvCuqrazaMm9JZ9v2N9o09Lv6i6CiD7NrpCwsr73hr96rzKqY
 oqgRIpruPUrtSBbMZvgYqDqSjq7YFqpxGt3PkjSqWpd+VWj+0pIUfMHopwbYhybFhh7qn5aofle
 CJ9BW4tM+oyoiM3yUZLy4jGSCtR0OG5Q2sVD7cWQTSLI604OETKXcesZb2H6cyuuC3oX3nxU2mQ
 Jzmoqi6MdToG25x10PIJ5DZ1ZJffBTRcPqmdQEQN5zMpAaYPDpZZnzjFavNtfir6Z3XtbXmUPn+
 zoRaJMww2fwpGc9hl00kRNd/3ZRrO7arL6fywECU31BZGM6kVxY5XLJgnvkNiR4z3C2S2wBiV+8
 Ib0ZBkQe06GcJTp4BjDfFbNMNTldLWMyBzvmGETCOeSTrFZwBlJNZxh568RJMHTpYA4zaCS1l7m
 gHt6FDcCJm7mVp7M9TzTcScKB3PCV7fCR64mSyW9dSZgmYukeIZuSS/ktVTw0C8dtXFZ54k6zdf
 iR1BEvgpYshflVvlaA2bqNgsEasbHb8ezPz+o5CEVzvssv2S4yXAvJAWsTkmgzkYXCuEfmfd/xL
 qxL/ZTtoB4ba2lw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Use the wrapped keys capability when HWKM is supported. Whether to use
HWKM or not would be decided during an ICE probe, and based on this
information, UFS can decide to use wrapped or raw keys.

Also, propagate the appropriate key size to the ICE driver when wrapped
keys are used.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 58018fc8999d..366fd62a951f 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -129,6 +129,8 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 
 	host->ice = ice;
 	hba->caps |= UFSHCD_CAP_CRYPTO;
+	if (qcom_ice_hwkm_supported(host->ice))
+		hba->capabilities |= UFSHCD_CAP_WRAPPED_CRYPTO_KEYS;
 
 	return 0;
 }
@@ -166,7 +168,11 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
 	    cap.key_size != UFS_CRYPTO_KEY_SIZE_256)
 		return -EOPNOTSUPP;
 
-	ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
+	if (bkey->crypto_cfg.key_type == BLK_CRYPTO_KEY_TYPE_HW_WRAPPED)
+		ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED;
+	else
+		ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
+
 	if (config_enable)
 		return qcom_ice_program_key(host->ice,
 					    QCOM_ICE_CRYPTO_ALG_AES_XTS,

-- 
2.43.0


