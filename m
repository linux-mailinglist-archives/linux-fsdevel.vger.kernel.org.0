Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81176437A68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhJVP4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 11:56:54 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:39286 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233151AbhJVP4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:56:52 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 967B9120;
        Fri, 22 Oct 2021 18:54:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1634918072;
        bh=KjXp0HECCDmxLZTX1hu71cOXhB6Xk/q6EuXO/P1++88=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=k5rtf73AEE7Pb5/aiNeJRqvV3QG07RDbPvBIGmlZiihq5jN+S1KRh1vs7JNEsYd7z
         kmkSSk9inUQQnM3+vXRzhR0G++q/5lY4/QISEe+pq4sxJwmknN4cpAjhOqopLz/Dq6
         YlkoNyA0x+aMTdgvnUarGEYI1Znw0+jDtCLfem6c=
Received: from [192.168.211.69] (192.168.211.69) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 22 Oct 2021 18:54:32 +0300
Message-ID: <aaf41f35-b702-b391-1cff-de4688b3bb65@paragon-software.com>
Date:   Fri, 22 Oct 2021 18:54:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: [PATCH 1/4] fs/ntfs3: Keep preallocated only if option prealloc
 enabled
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <09b42386-3e6d-df23-12c2-23c2718f766b@paragon-software.com>
In-Reply-To: <09b42386-3e6d-df23-12c2-23c2718f766b@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.69]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If size of file was reduced, we still kept allocated blocks.
This commit makes ntfs3 work as other fs like btrfs.
https://bugzilla.kernel.org/show_bug.cgi?id=214719
Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")

Reported-by: Ganapathi Kamath
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 43b1451bff53..3ac0482c6880 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -494,7 +494,7 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 
 	down_write(&ni->file.run_lock);
 	err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run, new_size,
-			    &new_valid, true, NULL);
+			    &new_valid, ni->mi.sbi->options->prealloc, NULL);
 	up_write(&ni->file.run_lock);
 
 	if (new_valid < ni->i_valid)
-- 
2.33.0


