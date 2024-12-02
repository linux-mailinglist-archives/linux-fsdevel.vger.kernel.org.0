Return-Path: <linux-fsdevel+bounces-36235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6326F9E013A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 13:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238A928103E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E855E1FE47D;
	Mon,  2 Dec 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pv4PGMIj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB41FE468
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140959; cv=none; b=pDwhABqlHoikoq7W68Gw7TjIcqAGI9AuJrZnmTx+/GqePk6Sg1uH245SHiZcqU2t69PrhNE8A6KEazjUDFzhgb+boAntr9j68jWSzOUVAL8i3BBObD9YB8DousN3DatKq1+IVDv/BfXJJ/PoxQu15t4QBVWNfJGKuqpByn3MShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140959; c=relaxed/simple;
	bh=ZglotLJcR4CCLrQDhLbSQD6rQEmc166vGenhEoZLUSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a3+EJb1MkyXjwc9A2/fKmjyLeS0RoTwfyux/94CTFc7HDN6EY3PQx44cbUyrxtX1/Fxmr048l2aBmlYZGu6dqA8S0c6sYqL6ZdpFiaOa1KbS66P2TDWBjy+F9Uhg3srdwRURbkwOCllqbQ3VL7UMZA6bVhpXE1Q/fmLJpvdWbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pv4PGMIj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434aa222d96so52627465e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 04:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733140955; x=1733745755; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BwRMKTWFRP1q9coxB3M1v3mwt7WbcpJ6EI+/1VsFCIU=;
        b=pv4PGMIjGVzehQXAKmn8lt9VZJw9hgvL3CYb5vfFtrbUzx+kMFKZsdtTs2HaQGSAxN
         C/ouE2TBA973NPAbto6bzFa54tXz09YKx58yVr8WlKTfDJhod0tC1nXlji7ZlwsKmDnB
         L1tfRHWR0g6/HNi4yaW6UgNmn9KStCF7/3axG3OBUkrBSiScoZkROqQ/SUXx1dkmf75Q
         McbmSGpgOB3rwSYRc4wgYjdUzJzOe/gD1V+rX+lClG2oWaH1JrkZ/tQhKklgnECL/49C
         CbM8vEZxDk6EkYkdpO4w58DqoATWhXjJ3sPtosGfnCEb/75QDZtaK3MucnfRFFmHLBt9
         wBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140955; x=1733745755;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwRMKTWFRP1q9coxB3M1v3mwt7WbcpJ6EI+/1VsFCIU=;
        b=QYeZbdwaZgf7YrUGvKpzANyauNH49NRxofVFfOkgfhrnhqD+dvyyUnemIX3BfJhiJD
         5cjVfz8MRXAmnwkgtCbXFLZylScITejExTNqKaQHktum33ZFaZMoc38YXx2krDql5bOa
         BU5WlhFa4JB1u12RKiUHK/QZYttr4Qq9jN39mm3oAyOju58/fPGykIRx6IIR9v8PT+Ti
         Xm1mgnaeP9bCMOkKI9VP1DFKddBXafu7geGVV7Tp+7XxS3zBiriTSQPOhDGXXgyVC5Ya
         kWC9U92wvg6H8nLnntCAEZB2IWneMPoyX3QoBhXWFKEo3jWVe1ZYaRytipjihL9VNAqz
         Eahg==
X-Forwarded-Encrypted: i=1; AJvYcCU4st/INweSvigqbs9HhJiMy/d8SZZlzz2UsD9U+M69ZhnPbTZjUea06vXRR1MGt3p3f0ZDOZfXil8GUfok@vger.kernel.org
X-Gm-Message-State: AOJu0YyYG81TQum7cUsSh3SwU2talzqw5tRJzaulCPoKNJCvM7DptNIg
	Oy6G5d2AHjerS0zo8StvA0JNvu1if/HTTXw1g8Ugo5Zf+V8e/g6o7kGVznpyRK0=
X-Gm-Gg: ASbGnctCcu1Umw38/OtEgw3z/suw96RMpH9hN42SaNNdjrS/seY4tykpSYoCcPBl17B
	wjWuG9vb6taEDg8M1PLlcQFyHZQ72/H3rFKw+dehaZD4VNPun2H2jbhuOWWm19wqtXRxXSIUp+y
	LtDrZh84xOrRHKJxEWaohQXQqqhCaJzzolTPiPaOtbrflQN5B3TdavJVe3jIGT1y5RJYPvZ339q
	lIrT8Y84NQQYJGVpsUoeM48ach6JTB2xtwfOdIL
