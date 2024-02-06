Return-Path: <linux-fsdevel+bounces-10491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B140784B956
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43761C24D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46341350FA;
	Tue,  6 Feb 2024 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TegT1xea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F769133983;
	Tue,  6 Feb 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232702; cv=none; b=OL01cOBTrsDHVV8dExnP/99rGpgQve40YBj6oD5BeiRQc3X7SogFIc66PbTHo7XLCu52Z6fZJf1eDhW6NhuHaxdjAXKmJL0/AyDcRcc/tbIzWJDXxr54d8yhPsc+2e39ShWDapFCJgvewFAbUsMWZJyA5ZJD7FaEBQdXZyZEs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232702; c=relaxed/simple;
	bh=VdU1vYi+GD+ERYjNJIkCxt562Lr/u19Pv+1odKYSw10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ra5xFmEVh040Mc1HkkKnLWyjTIA3PAoWcPbMC4dMzFG+apT2ZvCMvt2+zyNTpAPVatTHYamfnhgiuZUI5AP/XDMI4gVmofmV3nguhCmljAeG24AurMuUVBFfkeUnGnLbDZE2JuG27z6E3XyrGwdRah2HOM7DfEZU8n/u7EATc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TegT1xea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 937D8C433F1;
	Tue,  6 Feb 2024 15:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232701;
	bh=VdU1vYi+GD+ERYjNJIkCxt562Lr/u19Pv+1odKYSw10=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=TegT1xeaUHN+4H5ISFusXR6gs17vmhyBe3O2IyOYGja9hciFg//jH6BtC8LEg9wp6
	 5z/70zbK4mxfzg4eoiXR3eseLqAUzoMXZLdtfgA1Sgb1CCn4DvKMf945u0FLQvc/Xc
	 +eYFRcsU3nkJ1o8W8qORVjDT18ADWtNMxubWKUeqSCmfCLXyB8jc830KMCNVWT7Zrw
	 0PhdLQ1XdxiO9WZNpd/LxRYH+btZq+o9KcUw0VKP9gEdzPPKKedD3GImrSC0uZ4MnD
	 y2hLvQJQRPNOUtGTFMpCIxqrxA820OK8lPG/J9BDFrHIqhjwyH1i/maOb/Aah0bcsR
	 LEm2qeLOIbZXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7203AC4829B;
	Tue,  6 Feb 2024 15:18:21 +0000 (UTC)
From: Taylor Jackson via B4 Relay <devnull+taylor.a.jackson.me.com@kernel.org>
Date: Tue, 06 Feb 2024 15:17:52 +0000
Subject: [PATCH] fs/mnt_idmapping.c: Return -EINVAL when no map is written
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-mnt-idmap-inval-v1-1-68bfabb97533@me.com>
X-B4-Tracking: v=1; b=H4sIAJ9NwmUC/x2MWwqAIBAAryL7neCjIrpK9CG51kKaaEgQ3j3pc
 wZmXsiYCDPM7IWEhTJdoYHsGGyHCTtyso1BCdULJUbuw92UN5FTKObkcrLa6MFN2lloVUzo6Pm
 Py1rrBxyJvE5hAAAA
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Seth Forshee <sforshee@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Taylor Jackson <taylor.a.jackson@me.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707232700; l=891;
 i=taylor.a.jackson@me.com; s=20240206; h=from:subject:message-id;
 bh=2l2Nt8j5OYHJJurGGPNUw+7blMKm2R2dG9Yx/CViUyI=;
 b=KmXGWKD8500obyfmmDYWwluHofdz3w2KdArnaAT553VlbvcAPHEfkuirTLne5vUdfSQ0ybnv2
 5NsuDm3y269DxhGLXuFEhejM8RpOD4hmSb8MQKXBpti7AhwVCzH3aIW
X-Developer-Key: i=taylor.a.jackson@me.com; a=ed25519;
 pk=NO7ntQpjIG1IGTO7F8OnLJDKSHUakhrhAli+PL72OLA=
X-Endpoint-Received:
 by B4 Relay for taylor.a.jackson@me.com/20240206 with auth_id=127
X-Original-From: Taylor Jackson <taylor.a.jackson@me.com>
Reply-To: <taylor.a.jackson@me.com>

From: Taylor Jackson <taylor.a.jackson@me.com>

This change will return an "invalid argument" error code when a map is
not provided when attempting to remap files using the id mapped mount
command, rather than returning nothing.

Signed-off-by: Taylor Jackson <taylor.a.jackson@me.com>
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


