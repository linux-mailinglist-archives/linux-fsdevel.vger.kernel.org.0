Return-Path: <linux-fsdevel+bounces-31768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A355299AC3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E571F26986
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 19:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E391F707A;
	Fri, 11 Oct 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nRkMEkO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12031D150E
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672898; cv=none; b=iD/cRYtmGOemh4A1//GWYIVjAzjuzzW3l9xVT8/kgRK2seLELC0p2FXeCq6KLfE3l3vE+46yFLd4Cq9T0qfwljc5SX/UZUPC4APHxkZq/SWIuxZnTiXyxjuzfUANRONkm481TYEycAqJuCn7ZYzx3HbDPma94a/Wgeru5tub+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672898; c=relaxed/simple;
	bh=rCoqdQ9B7Hn8xdsgALiUMx6hOr/x0MpVdqxz3Ze2hQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BvZQYd1DtMvNLgS8373mDrhVBm6kuMriV0IBL1LhUcc+nmU3oN6TQaTsqUFgq/ir03m/iW4etb9QGWCHmp6yKDV0L2bKqlxkPnMVwFFapeKKoWt4K33JE3bwDYHOJaK0Em5mqMhMZ5ttMh2YH9mO5/+Zab7ZwdVr5ZlVNgpoR2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nRkMEkO3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431195c3538so14559155e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672888; x=1729277688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhatKWKJuxfltx1oNZ6oUaNqgboH9F2TpuTRwRw3JfI=;
        b=nRkMEkO3WAn4V05TmXnB8gjaBNhfQPZIJTzt6Q9SV7V9A9wJG9louYgBc2SltMkUap
         vbrFbizKTeMn3tVVPXoR+aXaDEK4mvx/79VTmud68FnTyjKPbeSP3kv3SmN+Ldy+pciT
         d1Gm4NGWZYTacVA7upmqdi+8j0jpmjLYW8am9eglDhMVjp4nMhw4oECCp0broom8aUkQ
         pdFkw6jEl68o696hM9TqwtVbQsu0UCms/Jy06Y6Yg4ceN1uTW8c62GxgWklzNckDVQMN
         nMENVlUK7ev0l7OQRcROTSK5WFio43Fn9Nac2ZFE0I4kIpReIOqaBBeUzFPIFg31eotx
         TnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672888; x=1729277688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhatKWKJuxfltx1oNZ6oUaNqgboH9F2TpuTRwRw3JfI=;
        b=m/2ghKfxlTxerXHWM6ELq/M83w3Kb9FTX03MoIooB3MZMsn5FO/I+XF1ssTIa9VVOc
         wL1dtOWCPeCAxCsR/F5Z8YdaC3urmLL6j7fzbgM9OAS+ERzvIWZL981dhmWJcb1WBx9M
         OuCBarMzxZGhtlIF01MJ14FjpSabzN77dImTlpVzOjfs/vei/Lkj0+fN8GjutrAiB3pe
         yi2dP1tJBZWoD6gH7SUkbtNX2f+ldf00lm4S5IOMfE8wcxVXoiL/bCqUn3IfTJ/tq56n
         S6T52O9bTSWCoM8WDk5/+AfH0cO4KgtFXmuRFJvoB3a7lKDISJW1eq72bNbrAazbCKGS
         /H0g==
X-Forwarded-Encrypted: i=1; AJvYcCWoA9136yP8CpMDJ89F1pQ+MYF9D88nVi1bsmv5Ipztt0aBSVCIHcZHwbnfIQtVzfp4nIaxAORZXbam2j7A@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1tsBUsTmnzqhGl/TPIMJJiK0zjD75Yc0UyLB+V5kP7v2enu2O
	ppkRiAikuRcgSnZYBvJD0Cjv+IusSWjcbnIm++aGYS3H+W6vd0hlkqtZZmmj8+8=
X-Google-Smtp-Source: AGHT+IGmsTYdyN8AnM0SFDW0KnEWUsE2KWdNV7xLu0WWRUc2MVy9WTK7gb9S/nVCr2balMC3xW7jWQ==
X-Received: by 2002:a05:600c:1e03:b0:42f:520b:1591 with SMTP id 5b1f17b1804b1-4311df474abmr30031205e9.24.1728672888171;
        Fri, 11 Oct 2024 11:54:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:13 +0200
