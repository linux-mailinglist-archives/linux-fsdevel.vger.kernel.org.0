Return-Path: <linux-fsdevel+bounces-3716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC8C7F7955
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAEF1C20E69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D29535F01;
	Fri, 24 Nov 2023 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EC3919AA;
	Fri, 24 Nov 2023 08:36:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB5B1C01;
	Fri, 24 Nov 2023 08:37:10 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C6C93F73F;
	Fri, 24 Nov 2023 08:36:21 -0800 (PST)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	will@kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v3 25/25] KVM: selftests: get-reg-list: add Permission Overlay registers
Date: Fri, 24 Nov 2023 16:35:10 +0000
Message-Id: <20231124163510.1835740-26-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124163510.1835740-1-joey.gouly@arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new system registers:
  - POR_EL1
  - POR_EL0

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 709d7d721760..ac661ebf6859 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -40,6 +40,18 @@ static struct feature_id_reg feat_id_regs[] = {
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
 		4,
 		1
+	},
+	{
+		ARM64_SYS_REG(3, 0, 10, 2, 4),	/* POR_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
+		16,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 3, 10, 2, 4),	/* POR_EL0 */
+		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
+		16,
+		1
 	}
 };
 
@@ -468,6 +480,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 10, 2, 0),	/* MAIR_EL1 */
 	ARM64_SYS_REG(3, 0, 10, 2, 2),	/* PIRE0_EL1 */
 	ARM64_SYS_REG(3, 0, 10, 2, 3),	/* PIR_EL1 */
+	ARM64_SYS_REG(3, 0, 10, 2, 4),	/* POR_EL1 */
 	ARM64_SYS_REG(3, 0, 10, 3, 0),	/* AMAIR_EL1 */
 	ARM64_SYS_REG(3, 0, 12, 0, 0),	/* VBAR_EL1 */
 	ARM64_SYS_REG(3, 0, 12, 1, 1),	/* DISR_EL1 */
@@ -475,6 +488,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 13, 0, 4),	/* TPIDR_EL1 */
 	ARM64_SYS_REG(3, 0, 14, 1, 0),	/* CNTKCTL_EL1 */
 	ARM64_SYS_REG(3, 2, 0, 0, 0),	/* CSSELR_EL1 */
+	ARM64_SYS_REG(3, 3, 10, 2, 4),	/* POR_EL0 */
 	ARM64_SYS_REG(3, 3, 13, 0, 2),	/* TPIDR_EL0 */
 	ARM64_SYS_REG(3, 3, 13, 0, 3),	/* TPIDRRO_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 0, 1),	/* CNTPCT_EL0 */
-- 
2.25.1


