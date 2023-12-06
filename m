Return-Path: <linux-fsdevel+bounces-5011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CD7807527
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC4EFB20DAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9A946540
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="W9QM4y1P";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="LhPCq7kw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC519A;
	Wed,  6 Dec 2023 07:11:15 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 4775E1E1A;
	Wed,  6 Dec 2023 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875089;
	bh=2BFRYk4Moqh9lL8OQcoNVoZ0RV2c9czsoWnrNagsXik=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=W9QM4y1PMOeSapyHHNSO54M7gNOc1aLuFNGjtTYjQSJV0htdC4x+VrQzupF0/j9I2
	 UQ/Qz+SxSN+tutElWa0RtsRilM5yspu+upzKbRQtGAS3NGzhFCZufJlfmJhGi0hO+U
	 tyjNmuWSVtRiSUFQIzuDruoiwdUzHk7LPQA+M7rs=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 7F1272117;
	Wed,  6 Dec 2023 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875473;
	bh=2BFRYk4Moqh9lL8OQcoNVoZ0RV2c9czsoWnrNagsXik=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=LhPCq7kwV1lA63gtdTSLts0Uu8PS4YjNDVw1GJMjGvA42Ak90TZUseTrn1H2SP9cN
	 sxA8xmWKrdoRbOZEcndzE9IUEt+a/pP//oH3NFdTK23dYF2ejGyECH6+V9PauMUPIH
	 I7ouj8D/oTC4AJ8ES2dOWKSGaeBFkG1lESNnyQ7I=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:11:12 +0300
Message-ID: <44b1dd7e-f5fc-4908-84f1-8e631cdc23d9@paragon-software.com>
Date: Wed, 6 Dec 2023 18:11:12 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 05/16] fs/ntfs3: Print warning while fixing hard links count
Content-Language: en-US
From: Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
In-Reply-To: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/inode.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 5e3d71374918..fa6c7965473c 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -412,7 +412,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
          goto out;

      if (!is_match && name) {
-        /* Reuse rec as buffer for ascii name. */
          err = -ENOENT;
          goto out;
      }
@@ -427,6 +426,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,

      if (names != le16_to_cpu(rec->hard_links)) {
          /* Correct minor error on the fly. Do not mark inode as dirty. */
+        ntfs_inode_warn(inode, "Correct links count -> %u.", names);
          rec->hard_links = cpu_to_le16(names);
          ni->mi.dirty = true;
      }
-- 
2.34.1


