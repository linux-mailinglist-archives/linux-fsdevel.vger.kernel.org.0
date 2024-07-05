Return-Path: <linux-fsdevel+bounces-23188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF6E928387
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 10:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9312822C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E37145B11;
	Fri,  5 Jul 2024 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pDeUOnfX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C54F2BD18;
	Fri,  5 Jul 2024 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167463; cv=none; b=AGWhhPCEDr5dP99ZtJ7W49Zlri0sP3tpIlb8tNVXHC8kLfzMxoWt4blYHzLc9HDmtYpCsZKQKSUX96DKqcUx+dPykq7Mx0nKoxY6mXLVB93N28IrDyytPnzEtJjmgjd5SgmLFW6h5U+rZ88Bb9JIdQWTRyXhEqWZM+oQJVC0DDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167463; c=relaxed/simple;
	bh=Z+8whFJ3grQJ83XKO0yH93uOiE2mwA7zhToEaEIWdKU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U6VMzcCB3yK/Fz6ZBJzrSrpaTXcyefRQBbp/zjGyojrjgMXPqdw+e1VAiOg51ZINpZiB0FytOZWI2wdIqi0tFfj+Nmm9vBpJjU4DTKPvnl6zK0AXcx1ydiHL7DHiygYROv8CyW3htW08zro1ZX0UlQFWs3eQH6OyFlR+GwCgoF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pDeUOnfX; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 095570ae3aa711ef8b8f29950b90a568-20240705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gHtQXoO3gkfXq9fecupWc54bImQ5r1jPbo1pnWk/lX0=;
	b=pDeUOnfX4wQ0qI9P5tV2NfM/sRga4RJT+vx3MZIeMxT63woIuRHs3Ftylr1EojqWc3PQq2yxKvqxgjDCGSvmVoXEAzUWRtFJp1c83n57IK/IVAsA5eLKR6ofTkvSo13ixtpghYgYrPB7fY98+uqnJMa1hj4Ol11vOOYF6lUts6k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:0c23b54f-8060-46ac-9fd2-a6cd5cfbb233,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:ce6a20d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 095570ae3aa711ef8b8f29950b90a568-20240705
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 106142935; Fri, 05 Jul 2024 16:17:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 Jul 2024 01:17:34 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 Jul 2024 16:17:34 +0800
From: <ed.tsai@mediatek.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <chun-hung.wu@mediatek.com>,
	<casper.li@mediatek.com>, Ed Tsai <ed.tsai@mediatek.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-unionfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] backing-file: covert to using fops->splice_write
Date: Fri, 5 Jul 2024 16:16:39 +0800
Message-ID: <20240705081642.12032-1-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Ed Tsai <ed.tsai@mediatek.com>

Filesystems may define their own splice write. Therefore, use file
fops instead of invoking iter_file_splice_write() directly.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
---
 fs/backing-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 740185198db3..687a7fae7d25 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -280,13 +280,16 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (WARN_ON_ONCE(!(out->f_mode & FMODE_BACKING)))
 		return -EIO;
 
+	if (out->f_op->splice_write)
+		return -EINVAL;
+
 	ret = file_remove_privs(ctx->user_file);
 	if (ret)
 		return ret;
 
 	old_cred = override_creds(ctx->cred);
 	file_start_write(out);
-	ret = iter_file_splice_write(pipe, out, ppos, len, flags);
+	ret = out->f_op->splice_write(pipe, out, ppos, len, flags);
 	file_end_write(out);
 	revert_creds(old_cred);
 
-- 
2.18.0


