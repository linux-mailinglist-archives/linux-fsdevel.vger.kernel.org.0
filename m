Return-Path: <linux-fsdevel+bounces-48605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E53B0AB1541
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9084188CF8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3EA33FD;
	Fri,  9 May 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6wqO6yN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B11428E7
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797568; cv=none; b=J1VwdVntM8AVqbJxzzsUtFFliiVj2zHEc2UWwDNoFrU0d/K0GUN6vS6RVJMt6N6Xoj2j0UsV4HXKvtdcNPhbyNRdRJWIk/kYfVYlc7tYkz2rziCnvVpxARdZHIb4WeHO6g4KiXwpHTBTfAPCeLDF9g3G3k0fePWLN0goIScB5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797568; c=relaxed/simple;
	bh=faNjyStGz9Xsf46tiQJuTgISS9nkM+ZOh7LE1yhui8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QK+VS+kkLpHgWEbJDRup7aKugBNFPpXS3EesqeTmtx4wC0uSF7wGdUoGPS6+DS1NyLJKOmAq0IvptC4Co4i+FF63iI5Q2Qe0iTNnHFOPeSEhMkTpCAUVdSRZbdU/KF2GIhxR03LVIrDyx9v/f1/mm+WlOJA49sHS6opiVR6FUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6wqO6yN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a1c85e77d7so913048f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746797565; x=1747402365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6uAwiyUFXC85Dt/7tHHeiAlw+czVyZs7fVaod5d3Zao=;
        b=H6wqO6yNJplj2AMyk0h3oW7DvNfkUHgaiKZVSO4Dkd2PtlVO+FY4OiHxPpOD19DInK
         cHKmgsYoBysA+bm7xPEsqAyPrC19enpDU7vpo1qCwEMhvITpQ1hhC4yprxGE0Zfj2jsC
         jDwf1vWpYTJUvYInrO9vmwFp7gP8KaBTYyBTbbO7hGwBWYpzKQmHE+VL3HpSihJMq7Wu
         5J2BgtkLn75H3kdLUi+sZcJeIvYWClIxqzjU7yUsj3//xW+F1bEVtq+ps7hCpX1JIopE
         JveEU0GgIYvacWBXakA5q3U1wHkvVSggb/XqCKIS7gXRvvklijmnD37sosmfqhydiH5n
         zb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797565; x=1747402365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uAwiyUFXC85Dt/7tHHeiAlw+czVyZs7fVaod5d3Zao=;
        b=Tc5rzB7o9OzqVVUizYlbbnfYh9TAj1izJm+jzRNtAZZ58rZi6UfgdcfyKrUfNfa0Mj
         5NnL63UPe3gfvDJKF4bZ395WRptMr0Zz1h7AIVGDo5L/bUSukGZ/dSo8pw+LXmkqCPbf
         RlAyAv62ifuQvoqQcB2g5vM2iUDvGv5+oJVZsaoetQMfpJ8xeX1QjWebQ2rBgnc8DgtP
         pOPtQ+I8TANNJCZWhUBY9Rf1yg75liHXVebJEHDNYEB1hbf4TvfJt4/8uOs9N87Lhbib
         R3r9zhJBN4GineKXYrX7b1TVpjgAAXv6uuJd40+w+CgubWYz5Sp9kTUdNrosyHiOEWp7
         c6Tw==
X-Forwarded-Encrypted: i=1; AJvYcCU4QmKfRJVO0oe4RqiDcwdEnD0NBnBGGSeZLNdB5l1cRj/pnymuEUqzCv75v8AxaAySMsPjgdveEcM9Ik9T@vger.kernel.org
X-Gm-Message-State: AOJu0YzUgyeGlDNWWuS0Lhvja7XDyOBLgUn2yR1/4hpmuwF/rMf7gPJt
	dm6Upft2mEpl1ZUgJdq0B0CWDLxVoqsFE3lf6UtjeD76LWRNJFoX
X-Gm-Gg: ASbGncvKT5efmIXs2G16hWHQ9X1+A4eDeO1l3A/Eh5lhjCUQ1qH4alGCUfdpde0mIVk
	BAtq78ZcAD7kw+xA7AlcI7tOt/FJghGYFoqhph7q8ZgU7iB8g9lDGLBABtypidOAji9gAo+H9Dy
	WQp571J4AwtWJGkW4Dj2SnsDYs2l10d1pS42VTL2itt9SWW6i9X5YwBqLa/BLgSfFn6+Dhq6hq9
	QC9xO4fe8wTDilo8QChpn3Psqc9y2QtzhXynu06j9dnAWursHgtDlS9YupuQAcocoV12PllsDlg
	Ltx2XCm6JtvQrZYkapK8oeQu4ALWW0d9HfVvb5qQ/EPihHGBnIr848DQnvVEW00e526GT2h5+/v
	Dp2htl6MUecJoHMjdUT1ss8EWk8ov7qOc4G9rMRvkpnIvuCLz
