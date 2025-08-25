Return-Path: <linux-fsdevel+bounces-58930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A07B3357F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6EF179950
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CD7283CA3;
	Mon, 25 Aug 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hIxRTx3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75756265CA2
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097043; cv=none; b=DPfaA3Uemb5uoVmPBgrWBi0nJqX1s+bqmwHYTFGfWx9pbyO/aMQchTtdpPbRh8abW/OdKmG56L8wWB+pw9FMBVLRw39/XaVP8B+9bDedbVb08idldQXSRN1MBWk5ykwzxi4hIesDUeXljtHv2s/uhTLhGHQQe5wANQ4HUPVonf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097043; c=relaxed/simple;
	bh=g0cFIaFhEa1YXDyKhmVT20/8ufV/Rp+VbNb7Fz8QxiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVWwrBtETyNHB/enbfRHv0D/e43+HrmgAOUwNMNOrCApM0fFydfxrl4deWViLTzn7LRnzPujL2/quMw1zFlijiEUIIszF4PPjaJweS3ydWffp9u8Z6mMgo1+d5+7NBC9Cy6Se7wHb2Dy/WzeUAbDJnf6sWz1inOrEJX756zuCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hIxRTx3e; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TUaYPvwtc/UWs3S/Uk/AEuJZpqrixOi5E3xR6AGJWos=; b=hIxRTx3efW/B7OHUzAELdD6c4s
	m5SUnV21hzFbgcl3AjOvCL+ywl8M1FfzmRYDUJhb5ro7IBC+5TJCIzaKRGF89Lf4sOUmfMksbc8Qp
	LsNfNeAJF0gSsEb77n2DJfWhRqpbi3YLmf0X8xHa/pX2doRaabxh7XH9Z8oL7n+dSZn/Czca20MMQ
	HajKlSe2l4lS2EJtSaom7mZmcWKaHnXJahJA/N5SZSfZhMevvp7DjgoWZuMddLATRDq7OHNpRudbp
	Fd+ieKPJ4cwtnAnoST1I6y5ft2BlfKcH5WNbqZfkGlEs14AKE+mUgRYKHYYSUHvzseohxoQ+OfoER
	C6dGEQaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3l-00000006T9q-0PPr;
	Mon, 25 Aug 2025 04:43:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 12/52] propagate_mnt(): use scoped_guard(mount_locked_reader) for mnt_set_mountpoint()
Date: Mon, 25 Aug 2025 05:43:15 +0100
Message-ID: <20250825044355.1541941-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 6f7d02f3fa98..0702d45d856d 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -304,9 +304,8 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 				err = PTR_ERR(this);
 				break;
 			}
-			read_seqlock_excl(&mount_lock);
-			mnt_set_mountpoint(n, dest_mp, this);
-			read_sequnlock_excl(&mount_lock);
+			scoped_guard(mount_locked_reader)
+				mnt_set_mountpoint(n, dest_mp, this);
 			if (n->mnt_master)
 				SET_MNT_MARK(n->mnt_master);
 			copy = this;
-- 
2.47.2


