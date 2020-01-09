Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41622135CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 16:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbgAIPhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 10:37:18 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35733 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgAIPhS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:37:18 -0500
Received: by mail-qt1-f193.google.com with SMTP id e12so6214019qto.2;
        Thu, 09 Jan 2020 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2YJGyHBLvtLKqb9SRpRu2YXGxUEZDi676bDfDkyEFg=;
        b=ZneKtiAlMcidG4UdYbHPyxPvUR5AWwRcKL1wUXAKDc3yaB5Rz2JG2cg9C+f/skx5di
         IPR1RluXbxEvHAmkbAnTVYeiCBecT03OzDYOo2OAHOHyuRB11O8rFg3tNiTOZLHmgXoa
         MDVcLXuCkhA1oB8ew29ESo+iL2YRj+s/rpqID+AgHME6pbnELqyMDAgHnW+2SQNpPP+w
         qa9P8QKO7h3dtEfAoPylj50dBtBSxZp8+7AFMi+ZRNDBYAZndBhg3CrVPteAPfeEtlfx
         QjKbf7Bh/VxE39BXkS2iW5QtRy7yAmy4Ihv5t2FvO5Gi6UQ3SfCpkGzS2kwEEsdy9Ixw
         /zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2YJGyHBLvtLKqb9SRpRu2YXGxUEZDi676bDfDkyEFg=;
        b=mOaRoE2a/5px/T8mIM6hF9MnFRxwEEF5uGxu9OT1ppZsSxJaQ3/SaOYI4Yiov9tQSG
         EJUal8RQ4Q33YiSpVBWGBsoSzzPRMqc2dFsvyozpAyObpoSMlLNflyGGD+iWhh+oizlS
         FFTYtSkMhn+s0Y+2ECfBv9mRleT3St/2piNpeHSa1avqV49WKduxOKVBkYoTuvMCJ8AF
         7ln9dQiDTPZDLAT2uQ6w5/ororjHFwhM+cGNJ6U2S5kaio8my8sPsm6ca8BXRrbFd44m
         7EwUDRlo1ZhC2tnCMsREiMAFeoS8MffTDl2s8OX+fjQiq23o+5mvIuk5bsuN3mR+v51L
         rP1w==
X-Gm-Message-State: APjAAAUsPuRmEuyYTtu8DwUdCKOaRupdTo98ntPwYxbNNFmjSm1OAXMz
        yYmTeqK61lrkmiHR1aqgG9U=
X-Google-Smtp-Source: APXvYqzRsrNCmNbKgXNaQF/bpdsSBKi6qZ1al31wLZdA+ei0VbefgTZAFJ0ZXB5U1yp13F10a5Gylg==
X-Received: by 2002:ac8:65d3:: with SMTP id t19mr8721051qto.369.1578584237194;
        Thu, 09 Jan 2020 07:37:17 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id u16sm3122008qku.19.2020.01.09.07.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:37:16 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     viro@zeniv.linux.org.uk
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RESEND] fs: posix-acl.c: Fix warnings
Date:   Thu,  9 Jan 2020 12:37:07 -0300
Message-Id: <20200109153708.1021891-1-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warning

/fs/posix_acl.c:636: WARNING: Inline emphasis start-string without end-string.

By escaping a character.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 fs/posix_acl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 84ad1c90d535..cb25966c6881 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -634,7 +634,7 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
  *
  * Update the file mode when setting an ACL: compute the new file permission
  * bits based on the ACL.  In addition, if the ACL is equivalent to the new
- * file mode, set *acl to NULL to indicate that no ACL should be set.
+ * file mode, set \*acl to NULL to indicate that no ACL should be set.
  *
  * As with chmod, clear the setgit bit if the caller is not in the owning group
  * or capable of CAP_FSETID (see inode_change_ok).
@@ -743,12 +743,12 @@ posix_acl_from_xattr(struct user_namespace *user_ns,
 		return ERR_PTR(-EINVAL);
 	if (count == 0)
 		return NULL;
-	
+
 	acl = posix_acl_alloc(count, GFP_NOFS);
 	if (!acl)
 		return ERR_PTR(-ENOMEM);
 	acl_e = acl->a_entries;
-	
+
 	for (end = entry + count; entry != end; acl_e++, entry++) {
 		acl_e->e_tag  = le16_to_cpu(entry->e_tag);
 		acl_e->e_perm = le16_to_cpu(entry->e_perm);
-- 
2.24.1

