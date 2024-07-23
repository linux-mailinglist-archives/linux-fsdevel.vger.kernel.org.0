Return-Path: <linux-fsdevel+bounces-24115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF735939D4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 11:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E73E282F7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 09:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C450F14D2B2;
	Tue, 23 Jul 2024 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhI6aT3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332E14BFB4;
	Tue, 23 Jul 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721725924; cv=none; b=WkhY+Pp+bR7FPh32NbVTfAQGFQBTIW6k5ewJZgL77CjOa3lFc/LFsorrNBWWE0JaNmWiWdqM4wWHwMw01EX11SgjhTApI1RBqjXYeq83w16FO0Zut89P3ROoiH7IiPAHC3CcMkOfdQ1AH4QUPUKe4hSKphU4GOE+xlEL6TitwLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721725924; c=relaxed/simple;
	bh=GiuCeU2EEv4YGcuxeW3WohJ+rAWPLx3yNP61gNIUsZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y0LEllalDoKmRhrjFeqQUNnmhKSc1JP8bO3RqZVitiRqJWxeIn78btzf5Jm9QOgJ64hXuImSDiu3dbfLwKtHOWz7ZwmHgaJmnyE7HTm9aFlyN1bxJgvtXHOx+gq9LnD9GwrnvGrIBfNxItvPvH4I1p3Xhz9Mh0YGU6pDc3qKN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhI6aT3j; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d333d5890so1147170b3a.0;
        Tue, 23 Jul 2024 02:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721725921; x=1722330721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5NOfvVrRF8+r3VwS12jIQzSFt0uID0WbrULFoZ3kO4=;
        b=dhI6aT3j2yiX8QtlxPBSRQ7YI5e8AZuVW9YDmbhzhDvvfdJMbZPCQBMkT4RjCYXon3
         uM8+R3CGO4K7oLF64Pvv94ORZz/39ifJBrLgBTZJglVsM1Zf4mCQ05GLi9xVfJezuOS/
         QjAgSdjzQZVW4rgBpuu84mgbWvJtPan3WZWMc76xfwpPRmsUhMijQQx8kvkd5+Uwmc0W
         bLCqHhvNQWGgY0fJiAVWSX3JLe4Tb+RC7TAr7ieww6PMXDKAKcrv37dwiKWeeWyU6QzP
         BAmPf4cbxAAeFWABcjnULmdZPH5NNNRq5A896LSnmI+IrUipNqi/NmtYdo1IxrEkZcvw
         Xlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721725921; x=1722330721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5NOfvVrRF8+r3VwS12jIQzSFt0uID0WbrULFoZ3kO4=;
        b=bb2EPN8GaB+0cVLlqQFtRIL8X0WxTtejclwH6Z4z0kKzVZl0HM6OP+Djya4DXG5p0W
         ae/cF0QyYqrV62V79ynURNnbqMS7vV17E9CP/HzBuG28FLzsJaxsYZkxvT20wvsLHwvc
         RGY+WTtKefRqA+A4EFX7jZdzciSXvOS3FbCt/IW8E2NrElSo8LdZD8ud2fcfZhb9w8UH
         Adyixd6PtDaQOCotJh5eZOpx9WDagvJkuWLEc0rGtZFQrXjkHSUq0k220E029h0HiVGa
         dYr5LcNcOJk91K80vwJxuh/B9V/RQdmzqhIm7Z7aVLD7WhDoepAqiyZd2a/ARMFQGuAA
         jnBg==
X-Forwarded-Encrypted: i=1; AJvYcCVyBYIvmp8TELm0O2NFPoR5ixGsw3q6pz0+BjKhVxi04viMVELO7/eqiwXnD3Mg4kB1Vsx7OpS3jAZHyCawrqNbhK7FxuCeqH9A4fLPLZzSloeA4FpQVrgu0fqM/Jm5aLpskztMPQKAo2E/8w==
X-Gm-Message-State: AOJu0YyL3wqaGK8kcCoIcRUY3c+0ntqyG64mOEdjbIWjR422SmyiJ4HI
	luv2jx/WTJKUr/ZJb3EC+naGfQkD4ddimM2RxoXzdZR8Q+HYrBVf0Qedn6MFVrw=
X-Google-Smtp-Source: AGHT+IGX7jwTy6jLfVTgsIlcWEhHo8AMmr6En4ffuDNe4Z/ziszz16/nLMs4jAancbzv6jNIbGOpHg==
X-Received: by 2002:a05:6a00:1741:b0:70d:22b5:5420 with SMTP id d2e1a72fcca58-70d22b5598amr8849924b3a.15.1721725920936;
        Tue, 23 Jul 2024 02:12:00 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2fbebcc1sm2369119b3a.23.2024.07.23.02.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 02:12:00 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	n.schier@avm.de,
	ojeda@kernel.org,
	djwong@kernel.org,
	kvalo@kernel.org,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] scripts: add macro_checker script to check unused parameters in macros
Date: Tue, 23 Jul 2024 05:11:54 -0400
Message-Id: <20240723091154.52458-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Recently, I saw a patch[1] on the ext4 mailing list regarding
the correction of a macro definition error. Jan mentioned
that "The bug in the macro is a really nasty trap...".
Because existing compilers are unable to detect
unused parameters in macro definitions. This inspired me
to write a script to check for unused parameters in
macro definitions and to run it.

