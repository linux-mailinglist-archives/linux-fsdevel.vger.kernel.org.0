Return-Path: <linux-fsdevel+bounces-40868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E38CA280B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 02:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0048E3A3ED7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D6228C92;
	Wed,  5 Feb 2025 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2SuG2IHV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982C228381
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718521; cv=none; b=sa8ToSSp6qxExLycgGbC1XXVRgFN6gOMpuB8xEMmt+gWvQ6Pu2QhqWsU3QJKTXhrrjwj6H6vWFyWbF1v1q6DSsNam5ViEmDiW7j6Ggkzqx027WwdeX/EFwI8lAkO3Ehffg1+JhxSZxfulmcaGeOvtHhRwpSn23CdJ5H0k5q0M78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718521; c=relaxed/simple;
	bh=DjlSjyKZg5L1RJtFrw9Awsbe+InTSaQHdJt80sHp1pA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J93tRtPgBptZ388Rw2m6Q4VDIdwky6LE7/vmBssC5EzEBbWBQx1hcZZ/dVlAoNs8cTesl8DcKsONDSX2n5u0d8NWQBMDN4YVrWZfyklD5wwb/n0fPSZxXaEmz3vUi2Kv8mThnkdBF7T6aTUpcaPo6Wz2hCVcudnNzLVOEcHx+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2SuG2IHV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2162c0f6a39so6257895ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 17:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718518; x=1739323318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHEXIimjUTXAyC0fOzh8XAkym19Q72QcmDI6hc+cq4k=;
        b=2SuG2IHVeSCEy6VslnXTwB1Zyu/SHh9Xyt5jI/6LbsU5hfYh219JX9L4ybPfJlIiRe
         BbbhC6+r5Ctti+6beAwhJJjoeR63cAK6cm+dhfolEguRVT2ghxGxHuovStB6+pLoIXl3
         NmE3JpCLdmV4UaKXd7hSNcG1pN//dL98bPc+ujkyp7Xj4jfKT22LlerO54Qf5iy1rf9o
         RUYoP+V90ugw0o54SFc1as1qQ1s4BZjgsmVusccJO/IOVThSE8ZGoCa0q6Z07R9DfmN4
         0CF9EcPLqY9H43h+FqUpHI/ymJiU9hEQckyhv9e6S18718YY+awAugVgIvqJa5XVHwpZ
         dH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718518; x=1739323318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHEXIimjUTXAyC0fOzh8XAkym19Q72QcmDI6hc+cq4k=;
        b=tPCwnpcqN5lZmF0YeajEM0ebYb8zXOlGmIqhvqNSvyp62biqOo4tGh5umASklq3s5P
         RURvjli20x3LrRmdP26D7rlUxHv22D9q0zRvQN7fGz0jOoAYvyydGeGlPOLNqKQNTuZg
         LcsVkKIU6UkK0q8JJoT8uZ5AQvrcQduPzC73KGdIRzQvSa5adkJ9GOn2iOdnuX/e6K1r
         mK1XbwcxYy5RejhJaGOJSVWC1QIS5SW1RuzJsA5F6PdJMMKXBUqlzeCY8QiM7Amn6CKN
         /02zwCcG0LC0mYIcHvGEU0q4tD3t2avRqCwJhlZGEQtH6Z9SSIqdGu5Zllyxo2yAEU5s
         ccfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSSEEDWROaDFQgfh0r80oJFDw3y+eIJXWHRrbaNd8Uyao1Hi8RVpsz3PoqBoRYO+ITsCcpS5CHzDynGecV@vger.kernel.org
X-Gm-Message-State: AOJu0YxPudnRJ/wUbaDn4fvK4js2tEZ6Is3Y9LTrk+QV+RqBx/1ncgeD
	iWF/ml08aES+G23CG6sah9SpXq2LrswW1wqUAvjuZAivOC+oM78JTgq7slF5yg0=
X-Gm-Gg: ASbGnct31n1sRrCHQU0nB6O3L1QdJNWWfsN1G0QMGhGhS7kpij45tn8a7WHIfg+DrFa
	Ud2zgbSOBIALuvsP6rQ+br3nTa5fRoTBCXFlynij+gmUUTkPjv7k4ZkKWqn2yESMj4nhUIQzKdD
	O2Veh7LDbORxSCxjSMmcH1DqDRJfaOnfXGLDA9qzReZSkZ0xWgVVKFH9cQYpZLQOvEWXae6o/NA
	r878uuqVa8EA3x6BEHBipduC4LPLGFGF8RVmmff4htNpyu55YXVueKvQofR4kLmymvwdTTImIhn
	BBO3MWXFIE2zWFqFLQOr5HVM1A==
X-Google-Smtp-Source: AGHT+IHzHonQ1oXGudf3ZfMVrMZV3mKwGoRuXs9FutPohSBaJGIm20BPBEq9+EHRoF58EkXIbMe1gA==
X-Received: by 2002:aa7:888c:0:b0:726:a820:921d with SMTP id d2e1a72fcca58-7303523eaaamr1533935b3a.10.1738718517175;
        Tue, 04 Feb 2025 17:21:57 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:21:56 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:21:49 -0800
Subject: [PATCH v9 02/26] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-2-b37a49c5205c@rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

Make an entry for cfi extensions in extensions.yaml.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a63b994e0763..9b9024dbc8d2 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -426,6 +426,20 @@ properties:
             The standard Zicboz extension for cache-block zeroing as ratified
             in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+        - const: zicfilp
+          description: |
+            The standard Zicfilp extension for enforcing forward edge
+            control-flow integrity as ratified in commit 3f8e450 ("merge
+            pull request #227 from ved-rivos/0709") of riscv-cfi
+            github repo.
+
+        - const: zicfiss
+          description: |
+            The standard Zicfiss extension for enforcing backward edge
+            control-flow integrity as ratified in commit 3f8e450 ("merge
+            pull request #227 from ved-rivos/0709") of riscv-cfi
+            github repo.
+
         - const: zicntr
           description:
             The standard Zicntr extension for base counters and timers, as

-- 
2.34.1


