Return-Path: <linux-fsdevel+bounces-28799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F596E60D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 01:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A65B23099
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 23:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883F41B3B26;
	Thu,  5 Sep 2024 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3KYMhsC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06DA13D638;
	Thu,  5 Sep 2024 23:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725577613; cv=none; b=kkF74zQn9ZtDCiUZSvSvD2yMxlVILaYJFPW55iojWChkTz9SRvWHVwNFZgF4VIXlv2nCdeBfkCqYppLZzxjGyZpL1KmhGAR26T2SSNpFi9YNtt/XYT0IJRQTI75drSMo9AcrtLmyaaQW77uI9g69fTAdhqY+CoWUFUn7usPJwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725577613; c=relaxed/simple;
	bh=CPoDkYNnJw32LYds6YH/ngdRgMIgp8fiMKSJ3WMd49Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UWc6xE5pzUrj+67Q1vxHznfp4jE3Fs/MjjTbuLuOPrmb/LCGnFQZliDoELhxUq4z2/pVo1/eQZlsBQAJS3B+OU7H2ruFYp4ZixwGX5OhOlA4XqMa5zCIV1HJdoU3Vy/0BJzQi6EsxSQ41/QbBHkMoML7KSTVjTEmyXUc08YE45g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3KYMhsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B26C4CEC3;
	Thu,  5 Sep 2024 23:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725577612;
	bh=CPoDkYNnJw32LYds6YH/ngdRgMIgp8fiMKSJ3WMd49Q=;
	h=From:Subject:Date:To:Cc:From;
	b=S3KYMhsC7Sg/8R3rfUwyhAW8xdl9AJ5/dEkSkTbFLJIKOa/Kgv535MJHxODrkWzBN
	 rbxVxcltB9dB7TW4p6lV73L8gJRMbk5fzgmLASfUl0PIQbgDx1s9Yrz9oh//hwZo1r
	 VGA6CqaanA2292AqUKgeGZrFCPAQCMq/zRWUkGjKY8TzqnWwKurk1ljSatk88pkBbk
	 2PXo7ASmGZ4hzjYbCYa5PrMxUGynwwMyr2JlwC8O8mgzj+oWR5vpwA2JCPjwxsVvP4
	 8z3z/F0iTl5Py1L2FFr/c+RXlMIPpODUHCrtZwSGw2Hvmkz1sVs07pXT5ksOOJie9l
	 9b0tgdnGJIBag==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH RFC 0/2] arm64: Add infrastructure for use of AT_HWCAP3
Date: Fri, 06 Sep 2024 00:05:23 +0100
Message-Id: <20240906-arm64-elf-hwcap3-v1-0-8df1a5e63508@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADM52mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNT3cSiXDMT3dScNN2M8uTEAmNdc3MDy2RTU0vjFGMTJaC2gqLUtMw
 KsJHRSkFuzkqxtbUA7ybGrWcAAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CPoDkYNnJw32LYds6YH/ngdRgMIgp8fiMKSJ3WMd49Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm2jmH+9Ah9sC12NbAxu3lH//yIxqpau2tH5r/wKBy
 OZ4ndN+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZto5hwAKCRAk1otyXVSH0M0GB/
 9+yDgb9c3DrrqPt6+lrQ8J5wLz0bPg8fxi42o/cU51UtOJIo3jDK8qIyGVt4sNPOAEnedIdeonZYCM
 UA6vMgHkXNIV0RQGtCdNbBU0S4GSoeaN1Dbm0YUXvArQ2i+J2e9hWe+6o5jEoCKkUQulb8pIVZYBCq
 Hwz5ENScRV4rK2yeH3CG7digDIR/qRKiF4L24vRCp2ApbHpyVC+CmYtI66WMlMBylVHTUXv8HPyblc
 Fo9tUdCPYPAD8rN7DqvqdKUOZDQ96Pn5gjZE5noM3VNgHLRYctd/fgNx8N2vCl1onFnqAhpRXjIhBO
 sDgAjKOBeQug/qJcsQYdrOl20OUzRz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since arm64 has now used all of AT_HWCAP2 it needs to either start using
AT_HWCAP3 (which was recently added for PowerPC) or start allocating
bits 32..61 of AT_HWCAP first.  Those are documented in elf_hwcaps.rst
as unused and in uapi/asm/hwcap.h as unallocated for potential use by
libc, glibc does currently use bits 62 and 63.  This series has the code
for enabling AT_HWCAP3 as a reference.

We will at some point need to bite this bullet but we need to decide if
it's now or later.  Given that we used the high bits of AT_HWCAP2 first
and AT_HWCAP3 is already defined it feels like that might be people's
preference, in order to minimise churn in serieses adding new HWCAPs
it'd be good to get consensus if that's the case or not.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4
      arm64: Support AT_HWCAP3

 Documentation/arch/arm64/elf_hwcaps.rst |  6 +++---
 arch/arm64/include/asm/cpufeature.h     |  3 ++-
 arch/arm64/include/asm/hwcap.h          |  6 +++++-
 arch/arm64/include/uapi/asm/hwcap.h     |  4 ++++
 arch/arm64/kernel/cpufeature.c          |  6 ++++++
 fs/binfmt_elf.c                         |  6 ++++++
 fs/binfmt_elf_fdpic.c                   |  6 ++++++
 fs/compat_binfmt_elf.c                  | 15 +++++++++++++++
 8 files changed, 47 insertions(+), 5 deletions(-)
---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240905-arm64-elf-hwcap3-7709c5593d34

Best regards,
-- 
Mark Brown <broonie@kernel.org>


