Return-Path: <linux-fsdevel+bounces-22494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20094918129
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE811F236EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4713E1822EF;
	Wed, 26 Jun 2024 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="OgaI0UQc";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="fuohsigF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481A17B4F7;
	Wed, 26 Jun 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405798; cv=none; b=tAoYwW+EojNWdDQYScBkf5dEP8r3joVuqiSab1vrtpQ0EVO+itIHax2y3IUzZLrVDQCqrcRpslYJjONuoy2XIRRaARzMRuLUlTzKFjKFIFO2yas9g+9FlEN8GMZLDfl9ZAoTeeVJU5hgteTChRZjN2VipFczHU8p6+FGlpAEQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405798; c=relaxed/simple;
	bh=2NCpi0/J0hUaIhSI/0Vodq1YR8gjKfFbK0nUYJMcaAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4v1qoTIZG+BOId77zHPufGLMqzdgiBEGsiof2yAtEdMufFWfbicVaLlBsrcdbLvuFD0OoCRAie4JUIau9GURuqcpaRmAW0zAp3aIXbBGnv6PVQdxkIBt+9FxC1AAhcmXO+Fzs+QN1Elrpctp8Jl2hkzbRh/pCWJy7LvsKyw4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=OgaI0UQc; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=fuohsigF; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6AB302185;
	Wed, 26 Jun 2024 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405311;
	bh=TmMx8AmiJS5CH/TSFmSJf+KP/A8tPO8bgD/92DWky5Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OgaI0UQco3vCPf5jHgTggeo43924ZjWe2wCc7RFf1AR19DPTZvDapnvTusG+mIbsa
	 p2Nd/aSSH+1T887VxMi1F+uzUF8GwOgj/WPhJCZ8HZa8DLWUy0YvPLM/+5n46uxe1N
	 3LnWTwzjBNjgVQuB/x0FuBix0EcEvY9WQLlqY+ks=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 996123E3;
	Wed, 26 Jun 2024 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405794;
	bh=TmMx8AmiJS5CH/TSFmSJf+KP/A8tPO8bgD/92DWky5Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fuohsigFo9+NOQilN1x44m6uL8tqkQExXSNSKT/kCNdRl09OawdzkN+AA5zDZF498
	 ovJnQAAo/dpy692ZJEwhkkMkrmmZKZCWtKvpkrooqX9oinJzeBV5vhmkbOlo4MoQFw
	 E/pjtumZ4iOWYmdJzlEw4NffN4nUrUdbTqLDau0U=
Received: from ntfs3vm.paragon-software.com (192.168.211.129) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Jun 2024 15:43:14 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 04/11] fs/ntfs3: Keep runs for $MFT::$ATTR_DATA and $MFT::$ATTR_BITMAP
Date: Wed, 26 Jun 2024 15:42:51 +0300
Message-ID: <20240626124258.7264-5-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
References: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
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

We skip the run_truncate_head call also for $MFT::$ATTR_BITMAP.
Otherwise wnd_map()/run_lookup_entry will not find the disk position for the bitmap parts.

Fixes: 0e5b044cbf3a ("fs/ntfs3: Refactoring attr_set_size to restore after errors")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index e62a8fee5250..1d63e1c9469b 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -672,7 +672,8 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			goto undo_2;
 		}
 
-		if (!is_mft)
+		/* keep runs for $MFT::$ATTR_DATA and $MFT::$ATTR_BITMAP. */
+		if (ni->mi.rno != MFT_REC_MFT)
 			run_truncate_head(run, evcn + 1);
 
 		svcn = le64_to_cpu(attr->nres.svcn);
-- 
2.34.1


