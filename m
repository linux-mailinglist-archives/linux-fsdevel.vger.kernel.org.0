Return-Path: <linux-fsdevel+bounces-71121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2C1CB617C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 14:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A26A4304EFCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE0278E5D;
	Thu, 11 Dec 2025 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="A3kE4blt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C31238C03;
	Thu, 11 Dec 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461098; cv=none; b=mXS5L/hviBnT48kuawXeGnN20S7rm5J+P0dR/E2K2bQr2pZLWgJRjQbeT0vPL23oqBGqWFCfoS+MbnlKA0uHWBmy6UC8P8LQItvjKl4iim1fYUmU40seuSGuBfnRO36M8+ujxcM/qSA9HjItrRgaAgj8sz11Pmoyvyai1cIsd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461098; c=relaxed/simple;
	bh=0jMaZksR1pU8HeMDHXj10RAlzP+w1jsuZ6YB+Nl4hK0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X482Vtf7QvIOupDwlLUArsb6e8MOX/EC5mPMAFi9mntFQ5Z+NM1ZKMCX6FlYIKtSW0FEBVZ2VRMdaYqxM/U6yJHy2jSFjMObLN1+Nir5XJ4mup/gGyxwV1lQ7D9oJBmeMBzidM2gVfKqZCsc9CJGBKPKeCiUE1Jof0DRG2fwRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=A3kE4blt; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 343421D99;
	Thu, 11 Dec 2025 13:48:05 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=A3kE4blt;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 41D9D3AC;
	Thu, 11 Dec 2025 13:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1765461095;
	bh=sfDYmHiTzYoSQ1ip2WjSnpCHc186W+aq+sQkz9vVVWU=;
	h=From:To:CC:Subject:Date;
	b=A3kE4bltrTGWubDGIlsYa+kU0PBJocXWUCDwmEApxZhbTNjQpanyZyNEpbufhVGsA
	 Q2vGgdKVSQolC/l4O2DAR0+gpHRdk0bg71d1qBvLGU3oSW1Ve6CAtZ0RfULrqOcyjE
	 jrlmkW5J1WtOpNJHERHUL3bu3vWPDuCmIpokoGyY=
Received: from localhost.localdomain (172.30.20.154) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 11 Dec 2025 16:51:34 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: fix memory leak in ntfs_fill_super()
Date: Thu, 11 Dec 2025 14:51:26 +0100
Message-ID: <20251211135126.13965-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
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

ntfs_fill_super() assigns fc->fs_private to a newly allocated options
structure earlier in the mount path. At the end of a successful mount, the
code set fc->fs_private = NULL, which prevented the vfs from freeing this
memory during mount context cleanup. As a result, the options structure
was leaked.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index a641d474c782..38d82e46171a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1252,7 +1252,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 	}
 	sbi->options = options;
-	fc->fs_private = NULL;
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = 0x7366746e; // "ntfs"
 	sb->s_op = &ntfs_sops;
-- 
2.43.0