Subject: [PATCH v7 14/17] ufs: core: add support for generating, importing
 and preparing keys
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-14-e3f7a752059b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+ALSGPhqSpFCx8VMqBEOHa6jvoZdtMRVH6U+tA0zR4E=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRgIa9JxS13dmB3BNLm5fvTras3dIpSag6X7
 iOgkq4b7OWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0YAAKCRARpy6gFHHX
 cv+EEADf3pf7OpbgUzzA0lbKqWbwldOeq01TQaRjRNSnIIGR9Pir/kkxjWn0wIojkhZLtqaRXdZ
 i6cbuaIfFzAbqGeGUNmocV4ivByw808djzRGDXZj5C/l9O0Ztf7Oulz+QvskdWsEmmLhgffrwNt
 MP/Z47wGvTnVQVsXGbIEyPZSX82eglF9A2u71/d0+Ozb2OjKpwMxAj0UEasybrj7K4+i9MGVTa2
 6JlU2kEB/3H1vhhysqZK5T78mKy2Prl97HwuTUgqm+yQ6QLeyyjKXbwWIWe/tG/ZJYUuhnf+cfR
 E7pphMtjVKPduJeEvBJU3ocdLgtCsiLBxS53CktanacXKOWGWDCkVVn2M2dK2nY6l3YKh7KnQHM
 VJxRQoQffBcRXUNbhgfUtiaF1Hq3ZE6OVtGBmFUH/1OlE10cn2eEeWmhJ/rS5oBkcajHBvHCwAG
 2e1hR41YzEjaKMs1GXbm3nJTI5ogUwQ9gAtur2KYXkd6NSOVy0VeZKfk6mG2/ZzFz9zP7g2EZce
 lpaXSpe24sTH4DE8/e0OXNRxb/LM0B3U6Klpsf2zUKXvfc1tUo7SXpVKPuGAxs8fjXDxBm6ezhH
 ab1ZdLu+2XbyoeTs8wAf4xThVS+VVcFDIwYRCMOiG8FEOiBFAn1Rn8/S/tA/XcvAwQirGxP58ML
 bS1eVfDWvezVEww==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

The block layer now allows storage controllers to implement the
operations for handling wrapped keys. We can now extend the UFS core to
also support them by reaching into the block layer. Add hooks
corresponding with the existing crypto operations lower on the stack.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/core/ufshcd-crypto.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index 2530239d42af..49c0784f2432 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -145,10 +145,51 @@ bool ufshcd_crypto_enable(struct ufs_hba *hba)
 	return true;
 }
 
+static int ufshcd_crypto_generate_key(struct blk_crypto_profile *profile,
+				      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->generate_key)
+		return hba->vops->generate_key(hba, lt_key);
+
+	return -EOPNOTSUPP;
+}
+
+static int ufshcd_crypto_prepare_key(struct blk_crypto_profile *profile,
+				     const u8 *lt_key, size_t lt_key_size,
+				     u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->prepare_key)
+		return hba->vops->prepare_key(hba, lt_key, lt_key_size, eph_key);
+
+	return -EOPNOTSUPP;
+}
+
+static int ufshcd_crypto_import_key(struct blk_crypto_profile *profile,
+				    const u8 *imp_key, size_t imp_key_size,
+				    u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->import_key)
+		return hba->vops->import_key(hba, imp_key, imp_key_size, lt_key);
+
+	return -EOPNOTSUPP;
+}
+
 static const struct blk_crypto_ll_ops ufshcd_crypto_ops = {
 	.keyslot_program	= ufshcd_crypto_keyslot_program,
 	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
 	.derive_sw_secret	= ufshcd_crypto_derive_sw_secret,
+	.generate_key		= ufshcd_crypto_generate_key,
+	.prepare_key		= ufshcd_crypto_prepare_key,
+	.import_key		= ufshcd_crypto_import_key,
 };
 
 static enum blk_crypto_mode_num

-- 
2.43.0


