Return-Path: <linux-fsdevel+bounces-24227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D7493BD83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 09:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B003D1F21474
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 07:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C288172BB2;
	Thu, 25 Jul 2024 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvFm88Fh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179E7172796;
	Thu, 25 Jul 2024 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894319; cv=none; b=LW1LjBY2vh+Uo/oiz1cCAYvadIVXszCWs8VhdC/Ad/CR9Wo7F3dZ9U+btqPRDv7kGKdOdDe/ZCKqZZ31WryU1mjyQhsnwQla+s06V20fcers9uxYTVMg7h607HnBxS9Ipl/cjsC5l9b1dZee4h4C2Ypay4mNSEMfMDWODVaG1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894319; c=relaxed/simple;
	bh=Q8zxkt2xK/cM957zT5MhFTAW4qRe/Wss5isDY7EWDhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ghwK9Pqszq2W/qO8pFxA8qtoj+RN3UlEPo1eHbBkbSn7xG4BuJ96Mrm477TSUduDrmKTL0PHzanCLV4G2Blw7QwZ/3LNsYgnNkNrSg6rrcFflQza2tnTghIfy/Bil5n6uu+ueVM6DQ000lkE50nk4Sy6ho2XHoum6lHR+0a40AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvFm88Fh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d2ae44790so484957b3a.2;
        Thu, 25 Jul 2024 00:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721894316; x=1722499116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTwMxNHq1BLBlwRxe0MIFu6JMR5H/T1gtINZWNBZrbI=;
        b=AvFm88Fhb0QddwCxcxMxjIdTIQQhjT2Ul762r0VcolVqYoQ/HATlF2+MAqxbr9Vo5G
         RDXVjmZ3A7ak3QGN8magF//spRfDN9wdNaX1gVoirjlzgZ/G8Xg545BO8UTcdWseCJ0W
         CDo952p6nTrO7mdFW0JmdhHO6MO/R06mAn3KYGZdeEc8QGSwPNNGMGYU2v19uNpc1ru2
         E1iTG3nzJEUGKzqcHL/xpp1Wm1Clq1BFo3WL3fNhQRlL56gBT0vKunsQL/avTt5yfK4h
         WrcoezqTIN/zLlgOio3Rn3uG/AeECPitM5a1/3ZZeDXISVvX0kuBXKvxoFfxVYmoKhfk
         5jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721894316; x=1722499116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTwMxNHq1BLBlwRxe0MIFu6JMR5H/T1gtINZWNBZrbI=;
        b=HIJf/boGiR7HheLiJWa9aN89DwO5TjaBW3myMeK7RytOc/LnDuZP5MAMZGyWF4dCPs
         Vl7FDacdw1oHHCb1JoD2CZWyV2sH8UGbnwAIbamBdZ/fgI2n2g/VkH/uyDlxOivNbzlj
         jbmqLNE9FTs9m+hl9WYgsQTK1sdyiyXzAh1AE/tPT4rxYk1S8heCcinH2D7Ky8oDLxOD
         E6AQws3bhM3ZHltAS7TxHlDKEB4E8Xs260ufrfh7SmJ9YtrDoK24BZmA5DHhTrpcwhmd
         +BT5aMKO14HawFnCExDJOjI5lMiezl9EGb039XIJYKCdxFo46pYBg0hH8pNlz27cI8R8
         Ikiw==
X-Forwarded-Encrypted: i=1; AJvYcCU4Re0pmsIKcUP+iBNc+Lc1Ti7PssBdzMtPe7yyx1JNFlpblGHO5869kgk7nXxS1vIwRqxlAIYOdqZl1qikULMMRxVLorYMJUP+l/P2JPUa/8nFAVNprQA+ZSNBcgYU14VCuz4GRNBpR+TFMiHiglVOd5qzXY/SkkCB4l43PBoNxBumvNsgSjyetA==
X-Gm-Message-State: AOJu0YzVfi8pQq/5MVeYfngXcZKi2d2lJ+KX6f6xghUUYmfx66oxLvUb
	/Qt7/bNa8AWGszWFzM2PnO6tnOPlJMA8ut11DXKdXg5oy/FEE1xqy7oMeKjK
