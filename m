Return-Path: <linux-fsdevel+bounces-24613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488A394145A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 16:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31411F23731
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA5B1A255C;
	Tue, 30 Jul 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi1ZEjPR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34E1A08AB;
	Tue, 30 Jul 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349689; cv=none; b=ppUzdPZ88n6kLhwM45TyRpB2XhLKVZBP//dCn/BZj6lWDUnvv8R7c9Ia6ZXGKaZe19Sh9N/YHhFxFlIyvN+wbABQ2b3AHI+Ic/bFOt1mzkQBiC0vjHRsEuQDyR6qVTsVMpyZgsIGi9fBBZm+/0V/4hi6e8D7bLcNqqklVVD+BYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349689; c=relaxed/simple;
	bh=v94Q6O93dIkGqquJJVrs9WTgJESEvwnwlclXeilEtus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RK4AIJNW5QhSOvjXkwH4LAxAnt8CBrdjrxRIy4UXUlpu1+PdaW0X08IyKlpZ+k4lFIDURhPe5lWfdwEGL2f3hphASFMGJSJ7imFk3hYHmK/l0oYDqOacsj2x3+VDBP4SjwOVm0LSQGht04MUDhSk37CNQvGQxdHAbNjEgiSJVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi1ZEjPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F627C32782;
	Tue, 30 Jul 2024 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722349688;
	bh=v94Q6O93dIkGqquJJVrs9WTgJESEvwnwlclXeilEtus=;
	h=From:To:Cc:Subject:Date:From;
	b=gi1ZEjPRA7JZo8a2YhG1Rl02E1bR2Ma/crld/CAqxWPQmlh3V1QKujEyB1Msa+Si+
	 eoxXvEK7SPlIK4OLeSAcLtRNRZijercBTXjtL7om62wbFwXAo+yzBgy3+muwhZK1yx
	 eJHcl1IEy/RPKxLcjH02iCUdnjpqW175UJAamxtOK6dxhLFN8mCqL3MSG+xCcE67Eb
	 Py0xu9p4DcS60smDSidoV4PNMc01bu03zcgbQgDAGBxvqURiFpjtPn9+wj1Hc6Klp8
	 BLMcNWR+A0IV1/r1dNbuzhG5cqweVgErcx8zvvEza+ZSm92wa0P8M4O+VGpvdA0cL0
	 YetbsSaJa+hKQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Richard Fung <richardfung@google.com>,
	Eric Biggers <ebiggers@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] fuse: fs-verity: aoid out-of-range comparison
Date: Tue, 30 Jul 2024 16:27:52 +0200
Message-Id: <20240730142802.1082627-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang points out that comparing the 16-bit size of the digest against
SIZE_MAX is not a helpful comparison:

fs/fuse/ioctl.c:130:18: error: result of comparison of constant 18446744073709551611 with expression of type '__u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
            ~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This either means tha tthe check can be removed entirely, or that the
intended comparison was for the 16-bit range. Assuming the latter was
intended, compare against U16_MAX instead.

Fixes: 9fe2a036a23c ("fuse: Add initial support for fs-verity")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/fuse/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 572ce8a82ceb..5711d86c549d 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -127,7 +127,7 @@ static int fuse_setup_measure_verity(unsigned long arg, struct iovec *iov)
 	if (copy_from_user(&digest_size, &uarg->digest_size, sizeof(digest_size)))
 		return -EFAULT;
 
-	if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
+	if (digest_size > U16_MAX - sizeof(struct fsverity_digest))
 		return -EINVAL;
 
 	iov->iov_len = sizeof(struct fsverity_digest) + digest_size;
-- 
2.39.2


