Return-Path: <linux-fsdevel+bounces-4118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D12A7FCB88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC811C20D1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D892382
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8OY25HX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CD481C4;
	Tue, 28 Nov 2023 23:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E808C433C8;
	Tue, 28 Nov 2023 23:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701215758;
	bh=nG35m4Vhxm9XNz4uNcrivh81CH8gXfwdbwOCLLaDjvc=;
	h=From:Date:Subject:To:Cc:From;
	b=H8OY25HXkY/+389x+INNuMR+qeYUfXBigl+TQ7yAxhaZCU2brkK4nogY/bpNaednx
	 eyA8WkmW9/XasYQRRbV6/fe0ZtW7HhsdUDbnsUvXTGsCwaEa3fJqMJ+qFsagq+T5gp
	 lGcZpOVRCfS+Umh3ydNyuzYAycGIBI+GWma7AcfXrkFXHdfR0ytlq57gbopfowsNOf
	 b3p+enhLs9ZST689HKcd26/WSI4vLmFCtTevslR76NUgCqL5kWh5navmy875BjRrxt
	 RSu0jCUVT9ZozQjrpLxS64m+XTeE6Ihup65O7D1z+27s9hnWdWjyASyJdXX1msEOyS
	 rG5QV+USiLINw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 28 Nov 2023 16:55:43 -0700
Subject: [PATCH] buffer: Add cast in grow_buffers() to avoid a
 multiplication libcall
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-avoid-muloti4-grow_buffers-v1-1-bc3d0f0ec483@kernel.org>
X-B4-Tracking: v=1; b=H4sIAP59ZmUC/x3MSwqDMBAA0KvIrDtgxijqVYoUrRMdUCOT+gHx7
 g0u3+ZdEFiFA9TJBcq7BPFLhHkl8B3bZWCUPhoopcwYKrHdvfQ4b5P/icVB/fHpNudYA+ZFYSm
 1LrdUQQxWZSfnk7+b+/4DPVXPLWwAAAA=
To: akpm@linux-foundation.org
Cc: willy@infradead.org, ndesaulniers@google.com, 
 linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587; i=nathan@kernel.org;
 h=from:subject:message-id; bh=nG35m4Vhxm9XNz4uNcrivh81CH8gXfwdbwOCLLaDjvc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlpdXztleunX9qzhVOy9p1PwwUxDZcIfr4gH47l9UYWy
 au1A+U7SlkYxLgYZMUUWaofqx43NJxzlvHGqUkwc1iZQIYwcHEKwEQcZzL8FTQ6/lwk/XxE19F7
 888s45repZ9x9tWDORZ/2feuuL5yoiIjw8xI/6QEJVeNr7IKusv42E9tfqIae+iJtXvb2SqjmPg
 fnAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with clang after commit 697607935295 ("buffer: fix
grow_buffers() for block size > PAGE_SIZE"), there is an error at link
time due to the generation of a 128-bit multiplication libcall:

  ld.lld: error: undefined symbol: __muloti4
  >>> referenced by buffer.c:0 (fs/buffer.c:0)
  >>>               fs/buffer.o:(bdev_getblk) in archive vmlinux.a

Due to the width mismatch between the factors and the sign mismatch
between the factors and the result, clang generates IR that performs
this overflow check with 65-bit signed multiplication and LLVM does not
improve on it during optimization, so the 65-bit multiplication is
extended to 128-bit during legalization, resulting in the libcall on
most targets.

To avoid the initial situation that causes clang to generate the
problematic IR, cast size (which is an 'unsigned int') to the same
type/width as block (which is currently a 'u64'/'unsigned long long').
GCC appears to already do this internally because there is no binary
difference with the cast for arm, arm64, riscv, or x86_64.

Link: https://github.com/ClangBuiltLinux/linux/issues/1958
Link: https://github.com/llvm/llvm-project/issues/38013
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/CA+G9fYuA_PTd7R2NsBvtNb7qjwp4avHpCmWi4=OmY4jndDcQYA@mail.gmail.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I am aware the hash in the commit message is not stable due to being on
the mm-unstable branch but I figured I would write the commit message as
if it would be standalone, in case this should not be squashed into the
original change. I did not add a comment to the source around this
workaround but I can if so desired.
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4eb44ccdc6be..3a8c8322ed28 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1091,7 +1091,7 @@ static bool grow_buffers(struct block_device *bdev, sector_t block,
 	 * Check for a block which lies outside our maximum possible
 	 * pagecache index.
 	 */
-	if (check_mul_overflow(block, size, &pos) || pos > MAX_LFS_FILESIZE) {
+	if (check_mul_overflow(block, (sector_t)size, &pos) || pos > MAX_LFS_FILESIZE) {
 		printk(KERN_ERR "%s: requested out-of-range block %llu for device %pg\n",
 			__func__, (unsigned long long)block,
 			bdev);

---
base-commit: 5cdba94229e58a39ca389ad99763af29e6b0c5a5
change-id: 20231128-avoid-muloti4-grow_buffers-5664204f5429

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


