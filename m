Return-Path: <linux-fsdevel+bounces-35683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 660319D757E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 16:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9FABC4514
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8311A20967A;
	Sun, 24 Nov 2024 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTvnvEeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F7209667;
	Sun, 24 Nov 2024 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455872; cv=none; b=o8tMUsperi+fOkgN6bGXNN+kIAUr+3wf5RyAbq2VdiBPC5zqOfL9wxnLTr0WboeRBA+QVYZn1QGYWTf91ldL+0PNbEmqP8mFEp+3t76s9AnIxMmg7TkoKkaBmygUh8vSG6xwbrRA6yuDAC6sJKnW92JKeyL7Z95Zvhiv872FrF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455872; c=relaxed/simple;
	bh=JyuYZyB4OGl5WxMFcCkQWT6w+5cVFX8MiGQmbuR3Uto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUekGebyeWLkYmjxfHwaN4A1Kb4ciZi31jDwHr+71zGgL2gFciXI+IZ5RGK/tEtm4ZsIORgC9Az8T18BuzEJ1Bcmn/TMNx1fiUdyXXpb3YoifNnmv8DVliomzsvybL0hC3+uz6v1/eZJxy+N9py2shU6BwSZY0vsObx+NRo9Sd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTvnvEeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B61C4CED1;
	Sun, 24 Nov 2024 13:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455872;
	bh=JyuYZyB4OGl5WxMFcCkQWT6w+5cVFX8MiGQmbuR3Uto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTvnvEeYZD0vzhoR6ZADEwGB9P1N+jyf7ReEpFcLc0ak9YybywMzpe7J/y1hEbKaW
	 CRqRurxZ1EpZ10THfXolog6ZjaQaLwNA6Ft6C1LKx49Aa9wl9dublc/8pctepTtUd7
	 mW89QbPuTtNc4yRXKcuI+oghcWXAEoVzrGQ0CwqfINGmtln9UVCiJTdSAlrUpVD3V1
	 rzXqMp9e2bu/OvfD4bH+nV6nWMiNOBQ6Nodb9FPJVCRgkAQmsGn2qpluSZeeQNlGCj
	 zSG9X8X2gilrCbIg0jbi9UyDyEBRgzYwC7Lu0gzL1EjzOfsa4i8T7f7eDqlD4BwH2k
	 SLY90QJfmtX+A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/26] sev-dev: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:43:54 +0100
Message-ID: <20241124-work-cred-v1-8-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=brauner@kernel.org; h=from:subject:message-id; bh=JyuYZyB4OGl5WxMFcCkQWT6w+5cVFX8MiGQmbuR3Uto=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7686+EeKebvDqP9uid6reyQ9FGlez7nW5uzK0+93iu y8nCjGt7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI0y0M/z1XXTnam5Mr8Ddh 9WqPeZvU36o89dUXXqTQuee3T4u7wSJGhv/lieqfHy/ukDYUXjh992Iri4edM9eGl/2fIsNtO6f lChcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

and fix a memory leak while at it. The new creds are created via
prepare_creds() and then reverted via put_cred(revert_creds()). The
additional reference count bump from override_creds() wasn't even taken
into account before.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 187c34b02442dd50640f88713bc5f6f88a1990f4..2e87ca0e292a1c1706a8e878285159b481b68a6f 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -244,7 +244,7 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 	if (!cred)
 		return ERR_PTR(-ENOMEM);
 	cred->fsuid = GLOBAL_ROOT_UID;
-	old_cred = override_creds(get_new_cred(cred));
+	old_cred = override_creds(cred);
 
 	fp = file_open_root(&root, filename, flags, mode);
 	path_put(&root);

-- 
2.45.2


