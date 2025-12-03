Return-Path: <linux-fsdevel+bounces-70575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDD3CA09E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 18:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B708B3009C22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C21932C30A;
	Wed,  3 Dec 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SyY83qXJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570C32B9B3;
	Wed,  3 Dec 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776993; cv=none; b=GGrklp0yNoUM0dPDMbwwmV0kuhmrq1+i/GQrT3wLpGJ3eCBU+a6bAclHQZ4PnVzytKqV4ke5sGDjVbCMZX3uGKSIwrHx0jH0V0gNFJ+0CJk7z1KjX9FcConjxx2axXmQ/YtoHswdenPTf+4oRSjKcGjKx8lIT/qyZiBszKw15jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776993; c=relaxed/simple;
	bh=jO8uzi3Si5l3LVhDdcaywLi3ykfjTVkA16+VrEW12OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWXHm4dd4gnRCKNjZpullJa33lcG+ufkyCt1vUwvtB8zfhbdBRgt2nmCrnMFQcfCEfdQRyQn/+e66a1ycXCL69Zb83dN3PnsYODT+Cifpxo8WJmOfwY3/rouqO1SSLfac/pp3L81MLn2U6RwDbyQxizO/9/sv7Q623spxTri+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SyY83qXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C951CC116B1;
	Wed,  3 Dec 2025 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776993;
	bh=jO8uzi3Si5l3LVhDdcaywLi3ykfjTVkA16+VrEW12OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SyY83qXJps64oZUFTd01h3BdLWBuTuZa4pA5aOJ+h1CAxyPSKzYNLC7vfPxiQ2ri1
	 tma9cxML9+/bZ0nkOvgaciTXJVp4Rcf0k1H8mCKHs11FnrsfVVAkQ8V0qTS1Geufuv
	 4izpuBszKWKSl4K6e5x0NLJJFQPw/FPNZFhkWz7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paulo Alcantra <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	syzbot+41c68824eefb67cdf00c@syzkaller.appspotmail.com,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 050/146] afs: Fix uninit var in afs_alloc_anon_key()
Date: Wed,  3 Dec 2025 16:27:08 +0100
Message-ID: <20251203152348.302980110@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
References: <20251203152346.456176474@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 19eef1d98eeda3745df35839190b7d4a4adea656 ]

Fix an uninitialised variable (key) in afs_alloc_anon_key() by setting it
to cell->anonymous_key.  Without this change, the error check may return a
false failure with a bad error number.

Most of the time this is unlikely to happen because the first encounter
with afs_alloc_anon_key() will usually be from (auto)mount, for which all
subsequent operations must wait - apart from other (auto)mounts.  Once the
call->anonymous_key is allocated, all further calls to afs_request_key()
will skip the call to afs_alloc_anon_key() for that cell.

Fixes: d27c71257825 ("afs: Fix delayed allocation of a cell's anonymous key")
Reported-by: Paulo Alcantra <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: syzbot+41c68824eefb67cdf00c@syzkaller.appspotmail.com
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/security.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/security.c b/fs/afs/security.c
index ff8830e6982fb..55ddce94af031 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -26,7 +26,8 @@ static int afs_alloc_anon_key(struct afs_cell *cell)
 	struct key *key;
 
 	mutex_lock(&afs_key_lock);
-	if (!cell->anonymous_key) {
+	key = cell->anonymous_key;
+	if (!key) {
 		key = rxrpc_get_null_key(cell->key_desc);
 		if (!IS_ERR(key))
 			cell->anonymous_key = key;
-- 
2.51.0




