Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C27A6BC297
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 01:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjCPAbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 20:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjCPAba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:31:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0406A2F13
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 17:31:21 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t2-20020a632d02000000b005075b896422so5017pgt.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 17:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678926680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JjmIOJvjUEG2+4aovgmSBlRBGRP0JRLKbOkhR3o7e/I=;
        b=XWGmJ9JAs9QizM49LznB/3WeGWT9Pc+PU89wCd8j/FUtVE5mMn/ax/bL088f1qtOz1
         RFmCWBaiH29nU9Rm1KEJYwwbJN+AkVaHOxnJG89ZrDJuTFkTNXO5WvuZG2ISNDllw0uo
         fSjaUkPVuesviWcTzk98UxYatwmpd417x6c+02nHUCPhFRDc3jObfLW3h3zTrxlqgUMt
         LSd6LeHzPnNB0IV8pPZgCTjW0bYxKCuKc0IBsjiwto4vhAFiBAjpHsDO9Qt092Ms2tAr
         DgVpYe+MAJleDmnTkKW5CLiYIwwbNbMGX4Gf9ND5AcxA8F5WN4Z2xDh5NS+5PrMXSWp9
         XSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678926680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjmIOJvjUEG2+4aovgmSBlRBGRP0JRLKbOkhR3o7e/I=;
        b=SnSvmEJ8sxvHavPpNjo+D9OIugZ2C0VHFJUwA6itQbR59buEB/EkN0vpaEkz6gvevP
         gM+v28id5Lev6Rr5QaVur48p7+BMHaJy2st4tOga9ys2akFO64AKvBDKWaCkqmMlIyS8
         RC1QTvkgmEjpyEJx1ieXACdk80CCeVyUNnWRyM+f1DSH1qhSIIsJmV4vBj9rkFbkDzFp
         iYqcbADlBakRPBpVa2MKLmjTl3tN3PN+K9LTfDuAk7E7gSY5yAGhu3S79igZwgV2xn2O
         K55qP0/e9+a3ssXWxZNWEv70gjn74Iaa4hIhq/BQ6kFxlN/pwfnWN9XuFpLTROMa8Lpq
         UE5w==
X-Gm-Message-State: AO0yUKVKwcl/QS6+/hn9/joKFrZRgOg2mRQx4HQkF+Ii7g+P1wDlaNIM
        ugle4Qr/i225T2KDo7diuEFykAVV+8L8WUyEwg==
X-Google-Smtp-Source: AK7set+j36PrTQ1uWKwZ/ZTMviUfrC3nfQJHH3bSUBCARqM/YyB/PYWAqeXRAUTM8xOy7rllnybTZtBO0uvKhOtP8A==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:e5cb:b0:1a0:4346:d43e with
 SMTP id u11-20020a170902e5cb00b001a04346d43emr595748plf.11.1678926680301;
 Wed, 15 Mar 2023 17:31:20 -0700 (PDT)
Date:   Thu, 16 Mar 2023 00:30:56 +0000
In-Reply-To: <cover.1678926164.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1678926164.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <48490641ce981c31ea58c11ad478ff85cd0dd156.1678926164.git.ackerleytng@google.com>
Subject: [RFC PATCH 03/10] KVM: selftests: Test that VM private memory should
 not be readable from host
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After VM memory is remapped as private memory and guest has written to
private memory, request the host to read the corresponding hva for
that private memory.

The host should not be able to read the value in private memory.

This selftest shows that private memory contents of the guest are not
accessible to host userspace via the HVA.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/x86_64/private_mem_conversions_test.c | 54 ++++++++++++++++---
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
index ef9894340a2b..f2c1e4450b0e 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
@@ -47,6 +47,16 @@ static void memcmp_h(uint8_t *mem, uint8_t pattern, size_t size)
 			    pattern, i, mem[i]);
 }
 
