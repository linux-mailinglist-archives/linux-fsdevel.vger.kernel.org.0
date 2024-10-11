Return-Path: <linux-fsdevel+bounces-31755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018B399ABC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 20:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADB7285CE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F7C1D0E18;
	Fri, 11 Oct 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="E9TVMWUZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592E81D0486
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672876; cv=none; b=GxqATlxg6FhMFrYxLGIkNw6/+hSwHjw40d7TtsmT/FR/Xz1uAo5CvFfQahi9RSdZyespEag9FIxUDTKH4OLfX4ueCkwkuN/aN44roUUp6I55bICcEo5YND6EVPd8fFF46faFGV5hVoBmSOAZasO2zoHo6zm4dGAzWtuOB3G6NF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672876; c=relaxed/simple;
	bh=za3FqIs6l3A0GlQOys3rroJhcgTO/d1pbCP527ykGsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knOPBmcP+b5Vj1CBMGDtgWpZrB+U0FEH8jf5OZ8GvRsEQRgS3+p2QRG9ajefoT9DmD/T7CSxKfvQZaUEeTQvl4wS7aHxdV54DTwKspjyNhXlz0TKvxQrBZv2cuM7zHV4rlPsOkvT6TO4rXprA1epb22KOXmWoQHpIkMsYVGrC9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=E9TVMWUZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so1311487f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672871; x=1729277671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctH3KG1aiWPWTHNhRvJUzPlU5rBlfdSFSxiEIs7iqRM=;
        b=E9TVMWUZikKi9Mcosot+4wQmvEyMq5aFE5v/qS6QT4W/NDyZ8QRyM2iX44Q+6mqalk
         lb4UnnaQeYI7IrWosdkDQPOmdijaOPmkTnxYwbcjnH4T2hOIFfWqxbVpVXZtngOq19Ro
         vhERqCI9Z+Tz5Ypb+z0nTcVuW2KJ/QZFJ+ZIy1kXg2UYZ2ERn9KHYySinQav5MZLpN6t
         Fuy1nyhhcQqiKWDCXW6CJet0VIuJXZEh+x8vYuGkkN2VfFqlKYs004XhRWqytEe7GfVy
         JDzfhJstXytm7qQQodp4fxXWf0XQaT/GPinDjPhV4F6IUbSyKrDuBDOmlD3rB1kEK6ky
         ZluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672871; x=1729277671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctH3KG1aiWPWTHNhRvJUzPlU5rBlfdSFSxiEIs7iqRM=;
        b=D0PS0avFEdc/EwepXP3vv36rw06wN9bcXdI6ayWZA1L0WNUEZpbGG8vWaS3oigXJMx
         cDa5kA1gVN6VFH2AlQ2r380mJDT03V9e+yJ8QuaNLogU3bh1HLDdcEcu7S130E2iGgxu
         bgcSLFuRshU3ji5St3QSKBCbpIZMwnKxLEO8u+ONK0GEiI3NKPdKXNl5GQn37IFE8+Oy
         ljn/IZl7ldXeTGNvX65IcFZAPX9qmOQrO1WqVcmdmE36ECgUE2jC9YlQiHkasqaaEPBg
         TxY513orfjzJdRgLHYV6PbrN0HCiclA5qEtlTnMU6dP3EZ36vYqr7BfX10igezZPQh3a
         tl7g==
X-Forwarded-Encrypted: i=1; AJvYcCWDoKvobTpC6pAXm/uD/yflJ6mPFZDZGYt9mS4sPz0jLjTgUCkLITXCWFTxw9zI3EapARqWpRqHhXvVnyfs@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1qOz6erEDyRPl2nEsgg6xffRA9oQf6w/99yUE9VmgU/uR8Md
	b951Ayt3OxUiCfW7N6B96zeh9XXpg951w7kLzxmrUKuxL/V/T8Kfbc89McSYhow=
X-Google-Smtp-Source: AGHT+IG7JpCI6V/MnvYgZESExnjCaqd/GAeI4zIesbe5/XMxk7lQMRraA7K1J4T1hhi/1XI4HQC0AA==
X-Received: by 2002:a5d:634d:0:b0:37d:398f:44f9 with SMTP id ffacd0b85a97d-37d551f18d7mr2162400f8f.32.1728672870869;
        Fri, 11 Oct 2024 11:54:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:01 +0200
Subject: [PATCH v7 02/17] blk-crypto: show supported key types in sysfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-2-e3f7a752059b@linaro.org>
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
 Eric Biggers <ebiggers@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4301;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=b6piOxzlLcwilVcWi2g0mCoEhWsO2FMY5bdLYC4pykI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRcwb8CwHnlERpb2vBtGhi0iUArvclzP5VMM
 r1D1iAUAPCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0XAAKCRARpy6gFHHX
 ct+MD/4h/CD8h0oMKpUH1XiUAyIuOy6ds88Tg1MRjbQAr6GosMtmokMH5OE30nKz6UxclLdusrL
 8kzLMr9OYhWZbDjYGyO12JPeddrFj6SDdslyS3nwT7NBXHa9fLEovMDZtLxaWu+YMnICJgd6Uwx
 nYmZHhwoe7rUF4aKt0sCRO6VEUE8igjlCjiyHBkxE9KZKvHZkUvIAP7Kjue3OUolsCA/YRhsqHl
 q2GeTpDa7ahblMvFfGlLSBp2s9G5gQNuZ8kPv1exqyH9B3dsk1XMxEeh54HxzEn7RDlNcSTuf/H
 KSrNjwLWS2FUQG3EYkebk17ikT1Eo178FGg+bIa9Kzp9nN5DC321zfGah4lft9ZkmkzDuoolo17
 v5Kkbu77ELa0NjhjvXTJotMjLUgJ1C7qq403b8q1ebYtBszKsZ7Mhw+7KhcKfpgH8s82H2EI9Xy
 03XfQ8DMwlSYeRDVxLiNfa8kkzOPSYVl7vYw6/XCp6a0qnScnWQTNaLtBo0wnnRXPIkI7T4W7/4
 kyFEaodml6vfS+ipYCNMZ0IJtpUO0Swjh1SQabvyR6lrJW6TtTFq6RGYYgWCEs0UF7roUPEdzLy
 6A0ppgxETuGELwHPCBbSC5ElSQ1EpznXv8W5qRM7FJXFjHBwQlq5ed3WxAMJI75O/a97teOAI4X
 cZzeVBLdHqOoxvg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Eric Biggers <ebiggers@google.com>

