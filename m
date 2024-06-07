Return-Path: <linux-fsdevel+bounces-21178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B477C900333
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91671C233F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E9F1946AB;
	Fri,  7 Jun 2024 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="d0NqXQm8";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="gjneoprT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AD1194097;
	Fri,  7 Jun 2024 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762578; cv=none; b=n+Fh4fARLG/hrQYW2vCJwdxyO8aI+9Cnr1rRNec4dt4iLddlGs1YEQp12mEakdjjAajwuKNs706p+AHCs7jv/qiNYPaCIgFaYGzKh3+Ovrhj33QT5GVkq4WkP1bBhROFl2eKKdQFapbQyW2O2h/ut/7ZtkCflqbv39e05widMa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762578; c=relaxed/simple;
	bh=IDXHPwZU8zALb1dVj+JDa36NpI0ML5BFBX3jkG325/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnZrmYe1GzV1nCK9VCpfAxAHWnezf9XNi4HY7QW27DcpYFYh0VGmycog/lAsCvNB3TXR4ggAiJEbCH3I29LQi1BT3QpmFkI7VZl2Zvv3apSb/z0UlyN/7hSGhsJvQsJt0/SgW0DYMnRcyDRKpC6faJfaN4Kh/vqOG35JydABnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=d0NqXQm8; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=gjneoprT; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id AB2B82111;
	Fri,  7 Jun 2024 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762101;
	bh=PLpDTAuPwmuChFu88p0R105H1Nq2kjyzVIh/lCRxU/o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=d0NqXQm8xE9HOFVsrLG3Get/cSsSj8NgwmTSDU/xfWAZdWUQvVkON2RpV7gm3Oq6X
	 JVhJxVhRAc0xL/rrpWQUioDlo8VXCpXMetDn6Mxh3Tg3Xne3AW54o6xQoqoiSpmJf/
	 8Q3MErrOEjbPXcbURZpN7laQZsawHyjDJc21JUO8=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8F170195;
	Fri,  7 Jun 2024 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762575;
	bh=PLpDTAuPwmuChFu88p0R105H1Nq2kjyzVIh/lCRxU/o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gjneoprT4AtPMhX5ZWsjtz8G53BN+Q83iGi3BygDP76xjPkRZHxhWFzx7lhnGV6b2
	 OUf6QBh8QupsJ5vJEuDI0etPzGA/JIna0xEtefyJ8UQKzH1jtpJhzhhrnWreXqj6rm
	 lhJ6zftyV5mLv6siZXuRUzCgm/+L30tpvpiFC/uM=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:15 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 09/18] fs/ntfs3: Replace inode_trylock with inode_lock
Date: Fri, 7 Jun 2024 15:15:39 +0300
Message-ID: <20240607121548.18818-10-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
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

The issue was detected due to xfstest 465 failing.

Fixes: 4342306f0f0d5i ("fs/ntfs3: Add file operations and implementation")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2f903b6ce157..9ae202901f3c 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -299,10 +299,7 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		}
 
 		if (ni->i_valid < to) {
-			if (!inode_trylock(inode)) {
-				err = -EAGAIN;
-				goto out;
-			}
+			inode_lock(inode);
 			err = ntfs_extend_initialized_size(file, ni,
 							   ni->i_valid, to);
 			inode_unlock(inode);
-- 
2.34.1


