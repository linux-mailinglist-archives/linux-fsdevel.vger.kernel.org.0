Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED579E95E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbjIMNdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 09:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbjIMNdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:33:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65BD19B6;
        Wed, 13 Sep 2023 06:33:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA93C433C7;
        Wed, 13 Sep 2023 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694611999;
        bh=U6rJDc8/HNt2MyKMpa3VX4pGAzI4l/fhGVSjCrFrw7Y=;
        h=From:Date:Subject:To:Cc:From;
        b=m/w8vBSxfvwIwNoF+gZag1mEhpB3sRvgkHSPbVTdZCRl9EI1gH50kSfn5VTzzH0uc
         uIun0Oxa50ODwJ2UCl1o8sbvjU4oF6UCnnlxH4lRpfUjZ8pzlIefcSVfmCFs/lKStB
         G/8No0HmQLFeRScz+eX1raNBVI+dls0QRUVKl0+5lyWI0TnyveiUVMsd5JoCZ88kEA
         XEpT8uOTYX7s8ziLcSHcViIvq4/GVkUU/S7loMo+sw1oCji0WWymGebCYWocN8k2HT
         WTRmQ2vniQwhrPWPz+3RC5cJQg8QEDnD/yskvCRYzWj7s4j1QTA2QMZu3nMnmiU6lj
         GP23EhTE5eqrw==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 13 Sep 2023 09:33:12 -0400
Subject: [PATCH] overlayfs: set ctime when setting mtime and atime
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
X-B4-Tracking: v=1; b=H4sIABi6AWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0Nj3eSSzNxUXSNLS0NzY3Mzg5QUSyWg2oKi1LTMCrA50bG1tQA8zQ0
 +VwAAAA==
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=U6rJDc8/HNt2MyKMpa3VX4pGAzI4l/fhGVSjCrFrw7Y=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlAboee2/mgKjU8JTLm84bfls+24apRnvKTVw2o
 o2baxy12OiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZQG6HgAKCRAADmhBGVaC
 FZy6D/0em1kPDGpqJnR9cNODNrAjXokVlbqEB90ZRVJZs/HbLXOba7IWmkugvKyyOUM1uhEYicv
 muZGCzeaVVypehN7TDm+tFx8IcLSMRuw3jFS2mA3+vusG+eBNHM3TbfZ59XDYH0A0n5i+J32FPy
 1Ur8B90OQZZhQLqQ+Bn4gZxsiqo1E7kmwR7Y7mBOkzSDuc8YbNjeGhR/riv5O8cbafg3Nq6T68Z
 mG8TK1XS/76DBa+moWMfco3KV+exBxGA8cUXgK9kUphMOy+eZ+5TYExPC30vU+i6zdMkZN0YIDh
 z0tTEjiq9RbkN9HTbcIgcU0tHwC1x5Ft9yO0cFnoG+ABtQSrJ5P7MosKoob0ne4kfiB5wB15LtV
 Iq5Nfm8aFAZ4KV3gycblwkq8r/1dW1yFMKuvo36gonabRkaphnhyguafjwT1jwmr6A7VfC7OGjI
 4+KBF7NteZckElAN/MDDO2LODYp6hbEDB4PyM4HsA8igfhzkcQRIMY+HMDtro/5YIaVRqU1DfjP
 aMcrCPKLbfU6oFRhvujOAks9KGNe0pXRb8PzsF06NMb+Q+G2lJMxW3QIRThuO0wFOq4g+PL2YUr
 XwL5z3yEcFFjiv8UJ39/EX2M4ofKanO68yUYqzUzK8M9591vD/qaBV6O/NvoVV8WJCXCkwh7Q6S
 XM+A8mynNlCbqHw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nathan reported that he was seeing the new warning in
setattr_copy_mgtime pop when starting podman containers. Overlayfs is
trying to set the atime and mtime via notify_change without also
setting the ctime.

POSIX states that when the atime and mtime are updated via utimes() that
we must also update the ctime to the current time. The situation with
overlayfs copy-up is analogies, so add ATTR_CTIME to the bitmask.
notify_change will fill in the value.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
The new WARN_ON_ONCE in setattr_copy_mgtime caught a bug! Fix up
overlayfs to ensure that the ctime on the upper inode is also updated
when copying up the atime and mtime.
---
 fs/overlayfs/copy_up.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index d1761ec5866a..ada3fcc9c6d5 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -337,7 +337,7 @@ static int ovl_set_timestamps(struct ovl_fs *ofs, struct dentry *upperdentry,
 {
 	struct iattr attr = {
 		.ia_valid =
-		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET,
+		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_CTIME,
 		.ia_atime = stat->atime,
 		.ia_mtime = stat->mtime,
 	};

---
base-commit: 9cb8e7c86ac793862e7bea7904b3426942bbd7ef
change-id: 20230913-ctime-299173760dd9

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

