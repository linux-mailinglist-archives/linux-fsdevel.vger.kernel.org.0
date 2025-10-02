Return-Path: <linux-fsdevel+bounces-63295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA562BB4594
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260AE3BFE3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 15:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B25C223DDA;
	Thu,  2 Oct 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABwK7jNK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38901F582F;
	Thu,  2 Oct 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419048; cv=none; b=Sug4gRyL/MctNdqGxa2w7zh+J6s55zGLLmrblw3+ZpBjXfAFAV2KP8fXz9D0PMkfTGNcoppaT8LXBWQU/mHLTKevoK82X/2TziBtBy8OPfXiY1bHfqNSF2PTE/ZUhzE6DuyHmiSY3lFw6dd9Yfl1dM74aXj6DXCGA4/gx7EgXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419048; c=relaxed/simple;
	bh=st+5h9rptO73m5AtLhaB0rrGQgKZ+biOQ0GewOwtOFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYDkJCwscDCxJ9HjgLvFwl6aiIsUGFF60K8WluvV5B6/4D1SoVIl194WLtQ1LSZq7+4bdXZmPywG0EsxCiXJLgvsTjI2u/9GTnKEt2oc8NOH8qP5d1skK8SpfNfLUkcfWq+HM78nzkHC8hmSbmB4UK2/5PzJZspzN0f513EiCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABwK7jNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83851C4CEFC;
	Thu,  2 Oct 2025 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759419048;
	bh=st+5h9rptO73m5AtLhaB0rrGQgKZ+biOQ0GewOwtOFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABwK7jNKTwyupV6EU+gDivy7suWdnDzttMZc9HTtjPJxFJyl4YcdcjZQTaGy/MVSo
	 HQGcfNfdAODj60qmG4zh8XD5mZHnks54qJbRlSZT8CY/+lcBGCNKZVsvNQO7oLMwR8
	 /RFmEcBPUGzjUj7OTxuHxjfxCaaR/nurvAQdLhAERKrQzt0r9sUvfM1Fv8NVVWTEcM
	 yEoOAGWsPOtM5kHZ47YD1TATLoFyIInD71r63ZzX3AyNLNeXzfHi8QdbWDE1Dnnjhd
	 rcOVmfYeqtpCEbbOnlddMQFQogae8d2SNnqtC5W/MaI+gjqPV6Cj9vD0n86dLRjzo7
	 a4itgJ/9N78jg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Xichao Zhao <zhao.xichao@vivo.com>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 6.17-5.4] exec: Fix incorrect type for ret
Date: Thu,  2 Oct 2025 11:30:04 -0400
Message-ID: <20251002153025.2209281-17-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002153025.2209281-1-sashal@kernel.org>
References: <20251002153025.2209281-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Xichao Zhao <zhao.xichao@vivo.com>

[ Upstream commit 5e088248375d171b80c643051e77ade6b97bc386 ]

In the setup_arg_pages(), ret is declared as an unsigned long.
The ret might take a negative value. Therefore, its type should
be changed to int.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20250825073609.219855-1-zhao.xichao@vivo.com
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Backport Analysis: exec: Fix incorrect type for ret

**Backport Status: YES**

### Executive Summary

This commit fixes a long-standing type correctness bug in
`setup_arg_pages()` where the `ret` variable was incorrectly declared as
`unsigned long` instead of `int`. While this bug has existed since 2007
(commit b6a2fea39318e4) and has not caused known user-facing issues, it
should be backported to stable trees as a low-risk code correctness
improvement.

### Detailed Analysis

#### 1. Nature of the Bug

In fs/exec.c:602, the `ret` variable in `setup_arg_pages()` was declared
as:
```c
unsigned long ret;
```

However, `ret` is used to store return values from functions that return
`int` with standard Linux error codes:
- `mprotect_fixup()` - returns `int` (0 on success, negative error codes
  like -EPERM, -ENOMEM)