X-Google-Smtp-Source: AGHT+IFqB9yyu9YkcLkyohmLCk5WFYZFVqNhPxPgDTEeI7MnsPLSXcG5XKwrtKXKYuaoyUMATaWWXQ==
X-Received: by 2002:a5d:650b:0:b0:3a1:f655:c5b2 with SMTP id ffacd0b85a97d-3a1f655c5femr2581546f8f.39.1746797564561;
        Fri, 09 May 2025 06:32:44 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfd6sm3232899f8f.4.2025.05.09.06.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:32:44 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/8] filesystems selftests cleanups and fanotify test
Date: Fri,  9 May 2025 15:32:32 +0200
Message-Id: <20250509133240.529330-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian,

This adds a test for fanotify mount ns notifications inside userns [1].

While working on the test I ended up making lots of cleanups to reduce
build dependency on make headers_install.

These patches got rid of the dependency for my kvm setup for the
affected filesystems tests.

Building with TOOLS_INCLUDES dir was recommended by John Hubbard [2].

NOTE #1: these patches are based on a merge of vfs-6.16.mount
(changes wrappers.h) into v6.15-rc5 (changes mount-notify_test.c),
so if this cleanup is acceptable, we should probably setup a selftests
branch for 6.16, so that it can be used to test the fanotify patches.

NOTE #2: some of the defines in wrappers.h are left for overlayfs and
mount_setattr tests, which were not converted to use TOOLS_INCLUDES.
I did not want to mess with those tests.

Thanks,
Amir.

Changes since v1:
- Add test for fanotify mntns watch in userns
- Fix some braino in statmount_test_ns re-factoring
- Add cleanups to pidfd and mount_setattr tests
- Add syscall number defs for more archs
- Mention some more changes in commit messages
- Use ksft_print_msg() in helpers
- RVB from John Hubbard

[1] https://lore.kernel.org/linux-fsdevel/20250419100657.2654744-1-amir73il@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/6dd57f0e-34b4-4456-854b-a8abdba9163b@nvidia.com/

Amir Goldstein (8):
  selftests/filesystems: move wrapper.h out of overlayfs subdir
  selftests/fs/statmount: build with tools include dir
  selftests/pidfd: move syscall definitions into wrappers.h
  selftests/mount_settattr: remove duplicate syscall definitions
  selftests/fs/mount-notify: build with tools include dir
  selftests/filesystems: create get_unique_mnt_id() helper
  selftests/filesystems: create setup_userns() helper
  selftests/fs/mount-notify: add a test variant running inside userns

 tools/include/uapi/linux/fanotify.h           | 274 +++++++++
 tools/include/uapi/linux/mount.h              | 235 ++++++++
 tools/include/uapi/linux/nsfs.h               |  45 ++
 .../filesystems/mount-notify/.gitignore       |   1 +
 .../filesystems/mount-notify/Makefile         |   9 +-
 .../mount-notify/mount-notify_test.c          |  38 +-
 .../mount-notify/mount-notify_test_ns.c       | 557 ++++++++++++++++++
 .../selftests/filesystems/overlayfs/Makefile  |   2 +-
 .../filesystems/overlayfs/dev_in_maps.c       |   2 +-
 .../overlayfs/set_layers_via_fds.c            |   2 +-
 .../selftests/filesystems/statmount/Makefile  |   6 +-
 .../filesystems/statmount/statmount.h         |  36 ++
 .../filesystems/statmount/statmount_test_ns.c |  86 +--
 tools/testing/selftests/filesystems/utils.c   |  88 +++
 tools/testing/selftests/filesystems/utils.h   |   3 +
 .../filesystems/{overlayfs => }/wrappers.h    |  42 +-
 .../testing/selftests/mount_setattr/Makefile  |   2 +
 .../mount_setattr/mount_setattr_test.c        |  54 +-
 .../selftests/pidfd/pidfd_bind_mount.c        |  74 +--
 19 files changed, 1312 insertions(+), 244 deletions(-)
 create mode 100644 tools/include/uapi/linux/fanotify.h
 create mode 100644 tools/include/uapi/linux/mount.h
 create mode 100644 tools/include/uapi/linux/nsfs.h
 create mode 100644 tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
 rename tools/testing/selftests/filesystems/{overlayfs => }/wrappers.h (62%)

-- 
2.34.1


