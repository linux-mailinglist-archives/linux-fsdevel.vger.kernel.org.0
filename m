Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2919375F740
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGXMxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 08:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjGXMxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDDD171B;
        Mon, 24 Jul 2023 05:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68D2D6115B;
        Mon, 24 Jul 2023 12:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DD1C433D9;
        Mon, 24 Jul 2023 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690202997;
        bh=DtrqsekNxnVEUxJ8rAESK/JTguJ8OvysbbylOwjoIT0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IUoZTFytVGL4xL7IhIxdg1nWec1xqYOM3rC8hP5r7Ed3fjKC6Epo6KgMdnaCGtZRE
         /1Ia7SCVFhMN7008WtWRIVVIQewdoaH/kLojOC/4B8CeSMYhg/9WvHvzEdZDrdNhM/
         ZppJfgvJmeUYCboPphugV+Qc4zfN8d7SrKHz4Pgm039wTNQ83NIiKGqlB6w5BrY+lP
         SS2KPsG6UsSf4E9abb94zbB5S3eFhHqLBXDRN4l1suiGEkxttzaapRbGn+YCasRGel
         bGdb5JDjalsMIDleYixTH358UfPeKiW43FfZDzuafowTWjq5JJq1F7TpsimiGwZP2b
         fbtQWo91n0esg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 24 Jul 2023 13:46:15 +0100
Subject: [PATCH v2 28/35] kselftest/arm64: Add framework support for GCS to
 signal handling tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-arm64-gcs-v2-28-dc2c1d44c2eb@kernel.org>
References: <20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org>
In-Reply-To: <20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DtrqsekNxnVEUxJ8rAESK/JTguJ8OvysbbylOwjoIT0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkvnKw/Lzy9vRLhQ0v13Z2E1an+ZYJFNFtfGDMR5qc
 2iz7nAKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZL5ysAAKCRAk1otyXVSH0Dv/B/
 9z12rHapBgNvwTFstRW+LvaYq4zIFOeh7QfQsNxWufo6IybVnbM+Hvd0mXm4AjTv/BSluOomrarAEr
 m3sxqGmEoeUCUnwYUab6uGpkjrUOG0c4Vow9UuK4BDQ8IsGg63BT2nP+T+DQEIBN+MzYp4BF6e9yBS
 sqqcXKNecviuKIdE0tlR3/D6YYzJKwPOqJDLOvrrA6DsmD9JDj/p4NQEjt95ikt6ivRQ70L32KKP0D
 /hduQnIfCgJZ3Z+IR33Z2xIrkZUkqbaUXnvXzYMwAGdpajGCshPQve1wb+BzsV4pXBkDDGv2EFXYLv
 KFvvodUxTwYEQrCmkpjw9Sl04yI9WO
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

Teach the framework about the GCS signal context, avoiding warnings on
the unknown context.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.c | 7 +++++++
 tools/testing/selftests/arm64/signal/testcases/testcases.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 9f580b55b388..1cd124732be4 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -209,6 +209,13 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			zt = (struct zt_context *)head;
 			new_flags |= ZT_CTX;
 			break;
+		case GCS_MAGIC:
+			if (flags & GCS_CTX)
+				*err = "Multiple GCS_MAGIC";
+			if (head->size != sizeof(struct gcs_context))
+				*err = "Bad size for gcs_context";
+			new_flags |= GCS_CTX;
+			break;
 		case EXTRA_MAGIC:
 			if (flags & EXTRA_CTX)
 				*err = "Multiple EXTRA_MAGIC";
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index a08ab0d6207a..9b2599745c29 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -19,6 +19,7 @@
 #define ZA_CTX		(1 << 2)
 #define EXTRA_CTX	(1 << 3)
 #define ZT_CTX		(1 << 4)
+#define GCS_CTX		(1 << 5)
 
 #define KSFT_BAD_MAGIC	0xdeadbeef
 

-- 
2.30.2

