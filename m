Return-Path: <linux-fsdevel+bounces-57127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D382FB1EEDD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43101AA5EC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925952882D6;
	Fri,  8 Aug 2025 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cz7CmWNV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799011E0DE8
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681428; cv=none; b=LQutb8TGfagCa8/B3lRGooHtJAoyDN7NmTlr3apNb0qNsdqQEow/aVBSxmhf+cb/UmULpWhwnvOGLBAF6TKfsBC/eQCwuIBHGf+Irk/z5mdjEFNNalqP+dUaRrtU4h1dT3bj1flq93dENo5h6ff8v6fS9U/00ZKmV0wwTCbxnjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681428; c=relaxed/simple;
	bh=RoO+eToTLoP7DJCluxCUMFB3uHhVkxLfxlwTTYnRp1I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:To:Cc; b=LcB3aI7oh3+z7P7eCO1OeveASN3/TR5bjR57s0sccIWVyqv8v5s/uWEYmKGubP7vvHODA6ByOby1A8hRCiyED5qV2DMCDz8iad2u0Ta0Z64n5Q4C1YPVSWdqWZ69bZWdG/xf9RAGMz4RclXTL7d3LvHsZjdQYZ+CagJv8I51wT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cz7CmWNV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754681425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=Pbtv+XyTsq/xa+ZE8T4GUjr3UVdr93V/ZFjsmaMOOqw=;
	b=Cz7CmWNVHftjmVzaFzlyyvshdA2zyRF9s4oiver/vGQDavkb3WT51rGf+D0y7/EnOv6hR5
	EMitx808ytT//HqMvKFEcl4Gp5bNp0WU8Nhnt7vbSOVpayOuzgNRHVqmd6wecItFgDughz
	H/AVMFxTrhxTQAMt23UCN4Vle/qW1xY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-a0qt5wXCPgGqO5G8dc6X7w-1; Fri, 08 Aug 2025 15:30:21 -0400
X-MC-Unique: a0qt5wXCPgGqO5G8dc6X7w-1
X-Mimecast-MFC-AGG-ID: a0qt5wXCPgGqO5G8dc6X7w_1754681420
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45891629648so12917455e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 12:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754681420; x=1755286220;
        h=cc:to:in-reply-to:content-transfer-encoding:mime-version:message-id
         :date:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbtv+XyTsq/xa+ZE8T4GUjr3UVdr93V/ZFjsmaMOOqw=;
        b=ap3nu6DC5LnzcbzUVov4A9Blnzx6M5Xw04ms3mfdOOXvEoN7SNybDteBDeHcxXjE/d
         ShoKTo78IsKWtlm1szDPfD6NAkzZpTqoCL8h/DRodSoV+rYwsZMhFFg3dTkta5y02SLR
         tN3lQJB2MbX91pIrB08eB3bhaB23eCuZbmDzCwFxoxQmLalZtnZdVFkIt5pwNkayHKj+
         81ee3m4DpP8qNzypLnet+A7P/XjUgMARIJxoE8vCvcz/jXHsyb3jchF4X216+q0zTSP5
         ALru5zkOoMmuVJNrhVIXS9GLjrO3qQLMbzAVjFKa3c5BtBvMZKc+t4jUl8A1R9ByJkTd
         nTdg==
X-Forwarded-Encrypted: i=1; AJvYcCXxqP2JAoXERl9da8uZN4ajGQcpicRCntf8d01/JODtCQojl0TIiXNO+ARGm4GfoQyQoxf+nybOICjzCvGN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo0gtqsQYwjaHrkOqYPGwod27Ls5DxlPeoxBWFbbqHpyh8NuxR
	7BsDMhiRvwHjGVC524HavSg6QhArHuIl5NWA4D6VS3POzGbisF5+5/n8bwmb37stWxUieXyj7xE
	CVX/oFwuO6zgDETS2WUYoJPC4BLiJcMb1P8uLdYjMw1rQ8hE6PXzj/U5Om/iH+XqTkg==
