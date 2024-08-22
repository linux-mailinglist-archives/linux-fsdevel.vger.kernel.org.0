Return-Path: <linux-fsdevel+bounces-26803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BD595BB41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B852854E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D8E1CDA23;
	Thu, 22 Aug 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="uaECYrlz";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="mDMv9YYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01C41CCB2D;
	Thu, 22 Aug 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342492; cv=none; b=gGa6styn39+Y77CtXmRcre93oX7JKgt9tRVyIUR2hG7dtn+hYB7qOlQfnshXY6cB8MWfddphIV+s6HDmazNIGLpXNifn1uCwx4PPER8ZIDrAcncwomz9bQUzwEQJQfI+OA6TTVa9dLyiBE6tsul8rPXk6hfhx5IOiS05YbXWdWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342492; c=relaxed/simple;
	bh=wCDuVp6/XQFN/q3mprog83EJ97e7rjcJSy0xbKK3r0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvUTnCZiDIajTUBfahyaQZZDGFMeMgQiV8dpxqevhk7giyPjp2P63zQg+dxFHzaPAZqk9A7+Q/hhuD8BHzF058q3CktaGFiwocL1V6mmxaJXWHwmvArmsCHuclAojU+gijEkHT49045TnBfaxSCHDG3cgIUcYYqBge4RbCR2xyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=uaECYrlz; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=mDMv9YYJ; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 4640921D8;
	Thu, 22 Aug 2024 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341464;
	bh=3eYspw7lIl3J5RuPbwKS78VL8yfSiOQUzbX1nMit9uk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uaECYrlzii4jHTdSYf49MXIjthS+dFXa8LTojNebykv5QAaa1vKzvrxDiJCkFc/tk
	 RA2GBk25kZtFMw/XKh8mhUaVtPBZiF+HNKj0C4UFxbtrG9vTZIqBHDubEf1qLmhuHC
	 8OdVm70YAGn9DGDUjK2FbCIdXc7sy5yymXU0FfOA=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 7078A2215;
	Thu, 22 Aug 2024 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341940;
	bh=3eYspw7lIl3J5RuPbwKS78VL8yfSiOQUzbX1nMit9uk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mDMv9YYJywmZKb+AfdAXSMd1wUiRmdXZmjayqYV4ZvvP/txH2TlV+8PbahJkInDUI
	 for9ELFDKZ3HmUafekOgNQNubCC1Ut8bIlSHw831GIoLS50Gvp3cM4TOWP10d5nRPj
	 YPnPVAejAnQB5Uf14ppxdSwK9H6OKs0dHCGOG8Co=
Received: from ntfs3vm.paragon-software.com (192.168.211.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Aug 2024 18:52:19 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, kernel test
 robot <lkp@intel.com>
Subject: [PATCH 04/14] fs/ntfs3: Fix sparse warning for bigendian
Date: Thu, 22 Aug 2024 18:51:57 +0300
Message-ID: <20240822155207.600355-5-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
References: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
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

Fixes: 220cf0498bbf ("fs/ntfs3: Simplify initialization of $AttrDef and $UpCase")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404181111.Wz8a1qX6-lkp@intel.com/
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index a8758b85803f..28fed4072f67 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1491,11 +1491,10 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 #ifdef __BIG_ENDIAN
 	{
-		const __le16 *src = sbi->upcase;
 		u16 *dst = sbi->upcase;
 
 		for (i = 0; i < 0x10000; i++)
-			*dst++ = le16_to_cpu(*src++);
+			__swab16s(dst++);
 	}
 #endif
 
-- 
2.34.1


