Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A031B58AD30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbiHEPnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240946AbiHEPnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:43:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E212E9DA;
        Fri,  5 Aug 2022 08:43:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B03F2B82757;
        Fri,  5 Aug 2022 15:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC5AC433C1;
        Fri,  5 Aug 2022 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714178;
        bh=klVt3yCrvBHhkydJiycgq8KSkSxzwlLwoeN/vGNg5Z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ueUq3L6xOm1cI747w8OotyMasGVdCemp6GvGdvjciTMP3Ug8Y3wE376q8/ElHl5lt
         1Fe1G5xCnMIcJC1M7MrezbXsjy6Q6DxBks0AFrFbi1Xv2xcMONQhN/XAui1kK7A6tA
         a+ijUX2wIevajtSS7i9Ns1pvI5OiepPVH5E8sDcdlTuYFWADnFasYNsMrJ+uZFk2Dl
         +HxcCeqNSwRYUT6Mo37M4z19M9hG71elDas/T2/ctBRi5WmOU3G6Ham+LwkuISc8dA
         MMaOlXSx6BuHRdaJRbDiv3ueD0eCgZyyzEi04HqlYdfTQ1KUG4OS7mpUltBEm/ozF8
         5IazmXLa6ENtA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v9 02/27] kallsyms: avoid hardcoding buffer size
Date:   Fri,  5 Aug 2022 17:41:47 +0200
Message-Id: <20220805154231.31257-3-ojeda@kernel.org>
In-Reply-To: <20220805154231.31257-1-ojeda@kernel.org>
References: <20220805154231.31257-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

This introduces `KSYM_NAME_LEN_BUFFER` in place of the previously
hardcoded size of the input buffer.

It will also make it easier to update the size in a single place
in a later patch.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/kallsyms.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 52f5488c61bc..f3c5a2623f71 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -27,8 +27,14 @@
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
+#define _stringify_1(x)	#x
+#define _stringify(x)	_stringify_1(x)
+
 #define KSYM_NAME_LEN		128
 
+/* A substantially bigger size than the current maximum. */
+#define KSYM_NAME_LEN_BUFFER	499
+
 struct sym_entry {
 	unsigned long long addr;
 	unsigned int len;
@@ -198,13 +204,13 @@ static void check_symbol_range(const char *sym, unsigned long long addr,
 
 static struct sym_entry *read_symbol(FILE *in)
 {
-	char name[500], type;
+	char name[KSYM_NAME_LEN_BUFFER+1], type;
 	unsigned long long addr;
 	unsigned int len;
 	struct sym_entry *sym;
 	int rc;
 
-	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
+	rc = fscanf(in, "%llx %c %" _stringify(KSYM_NAME_LEN_BUFFER) "s\n", &addr, &type, name);
 	if (rc != 3) {
 		if (rc != EOF && fgets(name, sizeof(name), in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
-- 
2.37.1

