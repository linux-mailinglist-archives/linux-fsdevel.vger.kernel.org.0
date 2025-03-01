Return-Path: <linux-fsdevel+bounces-42879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7810FA4AA56
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 11:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA5C1733CB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B221D8A0B;
	Sat,  1 Mar 2025 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWTRgNR0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A71ADC6C;
	Sat,  1 Mar 2025 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825869; cv=none; b=s43P1NweiXi4nw2PykqRQEpPejgrDRPFTwtY5G9LTTSROxlK/ZPswVZFeNNj0XEsvSR0DxjvzcwfmWhHvwwOJ1KuCyFCEgZf5QPL39cxN1oBaFaaye7sg5wyIufesqO5MlLonE7u66qwnlcKX+eEMGAccSXn7SABKtaCxA7sCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825869; c=relaxed/simple;
	bh=CvQ3k67w7tuULWkrhVMJXumCUTtaIWC6dm3j8RSHHXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vt96bKgSmun9Qu/uDbraTJCCdODUWHlEm6pMxY9DTnESgC0B6f1R8DOuzjaeZh9VU7G88GJOkIG5OwrXWtvrnbWgLm47hNoknOUNmVYgREk6kUIsQ4Qo8t0dUQTyPycG3BqjIF+yOa4S2UTo/3Gbnnvu8aSBjkeL5IpIs9Fn6as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWTRgNR0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so18834445e9.1;
        Sat, 01 Mar 2025 02:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740825866; x=1741430666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LY/g5u1A0VA3lw6pSEa2VfIXvvWB4lz7NHrbOXPgD9Y=;
        b=nWTRgNR0o+rd/c/9913KOHy0Ey9TOOyl+vX1LGf4kbaGQMkpAkEzClZ8ULu/IWaoyw
         mfJiVQqnSjFEQun/gsmLfaL+6HmJSC+ApBZXUb8eyDaGFfEYPYZgbq2KJ0ah6kFnHnET
         1sRcUegp7MylGtlgHTyzJP6eLdFvrZomxDweGbzT0Bzfq8YEv2FKWo9mU3KFGpT39+aN
         wh2BnauiJHLRJqWV4pspTBDTPNfLOzbcHuRvCiZpQPlYVGASuwqnklmiU1oBY6ATFyou
         WQ6XZZOa1i7oRDvPPqvjnWj7WO3rLo3HUg7TJuIoEBLCv2v7NOKoEomRMGrlMRSb5ZlX
         0Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740825866; x=1741430666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LY/g5u1A0VA3lw6pSEa2VfIXvvWB4lz7NHrbOXPgD9Y=;
        b=X7/kGNucBbuI577wVF0Ds/vrkU9mEarZOgr9BrlQByveV/vjAY/QPtNHxZd6t2B2I1
         zaiBbMCoP0LqcbNqQySfSaAmOUWsz+U/9CZ1OgBLMmZ82srm8ONsYuhRbXQXVZYzNUV8
         nkegH4nQArxX/B7nHKa0B9b++e9WvqmS8q9Q6sH/oA/KJxa9pWBf42P8ZdH0ozRgT//t
         qBpZzNUrtna1/IWS0EVutXMpq/uuRjFmv7UJ8QLiiyRqW6jRjQ9CXxdVLtE/9QOE7lv/
         JxQLwlhYVWfkEzxoGGfmMlY0Kq128YGKL4AsbA+85IYAmcffO+ChC8nRz/irCZS5NtmU
         a+qg==
X-Forwarded-Encrypted: i=1; AJvYcCXMCNJNiiOiRFgIVR/MMqFGmRYCer+HJ/1kKA6KhyovW/Nd1492J2syGsevuL8Bt/4SS3TiDl0A4ek9vm9L@vger.kernel.org, AJvYcCXw4Wbvowo5lsqfQZGIU3t77sBSgRaMH/IVQRnEi6jheOJ6Svd/8bC8dtHURqBSzKB5BL7ve7Ywb0RVGawP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf5EPjQ195KiKz34liKrL18pGP+rFrOHdfZg8KveS6qVbxYCL8
	lEmiQ/3IUgCys9n8yRs9bvZnpKjONAnSlovbNp1lmlfRLgO8Jj+xnh2/vA==
