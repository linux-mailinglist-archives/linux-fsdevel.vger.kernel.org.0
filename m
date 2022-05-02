Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF701516E19
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 12:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384504AbiEBK3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 06:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384605AbiEBK3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 06:29:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46481402C;
        Mon,  2 May 2022 03:25:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so12301718pjb.0;
        Mon, 02 May 2022 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:organization;
        bh=opzFVZrWphL638v+ecMPeic1OeJD7YaCPj4Gw1q7Ih4=;
        b=etc8Bbru37frC6WJsYuezTnyp9A1bMZsUa35hIE2yoT4DwXUT+6X3Yao4zBAgnUepp
         zevEnuN5iE5wRgzsB5YfeBgSPizovcQ9T2KSYGJriR3dsrA264a4TezCtOCyJsiSTzvy
         oF030NU8hX01nFZ723F13CutIVBeBamJjvcrg8wmSa40nyfSHzM5tibjCLlUCPwSYCHZ
         5F9tMh+UPCLyiDPpWVPc17Lg6D0mIQnAzhXEkOGq/FS05BO3pCNAa/kGcQx2IhZFKkNu
         YQiCt3GBQ9DrremRiKitAGWODSQI3mrXKB8zBELJJKGROHLpMHhdp9Vwye1LBXsy9JI4
         phPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization;
        bh=opzFVZrWphL638v+ecMPeic1OeJD7YaCPj4Gw1q7Ih4=;
        b=IHJPACIXSX3vItmLU4yMMAcB3f9V1vaLy3lVvQ4UPLb36d/khUfAgdQ6mAiCl5MRNC
         sYqchhUkJL8W65xO544lZq0NvffOMNQ46CjqkdtuUjGfmo+UJMwkpjodN+oARBTo4An/
         NJKKJP0HtLeDgPG7OWKzeMdovtPIG8rPc1nGhS3BZeE6RzKqtFANsTeo9mNAxbNOyCBy
         qHQoeSX/woeWaAo8Zp1fQhQimOwew368AkqiCteihv/TRDGeUfUOoayVkvD0ndJ1sbsO
         oWMo/wfjgGx86lN/wkF7lgEQP3E4vvNBBZCrC5bQMVHXvRND+sYuL0dP7ir8sIb7dRSv
         pUbQ==
X-Gm-Message-State: AOAM533qSjZDbfWQj4K2AsgVm4yK5QLZyi4fgrzbZmlebi7HkH+29Uy3
        Z6O/Px66NxHbXy9EokYqL9A=
X-Google-Smtp-Source: ABdhPJyev9RipY719UCpL0VcIbRkBmaQkfw8Jmuiq3gDh39gWrzj5fwrX2EEf2tKhSS3nIjIHMIGOA==
X-Received: by 2002:a17:90b:3806:b0:1d2:6e95:f5cc with SMTP id mq6-20020a17090b380600b001d26e95f5ccmr12578362pjb.23.1651487133974;
        Mon, 02 May 2022 03:25:33 -0700 (PDT)
Received: from localhost.localdomain ([123.201.245.164])
        by smtp.googlemail.com with ESMTPSA id j14-20020aa7800e000000b0050dc762816bsm4347953pfi.69.2022.05.02.03.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 03:25:33 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com
Subject: [PATCH v4 0/3] FUSE: Implement atomic lookup + open/create
Date:   Mon,  2 May 2022 15:55:18 +0530
Message-Id: <20220502102521.22875-1-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
Organization: DDN STORAGE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In FUSE, as of now, uncached lookups are expensive over the wire.
E.g additional latencies and stressing (meta data) servers from
thousands of clients. These lookup calls possibly can be avoided
in some cases. Incoming three patches address this issue.


Fist patch handles the case where we are creating a file with O_CREAT.
Before we go for file creation, we do a lookup on the file which is most
likely non-existent. After this lookup is done, we again go into libfuse
to create file. Such lookups where file is most likely non-existent, can
be avoided.

Second patch handles the case where we open first time a file/dir
but do a lookup first on it. After lookup is performed we make another
call into libfuse to open the file. Now these two separate calls into
libfuse can be combined and performed as a single call into libfuse.

Third patch handles the case when we are opening an already existing file
(positive dentry). Before this open call, we re-validate the inode and
this re-validation does a lookup on the file and verify the inode.
This separate lookup also can be avoided (for non-dir) and combined
with open call into libfuse. After open returns we can revalidate the inode.
This optimisation is performed only when we do not have default permissions
enabled.

Here is the link to performance numbers
https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamhans87@gmail.com/


Dharmendra Singh (3):
  FUSE: Implement atomic lookup + create
  Implement atomic lookup + open
  Avoid lookup in d_revalidate()

 fs/fuse/dir.c             | 211 +++++++++++++++++++++++++++++++++++---
 fs/fuse/file.c            |  30 +++++-
 fs/fuse/fuse_i.h          |  16 ++-
 fs/fuse/inode.c           |   4 +-
 fs/fuse/ioctl.c           |   2 +-
 include/uapi/linux/fuse.h |   5 +
 6 files changed, 246 insertions(+), 22 deletions(-)

---
v4: Addressed all comments and refactored the code into 3 separate patches
    respectively for Atomic create, Atomic open, optimizing lookup in
    d_revalidate().
---

