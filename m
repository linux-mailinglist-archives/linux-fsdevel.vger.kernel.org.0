Return-Path: <linux-fsdevel+bounces-17463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2AE8ADDA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC41F220E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 06:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E683D0D5;
	Tue, 23 Apr 2024 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="TvmV5wgd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621523748;
	Tue, 23 Apr 2024 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854708; cv=none; b=aDqIRQZwYa6ZSifRnhYPYU3v2/yTwQJmevUa1NrvJYQOrRlIoS1YGSDgzS0p3MzquQRrxSj+gv3wasrv4LT4ayIt+qs7p3vC2n50miL/1up+KL4tt7bnVj5KdYpgezr8nQn6iwgey/Rn8ZNQE2xDbnopK0QpiyeWk5+VrOkUnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854708; c=relaxed/simple;
	bh=nTn0zaTNrShbk3paxud+AkmRRpbMA7FsQQJ0oaxqvyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YywkaQkRmp6RsLNB54STQ9WjVPHpoWq6BL3bAgP2DspyLhLshEHNqfOdpC8bMY1rtVAD8T7MAp78F5L4YgFdC3DqUl0fJNGy6VVziIdbPVU4dAijv+P4q2TQ6NsvvfbizAUT+kCrEWBjUExOAjz2o8irlfmFE9qjOgPnxccV+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=TvmV5wgd; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 92DE22001;
	Tue, 23 Apr 2024 06:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854253;
	bh=3cVk0H+rl0oBurqKEXVfmBKXIrjKBQMQ/qE3urFKI1g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TvmV5wgd+8JqVtFIywK227+EAgZrJEpNe57VElPf38rTtzMdeZ+YzgnUc+33b27A/
	 qJPsP6Cmj7XmTqNJJDN1uaugIwirtN2fwWdC30wcM4mi4EYBh+DoEekO6ogV2x9IHJ
	 Smgj7jfCi4I0mRqKMw5ltDX4SSP0WR7ckRjF7LAk=
Received: from ntfs3vm.paragon-software.com (192.168.211.160) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 09:45:04 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/9] fs/ntfs3: Remove max link count info display during driver init
Date: Tue, 23 Apr 2024 09:44:21 +0300
Message-ID: <20240423064428.8289-3-almaz.alexandrovich@paragon-software.com>
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

Removes the output of this purely informational message from the
kernel buffer:

	"ntfs3: Max link count 4000"

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: stable@vger.kernel.org
---
 fs/ntfs3/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9df7c20d066f..ac4722011140 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1804,8 +1804,6 @@ static int __init init_ntfs_fs(void)
 {
 	int err;
 
-	pr_info("ntfs3: Max link count %u\n", NTFS_LINK_MAX);
-
 	if (IS_ENABLED(CONFIG_NTFS3_FS_POSIX_ACL))
 		pr_info("ntfs3: Enabled Linux POSIX ACLs support\n");
 	if (IS_ENABLED(CONFIG_NTFS3_64BIT_CLUSTER))
-- 
2.34.1


