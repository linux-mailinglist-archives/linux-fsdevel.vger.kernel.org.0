Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB9659A9D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 02:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbiHTAGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 20:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244099AbiHTAGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:06:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CCAC57B6;
        Fri, 19 Aug 2022 17:06:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso8927594pjl.1;
        Fri, 19 Aug 2022 17:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=yC00KE65j+Axy9FPULOY4KYbcVa1VjZuo+YDP6XI95c=;
        b=RMMBtA5Fx7V8blcknadGehzfeRW+h+ppNKjgIpKLfxTU/cZ1zlbKFM9VPw9VNZkEpG
         H1iehANPbjI3U5YxKzRq1K0nldERCwzoZywEThoJv5j9Js0MljA/umBi9uimEG0ThlOk
         3Qh2gaeXVmDpuASGHyNtPDd+udonwXvnxxSjgnpRxwNk4KDl3WXI9LznxzPUh9ZKRAqp
         eYQbmSTai3LlBTfUxzW2/ZXOOBMuSFyJ/32q4fqPK8JJeTdSGu4KKqi/JCmtm7cI9EAE
         2HH/1jZEmbFhf3mWtRIOOQHcSiLyFs8HH03vzOfumDGrngSjl250GpH84puPCU6XJXmQ
         WjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=yC00KE65j+Axy9FPULOY4KYbcVa1VjZuo+YDP6XI95c=;
        b=rxRPPGXg/sw0nYkKyyeNVgiXODHUoCpEaD0imTui4knMQOtjy/DhmBbK12l+XJ81R0
         81wrbKFXDefS2Y8tdudPWuXU8jNyRrzfGNWNhHvAB5OM9Bz8DmrtmCLAPWbXiB71NQ55
         o/Wm6tHMj6Wk+UETFta4LwcI5m9iHccsaVpnCrO0qi91UF909nMjlANOaxBe0jCAcPpp
         bMZAA8RF2HBp7oiMyyo5TRTHUhU1PD7Wvhaa91Lg9HoBcT5SXZIFV5siOQ+MyQoIfPf2
         PE7zx9jJf2N4f8JITwc7A5aTmI7xIm+BYNJuhOiKOLBefesBP6FCzvMmxpsnZdjbETA6
         8NMA==
X-Gm-Message-State: ACgBeo2jNUGfjTHectf5Q2+X2/g+uh/oPohXEbL5ZDKKUd890GWtMtsc
        cmUSuXiWb+hEhZKVeV8vbGA=
X-Google-Smtp-Source: AA6agR6uDi3t5sGu/sHmEspJdx7iqNOlWZ5ekNYrNy+qurpUU1ONjj6Q3BdIaqMCdIqsHj4RrHlpBQ==
X-Received: by 2002:a17:902:d492:b0:16f:8583:9473 with SMTP id c18-20020a170902d49200b0016f85839473mr10037458plg.103.1660953961038;
        Fri, 19 Aug 2022 17:06:01 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a2f5])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b0016b81679c1fsm3676888pli.216.2022.08.19.17.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 17:06:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
Subject: [PATCHSET for-6.1] kernfs, cgroup: implement kernfs_deactivate() and cgroup_file_show()
Date:   Fri, 19 Aug 2022 14:05:44 -1000
Message-Id: <20220820000550.367085-1-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Currently, deactivated kernfs nodes are used for two purposes - during
removal to kill and drain nodes and during creation to make multiple
kernfs_nodes creations to succeed or fail as a group.

This patchset make kernfs [de]activation generic so that it can be used
anytime to deactivate (hide and drain) and activate (show) kernfs nodes,
and, on top, implement cgroup_file_show() which allows toggling cgroup file
visiblity.

This is for the following pending patchset to allow disabling PSI on
per-cgroup basis:

 https://lore.kernel.org/all/20220808110341.15799-1-zhouchengming@bytedance.com/t/#u

which requires hiding the corresponding cgroup interface files while
disabled.

This patchset contains the following seven patches.

 0001-kernfs-Simply-by-replacing-kernfs_deref_open_node-wi.patch
 0002-kernfs-Drop-unnecessary-mutex-local-variable-initial.patch
 0003-kernfs-Refactor-kernfs_get_open_node.patch
 0004-kernfs-Skip-kernfs_drain_open_files-more-aggressivel.patch
 0005-kernfs-Make-kernfs_drain-skip-draining-more-aggressi.patch
 0006-kernfs-Allow-kernfs-nodes-to-be-deactivated-and-re-a.patch
 0007-cgroup-Implement-cgroup_file_show.patch

0001-0003 are misc prep patches. 0004-0006 implement kernsf_deactivate().
0008 implements cgroup_file_show() on top. The patches are also available in
the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git kernfs-deactivate

diffstat follows. Thanks.

 fs/kernfs/dir.c             |  120 +++++++++++++++++++++++++++++++++++++++++-------------------
 fs/kernfs/file.c            |  139 +++++++++++++++++++++++++++++++---------------------------------------
 fs/kernfs/kernfs-internal.h |    1
 include/linux/cgroup.h      |    1
 include/linux/kernfs.h      |    2 +
 kernel/cgroup/cgroup.c      |   23 +++++++++++
 6 files changed, 172 insertions(+), 114 deletions(-)

--
tejun


