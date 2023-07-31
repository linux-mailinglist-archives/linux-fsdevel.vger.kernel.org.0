Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F4276989B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjGaN5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjGaN4o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C73A3588;
        Mon, 31 Jul 2023 06:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED9056115C;
        Mon, 31 Jul 2023 13:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDCDC433CB;
        Mon, 31 Jul 2023 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690811610;
        bh=6C9vpUKzxaC1YPufnnUpE8qHeuHqYjFB9iVUxK25t6w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=UZFz5zJl1rGYE8fD7JHP53kzdgO69dJ63VOmzz7bUb0LRuW6i+ZcOMuBP5jDkeRes
         0opKxX8qDYyU7cowwofSW23tP91yr2be4yytxli0fu8+qJNaTuoP6yXPE0BzQ/2HJd
         btw9ri7qVDKqBxG9CDZa4sEC+7NsK9s1eXRoR4LIR9/02JoljenLgYA+nviZBBpIy5
         3WFlQYKikMTaZRg8oZMHE5jqtdU5WWNcGod+fL1x8b5uRW6F3CV5PNvRD/qGhWtYMe
         LA9Lwu0Uo9+P//db7CjlsLxsv3amgMixYWOFazIc1PJp2o1GXXEZWoko+CJfn3Bb3w
         3CdSUM0Hussmg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 31 Jul 2023 14:43:35 +0100
Subject: [PATCH v3 26/36] kselftest/arm64: Verify the GCS hwcap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-arm64-gcs-v3-26-cddf9f980d98@kernel.org>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
In-Reply-To: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
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
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6C9vpUKzxaC1YPufnnUpE8qHeuHqYjFB9iVUxK25t6w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkx7wotwwlH/8oWbi9bhoozQqb9Mmh8Aqb/FKJVt4Z
 qCjBxyGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMe8KAAKCRAk1otyXVSH0IsnB/
 9tm+woi16lWLPQgMUT4tC/eRXlObR5g86WJCuPogQIpgBdTwwdKYR98ce07K6N7QDtvGAeT+3D7cTe
 JwbWzUZOYAUDAbdVuM2yT2WvrhhTVVromril0fKmh5LaOewRZNej29XwphRZ168nYzkX0jaCK1z6/5
 KzEm388tMfPmjOVOtet36gYdjmnBWBSD79CpbZUDTtk2Ld5YvAfo01QDVQde95o1Bhp2d8AFYXkUv2
 uzEGsFfsW6vn3HxjeNQxJYuDfaHcq/wCJPt+3WGavHLwqClwxZLMG11kK+ZbZpSL/0sJmUeHkQ6CRM
 nb0Zdkh3/BvB5mcAUTCYuK6uO6A/F8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index d4ad813fed10..38844e4c5aae 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -39,6 +39,17 @@ static void cssc_sigill(void)
 	asm volatile(".inst 0xdac01c00" : : : "x0");
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
 static void mops_sigill(void)
 {
 	char dst[1], src[1];
@@ -223,6 +234,14 @@ static const struct hwcap_data {
 		.cpuinfo = "cssc",
 		.sigill_fn = cssc_sigill,
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
 		.name = "MOPS",
 		.at_hwcap = AT_HWCAP2,

-- 
2.30.2

