Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222A24E3DD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 12:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiCVLxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 07:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiCVLxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:53:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E68D8022C;
        Tue, 22 Mar 2022 04:52:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j13so5334216plj.8;
        Tue, 22 Mar 2022 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:organization;
        bh=YQr4wEg51EwC/v7lwXtLcMJn8sCdqqPgFeB/1p6d61k=;
        b=VdyPkytt/KroavdVQ49PIc3j20+4tFQ6G6OV2wUgxi2w2T0CWaeOZPh2Vd3OcMKhYn
         PVepYlBwYhtTJTtwI6x7GmgGVAA3mLGqhafLal6oQ15wJP4eV/b7bX7Ol1dJvmCYluTs
         /IGRnnpmTb40hiMRJmssxO4T6iNEibz9LjLVJm+Sl4eLvWgmRZyN7OQq3lsJbKcYiIx8
         p8RwATIM3qPZUYjXl2Q/pdRivUT0smVT+KJM4cqDF3r/PDztbDy+3Zj1nby6CWnbb4aW
         UM71Bnkg/xH1KcSFbNPjbhciBeX0ORMKqhJbnQTOxHakxJdvLskSz4LUh+fmb313EoGS
         67hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization;
        bh=YQr4wEg51EwC/v7lwXtLcMJn8sCdqqPgFeB/1p6d61k=;
        b=ntsQi/VHhRee5cHnxVvndQtAkmBcKj5350RCJb5tHYYUA7QVpqZmZVIHsfu2H0RB7M
         3CKW2co604E3SjX+syMBf2cpVWP1NpogIy5HNT+urAyxO2o9Hz6CLvNTzDEYx9+iZdU7
         OgxCxNEF+PKjeoXendOuOd1ZZdHEr3Y8GffcPYj+QUbdRH6WU2Z9YISKYg9v1CsE6eUo
         JhhI7H63eRyn6vysWn7mi5V2a3vLMnOa8YJrSbIL1GVoMbuUHuPI0qkZAk/IDGovTMMD
         KcttYF1gfiVyQLoXZrMD6tYpKcqI7MKpoybVq46/xUFGjZvR1n/qT7lVDmn5xQrlHL1K
         xo+w==
X-Gm-Message-State: AOAM53209ABGk+ro9reHUCf7VZrKOjw317dxT7FCata2u50S0pJmaWDU
        +d5FXhSHp9kC/MVuamxsqIPzvogFiYFK9A==
X-Google-Smtp-Source: ABdhPJxU113mcucMtQpIgvQPz7jTXOHWTqrqWsK/j5R28m2kVaotD0dsNj7PkyqDmuaVZNqJtDhBIQ==
X-Received: by 2002:a17:90a:2e0e:b0:1bc:dbe:2d04 with SMTP id q14-20020a17090a2e0e00b001bc0dbe2d04mr4627984pjd.74.1647949925692;
        Tue, 22 Mar 2022 04:52:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:4053:719:67ea:fc62:7f30:7002:e0c2])
        by smtp.googlemail.com with ESMTPSA id h17-20020a63df51000000b0036b9776ae5bsm17147274pgj.85.2022.03.22.04.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 04:52:05 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] FUSE: Implement atomic lookup + open 
Date:   Tue, 22 Mar 2022 17:21:46 +0530
Message-Id: <20220322115148.3870-1-dharamhans87@gmail.com>
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
in some cases. Incoming two patches addresses this issue.

First patch handles the case where we open first time a file/dir or create
a file (O_CREAT) but do a lookup first on it. After lookup is performed
we make another call into libfuse to open the file. Now these two separate
calls into libfuse can be combined and performed as a single call into
libfuse.

Second patch handles the case when we are opening an already existing file
(positive dentry). Before this open call, we re-validate the inode and
this re-validation does a lookup on the file and verify the inode.
This separate lookup also can be avoided (for non-dir) and combined
with open call into libfuse.

Here is the link to the libfuse pull request which implements atomic open
https://github.com/libfuse/libfuse/pull/644

I am going to post performance results shortly.


Dharmendra Singh (2):
  FUSE: Implement atomic lookup + open
  FUSE: Avoid lookup in d_revalidate()

 fs/fuse/dir.c             | 179 +++++++++++++++++++++++++++++++++-----
 fs/fuse/file.c            |  30 ++++++-
 fs/fuse/fuse_i.h          |  13 ++-
 fs/fuse/inode.c           |   4 +-
 fs/fuse/ioctl.c           |   2 +-
 include/uapi/linux/fuse.h |   2 +
 6 files changed, 204 insertions(+), 26 deletions(-)

-- 
2.17.1

