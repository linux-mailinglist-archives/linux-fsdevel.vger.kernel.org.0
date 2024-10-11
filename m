Return-Path: <linux-fsdevel+bounces-31756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC45199ABC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 20:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AC71F250D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43C71D0DDA;
	Fri, 11 Oct 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="a/iLtV/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20C1D040E
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672877; cv=none; b=dQznBF7q3AG09qxyFwV/qr6r6x1B1ILA2xP5I+D62gQ3EH2Zeshpj1E+Xft8atZBgxuxp8TnID8QfxPjkWFNFNyURim2+068neo4HmJeQKmmcFP0ElCH6muw7ppk6rR8GF4M/l9QT5nxllvrWsMWlD/WPxanlIjzu9hCxKTW7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672877; c=relaxed/simple;
	bh=jKmpd4lqWYjC/bI56bxkX7EXYN8HCf2Hkw0YVqivTbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8VqXOYFfEB3CSRyT+EbjaXmKj2rdtbG6iOC9TTkvRN0eX5ONb93Kx4WSEbUiCaW9NmV5E3AOUxYm+tPhFCXN6LdDjBKfrk8lMFSpnsXmYZUGMzz6ZTRCJHB8I3pVhMHTajESYLGYdD8fYz0x2bln/KXGTHHE06tIRvZvjsmoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=a/iLtV/L; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4311420b63fso17092305e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672870; x=1729277670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9VxJ4jmLuD56SmEUpoUOEdV2HsuGTvp1hd0r9VZvLY=;
        b=a/iLtV/LoYcdBPDDUpmeHaZ/G9Lx0AVINbJchCrlFxcwgSwYkVD2fkAjXdaUO/D1uH
         tCphn1bebk298C+UNtmU2c145uxy8OTDdVD1H2/WZCrx9vG1sviYjCyI6FwqL+i/0e5J
         YUzyyfRAeW3FDf/zQLnwz6uprsVaqvNxDJBZLaKkwA3WouDJpeoGiDOomw8CDo0NebM2
         D1on1ErqZUwubv7AwkT0QQkZzqxJilXw8odJO9+DVsYW4husHlP6MMn86Pw17DtLPeV6
         7ZSL6Yfwl8VQHeWqRDW1KJfNRgi2yCZ5YpkkMGTeb3pf0/ViAK977biDBDNolBzvxuu3
         z4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672870; x=1729277670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9VxJ4jmLuD56SmEUpoUOEdV2HsuGTvp1hd0r9VZvLY=;
        b=TW3idhGN3x4iBhNYbq4aWdghZglxU/FL+gkd6KdL3gvECIGSkKnrbZRJ7s9jnNSU2k
         ja+tg9Vyz1Vla8Cev5p0yUZ85BS1KGa3qF55d+1v8ReGc5WS0Sw6b7IeDxPaPLT/pams
         n6ueIdjPVC2gNQiu7jnmuZjydhhuX4O9x76Hrd39OYdqSzjM2Et1ThhyOzY6xhJSuyw6
         Bue1SILmPdsFBCZbv22+tlVWD3yfhbCSKJsxQmCfUHI7l40fbLpmNsvTZqLZKp6OIP+7
         VgQT1Xj2PHt3zL/4JZdOGv7xsyoLlUr5Fb7nMsb7q6rb4sOoA2v6KNCXuYYtMmQeqYv8
         Zs+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR+JNkZ9OMn8AFaR/MowKbNP4WpdqYEuP/J6ttWcDI8za74CmFt8RszdGNgRr6Q2II7wcgeETCZh4Koj2O@vger.kernel.org
X-Gm-Message-State: AOJu0YzdllSxY2uUAjqE9h2pCem0uoRxaXGFa5yzG2FfnFDropwtKOvF
	KKYiZe29ILXv7ArgqOzL7bRp8hUCv7aM2xpCVi628OyHIP/+CdqvQJvYotfvKoY=
X-Google-Smtp-Source: AGHT+IG9XeK1ZJbQFlnDi+MQX22opDpqQ9TV9krLRzQ61dIv9JL7pNlicWbCfnHSREoPg83EQJOd3Q==
X-Received: by 2002:adf:e852:0:b0:37d:4fe9:b6a4 with SMTP id ffacd0b85a97d-37d600c8cc7mr367322f8f.50.1728672869346;
        Fri, 11 Oct 2024 11:54:29 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:00 +0200
