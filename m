Return-Path: <linux-fsdevel+bounces-48766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE458AB4210
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 20:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A279D16B8DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC52BD908;
	Mon, 12 May 2025 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFtU2ryU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7892BD5AB;
	Mon, 12 May 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073118; cv=none; b=ah3i2j/jcUUwSwvHthsPrls51bikxSN95Iz6lI7a3f1QLp6Efni7ff7uMv0Z4Yn2EjvqFPWEViW+iuxUfEoWQAYpVUMFHlsoZoOvVhPRAIBm0ukOdRre6piAEgYfCdaJ31Q0GcxvIq1+/Iv9Zn721B39pySAv4OTClATjyqm2Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073118; c=relaxed/simple;
	bh=bOnQEdYThpYqJSXsbDNSJRuDppx3jO9r6VhGfGNxQFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jAFt7KbScvxKxG+QGRFAR+U9Y08tvcQOhQLnjJBE1m2gP1P7SBA0DDj2oI0ftYm//1MdCPisNWNiJy9ZHIRVfLsgBp9R8+QXlv/oBRzafqPrHdYzbIW7Jr5QrA/NnIwFxYBvbTSk7a6ASq3xe+Oc/3ohWdp/rzwl4ivva7TNWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFtU2ryU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5F4C4CEEF;
	Mon, 12 May 2025 18:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073118;
	bh=bOnQEdYThpYqJSXsbDNSJRuDppx3jO9r6VhGfGNxQFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFtU2ryUvbAifO6YAfkcksIl9QYgbkAerOSEGUcu4bY71XG/8DaAPa8v4vI8/RkYK
	 4Q+Cp6KXt7FzNqHCo+FYEkykkG55s6bpYUlskTMUDGjwntAEeiv5ft0/sDaowhXH32
	 rtKKkhwsB8qsaxUkiCRjTp8l4ICJe2ph0fI1T9ecgoi+QRu0EqqgwoO/We9TGWxySd
	 zjmCX0m36YVfa9GvZfLdfoI6gcqWD6AC0LeKbFxaAzr6ZVagFbITK/8Bp7ZQnteXil
	 L8LC9pmwnAp2gQgEHcecfEayTXkK6VmMgmHftMQnoDbtF2n+JMu/YK/yw/v0pGHuMd
	 Q5JVijYWFF4SQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 4/4] __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be under mount_lock
Date: Mon, 12 May 2025 14:05:07 -0400
Message-Id: <20250512180508.437991-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180508.437991-1-sashal@kernel.org>
References: <20250512180508.437991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.138
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 250cf3693060a5f803c5f1ddc082bb06b16112a9 ]

... or we risk stealing final mntput from sync umount - raising mnt_count
after umount(2) has verified that victim is not busy, but before it
has set MNT_SYNC_UMOUNT; in that case __legitimize_mnt() doesn't see
that it's safe to quietly undo mnt_count increment and leaves dropping
the reference to caller, where it'll be a full-blown mntput().

Check under mount_lock is needed; leaving the current one done before
taking that makes no sense - it's nowhere near common enough to bother
with.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 57166cc7e5117..42e33d3ad05d8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -632,12 +632,8 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 	smp_mb();			// see mntput_no_expire()
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return 0;
-	if (bastard->mnt_flags & MNT_SYNC_UMOUNT) {
-		mnt_add_count(mnt, -1);
-		return 1;
-	}
 	lock_mount_hash();
-	if (unlikely(bastard->mnt_flags & MNT_DOOMED)) {
+	if (unlikely(bastard->mnt_flags & (MNT_SYNC_UMOUNT | MNT_DOOMED))) {
 		mnt_add_count(mnt, -1);
 		unlock_mount_hash();
 		return 1;
-- 
2.39.5