X-Google-Smtp-Source: AGHT+IG639mbdzAHWP2DbKvYV8dhWM2aiaprOJRaSX8I9eR3/MuLfcl1PvByIItZ0GmIJy8PtDKPTA==
X-Received: by 2002:a05:600c:4447:b0:428:d31:ef25 with SMTP id 5b1f17b1804b1-434a9dc3b0fmr246493455e9.12.1733140953439;
        Mon, 02 Dec 2024 04:02:33 -0800 (PST)
Received: from [127.0.1.1] ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm152396095e9.8.2024.12.02.04.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:02:32 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH RESEND v7 00/17] Hardware wrapped key support for QCom ICE
 and UFS core
Date: Mon, 02 Dec 2024 13:02:16 +0100
Message-Id: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMmhTWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyML3fKixIKC1BTd7NTKYt1k80QjCwNzSyMDc1MloJaCotS0zAqwcdF
 KQa7Brn4uSrG1tQAvFgsKZgAAAA==
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
 Eric Biggers <ebiggers@google.com>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6871;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ZglotLJcR4CCLrQDhLbSQD6rQEmc166vGenhEoZLUSM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTaHRa18ROdZQjFJTxaA0nPXeMIaxxw81A+en5
 Xa+jWKXzY+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ02h0QAKCRARpy6gFHHX
 cjjCD/45TNWZBAXWMt1QWi7ezhpvBe7E1FjDYcqREEgy5UAnob/0qZG4X5vn5iXe4g7jMGAWerc
 Ltj0h1ESwY6I+lUSxuVhq0iZi9kb5vvDTHYiip8kKVJnApgV7bA95i4Mzd7VBoR1exOKB2e1bIq
 ohKVuMVxBvEVHvUbwmk19fn6JeMc8KUUKEbVE9jjqpZzIngJOTFTR6sR1GsF+HNfWspEzlzZeHL
 k4QBCT18CbSuQQOFmOYff7r6FYZJs16wS2h0jZ/9MJzoOg1sTiyCuCUFBGNFKSacWG0jq3u9XhS
 3xFwI/eFjG2UYAoEVe9vst4EMjY8cBg30dHW6wfcHoIpxLGpDQFlaTmnQYrwdxsuSLLxCONYPii
 2n/2f3Fn885Pv2O40tXJsvv8EV/lYbcKKjHjeg9vX9OkC4f/HW6rASCIGXZxf0BG9NRu9de9sx5
 f7cKXH287QRd5SCJ4fyoMr4jtscPM/8GJJxHlTmdAmdJlQIA7BVpq6VWX/h2FXYtFtgPfgge8Xa
 W00MzT7yduf0fovaR7q/tJFpyOWW49CvWGslJz2piCFMZwb9N41hagpkAJf90lUrgUXIGOlK8tb
 Yy/yzkrM+fSVng17cBbyByiLVnIeT7+e75AnucqiULf58P69ds5BUd5sWSAVNbUmFDfxA4MMMBM
 GUex2CUCg8bRwLw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

The previous iteration[1] has been on the list for many weeks without
receiving any comments - neither positive nor negative. If there are no
objections - could we start discussing how to make these patches go
upstream for v6.14?

--

Hardware-wrapped keys are encrypted keys that can only be unwrapped
(decrypted) and used by hardware - either by the inline encryption
hardware itself, or by a dedicated hardware block that can directly
provision keys to the inline encryption hardware. For more details,
please see patches 1-3 in this series which extend the inline encryption
docs with more information.

This series adds support for wrapped keys to the block layer, fscrypt
and then build upwards from there by implementing relevant callbacks in
QCom SCM driver, then the ICE driver and finally in UFS core and QCom
layer.

Tested on sm8650-qrd.

How to test:

Use the wip-wrapped-keys branch from https://github.com/ebiggers/fscryptctl
to build a custom fscryptctl that supports generating wrapped keys.

Enable the following config options:
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_QCOM_INLINE_CRYPTO_ENGINE=m
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
CONFIG_SCSI_UFS_CRYPTO=y

$ mkfs.ext4 -F -O encrypt,stable_inodes /dev/disk/by-partlabel/userdata
$ mount /dev/disk/by-partlabel/userdata -o inlinecrypt /mnt
$ fscryptctl generate_hw_wrapped_key /dev/disk/by-partlabel/userdata > /mnt/key.longterm
$ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/userdata < /mnt/key.longterm > /tmp/key.ephemeral
$ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
$ rm -rf /mnt/dir
$ mkdir /mnt/dir
$ fscryptctl set_policy --hw-wrapped-key --iv-ino-lblk-64 "$KEYID" /mnt/dir
$ dmesg > /mnt/dir/test.txt
$ sync

Reboot the board

