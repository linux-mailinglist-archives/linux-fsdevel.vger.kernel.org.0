Return-Path: <linux-fsdevel+bounces-36252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623719E01BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 13:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF9E169C74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 12:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5A120ADF7;
	Mon,  2 Dec 2024 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y3UoEebG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315A20B1E3
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140994; cv=none; b=NUcrukTF0LrzzrqbMu2P9FYhQd1iq1ZfbA0L2xA5VMsxgo0QolJeHRU6h2LiPdUSW2ngQ/nRKAja323izAOqMeyEbrr1W0ZUBFIT9hjYz115AUnZTN7Tgx35V/VEVu/g0Tlt/lnUcwFiqZQ/LA0CqChcdNmGAkR7Y+ESNRmCj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140994; c=relaxed/simple;
	bh=gdr3l+RFSHrWyEruQBFmEvtHoeWmaRMEJf4HRZMyXWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IFeDF5Wewf0XzSCLWupkZkL5bEC91cARF0E+emnuBfL1R5kVAOjoLGAOeUy3QW1DnW/Qbdz5qq/M3uf8aosJMd3PiaJNY12gtBs0lEXuIIgM25p9QXu1DICpAvmcp4kfiNDtXspfcOkUXM2u6ZElDT7dPFASDpUShwh9h13h42Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y3UoEebG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a044dce2so52460985e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 04:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733140989; x=1733745789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+PmcWdMJm7CbMMHOaGOj0ZiJf4zVkJvWt/4CpfiDHk=;
        b=Y3UoEebGOmru323MkwO4gAcx3jC39EeStRWNNWDOz97E/uEDDwdzAYF66Eo512m4ZY
         XZYBZxiyudCcTrgwzQH08ne7goS8zhRJ1fkyAYgO50N+0wruokv68Nss4CB8sKF26R6V
         0U6DNlaJyVs2g+D9WCA+hYKU7WHGP9r4h3kPVEKl1CayUN2WmunzQ/+c66pKn+xqeM4S
         mMhlLy8sMRgxFjC1TWdFzXkUUKsEL4/dX4n2hpG3b2nExDQCbTOEJhFQOqWAmgNoseuP
         cazffC7WSOZmVAxcJfqCogBBLwAaxvFIiMPOQCMXWzFYAjdNKjzVSTD1yyOeoIFbNWMF
         X54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140989; x=1733745789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+PmcWdMJm7CbMMHOaGOj0ZiJf4zVkJvWt/4CpfiDHk=;
        b=T6h5h1sPAD946hXPosa5AG+q5jLpJSmN69Av9tXlITCOW6FUU16/a2uagJAz2dLCm+
         cPrHpcO/H2seJjZ9z7mjAFRz9KVq/suFDwTfsCfNKZhJIyKrBWH7kYdEDvAmyPknic0F
         oiBaMd1rORyaQcZ28NBrNR8Vie/so9dcwZd/qTmEJgamCsEVRtBjA4EILeiK4ar9jYLB
         yisRpw4nuOsOuj496QKDefgBiy6RR/bxyqKm5EPanLKqzUERm7Kky12L4JK9FRNwVtLm
         sEFNGJJ1AO5nmfuwH3v57Zh81xl3HZFCWalB7VZo9YF0x4gmanY6MnYk7sBf/pZTo8t7
         NcSA==
X-Forwarded-Encrypted: i=1; AJvYcCVEx6saSEZE1YUMrmdfEXJrUzMNZgtnBim9XIlFzB5qxkpF0f1K5R5Rcz9adk0hBFqOb2hhIYTDmSwv74WN@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnOt061m3PVclT2TYoNTlSaDxBpXcQwbiiWHpN069Iq5lsc+A
	dhwPnlt9AqMFFkcauMSmxPPesWmRjq5x516oNiGkKASC0u3WuM3ew21wenWrlDw=
X-Gm-Gg: ASbGncse2AQn2J8r8hN6+PCHukdNcsZ1NZvuGvwnTF8rW5WM3UEMuPcew7S/zh3Qly6
	DTFheG9vbwYPwbxpM1L0LkefoHEhqJs1OuPe2y8ITrqhwRywtdQkliIvnwKlmjSGxPFKSdnMb8X
	iba2zA9ruiIVZeqxto/ucjt2+GxISGQpOKhzB8uuw5UrtYJ4JrBnqBm70iQ8FEKXN/jnl9WI7eG
	L6EW5Nc40Wa7WZRYCgTkIc4S8J+dpAiiNQPfLvk
