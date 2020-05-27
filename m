Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3091E3778
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 06:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgE0Ek7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 00:40:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29223 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725294AbgE0Ek7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 00:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590554457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=62bWFuqjjYRHCtiXetCYD/KJZfcErk/k0VhDChgAXO8=;
        b=PAzaG6PhZE6MEtY0/PbDDjAVhg2HyRXr24Q5HA7KPmo/f+6ovHTbFDSTLPG0DTLqLpP6z8
        2arPwzbKyLzY9AYIoN33LnBvzn0q7BMTFtpKzQGqVsV7GvIeHHxt4gERw2TVjtpewU5UPd
        aL2Yf2+nq+Vl3ugOmpgfVt3uQCk9VAs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-PwsSmW7AP96YBPSI_Dt3Fw-1; Wed, 27 May 2020 00:40:55 -0400
X-MC-Unique: PwsSmW7AP96YBPSI_Dt3Fw-1
Received: by mail-pl1-f199.google.com with SMTP id g22so17306656plq.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 21:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62bWFuqjjYRHCtiXetCYD/KJZfcErk/k0VhDChgAXO8=;
        b=s1PPSlNOrK6+JIhsnl6gSDhepWZ0bV0IpyEMIx+IE1UwSOAKiH3IR+gHmSoBginYvk
         9Ydz3GVw6uV/LiE3cx02/dhuUYYXeHLio8vi6YTPp87/wFK0ej9QcyTlNDyfp+ALwZtH
         R0OGh96j+gMtgO9XFxu0dxYomEmGVN+HzB+jXpst9hUX6p5EgXcKAzjQVqQUJQjTM0B6
         1xQrtTwqx3VBKN3C6Qc036NC8xfGvDjvzjQU2+c81Oh7ZRsfFzUDXGUsaMLxeAaQZGE2
         9iqgPhBhsInk+vJ0Ep6z0FJ45H7KLNu27s146yuXPr46zguVjY+X6NF40tH2hPet6aDv
         3PXA==
X-Gm-Message-State: AOAM532awooLYgW3uWOgK6BtJJLEpD/qpKbi4eXCQpRbHO5ePNygZN6k
        DHrHE64g4tSLid64GsA2p4yMkLOGPyhQ9m0ziH6x19xWfytSsyg0kWZF1gawVYoKGUEs0iFulvw
        1nxnfPcvLmURbXAnaJs5p/eyXPQ==
X-Received: by 2002:a17:90a:f0d8:: with SMTP id fa24mr2767948pjb.93.1590554454367;
        Tue, 26 May 2020 21:40:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3AhxFWNIq2AkpKBB4NtPMQm+6oHtFAst619gt2ptZM930h8Bs8vT/fc6lIcLSTn64wdYb6w==
X-Received: by 2002:a17:90a:f0d8:: with SMTP id fa24mr2767930pjb.93.1590554454100;
        Tue, 26 May 2020 21:40:54 -0700 (PDT)
Received: from hsiangkao-HP-ZHAN-66-Pro-G1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mt3sm926663pjb.23.2020.05.26.21.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 21:40:53 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] xattr: fix EOPNOTSUPP if fs and security xattrs disabled
Date:   Wed, 27 May 2020 12:40:37 +0800
Message-Id: <20200527044037.30414-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit f549d6c18c0e ("[PATCH] Generic VFS fallback for security xattrs")
introduces a behavior change of listxattr path therefore listxattr(2)
won't report EOPNOTSUPP correctly if fs and security xattrs disabled.
However it was clearly recorded in manpage all the time.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chengguang Xu <cgxu519@mykernel.net>
Cc: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---

Noticed when reviewing Chengguang's patch for erofs [1] (together
with ext2, f2fs). I'm not sure if it's the best approach but it
seems that security_inode_listsecurity() has other users and it
mainly focus on reporting these security xattrs...

[1] https://lore.kernel.org/r/20200526090343.22794-1-cgxu519@mykernel.net

Thanks,
Gao Xiang

 fs/xattr.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 91608d9bfc6a..f339a67db521 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -352,13 +352,15 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 	error = security_inode_listxattr(dentry);
 	if (error)
 		return error;
-	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR)) {
-		error = inode->i_op->listxattr(dentry, list, size);
-	} else {
-		error = security_inode_listsecurity(inode, list, size);
-		if (size && error > size)
-			error = -ERANGE;
-	}
+
+	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR))
+		return inode->i_op->listxattr(dentry, list, size);
+
+	if (!IS_ENABLED(CONFIG_SECURITY))
+		return -EOPNOTSUPP;
+	error = security_inode_listsecurity(inode, list, size);
+	if (size && error > size)
+		error = -ERANGE;
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_listxattr);
-- 
2.24.0