Subject: [PATCH v7 01/17] blk-crypto: add basic hardware-wrapped key
 support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-1-e3f7a752059b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=34532;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=SYxIafHRjfmwA6JlhloJqr10zFsTaHOg0dvLgW2y5O8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRctEKhSzkZF4k9HAcBuhdoEMA2jK2w3TDnT
 2usuP+XFIqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0XAAKCRARpy6gFHHX
 co8RD/9fvlpQu5v7QpXzPKZOQ6cYohkCkHq+ffOWMFBJh4ZdwmwVp//uqr6Y400qAs7MO1rr4c4
 WyZeRUZDuFsOQwGZmsTqeHs1sXQCrab+K1WTqEuV4SxmZTKZEGecq61qdj8rR/DRLIwNsy+AKVP
 awopqkiJCml+4a7RimTDRK+W1EVy5K2qsXywbp+kX8QH8/T9CnwqXcAgoUFcugekd6Svh6iE8rZ
 EYkJXOxGFO3b4imX3wVBbO7kyUUlKKG/5g5da0EdNkUNgU+ExXNf+iybBW8uAL0U124mo9P3Uxn
 E/mooEmqFS37zlB6TKRuI4fB9jf3r4aWSZ/Wnrwyq/b+RVmQBkZTNk6syueoY55u99k1jQiYAjI
 EiiFAOtp3P2atYlcLxiAZIWTkiSFA2nrVukDBvFiG3CJiFz/J9jKDGpFBz8iP2CXcYdIkKWsusm
 m2OjmjyA6IkZ3peZ7uPLfHjqgsNJXA5oZWhm1v+6/9P4zLICoEJrgMJ1MWxEhaIWaM5Y1WPxk5Z
 0/uH8lJw6yIzl9M+fqZsPZbFcYknd5DpqkkV+0Du3yvc912VmO8fCaEzd8e+4nGvAQ4gb4Zq60u
 n9dIcpJ1C5lTkpY08Ou4egU1/lr2vyDRKmFbdY8uBzr+tQBH6c5DP+VI3lB8FIuI9ksJX8B817X
 Gc2XaH5UvQTuMvQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Eric Biggers <ebiggers@google.com>

To prevent keys from being compromised if an attacker acquires read
access to kernel memory, some inline encryption hardware can accept keys
which are wrapped by a per-boot hardware-internal key.  This avoids
needing to keep the raw keys in kernel memory, without limiting the
number of keys that can be used.  Such hardware also supports deriving a
"software secret" for cryptographic tasks that can't be handled by
inline encryption; this is needed for fscrypt to work properly.

To support this hardware, allow struct blk_crypto_key to represent a
hardware-wrapped key as an alternative to a standard key, and make
drivers set flags in struct blk_crypto_profile to indicate which types
of keys they support.  Also add the ->derive_sw_secret() low-level
operation, which drivers supporting wrapped keys must implement.

For more information, see the detailed documentation which this patch
adds to Documentation/block/inline-encryption.rst.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/block/inline-encryption.rst | 213 +++++++++++++++++++++++++++++-
 block/blk-crypto-fallback.c               |   5 +-
 block/blk-crypto-internal.h               |   1 +
 block/blk-crypto-profile.c                |  46 +++++++
 block/blk-crypto.c                        |  51 +++++--
 drivers/md/dm-table.c                     |   1 +
 drivers/mmc/host/cqhci-crypto.c           |   2 +
 drivers/ufs/core/ufshcd-crypto.c          |   1 +
 fs/crypto/inline_crypt.c                  |   4 +-
 include/linux/blk-crypto-profile.h        |  20 +++
 include/linux/blk-crypto.h                |  74 ++++++++++-
 11 files changed, 394 insertions(+), 24 deletions(-)

diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
index 90b733422ed4..07218455a2bc 100644
--- a/Documentation/block/inline-encryption.rst
+++ b/Documentation/block/inline-encryption.rst
@@ -77,10 +77,10 @@ Basic design
 ============
 
 We introduce ``struct blk_crypto_key`` to represent an inline encryption key and
-how it will be used.  This includes the actual bytes of the key; the size of the
-key; the algorithm and data unit size the key will be used with; and the number
-of bytes needed to represent the maximum data unit number the key will be used
-with.
+how it will be used.  This includes the type of the key (standard or
+hardware-wrapped); the actual bytes of the key; the size of the key; the
+algorithm and data unit size the key will be used with; and the number of bytes
+needed to represent the maximum data unit number the key will be used with.
 
 We introduce ``struct bio_crypt_ctx`` to represent an encryption context.  It
 contains a data unit number and a pointer to a blk_crypto_key.  We add pointers
@@ -301,3 +301,208 @@ kernel will pretend that the device does not support hardware inline encryption
 When the crypto API fallback is enabled, this means that all bios with and
 encryption context will use the fallback, and IO will complete as usual.  When
 the fallback is disabled, a bio with an encryption context will be failed.