X-Gm-Gg: ASbGncu8Z+opZ24kVnDAEdv8snCCCoj1vefR9UuqfxE0WGcNDhbWmwCOS8nazysQCZs
	QKANK2bINTyXmzIuTvOQVa6rVL+M3q7zW1aDHIGLWx4F0K0r9mc9eBsEB3UnZ1O9u8sHcgrl3oD
	3mpgnlvZwy4uCq9nZxr35FOTZT4Bp+y6vhTC2HBWj+NKjzj1K6wCl+5WuyKIr/pA1xLYw6NJBdb
	I45aCrsbbZ6SDDv2IklXYPi1l8eSWDfxrNF3tnl/3rGHVDeAJ2NRlvlKhebISOlNIEm5pe8tTEa
	vnD7QIUPx2Q3jpvoXumiA8ghIxlv/3aK5qdhxrQZxYpJqg==
X-Received: by 2002:a05:600c:1c2a:b0:456:1281:f8dd with SMTP id 5b1f17b1804b1-459f51fc4ebmr35049825e9.12.1754681420484;
        Fri, 08 Aug 2025 12:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp1IuzzdXOGE03zxoG8JUn7495zov2w9mOX8h5r+eV4QvNjeTn8aXSO+ujUQzn2AbrHIOH7A==
X-Received: by 2002:a05:600c:1c2a:b0:456:1281:f8dd with SMTP id 5b1f17b1804b1-459f51fc4ebmr35049555e9.12.1754681420032;
        Fri, 08 Aug 2025 12:30:20 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm8925162f8f.69.2025.08.08.12.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:30:19 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 0/4] xfsprogs: utilize file_getattr() and file_setattr()
Date: Fri, 08 Aug 2025 21:30:15 +0200
Message-Id: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEdQlmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Nz3YrEkpKixBLd4sri5MScHF0LY8u0JKOkJINkM2MloK6CotS0zAq
 widGxtbUAb1OEPGEAAAA=
X-Change-ID: 20250317-xattrat-syscall-839fb2bb0c63
In-Reply-To: <lgivc7qosvmmqzcq7fzhij74smpqlgnoosnbnooalulhv4spkj@fva6erttoa4d>
To: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=RoO+eToTLoP7DJCluxCUMFB3uHhVkxLfxlwTTYnRp1I=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMqYFeOdU5PYahrBaXWLy32+37p6o+XWXXww5HDeeF
 7pc6rKR1uooZWEQ42KQFVNkWSetNTWpSCr/iEGNPMwcViaQIQxcnAIwEe+JDP/Tnux9mqu1xG8K
 5+FFB5UTL7ZsLZvvk+o7MyChoSLwZlQzI8Msxaeyvb8zOFbNjrmUXepz8peK07LnoQ1bHr1kEum
 J5GQBAAllRVo=
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
Andrey Albershteyn (4):
      libfrog: add wrappers for file_getattr/file_setattr syscalls
      xfs_quota: utilize file_setattr to set prjid on special files
      xfs_io: make ls/chattr work with special files
      xfs_db: use file_setattr to copy attributes on special files with rdump

 configure.ac          |   1 +
 db/rdump.c            |  24 +++++++--
 include/builddefs.in  |   5 ++
 include/linux.h       |  20 +++++++
 io/attr.c             | 130 ++++++++++++++++++++++++++-------------------
 libfrog/Makefile      |   2 +
 libfrog/file_attr.c   | 105 ++++++++++++++++++++++++++++++++++++
 libfrog/file_attr.h   |  35 ++++++++++++
 m4/package_libcdev.m4 |  19 +++++++
 quota/project.c       | 144 ++++++++++++++++++++++++++------------------------
 10 files changed, 357 insertions(+), 128 deletions(-)
---
base-commit: d0884c436c82dddbf5f5ef57acfbf784ff7f7832
change-id: 20250317-xattrat-syscall-839fb2bb0c63

Best regards,
-- 
Andrey Albershteyn <aalbersh@kernel.org>