$ mount /dev/disk/by-partlabel/userdata -o inlinecrypt /mnt
$ ls /mnt/dir
$ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/userdata < /mnt/key.longterm > /tmp/key.ephemeral
$ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
$ fscryptctl set_policy --hw-wrapped-key --iv-ino-lblk-64 "$KEYID" /mnt/dir
$ cat /mnt/dir/test.txt # File should now be decrypted

[1] https://lore.kernel.org/all/20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org/

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v7:
- use a module param in conjunction with checking the platform support
  at run-time to determine whether to use wrapped keys in the ICE driver
- various minor refactorings, replacing magic numbers with defines etc.
- fix kernel doc issues raised by autobuilders
- Link to v6: https://lore.kernel.org/r/20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org

Changes in v6:
- add the wrapped key support from Eric Biggers to the series
- remove the new DT property from the series and instead query the
  at run-time rustZone to find out if wrapped keys are supported
- make the wrapped key support into a UFS capability, not a quirk
- improve kerneldocs
- improve and rework coding style in most patches
- improve and reformat commit messages
- simplify the offset calculation for CRYPTOCFG
- split out the DTS changes into a separate series

---
Bartosz Golaszewski (1):
      firmware: qcom: scm: add a call for checking wrapped key support

Eric Biggers (4):
      blk-crypto: add basic hardware-wrapped key support
      blk-crypto: show supported key types in sysfs
      blk-crypto: add ioctls to create and prepare hardware-wrapped keys
      fscrypt: add support for hardware-wrapped keys

Gaurav Kashyap (12):
      ice, ufs, mmc: use the blk_crypto_key struct when programming the key
      firmware: qcom: scm: add a call for deriving the software secret
      firmware: qcom: scm: add calls for creating, preparing and importing keys
      soc: qcom: ice: add HWKM support to the ICE driver
      soc: qcom: ice: add support for hardware wrapped keys
      soc: qcom: ice: add support for generating, importing and preparing keys
      ufs: core: add support for wrapped keys to UFS core
      ufs: core: add support for deriving the software secret
      ufs: core: add support for generating, importing and preparing keys
      ufs: host: add support for wrapped keys in QCom UFS
      ufs: host: add a callback for deriving software secrets and use it
      ufs: host: add support for generating, importing and preparing wrapped keys

 Documentation/ABI/stable/sysfs-block               |  18 +
 Documentation/block/inline-encryption.rst          | 245 +++++++++++++-
 Documentation/filesystems/fscrypt.rst              | 154 ++++++++-
 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
 block/blk-crypto-fallback.c                        |   5 +-
 block/blk-crypto-internal.h                        |  10 +
 block/blk-crypto-profile.c                         | 103 ++++++
 block/blk-crypto-sysfs.c                           |  35 ++
 block/blk-crypto.c                                 | 194 ++++++++++-
 block/ioctl.c                                      |   5 +
 drivers/firmware/qcom/qcom_scm.c                   | 233 +++++++++++++
 drivers/firmware/qcom/qcom_scm.h                   |   4 +
 drivers/md/dm-table.c                              |   1 +
 drivers/mmc/host/cqhci-crypto.c                    |   9 +-
 drivers/mmc/host/cqhci.h                           |   2 +
 drivers/mmc/host/sdhci-msm.c                       |   6 +-
 drivers/soc/qcom/ice.c                             | 365 ++++++++++++++++++++-
 drivers/ufs/core/ufshcd-crypto.c                   |  86 ++++-
 drivers/ufs/host/ufs-qcom.c                        |  61 +++-
 fs/crypto/fscrypt_private.h                        |  71 +++-
 fs/crypto/hkdf.c                                   |   4 +-
 fs/crypto/inline_crypt.c                           |  44 ++-
 fs/crypto/keyring.c                                | 124 +++++--
 fs/crypto/keysetup.c                               |  54 ++-
 fs/crypto/keysetup_v1.c                            |   5 +-
 fs/crypto/policy.c                                 |  11 +-
 include/linux/blk-crypto-profile.h                 |  73 +++++
 include/linux/blk-crypto.h                         |  75 ++++-
 include/linux/firmware/qcom/qcom_scm.h             |   8 +
 include/soc/qcom/ice.h                             |  18 +-
 include/uapi/linux/blk-crypto.h                    |  44 +++
 include/uapi/linux/fs.h                            |   6 +-
 include/uapi/linux/fscrypt.h                       |   7 +-
 include/ufs/ufshcd.h                               |  21 ++
 34 files changed, 1968 insertions(+), 135 deletions(-)
---
base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
change-id: 20241128-wrapped-keys-c7a280792075

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