+
+.. _hardware_wrapped_keys:
+
+Hardware-wrapped keys
+=====================
+
+Motivation and threat model
+---------------------------
+
+Linux storage encryption (dm-crypt, fscrypt, eCryptfs, etc.) traditionally
+relies on the raw encryption key(s) being present in kernel memory so that the
+encryption can be performed.  This traditionally isn't seen as a problem because
+the key(s) won't be present during an offline attack, which is the main type of
+attack that storage encryption is intended to protect from.
+
+However, there is an increasing desire to also protect users' data from other
+types of attacks (to the extent possible), including:
+
+- Cold boot attacks, where an attacker with physical access to a system suddenly
+  powers it off, then immediately dumps the system memory to extract recently
+  in-use encryption keys, then uses these keys to decrypt user data on-disk.
+
+- Online attacks where the attacker is able to read kernel memory without fully
+  compromising the system, followed by an offline attack where any extracted
+  keys can be used to decrypt user data on-disk.  An example of such an online
+  attack would be if the attacker is able to run some code on the system that
+  exploits a Meltdown-like vulnerability but is unable to escalate privileges.
+
+- Online attacks where the attacker fully compromises the system, but their data
+  exfiltration is significantly time-limited and/or bandwidth-limited, so in
+  order to completely exfiltrate the data they need to extract the encryption
+  keys to use in a later offline attack.
+
+Hardware-wrapped keys are a feature of inline encryption hardware that is
+designed to protect users' data from the above attacks (to the extent possible),
+without introducing limitations such as a maximum number of keys.
+
+Note that it is impossible to **fully** protect users' data from these attacks.
+Even in the attacks where the attacker "just" gets read access to kernel memory,
+they can still extract any user data that is present in memory, including
+plaintext pagecache pages of encrypted files.  The focus here is just on
+protecting the encryption keys, as those instantly give access to **all** user
+data in any following offline attack, rather than just some of it (where which
+data is included in that "some" might not be controlled by the attacker).
+
+Solution overview
+-----------------
+
+Inline encryption hardware typically has "keyslots" into which software can
+program keys for the hardware to use; the contents of keyslots typically can't
+be read back by software.  As such, the above security goals could be achieved
+if the kernel simply erased its copy of the key(s) after programming them into
+keyslot(s) and thereafter only referred to them via keyslot number.
+
+However, that naive approach runs into the problem that it limits the number of
+unlocked keys to the number of keyslots, which typically is a small number.  In
+cases where there is only one encryption key system-wide (e.g., a full-disk
+encryption key), that can be tolerable.  However, in general there can be many
+logged-in users with many different keys, and/or many running applications with
+application-specific encrypted storage areas.  This is especially true if
+file-based encryption (e.g. fscrypt) is being used.
+
+Thus, it is important for the kernel to still have a way to "remind" the
+hardware about a key, without actually having the raw key itself.  This would
+ensure that the number of hardware keyslots only limits the number of active I/O
+requests, not other things such as the number of logged-in users, the number of
+running apps, or the number of encrypted storage areas that apps can create.
+
+Somewhat less importantly, it is also desirable that the raw keys are never
+visible to software at all, even while being initially unlocked.  This would
+ensure that a read-only compromise of system memory will never allow a key to be
+extracted to be used off-system, even if it occurs when a key is being unlocked.
+
+To solve all these problems, some vendors of inline encryption hardware have
+made their hardware support *hardware-wrapped keys*.  Hardware-wrapped keys
+are encrypted keys that can only be unwrapped (decrypted) and used by hardware
+-- either by the inline encryption hardware itself, or by a dedicated hardware
+block that can directly provision keys to the inline encryption hardware.
+
+(We refer to them as "hardware-wrapped keys" rather than simply "wrapped keys"
+to add some clarity in cases where there could be other types of wrapped keys,
+such as in file-based encryption.  Key wrapping is a commonly used technique.)
+
+The key which wraps (encrypts) hardware-wrapped keys is a hardware-internal key
+that is never exposed to software; it is either a persistent key (a "long-term
+wrapping key") or a per-boot key (an "ephemeral wrapping key").  The long-term
+wrapped form of the key is what is initially unlocked, but it is erased from
+memory as soon as it is converted into an ephemerally-wrapped key.  In-use
+hardware-wrapped keys are always ephemerally-wrapped, not long-term wrapped.
+
+As inline encryption hardware can only be used to encrypt/decrypt data on-disk,
+the hardware also includes a level of indirection; it doesn't use the unwrapped
+key directly for inline encryption, but rather derives both an inline encryption
+key and a "software secret" from it.  Software can use the "software secret" for
+tasks that can't use the inline encryption hardware, such as filenames
+encryption.  The software secret is not protected from memory compromise.
+
+Key hierarchy
+-------------
+
+Here is the key hierarchy for a hardware-wrapped key::
+
+                       Hardware-wrapped key
+                                |
+                                |
+                          <Hardware KDF>
+                                |
+                  -----------------------------
+                  |                           |
+        Inline encryption key           Software secret
+
+The components are:
+
+- *Hardware-wrapped key*: a key for the hardware's KDF (Key Derivation
+  Function), in ephemerally-wrapped form.  The key wrapping algorithm is a
+  hardware implementation detail that doesn't impact kernel operation, but a
+  strong authenticated encryption algorithm such as AES-256-GCM is recommended.
+
+- *Hardware KDF*: a KDF (Key Derivation Function) which the hardware uses to
+  derive subkeys after unwrapping the wrapped key.  The hardware's choice of KDF
+  doesn't impact kernel operation, but it does need to be known for testing
+  purposes, and it's also assumed to have at least a 256-bit security strength.
+  All known hardware uses the SP800-108 KDF in Counter Mode with AES-256-CMAC,
+  with a particular choice of labels and contexts; new hardware should use this
+  already-vetted KDF.
+
+- *Inline encryption key*: a derived key which the hardware directly provisions
+  to a keyslot of the inline encryption hardware, without exposing it to
+  software.  In all known hardware, this will always be an AES-256-XTS key.
+  However, in principle other encryption algorithms could be supported too.
+  Hardware must derive distinct subkeys for each supported encryption algorithm.
+
+- *Software secret*: a derived key which the hardware returns to software so
+  that software can use it for cryptographic tasks that can't use inline
+  encryption.  This value is cryptographically isolated from the inline
+  encryption key, i.e. knowing one doesn't reveal the other.  (The KDF ensures
+  this.)  Currently, the software secret is always 32 bytes and thus is suitable
+  for cryptographic applications that require up to a 256-bit security strength.
+  Some use cases (e.g. full-disk encryption) won't require the software secret.
+
+Example: in the case of fscrypt, the fscrypt master key (the key that protects a
+particular set of encrypted directories) is made hardware-wrapped.  The inline
+encryption key is used as the file contents encryption key, while the software
+secret (rather than the master key directly) is used to key fscrypt's KDF
+(HKDF-SHA512) to derive other subkeys such as filenames encryption keys.
+
+Note that currently this design assumes a single inline encryption key per
+hardware-wrapped key, without any further key derivation.  Thus, in the case of
+fscrypt, currently hardware-wrapped keys are only compatible with the "inline
+encryption optimized" settings, which use one file contents encryption key per
+encryption policy rather than one per file.  This design could be extended to
+make the hardware derive per-file keys using per-file nonces passed down the
+storage stack, and in fact some hardware already supports this; future work is
+planned to remove this limitation by adding the corresponding kernel support.
+
+Kernel support
+--------------
+
+The inline encryption support of the kernel's block layer ("blk-crypto") has
+been extended to support hardware-wrapped keys as an alternative to standard
+keys, when hardware support is available.  This works in the following way:
+
+- A ``key_types_supported`` field is added to the crypto capabilities in
+  ``struct blk_crypto_profile``.  This allows device drivers to declare that
+  they support standard keys, hardware-wrapped keys, or both.
+
+- ``struct blk_crypto_key`` can now contain a hardware-wrapped key as an
+  alternative to a standard key; a ``key_type`` field is added to
+  ``struct blk_crypto_config`` to distinguish between the different key types.
+  This allows users of blk-crypto to en/decrypt data using a hardware-wrapped
+  key in a way very similar to using a standard key.
+
+- A new method ``blk_crypto_ll_ops::derive_sw_secret`` is added.  Device drivers
+  that support hardware-wrapped keys must implement this method.  Users of
+  blk-crypto can call ``blk_crypto_derive_sw_secret()`` to access this method.
+
+- The programming and eviction of hardware-wrapped keys happens via
+  ``blk_crypto_ll_ops::keyslot_program`` and
+  ``blk_crypto_ll_ops::keyslot_evict``, just like it does for standard keys.  If
+  a driver supports hardware-wrapped keys, then it must handle hardware-wrapped
+  keys being passed to these methods.
+
+blk-crypto-fallback doesn't support hardware-wrapped keys.  Therefore,
+hardware-wrapped keys can only be used with actual inline encryption hardware.
+
+Testability
+-----------
+
+Both the hardware KDF and the inline encryption itself are well-defined
+algorithms that don't depend on any secrets other than the unwrapped key.
+Therefore, if the unwrapped key is known to software, these algorithms can be
+reproduced in software in order to verify the ciphertext that is written to disk
+by the inline encryption hardware.
+
+However, the unwrapped key will only be known to software for testing if the
+"import" functionality is used.  Proper testing is not possible in the
+"generate" case where the hardware generates the key itself.  The correct
+operation of the "generate" mode thus relies on the security and correctness of
+the hardware RNG and its use to generate the key, as well as the testing of the
+"import" mode as that should cover all parts other than the key generation.
+
+For an example of a test that verifies the ciphertext written to disk in the
+"import" mode, see the fscrypt hardware-wrapped key tests in xfstests, or
+`Android's vts_kernel_encryption_test
+<https://android.googlesource.com/platform/test/vts-testcase/kernel/+/refs/heads/master/encryption/>`_.
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index b1e7415f8439..00f638955657 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -87,7 +87,7 @@ static struct bio_set crypto_bio_split;
  * This is the key we set when evicting a keyslot. This *should* be the all 0's
  * key, but AES-XTS rejects that key, so we use some random bytes instead.
  */
