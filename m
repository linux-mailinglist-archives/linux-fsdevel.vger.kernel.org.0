Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E370717339
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 03:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjEaBge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 21:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjEaBgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 21:36:32 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFDBF9;
        Tue, 30 May 2023 18:36:31 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-397f6a71ee7so3529296b6e.3;
        Tue, 30 May 2023 18:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685496990; x=1688088990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGGyS7PZ3izlD8uBHyD50YNbDhchZ2LRm+rdUWJP4bw=;
        b=psGoUI86pEOj/HZhmzkG65J6nlnC4qWnwFmr9pO7FE5KoE0rQTN3uPvuXEk3eDY1g2
         US5WjcAUMlNa1rF2LLkCh+bqlhD6Lms0UyqQJYP46Hle7kBSmpSl0ixQaIO2ahm6t9k9
         cXFK/n7DMzhE/P5Hh6oeVRVueGXmBXkEWiVzT28LhZ8XpZbqeZQ5kOQUiJXjJFBp27L4
         2fD9IF+iRJFLHJEWvOmtnMmt2q5ZgMFI888JekkOKjRRhKa0ExA7TfLBCjcVIkfuqJ87
         DNMAPmy/AabJ2HmZv5NPDAG0i+vChOVOEr/xOKVxHU39AXJde2dh22SFQ42KNfeORu5z
         nTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685496990; x=1688088990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGGyS7PZ3izlD8uBHyD50YNbDhchZ2LRm+rdUWJP4bw=;
        b=OR6hutPEkrN3lNI0G4+eXftztyByUgHsVdOSdBjDauNcfiRD1hs8THSNhMNd8r+/0e
         a9DoOASMId7FEyJa0MPCBghKh3Vw4pRJ3JCrvUGG9+swt5TuoIwLszCRTKH6tfXeR8GE
         r0dxvq77g1wiYJgwH+KMjJymvmJzVNlX7h6tm3+TyN7Rd9st038AEPhGL1DRuB6pCCdP
         a/kt6qJrWfYjRhnLavc9hDMyT94EBlca9anE9+1aAy4wtX5+7lLqOBLtFfAXbLyEeTVB
         xEhFnP5djE3E3OYMg2Eps6mkNIjIeCd+loi8HRohcg8zSX5bsw+LKd2YlBOuzXyVO7Du
         B8uA==
X-Gm-Message-State: AC+VfDwaOp+jWNWKLy8+mXb+FARSTS4lxNY7a07gAFzaWw3EtvxfUvnK
        U8trND28RQbi3Mnt3miu1Vw=
X-Google-Smtp-Source: ACHHUZ4J4Uv1VDY46ZEJ1JN/HequWr+HWLdhTcLel8YjgDuoyoK4icwe7BCMPHgi2JUZ3kyTsd9aqQ==
X-Received: by 2002:aca:b5c4:0:b0:398:214d:16d4 with SMTP id e187-20020acab5c4000000b00398214d16d4mr2139701oif.30.1685496990271;
        Tue, 30 May 2023 18:36:30 -0700 (PDT)
Received: from fedora.hsd1.wa.comcast.net ([2601:602:9300:2710::f1c9])
        by smtp.gmail.com with ESMTPSA id jb12-20020a170903258c00b001a69dfd918dsm6612877plb.187.2023.05.30.18.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 18:36:29 -0700 (PDT)
From:   Prince Kumar Maurya <princekumarmaurya06@gmail.com>
To:     skhan@linuxfoundation.org, brauner@kernel.org, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, chenzhongjin@huawei.com
Cc:     Prince Kumar Maurya <princekumarmaurya06@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com
Subject: [PATCH v4] fs/sysv: Null check to prevent null-ptr-deref bug
Date:   Tue, 30 May 2023 18:31:41 -0700
Message-Id: <20230531013141.19487-1-princekumarmaurya06@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530-gefangen-ersonnen-d1f1b6eea903@brauner>
References: <20230530-gefangen-ersonnen-d1f1b6eea903@brauner>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sb_getblk(inode->i_sb, parent) return a null ptr and taking lock on
that leads to the null-ptr-deref bug.

Reported-by: syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aad58150cbc64ba41bdc 
Signed-off-by: Prince Kumar Maurya <princekumarmaurya06@gmail.com>
---
Change since v3: Added cleanup code for the branch[n].key on 
failure code path.

 fs/sysv/itree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index b22764fe669c..58d7f43a1371 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -145,6 +145,10 @@ static int alloc_branch(struct inode *inode,
 		 */
 		parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh) {
+			sysv_free_block(inode->i_sb, branch[n].key);
+			break;
+		}
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
-- 
2.40.1

