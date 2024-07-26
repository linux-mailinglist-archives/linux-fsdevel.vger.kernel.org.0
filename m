Return-Path: <linux-fsdevel+bounces-24287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92CF93CCE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 05:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A402428256A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 03:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFF822F1E;
	Fri, 26 Jul 2024 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmL25kBq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA8D22611;
	Fri, 26 Jul 2024 03:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721963598; cv=none; b=YisuC+FJbZ404gTI/QasQR/4ahz9PMUNx1PyKiLdhvd6+69wlXhxGcx2mGiEkrCyjvMxcy1AX7OAwSUYUt2iN46hNF3o3DlxVNSnw1LCNb9d+k3Vyucz+tVIdVa3qngbE13h7pdxR9n1ARTVZjqjUbwrTEqdXZMoLLZ36AKWDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721963598; c=relaxed/simple;
	bh=Ay8xxu+taRpgSAApBS8YRZsW8nYWYCytrPALo5KpbuY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ahg+Tk0O5hejaWWHPW0siQ02pM3tHDQVRQy5r7jhf7+j+/fg7Hakb5iDzNPxHEr5kFGv8cWeGBSAXf9uDGYwgWwUWu0C+kz3bYZkv2cvEuv7EirBN+XB7m9XyL/p5vtY2xl1ay2E7O2mwsVVVfJCsBeXtGQzdYSRj51+s/CbYe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmL25kBq; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-260f863108fso426671fac.1;
        Thu, 25 Jul 2024 20:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721963596; x=1722568396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ci2Gck85EvPCemYSkdaGllILSEgdeKb2oHQPF4Q/Le8=;
        b=SmL25kBqx5KJvjikWHaPsnyNNSpD0//6g6BqwuYNmy8YficGP5Qd22BGWwEpuMwdjF
         jx/cBzo9lMm6mJgXtKxAsGOybcRxRZFPtPu8eLrne44OkVJzALn+4JIKeXlN3CNAbVP2
         VZwm2/TVLhPtnB8qV+6kjhWNlE9FoOE+QtqbAzL5eD0osfjJ6aO7702M9QqejDFlp1BV
         mDlhykuvMl6He/MertmCwX06Nkwyk1jI9x5JvuR+9we3o3LKMK/wXrhCk4hXU8gKN1Zb
         Sv/j7NoNn92DKPzF0h+8V+5+JUN0JezGyfN31B+fvIUOdo9wtU46BZZaVpv95RaZJq3I
         ARQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721963596; x=1722568396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci2Gck85EvPCemYSkdaGllILSEgdeKb2oHQPF4Q/Le8=;
        b=J5vRK1c1NQw1SGpQreLmYWOEu35nnVScf2wSoC3dkaI4p43VE0G6j00JVQcifLFtmF
         /hnG5H77Izll2k9XGXONq2TBGwzAhvwqFFsc7ksisjUrsHGFWUVGxIt/XFCoaOHO9Fq4
         DBu63KXkjRFekPJaRmXFEVqCwKCPgfb877MX/XyupYA2lXNUqFuhc8mbIozUzQvQLVHT
         S19kcxmxJQr0eERxowV6+P9aQxAkQZZUu9BsfYQHIILhxmFhdrlS55/gUUjj9zE41nG1
         ruCk0svVKtnd9siY/gmjuAM5ztbQ3xslv/b6uBacZztTSjV5hN8PRMRLjh6ovGLpGyBv
         7kPA==
X-Forwarded-Encrypted: i=1; AJvYcCW9MfyyhSG9g5oH/8aheKI5+6N+bNg8Zqqd+Kqr0HyXPrIrKT+RfN0/iMMmVUbHstBnjuJyVT1KJZ4jRIDgITaeR/mh9B2nYMQPwjJnwNNPtd1ZxMFx3ejvF6zsjSIkD1iaHg/phHRKMHMbtGE9vd0jYIr+FLpM7HuBGQCqxKwmvSaJ3JbDHKKz0w==
X-Gm-Message-State: AOJu0YxlS/d9c1tOgjLAeY+fanqKvU8hS5oF+ucpelkZpCof0ZfJCKXi
	ibSbgBDciTjfagR8jjVMxZ3d0VdwBYfAOCfg+RAnkzWWzU9el5EtGarE6oOH
