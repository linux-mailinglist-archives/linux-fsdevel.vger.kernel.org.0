Return-Path: <linux-fsdevel+bounces-28862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A37296FA94
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 20:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6671C1C24589
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 18:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1544E1DCB2B;
	Fri,  6 Sep 2024 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aC+u9vsT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E81D88B3
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646055; cv=none; b=fWn92XgJXEpxuAf9Yc0/7BcjYBrKla1x1wb6IBk0BfMdLet9ARP+aZKYhubXXcFligdsIGJaFig39vIJUJAx3RPojvuF3tVVYxzg6WwO4LN7b+MphB3vOe5dwPntEDHTd1FosTVcm93JnOYL4Ee6fphZJruvw/nCTy5JHnX1X6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646055; c=relaxed/simple;
	bh=K36z2WuBIGwsrVf3zhuB2he0VplkKuV85ChmTDvPANY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1JKm/nk2kkPKunN35cU9Kme8kxvf0XSLnQg+orvwDF0Eya9zsI3DQxZH41ja/3H0OxFerq8Y1j3fYxE/xKN4Vk0RpG1gr+BvjycCua/8YKOHXoGkESszO7DhUbpW/IfWO/0qClSinBIKNQdCJMYQccz229y0WB1x5+ayCQt/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aC+u9vsT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c180d123so1264455f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725646050; x=1726250850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XJXl52eLkVj+sANAtaj9+Yw4klLLGFdj3hisQeIOrA=;
        b=aC+u9vsTU7v/Vob3Nc2trV/sYLOSeZ7vovLtgWpnMTc2Ys1Lt+VctNg/+gSIpNK5/m
         BfoR5XZT6MUgr5wAhHoOoX4ehCOhTMj3ZG1U0Ny0T1dRk8DNBIfP8dEXRmGg2KLdVHle
         LFoAXhETcjvU3/AcHZU6bGnocoGW9kTw3IrYW/BNdsefR/bcpUSPsPDO9bs/Ef6pW521
         +3EQdHXnFDGJVg/w5mqWxNtHchkTQk/LNGiCQe+0+wvJ/pwjLa59dQTg+X5Bn1kScI05
         0oDecjMDMacrZtaGF5Xx+ose771EJJgcHl7puG0jJVUl3A9RqWT/gacrhHg+nfhrd3ej
         A86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646050; x=1726250850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XJXl52eLkVj+sANAtaj9+Yw4klLLGFdj3hisQeIOrA=;
        b=sB+jNv8Vc7TLZvYhV7q+X/ZV4Kxn0vu1kUzWaDtwDvhF1c35y9S8RwHtKhm+nQnnmK
         f89W9kbW2PRd/slozob+PGgLnHXKuJjWq6fDEU3rg6DbxmHUrA04oxJfoMyG+CylVhUo
         L1H/ezSuRUl8ejSxj5B79dP+IMyB8pe5vGjlI1x3MEzoFB9Lo7UkBXSPOllTzpM9THec
         hRlL6RvI9KuPQgx0NmJxFimYPOtL2FAWx64b957yXr2q7VSiKnJIOpjZoEDNEcFa4nLS
         ABhn4R11KFo0vFoVUQEDXp/tPkkLRnfZ2IkykRYhXE1LItlVQCryY1COAk31CYfuYT/j
         THwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz5Q8ju1jJp5k+F3qiMYdc1dMdJ0f3yJq9I3RcpUj4uog2K6EkybE3dyEy3AWWthSDFVkQriYNgzPPDFCX@vger.kernel.org
X-Gm-Message-State: AOJu0YzFowFPa+NSwz/IzkZhiKphqdhsO+FsAnFoWaz4PMZoAaM8iYK7
	+UTtVIpsX0H3gdUifS6jUZ64aLmPqyDEUeCrDUiWZmTIkXBOKqfw1P+4YhaR0EM=
X-Google-Smtp-Source: AGHT+IHQsONZ/FTNIaZIz5xwZjVjfu9DazfNrYbZsG0iT6AG3CT9r4ZsItuhTtdVa2Hu4fTTJV6CgA==
X-Received: by 2002:adf:a3d5:0:b0:374:ca43:cda5 with SMTP id ffacd0b85a97d-374ca43cfb2mr10164571f8f.0.1725646049660;
        Fri, 06 Sep 2024 11:07:29 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cac8543dbsm5880485e9.42.2024.09.06.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:07:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 06 Sep 2024 20:07:06 +0200
