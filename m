Return-Path: <linux-fsdevel+bounces-62556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648BBB996EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 12:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254F03A7E58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D652DEA99;
	Wed, 24 Sep 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SwN+js/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F212DE71C;
	Wed, 24 Sep 2025 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709782; cv=none; b=EPf/9YttXd3Ye2KHeHHlyUeIvmboyM8O37xUTEAxRAqo05JQKSHZld4lAu8xv8Fp873fqUXXFzIn5mNpXcLrlR6JHZakUqF+2sH5G6OcPCs/l6QVOAxIQLOKu1iX+ecIDdwwxRRxJHXsnTHut/iTSf48fcy4IPHN3ONwVnBzp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709782; c=relaxed/simple;
	bh=5378062ERny0wNEuMYTcyfgw6fPRno0BSo9s7ZhXL74=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=h7GRcA4ghGLibJV5Q0ep6/PdM4f6/ET7IOrBAf1TxpAja4G2jMblqFmpGUM9l0Y0DzRwO/SDwlXd7SE+J0Z8ZIzmtnK7hb0P/a7bfyar7aZJKJgCYB2U9XSOc30G/MUvL6/morjeHqQkbPNYWRhPsi3Z0m3cPIc6b6Aj3A3Tll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SwN+js/L; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758709768; bh=OPtaBmTcHZe7P+jP0ca1ZQLuI6ONmJK07D2B2RB7mSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SwN+js/LMFoS43utuyNXRo5oDVVwwYKaQQBMHzvyOCb+ePGsX7aQyymqnuAy9cuXx
	 YBOqndIn+kSIdhC0TPw9KUZcUZgHn8LOpkMNjcYA2hljPVQgnWw5FDsbe7b5IsYOk7
	 WCmODnE3GpIJ1E8GPX1NrXEfJ/V6iKIfhCSbxI/U=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 745ABC10; Wed, 24 Sep 2025 18:29:05 +0800
X-QQ-mid: xmsmtpt1758709745tz01q0y7i
Message-ID: <tencent_2396E4374C4AA47497768767963CAD360E09@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeCi4xUUsj4FPJbk7CZep/+Kn9vmgFMkrE4rGYN1vUDncCsqC/sK
	 qqewPK9XyM0B9SBBt4CXfACd/0ckraDF6bQRU1gBaB5QkD5PjapcKGfCvo2pCzDphXQxwv35UmNt
	 yrpJ5blVOTLLm0HNoFrc1gJ00hGr1irnk+LQy1IkjAZcv641KyBoIo7ghQInxzFhQiUd0hYU0WnC
	 9GrAGOcZ3gfQsqlFSCJmrruOb2LPoz/SoN+qgFHfoKMLJY7sjHQL6CDGPFv2fVNmBSbRK1pn/1tj
	 N6RFbexpRUUbBb2DEgIy9y04JyABME7TLUzit8jSWdFI++5w5or8RSb28D7/B4eNSlsKVEv4bDi9
	 I/34SHs+1+EQj9KADlkhSK527tiXuOROUgQZ4XSklnBJeeS8narFrhK53ArrHH8iDd4XfS3bY3La
	 5Cqklhx7+96bZ9SsxmTbwWHeHyln3D3C7NxgjAAtQV9/UrAxA3C/Lj5r6TC4fUgcZzjFzSejk/xe
	 jjrsQzDNqC5lvFiPnyw64+21a/ks2JshvP9P6Ih86BTjztP1TuH5iZT0yfCqmrzBdtVMkSW3wfPx
	 3Uw57Coo8API2S7lm1rrVJSkU8WPYvwiv22uyer99bE1jr2ROKMYirNw37JRdTTLNZX2ZypCEt7K
	 UysHiHDd3Hzn3WBIPKa6GeqTQ9hwiTgEH2EhTCMUvJRl5hcRVQiSTiznvQgN3DperkhcOHTn7Wnt
	 YUkfmBcNnSjoF+RahZK8JLvOrEUVx52yYvAebSmMoXgUzhwp9gHC5a62ZELs1ZY/pqZnsQkQwCIj
	 CQLJL634Bw/01gffNPC0QgeY9xqWMo90B77pyLfJOY3Tj6BryeMLuAvbtq/YGuCAMu9b6Yi3hBlK
	 m19kGIMmF9ncftRg8wzbnWAZFfK4btWhQmRUnBKZFp4OPBfnw3IjQOhqGHtrBb+0RLeq5Ejdc2kp
	 yMFgxlvJKo6HTO/yPJrqosSXu88/kgZmzZcouYy62Xn2fJ2fmnHRCynx/9Hyo7wx9AdiWov7svq6
	 4SZqOQok5B1WKLDa003mx2kr8HUo4=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH Next] copy_mnt_ns(): Remove unnecessary unlock
Date: Wed, 24 Sep 2025 18:29:04 +0800
X-OQ-MSGID: <20250924102903.1493869-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68d3a9d3.a70a0220.4f78.0017.GAE@google.com>
References: <68d3a9d3.a70a0220.4f78.0017.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This code segment is already protected by guards, namespace_unlock()
should not appear here.

Reported-by: syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0d671007a95cd2835e05
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ac1aedafe05e..c22febeda1ac 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4134,7 +4134,6 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		emptied_ns = new_ns;
-		namespace_unlock();
 		return ERR_CAST(new);
 	}
 	if (user_ns != ns->user_ns) {
-- 
2.43.0


