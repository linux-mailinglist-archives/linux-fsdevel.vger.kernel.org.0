Return-Path: <linux-fsdevel+bounces-67823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F06C4BE31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FB8334A0CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698D23570C1;
	Tue, 11 Nov 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XqMCp+ks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214CB313E15;
	Tue, 11 Nov 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844134; cv=none; b=jAu0iFDFLw7kK2o78/GLK6KgMQqeFTsFz5FD5u6I1cwFSgKclmxH4Qzn+ysaDp7sLNfg25Zuzg3iPzEf2IFfn3Spt9/gZNXZSIo29RpvdH+dfBaUh9ot8hT87kMIq4uTqTNvPbj9vRApOL0JeWMJttDoqi78BkFyIw94kMeWR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844134; c=relaxed/simple;
	bh=WxSgeuo0ahJRBpa5cCoszsU7LKgd5x5Hzdw5+x6gsRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxqKaW7HBNcCxc8lGaHm/kM6r1x2XZtdZkATHdOZCBIMNqs3tk/Yi1VTTRNiwDF2z6A4pOmx3DQ76YqZhs1FMEu8tjlQIF0qTY5K+7Q70qt2gknNgR85Lon1ULS7Z1/fpiWgYCkTLtpYNLMj0+5HzpQ9YCnROkk9nh29UlEI3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XqMCp+ks; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eoHAGF5loUqH0LAFPRC8F4kXyPuIEz0vDtopK5rWb5o=; b=XqMCp+ksCwtHsAxc3vOlMm2BUc
	Crr7QM0NFZWC+h5EJiUX7b0C4eorZyJDxSelasJeNRilwOKqX1onn9TmLulW/PLZTAbTtuBBe9026
	IXlnGKv8naAwkRak7PIahFF/jhRL/KVz1lNDiwxRlkCfDrG2RoyjemrjuACPkd5lHVt49BDGwtaAS
	DlcF+c5z2DoUdglLan7F9XNJ9OH5AJ2S53oe8R3vudDUMMA1pdyGSpqAFireguyYxE0m907oc75Ep
	3HsdFESeGr7wgdHVftqHeVTX0VrtHc0zQWVSj6D1dLR1tjerFHNGzTpWrp3HD7o3YiPcxrvQQRDyI
	kxOdGCEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHl-0000000Bwzq-3whg;
	Tue, 11 Nov 2025 06:55:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: [PATCH v3 28/50] binderfs_binder_ctl_create(): kill a bogus check
Date: Tue, 11 Nov 2025 06:54:57 +0000
Message-ID: <20251111065520.2847791-29-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

It's called once, during binderfs mount, right after allocating
root dentry.  Checking that it hadn't been already called is
only obfuscating things.

Looks like that bogosity had been copied from devpts...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/android/binderfs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index a7b0a773d47f..8253e517ab6c 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -397,12 +397,6 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 	if (!device)
 		return -ENOMEM;
 
-	/* If we have already created a binder-control node, return. */
-	if (info->control_dentry) {
-		ret = 0;
-		goto out;
-	}
-
 	ret = -ENOMEM;
 	inode = new_inode(sb);
 	if (!inode)
-- 
2.47.3


