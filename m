Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311A2516A6B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358661AbiEBFuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 01:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiEBFuM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 01:50:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1313F3EA86;
        Sun,  1 May 2022 22:46:44 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id j70so42978pge.1;
        Sun, 01 May 2022 22:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:organization;
        bh=d2sZ6LAA6PR0x27xVOtSQG3kRY2KKeJ2IQ3gWRqZVIo=;
        b=T8sg8k9C909HP0duHI63v0WZEYqGHr5ItIb7FPVV9puDAWn40w/mJNDlWJh3sr1gkg
         dGKY5saYavSKmFsOiZxmI41WxUpbgeg+lkOd6QB/VYO0rtSLSwwkIvkIrKldbL9e4R9v
         gHgTBnkD8TItilnYqDRBsxOJto/cBLvoLXvtOqaiNviww5G4i+LqAYJFabA8f9R7GG9T
         x8nzo9z21yF1wwLNy6SpgEtq3LVv1e3pKcOUzeVxSzFmGuK5Dg57LQlnnh0zcW/lKX1T
         HRSJ3GakzcUqF5Pn5/DCdfsNDc7qcv6qXBwxb97LnogR7KONlNewfDgrenQiVMUg6LZR
         F57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization;
        bh=d2sZ6LAA6PR0x27xVOtSQG3kRY2KKeJ2IQ3gWRqZVIo=;
        b=wWAy0G9qrAPnoyKHYYHFNTDHfy6BokvPV6YU7a++zVvsoYxNbSg4SWEYEaMOu5zL9K
         xpjMQJXOKY/g0Lzmjc2rHMKnW8oDpW+3bbjVFY0sHa8jhzj1qpmcWGnmFBMnZZb51m+7
         frz+uXgn1xwBxLiwFG+qkHA9hvXR8frD1kwNnWSfSGQdFQC4xX2PnG76T2MuoP0AD3Un
         irGlZuUsVPaekcR6GmGwNzlXEsAU+nuyWdujvjJD47tBpUvgU2fGGNLaZMcfeJIkFaMI
         1YL0vvniDnKcQbZWgLA8MR5CpTPcccJGZ3PDm5b/qMhOVoTHCeOgwFXKF3fPGaaxJvHh
         nZ0A==
X-Gm-Message-State: AOAM5320yO/TpwOPsSml2HbGmhvluQZnSh3vWeOj9jRTbUOtprthxuPs
        33zIB2B0Bu+7h0XlFOTKU0g=
X-Google-Smtp-Source: ABdhPJyk/Nt4ElAZAqLKKwQRG8TYcrx9es15INWArvFBRZIb9QURz78XomggWsGCMne2rbLgR3jW0w==
X-Received: by 2002:a63:8342:0:b0:3c2:1938:236a with SMTP id h63-20020a638342000000b003c21938236amr2879326pge.48.1651470403219;
        Sun, 01 May 2022 22:46:43 -0700 (PDT)
Received: from localhost.localdomain ([123.201.245.164])
        by smtp.googlemail.com with ESMTPSA id q20-20020a62e114000000b0050dc76281c8sm3787490pfh.162.2022.05.01.22.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 22:46:42 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com
Subject: [PATCH v3 0/3] FUSE: Implement atomic lookup + open/create
Date:   Mon,  2 May 2022 11:16:25 +0530
Message-Id: <20220502054628.25826-1-dharamhans87@gmail.com>
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

 fs/fuse/dir.c             | 210 +++++++++++++++++++++++++++++++++++---
 fs/fuse/file.c            |  30 +++++-
 fs/fuse/fuse_i.h          |  16 ++-
 fs/fuse/inode.c           |   4 +-
 fs/fuse/ioctl.c           |   2 +-
 include/uapi/linux/fuse.h |   5 +
 6 files changed, 245 insertions(+), 22 deletions(-)

-- 
2.17.1

