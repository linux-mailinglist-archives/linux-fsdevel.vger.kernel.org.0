Return-Path: <linux-fsdevel+bounces-22497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A905591812F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6432028C89E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3309E1836F4;
	Wed, 26 Jun 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="uVN+FEIs";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="NnIC+don"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB531836E4;
	Wed, 26 Jun 2024 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405801; cv=none; b=X/Vgeh6tplSlpvW34s7qY/OyI1XS2z35JeVpmadHQkXzr2qn6Wz4EzOo4WuUo8nIjryZ8hMP8dNfpyRDHIL+PeFPLk9MzC71Mu/GWDsoOZGPQF5SFu+0nqA8Nd82T73JKyb6irXmrDSn1nHqElj9sSusZbljXD6wvQWvr15zOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405801; c=relaxed/simple;
	bh=T4RL/LaDsoLP0wgzjIVv4qb2fxx3xQn9zdNO46Ml1pM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDfaP81Tav2C/5g/uHs2y7H4jsRPWJ5Oj+rz9R0QLPanhy8/cGvSbjju1LWwuRsj5aN6yUlb9QelYFKgBkG5mONXiq8PiPD7HXCHeWOpgJ3eBVGmYBYZ2seq8AA07LV1ts1h1n9cVGFQIxqjyFz1mRrxmwnPP8hJFh6NkX8A2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=uVN+FEIs; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=NnIC+don; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6992B2183;
	Wed, 26 Jun 2024 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405309;
	bh=G5T/DWgGyy0JYEwx2z+MTYgfegsEnXzgcF3ATMh7lyk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uVN+FEIsYN0NUlAnqUp2NUpe9/2yv49yrgJrMa71KyXeJ/uwaVJIMavOEPwCjboOh
	 otV4WfslvN+xqKux7AWw5zXXgQRMaxUKTJrygsybyle46pIRYN6i4mja6/UZuOBn6y
	 p6yuV4SJxvWFCwDwgATChiPnnUw24GX7ZuYlYVxQ=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 97FB93E3;
	Wed, 26 Jun 2024 12:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405792;
	bh=G5T/DWgGyy0JYEwx2z+MTYgfegsEnXzgcF3ATMh7lyk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NnIC+donSweliYx22gH7wVesNSMYRpX3k5Dj8aSDZVF2IRUFkY0vrhWjsPArwQxgG
	 Nhek8hYfpVTIHc/Gd7Rbxb5Knw2wvShz0bENNUTt6iuKigzTRoRY88Ufra81V2NiDa
	 83LIluo65FLATL8uXKNcCZg6kcGTGoMQwl1BsPrg=
Received: from ntfs3vm.paragon-software.com (192.168.211.129) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Jun 2024 15:43:12 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 03/11] fs/ntfs3: Missed error return
Date: Wed, 26 Jun 2024 15:42:50 +0300
Message-ID: <20240626124258.7264-4-almaz.alexandrovich@paragon-software.com>
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

Fixes: 3f3b442b5ad2 ("fs/ntfs3: Add bitmap")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index c9eb01ccee51..cf4fe21a5039 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -1382,7 +1382,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 
 		err = ntfs_vbo_to_lbo(sbi, &wnd->run, vbo, &lbo, &bytes);
 		if (err)
-			break;
+			return err;
 
 		bh = ntfs_bread(sb, lbo >> sb->s_blocksize_bits);
 		if (!bh)
-- 
2.34.1


