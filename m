Return-Path: <linux-fsdevel+bounces-53261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99633AED299
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0553B52D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A05F1F5434;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vo5Zbx9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36C1A0B0E
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251981; cv=none; b=hqWmdPVeUoH0qnzxHfC57OgkNDreEossuRR2nQoEq+rCOTUw6pbHSjonY3kBO1Y5I1jlEk1CSAL/+tNceSRK5g7hPrZ7lDhUpqSwIn0i5V69zFSU7YL42I8xzN2WNwyKhmLcgxGKOMSP+IPrcJqBnpbslddvP+9CGTcGG6C/BrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251981; c=relaxed/simple;
	bh=aIG7d45JVyrHxsv2MqfRQW0/R0nRQyl6XNzuVo8fExc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuhuaTQFf1c+5dTNP70SRvPad7JsZSjLyN1+O5P5bttSnm2BT/S08AUkth4Y8m0GqB7Ny9zugROu4vA7poJmuR2YBndudw+DvbACv+qXnrwpX9GLt38Vq3osflET4K1Gd2Y3w7/QRpXYGnLOB/wWYjFuhVtyeeZoHRJoeHdEc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vo5Zbx9Z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=R9U3bPS78goKcq42yHlGd6MEQSus6Ge7sbmR08Jafw0=; b=vo5Zbx9ZQ/sYTHWtZ0+iUq6N98
	3ZyN4BlOFJSigZ0vstAMc9TTVVZLH9kSkaoVek6C8TIMV8nbArxpN+I09XKGNeyDbOqfwOCQRhuJf
	H0kQbsKDBo1eRAzw85xHCBS12CZA6YCYzV5Zh08hA8B/5r0KNNFn69FqWmrCajcwhkakwyI/MriyU
	Z5uhS/K0thDHlc9m176kIMN45O9LCBISCCG3YU3mGdtNGEluwb9LM5IYJsDzNaVppWNJVvxmODF6I
	cnxpcI8zUoUUbpgyG25BXqpgXAWG3xnLCswKhyBKBtDTwWnT4iWh+2sM1zoRIQDxludO04WlI6xmw
	ScnFlOng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dd-00000005p0G-3Biv;
	Mon, 30 Jun 2025 02:52:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 23/48] attach_recursive_mnt(): remove from expiry list on move
Date: Mon, 30 Jun 2025 03:52:30 +0100
Message-ID: <20250630025255.1387419-23-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... rather than doing that in do_move_mount().  That's the main
obstacle to moving the protection of ->mnt_expire from namespace_sem
to mount_lock (spinlock-only), which would simplify several failure
exits.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7c7cc14da1ee..e8dc8af87548 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2684,6 +2684,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	if (moving) {
 		umount_mnt(source_mnt);
 		mnt_notify_add(source_mnt);
+		/* if the mount is moved, it should no longer be expired
+		 * automatically */
+		list_del_init(&source_mnt->mnt_expire);
 	} else {
 		if (source_mnt->mnt_ns) {
 			LIST_HEAD(head);
@@ -3674,12 +3677,6 @@ static int do_move_mount(struct path *old_path,
 		goto out;
 
 	err = attach_recursive_mnt(old, p, mp);
-	if (err)
-		goto out;
-
-	/* if the mount is moved, it should no longer be expire
-	 * automatically */
-	list_del_init(&old->mnt_expire);
 out:
 	unlock_mount(mp);
 	if (!err) {
-- 
2.39.5