Surprisingly, the script uncovered numerous issues across
various subsystems, including filesystems, drivers, and sound etc.

Some of these issues involved parameters that were accepted
but never used, for example:
	#define	XFS_DAENTER_DBS(mp,w)	\
	(XFS_DA_NODE_MAXDEPTH + (((w) == XFS_DATA_FORK) ? 2 : 0))
where mp was unused.

While others are actual bugs.
For example:
	#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(x) \
		(ab->hw_params.regs->hal_seq_wcss_umac_ce0_src_reg)
	#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(x) \
		(ab->hw_params.regs->hal_seq_wcss_umac_ce0_dst_reg)
	#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(x) \
		(ab->hw_params.regs->hal_seq_wcss_umac_ce1_src_reg)
	#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(x) \
		(ab->hw_params.regs->hal_seq_wcss_umac_ce1_dst_reg)
where x was entirely unused, and instead, a local variable ab was used.

I have submitted patches[2-5] to fix some of these issues,
but due to the large number, many still remain unaddressed.
I believe that the kernel and matainers would benefit from
this script to check for unused parameters in macro definitions.

It should be noted that it may cause some false positives
in conditional compilation scenarios, such as
	#ifdef DEBUG
	static int debug(arg) {};
	#else
	#define debug(arg)
	#endif
So the caller needs to manually verify whether it is a true
issue. But this should be fine, because Maintainers should only
need to review their own subsystems, which typically results
in only a few reports.

[1]: https://patchwork.ozlabs.org/project/linux-ext4/patch/1717652596-58760-1-git-send-email-carrionbent@linux.alibaba.com/
[2]: https://lore.kernel.org/linux-xfs/20240721112701.212342-1-sunjunchao2870@gmail.com/
[3]: https://lore.kernel.org/linux-bcachefs/20240721123943.246705-1-sunjunchao2870@gmail.com/
[4]: https://sourceforge.net/p/linux-f2fs/mailman/message/58797811/
[5]: https://sourceforge.net/p/linux-f2fs/mailman/message/58797812/

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 scripts/macro_checker.py | 101 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100755 scripts/macro_checker.py

diff --git a/scripts/macro_checker.py b/scripts/macro_checker.py
new file mode 100755
index 000000000000..cd10c9c10d31
--- /dev/null
+++ b/scripts/macro_checker.py
@@ -0,0 +1,101 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+# Author: Julian Sun <sunjunchao2870@gmail.com>
+
+""" Find macro definitions with unused parameters. """
+
+import argparse
+import os
+import re
+
+macro_pattern = r"#define\s+(\w+)\(([^)]*)\)"
+# below two vars were used to reduce false positives
+do_while0_pattern = r"\s*do\s*\{\s*\}\s*while\s*\(\s*0\s*\)"
+correct_macros = []
+
+def check_macro(macro_line, report):
+    match = re.match(macro_pattern, macro_line)
+    if match:
+        macro_def = re.sub(macro_pattern, '', macro_line)
+        identifier = match.group(1)
+        content = match.group(2)
+        arguments = [item.strip() for item in content.split(',') if item.strip()]
+
+        if (re.match(do_while0_pattern, macro_def)):
+            return
+
+        for arg in arguments:
+            # used to reduce false positives
+            if "..." in arg:
+                continue
+            if not arg in macro_def and report == False:
+                return
+            if not arg in macro_def and identifier not in correct_macros:
+                print(f"Argument {arg} is not used in function-line macro {identifier}")
+                return
+
+        correct_macros.append(identifier)
+
+
+# remove comment and whitespace
+def macro_strip(macro):
+    comment_pattern1 = r"\/\/*"
+    comment_pattern2 = r"\/\**\*\/"
+
+    macro = macro.strip()
+    macro = re.sub(comment_pattern1, '', macro)
+    macro = re.sub(comment_pattern2, '', macro)
+
+    return macro
+
+def file_check_macro(file_path, report):
+    # only check .c and .h file
+    if not file_path.endswith(".c") and not file_path.endswith(".h"):
+        return
+
+    with open(file_path, "r") as f:
+        while True:
+            line = f.readline()
+            if not line:
+                return
+
+            macro = re.match(macro_pattern, line)
+            if macro:
+                macro = macro_strip(macro.string)
+                while macro[-1] == '\\':
+                    macro = macro[0:-1]
+                    macro = macro.strip()
+                    macro += f.readline()
+                    macro = macro_strip(macro)
+                check_macro(macro, report)
+
+def get_correct_macros(path):
+    file_check_macro(path, False)
+
+def dir_check_macro(dir_path):
+
+    for dentry in os.listdir(dir_path):
+        path = os.path.join(dir_path, dentry)
+        if os.path.isdir(path):
+            dir_check_macro(path)
+        elif os.path.isfile(path):
+            get_correct_macros(path)
+            file_check_macro(path, True)
+
+
+def main():
+    parser = argparse.ArgumentParser()
+
+    parser.add_argument("path", type=str, help="The file or dir path that needs check")
+    args = parser.parse_args()
+
+    if os.path.isfile(args.path):
+        get_correct_macros(args.path)
+        file_check_macro(args.path, True)
+    elif os.path.isdir(args.path):
+        dir_check_macro(args.path)
+    else:
+        print(f"{args.path} doesn't exit or is neither a file nor a dir")
+
+if __name__ == "__main__":
+    main()
\ No newline at end of file
-- 
2.39.2


