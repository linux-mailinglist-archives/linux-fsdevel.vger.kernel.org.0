Return-Path: <linux-fsdevel+bounces-51392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC4DAD661E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4913AC2CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0321DED42;
	Thu, 12 Jun 2025 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzuX1X/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07B19644B;
	Thu, 12 Jun 2025 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749698568; cv=none; b=gLRMY2DrYHDzaR6BornZANcOakOVd7XeAD+iu44HEDUIXs5FDl3vMY/N8F+JybeoUvAc/BLkTndva4df1Vz3Rqol7S0yOX4LAmBUaf7hNmKhkPpxgkqjhLREDUaR08mse+RVCzE+SdYASKOqddVAfQlZFjgDTXsM/ua3Ug+h1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749698568; c=relaxed/simple;
	bh=BrSkfwr2fEUkp4ke6mpxarWl8wHtq54sqWB/PYbJtZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5cH4k6WX/+KqYPi2K2hAMhMcfqJRishcmhxsl7yYglGovwljTrF8v/uDPIQQaUTrRCLt2sVK6cvVI7x5lugvZjLtgoKRTpEpnXGjzM+hcs9ivb9mgGZGpM5FRBUfviroP0SU2wbKTxEJxjEiTN2IaBfvfEYng2BPyW3pQkn520=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzuX1X/k; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-747ef5996edso581840b3a.0;
        Wed, 11 Jun 2025 20:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749698566; x=1750303366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o5BrchDvLAnoGuJ9lm9D6RimRbXBnEt7ZlMQvCcmHq4=;
        b=ZzuX1X/kWB7QVZhrxFKDBx8KwlPifKJdpdPsXI87yjybMeA9tAKCz0zM8BJP/BQWyu
         5uNya1TW6YylOjXdp+BIDOpAlW6aH0LEF0g0XeKpD4vFze3RHv20D9phqRixZ1VDGIGe
         CyD0KEDurZtACwZfOkkpgV56+wKn+7FslWKphcgXSFPlwRMvNJ+oKMfyhC6jXOvSJJ0C
         9vfz/ujX8tlXYg09fEMcM5VJNmj7ZJNZCjEsh8s9gZxY4fa5fQwN81kpVpPln0B/1eGX
         dO7w8CXbYcFcQQ6kTUUQlvuF8Qt4L1vfYfMp7tdE5eN7A2GElXtUqrN040RfdKuIk7X6
         I+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749698566; x=1750303366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5BrchDvLAnoGuJ9lm9D6RimRbXBnEt7ZlMQvCcmHq4=;
        b=wLj0ej3IoGxKdcjmy5lB9PGnbYe+0y5nCCuzxmjr4Pm9s+uDAhisA9Br+vJnl6CI5l
         nmfli2FZDuwKTphbCb2EyKKj/qukw/77bplTfIVYdm1VqB/hE22F/UrZ9phIeRLPmzii
         vyYE1MCxiL4jxYHuKEmMtuK3oPuPvUKV+F4cwXre02XtkqrSDHbxVZNS97sxXNj5mp9f
         4hXmr0+uIiw6KsCMjrJa1N87u+cLzpaejOJY3f+OtND6XoaG/taouMzyrnyqh/Ivtp7r
         XdxG/OWoSMq3M/E9S60XUKD3Ett0aZeWrVZ8EpJoZ46Mm90sKTaKwn3ekLhM/uI/C0Ad
         5vRg==
X-Forwarded-Encrypted: i=1; AJvYcCV++pvThQcF9TKNkylXz0oUpQAe2BrS7PTkBUe2Bj9bpn/KK6fHkn5cIdF+0G3IrLGl7mLY9uYQ7B+cdfCLzA==@vger.kernel.org, AJvYcCWGeI1XAozjUIkoRqj0OqZf+9FCevXGnGKoX3CXq51R/5mp2Tvzn65aIPr07pIzLyjeqTFGUj6/XLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXwQAKDuJ2NJ7unCDFd/R7tckC7vYnoxr+z1A75wE4LuxFsaNU
	Kqk5yEJ11ZmjtpnWJFstc4+XbHXz/yyDPaK5DHIqDKcYQmbCdqRoAxo/
X-Gm-Gg: ASbGncuyNUJ7Ew6kOaPLF/oyrbSorD9Uq6xLUFSuN8iktuapoDPtD3vndBkKUF+LoKg
	JO2eIT2KtYbvxh0LsYZAxaqkDtRleFMN6Pvx8lqg/rtwXNN6EV9R3vO9yXP3M7mh3AWcOGIoJfi
	JBjVLVlx3bdA7IIAvcVTlTsHAzwyviPj58WjdSg7fTjAL3yw0uSJ07FWg5vMkJ6wT3j02k7Yeir
	Q+94TsY4oNuTj/DKuApzHkzokhpHrtqtRTsEYrZ+pFNa2ak7CMkziyss/4Lrnr6qKRS3/txq7Xg
	7DnsYFo2GAVYJEme7sqLltjEdnyNCgaygTrDt65WKkt/tv1FyDEOYwxILFgoug==
