Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD85187648
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 00:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbgCPXi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 19:38:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33369 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732965AbgCPXi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:38:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id r7so14410207wmg.0;
        Mon, 16 Mar 2020 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n6sFKO+k+B7M8HISJMJ4F/MsvQHfG/I2iTodahtZLUY=;
        b=QuhxdzvE/B9WfM8MrDcHJvGg/S1obd/Whx3bLHc9bvKRJbBcXuZgxRohoXyZ30MaVJ
         4tQdfotLI7/67XUbDUCGHOVPnrCCI9iUaOzOKNhk4QWi+382kLdLwVHCxrG2TAte9F22
         64Fg+8J9S/ZKZj9JhxINfvSEYv55H0mKTJf8aOVWLQAtuKMEWSvbVQVl8Y6uRw/JLJxW
         JiDbAqjxlisach4k44Q268RccUuV0e5mXp+VJg/l4irhOYnAR8RLk+QkMg+koe/k1k6Y
         46VVcvAoAqOkAxBjGOA8KmzU95zgpGSd5Q+0rcXzk3ogyKHnzxlAaFyfWAuZBsYio/Xi
         uXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n6sFKO+k+B7M8HISJMJ4F/MsvQHfG/I2iTodahtZLUY=;
        b=M7Uc7BcHNKMEB7ce7VwVP8mI4bZYOopD06eam+m6jQO6HRsROo9Roap/VzYp+eRGc8
         Ex4Ah31ZDD0eh3ct9ZbCQH0UJXX2+XCQIPfx0auY3Tzc/1nV6a/ksO3eL1VanQGVWAfp
         xsQo9V9dgrLVo5Unpw33ccYliF91wxzePfgLpIZ5j41Hk/j/ACl6BXg8k8jREmVSh4zC
         GotxpIxVkqP1r7IJZbMAi/9Qhx2MeuIMs5CyBNlAhj6jjIasDSRqL32u7e9rnrrqgaml
         q6LtI1g+l7kK34ToDfM8BshEcTetQMR/noCvUa3G3lJYd/jIfQPEcKEazuo3+5KZY/WF
         9lTw==
X-Gm-Message-State: ANhLgQ3zaM28bkO6bsKfAl/9r5mvrePkSIOsYwmeEhLldzgIyycrygbv
        z1PFpHYTK8P6yts+79VJLA==
X-Google-Smtp-Source: ADFU+vtUCSByZJTRvYZDZM+gyoPb28AxoxwA80n+yUdKwvRzW81kckei/qOpsPOueEP5eTnXCb2PeQ==
X-Received: by 2002:a1c:a102:: with SMTP id k2mr1374680wme.125.1584401933955;
        Mon, 16 Mar 2020 16:38:53 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.googlemail.com with ESMTPSA id i9sm1510495wmd.37.2020.03.16.16.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 16:38:53 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5/6] fs/fs-writeback.c: replace two annotations for __inode_wait_for_writeback()
Date:   Mon, 16 Mar 2020 23:38:03 +0000
Message-Id: <20200316233804.96657-6-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316233804.96657-1-jbi.octave@gmail.com>
References: <0/6>
 <20200316233804.96657-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To improve readability of the code,
__releases(inode->i_lock) and __acquires(inode->i_lock) annotations here
are replaced by one annotation __must_hold(inode->i_lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/fs-writeback.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 008e572faf32..d0c0dc10526d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1322,8 +1322,7 @@ static int write_inode(struct inode *inode, struct writeback_control *wbc)
  * Caller must make sure inode cannot go away when we drop i_lock.
  */
 static void __inode_wait_for_writeback(struct inode *inode)
-	__releases(inode->i_lock)
-	__acquires(inode->i_lock)
+	__must_hold(inode->i_lock)
 {
 	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_SYNC);
 	wait_queue_head_t *wqh;
-- 
2.24.1

