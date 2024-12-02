Return-Path: <linux-fsdevel+bounces-36240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB1C9E0163
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 13:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91531165737
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9681D205AB3;
	Mon,  2 Dec 2024 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CZIZBUmW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B272202F67
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140972; cv=none; b=djq0+9hiSnH+KJaSTudIYewkYCnpJ5J5Un1T+oUmOQz7NW1X2CC2iBGu6x/0cio+cOKfi+nDHYSxcR9iXgOsHys/TJmng62lXP+XXwRK1SA8+1u7VgAl7arGzS2N3tn8Z2ecNXOoJoUVVFWiBBVotJyqgoG/CstuKa4Z6Zni/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140972; c=relaxed/simple;
	bh=fQ5UQE+przlZ0BeiqrSFVoMcpjW+DwXdZQn/uPLysoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CvCuYN1Y4otQF5u+YZh/UyK5ZGJBDKNUtGNtwpIHn3LJComp+azo3ABUJVMmx22rG5No0Bx3VQp7vte7yPZ0D7/Kz59Io5Vv2DiChUZavX6jnwX4DMqn+XmKfv1h6eifwa/1YkMG4KrpB6n+/oi8fxdOrnyXh8EVDcVYvoTVP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CZIZBUmW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a45f05feso52440065e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 04:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733140964; x=1733745764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzYsR4fPMAUSlweUAnZ3z9CwJlVMGTkodPbQGaiasNY=;
        b=CZIZBUmWFxxIQJfFJTLB4rGP8UBq7qGmYAtBYiwgbmo94LtkL/IhC+H9u43xo/OKvr
         qYEP/4ptjHjylKS3Sfd7ThGlZNcTW/F/8vb76w0e6qo+0O2YwvbS28jgdxSVDGJPi3t4
         o9ExdQ+62PZwxyvbee/a9HvAEL7ZX7HGOpf7/uoSBugVX/oq/UGZ64cAcdNb8uSQxqVa
         6iTfsJPjHBkPpBYwMOUUgKviaOY89I9vxYMIEOc8HNLiqikrzOCh4fTXvn80GcTp2Bq/
         vfYVjd/CVOiG/V8jPA1VU2zO9Lfb6+eXdIAXBI2GIbWKVeWjXE75EQoUJqg7EkibbAQ1
         czkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140964; x=1733745764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzYsR4fPMAUSlweUAnZ3z9CwJlVMGTkodPbQGaiasNY=;
        b=rdZtSGvuKi3smZxRZnCj6Re1DnrHavbmq+CD7eOYldmcV+yz/fGM9eXAf9VmAiSpqu
         lH8bZTlBRIH4mIAhTLCr2CzesgiqKbm1b6WWkmUFMmlMsBDsJhE1hTlwHT4vjMjhJFxb
         OAQHAILX84f1oFh+d+daovbv2Cc7R1mpB8SWD7y3tV472As1KhIJZoLLzvjqLe8QJVlY
         +sIXu50+Q4onlYhawuXUfwtb+wylBotUjUPxzqQWBf4VLWGKCevIO83PDJKm+yMqu/kb
         FKs8LjCxkbM7GTCBhsmoTSOmGfR7085az4BQ670MoQIpu45OsXOEC94pfH39MTwvLBVz
         gFhg==
X-Forwarded-Encrypted: i=1; AJvYcCVSJnyzfFxmbIgjIoyA5RJObI67IT2ByM/oZuo6u8xz78FnIWSTT5QaVqMcWu0NU27Loy5C8kQdNPOP/e4G@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+F2zBtWkV+yFZRcdl9vCvbdQ9AOnQZf7F37mqTB68Fd9iTxV
	Qrx27JMwqVa+u0wX+W6rrRhcf8YLdn4jwFMjS7DpadQC9Ws3G66C6XQKH2r/AG8=
X-Gm-Gg: ASbGncv00Q2SQYBc3Qxc7PLqzlJP5ysVLS22q76DW2Qnrd8hDlDFwpHjDdzE5/Fmndq
	biBDKePrAmGegXF5y0EhetXUzmSA9Ios5dYEr4tSynnxCir3KSSPTsVOXO6TM3faopZhN+YgB5C
	i+/f5GaZL7Y2ku1w/3dBzvN5FuR5guxsFx8Jxr66SYF1/tnEE+xY8AuesQI2urwMb/rcogl26fr
	q009CtdCLqAY25ycCmPqbDJZFk53uRcYrEP1kLT
X-Google-Smtp-Source: AGHT+IE+10EBP2XKoBiZXQmEhzLLRfyuxNX9inrS2NiqBNIcNWRu8PFg9CIjxYZcAnLsObazRExuVA==
X-Received: by 2002:a05:600c:4f85:b0:431:4f29:9539 with SMTP id 5b1f17b1804b1-434a9dfbb05mr220160665e9.32.1733140963342;
        Mon, 02 Dec 2024 04:02:43 -0800 (PST)
Received: from [127.0.1.1] ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm152396095e9.8.2024.12.02.04.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:02:42 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 02 Dec 2024 13:02:20 +0100
Subject: [PATCH RESEND v7 04/17] fscrypt: add support for hardware-wrapped
 keys
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-wrapped-keys-v7-4-67c3ca3f3282@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=40243;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=wqhiZ88ieICtwNPbt7E4MyENol1dZqLnOFjNt8pcbww=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTaHS256+NH5RYrGYqGi6oqF+h7Gr9B+/Z0LcU
 uA+V+ZBdoyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ02h0gAKCRARpy6gFHHX
 cmXCD/401A0qhPfGNqLIfutoAp6YTTDV480/CWY09AJzfFPinybQt/Umg15231IUNCOf65KqIBm
 SFAgssIi+zo9Tw01jv3OVgX5M1qGtjOykowndiU8F6GGilT6PiYU49dCD+o+YY9ezT+AuQdcAxE
 dy5hNJEiR31KpHtAn9DZHcaidvF9zrSWU6hPhdIWt7itd+A55ABhi7UAbyN7RF0KonrGWDEGroe
 fftV4zWIfJ4KU6GE+fxYHelxHOex3joVfkdQLNI4vLxm8680XAfogYYaqaWHLKWoq9knmGS28gS
 DUHIRFfbwiM540Emw0JgrUfJLpu07r/x10HUzrejK5kNT93lGEGbVHz6LylvhDYQRahiJJHnFoi
 Inx0xhP99u+TtCeR0Im1cIM0kNZBz4/4ZvuMuHS4piqxbyimhWPzYAxnKTHf1aEojYsrnR1o8eU
 xNqxbuNPJhy3mIacDlDOitFwb3Iodtdbx8pkvCQrGW8RUkhKUx4bS7ICqNMRrTA92467QnRyjKF
 tz2Uc9v0FwFzoQ9gnbdT4AEbejYuNdkJgWj3mgU5W8GwgNGpdzropZo9btONIciniOw4BKI1eS8
 ueuVojkjZYp78siSQGeTPCyQ6tichKn2MPUB3juV2VagbwgsuPaCpr17yaKZhQqzHQZvpzhZsoD
 ul+0D/vYeDjcb1A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Eric Biggers <ebiggers@google.com>