X-Gm-Gg: ASbGncvqP8Fljbw9kGdgj5DIAo9nkWcKcHKKTU0pimIABQtqgsvrZDHK6trIp9Thf1k
	jtMFvR3UMI0vG2MXVFs+2rzkKVaH2CAfff23d94Pobuc02s4/iBtI9RXpZvuTFc0J2chu3li6Qp
	w5JMolh87NRDyrfldeYtsvMxDVpSHwRgpOJLHzs0y/B8T5jSgHGEt9FVloRLApy3RzBPGdiFBsR
	ORXZnHNmOx2ybwqq5y2fdxQwUVQzpkmQE2Zc/S7S3UAv8BJLVqls8RZYVOYwhT4LLG2UPPwMF50
	Htcpa1JmU/pRA5bGFbhwkeNEGElNypL6IAbuv0RiNo7GigAvmpK8Ok2kDe4vuWM=
X-Google-Smtp-Source: AGHT+IG89+MHRzO8hrfvoS8BM+5zLHNqN52NuLSpsDE+GkqPCfIeSP1aGOaPTvoqsNSMo80weBCqLQ==
X-Received: by 2002:a05:600c:1da8:b0:439:9b3f:2de1 with SMTP id 5b1f17b1804b1-43ba6702c10mr60227805e9.15.1740825865580;
        Sat, 01 Mar 2025 02:44:25 -0800 (PST)
Received: from f.. (cst-prg-72-140.cust.vodafone.cz. [46.135.72.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28bf64sm85335595e9.39.2025.03.01.02.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 02:44:24 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: predict no error in close()
Date: Sat,  1 Mar 2025 11:43:56 +0100
Message-ID: <20250301104356.246031-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vast majority of the time the system call returns 0.

Letting the compiler know shortens the routine (119 -> 116) and the fast
path.

Disasm starting at the call to __fput_sync():

before:
<+55>:    call   0xffffffff816b0da0 <__fput_sync>
<+60>:    lea    0x201(%rbx),%eax
<+66>:    cmp    $0x1,%eax
<+69>:    jbe    0xffffffff816ab707 <__x64_sys_close+103>
<+71>:    mov    %ebx,%edx
<+73>:    movslq %ebx,%rax
<+76>:    and    $0xfffffffd,%edx
<+79>:    cmp    $0xfffffdfc,%edx
<+85>:    mov    $0xfffffffffffffffc,%rdx
<+92>:    cmove  %rdx,%rax
<+96>:    pop    %rbx
<+97>:    pop    %rbp
<+98>:    jmp    0xffffffff82242fa0 <__x86_return_thunk>
<+103>:   mov    $0xfffffffffffffffc,%rax
<+110>:   jmp    0xffffffff816ab700 <__x64_sys_close+96>
<+112>:   mov    $0xfffffffffffffff7,%rax
<+119>:   jmp    0xffffffff816ab700 <__x64_sys_close+96>

after:
<+56>:    call   0xffffffff816b0da0 <__fput_sync>
<+61>:    xor    %eax,%eax
<+63>:    test   %ebp,%ebp
<+65>:    jne    0xffffffff816ab6ea <__x64_sys_close+74>
<+67>:    pop    %rbx
<+68>:    pop    %rbp
<+69>:    jmp    0xffffffff82242fa0 <__x86_return_thunk> # the jmp out
<+74>:    lea    0x201(%rbp),%edx
<+80>:    mov    $0xfffffffffffffffc,%rax
<+87>:    cmp    $0x1,%edx
<+90>:    jbe    0xffffffff816ab6e3 <__x64_sys_close+67>
<+92>:    mov    %ebp,%edx
<+94>:    and    $0xfffffffd,%edx
<+97>:    cmp    $0xfffffdfc,%edx
<+103>:   cmovne %rbp,%rax
<+107>:   jmp    0xffffffff816ab6e3 <__x64_sys_close+67>
<+109>:   mov    $0xfffffffffffffff7,%rax
<+116>:   jmp    0xffffffff816ab6e3 <__x64_sys_close+67>

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I'm looking at whacking some of the overhead the open+close cycle, this
is a side nit which popped up. I'm not going to argue about *this* patch.

 fs/open.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 3285d146b0e6..a5def5611b2f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1579,11 +1579,14 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 	 */
 	__fput_sync(file);
 
+	if (likely(retval == 0))
+		return 0;
+
 	/* can't restart close syscall because file table entry was cleared */
-	if (unlikely(retval == -ERESTARTSYS ||
-		     retval == -ERESTARTNOINTR ||
-		     retval == -ERESTARTNOHAND ||
-		     retval == -ERESTART_RESTARTBLOCK))
+	if (retval == -ERESTARTSYS ||
+	    retval == -ERESTARTNOINTR ||
+	    retval == -ERESTARTNOHAND ||
+	    retval == -ERESTART_RESTARTBLOCK)
 		retval = -EINTR;
 
 	return retval;
-- 
2.43.0


