Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2FA43B774
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 18:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhJZQoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 12:44:17 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:54214 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234249AbhJZQoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:44:17 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id A6DFA82240;
        Tue, 26 Oct 2021 19:41:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1635266511;
        bh=Svw6iDPddCZzmIZAdwnbtfsGGI8IUqRP1pf1ufWd3nA=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=NtdGpRZWeCWC5QEuFRvLX3/tvEw093+v4xywGaZm3vGuv+8d9+rHI+WbGvfyTI1Ai
         eWkzPFSnabv0OPllITjG1CvE3zyGj6rY4y4NbrqJVlL8Ic9qgcJcigwuIGzVjeEgwk
         NsVYx+m8bF0FfRqaL/aqr236Kjyyk53kxXTHokgs=
Received: from [192.168.211.149] (192.168.211.149) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 26 Oct 2021 19:41:51 +0300
Message-ID: <d5482090-67d1-3a54-c351-b756b757a647@paragon-software.com>
Date:   Tue, 26 Oct 2021 19:41:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: [PATCH 3/4] fs/ntfs3: Update i_ctime when xattr is added
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

Ctime wasn't updated after setfacl command.
This commit fixes xfstest generic/307
Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 3ccdb8c2ac0b..157b70aecb4f 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -992,6 +992,9 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 	err = ntfs_set_ea(inode, name, name_len, value, size, flags);
 
 out:
+	inode->i_ctime = current_time(inode);
+	mark_inode_dirty(inode);
+
 	return err;
 }
 
-- 
2.33.0


