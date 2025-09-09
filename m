Return-Path: <linux-fsdevel+bounces-60683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A725EB500FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DDA1B25E1F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5D352095;
	Tue,  9 Sep 2025 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STDkYNtF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBC935207F
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431489; cv=none; b=ZFEuS3D0BH2ozLdtL9Ytje1Zp72cog18oL/HI4XgXlOVT0exhb92AQZYYVrXtMWUEnrtJJEQkWwsTE0F7aEzu7vPjB5H+scn7hKk+d2nNbMTRtE2CGYhgPTeeaTbFJr7XQ7i47U6l1m7NezFmXkT4drIFPCTs4kZdE41Kzy8jSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431489; c=relaxed/simple;
	bh=qLI7K7SjBg75kFVpuEMsnQPGUHaOHPFdi7ri3LAszIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:To:Cc; b=qobXsDQq6ym2CMEeu5BKka1BVBt4p7CEPqZ0ET1zOtqrIV5UuhBq3/FueY5hqDBVELSEXN/pP1DQEQhD/5EKp5drxv0XgO+kdNwLIC7eqhw02VFo4XuK+u7PcCNIvUZmbJ2FHdMx3aiiIqvnCOFhEw1n9dyEFGsnTy2R77x8r7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STDkYNtF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757431486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=EVQrM7vvGg2wr9cyg1VwAlrBbHtBHMrtY7DnkbL5fuU=;
	b=STDkYNtFZXl8FSelh6bMe5kBTVS18sIuxUXFDK/ltgNedqOEuUszucVs7WQflbfCwvIBdp
	Bwi4lqBed4Qn+pWWlVwxOAMJ9t98xoyuwTvRxvvve7xvix4BlprAhf0X20bg7ZmWXObrZb
	MkDn7feN3yJtDXCNwNX98xT3fe1BDq0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-SzOMyKM-PomC-7nb7kdzAw-1; Tue, 09 Sep 2025 11:24:44 -0400
X-MC-Unique: SzOMyKM-PomC-7nb7kdzAw-1
X-Mimecast-MFC-AGG-ID: SzOMyKM-PomC-7nb7kdzAw_1757431484
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45df4726726so2869805e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 08:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431484; x=1758036284;
        h=cc:to:in-reply-to:content-transfer-encoding:mime-version:message-id
         :date:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVQrM7vvGg2wr9cyg1VwAlrBbHtBHMrtY7DnkbL5fuU=;
        b=VlVbaPD6c1xuug8nPshUJlcHP3EV+7f6vHyKx04Ja+GxdTcAyS8Am3gX8Agt7fEMh1
         B9UMxXYq6GYPiQGgAYkVPKQWbSe0mt1XOCMtVdZdBlzACqZuOBSYT3QXtbFD1gdq1kvT
         ElUkpzH/xHa8TLKmQ757r8o4UL6cC0xXaDrSkjVp3jVKrTPr8zwS9NH1GWfsiRCREJ08
         ueVicB6oODRA1gBd8lkzFLPOojlr0+jw35V4HAF3u0Dzn6ENemST6IpcRCyoqk0KkGtp
         +9bfxfONAshoavBbukr82QC+ksjY/DMPhaNAxpo4Dm/BQmVeU2ICxnR0Z91E5eLuht8l
         3JZg==
X-Forwarded-Encrypted: i=1; AJvYcCVihzAJbbhcLNjf1XMof4RkkuKEpPrnH+q+1c5ysSx35okAvQGR8o1KzPMX2GZiiPhZuhFXmkurjN5FkBCG@vger.kernel.org
X-Gm-Message-State: AOJu0YwcohT5eeoGVuf8w+Bh89r1UibO6hpGXYcCl9iyaFIYiZLFIS99
	uuCysy7rfx9z/umomOw8wnMyYp4YUICtz7HwegkTlICBMjQqTDC10vMYa/RbG/12l9PiTul/j3b
	A04n3IjP1dlmppJhm8P0dWprw2+RsPDwRGtVij9lo6wlZGJ7TZ7Ns2plB3Vi+Smm63g==