X-Google-Smtp-Source: AGHT+IH20S/NhBMoKYIZBWMUE+n8bVvzIS8OCFFPusGhzVlpdxZ284oURaUPgBmg+Tuye6NAdfA06A==
X-Received: by 2002:a05:6a20:7d86:b0:21f:568c:713a with SMTP id adf61e73a8af0-21f977e8f6fmr3123090637.17.1749698566083;
        Wed, 11 Jun 2025 20:22:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd6295233sm348019a12.37.2025.06.11.20.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 20:22:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9B72E424180B; Thu, 12 Jun 2025 10:22:42 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Luis Henriques <luis@igalia.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	James Morse <james.morse@arm.com>
Subject: [PATCH] Documentation: fuse: Consolidate FUSE docs into its own subdirectory
Date: Thu, 12 Jun 2025 10:22:39 +0700
Message-ID: <20250612032239.17561-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4174; i=bagasdotme@gmail.com; h=from:subject; bh=BrSkfwr2fEUkp4ke6mpxarWl8wHtq54sqWB/PYbJtZw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBle7q4TP35qt069wq+S5O5/afr+O4u2ntb/nDeXZbafv ZV383rfjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExktxzD/+AFB1WkDmx4Lql/ InKXlS9PfnR3UFvFvCnRUzkZZt39uIuRobeVW/2oPqc/086/r/S0ruh99WDIsWgsetih0sDFa+r ABQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

All four FUSE docs are currently in upper-level
Documentation/filesystems/ directory, but these are distinct as a group
of its own. Move them into Documentation/filesystems/fuse/ subdirectory.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../filesystems/{ => fuse}/fuse-io-uring.rst       |  0
 Documentation/filesystems/{ => fuse}/fuse-io.rst   |  2 +-
 .../filesystems/{ => fuse}/fuse-passthrough.rst    |  0
 Documentation/filesystems/{ => fuse}/fuse.rst      |  6 +++---
 Documentation/filesystems/fuse/index.rst           | 14 ++++++++++++++
 Documentation/filesystems/index.rst                |  5 +----
 MAINTAINERS                                        |  2 +-
 7 files changed, 20 insertions(+), 9 deletions(-)
 rename Documentation/filesystems/{ => fuse}/fuse-io-uring.rst (100%)
 rename Documentation/filesystems/{ => fuse}/fuse-io.rst (99%)
 rename Documentation/filesystems/{ => fuse}/fuse-passthrough.rst (100%)
 rename Documentation/filesystems/{ => fuse}/fuse.rst (99%)
 create mode 100644 Documentation/filesystems/fuse/index.rst

diff --git a/Documentation/filesystems/fuse-io-uring.rst b/Documentation/filesystems/fuse/fuse-io-uring.rst
similarity index 100%
rename from Documentation/filesystems/fuse-io-uring.rst
rename to Documentation/filesystems/fuse/fuse-io-uring.rst
diff --git a/Documentation/filesystems/fuse-io.rst b/Documentation/filesystems/fuse/fuse-io.rst
similarity index 99%
rename from Documentation/filesystems/fuse-io.rst
rename to Documentation/filesystems/fuse/fuse-io.rst
index 6464de4266ad50..d736ac4cb48370 100644
--- a/Documentation/filesystems/fuse-io.rst
+++ b/Documentation/filesystems/fuse/fuse-io.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ==============
-Fuse I/O Modes
+FUSE I/O Modes
 ==============
 
 Fuse supports the following I/O modes:
diff --git a/Documentation/filesystems/fuse-passthrough.rst b/Documentation/filesystems/fuse/fuse-passthrough.rst
similarity index 100%
rename from Documentation/filesystems/fuse-passthrough.rst
rename to Documentation/filesystems/fuse/fuse-passthrough.rst
diff --git a/Documentation/filesystems/fuse.rst b/Documentation/filesystems/fuse/fuse.rst
similarity index 99%
rename from Documentation/filesystems/fuse.rst
rename to Documentation/filesystems/fuse/fuse.rst
index 1e31e87aee68c5..5976828586f8df 100644
--- a/Documentation/filesystems/fuse.rst
+++ b/Documentation/filesystems/fuse/fuse.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-====
-FUSE
-====
+=============
+FUSE Overview
+=============
 
 Definitions
 ===========
diff --git a/Documentation/filesystems/fuse/index.rst b/Documentation/filesystems/fuse/index.rst
new file mode 100644
index 00000000000000..393a845214da95
--- /dev/null
+++ b/Documentation/filesystems/fuse/index.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================================
+FUSE (Filesystem in Userspace) Technical Documentation
+======================================================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
+
+   fuse
+   fuse-io
+   fuse-io-uring
+   fuse-passthrough
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 11a599387266a4..84c5a0d11b6df7 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -96,10 +96,7 @@ Documentation for filesystem implementations.
    hfs
    hfsplus
    hpfs
-   fuse
-   fuse-io
-   fuse-io-uring
-   fuse-passthrough
+   fuse/index
    inotify
    isofs
    nilfs2
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa163f..026afb50000346 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9898,7 +9898,7 @@ L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 W:	https://github.com/libfuse/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
-F:	Documentation/filesystems/fuse*
+F:	Documentation/filesystems/fuse/*
 F:	fs/fuse/
 F:	include/uapi/linux/fuse.h
 

base-commit: d3f825032091fc14c7d5e34bcd54317ae4246903
-- 
An old man doll... just what I always wanted! - Clara


