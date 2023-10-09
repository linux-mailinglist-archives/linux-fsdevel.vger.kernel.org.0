Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29397BDB7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 14:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346576AbjJIMVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 08:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346578AbjJIMVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:21:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7771AA;
        Mon,  9 Oct 2023 05:13:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A219C4339A;
        Mon,  9 Oct 2023 12:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696853633;
        bh=CQJ0Nn/FrNQwik1UANJ8xSGTPojw3dSDEOcln7FrjBk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NeKlb9iqE4AGE1VnnuuEDi9x2qHDhG39YDOtQOygNJGcp/7puO71yjWwEgjDhH3Ok
         EsjeQrTlMbsE9cdsW802P0C4KwKQrLhXCAVPvYoMyhwdzLylGiRYrjWH/2pZ60L35S
         a9jKGbTd5a1hArbwkwropJxQO7vTjD7c0Xx2znQT6EoNdzaeRtiC4g26P+M7uLgWrS
         b3oQO2OsLcUn+5vvhhOIDKBd0jOw7N1t0STVQxilRLL4vRA2LTeFElBL2WUiAMl4Hv
         HOWchYwqBex8aqYopW1sVnLkcj0J6hahyC/X4knAzKLC7SCmnLWKhbRz/SG+nIDF/N
         IhyAEtwkn59tQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 09 Oct 2023 13:09:02 +0100
Subject: [PATCH v6 28/38] kselftest/arm64: Verify the GCS hwcap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-arm64-gcs-v6-28-78e55deaa4dd@kernel.org>
References: <20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org>
In-Reply-To: <20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CQJ0Nn/FrNQwik1UANJ8xSGTPojw3dSDEOcln7FrjBk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlI+2nVuVBXqjsn2LJUIT0YQm3p4RqL6b7G3kTo12X
 jK0EkTuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZSPtpwAKCRAk1otyXVSH0DpxB/
 oD/2yjl18oaUFoxgjlXboHnU3Vdbj18snA/U+HNmjP8ycDMAla/rlRZJTMobzcc6q3xUzjBw6Qby42
 XQwsre3+1XKPZXNnbbU4/AE729y6HgZeTm9fQ6OYXPXHqyLSUC70l8Mo4jdi6hLBwPh6S8TQSHX7NQ
 gwp1jXGMDhHgNWm9OEXmFTt5+FD7DPoWDWt02MDae8YapOFbDrFRg5urZTSdSJLdZnCDJ77TJT4QQP
 vhmv94GFddGFi32RfpOmDdfT0/fr2hdAfocT2Sv6jv7q5XCYP8ofxBQ1QvfGbrhqxoMKQwleOK6puP
 vrqiRdibSz+Kgt6dLzej/2YoOwjid2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add coverage of the GCS hwcap to the hwcap selftest, using a read of
GCSPR_EL0 to generate SIGILL without having to worry about enabling GCS.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index e3d262831d91..785c9a4ad666 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -63,6 +63,17 @@ static void fp_sigill(void)
 	asm volatile("fmov s0, #1");
 }
 
+static void gcs_sigill(void)
+{
+	unsigned long *gcspr;
+
+	asm volatile(
+		"mrs	%0, S3_3_C2_C5_1"
+	: "=r" (gcspr)
+	:
+	: "cc");
+}
+
 static void ilrcpc_sigill(void)
 {
 	/* LDAPUR W0, [SP, #8] */
@@ -327,6 +338,14 @@ static const struct hwcap_data {
 		.cpuinfo = "fp",
 		.sigill_fn = fp_sigill,
 	},
+	{
+		.name = "GCS",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_GCS,
+		.cpuinfo = "gcs",
+		.sigill_fn = gcs_sigill,
+		.sigill_reliable = true,
+	},
 	{
 		.name = "JSCVT",
 		.at_hwcap = AT_HWCAP,

-- 
2.30.2

