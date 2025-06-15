Return-Path: <linux-fsdevel+bounces-51681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ED0ADA110
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 07:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0421F1891F4C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 05:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0899E2367D5;
	Sun, 15 Jun 2025 05:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lhkjwzA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E2F522F;
	Sun, 15 Jun 2025 05:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749964296; cv=none; b=RBvTZzUOUfp3GsAbhmnRPMHBi764NOPMVlCHON+edewEOjfJAbi6TSRM2mLoQczG7zCFbJC+ci5IHBVBFZA2K0Jljr+MzvUOWUnw72MHKLbj732SRejaLUga9ysxj/yUI6+e0RPwsscuItnct0r6K3D3eYIL2vyeVfyix/2FULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749964296; c=relaxed/simple;
	bh=lVOGH0hJEV1XPPYnyDcGzY+njO3iZlSMM5nAaiH2wVM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DSaDZ5tiyiherOJW7ZClsLns7sx7PplX2jKg4sPfaw8GgYvDGggBGXPcSw4i7+utIGB+PkUZom/ivxyat6UPZnTH5Aw55v79btTklqbwX+naYCq4F7oFXGJ6QbMQnrMJ0OG8QtSQSEQCwFpNah350KfuSDuAkmgs4Qe+53wQSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lhkjwzA9; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1749964281; bh=d5TyK4yx0XBWBsINgoNisr8SuMCID+F1Z6VSjQfI+JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lhkjwzA9CeH8QORHru0r9vIgBpL2FODhGDAAzIrNq17Uksq4Urc8HJxTiQMFtUWk2
	 yMjHIU8sebXVdQvKZ54R+stiaaZw/c8eyHa2+Bt91qTVTevN1UiTAHyzgZ33Xc/tNG
	 JTdD6BtUXgvvBRgpo3ib50ul9BsTzOyUJKgmcbM8=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 148A9EEF; Sun, 15 Jun 2025 13:05:08 +0800
X-QQ-mid: xmsmtpt1749963908t7ag37dfo
Message-ID: <tencent_15B5C44A7766B77466C6B36CE367297EA305@qq.com>
X-QQ-XMAILINFO: MK3JR/K3P3T7YGLsROEKh1Zzhhimt0j3e7IXLnaz1nMYc7GnEjB3LLPR4Le8sZ
	 8GY93cyBCIw8BYbFm0Dj/OcZsPQcVQe6sf7TxkdyOD7Mybybo+EMR8oiJgu0fRDUWdlrndwSY3/L
	 Icyy3Jjl34Qgchf32/HleZ6Dft6NNgZ28pCD9L+mhb3v88A96d3yjequMYjueqcsDoozlgy7L48B
	 WqqmjJJo9Zqvb/lx1kxFAA2OuXFma7T7cXa8bjstpztQHDJ9tmgAz7k9iFaTmwt9hxFIqPyrzAyL
	 D3A0Lwp1r1TcwST+TB54dDUDoDufpeh70ut4RwJiADcUTRojYuNx3TxgpE+oHjd3YT05hD5PpTdT
	 WV9+nxBjHEvIA4pOwLex7lEohR1ChNg0TcDWYt1kzv1wLQNNilpQ4L94TfYSU9q0l+W0k9FaUYV4
	 33HhQVh5wxyM3P5rObPXShdSth9t5u1ZhtxUsrpJIE/lmUiv1TMaJombZKYBqoO3H5bCXhZ5AKHV
	 NqZ39q7A1LbRlHf1dz+urZ1Y+V+hK++Qb5oUNdaUEQNSfDWWwq13EaOeFd2Q/8eA66E/kiM7Kme4
	 P6X9qwqYASdBU/I5UMlSNxWXSHuDnrdFobJgcznc+8xpB6j8dvnC7pHuTdGV/uwWSype81HQkIUM
	 gqyX+GNmo/jqa+2f9JPpz/UPitbkFMF/llbzSE8d1QuW79j1OJr27CGN/TGBxaX/iSgHJCpkSrz9
	 v5yV417QEQ7ZhU0jdK04KaZMwoY0NuVEfxXAEMa4QnUMHylH1uaCPc0CzWJTH0mapqkCItu8wNl7
	 jLvH13dja759qynTlSowKMwCDh9lzcolZcNzb+61KoUruIL/faf/YsaErPgCR9mxmWN9WTDlDJom
	 eek7p8zL4EzdIknUVP8qOmZ+PcOihHIu1ifDnV6SF2S/ePeiv/lvc7GCo7pp3+KNCc6qvFkU6Io3
	 YxKHcFGuoXYff1AXXY7cyWC051z8N8CWP5m8auZlqtw804EmJAgR3emc5q5+mU
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	chao@kernel.org,
	djwong@kernel.org,
	eadavis@qq.com,
	hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	xiang@kernel.org
Subject: [PATCH] erofs: confirm big pcluster before setting extents
Date: Sun, 15 Jun 2025 13:05:09 +0800
X-OQ-MSGID: <20250615050508.3722289-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <684d44da.050a0220.be214.02b2.GAE@google.com>
References: <684d44da.050a0220.be214.02b2.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this case, advise contains Z_EROFS_ADVISE_EXTENTS,
Z_EROFS_ADVISE_BIG_PCLUSTER_1, Z_EROFS_ADVISE_BIG_PCLUSTER_2 at the same
time, and following 1 and 2 are met, WARN_ON_ONCE(iter->iomap.offset >
iter->pos) in iomap_iter_done() is triggered.

1. When Z_EROFS_ADVISE_EXTENTS exists, z_erofs_fill_inode_lazy() is exited
   after z_extents is set, which skips the check of big pcluster;
2. When the condition "lstart < lend" is met in z_erofs_map_blocks_ext(),
   m_la is updated, and m_la is used to update iomap->offset in
   z_erofs_iomap_begin_report();

Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Reported-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d8f000c609f05f52d9b5
Tested-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/erofs/zmap.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 14ea47f954f5..664611cca689 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -686,7 +686,17 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		vi->z_tailextent_headlcn = 0;
 		goto done;
 	}
+
 	vi->z_advise = le16_to_cpu(h->h_advise);
+	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
+	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
+			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
+		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
+			  vi->nid);
+		err = -EFSCORRUPTED;
+		goto out_put_metabuf;
+	}
+
 	vi->z_lclusterbits = sb->s_blocksize_bits + (h->h_clusterbits & 15);
 	if (vi->datalayout == EROFS_INODE_COMPRESSED_FULL &&
 	    (vi->z_advise & Z_EROFS_ADVISE_EXTENTS)) {
@@ -711,14 +721,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_put_metabuf;
 	}
 
-	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
-	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
-			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
-		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
-			  vi->nid);
-		err = -EFSCORRUPTED;
-		goto out_put_metabuf;
-	}
 	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
-- 
2.43.0