-static u8 blank_key[BLK_CRYPTO_MAX_KEY_SIZE];
+static u8 blank_key[BLK_CRYPTO_MAX_STANDARD_KEY_SIZE];
 
 static void blk_crypto_fallback_evict_keyslot(unsigned int slot)
 {
@@ -539,7 +539,7 @@ static int blk_crypto_fallback_init(void)
 	if (blk_crypto_fallback_inited)
 		return 0;
 
-	get_random_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
+	get_random_bytes(blank_key, sizeof(blank_key));
 
 	err = bioset_init(&crypto_bio_split, 64, 0, 0);
 	if (err)
@@ -561,6 +561,7 @@ static int blk_crypto_fallback_init(void)
 
 	blk_crypto_fallback_profile->ll_ops = blk_crypto_fallback_ll_ops;
 	blk_crypto_fallback_profile->max_dun_bytes_supported = BLK_CRYPTO_MAX_IV_SIZE;
+	blk_crypto_fallback_profile->key_types_supported = BLK_CRYPTO_KEY_TYPE_STANDARD;
 
 	/* All blk-crypto modes have a crypto API fallback. */
 	for (i = 0; i < BLK_ENCRYPTION_MODE_MAX; i++)
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 93a141979694..1893df9a8f06 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -14,6 +14,7 @@ struct blk_crypto_mode {
 	const char *name; /* name of this mode, shown in sysfs */
 	const char *cipher_str; /* crypto API name (for fallback case) */
 	unsigned int keysize; /* key size in bytes */
+	unsigned int security_strength; /* security strength in bytes */
 	unsigned int ivsize; /* iv size in bytes */
 };
 
diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 7fabc883e39f..1b92276ed2fc 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -352,6 +352,8 @@ bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
 		return false;
 	if (profile->max_dun_bytes_supported < cfg->dun_bytes)
 		return false;
+	if (!(profile->key_types_supported & cfg->key_type))
+		return false;
 	return true;
 }
 
