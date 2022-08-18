Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC95984DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 15:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245332AbiHRNwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 09:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245023AbiHRNwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:52:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AA85F214
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 06:52:38 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 73so1336716pgb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JIt9Hr3bnXwA/tRzFdUUjJF8ICdMOLH9UGftglFwKs0=;
        b=rx0D5/86CeH9rfls9cK+ovoX6WXvUqWR5yR9uWVkAKmXOMBXx94XSUUEx7H3dppxqk
         0XJR0QcosZQsZamTxInDJnivdwpSHeRDS7y+llNNp3dHBXKLlc83/VJ+oArwJUMP+Ur9
         hIakH/6FLBjhAayfoOwo57F1c+VwhPJPl75FCbrvtgwAsTgdYkGDCuaGwxaREE04BMCc
         9/3Ec7a5OdzkzyAJmB0OJO55kdOjDp6dWJYnm8UQ57HxpVflXFA9vdb/6+FzlSJG4K3K
         uFF3mhw+/UR6CUVl+qU+0YH4tGfsv+KRtARIieVUP/aShtVfQotfAsAiNQMPAR2Vmocd
         ZaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JIt9Hr3bnXwA/tRzFdUUjJF8ICdMOLH9UGftglFwKs0=;
        b=NiskbElLpvtRMeoJjB7zfLopCQVOWLXt72iyhXaZFawAl20qQbrR3fj3tlNBbwrm59
         H9sDHYnMkycVDYFGTq1L1ATwA7KEQpXw/cur8juwJp+pDIZuHUulj/ZqCGwMVJ6w91SD
         DPhrZIwZPnJ50xGjnIP7INGC/U9WiToWgnyAlwLcEU7+SNFz6X02NqqOntaotoeS28s2
         hfL45Do6lNUX3EoQgnlzrcroa1amR5ciy7AuBrkDD2BXsO5U8yezPfU4fYJ+V7Obp2l5
         zlNUt+zdl8jL8uuOSSdJix85UTNIljbh6KL0F78rR0NqHTt3VXdnDPaMu875bpgqQAXp
         aa5w==
X-Gm-Message-State: ACgBeo23GtRLRqgGGoo2f9Poli1b3PGqF9HIu/OBguWDkg3dzpexISXj
        74b5Gmp4LMu/nHrJpyVq1uqObg==
X-Google-Smtp-Source: AA6agR7dyQJ+ORPyUmexb/HyRV/vRty6JE9R9UJyqOx4rKaS8Fn0kNA5WBhPQP1h+roc/IdDaQXkGQ==
X-Received: by 2002:a63:698a:0:b0:41c:8dfa:e622 with SMTP id e132-20020a63698a000000b0041c8dfae622mr2473637pgc.465.1660830758358;
        Thu, 18 Aug 2022 06:52:38 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ce1100b0016db0d877e4sm1385697plg.221.2022.08.18.06.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:52:37 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [RFC PATCH 0/5] Introduce daemon failover mechanism to recover from crashing
Date:   Thu, 18 Aug 2022 21:51:59 +0800
Message-Id: <20220818135204.49878-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Background]
============
In ondemand read mode, if user daemon closes anonymous fd(e.g. daemon
crashes), subsequent read and inflight requests based on these fd will
return -EIO.
Even if above mentioned case is tolerable for some individual users, but
when it happenens in real cloud service production environment, such IO
errors will be passed to cloud service users and impact its working jobs.
It's terrible for cloud service stability.

[Design]
========
This patchset introduce three states for ondemand object:
CLOSE: Object which just be allocated or closed by user daemon.
OPEN: Object which related OPEN request has been processed correctly.
REOPENING: Object which has been closed, and is drived to open by a read
request.

[Flow Path]
===========
[Daemon Crash] 
0. Daemon use UDS send/receive fd to keep and pass the fd reference of
   "/dev/cachefiles".
1. User daemon crashes -> restart and recover dev fd's reference.
2. User daemon write "restore" to device.
   2.1 Reset the object's state from CLOSE to OPENING.
   2.2 Init a work which reinit the object and add it to wq. (daemon can
       get rid of kernel space and handle that open request).
3. The user of upper filesystem won't notice that the daemon ever crashed
   since the inflight IO is restored and handled correctly.

[Daemon Close fd]
1. User daemon closes an anonymous fd.
2. User daemon reads a READ request which the associated anonymous fd was
   closed and init a work which re-open the object.
3. User daemon handles above open request normally.
4. The user of upper filesystem won't notice that the daemon ever closed
   any fd since the closed object is re-opened and related request was
   handled correctly.

[Test]
======
There is a testcase for above mentioned scenario.
A user process read the file by fscache ondemand reading.
At the same time, we kill the daemon constantly.
The expected result is that the file read by user is consistent with
original, and the user doesn't notice that daemon has ever been killed.

https://github.com/userzj/demand-read-cachefilesd/commits/failover-test

[GitWeb]
========
https://github.com/userzj/linux/tree/fscache-failover-v1

Jia Zhu (5):
  cachefiles: introduce object ondemand state
  cachefiles: extract ondemand info field from cachefiles_object
  cachefiles: resend an open request if the read request's object is
    closed
  cachefiles: narrow the scope of triggering EPOLLIN events in ondemand
    mode
  cachefiles: add restore command to recover inflight ondemand read
    requests

 fs/cachefiles/daemon.c    |  14 +++-
 fs/cachefiles/interface.c |   6 ++
 fs/cachefiles/internal.h  |  74 ++++++++++++++++++++-
 fs/cachefiles/ondemand.c  | 135 ++++++++++++++++++++++++++++----------
 4 files changed, 193 insertions(+), 36 deletions(-)

-- 
2.20.1

