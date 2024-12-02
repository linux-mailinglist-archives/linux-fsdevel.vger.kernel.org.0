Return-Path: <linux-fsdevel+bounces-36239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF6E9E0156
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 13:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA30164E5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 12:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AE01FECBA;
	Mon,  2 Dec 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="o2MicrlE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79572200B9F
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140968; cv=none; b=NYl6NutM7vzp9P7Jk+ozdGkQEXCdysoPIXXPgNUFKi/9pTUW/aO8XS04JGj/IBWNQ0kas/rOdhxccguZ4Scx5K27GL3OPR8wAgQhwYM+Q6FZ5gD8HG1UZKkNE6zDPPJt57VXWEAYHAvZBz52g++PcVc+Pe0b7jdqqAHzDq82kAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140968; c=relaxed/simple;
	bh=Hgr5gnEcipo3iroC2Z35QugNVIgPPBWK9LcPRSXICLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R/AZiiGabrrfMitlP3jla1ep8dm7L8PDXRKeEA98xUZ8LaziOWOeC9/HpuFSOXhDzcsbkUzs/hNvcmpW+hI9kW3kiLT+JTscgxVJERA4OASYrSYXyLaTFyaV72liDwbrV0g7CbhDkyOPHXUDPiZIkXh8barYICRoRUwlZOQlQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=o2MicrlE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4349cc45219so37402085e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 04:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733140963; x=1733745763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbmHDTbdMbFLibDhFaSSw7kfgSGxZjF1PeLKMBpjXLU=;
        b=o2MicrlEmGada1xHjeb9RLjOKIbgd0k9N8f0XmC+TXKa4eAohwQ1mEcHnJHn2Z8QvA
         vMWiX9LbK02h31eV6cl3+y0tgQhxDjHklm/fTppyjmlzAVSNAL8ezdfH3OYAHLJ7Mt22
         6CPmYgXPcviEFt7SofhLNCflSDGrZPNKHoBEOEIa9fzTABbo//k2bwwcacISSCqT29hV
         hra1htghD4vjEjgW1DypOdOF2dByKTw/A+vSHNspXKGLRGvLOmLC7NcXdEUpGubVRfHA
         O5hKVGzpKJHWYL1SVVNTeuQnkNWrpE6lv5WjNcdrbgDlAlg0QFu5hG0GgcjAdqorp+Zm
         qd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140963; x=1733745763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbmHDTbdMbFLibDhFaSSw7kfgSGxZjF1PeLKMBpjXLU=;
        b=GkcCPHLqVxO8kKrZ4K14goUXRDd64GTYq/ZrIBc2xR6vws8pU0BY4KBz/bCmMdSk19
         QNkA4oPlEwjm3P2Irbj9w/0gSPKdDuzrOV6XI7mECFKXk7Kzo2lbL2KmAt7EhkBSOAwU
         sFSuM/sciCHLDVCZIVC5RYhFtPj3ZXltgjfpEF/XhCm+VTtwHevDGKhmsTrnZUoe63n0
         2FdtK0V1qxgFfrqczPqBelsOcQ5p1W8o3lnIfkfCUVCrDD4odFk+loH5+7xXKyxCgYe+
         KG7GAnXWPHXOWm3VH+YOumW5gc5ur1mfvQp1JWJT/V9voK4muoFD9G/ngdxRDTkkeWf3
         LuSA==
X-Forwarded-Encrypted: i=1; AJvYcCWKxtypGLxpJEwrYkX163IzEUgb6JVsjBfFrDriz2qoL378UDLlAT9i3nZQ4RKcYO7D3UH5FSsybBb0QMk2@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFFQNhXUZDEJJxIoN2hzOcWAgFh3tFYRQpD+feXv9Qv7v4rNt
	1XNuhA/KVVDGhUJyjjhBCyPLdhpmr3L+5myKpcEpwaf9gx/4xfETH+emrNyXlHk=