X-Google-Smtp-Source: AGHT+IG7NmN/XF+oH/8aI+ShSVuP5dqS6kIopTBQolUMjWB0IhVK3t6jYIF8rUrw98Mr8WCViL6m6g==
X-Received: by 2002:a05:6a00:94a3:b0:70d:3354:a190 with SMTP id d2e1a72fcca58-70eae9a10fcmr1141182b3a.27.1721894316171;
        Thu, 25 Jul 2024 00:58:36 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a2bf6sm640710b3a.197.2024.07.25.00.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:58:35 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
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
Subject: [PATCH] scripts: reduce false positives in the macro_checker script.
Date: Thu, 25 Jul 2024 03:58:30 -0400
Message-Id: <20240725075830.63585-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce false positives in the macro_checker
in the following scenarios:
  1. Conditional compilation
  2. Macro definitions with only a single character
  3. Macro definitions as (0) and (1)

Before this patch:
	sjc@sjc:linux$ ./scripts/macro_checker.py  fs | wc -l
	99

After this patch:
	sjc@sjc:linux$ ./scripts/macro_checker.py  fs | wc -l
	11

Most of the current warnings are valid now.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 scripts/macro_checker.py | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/scripts/macro_checker.py b/scripts/macro_checker.py
index cd10c9c10d31..8195339ea5b5 100755
--- a/scripts/macro_checker.py
+++ b/scripts/macro_checker.py
@@ -9,9 +9,12 @@ import os
 import re
 
 macro_pattern = r"#define\s+(\w+)\(([^)]*)\)"
-# below two vars were used to reduce false positives
-do_while0_pattern = r"\s*do\s*\{\s*\}\s*while\s*\(\s*0\s*\)"
+# below vars were used to reduce false positives
+fp_patterns = [r"\s*do\s*\{\s*\}\s*while\s*\(\s*0\s*\)",
+               r"\(?0\)?", r"\(?1\)?"]
 correct_macros = []
+cond_compile_mark = "#if"
+cond_compile_end = "#endif"
 
 def check_macro(macro_line, report):
     match = re.match(macro_pattern, macro_line)
@@ -21,15 +24,25 @@ def check_macro(macro_line, report):
         content = match.group(2)
         arguments = [item.strip() for item in content.split(',') if item.strip()]
 
-        if (re.match(do_while0_pattern, macro_def)):
+        macro_def = macro_def.strip()
+        if not macro_def:
             return
+        # used to reduce false positives, like #define endfor_nexthops(rt) }
+        if len(macro_def) == 1:
+            return
+
+        for fp_pattern in fp_patterns:
+            if (re.match(fp_pattern, macro_def)):
+                return
 
         for arg in arguments:
             # used to reduce false positives
             if "..." in arg:
-                continue
+                return
+        for arg in arguments:
             if not arg in macro_def and report == False:
                 return
+            # if there is a correct macro with the same name, do not report it.
             if not arg in macro_def and identifier not in correct_macros:
                 print(f"Argument {arg} is not used in function-line macro {identifier}")
                 return
@@ -49,6 +62,8 @@ def macro_strip(macro):
     return macro
 
 def file_check_macro(file_path, report):
+    # number of conditional compiling
+    cond_compile = 0
     # only check .c and .h file
     if not file_path.endswith(".c") and not file_path.endswith(".h"):
         return
@@ -57,7 +72,14 @@ def file_check_macro(file_path, report):
         while True:
             line = f.readline()
             if not line:
-                return
+                break
+            line = line.strip()
+            if line.startswith(cond_compile_mark):
+                cond_compile += 1
+                continue
+            if line.startswith(cond_compile_end):
+                cond_compile -= 1
+                continue
 
             macro = re.match(macro_pattern, line)
             if macro:
@@ -67,6 +89,11 @@ def file_check_macro(file_path, report):
                     macro = macro.strip()
                     macro += f.readline()
                     macro = macro_strip(macro)
+                if file_path.endswith(".c")  and cond_compile != 0:
+                    continue
+                # 1 is for #ifdef xxx at the beginning of the header file
+                if file_path.endswith(".h") and cond_compile != 1:
+                    continue
                 check_macro(macro, report)
 
 def get_correct_macros(path):
-- 
2.39.2


