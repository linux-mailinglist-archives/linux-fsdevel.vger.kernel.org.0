Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60775598A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 13:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiFXLk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 07:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiFXLk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:40:57 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63D8680A7;
        Fri, 24 Jun 2022 04:40:56 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 88D4C1D74;
        Fri, 24 Jun 2022 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656070803;
        bh=3Mkqb1PWuU0xIeT72wwiSaW/DavCpeTw5fGLN/P1VQc=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=QdTf2H871h2QnnqOsrvFnsrrRAqRAmzhcM5EVdkt2w+7SmIkPp//N+MPFcUNhY23L
         7XhfgW3cEl7Fr/1zlFC6jsYP3EtKUnO3hXODEIEenlvbxUyNb9fMzJQvmDqjPFMMVc
         m/RrnjMWDa9pgRK1qnegZ9Ncgg3RmxaX9lGiIsXs=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id CF2B321AE;
        Fri, 24 Jun 2022 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656070854;
        bh=3Mkqb1PWuU0xIeT72wwiSaW/DavCpeTw5fGLN/P1VQc=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=tIKtuYDRhff+4vCu0zOMkGRP3foRNjv4lcGXrl2UmALCXSGATWlxM4IZMcK/2pMj8
         kDqXevtqpF2UAPvHlszMSBACPja77tcN6XAL0DNuYMPwA9pBzf1WfEFtq84nCKqkgJ
         dh/XGKKagWx5C+9iJHnZ/8kIl+bsGbRBmAjsKPWM=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 24 Jun 2022 14:40:54 +0300
Message-ID: <71c6964a-bcab-0c53-931a-6e41b2637ff0@paragon-software.com>
Date:   Fri, 24 Jun 2022 14:40:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: [PATCH 1/3] fs/ntfs3: Do not change mode if ntfs_set_ea failed
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <f76c96bb-fdea-e1e5-5f47-c092af5fe556@paragon-software.com>
In-Reply-To: <f76c96bb-fdea-e1e5-5f47-c092af5fe556@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ntfs_set_ea can fail with NOSPC, so we don't need to
change mode in this situation.
Fixes xfstest generic/449
Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/xattr.c | 20 ++++++++++----------
  1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 5e0e0280e70d..1e849428bbc8 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -547,28 +547,23 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
  {
  	const char *name;
  	size_t size, name_len;
-	void *value = NULL;
-	int err = 0;
+	void *value;
+	int err;
  	int flags;
+	umode_t mode;
  
  	if (S_ISLNK(inode->i_mode))
  		return -EOPNOTSUPP;
  
+	mode = inode->i_mode;
  	switch (type) {
  	case ACL_TYPE_ACCESS:
  		/* Do not change i_mode if we are in init_acl */
  		if (acl && !init_acl) {
-			umode_t mode;
-
  			err = posix_acl_update_mode(mnt_userns, inode, &mode,
  						    &acl);
  			if (err)
  				goto out;
-
-			if (inode->i_mode != mode) {
-				inode->i_mode = mode;
-				mark_inode_dirty(inode);
-			}
  		}
  		name = XATTR_NAME_POSIX_ACL_ACCESS;
  		name_len = sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1;
@@ -604,8 +599,13 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
  	err = ntfs_set_ea(inode, name, name_len, value, size, flags, 0);
  	if (err == -ENODATA && !size)
  		err = 0; /* Removing non existed xattr. */
-	if (!err)
+	if (!err) {
  		set_cached_acl(inode, type, acl);
+		if (inode->i_mode != mode) {
+			inode->i_mode = mode;
+			mark_inode_dirty(inode);
+		}
+	}
  
  out:
  	kfree(value);
-- 
2.36.1


