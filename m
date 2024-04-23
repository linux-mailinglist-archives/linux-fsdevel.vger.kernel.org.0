Return-Path: <linux-fsdevel+bounces-17464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EC28ADDA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6576B20B35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 06:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B8A250F8;
	Tue, 23 Apr 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="hJX4aZUA";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="SvZZygVO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F241A94;
	Tue, 23 Apr 2024 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854714; cv=none; b=bqO5PuwcqRpmfb8YMyrwt+CJGMLHVY62EW4dCOyAna6h7ZsoxQz65B5IJtrymkwJRQk57OzUqc6as7ir7lqVMQhXqTZ4Veos/Y+z/lBjaAEgh+j9AoCCl+AyWOjewYzFuMSpfTONeExP+db4x6ZphOkOsu7otwMBCG6/uuaqX2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854714; c=relaxed/simple;
	bh=FEFl4Wn3CE2UFGs9JOKQSkukkncytot6qPwH1xm43u0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSwC9b9sMccazTMRj0vgRGcBE7T1oizU61b9+b8XxJFuz82zASsElrmRSx1BLY/JFkr/ziH0nTRXLhqiGvU8Sduz46KAT4BrluhJPwpJrcDNbtBgCGs3W/59sZeewTCup1N1juBhQ95mVSH17myNpKUKMdEXPr+cyUldN56WGys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=hJX4aZUA; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=SvZZygVO; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 2E15A1E80;
	Tue, 23 Apr 2024 06:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854259;
	bh=XNDdOBfydzO5hUu6PPstrbCwKxTzEdjYBc1BzGfVFsA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hJX4aZUAamhX5HafEIE3qIXTnph+X3oTbwTEAIU4kVtqKv9qTIUhWwP6xPD9jOevL
	 WwEr0H/RhPCPz+/0HsecmXvU7XQs/lA719P6l4le6M28Dgn3l7z/nUSeqdn5clqKN+
	 ZEQlx5HwTOn/zuG13A7L0IolqH9e1IUTw8wOxAy8=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E73E1214E;
	Tue, 23 Apr 2024 06:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854710;
	bh=XNDdOBfydzO5hUu6PPstrbCwKxTzEdjYBc1BzGfVFsA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SvZZygVOMyZ5cYwrFSW7qsBghW9MufpU1dho+8vK8MpZ9fuLo8LxWTbNXiswHrJEB
	 xdwpfMWNkYn0l2bXfpHPvrP9tKDQ8rVm9GHCp8GOL7gcU+h9bgU/Ie6gKNCUq/CR7/
	 gW7QrOp2hl9le3/GFw10Kqmm/02nIzZR3mEwW+w0=
Received: from ntfs3vm.paragon-software.com (192.168.211.160) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 09:45:10 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 3/9] fs/ntfs3: Missed le32_to_cpu conversion
Date: Tue, 23 Apr 2024 09:44:22 +0300
Message-ID: <20240423064428.8289-4-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
References: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

NTFS data structure fields are stored in little-endian, it is necessary
to take this into account when working on big-endian architectures.

Fixes: 1b7dd28e14c47("fs/ntfs3: Correct function is_rst_area_valid")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/fslog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 855519713bf7..d9d08823de62 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -517,7 +517,7 @@ static inline bool is_rst_area_valid(const struct RESTART_HDR *rhdr)
 		seq_bits -= 1;
 	}
 
-	if (seq_bits != ra->seq_num_bits)
+	if (seq_bits != le32_to_cpu(ra->seq_num_bits))
 		return false;
 
 	/* The log page data offset and record header length must be quad-aligned. */
-- 
2.34.1


