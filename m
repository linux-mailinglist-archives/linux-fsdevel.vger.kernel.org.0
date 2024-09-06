Return-Path: <linux-fsdevel+bounces-28858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F496FA6E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 20:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A940D2851A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 18:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943601D7E4F;
	Fri,  6 Sep 2024 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dNnKs/3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1E1D47B9
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646048; cv=none; b=j3ag1wo+Q9DH4hbhGK8BL1sDQYFD0tptMWmeZ0H1bReDPoLOrdoQ3+GZecMLLtSeCxg1G9dEHjW0EMfxlOvPD2e379B5IBBvsWl1pkNK8fTVWyMvqmqNJsGbCC4RtF8wnhVW5Dv0XT9qzvbtbHWAExf182RIyST0oqbpP15c9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646048; c=relaxed/simple;
	bh=aVAgf6Jw06Lql3bDOfE6zVcTVmPhHzcmNDJscnSeSew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fnegOApXjNzlVIPfAnofUBXXq2EIz6O3TnR+55BD7Wh55mpPJdx5jCep0xhZI3jlFZzceTN/posUxBPdfuE/rVhVc22u8+7E2O7eW2Of5SF75SyOa1Ac2voyXtisczToRejSYR63MhRSL6j5Rz7qydX61VuAEJKFDxWpuAsuggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dNnKs/3j; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42c828c8863so18793985e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725646045; x=1726250845; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+CkJo3Bz1wCo8cghBLvNHn5F/2d1ljMEB+CBPgFMiOM=;
        b=dNnKs/3jgyvO+A6mXjyT7eFiuJije9f1o6pKnEkiUiDkVKYDYpLm84U/T7zp3WR4Qo
         3sGVUHueJACIsD7IXa6ca7+reSi+BmgijvPbV5DByfMVibDD3UwALwB5BHDJsuzSa54T
         ZvKlEKAuUZylowgZvhA7evaUoYYI/vt4SLP3EtBTvCJViDrIQUsAti01U+TyFvsOinKk
         pU+WY8+x1khKstuzzirgsdKTBkO5hduI/rgOR41b3YfnXNo6ITdHo70YgEhVwNzWSuh8
         7pygZrs+0WG9uxzsUgOHAztASfMVF6yruH7tCdjTQgJmlhB2FimR0FcmPwrwllYwHkfR
         o1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646045; x=1726250845;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CkJo3Bz1wCo8cghBLvNHn5F/2d1ljMEB+CBPgFMiOM=;
        b=Wg4o6ThzybC9Di+ZlUL7zW2w2U7hrHdLkcgm1uRe7uN/ewq83/dz3wYu//+1633JRp
         bOO07C0FPs8DaOUL5zF3Ob2FL+RXZvdQY9WrcG34MH1KmAlr2q5GN8RfoYijzk0sbJ0s
         uLk7yjL/5pwx7d6vRYRgMgRUtEP8h8r1m0icVpz8fC9Cuff4yJzw38BDwWmuGM+7AbwA
         5oytBTemWDkCMjaR9hn2nWVbOqZ02le1OLLVas9bqBlYp+Vk7tMW1zW2w4M9sD/sRFLE
         I4liSbtgvqOx3Yg+4+VIdNcVJTj9zaXIpqX/avWuowolYnAMAaT6zD1cdWHfG9QOYVpi
         mCsg==
X-Forwarded-Encrypted: i=1; AJvYcCUArbiI3tM/VZJx2t9lR8NE7GKDeo/yhuRVSWnW1hlYGEdyx+O+cHoCjGsY0i+ck8HWXQlnObzUzbMUMppc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LmU4DNx+c4FeGlXehHTT/9yHmVkdtzdmOSSALMZ5XKocEuiN
	6xy0iq/ek4JFFXW8o4ziwr4o1qunhJByOwtgHnPY6d3wdZGo+k/JFeNwDf10N6o=
X-Google-Smtp-Source: AGHT+IHy1pIX6vPFN+GTLpQP7Rpewt0HZvI8JhY+ZgzCgA6fBvnlWfM8eNUCakcjVl0vKiyxCZY3pw==
X-Received: by 2002:adf:f14a:0:b0:377:2ce0:a760 with SMTP id ffacd0b85a97d-378896a47eamr2289788f8f.49.1725646044865;
        Fri, 06 Sep 2024 11:07:24 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cac8543dbsm5880485e9.42.2024.09.06.11.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:07:24 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v6 00/17] Hardware wrapped key support for QCom ICE and UFS
 core
