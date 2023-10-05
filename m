Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BF37BA7E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 19:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjJERYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjJERXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:23:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BD33C27;
        Thu,  5 Oct 2023 10:17:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A67C433C7;
        Thu,  5 Oct 2023 17:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696526269;
        bh=o5L4igQZuUyyRkvZWeW6hIphjuPRgbdBnW7gTpA7Zqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljD0DSVXW7mrLs6rk+uo3OA3n8H7FoAXevG0rpTNVXlO2DhM+97akz/db9F7eliN5
         SNbIT+B6xWAsEWFkyhHl9KEp9sDqDYd3nOR1FdJrXGba22PQ0OtrtztDB0xiLMUv4U
         NsIIAYqd5gIEja/x0tSYJgWFIS1sFMR4e5JhWh+kFR6GKb4Z4eU3efb+QA+VxubfD5
         iJlmKXTYybduRDmv5K4UakHiSKx5UD2e7jPt8calVUcE8g2+UF9dQYAPuDmVzB9mKK
         RbgR4Q1HEngsKrSmb1wyPZLhT7YcBmnLC83OK62ejaUH/O5hGMEiPr7lL94GLALGEr
         73I98sKn9MlgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 167D2CE0975; Thu,  5 Oct 2023 10:17:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH bootconfig 2/3] fs/proc: Add boot loader arguments as comment to /proc/bootconfig
Date:   Thu,  5 Oct 2023 10:17:46 -0700
Message-Id: <20231005171747.541123-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <6ea609a4-12e3-4266-8816-b9fca1f1f21c@paulmck-laptop>
References: <6ea609a4-12e3-4266-8816-b9fca1f1f21c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
show all kernel boot parameters, both those supplied by the boot loader
and those embedded in the kernel image.  This works well for those who
just want to see all of the kernel boot parameters, but is not helpful to
those who need to see only those parameters supplied by the boot loader.
This is especially important when these parameters are presented to the
boot loader by automation that might gather them from diverse sources.
It is also useful when booting the next kernel via kexec(), in which
case it is necessary to supply only those kernel command-line arguments
from the boot loader, and most definitely not those that were embedded
into the current kernel.

Therefore, add comments to /proc/bootconfig of the form:

	# Parameters from bootloader:
	# root=UUID=ac0f0548-a69d-43ca-a06b-7db01bcbd5ad ro quiet ...

The second added line shows only those kernel boot parameters supplied
by the boot loader.

Link: https://lore.kernel.org/all/CAHk-=wjpVAW3iRq_bfKnVfs0ZtASh_aT67bQBG11b4W6niYVUw@mail.gmail.com/
Link: https://lore.kernel.org/all/20230731233130.424913-1-paulmck@kernel.org/
Co-developed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: <linux-trace-kernel@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>
---
 fs/proc/bootconfig.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index 2e244ada1f97..902b326e1e56 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -62,6 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 				break;
 			dst += ret;
 		}
+		if (ret >= 0 && boot_command_line[0]) {
+			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
+				       boot_command_line);
+			if (ret > 0)
+				dst += ret;
+		}
 	}
 out:
 	kfree(key);
-- 
2.40.1

