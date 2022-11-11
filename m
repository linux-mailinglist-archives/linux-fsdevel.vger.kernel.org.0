Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C99262533D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 06:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiKKF6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 00:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKKF57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 00:57:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1BB6F351
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 21:57:57 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so6907799pji.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 21:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KHGjxOmAPLTjSOKR1E4aRsoBMeGm6miKnYzYvwRoo/8=;
        b=gohmZcSym6vfl404dEer4RoKFe3HbwM9Rjry0f1+FaJjNGXrOUU3IzieHCGv9fVlXU
         20HPKuKbTfKr27+1pOgyQagqOwshsJdmX4++YUlZIJXEP0+OKkA7uvi2RIXbNPR061cE
         wLFe9pHX6mFxXca6OZ0XiYwMbnGgeQ3SH20Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHGjxOmAPLTjSOKR1E4aRsoBMeGm6miKnYzYvwRoo/8=;
        b=sSmkmonfC6KbqVbyd3HCg+G5QCgwrUQPcvhG61Ei0eKAnIjCi3Bz6EcgOLBQ48gBql
         Adnwi5/6UkOx433xGzJa/V6hT6lgP1do4O88G6vZHSaMq+Jf/PWBK0imFIdm9kbPrEkv
         rMVYu0F/W06urRVpGoFNR9LfALVjMdTxvZsFqmxykWtWFo55r57v9U9lK/vkOdtq8hSS
         1ZkGVCxeI6XmuIatF2GCj8AzWukTdKYmFQppiN7Y8QHRh30xQzFCecMj1KbqzGuHjMYn
         ejrruTPKkpOcPtzvLjlV8WJRo8EH7fxWAhXMAC6ntlySwjTwm7ns04ebFjyfvdihPeWb
         LPgA==
X-Gm-Message-State: ANoB5pltbyN5l+rxUcQDOKS41Ik2WyyWSp0S5jQYrEQoqsPI2+z1A/0L
        0yjKP1+lGeyko1Frxfy+BlQphw==
X-Google-Smtp-Source: AA0mqf7iCcbOHwArRxyvqVIciEKulpY/TXf68aGvXkWAfzFVPXNotTaucQGneOg2BSYMzD+eEfnsGg==
X-Received: by 2002:a17:902:efd1:b0:17b:4ace:b67f with SMTP id ja17-20020a170902efd100b0017b4aceb67fmr1229537plb.12.1668146277473;
        Thu, 10 Nov 2022 21:57:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y197-20020a62cece000000b0056c47a5c34dsm662595pfg.122.2022.11.10.21.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 21:57:57 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Rich Felker <dalias@libc.org>,
        Fangrui Song <maskray@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] binfmt_elf: Allow .bss in any interp PT_LOAD
Date:   Thu, 10 Nov 2022 21:57:54 -0800
Message-Id: <20221111055747.never.202-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; h=from:subject:message-id; bh=IFv7zG9ua/TUw6RPzUQWoXA14J5yfz12EiQFTB5lii0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjbeRibkBnJb+JHCktBamRZlj///oiFFeK7VpOpPsB 44aQDc2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY23kYgAKCRCJcvTf3G3AJnJvD/ wMpSquxigcVJfg5ewqR3cpfP5urArMS1hWUeQchcdyXTMfEUFgqyt9Ty+7OE6vdD/z3R3uiC3lpphP FBxBvEkLF5ZynousHcyUauCkIiwZT1PLigA2z5DGCbu2tRUOeUZEI4uaYvMxWwJf+LoEIgjeWcXlHH QfBmP/w18M2HZvcH5ma39HbdZQPEU9Nn1sa4/WuZLf6xs+a6yVjJL2JpWk1Z6Md0kGbSu/n7KQkvRM OtJvFB3QrDrI8Mhm/UgZ/44bBI8kpStf/wXcD2PCGfSie6D+bPUvNlMk0t8eVQ0tq22d3po13Shtph N8IJDsgmVLbS0jbJLbWS5DQN5RlRrvmd+ss6JeZeCxMQVyJsUbft/Yydnvd6uxj/WLMK/Y1SsMrBgR vvBEdrAbJ1uO6PTohfPWyTOBG4P0nwz5/GodjBItoS6ceZjbf5tr82KhuQ8skBW+uztDUbi98znHu7 494BhsMzVXPETrqKnMIshOd0fSUYuawrnNvCqKGN0O4MYRiv06uCFYyyK45PqZOsFT2NA7U1hC8FF+ 11Hn4IoGq6LaAsuVbgTfBE7LR0lxPnBLwXLrsf3woKx8wRL7SCI7XKcYsaHeu0JFg/ukPkU1tMpiII tv6vNwpD91PO6uTpbXuWBE8xgYj3IBtoPba44NCzuwf246ajS31oQK2S+zVA==
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
Rich, Pedro, and Fangrui, are you able to test this change? I haven't
constructed a trivial reproducer yet (though it would be nice to have
a self-contained test-case).
---
 fs/binfmt_elf.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 528e2ac8931f..3f07945ff085 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -673,18 +673,19 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				last_bss = k;
 				bss_prot = elf_prot;
 			}
+
+			/*
+			 * Now fill out any zeroed region (e.g. .bss): first pad the
+			 * last page from the file up to the page boundary, and zero
+			 * it from elf_bss up to the end of the page.
+			 */
+			if (last_bss > elf_bss && padzero(elf_bss)) {
+				error = -EFAULT;
+				goto out;
+			}
 		}
 	}
 
-	/*
-	 * Now fill out the bss section: first pad the last page from
-	 * the file up to the page boundary, and zero it from elf_bss
-	 * up to the end of the page.
-	 */
-	if (padzero(elf_bss)) {
-		error = -EFAULT;
-		goto out;
-	}
 	/*
 	 * Next, align both the file and mem bss up to the page size,
 	 * since this is where elf_bss was just zeroed up to, and where
-- 
2.34.1

