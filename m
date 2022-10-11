Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336E45FB32B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 15:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJKNR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJKNRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:17:16 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0949D33849
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 06:16:23 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id d64so15786348oia.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0QJPhughD80u7ewLF/tLA+xOCDrl/cfryqlkNyAxbY=;
        b=rY+PWlvEEZtJ+HmXXbLiYRgNbuvRmBZeRWVqWpI2rKqCJccNk+ZqopV4EPVf1Q0qpz
         B/bSu3cokc+8EocLFcORWfEckjlHkoHjle5UXU3LwaAwXMLI74KLRyCQgWf09lg25Fbi
         4JmNle7Lcw5uqueqRyJ1df3nmHfLiu0IgnMBkvPYpe+KLtFYw0Ww5lwTXssb5cK9LeDB
         F5zYYGYT1ENpmoXg3MC5MD4+rPPPx5EkwjlylMTlRTQxytrEPhJSetBoYUpx2Lj7XSuO
         iGmbMyCobXc/Zm0gUG3FfaX3ouOgzkVB+yV8TKFoC9BVySClixuELZ5bX8Xtpsxojzyh
         +sXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0QJPhughD80u7ewLF/tLA+xOCDrl/cfryqlkNyAxbY=;
        b=5LpvpuwO7frstEGCZhNNDQ8A7R0S8MwK9e6NEZGVAUkYU/w3kGijEjrWSN5Rm2tkBB
         0B8SF7BPfGyO4R5X7YXDb6qr2/qocVcwBEvuv/IuTQg9CJ0jRR8euNjfcsR71fif4Kay
         Rk4a6qqHA0afO8b9PkgR2KSv9cF+lVBlRxSgDDu164PIMjoAOTrLlSzUzapElofO+b3r
         XJc9Hg2HTt5J98XLH6x9UgY89WrJutPOWgqln4Yp70Nh7rOgfP/KsHxisNJ8M9Nq7Nyo
         56V3A9GqGFqoafX/EH8WC1+OTpfm/NKoHzPEuvfNfFC4zBU+g66Zb2//VCQgT73UsyHN
         jApw==
X-Gm-Message-State: ACrzQf3VmsyGR14taDQhNWtGUX6Qj7BOmavLnvAPmZtVvsgJu20lxZLQ
        Xy/rhdHaG/5hwr5Xw9Sv5uZBJI+iXlN6lLX+
X-Google-Smtp-Source: AMsMyM6VuhiNMjdIO3SyvCAmXoE9oQdlr+6UO2h2kSoiH3hgKQ+xUOuHexT0ia7yWQdNOXMDI90tHA==
X-Received: by 2002:a17:90a:d983:b0:20a:ec04:e028 with SMTP id d3-20020a17090ad98300b0020aec04e028mr35546281pjv.122.1665494165504;
        Tue, 11 Oct 2022 06:16:05 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.190])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b00181f8523f60sm4773415pln.225.2022.10.11.06.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:16:05 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH 0/5] Introduce daemon failover mechanism to recover from crashing
Date:   Tue, 11 Oct 2022 21:15:47 +0800
Message-Id: <20221011131552.23833-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

Changes since RFC:
1. Solve the conflict with patch "cachefiles: make on-demand request distribution fairer" 
2. Add some code comments.
3. Optimize some structures to make the code more readable.
4. Extract cachefiles_ondemand_skip_req() from cachefiles_ondemand_daemon_read()
   to make codes more intuitional.

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
https://github.com/userzj/linux/tree/fscache-failover-v2

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
 fs/cachefiles/internal.h  |  71 ++++++++++++++++-
 fs/cachefiles/ondemand.c  | 155 +++++++++++++++++++++++++++++---------
 4 files changed, 205 insertions(+), 41 deletions(-)

-- 
2.20.1