Add support for hardware-wrapped keys to fscrypt.  Such keys are
protected from certain attacks, such as cold boot attacks.  For more
information, see the "Hardware-wrapped keys" section of
Documentation/block/inline-encryption.rst.

To support hardware-wrapped keys in fscrypt, we allow the fscrypt master
keys to be hardware-wrapped, and we allow encryption policies to be
flagged as needing a hardware-wrapped key.  File contents encryption is
done by passing the wrapped key to the inline encryption hardware via
blk-crypto.  Other fscrypt operations such as filenames encryption
continue to be done by the kernel, using the "software secret" which the
hardware derives.  For more information, see the documentation which
this patch adds to Documentation/filesystems/fscrypt.rst.

Note that this feature doesn't require any filesystem-specific changes.
However it does depend on inline encryption support, and thus currently
it is only applicable to ext4 and f2fs.

This feature is intentionally not UAPI or on-disk format compatible with
the version of this feature in the Android Common Kernels, as that
version was meant as a temporary solution and it took some shortcuts.
Once upstreamed, this new version should be used going forwards.

This patch has been heavily rewritten from the original version by
Gaurav Kashyap <gaurkash@codeaurora.org> and
Barani Muthukumaran <bmuthuku@codeaurora.org>.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/filesystems/fscrypt.rst | 154 ++++++++++++++++++++++++++++++----
 fs/crypto/fscrypt_private.h           |  71 ++++++++++++++--
 fs/crypto/hkdf.c                      |   4 +-
 fs/crypto/inline_crypt.c              |  46 ++++++++--
 fs/crypto/keyring.c                   | 124 +++++++++++++++++++--------
 fs/crypto/keysetup.c                  |  54 +++++++++++-
 fs/crypto/keysetup_v1.c               |   5 +-
 fs/crypto/policy.c                    |  11 ++-
 include/uapi/linux/fscrypt.h          |   7 +-
 9 files changed, 402 insertions(+), 74 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 04eaab01314bc..a359a92d6c47a 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -70,7 +70,7 @@ Online attacks
 --------------
 
 fscrypt (and storage encryption in general) can only provide limited
-protection, if any at all, against online attacks.  In detail:
+protection against online attacks.  In detail:
 
 Side-channel attacks
 ~~~~~~~~~~~~~~~~~~~~
@@ -99,16 +99,23 @@ Therefore, any encryption-specific access control checks would merely
 be enforced by kernel *code* and therefore would be largely redundant
 with the wide variety of access control mechanisms already available.)
 
-Kernel memory compromise
-~~~~~~~~~~~~~~~~~~~~~~~~
+Read-only kernel memory compromise
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-An attacker who compromises the system enough to read from arbitrary
-memory, e.g. by mounting a physical attack or by exploiting a kernel
-security vulnerability, can compromise all encryption keys that are
-currently in use.
+Unless `hardware-wrapped keys`_ are used, an attacker who gains the
+ability to read from arbitrary kernel memory, e.g. by mounting a
+physical attack or by exploiting a kernel security vulnerability, can
+compromise all fscrypt keys that are currently in-use.  This also
+extends to cold boot attacks; if the system is suddenly powered off,
+keys the system was using may remain in memory for a short time.
 
-However, fscrypt allows encryption keys to be removed from the kernel,
-which may protect them from later compromise.
+However, if hardware-wrapped keys are used, then the fscrypt master
+keys and file contents encryption keys (but not other types of fscrypt
+subkeys such as filenames encryption keys) are protected from
+compromises of arbitrary kernel memory.
+
+In addition, fscrypt allows encryption keys to be removed from the
+kernel, which may protect them from later compromise.
 
 In more detail, the FS_IOC_REMOVE_ENCRYPTION_KEY ioctl (or the
 FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS ioctl) can wipe a master
@@ -145,6 +152,24 @@ However, these ioctls have some limitations:
   accelerator hardware (if used by the crypto API to implement any of
   the algorithms), or in other places not explicitly considered here.
 
+Full system compromise
+~~~~~~~~~~~~~~~~~~~~~~
+
+An attacker who gains "root" access and/or the ability to execute
+arbitrary kernel code can freely exfiltrate data that is protected by
+any in-use fscrypt keys.  Thus, usually fscrypt provides no meaningful
+protection in this scenario.  (Data that is protected by a key that is
+absent throughout the entire attack remains protected, modulo the
+limitations of key removal mentioned above in the case where the key
+was removed prior to the attack.)
+
+However, if `hardware-wrapped keys`_ are used, such attackers will be
+unable to exfiltrate the master keys or file contents keys in a form
+that will be usable after the system is powered off.  This may be
+useful if the attacker is significantly time-limited and/or
+bandwidth-limited, so they can only exfiltrate some data and need to
+rely on a later offline attack to exfiltrate the rest of it.
+
 Limitations of v1 policies
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -171,6 +196,11 @@ policies on all new encrypted directories.
 Key hierarchy
 =============
 
