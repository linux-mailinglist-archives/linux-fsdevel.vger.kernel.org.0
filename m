Return-Path: <linux-fsdevel+bounces-58943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EC5B3358D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D323BB0C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927342857C4;
	Mon, 25 Aug 2025 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ik2827r8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C62701B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097045; cv=none; b=oiScuCo/vxtKl/PGkKqDntjqIqFKeidsaux6NTQfcvA1+WDGqaA6C5cXgk+idjufiHtWZrMfwF3BfziiJ6NusWSzGTn0a/ENB+7nx9xTry5vP9tWf3vnGxuAdxdv5JcQGk8iPwwQ7QXNkFhUp2Dnrf3Fo4D+H6on/TRMiDz5KW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097045; c=relaxed/simple;
	bh=GMHMxoXggISqrudgGvEHRv8hITFx62Ra4ux8ALe7jBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjeD0+WG1IcDLYrw61HIN2Twr0yShBUWN3yelkE62+OdLivrtjusfHJ6vJ1pJwvicKmgLFgh2RxNYQ/pW2QYjgN+wk/44Q0dBH0wbDwtyaY6BxsAf2Cc6pUD4jYIQp410yyktpvSuL2HX+zm+JbbckCibXhdfndWhF9gqmZSH6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ik2827r8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Iek2kcBdfuCTyk3yqB4XV22RNwWZ76QeZXNU9WTCGns=; b=ik2827r84mTif7qvFGbPiRHCTX
	JFXU1RLZ73kocRDe9Ocszd3lCJm2qljRdI80TxRb3wf66zqWSekFwhAP2uMV27YBfNvKTZi8IHc1X
	E2MIrADcC1JNCiaXE2ZqtsFpd+v2n3hmQWpeF4DzPvnIIWvoJ4a0mqhvMwJwNsBHAxEKO6O6TI+Hy
	ACmD08hms7ptGh+yvDl3xEeT81gfZu6O76/Fm3QuvEZVouQkFuyAY4ES/EVB2aPzhU6y81dji3Txc
	uUvmgNBxIikR6H8WOn/RTcwt0MWNQuVYtlpaTsHF544KfrgqDbydiG1iBnkX/rHN7mGj23A4oXLSv
	AmvKtVZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3p-00000006TFS-33BB;
	Mon, 25 Aug 2025 04:44:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 47/52] constify can_move_mount_beneath() arguments
Date: Mon, 25 Aug 2025 05:43:50 +0100
Message-ID: <20250825044355.1541941-47-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 76f0dde2ff62..c6fd5d4d7947 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3473,8 +3473,8 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
  * Context: This function expects namespace_lock() to be held.
  * Return: On success 0, and on error a negative error code is returned.
  */
-static int can_move_mount_beneath(struct mount *mnt_from,
-				  struct mount *mnt_to,
+static int can_move_mount_beneath(const struct mount *mnt_from,
+				  const struct mount *mnt_to,
 				  const struct mountpoint *mp)
 {
 	struct mount *parent_mnt_to = mnt_to->mnt_parent;
-- 
2.47.2


