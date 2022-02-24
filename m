Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E354C225A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 04:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiBXD2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 22:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBXD2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:28:01 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1E5144F5C;
        Wed, 23 Feb 2022 19:27:32 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id l9so133850pls.6;
        Wed, 23 Feb 2022 19:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:organization;
        bh=4RCSOSz1s5gUcQ6WfXIYAmExC36/ZKP+g8T1y22c4Rk=;
        b=jDvi5G8KTlANR/St8z6PYv5+G60GaBXmUyvu/kwrDo6ylbezT3pnrPP3toMbRK3JoX
         YQprI8a4xvp2zofCcR6iIOnuXOE63yoOU0cysaKUHlQgFBY1NWqtQZyB+jA7qarBlz0Y
         bP3siFOxTu6ue8fR1+rlEAwpTZWizlo5xrguHK1TNcOVZ/eJp+cYnz2xDlpU0N2erIur
         nJw2UCdlKk/dJpBqofk4dR2Dw0zUBnIaM7BRx5LGNk82I6RxHjjBHl97BKkU8rt/ZXSX
         wR/WgO4cl6CilagNCc2/9ylcHDPhBmtjDonNryluNmosmf+62iWw2eFMgPzvxiYAFp0r
         Ux2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization;
        bh=4RCSOSz1s5gUcQ6WfXIYAmExC36/ZKP+g8T1y22c4Rk=;
        b=AvAgycDrmraUCx7627+YWaeF736ws/yj+tV3NzimNSNb0/OuhvWt4Q9VKNK1NF3HS6
         p8HTOAeVGjbdIiAdk3XQkgAuyYab3Z9P7wW8Q9L4BGpmPMIObQU96UBpogZGA+cNSJ/4
         rvIoEj7RvJOInzabbBbid7KYvSH/KBQhDkNTwT6s9YF+C4YIcx1PEWrjhqnlHcU1LQyL
         T9FGQdRhvlZONJHepLeygFd37MLcm+aHc9i/qcy/FjZR4f46ynwuDyNyt1kVnA7hp62J
         hVF3MJ/QeJquUeZaLr1M1ah/4tzEmBjuRp+x6tuP6JKX1iR12Ktu2S8PR9/QnW4gSkgh
         9lEw==
X-Gm-Message-State: AOAM531Yay3xIJF8aJCeuoXJtWu+ElKWZEEbxelzVq3l4OC7r86JkSnK
        1laiVMPk1D46PT/gbYWdMgfcGtJ1Mxdk7T2zfWI=
X-Google-Smtp-Source: ABdhPJyKhS1aReVHpv/3raEn/PB1VNmKG8Hq7CWSk0Nke9SsOu18fuXvALWndQcfnDFQXviBWiFkqg==
X-Received: by 2002:a17:90a:9288:b0:1bc:568b:55bc with SMTP id n8-20020a17090a928800b001bc568b55bcmr768005pjo.9.1645673252087;
        Wed, 23 Feb 2022 19:27:32 -0800 (PST)
Received: from localhost.localdomain ([123.201.194.48])
        by smtp.googlemail.com with ESMTPSA id 23-20020a17090a0d5700b001bc3c650e01sm7236178pju.1.2022.02.23.19.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 19:27:31 -0800 (PST)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] FUSE: Implement atomic lookup + open
Date:   Thu, 24 Feb 2022 08:53:35 +0530
Message-Id: <20220224032337.19284-1-dharamhans87@gmail.com>
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

FUSE, as of now, makes aggressive lookup calls into libfuse in certain code
paths. These lookup calls possibly can be avoided in some cases. Incoming
two patches addresses the issue of aggressive lookup calls.

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

Here is the link to libfuse patches which implement atomic open

https://github.com/d-hans/libfuse/commit/5255ce89decac71912e25b3cb4d79ebac538a456
https://github.com/d-hans/libfuse/commit/346b9feb2de5b6ff2b15882a38d7de0a0768c17c
https://github.com/d-hans/libfuse/commit/ac010dac446a9267b619afb138ab315d6c6eeb3e


Dharmendra Singh (2):
  FUSE: Implement atomic lookup + open
  FUSE: Avoid lookup in d_revalidate()

 fs/fuse/dir.c             | 170 +++++++++++++++++++++++++++++++++-----
 fs/fuse/file.c            |  30 ++++++-
 fs/fuse/fuse_i.h          |  13 ++-
 fs/fuse/inode.c           |   4 +-
 fs/fuse/ioctl.c           |   2 +-
 include/uapi/linux/fuse.h |   2 +
 6 files changed, 195 insertions(+), 26 deletions(-)

-- 
2.17.1