Add sysfs files that indicate which type(s) of keys are supported by the
inline encryption hardware associated with a particular request queue:

	/sys/block/$disk/queue/crypto/hw_wrapped_keys
	/sys/block/$disk/queue/crypto/standard_keys

Userspace can use the presence or absence of these files to decide what
encyption settings to use.

Don't use a single key_type file, as devices might support both key
types at the same time.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/ABI/stable/sysfs-block | 18 ++++++++++++++++++
 block/blk-crypto-sysfs.c             | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 835361110715..4f368a7fa621 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -229,6 +229,16 @@ Description:
 		encryption, refer to Documentation/block/inline-encryption.rst.
 
 
+What:		/sys/block/<disk>/queue/crypto/hw_wrapped_keys
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] The presence of this file indicates that the device
+		supports hardware-wrapped inline encryption keys, i.e. key blobs
+		that can only be unwrapped and used by dedicated hardware.  For
+		more information about hardware-wrapped inline encryption keys,
+		see Documentation/block/inline-encryption.rst.
+
+
 What:		/sys/block/<disk>/queue/crypto/max_dun_bits
 Date:		February 2022
 Contact:	linux-block@vger.kernel.org
@@ -267,6 +277,14 @@ Description:
 		use with inline encryption.
 
 
+What:		/sys/block/<disk>/queue/crypto/standard_keys
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] The presence of this file indicates that the device
+		supports standard inline encryption keys, i.e. keys that are
+		managed in raw, plaintext form in software.
+
+
 What:		/sys/block/<disk>/queue/dax
 Date:		June 2016
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-crypto-sysfs.c b/block/blk-crypto-sysfs.c
index a304434489ba..acab50493f2c 100644
--- a/block/blk-crypto-sysfs.c
+++ b/block/blk-crypto-sysfs.c
@@ -31,6 +31,13 @@ static struct blk_crypto_attr *attr_to_crypto_attr(struct attribute *attr)
 	return container_of(attr, struct blk_crypto_attr, attr);
 }
 
+static ssize_t hw_wrapped_keys_show(struct blk_crypto_profile *profile,
+				    struct blk_crypto_attr *attr, char *page)
+{
+	/* Always show supported, since the file doesn't exist otherwise. */
+	return sysfs_emit(page, "supported\n");
+}
+
 static ssize_t max_dun_bits_show(struct blk_crypto_profile *profile,
 				 struct blk_crypto_attr *attr, char *page)
 {
@@ -43,20 +50,48 @@ static ssize_t num_keyslots_show(struct blk_crypto_profile *profile,
 	return sysfs_emit(page, "%u\n", profile->num_slots);
 }
 
+static ssize_t standard_keys_show(struct blk_crypto_profile *profile,
+				  struct blk_crypto_attr *attr, char *page)
+{
+	/* Always show supported, since the file doesn't exist otherwise. */
+	return sysfs_emit(page, "supported\n");
+}
+
 #define BLK_CRYPTO_RO_ATTR(_name) \
 	static struct blk_crypto_attr _name##_attr = __ATTR_RO(_name)
 
+BLK_CRYPTO_RO_ATTR(hw_wrapped_keys);
 BLK_CRYPTO_RO_ATTR(max_dun_bits);
 BLK_CRYPTO_RO_ATTR(num_keyslots);
+BLK_CRYPTO_RO_ATTR(standard_keys);
+
+static umode_t blk_crypto_is_visible(struct kobject *kobj,
+				     struct attribute *attr, int n)
+{
+	struct blk_crypto_profile *profile = kobj_to_crypto_profile(kobj);
+	struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
+
+	if (a == &hw_wrapped_keys_attr &&
+	    !(profile->key_types_supported & BLK_CRYPTO_KEY_TYPE_HW_WRAPPED))
+		return 0;
+	if (a == &standard_keys_attr &&
+	    !(profile->key_types_supported & BLK_CRYPTO_KEY_TYPE_STANDARD))
+		return 0;
+
+	return 0444;
+}
 
 static struct attribute *blk_crypto_attrs[] = {
+	&hw_wrapped_keys_attr.attr,
 	&max_dun_bits_attr.attr,
 	&num_keyslots_attr.attr,
+	&standard_keys_attr.attr,
 	NULL,
 };
 
 static const struct attribute_group blk_crypto_attr_group = {
 	.attrs = blk_crypto_attrs,
+	.is_visible = blk_crypto_is_visible,
 };
 
 /*

-- 
2.43.0


