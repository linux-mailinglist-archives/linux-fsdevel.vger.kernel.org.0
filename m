Return-Path: <linux-fsdevel+bounces-26795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E91B95BB08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF40282FEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5B1CDFC0;
	Thu, 22 Aug 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="g7LZPj7b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B671CCEC5;
	Thu, 22 Aug 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341951; cv=none; b=EZABjw7QDcrwM4LYaqaByDnmM69EFFwjbc/t9a1IBzF23ig4DbHXBQCD58k0dxlxMShB8jKWYBEx2OlAh/n3WFsd3lTcIbvTUMXqRQpDjj8KNxIp7KX4F8JjEzBnZEs3MMEvGtdUK+X2YW6SYIUUatbFEvCW1Lr8LMlO5r5+y2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341951; c=relaxed/simple;
	bh=RnqOkoHf7tMMnt3OlFnGk/EEwgrjtQx/QMgMTTpNIKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syYzX1ZkEJwCQ23H6kxH8LzKmtKIDC1WVByJa35uNWsi6fm5i30yhwHeA7bUCQve8TrbaPqAHAz1wC3feESfq6aOghZhVmMIhEr3RwEZeO18bZv4hFHbID1aPx9kWHTgaThPcBQLnWBvoxsZVmpeP2llZor7spMTcqjK+ym4918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=g7LZPj7b; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 46DEB21DD;
	Thu, 22 Aug 2024 15:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341466;
	bh=lJwnTsLSOngz792/fDzy3aN/miLK8nR0E/OK1x7J4dU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=g7LZPj7byyERrC/vdETVCUza+i5jtKbQIl0pzkYc7CQi6YDLSTAl5RwfArPJViqDH
	 GmM7vmy71OHK8cqLNBCr0lv480YPULo+f3PHrfu00Ppehx0hQmN1eBpH+kpbm9YiKO
	 mfFhZoQoD9L6z07k0tpWYdSdZbsvcpbuaxoD5CGA=
Received: from ntfs3vm.paragon-software.com (192.168.211.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Aug 2024 18:52:22 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com>
Subject: [PATCH 09/14] fs/ntfs3: Add rough attr alloc_size check
Date: Thu, 22 Aug 2024 18:52:02 +0300
Message-ID: <20240822155207.600355-10-almaz.alexandrovich@paragon-software.com>
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

Reported-by: syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/record.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 6c76503edc20..82950a267d4c 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -334,6 +334,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 		if (attr->nres.c_unit)
 			return NULL;
+
+		if (alloc_size > mi->sbi->volume.size)
+			return NULL;
 	}
 
 	return attr;
-- 
2.34.1