Date: Fri, 06 Sep 2024 20:07:03 +0200
Message-Id: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMdE22YC/x3MSwqAIBRG4a3EHSdcLCLaSjSw/K1LYKLQA2nvS
 cNvcE6mhChINFSZIk5JcviCrq5o2YxfocQWk2bdcs9aXdGEAKt2PEkBhrnRbnawVJIQ4eT+d+P
 0vh8aHOmmXgAAAA==
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
 Eric Biggers <ebiggers@google.com>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6577;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=aVAgf6Jw06Lql3bDOfE6zVcTVmPhHzcmNDJscnSeSew=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm20TRVUK7s5AluIXTTb9EEpQr0K8OAnyTVliLo
 nGHj15AhL6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZttE0QAKCRARpy6gFHHX
 cgslEAC8zF47axKM4eyrLbxAT7zfi+OlAXxoW7fVp6nbh2i+ikstA+dRIKyyAkw+09gVD629cnv
 PPxeehFUKgVaHZshBdiP8ekuFLijPWDFySoOK8WrNHLAGcnyMYeKeEk/tGAuzVIQv5VUjSQvHXl
 jfMYj/lxFMbIOGUdCkc8wMxYQTwwK6xD3PAUKEcjhGGEgDRgWYoH/OA5iYsnqKCQ0aaddlcyTYc
 IDTedf3x5Xi4rM+caiUpdRwf5Q5zwHQJzGugfh5H0xba2vidjV3mlOu75lYHqnbKBJHjnfqt2zZ
 Hmuv/PzCMq2gQZAhfpUTyFyqQYBxJtNeYGnlV1d2HRhHBkrbEt1Bgj1PJ/i8rw9yDvPWIA3NE4c
 vttukKfAwu9UGl+szEG3nGdUuHn56GRJaS8xAfq5GjpALf1krP+HGkH0G/GNd/g9XijKVADUTyx
 o2x0pHeMt7FoQqtpiiqzsK7G7KyNr3QHxziDtA/fhfEwBARI6lvGDX3EkFcIMx97RdI3PugB8SC
 nOb/xe2w4qBxuHUSW5CGovmHNE7OUyl+37XuGY+odYSRw2viBjr2anYSHsJJIdF3vnZsfuMrm2H
 bYhyu4zX5jsiygksTPOInurmIbq8XAjgyz7ddVW2tOlyDcdbk/Kg0tSLXpOGMrNIZmnlaoqQnHc
 53ysG6tzB32F0fw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

I took this work over from Gaurav Kashyap and integrated Eric's series
into it for an easier discussion on the actual API to be used for
wrapped keys as well as if and how to enable users to indicate whether
wrapped keys should be used at all.

I know Dmitry's opinion on that and expect this to be more of an RFC
rather than a real patch series. That being said, what is here, works
fine on sm8650.

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

Changes since v5:
- add the wrapped key support from Eric Biggers to the series
- remove the new DT property from the series and instead query the
  at run-time rustZone to find out if wrapped keys are supported
- make the wrapped key support into a UFS capability, not a quirk
- improve kerneldocs
- improve and rework coding style in most patches
- improve and reformat commit messages
- simplify the offset calculation for CRYPTOCFG
- split out the DTS changes into a separate series

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

 Documentation/ABI/stable/sysfs-block               |  18 ++
 Documentation/block/inline-encryption.rst          | 245 +++++++++++++-
 Documentation/filesystems/fscrypt.rst              | 154 ++++++++-
 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
 block/blk-crypto-fallback.c                        |   5 +-
 block/blk-crypto-internal.h                        |  10 +
 block/blk-crypto-profile.c                         | 103 ++++++
 block/blk-crypto-sysfs.c                           |  35 ++
 block/blk-crypto.c                                 | 194 ++++++++++-
 block/ioctl.c                                      |   5 +
 drivers/firmware/qcom/qcom_scm.c                   | 233 ++++++++++++++
 drivers/firmware/qcom/qcom_scm.h                   |   4 +
 drivers/md/dm-table.c                              |   1 +
 drivers/mmc/host/cqhci-crypto.c                    |   9 +-
 drivers/mmc/host/cqhci.h                           |   2 +
 drivers/mmc/host/sdhci-msm.c                       |   6 +-
 drivers/soc/qcom/ice.c                             | 355 ++++++++++++++++++++-
 drivers/ufs/core/ufshcd-crypto.c                   |  86 ++++-
 drivers/ufs/host/ufs-qcom.c                        |  61 +++-
 fs/crypto/fscrypt_private.h                        |  71 ++++-
 fs/crypto/hkdf.c                                   |   4 +-
 fs/crypto/inline_crypt.c                           |  44 ++-
 fs/crypto/keyring.c                                | 124 +++++--
 fs/crypto/keysetup.c                               |  54 +++-
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
 34 files changed, 1958 insertions(+), 135 deletions(-)
---
base-commit: ad40aff1edffeccc412cde93894196dca7bc739e
change-id: 20240802-wrapped-keys-eea0032fbfed

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


