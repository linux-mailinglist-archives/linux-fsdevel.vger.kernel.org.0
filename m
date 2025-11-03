Return-Path: <linux-fsdevel+bounces-66746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99770C2B692
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE3218956BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7CB30C379;
	Mon,  3 Nov 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdXcmdeU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C778303CAA;
	Mon,  3 Nov 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169267; cv=none; b=EDNlyiA0/pyJ1od3b2kxKCd4bdswfneQkgUbaL3lViPIH5b2+k2SBzcIZpcta+6OXLnxGc7QljvBw3XC+AnqYYvztCxsQyB4G/zCJgHHX2dDd536DS3esQlQDTYdZV+lr5B8QvuB7OrQirJ57SArLCDNhh7bkALrQc/yjhwg9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169267; c=relaxed/simple;
	bh=cI/wCkL2aCWjfu8Fn9+DnW9cfZKAM4aWc79J+WWc2Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EAM2ipFa9fzakAjR89/6IdvbMuosOJfNS8TaVtE4eFESgx9Yr+ntX3YbKQjBq8B/eq3sH0Ivgj5S4OBv1UGGM7BB+id363CDo2D84lyR635TkaiiaDPskxHtxu8cot6pYUx8vXzPB403xiqlbYehpiKoVfybbM8R4uWpv5gbk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdXcmdeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C00C4CEE7;
	Mon,  3 Nov 2025 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169266;
	bh=cI/wCkL2aCWjfu8Fn9+DnW9cfZKAM4aWc79J+WWc2Og=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WdXcmdeUI7d7FY8An7/fIl/EVg+Uk/Gsp72iYPvHQI0TMM2ZwM+FkDEcH65fSeC4D
	 lNzRLyt/nrrMaxqugF5szXDc9alaK5CA03yFADWm/OTnxfiPAkCFM1OqzyCAJ0HK3l
	 VXHm3zRc1Bdg6sgv/WOuWWyHLMSdOtZzfNmt4hoFAGAnmp4lH55Y+6YtZBNCGREhhw
	 B77COT6wrCa+L5PGDqDnseQOs99bJgfmOow1aYPlfXjeyssIHhn8PY7emMUot6cT+C
	 ik2I+AlaNtzUU0XF4ol6l79HbigRNAT5Zg3vKGS6GXmAUSr3lyOXMu5tZ8llaYquKR
	 pHoWbORGrPuBQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:27:01 +0100
Subject: [PATCH 13/16] smb: use credential guards in cifs_get_spnego_key()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-13-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cI/wCkL2aCWjfu8Fn9+DnW9cfZKAM4aWc79J+WWc2Og=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTOxILb32Z+vLgE6nhY+mnF68VHJekZl+4OTFuT9+F
 C4KTI/w7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIzCeMDFM6cvZe2CyhUXbm
 V391qJP7NdHHgrxf58ez6pc7N2tPSGX4p/21dNKnHytYHyeuXL2ncu7aGzbbNxX7fM2M26B/TnT
 rYVYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/client/cifs_spnego.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
index 9891f55bac1e..da935bd1ce87 100644
--- a/fs/smb/client/cifs_spnego.c
+++ b/fs/smb/client/cifs_spnego.c
@@ -90,7 +90,6 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	size_t desc_len;
 	struct key *spnego_key;
 	const char *hostname = server->hostname;
-	const struct cred *saved_cred;
 
 	/* length of fields (with semicolons): ver=0xyz ip4=ipaddress
 	   host=hostname sec=mechanism uid=0xFF user=username */
@@ -158,9 +157,8 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 		dp += sprintf(dp, ";upcall_target=app");
 
 	cifs_dbg(FYI, "key description = %s\n", description);
-	saved_cred = override_creds(spnego_cred);
-	spnego_key = request_key(&cifs_spnego_key_type, description, "");
-	revert_creds(saved_cred);
+	scoped_with_creds(spnego_cred)
+		spnego_key = request_key(&cifs_spnego_key_type, description, "");
 
 #ifdef CONFIG_CIFS_DEBUG2
 	if (cifsFYI && !IS_ERR(spnego_key)) {

-- 
2.47.3


