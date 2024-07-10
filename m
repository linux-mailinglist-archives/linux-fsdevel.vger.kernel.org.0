Return-Path: <linux-fsdevel+bounces-23525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFF492DC26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 00:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF261F25124
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106BD14C586;
	Wed, 10 Jul 2024 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4cERl79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BDD1411ED;
	Wed, 10 Jul 2024 22:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652247; cv=none; b=Hj5J2aBpDlUdPe8sXJ9Rcvu1LN5oWpKMn9EczbFlRPxuYlW05KJJlnwwv18MHYH8Ron/4QyLiktOPB3npj2rCzAFERPHRATnDNg9DIGxRNYa+tGlBsBMRGyJOd0nBB4h+KZEO/kbPSLeqqHVDAn+9KAHDt48elIGBRT8k/a4wqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652247; c=relaxed/simple;
	bh=lgkwuMhYjgJdCgtmrNEJX1o/Bkha+B9ImM8K81AzqKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=atMJtNl/gOBUL3yyhzqaTmmDBOyDxYNy9zyonAj2NPzL1jWcQg282Z0t+wDV/je64qOYuk/8iGoJLVkYLYC6UrWnZab7qQWgFgK9nN8LKFg4zsaqpzs8XVWuw34Sz0pdr/XbS4ZJknJWmvsIuE1OJeiKp6nErumaZPKrLfda1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4cERl79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47982C4AF07;
	Wed, 10 Jul 2024 22:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720652247;
	bh=lgkwuMhYjgJdCgtmrNEJX1o/Bkha+B9ImM8K81AzqKU=;
	h=From:To:Cc:Subject:Date:From;
	b=H4cERl79oVFHINy2xMbmjFiiCIVsemisWvR+v+NA+wH3tbeU0nio8vpNw71TBF32O
	 ZbDUZzBpMOBAIaQt2Q7YhayGrHtU0S7zOHX3rJqomQcutOyCYrv74CJ2EqaCFJe5/M
	 pQptBBcP2OO1lGcNPKALS7r8I1sMVLV0NxKfS/a2Vc+AJSUgYAMy5Lyk/2XjDV55Co
	 T041thcUjpNzl5domoEeZWlHHo90rwsFey75SMUutO4N2pfTXwrzmvkhPfhZ4J5O/y
	 BLnDKK2UTlenXX8HL13z2s10KgfMWVEcvmgzT6+oI+39QYKCCfSp48IafDHu0hA0a5
	 ar0pDR1se7owQ==
From: Kees Cook <kees@kernel.org>
To: David Sterba <dsterba@suse.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] fs/affs: struct affs_data_head: Replace 1-element array with flexible array
Date: Wed, 10 Jul 2024 15:57:25 -0700
Message-Id: <20240710225725.work.409-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=kees@kernel.org; h=from:subject:message-id; bh=lgkwuMhYjgJdCgtmrNEJX1o/Bkha+B9ImM8K81AzqKU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjxHVDuolJI1SOCuvqG78mp7to8j9ToRsJxZUF kMkyR0aqKCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZo8R1QAKCRCJcvTf3G3A JrXID/9Fv+AK42CH8krWSvnBxkUKUZQ2RUOncRj1NGjDNJCrXc5LFQ9z8pyaG96UVfqjMqaWyVQ eLoNzRImzqRNm9oWM2cKVkw2G/EzZGtS4xIUkpjtbahSEaq2DtytKbDkkg38cjHChR8wA7oU0HG mozEqjJmLNwMY3vfk+C/BHIG93Oepew7wvadneuCeilgDgDk2gcwXkOhzStShr5E0IVXIa9WaOe 2Fwbt5yWg3GHtynGz8CNn8G6y/bdRaLsb7lPHSdQ70N0AywDGcvnWJZAyPwXa45YFRJ033Pigr0 EN40Jqib37334PvEBJUGitgNIkjWZVgF87rMfEYi1UskCxQa+XkXx+Blbp/wjaysAJ8GlPcH32v j+rM3urbVlUiiOZv597dTxdU9rMVRCs687OyTn6vOuBPOV1e4dxcGYE5XVnHlpjvRiQCW2IL9qM aqZM4Sr7JL487lKk3rTYyexMk5hAHpOkTU0QTnAJV7E5ykSXlwgIXUV6U7HG+SE+RFa1ljDtFJ/ I2uUt/HFYT9aMcmMKRj3PXLRBf/GWyDo+wgeacQhrcnatuGwNTIfIVLJmkkjSZk3qpDl9kqOvmx quO3fbLxchbf5MnQWSgqCb+VtuKB39lxfoLF+TEvYbwfzdj72unoxsIeyxpv5jL8oufwyNXlDi/ PLwgGcFvaWwLmU
 Q==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace the deprecated[1] use of a 1-element array in
struct affs_data_head with a modern flexible array.

No binary differences are present after this conversion.

Link: https://github.com/KSPP/linux/issues/79 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/affs/amigaffs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
index 09dc23a644df..1b973a669d23 100644
--- a/fs/affs/amigaffs.h
+++ b/fs/affs/amigaffs.h
@@ -119,7 +119,7 @@ struct affs_data_head
 	__be32 size;
 	__be32 next;
 	__be32 checksum;
-	u8 data[1];	/* depends on block size */
+	u8 data[];	/* depends on block size */
 };
 
 /* Permission bits */
-- 
2.34.1