Subject: [PATCH v6 03/17] blk-crypto: add ioctls to create and prepare
 hardware-wrapped keys
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-wrapped-keys-v6-3-d59e61bc0cb4@linaro.org>
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
 Eric Biggers <ebiggers@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18890;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=CDS3cdJGxKUTlVx2HhL4j99Ijp7cVRdzHB/MHjGguoY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm20TVMl6PrN0h+HbcZS/YKLL+d+/tOOx4e8+UX
 jkXMc4S7kOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZttE1QAKCRARpy6gFHHX
 coSlD/kBPFc1BrhabkOME+ybQF1CLVdNHm+Q13CURCYM4KGvCYQ0aHryumUfMCWsasDuespk3Bu
 AwoVD3avNVYexupBqcf8PXIDnMnCvcR9b3Jrmd+r2LIUUQGHD5grGPRee9kbJmcCasYxqBdr13R
 n+QaKV5QcNsR5UamHIkAfQQlE3VXOhv4njd2+44uaEN+roosz1DgvTYvca2rib5QizlOAQda7dZ
 oN+SUGRN9pwHo5mASQWok/wcSb2u04Pz5utkVqW+NOmaE0Hvx5ItT0Gf+denarsRNww1K+1GxU4
 GECQF9ltD6bdNL//KKAxUXzOvoZ/ws1vHzEqf9zJfxFzGwFTsuYfkvpLV9pbx5+fPWRQI4F5dvq
 NCJRXWL/Pkkgf+EnrTfWRqJX2OQJo68y27jYJPc9CmOfPKbuX6hiTtYWiuNeMZA/RUJxiuEH3x1
 XNwGxE9wH5FViCsk8IsepOc3Gst7xeIaaau2oh52IdMQv+Me7e/7/ApT6/3DH+0h6JnUt1xm9Nz
 X+xw2QhoWBr/1hwr7p8shye3/X+yUdfYIumGsNetzor0C4fAzeCajkrJuiMqpoLnf8eP/f5vNkp
 SfujYtdLCxkgxt3oNLZFjzSXYo7ScwtG2d3CZqGhqZ+S+drfKgHZaIZaoKwecUy3EvAQyUiTuxi
 j28co2xd+6TbMEg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Eric Biggers <ebiggers@google.com>

Until this point, the kernel can use hardware-wrapped keys to do
encryption if userspace provides one -- specifically a key in
ephemerally-wrapped form.  However, no generic way has been provided for
userspace to get such a key in the first place.

Getting such a key is a two-step process.  First, the key needs to be
imported from a raw key or generated by the hardware, producing a key in
long-term wrapped form.  This happens once in the whole lifetime of the
key.  Second, the long-term wrapped key needs to be converted into
ephemerally-wrapped form.  This happens each time the key is "unlocked".

In Android, these operations are supported in a generic way through
KeyMint, a userspace abstraction layer.  However, that method is
Android-specific and can't be used on other Linux systems, may rely on
proprietary libraries, and also misleads people into supporting KeyMint
features like rollback resistance that make sense for other KeyMint keys
but don't make sense for hardware-wrapped inline encryption keys.

Therefore, this patch provides a generic kernel interface for these
operations by introducing new block device ioctls:

- BLKCRYPTOIMPORTKEY: convert a raw key to long-term wrapped form.

- BLKCRYPTOGENERATEKEY: have the hardware generate a new key, then
  return it in long-term wrapped form.

- BLKCRYPTOPREPAREKEY: convert a key from long-term wrapped form to
  ephemerally-wrapped form.

These ioctls are implemented using new operations in blk_crypto_ll_ops.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/block/inline-encryption.rst          |  32 +++++
 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
 block/blk-crypto-internal.h                        |   9 ++
 block/blk-crypto-profile.c                         |  57 ++++++++
 block/blk-crypto.c                                 | 143 +++++++++++++++++++++
 block/ioctl.c                                      |   5 +
 include/linux/blk-crypto-profile.h                 |  53 ++++++++
 include/linux/blk-crypto.h                         |   1 +
 include/uapi/linux/blk-crypto.h                    |  44 +++++++
 include/uapi/linux/fs.h                            |   6 +-
 10 files changed, 348 insertions(+), 4 deletions(-)

diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
index 07218455a2bc..e31b32495f66 100644
--- a/Documentation/block/inline-encryption.rst
+++ b/Documentation/block/inline-encryption.rst
@@ -486,6 +486,38 @@ keys, when hardware support is available.  This works in the following way:
 blk-crypto-fallback doesn't support hardware-wrapped keys.  Therefore,
 hardware-wrapped keys can only be used with actual inline encryption hardware.
 
+All the above deals with hardware-wrapped keys in ephemerally-wrapped form only.
+To get such keys in the first place, new block device ioctls have been added to
+provide a generic interface to creating and preparing such keys:
+
+- ``BLKCRYPTOIMPORTKEY`` converts a raw key to long-term wrapped form.  It takes
+  in a pointer to a ``struct blk_crypto_import_key_arg``.  The caller must set
+  ``raw_key_ptr`` and ``raw_key_size`` to the pointer and size (in bytes) of the
+  raw key to import.  On success, ``BLKCRYPTOIMPORTKEY`` returns 0 and writes
+  the resulting long-term wrapped key blob to the buffer pointed to by
+  ``lt_key_ptr``, which is of maximum size ``lt_key_size``.  It also updates
+  ``lt_key_size`` to be the actual size of the key.  On failure, it returns -1
+  and sets errno.
+
+- ``BLKCRYPTOGENERATEKEY`` is like ``BLKCRYPTOIMPORTKEY``, but it has the
+  hardware generate the key instead of importing one.  It takes in a pointer to
+  a ``struct blk_crypto_generate_key_arg``.
+
+- ``BLKCRYPTOPREPAREKEY`` converts a key from long-term wrapped form to
+  ephemerally-wrapped form.  It takes in a pointer to a ``struct
+  blk_crypto_prepare_key_arg``.  The caller must set ``lt_key_ptr`` and
+  ``lt_key_size`` to the pointer and size (in bytes) of the long-term wrapped
+  key blob to convert.  On success, ``BLKCRYPTOPREPAREKEY`` returns 0 and writes
+  the resulting ephemerally-wrapped key blob to the buffer pointed to by
+  ``eph_key_ptr``, which is of maximum size ``eph_key_size``.  It also updates
+  ``eph_key_size`` to be the actual size of the key.  On failure, it returns -1
+  and sets errno.
+
+Userspace needs to use either ``BLKCRYPTOIMPORTKEY`` or ``BLKCRYPTOGENERATEKEY``
+once to create a key, and then ``BLKCRYPTOPREPAREKEY`` each time the key is
+unlocked and added to the kernel.  Note that these ioctls have no relevance for
+standard keys; they are only for hardware-wrapped keys.
+
 Testability
 -----------
 
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index e4be1378ba26..dad55a26cd5a 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -85,6 +85,8 @@ Code  Seq#    Include File                                           Comments
 0x10  20-2F  arch/s390/include/uapi/asm/hypfs.h
 0x12  all    linux/fs.h                                              BLK* ioctls
              linux/blkpg.h
+             linux/blkzoned.h
+             linux/blk-crypto.h
 0x15  all    linux/fs.h                                              FS_IOC_* ioctls
 0x1b  all                                                            InfiniBand Subsystem
                                                                      <http://infiniband.sourceforge.net/>
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 1893df9a8f06..ccf6dff6ff6b 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -83,6 +83,9 @@ int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
 bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
 				const struct blk_crypto_config *cfg);
 
+int blk_crypto_ioctl(struct block_device *bdev, unsigned int cmd,
+		     void __user *argp);
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline int blk_crypto_sysfs_register(struct gendisk *disk)
@@ -130,6 +133,12 @@ static inline bool blk_crypto_rq_has_keyslot(struct request *rq)
 	return false;
 }
 
