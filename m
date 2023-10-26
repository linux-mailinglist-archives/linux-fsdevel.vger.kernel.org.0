Return-Path: <linux-fsdevel+bounces-1218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D327D7AD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 04:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41DAFB21345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 02:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAE7BA25;
	Thu, 26 Oct 2023 02:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ovwv1aiu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5278C11;
	Thu, 26 Oct 2023 02:21:18 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFC718B;
	Wed, 25 Oct 2023 19:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=oXOuDkadsHdiYyK7tGohGzYZ8myugwNQ18xV61iZdGQ=; b=Ovwv1aiuReE2N/V/h/pLeUuNPC
	S6BCKdeicCxuQvsGBeMLD6HBd40xLezQ8arKZpHx/s/kGgKRseekWWeWjmtT6vpPTZE0+ZUfCxECo
	V+evCsGq39jbzoQEooW6RapIypf/2hs/Lg8gtUSQ8E/69xWgG02crtcq7ABMSGc/9zTUE0oHsm98U
	omE7CiaC/qwpgGRlKf300wNrnD5pptrOoILWdki4Qper+YTcXbpSkBFdZsH6nTSL8zJ7MWjQKyGbz
	7rHy1jgyfDevNJROMa8hE9aYCuzs3u0UeLUk+Fvt0g7Kt8Mb7ChYuVQoK11CG7HyEwEK+tlHKABNe
	n/po3wRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qvpzn-005mne-0f;
	Thu, 26 Oct 2023 02:21:15 +0000
Date: Thu, 26 Oct 2023 03:21:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xiubo Li <xiubli@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [PATCH] ceph_wait_on_conflict_unlink(): grab reference before
 dropping ->d_lock
Message-ID: <20231026022115.GK800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[at the moment in viro/vfs.git#fixes]
Use of dget() after we'd dropped ->d_lock is too late - dentry might
be gone by that point.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/mds_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 615db141b6c4..293b93182955 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -861,8 +861,8 @@ int ceph_wait_on_conflict_unlink(struct dentry *dentry)
 		if (!d_same_name(udentry, pdentry, &dname))
 			goto next;
 
+		found = dget_dlock(udentry);
 		spin_unlock(&udentry->d_lock);
-		found = dget(udentry);
 		break;
 next:
 		spin_unlock(&udentry->d_lock);
-- 
2.39.2