@@ -462,6 +464,44 @@ bool blk_crypto_register(struct blk_crypto_profile *profile,
 }
 EXPORT_SYMBOL_GPL(blk_crypto_register);
 
+/**
+ * blk_crypto_derive_sw_secret() - Derive software secret from wrapped key
+ * @bdev: a block device that supports hardware-wrapped keys
+ * @eph_key: the hardware-wrapped key in ephemerally-wrapped form
+ * @eph_key_size: size of @eph_key in bytes
+ * @sw_secret: (output) the software secret
+ *
+ * Given a hardware-wrapped key in ephemerally-wrapped form (the same form that
+ * it is used for I/O), ask the hardware to derive the secret which software can
+ * use for cryptographic tasks other than inline encryption.  This secret is
+ * guaranteed to be cryptographically isolated from the inline encryption key,
+ * i.e. derived with a different KDF context.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the block device doesn't support
+ *	   hardware-wrapped keys, -EBADMSG if the key isn't a valid
+ *	   hardware-wrapped key, or another -errno code.
+ */
+int blk_crypto_derive_sw_secret(struct block_device *bdev,
+				const u8 *eph_key, size_t eph_key_size,
+				u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	struct blk_crypto_profile *profile =
+		bdev_get_queue(bdev)->crypto_profile;
+	int err;
+
+	if (!profile)
+		return -EOPNOTSUPP;
+	if (!(profile->key_types_supported & BLK_CRYPTO_KEY_TYPE_HW_WRAPPED))
+		return -EOPNOTSUPP;
+	if (!profile->ll_ops.derive_sw_secret)
+		return -EOPNOTSUPP;
+	blk_crypto_hw_enter(profile);
+	err = profile->ll_ops.derive_sw_secret(profile, eph_key, eph_key_size,
+					       sw_secret);
+	blk_crypto_hw_exit(profile);
+	return err;
+}
+
 /**
  * blk_crypto_intersect_capabilities() - restrict supported crypto capabilities
  *					 by child device
@@ -485,10 +525,12 @@ void blk_crypto_intersect_capabilities(struct blk_crypto_profile *parent,
 			    child->max_dun_bytes_supported);
 		for (i = 0; i < ARRAY_SIZE(child->modes_supported); i++)
 			parent->modes_supported[i] &= child->modes_supported[i];
+		parent->key_types_supported &= child->key_types_supported;
 	} else {
 		parent->max_dun_bytes_supported = 0;
 		memset(parent->modes_supported, 0,
 		       sizeof(parent->modes_supported));
+		parent->key_types_supported = 0;
 	}
 }
 EXPORT_SYMBOL_GPL(blk_crypto_intersect_capabilities);
@@ -521,6 +563,9 @@ bool blk_crypto_has_capabilities(const struct blk_crypto_profile *target,
 	    target->max_dun_bytes_supported)
 		return false;
 
+	if (reference->key_types_supported & ~target->key_types_supported)
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(blk_crypto_has_capabilities);
@@ -555,5 +600,6 @@ void blk_crypto_update_capabilities(struct blk_crypto_profile *dst,
 	       sizeof(dst->modes_supported));
 
 	dst->max_dun_bytes_supported = src->max_dun_bytes_supported;
+	dst->key_types_supported = src->key_types_supported;
 }
 EXPORT_SYMBOL_GPL(blk_crypto_update_capabilities);
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 4d760b092deb..5a09d0ef1a01 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -23,24 +23,28 @@ const struct blk_crypto_mode blk_crypto_modes[] = {
 		.name = "AES-256-XTS",
 		.cipher_str = "xts(aes)",
 		.keysize = 64,
+		.security_strength = 32,
 		.ivsize = 16,
 	},
 	[BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV] = {
 		.name = "AES-128-CBC-ESSIV",
 		.cipher_str = "essiv(cbc(aes),sha256)",
 		.keysize = 16,
+		.security_strength = 16,
 		.ivsize = 16,
 	},
 	[BLK_ENCRYPTION_MODE_ADIANTUM] = {
 		.name = "Adiantum",
 		.cipher_str = "adiantum(xchacha12,aes)",
 		.keysize = 32,
+		.security_strength = 32,
 		.ivsize = 32,
 	},
 	[BLK_ENCRYPTION_MODE_SM4_XTS] = {
 		.name = "SM4-XTS",
 		.cipher_str = "xts(sm4)",
 		.keysize = 32,
+		.security_strength = 16,
 		.ivsize = 16,
 	},
 };
@@ -76,9 +80,15 @@ static int __init bio_crypt_ctx_init(void)
 	/* This is assumed in various places. */
 	BUILD_BUG_ON(BLK_ENCRYPTION_MODE_INVALID != 0);
 
