Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F859439C33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhJYRB5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 13:01:57 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:57009 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232050AbhJYRBy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:01:54 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 1D297808C5;
        Mon, 25 Oct 2021 19:59:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1635181167;
        bh=gUy+qk4k+tYm1QGWsx1o8F44iIlg+MWlY8HDA1Uw+To=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ZRcbrsUDNmlsbAuLS2pSiiw2Zi2c+Pma15Ol9StNZGVKYSgDMyrD1LJuSBFUiob9l
         8o4hOS0jkL36BXUY18hM/hh0MykZsrbnkYM4xuUK4893pblDONaDSSHiwoGbdwMwXb
         N4h9hblLR6GWt0Q90B7lf2J/tGZsVI2E0I57hWLA=
Received: from [192.168.211.155] (192.168.211.155) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 25 Oct 2021 19:59:26 +0300
Message-ID: <512a989d-c15f-d73f-09c1-74ba25eeec27@paragon-software.com>
Date:   Mon, 25 Oct 2021 19:59:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: [PATCH 3/4] fs/ntfs3: Check new size for limits
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
In-Reply-To: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.155]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We must check size before trying to allocate.
Size can be set for example by "ulimit -f".
Fixes xfstest generic/228
Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 5418e5ba64b3..efb3110e1790 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -661,7 +661,13 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		/*
 		 * Normal file: Allocate clusters, do not change 'valid' size.
 		 */
-		err = ntfs_set_size(inode, max(end, i_size));
+		loff_t new_size = max(end, i_size);
+
+		err = inode_newsize_ok(inode, new_size);
+		if (err)
+			goto out;
+
+		err = ntfs_set_size(inode, new_size);
 		if (err)
 			goto out;
 
-- 
2.33.0

