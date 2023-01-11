Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D84C6653C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 06:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbjAKFh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 00:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjAKFgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:36:47 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CF212D1C
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 21:25:26 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q64so14719785pjq.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 21:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zKLZ4cMF4VZH8zOzNr6plvSw69rGNAVsqBjH7W6v6Q=;
        b=z5siAmwL0KyX3ZAkTakARazMKr4W80Evyjiap3KoB249oAn29O0Wc3a89zZfNTxmCU
         nakN0bq7rIJkBBmlXBQwwNCv+/WeFVOPAOTRi23O0o9Iz9Ne9emioRPjfG0HP41SdG9E
         ry5CoGjhHruyyIPsQv3JoOHUc2TvuZ5jB76HRNGT4ORAt97bReLLosizCUFaqtvurzGJ
         Tu/Wcd3fqr3drSAhKbIfCm1yWcYBhTdlL1/IgjPn1rUzPs0SiHUYVMa03x7ImQ4CmSLY
         hSyurk8FXo6tB/5sq0k/kUEm6CEsxs3aw82aE1ugLgymue/qO0lEOfdPi5Q+iGSkDMao
         zn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zKLZ4cMF4VZH8zOzNr6plvSw69rGNAVsqBjH7W6v6Q=;
        b=dSynwyw+oaS8BKOZA39Bw2/NwW7V7P/te33I6hKyZ0ajuL9/I0X0qv1QZNqIBJ/hpJ
         uaAFHRJAsF4Wh8MLjae9nwBaIl1QCK2JI4S6V00vsmZHThkYhzZsl2hTLgTAfXJnoGTi
         5H7dDVK4q8wp52+Y1ei+gV/S5MT0driqNtOM6Mvw1ckf+eEVQYeMFsrvrhFes8kQtYY0
         ZNenKNn2jwNNu/AKtm6SoxtQKCa/7NXhepvYduBu8Nh3ESrvL4a35cO4j27yal1ZeY87
         fU8WkCuUugviKFYVCUYYzNdAGBqgeoaHtHR+89Sz07rlhpTLWY5ZVP9rBt5vElHd5ubq
         VPtg==
X-Gm-Message-State: AFqh2kpKGsyrATtdt0LzwaMSq0BYi5haB+1WZlYcnOzd49v97Ousyefw
        1asrCbBlQiD2cQ84tN5RFZhUXA==
X-Google-Smtp-Source: AMrXdXskv4V+w6rv13eZ0t91lgtE+UkuxrtFOIPL7NLfX0z7KikkZVtz4uyclgawuLN/+DOvISOr+g==
X-Received: by 2002:a17:902:9b8f:b0:192:6d68:158 with SMTP id y15-20020a1709029b8f00b001926d680158mr66117737plp.15.1673414725912;
        Tue, 10 Jan 2023 21:25:25 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b0019334350ce6sm4934520pls.244.2023.01.10.21.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 21:25:25 -0800 (PST)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V4 0/5] Introduce daemon failover mechanism to recover from crashing
Date:   Wed, 11 Jan 2023 13:25:10 +0800
Message-Id: <20230111052515.53941-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since v3:
1. Add xa_lock for traverse xarray in cachefiles_daemon_poll(). 
2. Use macro to simplify the code  in cachefiles_ondemand_select_req().

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
The main idea of daemon failover is reopen the inflight req related object,
thus the newly started daemon could process the req as usual. 
To implement that, we need to support:
	1. Store inflight requests during daemon crash.
	2. Hold the handle of /dev/cachefiles(by container snapshotter/systemd).
BTW, if user chooses not to keep /dev/cachefiles fd, failover is not enabled.
Inflight requests return error and passed it to container.(same behavior as now).

[Flow Path]
===========
This patchset introduce three states for ondemand object:
CLOSE: Object which just be allocated or closed by user daemon.
OPEN: Object which related OPEN request has been processed correctly.
REOPENING: Object which has been closed, and is drived to open by a read
request.

1. Daemon use UDS send/receive fd to keep and pass the fd reference of
   "/dev/cachefiles".
2. User daemon crashes -> restart and recover dev fd's reference.
3. User daemon write "restore" to device.
   2.1 Reset the object's state from CLOSE to REOPENING.
   2.2 Init a work which reinit the object and add it to wq. (daemon can
       get rid of kernel space and handle that open request).
4. The user of upper filesystem won't notice that the daemon ever crashed
   since the inflight IO is restored and handled correctly.

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
https://github.com/userzj/linux/tree/fscache-failover-v5

RFC: https://lore.kernel.org/all/20220818135204.49878-1-zhujia.zj@bytedance.com/
V1: https://lore.kernel.org/all/20221011131552.23833-1-zhujia.zj@bytedance.com/
V2: https://lore.kernel.org/all/20221014030745.25748-1-zhujia.zj@bytedance.com/
V3: https://lore.kernel.org/all/20221014080559.42108-1-zhujia.zj@bytedance.com/

Jia Zhu (5):
  cachefiles: introduce object ondemand state
  cachefiles: extract ondemand info field from cachefiles_object
  cachefiles: resend an open request if the read request's object is
    closed
  cachefiles: narrow the scope of triggering EPOLLIN events in ondemand
    mode
  cachefiles: add restore command to recover inflight ondemand read
    requests

 fs/cachefiles/daemon.c    |  16 +++-
 fs/cachefiles/interface.c |   6 ++
 fs/cachefiles/internal.h  |  57 +++++++++++++-
 fs/cachefiles/ondemand.c  | 160 ++++++++++++++++++++++++++++----------
 4 files changed, 192 insertions(+), 47 deletions(-)

-- 
2.20.1

