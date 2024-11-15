Return-Path: <linux-fsdevel+bounces-34904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC509CE066
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8937D1F28615
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 13:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8F91CDA12;
	Fri, 15 Nov 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="boPmHIT2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CEA18D65E;
	Fri, 15 Nov 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678090; cv=none; b=jD0hBdtNyWTcykUxoq4abv4qjZyn6DuX6BoPqtC4d2og0EcI65UPhzE5Jy6C3JhrFmPMpYDmJ0BKYeJHZ2Tvelf1ZpF9z79NBefZRIJpxTlXJ+Me9qC9L1gRWhnExrvhc6KJd5k3RUu63TMQOWrjq0/mMTJ42NwhK36IjiHshJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678090; c=relaxed/simple;
	bh=daBuVmuPuGD6Rg2uT8BKL5cILWTFJXkIoaQJDF0280s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GMcG5saR56CxAnBL7hOIv5Ik78JrArBx4Q6hmRGPZOF/h6Ve7OdBm5LDg09homB5zCGxA89AZb5/wvojS2zFZann3F7AaZKl0jY13XsRNre408ezwGYXwk5l8RuE/2D4KAxrfDwZQu2kpTUcCgCK+T9G0qrtvuu+Qg1OFGpqSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=boPmHIT2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731678077;
	bh=CWUey5ewpa0QOwduayBJGtFMN1WGhVsVPHWEh62bV1U=;
	h=From:To:Cc:Subject:Date:From;
	b=boPmHIT2e8MSBzjaB3CU3MYrzSHuf+jieypvN7zjgkVmG94kSQhdWt2uc9Fde18Uh
	 j7RmIdj9gvpawaprZ1iFPb9aj7925BCQ+7yDAYWTwITg90aG8y/JRXU1ABHXBZKIf/
	 4RCR5aTHx/8BptsQAQmBVqv3qOkJkQKWY8l5aSEudeUYF7xphfP66K0HZoMswRmDww
	 /DttRaryn1a7gZW2vbitOcGEm4lTwtKjjjBPaQ7VFLnUluX5Ni0u7AAeP9Q++wMOV0
	 cDuYw1ONvtL5NWR9GVSCpA0+mh95tlWGiW3NWpKZ7A7A+m4A06HXA0vEtgH00qBqXm
	 OdVbpQS1rI7tA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XqdTT32Lcz4x6k;
	Sat, 16 Nov 2024 00:41:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: brauner@kernel.org
Cc: sforshee@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	<linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] selftests/mount_setattr: Fix failures on 64K PAGE_SIZE kernels
Date: Sat, 16 Nov 2024 00:41:14 +1100
Message-ID: <20241115134114.1219555-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the mount_setattr_test fails on machines with a 64K PAGE_SIZE,
with errors such as:

  #  RUN           mount_setattr_idmapped.invalid_fd_negative ...
  mkfs.ext4: No space left on device while writing out and closing file system
  # mount_setattr_test.c:1055:invalid_fd_negative:Expected system("mkfs.ext4 -q /mnt/C/ext4.img") (256) == 0 (0)
  # invalid_fd_negative: Test terminated by assertion
  #          FAIL  mount_setattr_idmapped.invalid_fd_negative
  not ok 12 mount_setattr_idmapped.invalid_fd_negative

The code creates a 100,000 byte tmpfs:

	ASSERT_EQ(mount("testing", "/mnt", "tmpfs", MS_NOATIME | MS_NODEV,
			"size=100000,mode=700"), 0);

And then a little later creates a 2MB ext4 filesystem in that tmpfs:

	ASSERT_EQ(ftruncate(img_fd, 1024 * 2048), 0);
	ASSERT_EQ(system("mkfs.ext4 -q /mnt/C/ext4.img"), 0);

At first glance it seems like that should never work, after all 2MB is
larger than 100,000 bytes. However the filesystem image doesn't actually
occupy 2MB on "disk" (actually RAM, due to tmpfs). On 4K kernels the
ext4.img uses ~84KB of actual space (according to du), which just fits.

However on 64K PAGE_SIZE kernels the ext4.img takes at least 256KB,
which is too large to fit in the tmpfs, hence the errors.

It seems fraught to rely on the ext4.img taking less space on disk than
the allocated size, so instead create the tmpfs with a size of 2MB. With
that all 21 tests pass on 64K PAGE_SIZE kernels.

Fixes: 01eadc8dd96d ("tests: add mount_setattr() selftests")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 68801e1a9ec2..70f65eb320a7 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1026,7 +1026,7 @@ FIXTURE_SETUP(mount_setattr_idmapped)
 			"size=100000,mode=700"), 0);
 
 	ASSERT_EQ(mount("testing", "/mnt", "tmpfs", MS_NOATIME | MS_NODEV,
-			"size=100000,mode=700"), 0);
+			"size=2m,mode=700"), 0);
 
 	ASSERT_EQ(mkdir("/mnt/A", 0777), 0);
 
-- 
2.47.0


