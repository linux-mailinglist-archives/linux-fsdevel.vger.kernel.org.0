Return-Path: <linux-fsdevel+bounces-47192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28301A9A3AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA713B4FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 07:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41000221FC8;
	Thu, 24 Apr 2025 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ubg6cZpa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D877221F2D
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479284; cv=none; b=XCn3YXLSByqOy2xErDqC65tAvxhQGSCjF56b9tVxzY+quODony2lcNboqy66/ihWUGhFFCccivunvIrBtF4mPEnWMAmGqvzveXPZdTnA3GJGd5q7BuU5fND8j9hr3pjDAo7YQsqySb4CexjPixhY80em0ObxEaXVcFzXGfWvNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479284; c=relaxed/simple;
	bh=HSj61/DKHbscjrSxiKNrJbrvkTbOzS+iDBZfj2iqRRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbLWdH4rgaMHiqC57Uk+9JY4d8yfebMUtMQ6yX+ai9Krfz6oa8JEI4YBV4jOevMYjw2ZSL6Okxi+Co2Oi6Af2ZJBKIbcaKL9GDttMGBfT5BQ8Gx+PTxRePceH3ARMzU1RpKBMjXZnHctu97TsjopXpu5RK3nxdtntqfuzDyZnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ubg6cZpa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227cf12df27so6535715ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 00:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479281; x=1746084081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puoahas2OCQQdRJkSX5kN4b6Bd2MCUgo7wt+1uTIqSI=;
        b=ubg6cZpa5Vo6Fxp4Uf4waBarfwLeXRuCfcO/4vqI+fldUtLeg3Xx22zxIpeTEkrUay
         HsuBdUC+tJ+I1kp5tR6Q0ZqsH/bfmJC3GzVbx4DHQLeyTqNYCSeaQWO8RoS7tNWAarVj
         cflSY0Nge5CjCiFk3STI8oQKDo/gdP18lAXiMQtn9HFxM1l5a61OFBuA940E6+cI3nuk
         YJ2AWET8CwN+QBYeHaHRu2AklzMluGu+JAmgYD8Z5PKT/DBxzcObMjvY7fKUdaCrqrmJ
         oSulIA8fMwbtSGXjDZ7bW/WAuTovz/takJJtL4SX5Ea/ERtDKG0IH5+tUqoFuA3AnCkW
         DdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479281; x=1746084081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puoahas2OCQQdRJkSX5kN4b6Bd2MCUgo7wt+1uTIqSI=;
        b=bCSi5ff3YlTvEDepheeKLhAD2VRTxTbTPsT6vSynGacs/P8qR04Wfu58VpklxOyJCF
         jnO9guFZ4ErT2jeZ50s42cZ77RORd5gt7g529j+SgZA/oVyZSxb7r0Fh9U1Eov48PZ2V
         q/KXlMnZWkMymywGOEm7kecC/ozOceE4DxQh5J1HFtXULd/zDPYxNO323WeNiEJ8uIYt
         Ycx1mIXETGvqIyg8GOPUnQBOj2bD+/kPgBZrfKe4n+ZIH5fJrkqMHgvMAh6pNrbm0ugj
         1LXYWnfeQS/WliDQvEPjSX7GKjOoBl3+HE0idaWt5ngMz8czA+rsUXVbkS4wgUw4oR9Z
         8kow==
X-Forwarded-Encrypted: i=1; AJvYcCWFyn3FDNrn9gVy6AAlA4aouhFJDTCNBFM8zbgSudE3+iHto6awozRc6ll4PHJ4VpKvxjOkFN6DNXORo0Sr@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrwz/CC/UUV3nOnbHfnY0QiUZLxw1HPNIhzuUoaW0t1mmOa7c
	8jsizjRC7AnzTq4ScWDX3RkKw0u0baUSu0OXEskRiqFR/SiQK/Zrvr+Oxwbkl9o=
X-Gm-Gg: ASbGncvtCuuOTowoTFFfWpVQH45rB/ooNLyJGolLlGE3T7eLKZ1ALvAqd6GEezjdbWs
	7zWzpNw2/eEpCt8z/DT45AylxEFC1rq28FC1SElYG/IL07QvUhu945u6BEVZsglOTw/vsogH5KL
	iaW2GjfV/Od3AHjkObjWtSAireUzANNZEKAkHOPKUGGtU2Msne3VySoYpahkRUdLlDZAJQP6E4N
	egbRCgIJdbSHzTKPmmGAaGVxsoKm1D6Wc04PoVbYz7qhVXjVD7P8jzMw31+fVs1Fk3Mhnhy3oyx
	nFIDGqLq1HhbrPF17+zCjeuLmXiYNPDFyEb14hU4GbHwvwLiC7I=
X-Google-Smtp-Source: AGHT+IGB31thuufoxJYlKx2OJ9+59LtpnF6oD6iN+AzfxNeqUgzSARE3kzGHVOeHGGHAiVK6EGT83Q==
X-Received: by 2002:a17:902:c94c:b0:215:a56f:1e50 with SMTP id d9443c01a7336-22db47e5457mr21504655ad.8.1745479281373;
        Thu, 24 Apr 2025 00:21:21 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:21:20 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:33 -0700
Subject: [PATCH v13 18/28] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-18-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 4587201dd81d..6bb53ce72ed5 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -90,8 +90,8 @@ void __show_regs(struct pt_regs *regs)
 		regs->s8, regs->s9, regs->s10);
 	pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
 		regs->s11, regs->t3, regs->t4);
-	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
-		regs->t5, regs->t6);
+	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT " ssp : " REG_FMT "\n",
+		regs->t5, regs->t6, get_active_shstk(current));
 
 	pr_cont("status: " REG_FMT " badaddr: " REG_FMT " cause: " REG_FMT "\n",
 		regs->status, regs->badaddr, regs->cause);

-- 
2.43.0


