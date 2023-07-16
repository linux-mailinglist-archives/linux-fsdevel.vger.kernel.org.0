Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6274755792
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 23:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjGPVyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 17:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGPVxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:53:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1741110D3;
        Sun, 16 Jul 2023 14:53:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DABD60ECC;
        Sun, 16 Jul 2023 21:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40995C433CA;
        Sun, 16 Jul 2023 21:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689544407;
        bh=k6DV13RSkbr/e436II0jx5LmEFZf9bksk2EmOe6Nllo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uzQ1im68+uRYQ37l8Y3P5U7a8pIhItxesP5/Ha+GLa0KYNA17P2Sta1FT5WU4v/L6
         KvGIaLo1Zf0YNf5AUzcQObikFG+QXtksSN5NaCCbREi2N8a60cRmz7EDDt40xJavJV
         QzVjeBwSmghoOY24pG+Cyu/XMk1zBQGVjleqyLkSNAWIZ4ttEJE5piLkrmZby4eBbs
         v2C2rloKFR1t9/PP7O23fZSv6c19/onAYb8xDtkEQ8iNNAZ1GfmHADXH2UqVoMLxhp
         o2aQy8HsyX9S0YD3U72tJ+wutyVibdlTzK0pnEmYK/6svtAto3cQuUk86mP0GVxoZC
         JlgDpAPp1FZSQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 16 Jul 2023 22:51:02 +0100
Subject: [PATCH 06/35] arm64/sysreg: Add definitions for architected GCS
 caps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-arm64-gcs-v1-6-bf567f93bba6@kernel.org>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
In-Reply-To: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=broonie@kernel.org;
 h=from:subject:message-id; bh=k6DV13RSkbr/e436II0jx5LmEFZf9bksk2EmOe6Nllo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktGaTmVK0TUI9LTFT/azN8/vjq2wV953BMqK+9snM
 Pa5vL1yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLRmkwAKCRAk1otyXVSH0CqmB/
 4436TL/EM1gB8ywH6nr0DbwUHDj9CyTDdqJ2nvvtMQHXypn6q1307YvWxphCq4QKu1CoiR08Yzopui
 ceroA2JEG6hNuK9ifvwEpIOhmNN2Z1vu98yD1FQ3Pprpva7RxrgZ6JKxg5zFKHwpZViKW8DxxpXIiX
 iLnEeOd0ypipAGU0VyMjNKhWsQcRvd/uYrYkgUXDXiYhqUQe26jt4yZJwfKJqZuSpNSlTnB1F1ERIf
 9LKLi77VcX8jSllnqf2E4me97wzF8b6ygPLDtkalK9GdBfUSUHR2G8VNTKHj2T/VtBzwbT8Gti+SUu
 Ijul9BpfaBVsABhYmIConTkXBeTtDm
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

The architecture defines a format for guarded control stack caps, used
to mark the top of an unused GCS in order to limit the potential for
exploitation via stack switching. Add definitions associated with these.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index b481935e9314..3d7f9b25b8fb 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -730,6 +730,26 @@
 
 #define PIRx_ELx_PERM(idx, perm)	((perm) << ((idx) * 4))
 
+/*
+ * Definitions for Guarded Control Stack
+ */
+
+#define GCS_CAP_ADDR_MASK		GENMASK(63, 12)
+#define GCS_CAP_ADDR_SHIFT		12
+#define GCS_CAP_ADDR_WIDTH		52
+#define GCS_CAP_ADDR(x)			FIELD_GET(GCS_CAP_ADDR_MASK, x)
+
+#define GCS_CAP_TOKEN_MASK		GENMASK(11, 0)
+#define GCS_CAP_TOKEN_SHIFT		0
+#define GCS_CAP_TOKEN_WIDTH		12
+#define GCS_CAP_TOKEN(x)		FIELD_GET(GCS_CAP_TOKEN_MASK, x)
+
+#define GCS_CAP_VALID_TOKEN		0x1
+#define GCS_CAP_IN_PROGRESS_TOKEN	0x5
+
+#define GCS_CAP(x)	((((unsigned long)x) & GCS_CAP_ADDR_MASK) | \
+					       GCS_CAP_VALID_TOKEN)
+
 #define ARM64_FEATURE_FIELD_BITS	4
 
 /* Defined for compatibility only, do not add new users. */

-- 
2.30.2

