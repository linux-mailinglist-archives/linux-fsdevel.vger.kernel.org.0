Return-Path: <linux-fsdevel+bounces-66807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ADDC2CAB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4BD3BFAB8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC33329C56;
	Mon,  3 Nov 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2wLd3sx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC973327786;
	Mon,  3 Nov 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181876; cv=none; b=Z69PLnkvAV2xIonDG4grxhcFFJ1+yNu86ODkvRg1cj+9u5LCS+VSneNJpZ3qKZCSPQCpW8cnNonR8GqnuSX5xww6zqynbS/Mu6jnBVoyZbxzjL1A1crX1Ie5YeIF7IhyWK2KbzJXijWM7uBWb7eu2gjZvUybJNHZ/Kp3bhhdgdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181876; c=relaxed/simple;
	bh=hgkklzfTerCwn6xW0BCQ41853TdMJYRvcgAE5M0xYQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VREKBQ/X+kuNwctQx/ndm1YB9dPh5c83hlweBOC0hikOuhsOFRj4HLqTJggTz5GcIe5U8p0ve7mFlgBDzWKe2nI9k/jchHOEg30b3lYVEEM362FtB9K3PKr2/yerLVdEBGIHBf7sEs4vafC38AkRjXsLAyzTB6o1BZUgn473PKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2wLd3sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BB4C4CEE7;
	Mon,  3 Nov 2025 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181875;
	bh=hgkklzfTerCwn6xW0BCQ41853TdMJYRvcgAE5M0xYQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r2wLd3sxfx6r1r0GoodOvyvfY2BqexLnPkiaRjmgO4WFNcJOtSLd+mcA/t4apNfgF
	 Y15njJMrP6EshXnNLc8S93q27uPRutrlOAJ7DwqbRJGK8noAcHnvsW3epmMAf22T9l
	 343cSmpA9Kpt1SdAOPwqfrO2KPUxcotPK0xrR4sCOaVX+oyJMC+GLlE5GudrvZqES5
	 Unt0LXqT+5DyH8zm/AuSLWIfMjcM0sPrwt3YST18lDpb6QrPe8mZED99l5H2rfLk0E
	 rdXNQrvCp+bssYibRawYXm7uxvjB6n270+gewURxwnC/Bs2b5sv9Fd0zUT1Yv7Cr6q
	 5dI2M+G1dJZzA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:28 +0100
Subject: [PATCH 02/12] sev-dev: use guard for path
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-2-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hgkklzfTerCwn6xW0BCQ41853TdMJYRvcgAE5M0xYQw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHpx5VP+PfPGc9c+np/VuvH0v/bpz1u/Ml8UPLz+1
 rpIlt/7xDtKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAm8pGX4Z8FSwKz59Rc02gn
 GwcbnsI4h7+p4osfx+n0mDH3T+L1WMLwP23ZHsHkndXnPsv8ue4csto2fOqv8xnHq++8PMT3dLJ
 gIyMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Just use a guard and also move the path_put() out of the credential
change's scope. There's no need to do this with the overridden
credentials.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 0d13d47c164b..c5e22af04abb 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -259,8 +259,8 @@ static int sev_cmd_buffer_len(int cmd)
 
 static struct file *open_file_as_root(const char *filename, int flags, umode_t mode)
 {
+	struct path root __free(path_put) = {};
 	struct file *fp;
-	struct path root;
 	struct cred *cred;
 	const struct cred *old_cred;
 
@@ -275,7 +275,6 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 	old_cred = override_creds(cred);
 
 	fp = file_open_root(&root, filename, flags, mode);
-	path_put(&root);
 
 	put_cred(revert_creds(old_cred));
 

-- 
2.47.3


