Return-Path: <linux-fsdevel+bounces-51240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352A0AD4D8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97963A3F0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176D423F409;
	Wed, 11 Jun 2025 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KTgsGrqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A823A9BF
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628481; cv=none; b=tA7WDys19FWiJQuwOznQaIjjD+zBw+om5jpOhR07JmwcS2S81rJCWSYh7Sc5D3gRFjYmnw3KH5xU7AykURRKqHuHTgVrnfwQphMSlq53uAZ/M1oWbmusolHIwZu5gNCPcY0nDz2N40ODWViGGL7AimlKInwCoLRRmGaDWKw0llE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628481; c=relaxed/simple;
	bh=9nmQx3lScApld4UbYjNukEgh1kOLFW5w0hSm4LZQbvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erobtlMM2DGsKrpY7t0kNWpR+ZTGTq5reF73fBXzEug3rUVCEXAoL56jKQVh00i26DOt5uvrCR/T2kk4Luz5EtXXpm81FHRC+PATmcHhsPTasQysj2wvRwODxxhoGRaOY/2QSL7wzX/h1mzD1NrpOsJ7of/xc68rN3/5XD3nEi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KTgsGrqb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YNRjan0o1fdtQE1guqzcWQHOOVJEunboOJ5/teN6dkk=; b=KTgsGrqbePxEXjMDKxV2j16zbP
	uFzwUgHv9glK8RRdSzPss8n+k/S/WyZWM8cw4PLQXH2ylT480ZpFuOtv/cwNGZ+7343+nZNcGfJ2O
	YcDBt4GJ+LwXLk0TbxiwujsOcq/zyqL3pZOZRjogwyVM4S9I3vgRdz8GG9wtmRjCtT0jX4mpqXWde
	P2w1O7XatpdUua4A02wcW1ayYkaC2SRDCyrf5PshTgCgD5T9YkaOVtsxkbTNbmIhQxtYbvnzCYz5Y
	NBBRyViAob7+86fYVqu2y47a0YKfojA1bcsstqNEkkkJsizsUQu9EQ9XjbHHmNmdbnWmowmrDrmID
	ZL6Dx5OQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGI9-0000000HTvx-3NdC;
	Wed, 11 Jun 2025 07:54:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 01/21] d_set_mounted(): we don't need to bump seqcount component of rename_lock
Date: Wed, 11 Jun 2025 08:54:17 +0100
Message-ID: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075023.GJ299672@ZenIV>
References: <20250611075023.GJ299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

IOW, read_seqlock_excl() is sufficient there; no need to bother
with write_seqlock() (forcing all rename_lock readers into retry).

That leaves rename_lock taken for write only when we want to change
someone's parent or name.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 03d58b2d4fa3..3c3cfb345233 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1436,7 +1436,7 @@ int d_set_mounted(struct dentry *dentry)
 {
 	struct dentry *p;
 	int ret = -ENOENT;
-	write_seqlock(&rename_lock);
+	read_seqlock_excl(&rename_lock);
 	for (p = dentry->d_parent; !IS_ROOT(p); p = p->d_parent) {
 		/* Need exclusion wrt. d_invalidate() */
 		spin_lock(&p->d_lock);
@@ -1456,7 +1456,7 @@ int d_set_mounted(struct dentry *dentry)
 	}
  	spin_unlock(&dentry->d_lock);
 out:
-	write_sequnlock(&rename_lock);
+	read_sequnlock_excl(&rename_lock);
 	return ret;
 }
 
-- 
2.39.5


