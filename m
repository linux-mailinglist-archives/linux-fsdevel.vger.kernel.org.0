Return-Path: <linux-fsdevel+bounces-35573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B059D5ED4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 13:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB45CB25099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295B41632C2;
	Fri, 22 Nov 2024 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yT1aPnOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5971DE8B0
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278584; cv=none; b=LvWVRsQM81e6yPHkVNhaHXyRldsgHFEq418OGmCz4D/U7kbVDSW8gf+bXOd+o+3kqdZlrxng345FmXhxvSIczt7R76Jbzzgf5m9FFNyBlazuxLUq5moMOnejioakTKuQfOyXnqtlrXWWragQtuyEZow8FjJZjCALaT18YAH+rp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278584; c=relaxed/simple;
	bh=eZ5WKfM4uXLvpp5fQk2DaUBE3onsEuICbZOaSfRMr8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=La/GqAjMFV1OdM27kK2Gaa7e3AlmZfGRJp6hOPOx1KI56jdfFedG7WHGh/0xzcHT4dFpYOCuKZkOVqTkrI40AD9D6QrRc94FLx4cwd+HzurRzgy6rmMDGEtQIu4+JE/AdFgB1CKlz+GvAL9rE0R4o9HaTcvN7/drHZLkEwzT6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yT1aPnOP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sUpEx/GPYxzOEapi4LUrINj1r0JfWvqFT1fPFxx0mvk=; b=yT1aPnOPhEUgTrC1ezGq5L9yai
	tUlio3ECrZWRofGRzhyDTLBlsAg4sGbKDEI4iIlAt+z6w1OwyaHSJFwBAm61vUfWs84cTx8KyIgDO
	S11AtVSMPsMoiRo6TtLf0WwVUNU4oueOR/ItwzSW4NvzSys/Pt3Vklr5J505qtiV+PCaRZtZ7xiF6
	PGCsDO+n9TH2EofjP2Yn1ujQFWrWxM4ObvTLKBpSSz9Bi4qCx9o3Cle1TbUc8OTQbZijYR99Ugw0n
	9yfUW0yP+olqsKHagBKj8Br3AhBXlE1cfejjJFtb7ZheagmAXnEqWOT3FWJ5tTJMsv2V6zQNP+KyX
	7fEbd1Tg==;
Received: from 2a02-8389-2341-5b80-6215-0232-ff10-500c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6215:232:ff10:500c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESn7-00000002SFB-3tc4;
	Fri, 22 Nov 2024 12:29:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: 
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fs: require FMODE_WRITE for F_SET_RW_HINT
Date: Fri, 22 Nov 2024 13:29:25 +0100
Message-ID: <20241122122931.90408-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122122931.90408-1-hch@lst.de>
References: <20241122122931.90408-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

F_SET_RW_HINT controls the placement of written file data.  A read-only
fd should not allow for that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fcntl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 7fc6190da342..12f60c42743a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -377,6 +377,8 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 
 	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
 		return -EPERM;
+	if (!(file->f_mode & FMODE_WRITE))
+		return -EBADF;
 
 	if (copy_from_user(&hint, argp, sizeof(hint)))
 		return -EFAULT;
-- 
2.45.2


