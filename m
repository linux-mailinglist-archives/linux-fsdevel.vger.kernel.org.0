Return-Path: <linux-fsdevel+bounces-73870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39385D22418
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 04:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94A253022A87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 03:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559328FFF6;
	Thu, 15 Jan 2026 03:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMpEibgL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07E27FD43;
	Thu, 15 Jan 2026 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768446721; cv=none; b=ksOL9mXpOxBtgqLAHg9WpmjgIV5rNQXOPWpi6JEAkjsPX42Rw+tm7kloe9oodNpdbwqwgCk7oVST0hrpq+MQqcIuGRveZpY8rXJBNLv/tf10jU8qWCdPDachADLhqmbo7YUbqbqcTgPMmf+S677LssfzwRm+6NT94bY6Qx53zq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768446721; c=relaxed/simple;
	bh=Gk/osH7DfvUyCVOdPI7ZwI4Yhgby74VLmpmAMH87lg4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c3fXmuQTWJyBFtYaj1PKx67W2Q3A0rFFLRkky7pbND9fbKo9cI+ySx2iM0Pt6GkM+pJ07MCb+W3iVgRPF+h5WQiz3L+tQKn+JHWa6Vp7YXJDOq4oUE69ybSwCrKSw3gAgIyHDMAQ9pQnWnzuaZfcYQWi+cb8Pm0CU/H7ACJTOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMpEibgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C37C4CEF7;
	Thu, 15 Jan 2026 03:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768446720;
	bh=Gk/osH7DfvUyCVOdPI7ZwI4Yhgby74VLmpmAMH87lg4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=eMpEibgLnCCoCpngPx1LjqAwoqkiMOK1O4Pv6xFoiICf5Rumtl6OjcBtchzbPzV4f
	 fOrU3PDXtnHoFLULkmJ/EZqFFePw0CC8HldneMcrfYufeIQNp0HY07Vp5aHrp9IHkd
	 nq3R60jTiiN+shKdZGDZMryPH7AwCtKRTq/4XKMRhdBkC2k5bVNToMndvjt7czfLar
	 x/fNxwwiNZk1fqNCF6QXd4rCKWEMN/I5M7C9Cj3EXWXZgtlkLHJyt49efPTSWgzc7A
	 eZ765DSqUt+KUoiHEilrTQ4oXDTqCKP0wfcjXMwg2eLnQOGC//VRCZKowDLG0/42aI
	 VeqGUU4KYI+uA==
Date: Wed, 14 Jan 2026 20:11:56 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
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
    Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
    devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
    andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
    atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
    alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
    rick.p.edgecombe@intel.com
Subject: Re: [PATCH v9 02/26] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
In-Reply-To: <20250204-v5_user_cfi_series-v9-2-b37a49c5205c@rivosinc.com>
Message-ID: <9b663e94-696c-4678-829a-6471e7022895@kernel.org>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com> <20250204-v5_user_cfi_series-v9-2-b37a49c5205c@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Feb 2025, Deepak Gupta wrote:

> Make an entry for cfi extensions in extensions.yaml.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Here's what I'm planning to queue; please let me know if you want to 
change anything.


- Paul


From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 19 Nov 2025 09:55:05 -0700

dt-bindings: riscv: document zicfilp and zicfiss in extensions.yaml

Make an entry for cfi extensions in extensions.yaml.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de> # QEMU, custom CVA6
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Link: https://patch.msgid.link/20251112-v5_user_cfi_series-v23-2-b55691eacf4f@rivosinc.com
[pjw@kernel.org: updated subject]
Signed-off-by: Paul Walmsley <pjw@kernel.org>
---
 .../devicetree/bindings/riscv/extensions.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 5bab356addc8..1aeff17c7f24 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -469,6 +469,20 @@ properties:
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
2.51.0