+Note: this section assumes the use of standard keys (i.e. "software
+keys") rather than hardware-wrapped keys.  The use of hardware-wrapped
+keys modifies the key hierarchy slightly.  For details, see the
+`Hardware-wrapped keys`_ section.
+
 Master Keys
 -----------
 
@@ -614,6 +644,8 @@ This structure must be initialized as follows:
     policies`_.
   - FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32: See `IV_INO_LBLK_32
     policies`_.
+  - FSCRYPT_POLICY_FLAG_HW_WRAPPED_KEY: This flag denotes that this
+    policy uses a hardware-wrapped key.  See `Hardware-wrapped keys`_.
 
   v1 encryption policies only support the PAD_* and DIRECT_KEY flags.
   The other flags are only supported by v2 encryption policies.
@@ -836,7 +868,8 @@ a pointer to struct fscrypt_add_key_arg, defined as follows::
             struct fscrypt_key_specifier key_spec;
             __u32 raw_size;
             __u32 key_id;
-            __u32 __reserved[8];
+            __u32 flags;
+            __u32 __reserved[7];
             __u8 raw[];
     };
 
@@ -855,7 +888,7 @@ a pointer to struct fscrypt_add_key_arg, defined as follows::
 
     struct fscrypt_provisioning_key_payload {
             __u32 type;
-            __u32 __reserved;
+            __u32 flags;
             __u8 raw[];
     };
 
@@ -883,6 +916,12 @@ as follows:
   Alternatively, if ``key_id`` is nonzero, this field must be 0, since
   in that case the size is implied by the specified Linux keyring key.
 
+- ``flags`` contains optional flags from ``<linux/fscrypt.h>``:
+
+  - FSCRYPT_ADD_KEY_FLAG_HW_WRAPPED: This denotes that the key is a
+    hardware-wrapped key.  See `Hardware-wrapped keys`_.  This flag
+    can't be used if FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR is used.
+
 - ``key_id`` is 0 if the raw key is given directly in the ``raw``
   field.  Otherwise ``key_id`` is the ID of a Linux keyring key of
   type "fscrypt-provisioning" whose payload is
@@ -924,6 +963,8 @@ FS_IOC_ADD_ENCRYPTION_KEY can fail with the following errors:
   caller does not have the CAP_SYS_ADMIN capability in the initial
   user namespace; or the raw key was specified by Linux key ID but the
   process lacks Search permission on the key.
+- ``EBADMSG``: FSCRYPT_ADD_KEY_FLAG_HW_WRAPPED was specified, but the
+  key isn't a valid hardware-wrapped key
 - ``EDQUOT``: the key quota for this user would be exceeded by adding
   the key
 - ``EINVAL``: invalid key size or key specifier type, or reserved bits
@@ -935,7 +976,9 @@ FS_IOC_ADD_ENCRYPTION_KEY can fail with the following errors:
 - ``ENOTTY``: this type of filesystem does not implement encryption
 - ``EOPNOTSUPP``: the kernel was not configured with encryption
   support for this filesystem, or the filesystem superblock has not
-  had encryption enabled on it
+  had encryption enabled on it, or FSCRYPT_ADD_KEY_FLAG_HW_WRAPPED was
+  specified but the filesystem and/or the hardware doesn't support
+  hardware-wrapped keys
 
 Legacy method
 ~~~~~~~~~~~~~
@@ -998,9 +1041,8 @@ or removed by non-root users.
 These ioctls don't work on keys that were added via the legacy
 process-subscribed keyrings mechanism.
 
-Before using these ioctls, read the `Kernel memory compromise`_
-section for a discussion of the security goals and limitations of
-these ioctls.
+Before using these ioctls, read the `Online attacks`_ section for a
+discussion of the security goals and limitations of these ioctls.
 
 FS_IOC_REMOVE_ENCRYPTION_KEY
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -1320,7 +1362,8 @@ inline encryption hardware doesn't have the needed crypto capabilities
 (e.g. support for the needed encryption algorithm and data unit size)
 and where blk-crypto-fallback is unusable.  (For blk-crypto-fallback
 to be usable, it must be enabled in the kernel configuration with
-CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y.)
+CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y, and the file must be
+protected by a standard key rather than a hardware-wrapped key.)
 
 Currently fscrypt always uses the filesystem block size (which is
 usually 4096 bytes) as the data unit size.  Therefore, it can only use
@@ -1328,7 +1371,84 @@ inline encryption hardware that supports that data unit size.
 
 Inline encryption doesn't affect the ciphertext or other aspects of
 the on-disk format, so users may freely switch back and forth between
-using "inlinecrypt" and not using "inlinecrypt".
+using "inlinecrypt" and not using "inlinecrypt".  An exception is that
+files that are protected by a hardware-wrapped key can only be
+encrypted/decrypted by the inline encryption hardware and therefore
+can only be accessed when the "inlinecrypt" mount option is used.  For
+more information about hardware-wrapped keys, see below.
+
+Hardware-wrapped keys
+---------------------
+
+fscrypt supports using *hardware-wrapped keys* when the inline
+encryption hardware supports it.  Such keys are only present in kernel
+memory in wrapped (encrypted) form; they can only be unwrapped
+(decrypted) by the inline encryption hardware and are temporally bound
+to the current boot.  This prevents the keys from being compromised if
+kernel memory is leaked.  This is done without limiting the number of
+keys that can be used and while still allowing the execution of
+cryptographic tasks that are tied to the same key but can't use inline
+encryption hardware, e.g. filenames encryption.
+
+Note that hardware-wrapped keys aren't specific to fscrypt; they are a
+block layer feature (part of *blk-crypto*).  For more details about
+hardware-wrapped keys, see the block layer documentation at
+:ref:`Documentation/block/inline-encryption.rst
+<hardware_wrapped_keys>`.  Below, we just focus on the details of how
+fscrypt can use hardware-wrapped keys.
+
+fscrypt supports hardware-wrapped keys by allowing the fscrypt master
+keys to be hardware-wrapped keys as an alternative to standard keys.
+To add a hardware-wrapped key with `FS_IOC_ADD_ENCRYPTION_KEY`_,
+userspace must specify FSCRYPT_ADD_KEY_FLAG_HW_WRAPPED in the
+``flags`` field of struct fscrypt_add_key_arg and also in the
+``flags`` field of struct fscrypt_provisioning_key_payload when
+applicable.  The key must be in ephemerally-wrapped form, not
+long-term wrapped form.
+
+To specify that files will be protected by a hardware-wrapped key,
+userspace must specify FSCRYPT_POLICY_FLAG_HW_WRAPPED_KEY in the
+encryption policy.  (Note that this flag is somewhat redundant, as the
+encryption policy also contains the key identifier, and
+hardware-wrapped keys and standard keys will have different key
+identifiers.  However, it is sometimes helpful to make it explicit
+that an encryption policy is supposed to use a hardware-wrapped key.)
+
+Some limitations apply.  First, files protected by a hardware-wrapped
+key are tied to the system's inline encryption hardware.  Therefore
+they can only be accessed when the "inlinecrypt" mount option is used,
+and they can't be included in portable filesystem images.  Second,
+currently the hardware-wrapped key support is only compatible with
+`IV_INO_LBLK_64 policies`_ and `IV_INO_LBLK_32 policies`_, as it
+assumes that there is just one file contents encryption key per
+fscrypt master key rather than one per file.  Future work may address
+this limitation by passing per-file nonces down the storage stack to
+allow the hardware to derive per-file keys.
+
+Implementation-wise, to encrypt/decrypt the contents of files that are
+protected by a hardware-wrapped key, fscrypt uses blk-crypto,
+attaching the hardware-wrapped key to the bio crypt contexts.  As is
+the case with standard keys, the block layer will program the key into
+a keyslot when it isn't already in one.  However, when programming a
+hardware-wrapped key, the hardware doesn't program the given key
+directly into a keyslot but rather unwraps it (using the hardware's
+ephemeral wrapping key) and derives the inline encryption key from it.
+The inline encryption key is the key that actually gets programmed
+into a keyslot, and it is never exposed to software.
+
+However, fscrypt doesn't just do file contents encryption; it also
+uses its master keys to derive filenames encryption keys, key
+identifiers, and sometimes some more obscure types of subkeys such as
+dirhash keys.  So even with file contents encryption out of the
+picture, fscrypt still needs a raw key to work with.  To get such a
+key from a hardware-wrapped key, fscrypt asks the inline encryption
+hardware to derive a cryptographically isolated "software secret" from
+the hardware-wrapped key.  fscrypt uses this "software secret" to key
+its KDF to derive all subkeys other than file contents keys.
+
+Note that this implies that the hardware-wrapped key feature only
+protects the file contents encryption keys.  It doesn't protect other
+fscrypt subkeys such as filenames encryption keys.
 
 Direct I/O support
 ==================
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 8371e4e1f596a..bd01759e16539 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -27,6 +27,27 @@
  */
 #define FSCRYPT_MIN_KEY_SIZE	16
 
+/* Maximum size of a standard fscrypt master key */
+#define FSCRYPT_MAX_STANDARD_KEY_SIZE	64
+
+/* Maximum size of a hardware-wrapped fscrypt master key */
+#define FSCRYPT_MAX_HW_WRAPPED_KEY_SIZE	BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE
+
+/*
+ * Maximum size of an fscrypt master key across both key types.
+ * This should just use max(), but max() doesn't work in a struct definition.
+ */
+#define FSCRYPT_MAX_ANY_KEY_SIZE \
+	(FSCRYPT_MAX_HW_WRAPPED_KEY_SIZE > FSCRYPT_MAX_STANDARD_KEY_SIZE ? \
+	 FSCRYPT_MAX_HW_WRAPPED_KEY_SIZE : FSCRYPT_MAX_STANDARD_KEY_SIZE)
+
+/*
+ * FSCRYPT_MAX_KEY_SIZE is defined in the UAPI header, but the addition of
+ * hardware-wrapped keys has made it misleading as it's only for standard keys.
+ * Don't use it in kernel code; use one of the above constants instead.
+ */
+#undef FSCRYPT_MAX_KEY_SIZE
+
 #define FSCRYPT_CONTEXT_V1	1
 #define FSCRYPT_CONTEXT_V2	2
 
@@ -360,13 +381,16 @@ int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
  * outputs are unique and cryptographically isolated, i.e. knowledge of one
  * output doesn't reveal another.
  */
-#define HKDF_CONTEXT_KEY_IDENTIFIER	1 /* info=<empty>		*/
+#define HKDF_CONTEXT_KEY_IDENTIFIER_FOR_STANDARD_KEY \
+					1 /* info=<empty>		*/
 #define HKDF_CONTEXT_PER_FILE_ENC_KEY	2 /* info=file_nonce		*/
 #define HKDF_CONTEXT_DIRECT_KEY		3 /* info=mode_num		*/
 #define HKDF_CONTEXT_IV_INO_LBLK_64_KEY	4 /* info=mode_num||fs_uuid	*/
 #define HKDF_CONTEXT_DIRHASH_KEY	5 /* info=file_nonce		*/
 #define HKDF_CONTEXT_IV_INO_LBLK_32_KEY	6 /* info=mode_num||fs_uuid	*/
 #define HKDF_CONTEXT_INODE_HASH_KEY	7 /* info=<empty>		*/
+#define HKDF_CONTEXT_KEY_IDENTIFIER_FOR_HW_WRAPPED_KEY \
+					8 /* info=<empty>		*/
 
 int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
 			const u8 *info, unsigned int infolen,
@@ -385,12 +409,17 @@ fscrypt_using_inline_encryption(const struct fscrypt_inode_info *ci)
 }
 
 int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
-				     const u8 *raw_key,
+				     const u8 *raw_key, size_t raw_key_size,
+				     bool is_hw_wrapped,
 				     const struct fscrypt_inode_info *ci);
 
 void fscrypt_destroy_inline_crypt_key(struct super_block *sb,
 				      struct fscrypt_prepared_key *prep_key);
 
+int fscrypt_derive_sw_secret(struct super_block *sb,
+			     const u8 *wrapped_key, size_t wrapped_key_size,
+			     u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
+
 /*
  * Check whether the crypto transform or blk-crypto key has been allocated in
  * @prep_key, depending on which encryption implementation the file will use.
@@ -427,7 +456,8 @@ fscrypt_using_inline_encryption(const struct fscrypt_inode_info *ci)
 
 static inline int
 fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
-				 const u8 *raw_key,
+				 const u8 *raw_key, size_t raw_key_size,
+				 bool is_hw_wrapped,
 				 const struct fscrypt_inode_info *ci)
 {
 	WARN_ON_ONCE(1);
@@ -440,6 +470,15 @@ fscrypt_destroy_inline_crypt_key(struct super_block *sb,
 {
 }
 
+static inline int
+fscrypt_derive_sw_secret(struct super_block *sb,
+			 const u8 *wrapped_key, size_t wrapped_key_size,
+			 u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	fscrypt_warn(NULL, "kernel doesn't support hardware-wrapped keys");
+	return -EOPNOTSUPP;
+}
+
 static inline bool
 fscrypt_is_key_prepared(struct fscrypt_prepared_key *prep_key,
 			const struct fscrypt_inode_info *ci)
@@ -456,11 +495,23 @@ fscrypt_is_key_prepared(struct fscrypt_prepared_key *prep_key,
 struct fscrypt_master_key_secret {
 
 	/*
-	 * For v2 policy keys: HKDF context keyed by this master key.
-	 * For v1 policy keys: not set (hkdf.hmac_tfm == NULL).
+	 * The KDF with which subkeys of this key can be derived.
+	 *
+	 * For v1 policy keys, this isn't applicable and won't be set.
+	 * Otherwise, this KDF will be keyed by this master key if
+	 * ->is_hw_wrapped=false, or by the "software secret" that hardware
+	 * derived from this master key if ->is_hw_wrapped=true.
 	 */
 	struct fscrypt_hkdf	hkdf;
 
+	/*
+	 * True if this key is a hardware-wrapped key; false if this key is a
+	 * standard key (i.e. a "software key").  For v1 policy keys this will
+	 * always be false, as v1 policy support is a legacy feature which
+	 * doesn't support newer functionality such as hardware-wrapped keys.
+	 */
+	bool			is_hw_wrapped;
+
 	/*
 	 * Size of the raw key in bytes.  This remains set even if ->raw was
 	 * zeroized due to no longer being needed.  I.e. we still remember the
@@ -468,8 +519,14 @@ struct fscrypt_master_key_secret {
 	 */
 	u32			size;
 
-	/* For v1 policy keys: the raw key.  Wiped for v2 policy keys. */
-	u8			raw[FSCRYPT_MAX_KEY_SIZE];
+	/*
+	 * The raw key which userspace provided, when still needed.  This can be
+	 * either a standard key or a hardware-wrapped key, as indicated by
+	 * ->is_hw_wrapped.  In the case of a standard, v2 policy key, there is
+	 * no need to remember the raw key separately from ->hkdf so this field
+	 * will be zeroized as soon as ->hkdf is initialized.
+	 */
+	u8			raw[FSCRYPT_MAX_ANY_KEY_SIZE];
 
 } __randomize_layout;
 
diff --git a/fs/crypto/hkdf.c b/fs/crypto/hkdf.c
index 5a384dad2c72f..7e007810e4346 100644
--- a/fs/crypto/hkdf.c
+++ b/fs/crypto/hkdf.c
@@ -4,7 +4,9 @@
  * Function"), aka RFC 5869.  See also the original paper (Krawczyk 2010):
  * "Cryptographic Extraction and Key Derivation: The HKDF Scheme".
  *
- * This is used to derive keys from the fscrypt master keys.
+ * This is used to derive keys from the fscrypt master keys (or from the
+ * "software secrets" which hardware derives from the fscrypt master keys, in
+ * the case that the fscrypt master keys are hardware-wrapped keys).
  *
  * Copyright 2019 Google LLC
  */
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index ee92c78e798bd..eedbf42dd78ed 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -93,6 +93,7 @@ int fscrypt_select_encryption_impl(struct fscrypt_inode_info *ci)
 {
 	const struct inode *inode = ci->ci_inode;
 	struct super_block *sb = inode->i_sb;
+	unsigned int policy_flags = fscrypt_policy_flags(&ci->ci_policy);
 	struct blk_crypto_config crypto_cfg;
 	struct block_device **devs;
 	unsigned int num_devs;
@@ -118,8 +119,7 @@ int fscrypt_select_encryption_impl(struct fscrypt_inode_info *ci)
 	 * doesn't work with IV_INO_LBLK_32. For now, simply exclude
 	 * IV_INO_LBLK_32 with blocksize != PAGE_SIZE from inline encryption.
 	 */
-	if ((fscrypt_policy_flags(&ci->ci_policy) &
-	     FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) &&
+	if ((policy_flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) &&
 	    sb->s_blocksize != PAGE_SIZE)
 		return 0;
 
@@ -130,7 +130,9 @@ int fscrypt_select_encryption_impl(struct fscrypt_inode_info *ci)
 	crypto_cfg.crypto_mode = ci->ci_mode->blk_crypto_mode;
 	crypto_cfg.data_unit_size = 1U << ci->ci_data_unit_bits;
 	crypto_cfg.dun_bytes = fscrypt_get_dun_bytes(ci);
-	crypto_cfg.key_type = BLK_CRYPTO_KEY_TYPE_STANDARD;
+	crypto_cfg.key_type =
+		(policy_flags & FSCRYPT_POLICY_FLAG_HW_WRAPPED_KEY) ?
+		BLK_CRYPTO_KEY_TYPE_HW_WRAPPED : BLK_CRYPTO_KEY_TYPE_STANDARD;
 
 	devs = fscrypt_get_devices(sb, &num_devs);
 	if (IS_ERR(devs))
@@ -151,12 +153,15 @@ int fscrypt_select_encryption_impl(struct fscrypt_inode_info *ci)
 }
 
 int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
-				     const u8 *raw_key,
+				     const u8 *raw_key, size_t raw_key_size,
+				     bool is_hw_wrapped,
 				     const struct fscrypt_inode_info *ci)
 {
 	const struct inode *inode = ci->ci_inode;
 	struct super_block *sb = inode->i_sb;
 	enum blk_crypto_mode_num crypto_mode = ci->ci_mode->blk_crypto_mode;
+	enum blk_crypto_key_type key_type = is_hw_wrapped ?
+		BLK_CRYPTO_KEY_TYPE_HW_WRAPPED : BLK_CRYPTO_KEY_TYPE_STANDARD;
 	struct blk_crypto_key *blk_key;
 	struct block_device **devs;
 	unsigned int num_devs;
@@ -167,9 +172,8 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 	if (!blk_key)
 		return -ENOMEM;
 
-	err = blk_crypto_init_key(blk_key, raw_key, ci->ci_mode->keysize,
-				  BLK_CRYPTO_KEY_TYPE_STANDARD, crypto_mode,
-				  fscrypt_get_dun_bytes(ci),
+	err = blk_crypto_init_key(blk_key, raw_key, raw_key_size, key_type,
+				  crypto_mode, fscrypt_get_dun_bytes(ci),
 				  1U << ci->ci_data_unit_bits);
 	if (err) {
 		fscrypt_err(inode, "error %d initializing blk-crypto key", err);
@@ -228,6 +232,34 @@ void fscrypt_destroy_inline_crypt_key(struct super_block *sb,
 	kfree_sensitive(blk_key);
 }
 
+/*
+ * Ask the inline encryption hardware to derive the software secret from a
+ * hardware-wrapped key.  Returns -EOPNOTSUPP if hardware-wrapped keys aren't
+ * supported on this filesystem or hardware.
+ */
+int fscrypt_derive_sw_secret(struct super_block *sb,
+			     const u8 *wrapped_key, size_t wrapped_key_size,
+			     u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	int err;
+
+	/* The filesystem must be mounted with -o inlinecrypt. */
+	if (!(sb->s_flags & SB_INLINECRYPT)) {
+		fscrypt_warn(NULL,
+			     "%s: filesystem not mounted with inlinecrypt\n",
+			     sb->s_id);
+		return -EOPNOTSUPP;
+	}
+
+	err = blk_crypto_derive_sw_secret(sb->s_bdev, wrapped_key,
+					  wrapped_key_size, sw_secret);
+	if (err == -EOPNOTSUPP)
+		fscrypt_warn(NULL,
+			     "%s: block device doesn't support hardware-wrapped keys\n",
+			     sb->s_id);
+	return err;
+}
+
 bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 {
 	return inode->i_crypt_info->ci_inlinecrypt;
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 787e9c8938ba3..a6293dc6fdd9f 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -149,11 +149,11 @@ static int fscrypt_user_key_instantiate(struct key *key,
 					struct key_preparsed_payload *prep)
 {
 	/*
-	 * We just charge FSCRYPT_MAX_KEY_SIZE bytes to the user's key quota for
-	 * each key, regardless of the exact key size.  The amount of memory
-	 * actually used is greater than the size of the raw key anyway.
+	 * We just charge FSCRYPT_MAX_STANDARD_KEY_SIZE bytes to the user's key
+	 * quota for each key, regardless of the exact key size.  The amount of
+	 * memory actually used is greater than the size of the raw key anyway.
 	 */
-	return key_payload_reserve(key, FSCRYPT_MAX_KEY_SIZE);
+	return key_payload_reserve(key, FSCRYPT_MAX_STANDARD_KEY_SIZE);
 }
 
 static void fscrypt_user_key_describe(const struct key *key, struct seq_file *m)
@@ -558,20 +558,45 @@ static int add_master_key(struct super_block *sb,
 	int err;
 
 	if (key_spec->type == FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER) {
-		err = fscrypt_init_hkdf(&secret->hkdf, secret->raw,
-					secret->size);
+		u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE];
+		u8 *kdf_key = secret->raw;
+		unsigned int kdf_key_size = secret->size;
+		u8 keyid_kdf_ctx = HKDF_CONTEXT_KEY_IDENTIFIER_FOR_STANDARD_KEY;
+
+		/*
+		 * For standard keys, the fscrypt master key is used directly as
+		 * the fscrypt KDF key.  For hardware-wrapped keys, we have to
+		 * pass the master key to the hardware to derive the KDF key,
+		 * which is then only used to derive non-file-contents subkeys.
+		 */
+		if (secret->is_hw_wrapped) {
+			err = fscrypt_derive_sw_secret(sb, secret->raw,
+						       secret->size, sw_secret);
+			if (err)
+				return err;
+			kdf_key = sw_secret;
+			kdf_key_size = sizeof(sw_secret);
+			/*
+			 * To avoid weird behavior if someone manages to
+			 * determine sw_secret and add it as a standard key,
+			 * ensure that hardware-wrapped keys and standard keys
+			 * will have different key identifiers by deriving their
+			 * key identifiers using different KDF contexts.
+			 */
+			keyid_kdf_ctx =
+				HKDF_CONTEXT_KEY_IDENTIFIER_FOR_HW_WRAPPED_KEY;
+		}
+		err = fscrypt_init_hkdf(&secret->hkdf, kdf_key, kdf_key_size);
+		/*
+		 * Now that the KDF context is initialized, the raw KDF key is
+		 * no longer needed.
+		 */
+		memzero_explicit(kdf_key, kdf_key_size);
 		if (err)
 			return err;
 
-		/*
-		 * Now that the HKDF context is initialized, the raw key is no
-		 * longer needed.
-		 */
-		memzero_explicit(secret->raw, secret->size);
-
 		/* Calculate the key identifier */
-		err = fscrypt_hkdf_expand(&secret->hkdf,
-					  HKDF_CONTEXT_KEY_IDENTIFIER, NULL, 0,
+		err = fscrypt_hkdf_expand(&secret->hkdf, keyid_kdf_ctx, NULL, 0,
 					  key_spec->u.identifier,
 					  FSCRYPT_KEY_IDENTIFIER_SIZE);
 		if (err)
@@ -580,19 +605,36 @@ static int add_master_key(struct super_block *sb,
 	return do_add_master_key(sb, secret, key_spec);
 }
 
+/*
+ * Validate the size of an fscrypt master key being added.  Note that this is
+ * just an initial check, as we don't know which ciphers will be used yet.
+ * There is a stricter size check later when the key is actually used by a file.
+ */
+static inline bool fscrypt_valid_key_size(size_t size, u32 add_key_flags)
+{
+	u32 max_size = (add_key_flags & FSCRYPT_ADD_KEY_FLAG_HW_WRAPPED) ?
+		       FSCRYPT_MAX_HW_WRAPPED_KEY_SIZE :
+		       FSCRYPT_MAX_STANDARD_KEY_SIZE;
+
+	return size >= FSCRYPT_MIN_KEY_SIZE && size <= max_size;
+}
+
 static int fscrypt_provisioning_key_preparse(struct key_preparsed_payload *prep)
 {
 	const struct fscrypt_provisioning_key_payload *payload = prep->data;
 
-	if (prep->datalen < sizeof(*payload) + FSCRYPT_MIN_KEY_SIZE ||
-	    prep->datalen > sizeof(*payload) + FSCRYPT_MAX_KEY_SIZE)
+	if (prep->datalen < sizeof(*payload))
+		return -EINVAL;
+
+	if (!fscrypt_valid_key_size(prep->datalen - sizeof(*payload),
+				    payload->flags))
 		return -EINVAL;
 
 	if (payload->type != FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR &&
 	    payload->type != FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER)
 		return -EINVAL;
 
-	if (payload->__reserved)
+	if (payload->flags & ~FSCRYPT_ADD_KEY_FLAG_HW_WRAPPED)
 		return -EINVAL;
 
 	prep->payload.data[0] = kmemdup(payload, prep->datalen, GFP_KERNEL);
@@ -639,18 +681,18 @@ static struct key_type key_type_fscrypt_provisioning = {
  * Retrieve the raw key from the Linux keyring key specified by 'key_id', and
  * store it into 'secret'.
  *
- * The key must be of type "fscrypt-provisioning" and must have the field
- * fscrypt_provisioning_key_payload::type set to 'type', indicating that it's
- * only usable with fscrypt with the particular KDF version identified by
- * 'type'.  We don't use the "logon" key type because there's no way to
- * completely restrict the use of such keys; they can be used by any kernel API
- * that accepts "logon" keys and doesn't require a specific service prefix.
+ * The key must be of type "fscrypt-provisioning" and must have the 'type' and
+ * 'flags' field of the payload set to the given values, indicating that the key
+ * is intended for use for the specified purpose.  We don't use the "logon" key
+ * type because there's no way to completely restrict the use of such keys; they
+ * can be used by any kernel API that accepts "logon" keys and doesn't require a
+ * specific service prefix.
  *
  * The ability to specify the key via Linux keyring key is intended for cases
  * where userspace needs to re-add keys after the filesystem is unmounted and
  * re-mounted.  Most users should just provide the raw key directly instead.
  */
-static int get_keyring_key(u32 key_id, u32 type,
+static int get_keyring_key(u32 key_id, u32 type, u32 flags,
 			   struct fscrypt_master_key_secret *secret)
 {
 	key_ref_t ref;
@@ -667,8 +709,12 @@ static int get_keyring_key(u32 key_id, u32 type,
 		goto bad_key;
 	payload = key->payload.data[0];
 
-	/* Don't allow fscrypt v1 keys to be used as v2 keys and vice versa. */
-	if (payload->type != type)
+	/*
+	 * Don't allow fscrypt v1 keys to be used as v2 keys and vice versa.
+	 * Similarly, don't allow hardware-wrapped keys to be used as
+	 * non-hardware-wrapped keys and vice versa.
+	 */
+	if (payload->type != type || payload->flags != flags)
 		goto bad_key;
 
 	secret->size = key->datalen - sizeof(*payload);
@@ -734,15 +780,24 @@ int fscrypt_ioctl_add_key(struct file *filp, void __user *_uarg)
 		return -EACCES;
 
 	memset(&secret, 0, sizeof(secret));
+
+	if (arg.flags) {
+		if (arg.flags & ~FSCRYPT_ADD_KEY_FLAG_HW_WRAPPED)
+			return -EINVAL;
+		if (arg.key_spec.type != FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER)
+			return -EINVAL;
+		secret.is_hw_wrapped = true;
+	}
+
 	if (arg.key_id) {
 		if (arg.raw_size != 0)
 			return -EINVAL;
-		err = get_keyring_key(arg.key_id, arg.key_spec.type, &secret);
+		err = get_keyring_key(arg.key_id, arg.key_spec.type, arg.flags,
+				      &secret);
 		if (err)
 			goto out_wipe_secret;
 	} else {
-		if (arg.raw_size < FSCRYPT_MIN_KEY_SIZE ||
-		    arg.raw_size > FSCRYPT_MAX_KEY_SIZE)
+		if (!fscrypt_valid_key_size(arg.raw_size, arg.flags))
 			return -EINVAL;
 		secret.size = arg.raw_size;
 		err = -EFAULT;
@@ -770,13 +825,13 @@ EXPORT_SYMBOL_GPL(fscrypt_ioctl_add_key);
 static void
 fscrypt_get_test_dummy_secret(struct fscrypt_master_key_secret *secret)
 {
-	static u8 test_key[FSCRYPT_MAX_KEY_SIZE];
+	static u8 test_key[FSCRYPT_MAX_STANDARD_KEY_SIZE];
 
-	get_random_once(test_key, FSCRYPT_MAX_KEY_SIZE);
+	get_random_once(test_key, sizeof(test_key));
 
 	memset(secret, 0, sizeof(*secret));
-	secret->size = FSCRYPT_MAX_KEY_SIZE;
-	memcpy(secret->raw, test_key, FSCRYPT_MAX_KEY_SIZE);
+	secret->size = sizeof(test_key);
+	memcpy(secret->raw, test_key, sizeof(test_key));
 }
 
 int fscrypt_get_test_dummy_key_identifier(
@@ -790,7 +845,8 @@ int fscrypt_get_test_dummy_key_identifier(
 	err = fscrypt_init_hkdf(&secret.hkdf, secret.raw, secret.size);
 	if (err)
 		goto out;
-	err = fscrypt_hkdf_expand(&secret.hkdf, HKDF_CONTEXT_KEY_IDENTIFIER,
+	err = fscrypt_hkdf_expand(&secret.hkdf,
+				  HKDF_CONTEXT_KEY_IDENTIFIER_FOR_STANDARD_KEY,
 				  NULL, 0, key_identifier,
 				  FSCRYPT_KEY_IDENTIFIER_SIZE);
 out:
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index b4fe01ea4bd4c..b139c63bd39b0 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -153,7 +153,9 @@ int fscrypt_prepare_key(struct fscrypt_prepared_key *prep_key,
 	struct crypto_skcipher *tfm;
 
 	if (fscrypt_using_inline_encryption(ci))
-		return fscrypt_prepare_inline_crypt_key(prep_key, raw_key, ci);
+		return fscrypt_prepare_inline_crypt_key(prep_key, raw_key,
+							ci->ci_mode->keysize,
+							false, ci);
 
 	tfm = fscrypt_allocate_skcipher(ci->ci_mode, raw_key, ci->ci_inode);
 	if (IS_ERR(tfm))
@@ -195,14 +197,29 @@ static int setup_per_mode_enc_key(struct fscrypt_inode_info *ci,
 	struct fscrypt_mode *mode = ci->ci_mode;
 	const u8 mode_num = mode - fscrypt_modes;
 	struct fscrypt_prepared_key *prep_key;
-	u8 mode_key[FSCRYPT_MAX_KEY_SIZE];
+	u8 mode_key[FSCRYPT_MAX_STANDARD_KEY_SIZE];
 	u8 hkdf_info[sizeof(mode_num) + sizeof(sb->s_uuid)];
 	unsigned int hkdf_infolen = 0;
+	bool use_hw_wrapped_key = false;
 	int err;
 
 	if (WARN_ON_ONCE(mode_num > FSCRYPT_MODE_MAX))
 		return -EINVAL;
 
+	if (mk->mk_secret.is_hw_wrapped && S_ISREG(inode->i_mode)) {
+		/* Using a hardware-wrapped key for file contents encryption */
+		if (!fscrypt_using_inline_encryption(ci)) {
+			if (sb->s_flags & SB_INLINECRYPT)
+				fscrypt_warn(ci->ci_inode,
+					     "Hardware-wrapped key required, but no suitable inline encryption capabilities are available");
+			else
+				fscrypt_warn(ci->ci_inode,
+					     "Hardware-wrapped keys require inline encryption (-o inlinecrypt)");
+			return -EINVAL;
+		}
+		use_hw_wrapped_key = true;
+	}
+
 	prep_key = &keys[mode_num];
 	if (fscrypt_is_key_prepared(prep_key, ci)) {
 		ci->ci_enc_key = *prep_key;
@@ -214,6 +231,16 @@ static int setup_per_mode_enc_key(struct fscrypt_inode_info *ci,
 	if (fscrypt_is_key_prepared(prep_key, ci))
 		goto done_unlock;
 
+	if (use_hw_wrapped_key) {
+		err = fscrypt_prepare_inline_crypt_key(prep_key,
+						       mk->mk_secret.raw,
+						       mk->mk_secret.size, true,
+						       ci);
+		if (err)
+			goto out_unlock;
+		goto done_unlock;
+	}
+
 	BUILD_BUG_ON(sizeof(mode_num) != 1);
 	BUILD_BUG_ON(sizeof(sb->s_uuid) != 16);
 	BUILD_BUG_ON(sizeof(hkdf_info) != 17);
@@ -336,6 +363,19 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_inode_info *ci,
 {
 	int err;
 
+	if (mk->mk_secret.is_hw_wrapped &&
+	    !(ci->ci_policy.v2.flags & FSCRYPT_POLICY_FLAG_HW_WRAPPED_KEY)) {
+		fscrypt_warn(ci->ci_inode,
+			     "Given key is hardware-wrapped, but file isn't protected by a hardware-wrapped key");
+		return -EINVAL;
+	}
+	if ((ci->ci_policy.v2.flags & FSCRYPT_POLICY_FLAG_HW_WRAPPED_KEY) &&
+	    !mk->mk_secret.is_hw_wrapped) {
+		fscrypt_warn(ci->ci_inode,
+			     "File is protected by a hardware-wrapped key, but given key isn't hardware-wrapped");
+		return -EINVAL;
+	}
+
 	if (ci->ci_policy.v2.flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
 		/*
 		 * DIRECT_KEY: instead of deriving per-file encryption keys, the
@@ -362,7 +402,7 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_inode_info *ci,
 		   FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) {
 		err = fscrypt_setup_iv_ino_lblk_32_key(ci, mk);
 	} else {
-		u8 derived_key[FSCRYPT_MAX_KEY_SIZE];
+		u8 derived_key[FSCRYPT_MAX_STANDARD_KEY_SIZE];
 
 		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
 					  HKDF_CONTEXT_PER_FILE_ENC_KEY,
@@ -499,6 +539,14 @@ static int setup_file_encryption_key(struct fscrypt_inode_info *ci,
 
 	switch (ci->ci_policy.version) {
 	case FSCRYPT_POLICY_V1:
+		if (WARN_ON(mk->mk_secret.is_hw_wrapped)) {
+			/*
+			 * This should never happen, as adding a v1 policy key
+			 * that is hardware-wrapped isn't allowed.
+			 */
+			err = -EINVAL;
+			goto out_release_key;
+		}
 		err = fscrypt_setup_v1_file_key(ci, mk->mk_secret.raw);
 		break;
 	case FSCRYPT_POLICY_V2:
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index cf3b58ec32cce..8f2d44e6726a9 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -118,7 +118,8 @@ find_and_lock_process_key(const char *prefix,
 	payload = (const struct fscrypt_key *)ukp->data;
 
 	if (ukp->datalen != sizeof(struct fscrypt_key) ||
-	    payload->size < 1 || payload->size > FSCRYPT_MAX_KEY_SIZE) {
+	    payload->size < 1 ||
+	    payload->size > FSCRYPT_MAX_STANDARD_KEY_SIZE) {
 		fscrypt_warn(NULL,
 			     "key with description '%s' has invalid payload",
 			     key->description);
@@ -149,7 +150,7 @@ struct fscrypt_direct_key {
 	const struct fscrypt_mode	*dk_mode;
 	struct fscrypt_prepared_key	dk_key;
 	u8				dk_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
-	u8				dk_raw[FSCRYPT_MAX_KEY_SIZE];
+	u8				dk_raw[FSCRYPT_MAX_STANDARD_KEY_SIZE];
 };
 
 static void free_direct_key(struct fscrypt_direct_key *dk)
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 701259991277e..91102635e98aa 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -229,7 +229,8 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 	if (policy->flags & ~(FSCRYPT_POLICY_FLAGS_PAD_MASK |
 			      FSCRYPT_POLICY_FLAG_DIRECT_KEY |
 			      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64 |
-			      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32)) {
+			      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32 |
+			      FSCRYPT_POLICY_FLAG_HW_WRAPPED_KEY)) {
 		fscrypt_warn(inode, "Unsupported encryption flags (0x%02x)",
 			     policy->flags);
 		return false;
@@ -269,6 +270,14 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 		}
 	}
 
+	if ((policy->flags & FSCRYPT_POLICY_FLAG_HW_WRAPPED_KEY) &&
+	    !(policy->flags & (FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64 |
+			       FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32))) {
+		fscrypt_warn(inode,
+			     "HW_WRAPPED_KEY flag can only be used with IV_INO_LBLK_64 or IV_INO_LBLK_32");
+		return false;
+	}
+
 	if ((policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) &&
 	    !supported_direct_key_modes(inode, policy->contents_encryption_mode,
 					policy->filenames_encryption_mode))
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index 7a8f4c2901873..2724febca08fe 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -20,6 +20,7 @@
 #define FSCRYPT_POLICY_FLAG_DIRECT_KEY		0x04
 #define FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64	0x08
 #define FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32	0x10
+#define FSCRYPT_POLICY_FLAG_HW_WRAPPED_KEY	0x20
 
 /* Encryption algorithms */
 #define FSCRYPT_MODE_AES_256_XTS		1
@@ -119,7 +120,7 @@ struct fscrypt_key_specifier {
  */
 struct fscrypt_provisioning_key_payload {
 	__u32 type;
-	__u32 __reserved;
+	__u32 flags;
 	__u8 raw[];
 };
 
@@ -128,7 +129,9 @@ struct fscrypt_add_key_arg {
 	struct fscrypt_key_specifier key_spec;
 	__u32 raw_size;
 	__u32 key_id;
-	__u32 __reserved[8];
+#define FSCRYPT_ADD_KEY_FLAG_HW_WRAPPED			0x00000001
+	__u32 flags;
+	__u32 __reserved[7];
 	__u8 raw[];
 };
 

-- 
2.45.2


