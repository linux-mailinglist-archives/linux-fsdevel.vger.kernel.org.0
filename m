Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766176E2936
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 19:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjDNRXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 13:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNRXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:23:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886C759ED
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 10:23:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w11so19508144pjh.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681492999; x=1684084999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VT+0HvHjEsU+vTXyoXG01Ki1olkigaqjaaxRq0h7zD0=;
        b=WrL85XgE0J/LewoQgL2BMdswzVLg7QxUJTeJeS9VQZ5mwgMS0mXn5j79U8flu5TuJM
         z4/yZGflE+2kIgss9MtM/oNaynA0Nj6+pnjAPxwGQYlkZStGQBpz6+69PMwvwf/tUmDo
         hPL2KatXFoFd7z490zNL1E2J3rvfdUrnhDaYzqu7rk/CmRAhz57TpyIpmr+DrNiEkrkj
         GMLR7H+tVsAiitRBa8rHFIKMzRFzPbkmWP7Lb45gwH0ALEwN8PFjwPnOg3yIDHH6ZKDD
         6i2oxR5RGyobbFO316EpC1EpP2KfQMGsluPOpOdYDgbE4zJq2jhCILSbhujNOBF1Wn2D
         woCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681492999; x=1684084999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VT+0HvHjEsU+vTXyoXG01Ki1olkigaqjaaxRq0h7zD0=;
        b=f5yvKNQUG3NawIDJvwFJQFachTNUfMdOXp13KRD1NV3Cwup/W15z4Tpg7hVu3bKHj+
         yM3DtuBVpVhUjiV+ul9dXMUwoGpel/+Spik3PO6oDFZAwZ5Wjecy8xTJ5BRxLdCSGza5
         CD+3yHKI3zrP6+BEHR/e5oyW8wgowUkiRZkWT2mr8d5ZhD+9HEI5jCSVAo4o7E1Vihnp
         m3/zxdHjutSZmvvNAY6YflUNFU5i2o+sB2XhklECNl/kXkT0S+0Qmfc8yAvmHY80yIih
         pMNhGnVcPc51uo6f3yX7b5hMFU+clM88Z4O7iqyoK+tWJOSjgkI8EgUzvW2bnABU/nyZ
         Tkpw==
X-Gm-Message-State: AAQBX9fcBWEc8rQBCNWaaOEY6T41yW+ujotZ18K+4MRdwVPw20u62fne
        Bb0tA94Ot4gBDmi6qartjvy5lw==
X-Google-Smtp-Source: AKy350YoK4w2okqy34rm4+OZcZLR+GQ/jupsYmqKLeW08OcJZwUp+2x19/ioiaHyOTYBH/N7bCnvVw==
X-Received: by 2002:a17:902:c951:b0:1a6:8ee3:4e2e with SMTP id i17-20020a170902c95100b001a68ee34e2emr4809363pla.33.1681492998912;
        Fri, 14 Apr 2023 10:23:18 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id q12-20020a631f4c000000b0051b8172fa68sm370315pgm.38.2023.04.14.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:23:18 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
        hsiangkao@linux.alibaba.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V6 0/5]  Introduce daemon failover mechanism to recover from crashing
Date:   Sat, 15 Apr 2023 01:22:34 +0800
Message-Id: <20230414172239.33743-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since v5:
In cachefiles_daemon_poll(), replace xa_for_each_marked with xas_for_each_marked.

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
https://github.com/userzj/linux/tree/fscache-failover-v6

RFC: https://lore.kernel.org/all/20220818135204.49878-1-zhujia.zj@bytedance.com/
V1: https://lore.kernel.org/all/20221011131552.23833-1-zhujia.zj@bytedance.com/
V2: https://lore.kernel.org/all/20221014030745.25748-1-zhujia.zj@bytedance.com/
V3: https://lore.kernel.org/all/20221014080559.42108-1-zhujia.zj@bytedance.com/
V4: https://lore.kernel.org/all/20230111052515.53941-1-zhujia.zj@bytedance.com/
V5: https://lore.kernel.org/all/20230329140155.53272-1-zhujia.zj@bytedance.com/

Jia Zhu (5):
  cachefiles: introduce object ondemand state
  cachefiles: extract ondemand info field from cachefiles_object
  cachefiles: resend an open request if the read request's object is
    closed
  cachefiles: narrow the scope of triggering EPOLLIN events in ondemand
    mode
  cachefiles: add restore command to recover inflight ondemand read
    requests

 fs/cachefiles/daemon.c    |  15 +++-
 fs/cachefiles/interface.c |   7 +-
 fs/cachefiles/internal.h  |  59 +++++++++++++-
 fs/cachefiles/ondemand.c  | 166 ++++++++++++++++++++++++++++----------
 4 files changed, 201 insertions(+), 46 deletions(-)

-- 
2.20.1