+static void memcmp_ne_h(uint8_t *mem, uint8_t pattern, size_t size)
+{
+	size_t i;
+
+	for (i = 0; i < size; i++)
+		TEST_ASSERT(mem[i] != pattern,
+			    "Expected not to find 0x%x at offset %lu but got 0x%x",
+			    pattern, i, mem[i]);
+}
+
 /*
  * Run memory conversion tests with explicit conversion:
  * Execute KVM hypercall to map/unmap gpa range which will cause userspace exit
@@ -64,8 +74,14 @@ static void memcmp_h(uint8_t *mem, uint8_t pattern, size_t size)
 
 #define GUEST_STAGE(o, s) { .offset = o, .size = s }
 
-#define GUEST_SYNC4(gpa, size, current_pattern, new_pattern) \
-	ucall(UCALL_SYNC, 4, gpa, size, current_pattern, new_pattern)
+#define UCALL_RW_SHARED (0xca11 - 0)
+#define UCALL_R_PRIVATE (0xca11 - 1)
+
+#define REQUEST_HOST_RW_SHARED(gpa, size, current_pattern, new_pattern) \
+	ucall(UCALL_RW_SHARED, 4, gpa, size, current_pattern, new_pattern)
+
+#define REQUEST_HOST_R_PRIVATE(gpa, size, expected_pattern) \
+	ucall(UCALL_R_PRIVATE, 3, gpa, size, expected_pattern)
 
 static void guest_code(void)
 {
@@ -86,7 +102,7 @@ static void guest_code(void)
 
 	/* Memory should be shared by default. */
 	memset((void *)DATA_GPA, ~init_p, DATA_SIZE);
-	GUEST_SYNC4(DATA_GPA, DATA_SIZE, ~init_p, init_p);
+	REQUEST_HOST_RW_SHARED(DATA_GPA, DATA_SIZE, ~init_p, init_p);
 	memcmp_g(DATA_GPA, init_p, DATA_SIZE);
 
 	for (i = 0; i < ARRAY_SIZE(stages); i++) {
@@ -113,6 +129,12 @@ static void guest_code(void)
 		kvm_hypercall_map_private(gpa, size);
 		memset((void *)gpa, p2, size);
 
+		/*
+		 * Host should not be able to read the values written to private
+		 * memory
+		 */
+		REQUEST_HOST_R_PRIVATE(gpa, size, p2);
+
 		/*
 		 * Verify that the private memory was set to pattern two, and
 		 * that shared memory still holds the initial pattern.
@@ -133,11 +155,20 @@ static void guest_code(void)
 				continue;
 
 			kvm_hypercall_map_shared(gpa + j, PAGE_SIZE);
-			GUEST_SYNC4(gpa + j, PAGE_SIZE, p1, p3);
+			REQUEST_HOST_RW_SHARED(gpa + j, PAGE_SIZE, p1, p3);
 
 			memcmp_g(gpa + j, p3, PAGE_SIZE);
 		}
 
+		/*
+		 * Even-number pages are still mapped as private, host should
+		 * not be able to read those values.
+		 */
+		for (j = 0; j < size; j += PAGE_SIZE) {
+			if (!((j >> PAGE_SHIFT) & 1))
+				REQUEST_HOST_R_PRIVATE(gpa + j, PAGE_SIZE, p2);
+		}
+
 		/*
 		 * Convert the entire region back to shared, explicitly write
 		 * pattern three to fill in the even-number frames before
@@ -145,7 +176,7 @@ static void guest_code(void)
 		 */
 		kvm_hypercall_map_shared(gpa, size);
 		memset((void *)gpa, p3, size);
-		GUEST_SYNC4(gpa, size, p3, p4);
+		REQUEST_HOST_RW_SHARED(gpa, size, p3, p4);
 		memcmp_g(gpa, p4, size);
 
 		/* Reset the shared memory back to the initial pattern. */
@@ -209,7 +240,18 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type)
 		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			REPORT_GUEST_ASSERT_4(uc, "%lx %lx %lx %lx");
-		case UCALL_SYNC: {
+		case UCALL_R_PRIVATE: {
+			uint8_t *hva = addr_gpa2hva(vm, uc.args[0]);
+			uint64_t size = uc.args[1];
+
+			/*
+			 * Try to read hva for private gpa from host, should not
+			 * be able to read private data
+			 */
+			memcmp_ne_h(hva, uc.args[2], size);
+			break;
+		}
+		case UCALL_RW_SHARED: {
 			uint8_t *hva = addr_gpa2hva(vm, uc.args[0]);
 			uint64_t size = uc.args[1];
 
-- 
2.40.0.rc2.332.ga46443480c-goog

