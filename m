Return-Path: <linux-fsdevel+bounces-30590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16E298C8DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9897A285B74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285201D07B0;
	Tue,  1 Oct 2024 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwsAukUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776D51CFEA1;
	Tue,  1 Oct 2024 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823781; cv=none; b=o/C2SQQKcE6DV/I3D/BIeKAmx9pSKR4G2NoeIF7gCzRHs2ivjv1OTqsi2LniEVI5hod00Am79zkZxfjY+ZY0wjjkGliO2HSnAfmNDioHBP9mpZt99pyRys8O3mBmEqqlXFSpaS2Y2W7QqMachEZ5qqv+1tKVHJ7G+Q4cYol7neg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823781; c=relaxed/simple;
	bh=zAbUzr1ODeYIke6nRWrxiS99ZR09MpEN2O+JxNln/KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n4ZIjwXz1wYr7mtXqj7zPQY8BlEd1g7BgPgwzgdD+Q/XB/YTGbxNMBm7ZOCUacmkUyGnQGAa6aDT5UPyvRefrW+LNVyt1+qBwYk2PHAOG0xQnJ4fULOEZqmx1emO35It5EvZzbR0MDOdFvTOjRtp7YfLca77WTEevpAoITLq9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwsAukUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F414AC4CEC6;
	Tue,  1 Oct 2024 23:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823781;
	bh=zAbUzr1ODeYIke6nRWrxiS99ZR09MpEN2O+JxNln/KQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nwsAukUuBWfza0uW/rUXY3JuaOEaCfpGhqWfdkW4N1gDIkUidRK/hasGJbxinc8n9
	 aJuU34SmkjIp5dTX+VS2pz6KWmffzyTp6vcj+BHHUSPAxm4MvcCE0UpxaD7Y5fKPkn
	 ZIouN8Bo132zSXBrDXzBs9KdMFWMGBAL+8NcAJOHtPBextX0bEy24+65ZtcHu2XBQh
	 4ExV9wc+5W+7nYeRkqGn3uWRbIMhfHZWT4rIQWmnRpTLfUw142l34HvjeorA2Ftp5z
	 LQR24dMGjVHOKiE8geEw2Dk+GA2M8PK0kQgzok44ktT6EG3tYjPymmKJsyQtX5RU9K
	 rq1mVjQibGiCQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:56 +0100
Subject: [PATCH v13 17/40] arm64/idreg: Add overrride for GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-17-222b78d87eee@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
In-Reply-To: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, David Spickett <david.spickett@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=2008; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zAbUzr1ODeYIke6nRWrxiS99ZR09MpEN2O+JxNln/KQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7REUmBbOjHIbjRTXTBou6dlj2jf+JoQilSMLfb
 4oamPWaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+0QAKCRAk1otyXVSH0FP1B/
 4sD5XnZ55qcZbmL8d240mUgjPiUILjDGICiY1VAzT57XN7KmS4yKXFIBxESjVgvnC8PpI/Y9Zb7sLt
 BoUFcV+Q7U8gNjyR9hza7jtoxvCKcCe9Fn68gwmkX0Q4K0iHv87BggWlo0hChy9JQMvrDNyrRwBnMY
 BQAtnYj8LUX9i5RQKhYnVKqYIz6KT6wIZL3OCytHzA4lDd0VcqnaXlWy8vM+ahKTXCJCH1oxk8LAzG
 7YIm6HPFMIia0KQmWqlfB//G7jzb5amS/Mc8t2m3DcdvgO2PX0nljBPoA5AgKnG93CQFNxYmlBQ5kG
 7zXw7oMDda+u457zCFPWYThTod14ro
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Hook up an override for GCS, allowing it to be disabled from the command
line by specifying arm64.nogcs in case there are problems.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/pi/idreg-override.c           | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..c1b00f709734 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -446,6 +446,9 @@
 	arm64.nobti	[ARM64] Unconditionally disable Branch Target
 			Identification support
 
+	arm64.nogcs	[ARM64] Unconditionally disable Guarded Control Stack
+			support
+
 	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
 			Set instructions support
 
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index 29d4b6244a6f..2bb709d78405 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -133,6 +133,7 @@ static const struct ftr_set_desc pfr1 __prel64_initconst = {
 	.override	= &id_aa64pfr1_override,
 	.fields		= {
 		FIELD("bt", ID_AA64PFR1_EL1_BT_SHIFT, NULL ),
+		FIELD("gcs", ID_AA64PFR1_EL1_GCS_SHIFT, NULL),
 		FIELD("mte", ID_AA64PFR1_EL1_MTE_SHIFT, NULL),
 		FIELD("sme", ID_AA64PFR1_EL1_SME_SHIFT, pfr1_sme_filter),
 		{}
@@ -215,6 +216,7 @@ static const struct {
 	{ "arm64.nosve",		"id_aa64pfr0.sve=0" },
 	{ "arm64.nosme",		"id_aa64pfr1.sme=0" },
 	{ "arm64.nobti",		"id_aa64pfr1.bt=0" },
+	{ "arm64.nogcs",		"id_aa64pfr1.gcs=0" },
 	{ "arm64.nopauth",
 	  "id_aa64isar1.gpi=0 id_aa64isar1.gpa=0 "
 	  "id_aa64isar1.api=0 id_aa64isar1.apa=0 "

-- 
2.39.2


