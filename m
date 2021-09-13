Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5A44096D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 17:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244362AbhIMPOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 11:14:25 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:34552 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346468AbhIMPOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:14:16 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 228DA82267;
        Mon, 13 Sep 2021 18:12:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1631545979;
        bh=yJHpnfO2XyPKYiuXAIOMsx6Rrjs+v6RJzRc0invVEfk=;
        h=Date:Subject:From:To:References:CC:In-Reply-To;
        b=TkluKFH6eMbHQKllAKbH7gXd/hulbUrazley5kAmT67JEjzw4n+Dxli4LicR9cEdT
         WzDJNJJIJdrMnYs6P1F9uvQgd/cyKKgb2NWW5ESQbxA0hDQ2q2rgC/UhtFAUd8iH0K
         TbuvrZzfgPT4tTBOpd1Z9qvzJ44bA/5z7iVW+/iA=
Received: from [192.168.211.103] (192.168.211.103) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 13 Sep 2021 18:12:58 +0300
Message-ID: <9fd8b3d5-2f1e-29c3-282a-d2276b5d0db9@paragon-software.com>
Date:   Mon, 13 Sep 2021 18:12:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: [PATCH 1/3] fs/ntfs3: Fix insertion of attr in ni_ins_attr_ext
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
References: <a08b0948-80e2-13b4-ea22-d722384e054b@paragon-software.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <a08b0948-80e2-13b4-ea22-d722384e054b@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.103]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Do not try to insert attribute if there is no room in record.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/frecord.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 938b12d56ca6..834cb361f61f 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -956,6 +956,13 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 			continue;
 		}
 
+		/*
+		 * Do not try to insert this attribute
+		 * if there is no room in record.
+		 */
+		if (le32_to_cpu(mi->mrec->used) + asize > sbi->record_size)
+			continue;
+
 		/* Try to insert attribute into this subrecord. */
 		attr = ni_ins_new_attr(ni, mi, le, type, name, name_len, asize,
 				       name_off, svcn, ins_le);
-- 
2.33.0

