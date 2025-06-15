Return-Path: <linux-fsdevel+bounces-51674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB50ADA067
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 02:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8FD3B5FC9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 00:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A0E1CD15;
	Sun, 15 Jun 2025 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RrdmPQCR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A929A1;
	Sun, 15 Jun 2025 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749947474; cv=none; b=E2r5C6qJziaRYviopxnIcAZWop5U7h3rzldC42rV8Wu/P2rOWPpiA0oD5FBNK7nSRy6uE3GhtVP+agmT/UJb5i8QZVi1ghvmjuJuM/D5wmdgAp2o6CJBEwjTiIWBc8NgZb4VGxgl/88sy1E/MIOYdoAzNOf5qYUXmKcqVHkCOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749947474; c=relaxed/simple;
	bh=dGohUM+sYhQKCUn6Pff8Na7kJp+7rW/sIh9M7/csnEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyLAN1TnbYusmuUzolzKDZB518k/A+F98cfjAW6OrKtgczAdr6EZqICaUV5eayzp53yaTbQ2s9KHU6JPf1IRz8xbfahBH3oeXqJyl/WR+N/PBTk4XbAtva9XRn+6RHjKfUdlF6rbW9k7B7l1jHrlFpYcTj0UNxIX8qMZHGWLbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RrdmPQCR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3uaob2bthmoD71yPBoUZ0fqdQCtcAVh6XCaKnIyiGWA=; b=RrdmPQCRlb+l0KjxgfFjV2JbRb
	Svak4NWoVrjKyDquwHEuJdCu5CyVh4iVZGc2KanExjEVp/wYyW8YPc5Vz2WZZI7oOXSvIw05kawwm
	CWeiAZ09YizGwh3NRzXeeESiekkOnerCKiNWjVol735jtn0SJYTpLVX43d/BSBZCwNwmZqZrKBg0v
	XJcgfad1YV+xuWVWHdGCcktnE/vaGuj7O0abNg/CU+MO3pHeY3RQtMY/J4geExk/iYZ8oe32JKqej
	+NerJPzkdlx8mHrkQKT2cENogahfqu3dCbmugnLq74E3kMyMQzST3jQ7dzw5TCjVB0D6BA1Mmvb36
	WyOAANoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQbHC-0000000Cdqp-1lEf;
	Sun, 15 Jun 2025 00:31:10 +0000
Date: Sun, 15 Jun 2025 01:31:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] apparmor: file never has NULL f_path.mnt
Message-ID: <20250615003110.GA3011112@ZenIV>
References: <20250615003011.GD1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615003011.GD1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[don't really care which tree that goes through; right now it's
in viro/vfs.git #work.misc, but if somebody prefers to grab it
through a different tree, just say so]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/apparmor/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index d52a5b14dad4..f494217112c9 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -604,7 +604,7 @@ int aa_file_perm(const char *op, const struct cred *subj_cred,
 	rcu_read_unlock();
 	/* TODO: label cross check */
 
-	if (file->f_path.mnt && path_mediated_fs(file->f_path.dentry))
+	if (path_mediated_fs(file->f_path.dentry))
 		error = __file_path_perm(op, subj_cred, label, flabel, file,
 					 request, denied, in_atomic);
 
-- 
2.39.5