X-Google-Smtp-Source: AGHT+IHs0+z0rH8aFg/4yNzNXT6MvnCERGSAbtn6QHnH/2s3SBFq8Gi/yzYBmc0Sm4hD35LUr+J1tQ==
X-Received: by 2002:a05:6870:828e:b0:254:a09c:6ddf with SMTP id 586e51a60fabf-264a0d34e62mr4816325fac.24.1721963595908;
        Thu, 25 Jul 2024 20:13:15 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e18dfsm1852757b3a.11.2024.07.25.20.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 20:13:15 -0700 (PDT)
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
Subject: [PATCH v2] scripts: reduce false positives in the macro_checker script.
Date: Thu, 25 Jul 2024 23:13:10 -0400
Message-Id: <20240726031310.254742-1-sunjunchao2870@gmail.com>
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
  1. Macro definitions with only a single character
  2. Macro definitions as (0) and (1)
  3. Macro definitions as empty

Also provide an option (-v) that alow users to control
whether or not to check conditional macros. When -v is
specified, conditional macros are checked; otherwise,
thet are not.

Before this patch:
	sjc@sjc:linux$ ./scripts/macro_checker.py  fs | wc -l
	99

After this patch:
	sjc@sjc:linux$ ./scripts/macro_checker.py  fs | wc -l
	11
	sjc@sjc:linux$ ./scripts/macro_checker.py  -v fs | wc -l
	31

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 scripts/macro_checker.py | 50 ++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/scripts/macro_checker.py b/scripts/macro_checker.py
index cd10c9c10d31..ba550982e98f 100755
--- a/scripts/macro_checker.py
+++ b/scripts/macro_checker.py
@@ -8,10 +8,20 @@ import argparse
 import os
 import re
 
+parser = argparse.ArgumentParser()
+
+parser.add_argument("path", type=str, help="The file or dir path that needs check")
+parser.add_argument("-v", "--verbose", action="store_true",
+                    help="Check conditional macros, but may lead to more false positives")
+args = parser.parse_args()
+
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
@@ -21,15 +31,25 @@ def check_macro(macro_line, report):
         content = match.group(2)
         arguments = [item.strip() for item in content.split(',') if item.strip()]
 
-        if (re.match(do_while0_pattern, macro_def)):
+        macro_def = macro_def.strip()
+        if not macro_def:
+            return
+        # used to reduce false positives, like #define endfor_nexthops(rt) }
+        if len(macro_def) == 1:
             return
 
+        for fp_pattern in fp_patterns:
+            if (re.match(fp_pattern, macro_def)):
+                return
+
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
@@ -49,6 +69,8 @@ def macro_strip(macro):
     return macro
 
 def file_check_macro(file_path, report):
+    # number of conditional compiling
+    cond_compile = 0
     # only check .c and .h file
     if not file_path.endswith(".c") and not file_path.endswith(".h"):
         return
@@ -57,7 +79,14 @@ def file_check_macro(file_path, report):
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
@@ -67,6 +96,12 @@ def file_check_macro(file_path, report):
                     macro = macro.strip()
                     macro += f.readline()
                     macro = macro_strip(macro)
+                if not args.verbose:
+                    if file_path.endswith(".c")  and cond_compile != 0:
+                        continue
+                    # 1 is for #ifdef xxx at the beginning of the header file
+                    if file_path.endswith(".h") and cond_compile != 1:
+                        continue
                 check_macro(macro, report)
 
 def get_correct_macros(path):
@@ -84,11 +119,6 @@ def dir_check_macro(dir_path):
 
 
 def main():
-    parser = argparse.ArgumentParser()
-
-    parser.add_argument("path", type=str, help="The file or dir path that needs check")
-    args = parser.parse_args()
-
     if os.path.isfile(args.path):
         get_correct_macros(args.path)
         file_check_macro(args.path, True)
-- 
2.39.2