+static inline int blk_crypto_ioctl(struct block_device *bdev, unsigned int cmd,
+				   void __user *argp)
+{
+	return -ENOTTY;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 1b92276ed2fc..f6419502fcbe 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -502,6 +502,63 @@ int blk_crypto_derive_sw_secret(struct block_device *bdev,
 	return err;
 }
 
+int blk_crypto_import_key(struct blk_crypto_profile *profile,
+			  const u8 *raw_key, size_t raw_key_size,
+			  u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	int ret;
+
+	if (!profile)
+		return -EOPNOTSUPP;
+	if (!(profile->key_types_supported & BLK_CRYPTO_KEY_TYPE_HW_WRAPPED))
+		return -EOPNOTSUPP;
+	if (!profile->ll_ops.import_key)
+		return -EOPNOTSUPP;
+	blk_crypto_hw_enter(profile);
+	ret = profile->ll_ops.import_key(profile, raw_key, raw_key_size,
+					 lt_key);
+	blk_crypto_hw_exit(profile);
+	return ret;
+}
+
+int blk_crypto_generate_key(struct blk_crypto_profile *profile,
+			    u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	int ret;
+
+	if (!profile)
+		return -EOPNOTSUPP;
+	if (!(profile->key_types_supported & BLK_CRYPTO_KEY_TYPE_HW_WRAPPED))
+		return -EOPNOTSUPP;
+	if (!profile->ll_ops.generate_key)
+		return -EOPNOTSUPP;
+
+	blk_crypto_hw_enter(profile);
+	ret = profile->ll_ops.generate_key(profile, lt_key);
+	blk_crypto_hw_exit(profile);
+	return ret;
+}
+
+int blk_crypto_prepare_key(struct blk_crypto_profile *profile,
+			   const u8 *lt_key, size_t lt_key_size,
+			   u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	int ret;
+
+	if (!profile)
+		return -EOPNOTSUPP;
+	if (!(profile->key_types_supported & BLK_CRYPTO_KEY_TYPE_HW_WRAPPED))
+		return -EOPNOTSUPP;
+	if (!profile->ll_ops.prepare_key)
+		return -EOPNOTSUPP;
+
+	blk_crypto_hw_enter(profile);
+	ret = profile->ll_ops.prepare_key(profile, lt_key, lt_key_size,
+					  eph_key);
+	blk_crypto_hw_exit(profile);
+	return ret;
+}
+
 /**
  * blk_crypto_intersect_capabilities() - restrict supported crypto capabilities
  *					 by child device
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 5a09d0ef1a01..2270a88e2e4d 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -467,3 +467,146 @@ void blk_crypto_evict_key(struct block_device *bdev,
 		pr_warn_ratelimited("%pg: error %d evicting key\n", bdev, err);
 }
 EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
+
+static int blk_crypto_ioctl_import_key(struct blk_crypto_profile *profile,
+				       void __user *argp)
+{
+	struct blk_crypto_import_key_arg arg;
+	u8 raw_key[BLK_CRYPTO_MAX_STANDARD_KEY_SIZE];
+	u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE];
+	int ret;
+
+	if (copy_from_user(&arg, argp, sizeof(arg)))
+		return -EFAULT;
+
+	if (memchr_inv(arg.reserved, 0, sizeof(arg.reserved)))
+		return -EINVAL;
+
+	if (arg.raw_key_size < 16 || arg.raw_key_size > sizeof(raw_key))
+		return -EINVAL;
+
+	if (copy_from_user(raw_key, u64_to_user_ptr(arg.raw_key_ptr),
+			   arg.raw_key_size)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	ret = blk_crypto_import_key(profile, raw_key, arg.raw_key_size, lt_key);
+	if (ret < 0)
+		goto out;
+	if (ret > arg.lt_key_size) {
+		ret = -EOVERFLOW;
+		goto out;
+	}
+	arg.lt_key_size = ret;
+	if (copy_to_user(u64_to_user_ptr(arg.lt_key_ptr), lt_key,
+			 arg.lt_key_size) ||
+	    copy_to_user(argp, &arg, sizeof(arg))) {
+		ret = -EFAULT;
+		goto out;
+	}
+	ret = 0;
+
+out:
+	memzero_explicit(raw_key, sizeof(raw_key));
+	memzero_explicit(lt_key, sizeof(lt_key));
+	return ret;
+}
+
+static int blk_crypto_ioctl_generate_key(struct blk_crypto_profile *profile,
+					 void __user *argp)
+{
+	struct blk_crypto_generate_key_arg arg;
+	u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE];
+	int ret;
+
+	if (copy_from_user(&arg, argp, sizeof(arg)))
+		return -EFAULT;
+
+	if (memchr_inv(arg.reserved, 0, sizeof(arg.reserved)))
+		return -EINVAL;
+
+	ret = blk_crypto_generate_key(profile, lt_key);
+	if (ret < 0)
+		goto out;
+	if (ret > arg.lt_key_size) {
+		ret = -EOVERFLOW;
+		goto out;
+	}
+	arg.lt_key_size = ret;
+	if (copy_to_user(u64_to_user_ptr(arg.lt_key_ptr), lt_key,
+			 arg.lt_key_size) ||
+	    copy_to_user(argp, &arg, sizeof(arg))) {
+		ret = -EFAULT;
+		goto out;
+	}
+	ret = 0;
+
+out:
+	memzero_explicit(lt_key, sizeof(lt_key));
+	return ret;
+}
+
+static int blk_crypto_ioctl_prepare_key(struct blk_crypto_profile *profile,
+					void __user *argp)
+{
+	struct blk_crypto_prepare_key_arg arg;
+	u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE];
+	u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE];
+	int ret;
+
+	if (copy_from_user(&arg, argp, sizeof(arg)))
+		return -EFAULT;
+
+	if (memchr_inv(arg.reserved, 0, sizeof(arg.reserved)))
+		return -EINVAL;
+
+	if (arg.lt_key_size > sizeof(lt_key))
+		return -EINVAL;
+
+	if (copy_from_user(lt_key, u64_to_user_ptr(arg.lt_key_ptr),
+			   arg.lt_key_size)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	ret = blk_crypto_prepare_key(profile, lt_key, arg.lt_key_size, eph_key);
+	if (ret < 0)
+		goto out;
+	if (ret > arg.eph_key_size) {
+		ret = -EOVERFLOW;
+		goto out;
+	}
+	arg.eph_key_size = ret;
+	if (copy_to_user(u64_to_user_ptr(arg.eph_key_ptr), eph_key,
+			 arg.eph_key_size) ||
+	    copy_to_user(argp, &arg, sizeof(arg))) {
+		ret = -EFAULT;
+		goto out;
+	}
+	ret = 0;
+
+out:
+	memzero_explicit(lt_key, sizeof(lt_key));
+	memzero_explicit(eph_key, sizeof(eph_key));
+	return ret;
+}
+
+int blk_crypto_ioctl(struct block_device *bdev, unsigned int cmd,
+		     void __user *argp)
+{
+	struct blk_crypto_profile *profile =
+		bdev_get_queue(bdev)->crypto_profile;
+
+	if (!profile)
+		return -EOPNOTSUPP;
+
+	switch (cmd) {
+	case BLKCRYPTOIMPORTKEY:
+		return blk_crypto_ioctl_import_key(profile, argp);
+	case BLKCRYPTOGENERATEKEY:
+		return blk_crypto_ioctl_generate_key(profile, argp);
+	case BLKCRYPTOPREPAREKEY:
+		return blk_crypto_ioctl_prepare_key(profile, argp);
+	default:
+		return -ENOTTY;
+	}
+}
diff --git a/block/ioctl.c b/block/ioctl.c
index 44257bdfeacb..907f7faa2169 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -12,6 +12,7 @@
 #include <linux/pr.h>
 #include <linux/uaccess.h>
 #include "blk.h"
+#include "blk-crypto-internal.h"
 
 static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
@@ -604,6 +605,10 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
 		return blk_trace_ioctl(bdev, cmd, argp);
+	case BLKCRYPTOIMPORTKEY:
+	case BLKCRYPTOGENERATEKEY:
+	case BLKCRYPTOPREPAREKEY:
+		return blk_crypto_ioctl(bdev, cmd, argp);
 	case IOC_PR_REGISTER:
 		return blkdev_pr_register(bdev, mode, argp);
 	case IOC_PR_RESERVE:
diff --git a/include/linux/blk-crypto-profile.h b/include/linux/blk-crypto-profile.h
index 229287a7f451..a3eef098f3c3 100644
--- a/include/linux/blk-crypto-profile.h
+++ b/include/linux/blk-crypto-profile.h
@@ -71,6 +71,48 @@ struct blk_crypto_ll_ops {
 	int (*derive_sw_secret)(struct blk_crypto_profile *profile,
 				const u8 *eph_key, size_t eph_key_size,
 				u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
+
+	/**
+	 * @import_key: Create a hardware-wrapped key by importing a raw key.
+	 *
+	 * This only needs to be implemented if BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
+	 * is supported.
+	 *
+	 * On success, must write the new key in long-term wrapped form to
+	 * @lt_key and return its size in bytes.  On failure, must return a
+	 * -errno value.
+	 */
+	int (*import_key)(struct blk_crypto_profile *profile,
+			  const u8 *raw_key, size_t raw_key_size,
+			  u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+
+	/**
+	 * @generate_key: Generate a hardware-wrapped key.
+	 *
+	 * This only needs to be implemented if BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
+	 * is supported.
+	 *
+	 * On success, must write the new key in long-term wrapped form to
+	 * @lt_key and return its size in bytes.  On failure, must return a
+	 * -errno value.
+	 */
+	int (*generate_key)(struct blk_crypto_profile *profile,
+			    u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+
+	/**
+	 * @prepare_key: Prepare a hardware-wrapped key to be used.
+	 *
+	 * Prepare a hardware-wrapped key to be used by converting it from
+	 * long-term wrapped form to ephemerally-wrapped form.  This only needs
+	 * to be implemented if BLK_CRYPTO_KEY_TYPE_HW_WRAPPED is supported.
+	 *
+	 * On success, must write the key in ephemerally-wrapped form to
+	 * @eph_key and return its size in bytes.  On failure, must return a
+	 * -errno value.
+	 */
+	int (*prepare_key)(struct blk_crypto_profile *profile,
+			   const u8 *lt_key, size_t lt_key_size,
+			   u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
 };
 
 /**
@@ -163,6 +205,17 @@ void blk_crypto_reprogram_all_keys(struct blk_crypto_profile *profile);
 
 void blk_crypto_profile_destroy(struct blk_crypto_profile *profile);
 
+int blk_crypto_import_key(struct blk_crypto_profile *profile,
+			  const u8 *raw_key, size_t raw_key_size,
+			  u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+
+int blk_crypto_generate_key(struct blk_crypto_profile *profile,
+			    u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+
+int blk_crypto_prepare_key(struct blk_crypto_profile *profile,
+			   const u8 *lt_key, size_t lt_key_size,
+			   u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+
 void blk_crypto_intersect_capabilities(struct blk_crypto_profile *parent,
 				       const struct blk_crypto_profile *child);
 
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 19066d86ecbf..e61008c23668 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -7,6 +7,7 @@
 #define __LINUX_BLK_CRYPTO_H
 
 #include <linux/types.h>
+#include <uapi/linux/blk-crypto.h>
 
 enum blk_crypto_mode_num {
 	BLK_ENCRYPTION_MODE_INVALID,
diff --git a/include/uapi/linux/blk-crypto.h b/include/uapi/linux/blk-crypto.h
new file mode 100644
index 000000000000..97302c6eb6af
--- /dev/null
+++ b/include/uapi/linux/blk-crypto.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_BLK_CRYPTO_H
+#define _UAPI_LINUX_BLK_CRYPTO_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+struct blk_crypto_import_key_arg {
+	/* Raw key (input) */
+	__u64 raw_key_ptr;
+	__u64 raw_key_size;
+	/* Long-term wrapped key blob (output) */
+	__u64 lt_key_ptr;
+	__u64 lt_key_size;
+	__u64 reserved[4];
+};
+
+struct blk_crypto_generate_key_arg {
+	/* Long-term wrapped key blob (output) */
+	__u64 lt_key_ptr;
+	__u64 lt_key_size;
+	__u64 reserved[4];
+};
+
+struct blk_crypto_prepare_key_arg {
+	/* Long-term wrapped key blob (input) */
+	__u64 lt_key_ptr;
+	__u64 lt_key_size;
+	/* Ephemerally-wrapped key blob (output) */
+	__u64 eph_key_ptr;
+	__u64 eph_key_size;
+	__u64 reserved[4];
+};
+
+/*
+ * These ioctls share the block device ioctl space; see uapi/linux/fs.h.
+ * 140-141 are reserved for future blk-crypto ioctls; any more than that would
+ * require an additional allocation from the block device ioctl space.
+ */
+#define BLKCRYPTOIMPORTKEY _IOWR(0x12, 137, struct blk_crypto_import_key_arg)
+#define BLKCRYPTOGENERATEKEY _IOWR(0x12, 138, struct blk_crypto_generate_key_arg)
+#define BLKCRYPTOPREPAREKEY _IOWR(0x12, 139, struct blk_crypto_prepare_key_arg)
+
+#endif /* _UAPI_LINUX_BLK_CRYPTO_H */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..07180da44e13 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -203,10 +203,8 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
-/*
- * A jump here: 130-136 are reserved for zoned block devices
- * (see uapi/linux/blkzoned.h)
- */
+/* 130-136 are used by zoned block device ioctls (uapi/linux/blkzoned.h) */
+/* 137-141 are used by blk-crypto ioctls (uapi/linux/blk-crypto.h) */
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */

-- 
2.43.0