-	/* Sanity check that no algorithm exceeds the defined limits. */
+	/*
+	 * Validate the crypto mode properties.  This ideally would be done with
+	 * static assertions, but boot-time checks are the next best thing.
+	 */
 	for (i = 0; i < BLK_ENCRYPTION_MODE_MAX; i++) {
-		BUG_ON(blk_crypto_modes[i].keysize > BLK_CRYPTO_MAX_KEY_SIZE);
+		BUG_ON(blk_crypto_modes[i].keysize >
+		       BLK_CRYPTO_MAX_STANDARD_KEY_SIZE);
+		BUG_ON(blk_crypto_modes[i].security_strength >
+		       blk_crypto_modes[i].keysize);
 		BUG_ON(blk_crypto_modes[i].ivsize > BLK_CRYPTO_MAX_IV_SIZE);
 	}
 
@@ -315,8 +325,9 @@ int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
 /**
  * blk_crypto_init_key() - Prepare a key for use with blk-crypto
  * @blk_key: Pointer to the blk_crypto_key to initialize.
- * @raw_key: Pointer to the raw key. Must be the correct length for the chosen
- *	     @crypto_mode; see blk_crypto_modes[].
+ * @raw_key: the raw bytes of the key
+ * @raw_key_size: size of the raw key in bytes
+ * @key_type: type of the key -- either standard or hardware-wrapped
  * @crypto_mode: identifier for the encryption algorithm to use
  * @dun_bytes: number of bytes that will be used to specify the DUN when this
  *	       key is used
@@ -325,7 +336,9 @@ int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
  * Return: 0 on success, -errno on failure.  The caller is responsible for
  *	   zeroizing both blk_key and raw_key when done with them.
  */
-int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
+int blk_crypto_init_key(struct blk_crypto_key *blk_key,
+			const u8 *raw_key, size_t raw_key_size,
+			enum blk_crypto_key_type key_type,
 			enum blk_crypto_mode_num crypto_mode,
 			unsigned int dun_bytes,
 			unsigned int data_unit_size)
@@ -338,8 +351,19 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 		return -EINVAL;
 
 	mode = &blk_crypto_modes[crypto_mode];
-	if (mode->keysize == 0)
+	switch (key_type) {
+	case BLK_CRYPTO_KEY_TYPE_STANDARD:
+		if (raw_key_size != mode->keysize)
+			return -EINVAL;
+		break;
+	case BLK_CRYPTO_KEY_TYPE_HW_WRAPPED:
+		if (raw_key_size < mode->security_strength ||
+		    raw_key_size > BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE)
+			return -EINVAL;
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	if (dun_bytes == 0 || dun_bytes > mode->ivsize)
 		return -EINVAL;
@@ -350,9 +374,10 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 	blk_key->crypto_cfg.crypto_mode = crypto_mode;
 	blk_key->crypto_cfg.dun_bytes = dun_bytes;
 	blk_key->crypto_cfg.data_unit_size = data_unit_size;
+	blk_key->crypto_cfg.key_type = key_type;
 	blk_key->data_unit_size_bits = ilog2(data_unit_size);
-	blk_key->size = mode->keysize;
-	memcpy(blk_key->raw, raw_key, mode->keysize);
+	blk_key->size = raw_key_size;
+	memcpy(blk_key->raw, raw_key, raw_key_size);
 
 	return 0;
 }