- `relocate_vma_down()` - returns `int`
- `expand_stack_locked()` - returns `int`

The function `setup_arg_pages()` itself returns `int`, and all error
paths return negative error codes through `ret`.

#### 2. Why This Bug Hasn't Caused Issues

Despite being present for 18 years, this bug hasn't caused observable
problems due to C's type conversion rules:

1. When a negative `int` (e.g., -ENOMEM = -12) is assigned to `unsigned
   long`, it gets sign-extended to a large positive value
   (0xFFFFFFFFFFFFFFF4 on 64-bit)
2. When this `unsigned long` is returned as `int`, the truncation
   preserves the bit pattern, resulting in the correct negative value
3. All error checks in the function (`if (ret)`) work correctly because
   non-zero is still non-zero regardless of signedness

#### 3. Why It Should Still Be Fixed

Despite working "by accident," this is a genuine bug that should be
fixed:

1. **Code correctness**: Error codes should always be stored in signed
   types - this is a fundamental Linux kernel convention
2. **Type safety violation**: Storing signed error codes in unsigned
   variables violates type safety principles
3. **Compiler warnings**: Modern compilers with stricter type checking
   may warn about sign mismatches
4. **Future-proofing**: If code is added that relies on `ret` being
   signed (e.g., `if (ret < 0)`), it would break with `unsigned long`
5. **Code clarity**: It's confusing and error-prone to store error codes
   in unsigned variables
6. **Static analysis**: Tools like Coverity or Clang static analyzer may
   flag this as a potential issue

#### 4. Risk Assessment

The fix carries **minimal to zero risk**:

- **Change scope**: Single line change (fs/exec.c:602)
- **Change complexity**: Trivial type change from `unsigned long` to
  `int`
- **Testing**: The code paths are well-exercised by every execve()
  system call
- **Review quality**: Reviewed by Jan Kara <jack@suse.cz>, a respected
  kernel filesystem developer
- **Regression potential**: Extremely low - the conversion from
  `unsigned long` to `int` is safe for all existing error code paths

#### 5. Historical Context

- **Bug introduced**: 2007-07-19 by commit b6a2fea39318e4 (Ollie Wild)
- **Bug duration**: Present in kernel for ~18 years
- **Fix author**: Xichao Zhao <zhao.xichao@vivo.com>
- **Fix date**: 2025-08-25
- **Maintainer**: Kees Cook (security/hardening maintainer)

The original bug was introduced as part of a large refactoring that
added variable-length argument support. The incorrect type likely
slipped through because other variables in the function (stack_shift,
stack_base, etc.) are `unsigned long`, and the type mismatch didn't
cause immediate problems.

#### 6. Backport Justification

This commit meets the stable kernel criteria:

✅ **Fixes a bug**: Yes - type correctness bug
✅ **Small and contained**: Yes - single line change
✅ **No architectural changes**: Yes - simple type fix
✅ **Low regression risk**: Yes - extremely low risk
✅ **Improves code quality**: Yes - follows kernel conventions
✅ **Clear benefit**: Yes - prevents potential future issues

While the commit doesn't have a `Fixes:` or `Cc: stable` tag (suggesting
the author saw it as low priority), it's an ideal stable tree candidate
because:
1. It's completely safe
2. It improves correctness
3. It may prevent issues with stricter compiler checks in the future
4. It aligns with kernel coding standards

### Recommendation

**YES - Backport to all active stable trees**

Priority: Low (code quality fix, not a critical bug)

This is a "good housekeeping" fix that improves code correctness without
any meaningful risk. While not urgent, it should be included in stable
trees to maintain code quality and consistency across kernel versions.

 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index e861a4b7ffda9..4a89918b761f6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -599,7 +599,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		    unsigned long stack_top,
 		    int executable_stack)
 {
-	unsigned long ret;
+	int ret;
 	unsigned long stack_shift;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = bprm->vma;
-- 
2.51.0


