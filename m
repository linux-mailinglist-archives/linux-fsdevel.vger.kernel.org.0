Return-Path: <linux-fsdevel+bounces-31754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D9899ABAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 20:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27966283790
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 18:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223A41D0422;
	Fri, 11 Oct 2024 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WlQavfb2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7B81D0156
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672872; cv=none; b=BYBg3DuckMoRM+0QyEMOeXmptZUKm1tKg89Ox/O1Hf7ipdLOL7gmczSqXYd4Wgnw4n4h/hsmBHUb10oyLr/HLwPEm9Xzo/7QHyMOdZ361gjMhj7fIjp7oZqEAtPibPi+Cz1UKQ4sgzz3pjJAul/hXcJppLWi9dXyq/uF+j6KzyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672872; c=relaxed/simple;
	bh=V+W549yZR4YXE4o9ySJ5Sa4Yc/1frqei+R9VTkOnjww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dpdVsGOmyM9D9frsjyODATC+CSOD/dgyH+wx6KY1QZRASdGRESTv434rOdF/7LabBmelMnSxkSDQraZE0P7BbY6Ihcn3ideoKYa9sBXXy+M0zQ5u4rLmqKu0TKmkUOITNTcVkz4wpdUmoSqzK/5XtlVi0WC0rm/5jxPz7W1stiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WlQavfb2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43056d99a5aso21879505e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 11:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672868; x=1729277668; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMw51FgUh2hUVjZgjRJM4Ju1tWp7eQweTumzW/cQKyE=;
        b=WlQavfb2Sv0zMF4RRsI23bY6LL8JpqJxdS6hIswSj0jf02fWUK9CwsjJqNzW2sTnrp
         Tfhq08jxZVrtF6asdgJ20XE+hygjiTV/JOJUqclfjC6oulx3+T+l7v7RPSVmgvilO7lo
         ZMseE2zdc+RMkAMjK+KTL79TE4ZHX1Lh3bP/ZjLM6w37KyojtdSvjuOYmy1Ry2at4xKH
         Frf3xCDRrzdXyeliuKJsokcpLU/EgzoD1oqJJsi3L5ZEMZliLzDshVpnlGTv9zt29Vf4
         ZAccbhaZAkvyOJCxP25XxS6UUbnnzEWroZgE8hCrnTJwtTfpYtwTAaV4Xvl5cjEtr54Z
         RVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672868; x=1729277668;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMw51FgUh2hUVjZgjRJM4Ju1tWp7eQweTumzW/cQKyE=;
        b=ROlI/J7WTq7ic+CAgkYuIEzExBGFuKWHDRjvedEoyjivIPVfyeFp81t1EsIrmriBG2
         UXUVfN/YyjcA7jZq0QR8lyGHC6nGpQvKeSv2mJkgL5TSmpoW5QzoYXCzzi2e9tNh8PSY
         baEQTlAtbCXNnpR2VdgY3SP5T5BqJJKbHpFbV+i1abyoelOVxmQQ1+L3eU4vePeNfdTl
         9tpwZp7/IiR3I4IJ0R0Xl8aHjPoPC16WMtwx9e5lWyD21HN1reVZtvq1DmKbe0FchWqi
         /wdhBhej+eLA9qGDzciOqp4mtKG4132pzQg73kLxWYsCJyuRWibLC3l/hOVM+GSMQ2JV
         gr/g==
X-Forwarded-Encrypted: i=1; AJvYcCVDKd+yfJNZIrv8cO2mhVAFTD6J5GurVg9i97BBU5qlCovh9uakdhWYlCFomwM+eKg1+nOUjhyxdm9YC9D7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5TrZe/FmstNFAOVJnu+4lmigV1gIlRiEJ8waRNI84s43eqRBh
	JpdAB1CIXn1h0lopkWgp/0pYr0szseMkacD5KCkriBFOXx7FI3BtI1lL942EapI=
X-Google-Smtp-Source: AGHT+IHlglhANRvpdTESP3LsM2lgJBYup01gWvrpmxLiylK//L7bzFq3mNfdN8XOV1pwMyWsj+dc6w==
X-Received: by 2002:a5d:44c5:0:b0:37d:3141:5b6 with SMTP id ffacd0b85a97d-37d551d6533mr3343204f8f.12.1728672867357;
        Fri, 11 Oct 2024 11:54:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v7 00/17] Hardware wrapped key support for QCom ICE and UFS
 core
Date: Fri, 11 Oct 2024 20:53:59 +0200
Message-Id: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEd0CWcC/1XMQQ6CMBCF4auQWVszVqzCynsYFi0dYKKhZGqqh
 HB3K65c/i953wKRhClCXSwglDhyGHOcdwW0gx17Uuxzg0Zd4gW1eomdJvLqTnNURBbxqDvXkYd
 8mYQ6fm/crck9cHwGmTc9me/6gyo0/1AyCpU/VWQOrsXWldcHj1bCPkgPzbquH6oQeNSpAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6675;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=V+W549yZR4YXE4o9ySJ5Sa4Yc/1frqei+R9VTkOnjww=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRXheFkvmAfCwx0Kc8rJKoU5BpA3kyWjxAV/
 35LTWYZNfmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0VwAKCRARpy6gFHHX
 cgA0D/4p3Bi0fXlOemSeU2xvKKK25ZEN3/EmT9KnIyEvzW9pkACbc3kmA+hczDu+fEwMdi4SpF5
 wHgSASml14w4srJR/lEyN8QjLuq4WJB5aMwzRR/uLmxIkqI5oONlowHYqbrYs3fL2pUaiEmc9Xf
 z2jBXeZl7d1yLJMHyDke9WIB1jsEVzqsKBYbLnK1APKctF9NBkIOpsEmMEA1TKwlh8W9W9QJ1UM
 JwnX7CINZdXBI4gA2W3uUcF6lcovxO2QZRkViLGcgMQZfJlsFWP0sI0bOuPXejQMp3T71S2/Arm
 SlCRJ2mrhY6Gj0ycUjt8bH57j14pS8Q05CvGuwFDfcCZl+uF1GAjhw21G/dxCOaS7WglRuOq55x
 ZTQT1UsptQVVfQTCvY2OKUWPSrdBKCw60tXAYC1KDkbRWkTDurZnoLbls3SoS2c6IBJsMKeDa40
 GdDpfPRU8AWr3oXYwo34OoYMI1aR7zKd6dCxJwuYX2EqT5fTDhgGm61Fz3OqxMPYkIU6wxbZopK
 sBpaN3p5QYVq+HcVlblb1TJE2rnT/J3nekeHAO1Nd3G0y6VFoE3P8Z7Wet05HOSJzH8hKjDHIgX
 ekggBI63eC4hPHcK9Ayb21XHlt2yzjO0Hd/6aeS7v8sLL960tlGQ0ElhucsvwZiyE2IFqQD1MaD
 ph2BvhVDuk9LM6A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

The preferred solution to the HWKM configuration issue seems to be
using a module param so this is what I did in this iteration.

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
base-commit: eae80d86fb04e37032e5bdaec64e0b70316d11ae
change-id: 20240802-wrapped-keys-eea0032fbfed

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