X-Gm-Gg: ASbGncs3iKs4plxDnp+ErXGclXJ6VUxNLWy+HHrVFecn7HwgpDLkDzWjgAGP8qgjFod
	uIwULkc+QfOY2bfMnMS2Qgvh61SQwAc3SKGiKNHAl45MIW0HUd/3RWMNENbRYZ7zlreXrYUSByf
	pk0LJ/5PXQunHyHYFVxr/Jn1+00WYuwkIa2TNJVItgcE8yZgnd/TuRFQ2l3MCIAH68umjAS0FVE
	IQwCtfhZfHcyJFxNMqF29XCRmWt5I+OurRK/Zfn
X-Google-Smtp-Source: AGHT+IHaPui7+q4ZFmgBdHckntm6x5uHCL4yx9ak/3SvbuzD88H1/SeN3aoXoB92x7+chgCt+jsCSQ==
X-Received: by 2002:a05:6000:18a3:b0:385:e8b0:df11 with SMTP id ffacd0b85a97d-385e8b0e037mr4813389f8f.37.1733140960834;
        Mon, 02 Dec 2024 04:02:40 -0800 (PST)
Received: from [127.0.1.1] ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm152396095e9.8.2024.12.02.04.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:02:40 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 02 Dec 2024 13:02:19 +0100
Subject: [PATCH RESEND v7 03/17] blk-crypto: add ioctls to create and
 prepare hardware-wrapped keys
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-wrapped-keys-v7-3-67c3ca3f3282@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Eric Biggers <ebiggers@google.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=18924;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=XVd9BEBUqKhLheLfRrJQYUbVZgWWUoQ/WAiYDGJYj6w=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTaHSa2hKCjXqvabjMLfRi1dsmvc7YNcl8wsX1
 I0DkwyKkouJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ02h0gAKCRARpy6gFHHX
 coGzEACUO+jaQcPhr8E6oxRlGwkw9b+JvHcQpbWY9j8wPCJfuKdXYvHSLP5vV4JxI721pS5rYcq
 G96xHSiIQao+tNxOSAx06J8WOamGv78zpJXg2pGiml0sEOn+YIA9u7Zf4V9M162TFaLs23AFDnv
 R3AiORGGDUi+001ct+K8PPro4TqhOlI0uSC49/OZEoas98Eb/j++2Rq7EN6xudHQyvZXAc87gCp
 pxfa4V39LwVgqsJc7DYyWyxUOqEffJymZK/eRF1DwRY+hOtVrADwEKRZHMagMNvf0abNVVpHKpz
 SehAoND/x7ge1Aj4St70C5ZNndzvNvQwLh1rJNTVll5LKVlN6BRdcLPKos0Q0rjj6wyobnz8JNe
 SGfnOxG0KqDtDInBr5HjE9/fqgzRCKijrAtCS7FhA3z/72IXpkv41lrbH+MAqff7pcIsXFPMJ1v
 o+Dpxbs0jvbj+BXwYT04v7JbTowmvM5G+ug4rbzOLcIBy+29ZH1QMprdgtHlEVVNRdNIJCMQ+wA
 mbC7+u6hhNUmrc5aINayi4I1QZeEoDaHdDPhePZAW1GACY52E9qj9OXh4DGB5EbbI6SosxfbMTU
 wIwOMfWEuY2MYl56hoqmLUMcyTL6gHk+Do4g68QFU3D2PRRmDI8/x/Qj7p8sNdIIha9NPaE+odx
 c7MK67qEoL9y8oQ==
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
index 07218455a2bc3..e31b32495f66f 100644
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
index 243f1f1b554a2..b9d385e3c7bc5 100644
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
index 1893df9a8f06c..ccf6dff6ff6be 100644
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
index 1b92276ed2fcc..f6419502fcbee 100644
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
index 5a09d0ef1a011..2270a88e2e4d8 100644
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
index 6554b728bae6a..faa40f383e273 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -15,6 +15,7 @@
 #include <linux/io_uring/cmd.h>
 #include <uapi/linux/blkdev.h>
 #include "blk.h"
+#include "blk-crypto-internal.h"
 
 static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
@@ -620,6 +621,10 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
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
index 229287a7f451f..a3eef098f3c3d 100644
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
index 19066d86ecbf7..e61008c236688 100644
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
index 0000000000000..97302c6eb6afe
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
index 7539717707337..07180da44e13d 100644
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
2.45.2


