Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE5962536C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 07:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiKKGN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 01:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiKKGNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:13:24 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C387B9C
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 22:13:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so6910162pjs.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 22:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJbZhJS9Ev1XMOM4wW/EgY/OFSEa8D+Vt9N5SxaJSHs=;
        b=a2uE97e3Dcchu89fkZ3gY9WePVwKJGjK7Up57d0kS7VljHzA93kFQnDEGoaNzk7akx
         FbE5jDsPkJoQOdhi2fpzKV0AMFBEuO7sqUB6aKbW50VryFTbonmAC0ItGTxOz55L/XJW
         82c/fFG9f1otpcAjcMtZBQMf8sGiejXUweLag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJbZhJS9Ev1XMOM4wW/EgY/OFSEa8D+Vt9N5SxaJSHs=;
        b=u24UO7wWVeKo/vyQOikMino5C7BXztWdN5sjX1gmNxZgiXGRnG7HkZ6q1fy+WuGWN+
         lqEu6aUdVSYoN28vf1Y/HnKSaWZsrDeUpw7XX5gc5gihRzQ/UM3m4kpysqLxD6Z54mCx
         ZE68Qs40YOJ/CwkMrE7E8B0UG9HyphCjA9OEKzwK1/UZAVCk21s7Z2CAvM4UQSXpcnX7
         IMuiFIIe8smiNIaOmwr8x3DY21FpooYYiftQRhZWEW50Vxwnk7wHlAmaFSid3OpVdrck
         L9qOYeD7P/ZmdR3Dj3hGJvl94N4pldx/bV+j0CJF43ooqqWwJZ6y/BYlUEULFNZ+6hXT
         XuOw==
X-Gm-Message-State: ANoB5pmwP9rDxtVv8vpThU+bTyylhDoyxjCy764R0L2ancwJ12ujIiBT
        f6tP7da6CnP9Aon81pSlWK9xcA==
X-Google-Smtp-Source: AA0mqf6MjTXRlKDFh5J/QealI2TZICyMWy1lWdOK6vVH3VGXWxISZjjfHqxAOEHoddGtvzLObxhABg==
X-Received: by 2002:a17:902:82c5:b0:188:547d:b142 with SMTP id u5-20020a17090282c500b00188547db142mr1151214plz.103.1668147202950;
        Thu, 10 Nov 2022 22:13:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b0017f9021ddc6sm738931ple.289.2022.11.10.22.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 22:13:22 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Rich Felker <dalias@libc.org>,
        Fangrui Song <maskray@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] binfmt_elf: Allow .bss in any interp PT_LOAD
Date:   Thu, 10 Nov 2022 22:13:20 -0800
Message-Id: <20221111061315.gonna.703-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024; h=from:subject:message-id; bh=Y24MMuXgCRmwN8M9lMQ21fXH3PL7d1cIRSZ/p8LhrwM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjbef/6hzUuUZGLGrWJBWxgKZYE29qBjmhTy3LRXQp irXkyeaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY23n/wAKCRCJcvTf3G3AJk3dEA CIXfVDmGV7/YBxAB4wFGgxUpRivIRXez/dovh1l8xssD3q3bjdUJrxkzCsPrcEE/xNrOZiIHiXYFJV fCcQfwtmeVU1WrRUCGhwPxnfuMweCUte6qAuXQNNrf0swBefm8UYxQ3J3PfLPSWas6F32v+4mGkMMH UW69zCp+/TB87IXYknrKqw8PiE3SdOeNnZhnwfuQH9VWlNvy4Z0r1A9WCduyTXODw6CNC6MzTZDBoX 6pUzR+XyqvJARUHcg5mjPXrTUX4Odh9VmKMRT/vL6H4jQxKg2gSj/fMmY6jTnRlgEY93I+82L0Jlag jZfXxNKbSiCD84qLRUJwhHtFfypBrQtDiQzyN3piesT0vUmPHxwAVez+lf6sPmJDxm+ZsvtpePbCgP 3Gw0WHeuR5naODEOwvE+mBJWMIKzDjSlrzsdQ74Wot+ZzvE5keQN08R4UWVeCcu0y5pMPsTORxZE7K rJSOOaKvAlEEqJ+mPrszpXCudNN1d655Jt2fUIJj5gM4MtzNnC5trkijk6OzYwcUUlCQd5ScyFKvlV jezeFCHDx1aimUkMkSLCBnkXbVSd2wklLcscSFVqZiHxEWygZzNFbs6NRSyFTemptbIKZTvpeR50lW nJ+zAROtHOVfVb4upzYWUVOn8+t8vEaSzruQdPPvEQrV4Xm9O0BbQOJytazA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Traditionally, only the final PT_LOAD for load_elf_interp() supported
having p_memsz > p_filesz. Recently, lld's construction of musl's
libc.so on PowerPC64 started having two PT_LOAD program headers with
p_memsz > p_filesz.

As the least invasive change possible, check for p_memsz > p_filesz for
each PT_LOAD in load_elf_interp.

Reported-by: Rich Felker <dalias@libc.org>
Link: https://maskray.me/blog/2022-11-05-lld-musl-powerpc64
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Fangrui Song <maskray@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: I realized we need to retain the final padding call.
v1: https://lore.kernel.org/linux-hardening/20221111055747.never.202-kees@kernel.org/
---
 fs/binfmt_elf.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 528e2ac8931f..0a24bbbef1d6 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -673,15 +673,25 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				last_bss = k;
 				bss_prot = elf_prot;
 			}
+
+			/*
+			 * Clear any p_memsz > p_filesz area up to the end
+			 * of the page to wipe anything left over from the
+			 * loaded file contents.
+			 */
+			if (last_bss > elf_bss && padzero(elf_bss))
+				error = -EFAULT;
+				goto out;
+			}
 		}
 	}
 
 	/*
-	 * Now fill out the bss section: first pad the last page from
-	 * the file up to the page boundary, and zero it from elf_bss
-	 * up to the end of the page.
+	 * Finally, pad the last page from the file up to the page boundary,
+	 * and zero it from elf_bss up to the end of the page, if this did
+	 * not already happen with the last PT_LOAD.
 	 */
-	if (padzero(elf_bss)) {
+	if (last_bss == elf_bss && padzero(elf_bss)) {
 		error = -EFAULT;
 		goto out;
 	}
-- 
2.34.1

