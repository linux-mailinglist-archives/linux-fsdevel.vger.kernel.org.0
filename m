Return-Path: <linux-fsdevel+bounces-17520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9D48AE9C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA011F22BF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE1713BAEE;
	Tue, 23 Apr 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="HibwSwcl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC613B5BD;
	Tue, 23 Apr 2024 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883429; cv=none; b=XcEv/XoOdU07Eom5mK4qhKlvWQsaKCpCkdc6C1cMOzCwL5nZ3J5PooxiumabvMfLFO+EvkK2sllf05BBiO8I0aM/6BVERUm6CqYgVk5LYUMcTn0vTavqKd5owvCx4qMPput51nl64rBPyzRX3gMeVuC2ITl/t99CmAmSjzv0KG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883429; c=relaxed/simple;
	bh=XjKJ9cLPbWFBOZsNXXBPcqV1Ya2McS+Q6Xy1f/KErb4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=prYQEmsrQ1SO4kwurutUyFCaWofvIZZv0f4NNrjDdHHXwOk7PFh+ELosXZvGkGlTOg0Jg7rJSktW1cDwZaLpAmuXDJjPsW2+JV8YgigeQ7BJNZKfJiPhzeSrnaUkA8ZUgZhIztk0raFes5c+Qe/uf11UwyaZaUwd3JN42P8E0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=HibwSwcl; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id DED952157;
	Tue, 23 Apr 2024 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713882973;
	bh=GXL3SuBTg6ZAty/153VtafEhziwahLcJ1d1KPZtrhV8=;
	h=From:To:CC:Subject:Date;
	b=HibwSwclvfzATE1ZEDcDLEJYjfTqDbxR/4/MfXUsakjGbpnr5bNoWPk//0Rd41j2E
	 tyIVRPpfyY43+wjFUnXmIHm25ZV6CVncxqC62wcq5SkRJzPc250uEA5YJGrbqiDKmO
	 4hJ1xZV2v6DbeaAUHWNZ3ZMNP6xNNBNDAwMahF2s=
Received: from ntfs3vm.paragon-software.com (192.168.211.186) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 17:43:45 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] fs/ntfs3: Break dir enumeration if directory contents error
Date: Tue, 23 Apr 2024 17:41:55 +0300
Message-ID: <20240423144155.10219-2-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: stable@vger.kernel.org
---
 fs/ntfs3/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 5cf3d9decf64..45e556fd7c54 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -475,6 +475,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 		vbo = (u64)bit << index_bits;
 		if (vbo >= i_size) {
 			ntfs_inode_err(dir, "Looks like your dir is corrupt");
+			ctx->pos = eod;
 			err = -EINVAL;
 			goto out;
 		}
-- 
2.34.1


