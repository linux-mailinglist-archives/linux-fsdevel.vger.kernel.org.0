Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C19D5FE740
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 05:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJNDIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 23:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJNDIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:08:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F2C18A3D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 20:07:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h10so3575358plb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 20:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tR+LEXzrwnagFeN1X0qgpjAc8sXMoTZWp+ylsCx2Q8o=;
        b=j7OAaYtj4gywSty7236efJMlTd/eu1sIqqWbPt8D+9YFUIliYfpSpcCP0RVtqISuqu
         EUApBFrH2c13AslkzH2kxWWxVhadCyNF/XhwEb1+wO1wlOTaN9UmHTqGz6A7dGpsv7YF
         it1z3ccyiqrCduYkbdGYj6lFMob/8GWFUxSCLiEfqRHYmzWYMz69f2joQ1gse4CahmQo
         B0QilVGK3KBdC876cBFng16Xiyd/XBhGL3l+BQpBzVtwxcRpIqlzRC0RzVLV7IIzDFrN
         seYRGXSdBD8Bnk7v8XEuCwP6nYfyx4K0Y2PGOehom5FlQdP1PnCIfIsZ1rHUoEYjSv2F
         SSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tR+LEXzrwnagFeN1X0qgpjAc8sXMoTZWp+ylsCx2Q8o=;
        b=4Zf3KO1dSx91UelBVB/i8HhAt3X7Yl03q4lxXSLk+JzRilDIt33EIN8oS9ly14pQqk
         ZxzMXvGSBbqCA9AdKt0MYaOKmuFfpeGANZzRqvhVLZDJseEdcaJRB7t9853OGTYwHjqi
         1n+oY3PxfVD2GjUS6QCZYLWp4vEAbig4YI8Ux+FAljScDD0m2+OjymprAZa2o0MF/zhV
         xncaUV4Yg3yK296T8Lhum03mRHOk/sCTPt3OX4O6P0mP8FNmZLnCpEPLlip+9Yu+YBC3
         qtZIwWzI3Z/OkTDQP5eKQ9zAh4AjKy04QfLqfbwmxrkMH2ybnhgL7p9xYuZfSIrGAzHO
         VYnA==
X-Gm-Message-State: ACrzQf3/ZsNjuA0QnrO3BUAfTU57f7QC9rthV4cMu9nRUk3WJb8kei5Z
        s7pcS+XLydvVizyY8xEnmOv1QA==
X-Google-Smtp-Source: AMsMyM6fZ2yYhCzfqcA1T5TPO16rRcN9qdwd1V7oXdpGUkUt1ol+W9QIVGnrnP7azUmdi3NbdWxY1Q==
X-Received: by 2002:a17:903:2307:b0:17f:78a5:5484 with SMTP id d7-20020a170903230700b0017f78a55484mr2957038plh.15.1665716879180;
        Thu, 13 Oct 2022 20:07:59 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.183])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090a710400b0020ae09e9724sm425524pjk.53.2022.10.13.20.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:07:58 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V2 0/5] Introduce daemon failover mechanism to recover from crashing
Date:   Fri, 14 Oct 2022 11:07:40 +0800
Message-Id: <20221014030745.25748-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since V1:
1. Extract cachefiles_ondemand_select_req() from cachefiles_ondemand_daemon_read()
   to make the code more readable.
2. Fix a UAF bug reported by JeffleXu.
3. Modify some code comments.

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
https://github.com/userzj/linux/tree/fscache-failover-v3

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
 fs/cachefiles/internal.h  |  58 +++++++++++++-
 fs/cachefiles/ondemand.c  | 156 ++++++++++++++++++++++++++++----------
 4 files changed, 188 insertions(+), 46 deletions(-)

-- 
2.20.1

