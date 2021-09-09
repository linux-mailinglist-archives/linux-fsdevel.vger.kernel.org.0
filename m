Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05364048C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 12:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhIIK7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 06:59:13 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:37592 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234545AbhIIK7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:59:11 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 626C21D37;
        Thu,  9 Sep 2021 13:58:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1631185080;
        bh=fFhI2jZqVUvYHRUsDIGDkYy9fTbmvFt7gL2uySKNajk=;
        h=Date:To:CC:From:Subject;
        b=Zt/T/iUm11rNcXrIFJXskphS5o1q4VE4MjbiHzgoS9VxcTLeMGSm4kxKVvVZ8w/t3
         PX6RT3Q43QuVKDAXWqETApmvhgmyuj24aV0Q8zD8uzsaWTj4csjs2rVIwpCSXR3M/q
         6pFQKfZtprsYiXKlVc8XvWvdU+Jpm2Al8/uwNewY=
Received: from [192.168.211.46] (192.168.211.46) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 9 Sep 2021 13:58:00 +0300
Message-ID: <732a18ee-20ea-3e53-056c-8a4d496e5522@paragon-software.com>
Date:   Thu, 9 Sep 2021 13:57:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 1/3] fs/ntfs3: Fix insertion of attr in ni_ins_attr_ext
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.46]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Do not try to insert attribute if there is no room in record.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/frecord.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 938b12d56ca6..5dd7b7a7c5e0 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -956,6 +956,10 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 			continue;
 		}
 
+		/* Do not try to insert this attribute if there is no room in record. */
+		if (le32_to_cpu(mi->mrec->used) + asize > sbi->record_size)
+			continue;
+
 		/* Try to insert attribute into this subrecord. */
 		attr = ni_ins_new_attr(ni, mi, le, type, name, name_len, asize,
 				       name_off, svcn, ins_le);
-- 
2.28.0
