Return-Path: <linux-fsdevel+bounces-10707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 691FC84D80A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 04:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF361F231AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 03:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1EF1D532;
	Thu,  8 Feb 2024 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG/2miJD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E271D527;
	Thu,  8 Feb 2024 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707361381; cv=none; b=DTTZsKJ1GLrbBnZsAMkMhqphB1Cmxm1xWvR3FFW+P9sFO1NcCsikgFnyDLptx9dMo7hcNuk7Kzqi2590sdxHC46/28gxjIDIzD1uwdpj5KQsiW89tQy4hynb6syWoD2XJC1YS/2a50JupqfidwP3Wd6F1iJWGizLZEvyxlkr4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707361381; c=relaxed/simple;
	bh=gCp4+3KXtXmU2pDbRIv0pZycO02wlcy/xdhCfLUsbSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JP4WZYOY/yOAiqEL3d41YIbIod81yOAivyokWbAsilVViRRrT3MtkIa5diEslNC9UHEMDi+ch7JCXnrEyz3glzbI+mCjFWZOyTm5yJzfAhlMwi3TWFs3MGgzmi4R0lRGFt32V9y/r8coTnWTOq71SbYxHptl2KVTL9QQ2w1Ajn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG/2miJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 911AEC433F1;
	Thu,  8 Feb 2024 03:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707361380;
	bh=gCp4+3KXtXmU2pDbRIv0pZycO02wlcy/xdhCfLUsbSQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=aG/2miJDoPXVvUO7JbdKTqvdl5RJCB+kwfWB5Ykx0BRuVddp9A69wm5c19K59Eo3f
	 /RUBz/W9EWlk0jRzZ3KfuHtfuGaTneQo8oATrYtGV4eGRod6OvXVWpECXGUiI53wZK
	 b4SxC5Yl2mnhe6yzD58gk5zJzEZ4m+1MWedAyBCb7TYBf2e0HscTS/6WH8VfkStOWD
	 sFFL0Xhuvpb/2qlnWGx7fSkEkDZjsENr/Wad4geQkmjKjFfaQaW/sAoKMjyhanTNgU
	 Ejk7TYgysXEBEWB/FS2x7diDnszknX1fo0jHfSTA2f5dlCNwv+/kv9TaUdmVymlzFy
	 MFcie9BGRFtAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF26C4828F;
	Thu,  8 Feb 2024 03:03:00 +0000 (UTC)
From: Taylor Jackson via B4 Relay <devnull+taylor.a.jackson.me.com@kernel.org>
Date: Thu, 08 Feb 2024 03:02:54 +0000
Subject: [PATCH v2] fs/mnt_idmapping.c: Return -EINVAL when no map is
 written
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240208-mnt-idmap-inval-v2-1-58ef26d194e0@me.com>
X-B4-Tracking: v=1; b=H4sIAF5ExGUC/3WNyw7CIBQFf6W5azE8bMWu/A/TBRSwNxFooCGah
 n8Xu3c5k5w5O2Sb0GYYux2SLZgxhgb81MG8qPC0BE1j4JRfKKcD8WFryquVYCjqRZg0QoneSeE
 MtNWarMP3UXxMjRfMW0yf46Cwn/3fKowwMkjtlNa3ay/E3dvzHD1MtdYvwx1MZKsAAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Seth Forshee <sforshee@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Taylor Jackson <taylor.a.jackson@me.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707361379; l=1297;
 i=taylor.a.jackson@me.com; s=20240206; h=from:subject:message-id;
 bh=y6gRCATQD4BQ+HtUr3Y6tmpmjhF1EH0eWIIzJbmFHZw=;
 b=xgJWSv9ONnVT6GLyCRj6fBt71hj75Q+dupY5rzp8TyN5h3llr5WNNsvfSWm0VOyXJP1K/yq6o
 323miYF4kyXCKxCPSsqNNvQBBGURN9XwnlJuC4SIqzgv2/LTWvpqcjR
X-Developer-Key: i=taylor.a.jackson@me.com; a=ed25519;
 pk=NO7ntQpjIG1IGTO7F8OnLJDKSHUakhrhAli+PL72OLA=
X-Endpoint-Received:
 by B4 Relay for taylor.a.jackson@me.com/20240206 with auth_id=127
X-Original-From: Taylor Jackson <taylor.a.jackson@me.com>
Reply-To: <taylor.a.jackson@me.com>

From: Taylor Jackson <taylor.a.jackson@me.com>

Currently, it is possible to create an idmapped mount using a user
namespace without any mappings. However, this yields an idmapped
mount that doesn't actually map the ids. With the following change,
it will no longer be possible to create an idmapped mount when using
a user namespace with no mappings, and will instead return EINVAL,
an “invalid argument” error code.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Taylor Jackson <taylor.a.jackson@me.com>
---
Changes in v2:
- Updated commit message based on feedback 
- Link to v1: https://lore.kernel.org/r/20240206-mnt-idmap-inval-v1-1-68bfabb97533@me.com
---
 fs/mnt_idmapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 64c5205e2b5e..3c60f1eaca61 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -214,7 +214,7 @@ static int copy_mnt_idmap(struct uid_gid_map *map_from,
 	 * anything at all.
 	 */
 	if (nr_extents == 0)
-		return 0;
+		return -EINVAL;
 
 	/*
 	 * Here we know that nr_extents is greater than zero which means

---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240206-mnt-idmap-inval-18d3a35f83fd

Best regards,
-- 
Taylor Jackson <taylor.a.jackson@me.com>


