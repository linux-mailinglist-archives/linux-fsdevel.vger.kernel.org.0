Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0443B76E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 18:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhJZQnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 12:43:24 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:53977 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230373AbhJZQnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:43:23 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 9BA188224F;
        Tue, 26 Oct 2021 19:40:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1635266458;
        bh=Ocmjl5X+1yM+y6E8UyAWd2hXJMrOb9GnY3+xTm6DmWA=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=lGRtgTz/bYv+P3WznGi1JDdWw1oLQw2amLptGCmqCbKDDAykZ3RpJlD/jBSBxDkZz
         Vq0vDbe3Ub1HbLOuJhKby2OsKr4zOHALz5ezv4rcyfk5fqTofwcgRhYg77fos/g6Y5
         FNpndSjaAzYR3JdRAy7BOTRGgeWjaYA9dOAzK5yc=
Received: from [192.168.211.149] (192.168.211.149) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 26 Oct 2021 19:40:58 +0300
Message-ID: <19b0fc31-a28f-69aa-27dc-e6514a10643e@paragon-software.com>
Date:   Tue, 26 Oct 2021 19:40:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: [PATCH 1/4] fs/ntfs3: Keep preallocated only if option prealloc
 enabled
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kari.argillander@gmail.com>
References: <a57c1c49-4ef3-15ee-d2cd-d77fb4246b3c@paragon-software.com>
In-Reply-To: <a57c1c49-4ef3-15ee-d2cd-d77fb4246b3c@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.149]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If size of file was reduced, we still kept allocated blocks.
This commit makes ntfs3 work as other fs like btrfs.
Link: https://bugzilla.kernel.org/show_bug.cgi?id=214719
Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")

Reported-by: Ganapathi Kamath <hgkamath@hotmail.com>
Tested-by: Ganapathi Kamath <hgkamath@hotmail.com>
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