@@ -372,8 +397,10 @@ bool blk_crypto_config_supported_natively(struct block_device *bdev,
 bool blk_crypto_config_supported(struct block_device *bdev,
 				 const struct blk_crypto_config *cfg)
 {
-	return IS_ENABLED(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) ||
-	       blk_crypto_config_supported_natively(bdev, cfg);
+	if (IS_ENABLED(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) &&
+	    cfg->key_type == BLK_CRYPTO_KEY_TYPE_STANDARD)
+		return true;
+	return blk_crypto_config_supported_natively(bdev, cfg);
 }
 
 /**
@@ -396,6 +423,10 @@ int blk_crypto_start_using_key(struct block_device *bdev,
 {
 	if (blk_crypto_config_supported_natively(bdev, &key->crypto_cfg))
 		return 0;
+	if (key->crypto_cfg.key_type != BLK_CRYPTO_KEY_TYPE_STANDARD) {
+		pr_warn_once("tried to use wrapped key, but hardware doesn't support it\n");
+		return -EOPNOTSUPP;
+	}
 	return blk_crypto_fallback_start_using_mode(key->crypto_cfg.crypto_mode);
 }
 
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index dbd39b9722b9..f6af54551881 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1255,6 +1255,7 @@ static int dm_table_construct_crypto_profile(struct dm_table *t)
 	profile->max_dun_bytes_supported = UINT_MAX;
 	memset(profile->modes_supported, 0xFF,
 	       sizeof(profile->modes_supported));
+	profile->key_types_supported = ~0;
 
 	for (i = 0; i < t->num_targets; i++) {
 		struct dm_target *ti = dm_table_get_target(t, i);
diff --git a/drivers/mmc/host/cqhci-crypto.c b/drivers/mmc/host/cqhci-crypto.c
index d5f4b6972f63..6652982410ec 100644
--- a/drivers/mmc/host/cqhci-crypto.c
+++ b/drivers/mmc/host/cqhci-crypto.c
@@ -210,6 +210,8 @@ int cqhci_crypto_init(struct cqhci_host *cq_host)
 	/* Unfortunately, CQHCI crypto only supports 32 DUN bits. */
 	profile->max_dun_bytes_supported = 4;
 
+	profile->key_types_supported = BLK_CRYPTO_KEY_TYPE_STANDARD;
+
 	/*
 	 * Cache all the crypto capabilities and advertise the supported crypto
 	 * modes and data unit sizes to the block layer.
diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index a714dad82cd1..7d3a3e228db0 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -195,6 +195,7 @@ int ufshcd_hba_init_crypto_capabilities(struct ufs_hba *hba)
 	hba->crypto_profile.ll_ops = ufshcd_crypto_ops;
 	/* UFS only supports 8 bytes for any DUN */
 	hba->crypto_profile.max_dun_bytes_supported = 8;
+	hba->crypto_profile.key_types_supported = BLK_CRYPTO_KEY_TYPE_STANDARD;
 	hba->crypto_profile.dev = hba->dev;
 
 	/*
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 40de69860dcf..ee92c78e798b 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -130,6 +130,7 @@ int fscrypt_select_encryption_impl(struct fscrypt_inode_info *ci)
 	crypto_cfg.crypto_mode = ci->ci_mode->blk_crypto_mode;
 	crypto_cfg.data_unit_size = 1U << ci->ci_data_unit_bits;
 	crypto_cfg.dun_bytes = fscrypt_get_dun_bytes(ci);
+	crypto_cfg.key_type = BLK_CRYPTO_KEY_TYPE_STANDARD;
 
 	devs = fscrypt_get_devices(sb, &num_devs);
 	if (IS_ERR(devs))
@@ -166,7 +167,8 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 	if (!blk_key)
 		return -ENOMEM;
 
-	err = blk_crypto_init_key(blk_key, raw_key, crypto_mode,
+	err = blk_crypto_init_key(blk_key, raw_key, ci->ci_mode->keysize,
+				  BLK_CRYPTO_KEY_TYPE_STANDARD, crypto_mode,
 				  fscrypt_get_dun_bytes(ci),
 				  1U << ci->ci_data_unit_bits);
 	if (err) {
diff --git a/include/linux/blk-crypto-profile.h b/include/linux/blk-crypto-profile.h
index 90ab33cb5d0e..229287a7f451 100644
--- a/include/linux/blk-crypto-profile.h
+++ b/include/linux/blk-crypto-profile.h
@@ -57,6 +57,20 @@ struct blk_crypto_ll_ops {
 	int (*keyslot_evict)(struct blk_crypto_profile *profile,
 			     const struct blk_crypto_key *key,
 			     unsigned int slot);
+
+	/**
+	 * @derive_sw_secret: Derive the software secret from a hardware-wrapped
+	 *		      key in ephemerally-wrapped form.
+	 *
+	 * This only needs to be implemented if BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
+	 * is supported.
+	 *
+	 * Must return 0 on success, -EBADMSG if the key is invalid, or another
+	 * -errno code on other errors.
+	 */
+	int (*derive_sw_secret)(struct blk_crypto_profile *profile,
+				const u8 *eph_key, size_t eph_key_size,
+				u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
 };
 
 /**
@@ -84,6 +98,12 @@ struct blk_crypto_profile {
 	 */
 	unsigned int max_dun_bytes_supported;
 
+	/**
+	 * @key_types_supported: A bitmask of the supported key types:
+	 * BLK_CRYPTO_KEY_TYPE_STANDARD and/or BLK_CRYPTO_KEY_TYPE_HW_WRAPPED.
+	 */
+	unsigned int key_types_supported;
+
 	/**
 	 * @modes_supported: Array of bitmasks that specifies whether each
 	 * combination of crypto mode and data unit size is supported.
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 5e5822c18ee4..19066d86ecbf 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -17,7 +17,58 @@ enum blk_crypto_mode_num {
 	BLK_ENCRYPTION_MODE_MAX,
 };
 
-#define BLK_CRYPTO_MAX_KEY_SIZE		64
+/*
+ * Supported types of keys.  Must be bitflags due to their use in
+ * blk_crypto_profile::key_types_supported.
+ */
+enum blk_crypto_key_type {
+	/*
+	 * Standard keys (i.e. "software keys").  These keys are simply kept in
+	 * raw, plaintext form in kernel memory.
+	 */
+	BLK_CRYPTO_KEY_TYPE_STANDARD = 1 << 0,
+
+	/*
+	 * Hardware-wrapped keys.  These keys are only present in kernel memory
+	 * in ephemerally-wrapped form, and they can only be unwrapped by
+	 * dedicated hardware.  For details, see the "Hardware-wrapped keys"
+	 * section of Documentation/block/inline-encryption.rst.
+	 */
+	BLK_CRYPTO_KEY_TYPE_HW_WRAPPED = 1 << 1,
+};
+
+/*
+ * Currently the maximum standard key size is 64 bytes, as that is the key size
+ * of BLK_ENCRYPTION_MODE_AES_256_XTS which takes the longest key.
+ *
+ * The maximum hardware-wrapped key size depends on the hardware's key wrapping
+ * algorithm, which is a hardware implementation detail, so it isn't precisely
+ * specified.  But currently 128 bytes is plenty in practice.  Implementations
+ * are recommended to wrap a 32-byte key for the hardware KDF with AES-256-GCM,
+ * which should result in a size closer to 64 bytes than 128.
+ *
+ * Both of these values can trivially be increased if ever needed.
+ */
+#define BLK_CRYPTO_MAX_STANDARD_KEY_SIZE	64
+#define BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE	128
+
+/* This should use max(), but max() doesn't work in a struct definition. */
+#define BLK_CRYPTO_MAX_ANY_KEY_SIZE \
+	(BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE > \
+	 BLK_CRYPTO_MAX_STANDARD_KEY_SIZE ? \
+	 BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE : BLK_CRYPTO_MAX_STANDARD_KEY_SIZE)
+
+/*
+ * Size of the "software secret" which can be derived from a hardware-wrapped
+ * key.  This is currently always 32 bytes.  Note, the choice of 32 bytes
+ * assumes that the software secret is only used directly for algorithms that
+ * don't require more than a 256-bit key to get the desired security strength.
+ * If it were to be used e.g. directly as an AES-256-XTS key, then this would
+ * need to be increased (which is possible if hardware supports it, but care
+ * would need to be taken to avoid breaking users who need exactly 32 bytes).
+ */
+#define BLK_CRYPTO_SW_SECRET_SIZE	32
+
 /**
  * struct blk_crypto_config - an inline encryption key's crypto configuration
  * @crypto_mode: encryption algorithm this key is for
@@ -26,20 +77,23 @@ enum blk_crypto_mode_num {
  *	ciphertext.  This is always a power of 2.  It might be e.g. the
  *	filesystem block size or the disk sector size.
  * @dun_bytes: the maximum number of bytes of DUN used when using this key
+ * @key_type: the type of this key -- either standard or hardware-wrapped
  */
 struct blk_crypto_config {
 	enum blk_crypto_mode_num crypto_mode;
 	unsigned int data_unit_size;
 	unsigned int dun_bytes;
+	enum blk_crypto_key_type key_type;
 };
 
 /**
  * struct blk_crypto_key - an inline encryption key
- * @crypto_cfg: the crypto configuration (like crypto_mode, key size) for this
- *		key
+ * @crypto_cfg: the crypto mode, data unit size, key type, and other
+ *		characteristics of this key and how it will be used
  * @data_unit_size_bits: log2 of data_unit_size
- * @size: size of this key in bytes (determined by @crypto_cfg.crypto_mode)
- * @raw: the raw bytes of this key.  Only the first @size bytes are used.
+ * @size: size of this key in bytes.  The size of a standard key is fixed for a
+ *	  given crypto mode, but the size of a hardware-wrapped key can vary.
+ * @raw: the bytes of this key.  Only the first @size bytes are significant.
  *
  * A blk_crypto_key is immutable once created, and many bios can reference it at
  * the same time.  It must not be freed until all bios using it have completed
@@ -49,7 +103,7 @@ struct blk_crypto_key {
 	struct blk_crypto_config crypto_cfg;
 	unsigned int data_unit_size_bits;
 	unsigned int size;
-	u8 raw[BLK_CRYPTO_MAX_KEY_SIZE];
+	u8 raw[BLK_CRYPTO_MAX_ANY_KEY_SIZE];
 };
 
 #define BLK_CRYPTO_MAX_IV_SIZE		32
@@ -87,7 +141,9 @@ bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
 				 unsigned int bytes,
 				 const u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE]);
 
-int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
+int blk_crypto_init_key(struct blk_crypto_key *blk_key,
+			const u8 *raw_key, size_t raw_key_size,
+			enum blk_crypto_key_type key_type,
 			enum blk_crypto_mode_num crypto_mode,
 			unsigned int dun_bytes,
 			unsigned int data_unit_size);
@@ -103,6 +159,10 @@ bool blk_crypto_config_supported_natively(struct block_device *bdev,
 bool blk_crypto_config_supported(struct block_device *bdev,
 				 const struct blk_crypto_config *cfg);
 
+int blk_crypto_derive_sw_secret(struct block_device *bdev,
+				const u8 *eph_key, size_t eph_key_size,
+				u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline bool bio_has_crypt_ctx(struct bio *bio)

-- 
2.43.0


