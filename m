Return-Path: <linux-fsdevel+bounces-60052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D82B413C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87425489DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9B2D6612;
	Wed,  3 Sep 2025 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fs5BCYlD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EBF2D4B69
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875343; cv=none; b=NBfbPyg5HQw4C7X7XSnsKAAsVog8LcvlG431azRDQDL4HCl2KZghzNg1DWlZKBtSA3YpcH1GK0PnuCQ9QnUXYZqJf1MVqAKwDaHVsS65bbXFrvmq6lIVCffbdy4OaEwku5OWDfcLWKZB0yaNrotyGDQxSlCjYVEyoyPs3gELjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875343; c=relaxed/simple;
	bh=QkfkXtUoBI4VJpRGk6gUgrCv+C0f5lfycPQB5D36or8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ei3edRyR2B9AMAU41e5n9geCrj4p15CB6y8eNQgE2DfezocV9o9fcJj6qGuFTvPGMDpsKO8f9fRkd03+bw2qGgV4i54izO41ZjXydpEFHsSA2h0wtX7u2qZzu+loa0gbn/pAdTMrToAXF+INxAB8ALoRLiKG2UM+2BQIukcmV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fs5BCYlD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5D1GxuQ5k0GZaxVOYjvPH1/nQoHcqpz0jbV2p/7gZtI=; b=fs5BCYlDGn//U+0ORlM2d5DV+v
	ak6KXg4ClnJBBZIKH+6dHmfh/zF0KhD2MWSLmkcylzKyzULyrisAXomE93HpahcltmPIyUC8rzDfG
	FhSENt97z9TRsGsvwdP6fN5QrXowDPzWqORmBB6bAAxSR4pgUc8IByHRq6DDHNoWl+iksEQYsJAuj
	NqPM7I4C5qw8OEuCU8CaOHplIIgsje25RkFZZdgtsUG4jKBMt8H/0FuHbXnIKVG4ebL0lkCes3sc4
	V+fe0uhYh4zCuOZLATs6YnLlbAMQyvc8TL7CENdR9wVnFq5S95BEgjskB9uur2/wVQWRxgVG0EXdH
	5IwaWVDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX2-0000000Ap7E-1Mor;
	Wed, 03 Sep 2025 04:55:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 12/65] propagate_mnt(): use scoped_guard(mount_locked_reader) for mnt_set_mountpoint()
Date: Wed,  3 Sep 2025 05:54:33 +0100
Message-ID: <20250903045537.2579614-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
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