X-Google-Smtp-Source: AGHT+IEe2U0hKMLkW/kvwI9IdOuJTARvAn++dsfGezCEbCgsSOocEJZ25SQAJNm8raH54gf64cUe+w==
X-Received: by 2002:a05:600c:45cd:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-434a9dbb631mr238682775e9.6.1733140989459;
        Mon, 02 Dec 2024 04:03:09 -0800 (PST)
Received: from [127.0.1.1] ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm152396095e9.8.2024.12.02.04.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:03:09 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 02 Dec 2024 13:02:32 +0100
Subject: [PATCH RESEND v7 16/17] ufs: host: add a callback for deriving
 software secrets and use it
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-wrapped-keys-v7-16-67c3ca3f3282@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=MdNk2H0tGYbBpgVzTRjqUx6qkSuTV/Qf3E5ZrGPzFBA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTaHWQd1yXC+tq8uQ59eAQtfHl/6mdb5ozK09+
 cHD49JahjaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ02h1gAKCRARpy6gFHHX
 cscOD/4uo18/YSJusBFEPhCAOQrXkTC5my/rO09DdLTqE1XGp8d5iJ4c6VBgl5c4j875tDft90Z
 LDoSqYOoSOkIXdQq2w+e+CPuuVWHB0sljyAE4Hd5qhEPsan4OX2pG8PxGOQJQvO1RtZLbbW8RMt
 DjKvBxiA+g1hSmn0OvDw3NE9s/QFHLejldEX7SZ9kj8PhPlX+TensgJVR54kv24sOuq6eLhJN3R
 KxYmUnBAp7YNxsO3e1FaWBqE48qiRGhH8EXRXPgDjMUx0SPMefYjyw0rLA2rOp7BztoBqnT9Njc
 DsB/bpdeQFAH+GyMeBQ712WeIP4uTR6sler/piAQ+hqKa4h8HH4QK45eL8IUdz4U9PwMZzKfNzC
 p+C8F+zSJsQJQ/h0Z6YW6cNhaqBbsKJBZ5KmFiSgDUTt5h0CKDv8geQrxc4xleoqgrEulbqyLs9
 uH/1uBh+s86e5O4zxOiTp8EJUi/w7QHGy1Jx12c7Ua/cpw3HcuxV1J1vPndRA/+e4ew07AzVkBi
 mFeYHiSVYHHGT7YWuJK4PZCc9K9RJd/6QL37q+pT21CKuNGaqgaakybuaRo1IRReUDShiyqx9Sv
 td2iQmTzE5dNeT/nt5pMvJ6iX5JubFvUwokCEdED5zxLe9X2C/g79WCXNWZrh7/u6aYfu6OfQLJ
 ukpOFb4JFzQ/yPw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Add a new UFS core callback for deriving software secrets from hardware
wrapped keys and implement it in QCom UFS.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 15 +++++++++++++++
 include/ufs/ufshcd.h        |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index fd774531cbbf3..0da2674777d2c 100644
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
@@ -1833,6 +1847,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.device_reset		= ufs_qcom_device_reset,
 	.config_scaling_param = ufs_qcom_config_scaling_param,
 	.program_key		= ufs_qcom_ice_program_key,
+	.derive_sw_secret	= ufs_qcom_ice_derive_sw_secret,
 	.reinit_notify		= ufs_qcom_reinit_notify,
 	.mcq_config_resource	= ufs_qcom_mcq_config_resource,
 	.get_hba_mac		= ufs_qcom_get_hba_mac,
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 1b7c36e5347b2..dc8c055eae79a 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -325,6 +325,7 @@ struct ufs_pwr_mode_info {
  * @device_reset: called to issue a reset pulse on the UFS device
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
+ * @derive_sw_secret: derive sw secret from a wrapped key
  * @fill_crypto_prdt: initialize crypto-related fields in the PRDT
  * @event_notify: called to notify important events
  * @reinit_notify: called to notify reinit of UFSHCD during max gear switch

-- 
2.45.2


