Return-Path: <linux-fsdevel+bounces-22495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C19A791812C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0041B1C21BD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0D9184117;
	Wed, 26 Jun 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="M1uGnz15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111331822C5;
	Wed, 26 Jun 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405800; cv=none; b=V+ny8becwWFoX1Bf7ZQH8/Tjh6xo3lyxkpnJ8TJ1aB5whHJTcprVkf1gncteW9/BwEII18tJfJkJM+X2CxWJoVO0LTPPhQRy9ydZiBzaVQpsCarx/EYcV3wtxOCNOm8JzP9ciRN05KeNYoQ6F3Oac3gjSZaF0Sgo2kKILOhw/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405800; c=relaxed/simple;
	bh=xnspFLhiX242Ff3TR/uHTTxqz63zg/xnNK2QZEDyBOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upbLrDU4yGuvo1rv89wi9/Sp517OvsHibQFEHOm6E1QTrw9i0yB+PrhGIJQUuuHLjkP7o9cQYGT/+WoZeZ98yNb5cGYco85OcvsT9VkB2uS6g9Pk321YEi+wOVkQ9l5YgIXDh6J8RpuxpE7v5UdWwbFUMKKvbqljtivgZWOE8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=M1uGnz15; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 341D42181;
	Wed, 26 Jun 2024 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405308;
	bh=cSnqR4uOwrhFZmxk8fE+225CzSsn2Oh11/w9ccfMRuM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=M1uGnz15PXvnTcLDwYMwGqI8EjFTOm1Ut1zPXaSaSmMMLJVFsj/dZOkjdUi7UwucD
	 HB4lgC4rZ7me4weWVRe18CvxaXzwcr/kwusRRWHPJRiaoH5ro2XHW9x7pvhkwkMbJN
	 mUU0cctcHpt21zV/9Iwf7TfIs3b8dw0iRrLZAEsQ=
Received: from ntfs3vm.paragon-software.com (192.168.211.129) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Jun 2024 15:43:11 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 02/11] fs/ntfs3: Fix the format of the "nocase" mount option
Date: Wed, 26 Jun 2024 15:42:49 +0300
Message-ID: <20240626124258.7264-3-almaz.alexandrovich@paragon-software.com>
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

The 'nocase' option was mistakenly added as fsparam_flag_no
with the 'no' prefix, causing the case-insensitive mode to require
the 'nonocase' option to be enabled.

Fixes: a3a956c78efa ("fs/ntfs3: Add option "nocase"")
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 5af07ced25ed..c39a70b93bb1 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -275,7 +275,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("acl",			Opt_acl),
 	fsparam_string("iocharset",		Opt_iocharset),
 	fsparam_flag_no("prealloc",		Opt_prealloc),
-	fsparam_flag_no("nocase",		Opt_nocase),
+	fsparam_flag_no("case",		Opt_nocase),
 	{}
 };
 // clang-format on
-- 
2.34.1