X-Gm-Gg: ASbGncs1ZaDP3oW7nRUIvOPorHrC+cD4eKkLVDE6Yb6PAcRAVV/MiidOeYNn0OdxZU4
	VHaaS1LKC2pdwYn8vpcdOrOvtBD2R+LevNRgMFBjwXuFJWjQehbW3JNiCCp4DF9uOZB2P/nNbpk
	CLR+4SAJslPOz0E7d5hKJNLTEIRUe0ybwFGtEdTk6ZXBHaeFayP5bvKO81dLBjqRvA6LqS1YmYV
	eqvfbgFb2UplAYmx9evpmJZ/9mmNbaugQf+C2Hivfa4/P33PfrpBV7Q1oe6R8RrPYcnMBL5hi5W
	B1GM9rbv2Vb2N5UjL1Az6bc01RCOCUg4zfHg/mQ=
X-Received: by 2002:a05:6000:3108:b0:3d6:212b:9ae2 with SMTP id ffacd0b85a97d-3e643ff9652mr10220485f8f.63.1757431483644;
        Tue, 09 Sep 2025 08:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET43k6r7zmrgVjEPOzVzXuIKLSqrOCLzwj6hxs/9rooTTnKM2oQAJL5BkN8TiuGwtdt3/+uw==
X-Received: by 2002:a05:6000:3108:b0:3d6:212b:9ae2 with SMTP id ffacd0b85a97d-3e643ff9652mr10220461f8f.63.1757431483113;
        Tue, 09 Sep 2025 08:24:43 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df17d9774sm11432015e9.9.2025.09.09.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:24:42 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v3 0/4] xfsprogs: utilize file_getattr() and file_setattr()
Date: Tue, 09 Sep 2025 17:24:35 +0200
Message-Id: <20250909-xattrat-syscall-v3-0-4407a714817e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALNGwGgC/2WNzQqDMBCEX0X23JR0gzbtqe9RPORn1VDRsglBE
 d+9IdcevxnmmwMicaAIz+YAphxiWJcC6tKAm8wykgi+MKDEVqrbXWwmJTZJxD06M89Cq8dg0Vr
 pOgVl9WUawlaNb8gK+pJNIaaV93qSsTbVp/Hfl1FIodGgR9/qrrWvD/FC83XlEfrzPH+b9gfgs
 wAAAA==
X-Change-ID: 20250317-xattrat-syscall-839fb2bb0c63
In-Reply-To: <mqtzaalalgezpwfwmvrajiecz5y64mhs6h6pcghoq2hwkshcze@mxiscu7g7s32>
To: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
 "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=qLI7K7SjBg75kFVpuEMsnQPGUHaOHPFdi7ri3LAszIA=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMg647Wr0f7ht6kevFYlS64ymSOnUrZ8yw+58ufzfz
 UyZcrFHbVg7SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATKRXkpFhs8DGq4G2BXle
 E/63iO6TaFC/nbKh7PrmiW86+Xa4ctyKZmT4cPT52dTVnw6uEmzRsbu2q+ZtzGHlHVP+6U+Zckb
 u+uN1jAAdgEna
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Hi all,

This patchset updates libfrog, xfs_db, xfs_quota to use recently
introduced syscalls file_getattr()/file_setattr().

I haven't replaced all the calls to ioctls() with a syscalls, just a few
places where syscalls are necessary. If there's more places it would be
suitable to update, let me know.

Cc: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org

---
Changes in v3:
- Fix tab vs spaces indents
- Update year in SPDX header
- Rename AC_HAVE_FILE_ATTR to AC_HAVE_FILE_GETATTR
- Link to v2: https://lore.kernel.org/r/20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org

---
Andrey Albershteyn (4):
      libfrog: add wrappers for file_getattr/file_setattr syscalls
      xfs_quota: utilize file_setattr to set prjid on special files
      xfs_io: make ls/chattr work with special files
      xfs_db: use file_setattr to copy attributes on special files with rdump

 configure.ac          |   1 +
 db/rdump.c            |  20 ++++++-
 include/builddefs.in  |   5 ++
 include/linux.h       |  20 +++++++
 io/attr.c             | 138 ++++++++++++++++++++++++++++--------------------
 io/io.h               |   2 +-
 io/stat.c             |   2 +-
 libfrog/Makefile      |   2 +
 libfrog/file_attr.c   | 121 ++++++++++++++++++++++++++++++++++++++++++
 libfrog/file_attr.h   |  35 +++++++++++++
 m4/package_libcdev.m4 |  19 +++++++
 quota/project.c       | 142 ++++++++++++++++++++++++++------------------------
 12 files changed, 380 insertions(+), 127 deletions(-)
---
base-commit: 1d287f3d958ebc425275d6a08ad6977e13e52fac
change-id: 20250317-xattrat-syscall-839fb2bb0c63

Best regards,
--  
Andrey Albershteyn <aalbersh@kernel.org>


