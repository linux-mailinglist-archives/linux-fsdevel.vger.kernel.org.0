Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61F558B11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 00:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiFWWG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 18:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFWWG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 18:06:28 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15953563B5
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 15:06:24 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id bq15-20020a056a000e0f00b00524c3c1a3cdso348719pfb.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KwqDl7Ku0++kd3bGbvwgzs1gT1laIcj9GIfwKObRL9E=;
        b=f8U/4xKGanNwrOdn737tuWhSmnZoG61m1qxfjiv5VkQ8UPtSqaWeibB404rrX79rJX
         Sr8EwtDegZkmDOiQT1PYLi73vlNuyK3MEO3CteMf7qrTyzJdkDqEDsqiRCNCHSPQ5OpW
         eesWhWqiGdmVom/8h4KWFRd14AnohMl03xMmbV6Ab1oeKOXQCzTP9OQoqz1l8U2F6/ec
         VlqIw1iK8+IqtbCAOHrXtiW4tOefdgMl+CoajfkyUTpBuZ8kM+4EuI/xDArQ35ySZCKy
         wRv8WwozJNFIjWw3i7yzruaQIY9s/ub55YNu2bl9iMISFr3cyMkNMY6hYWwYFcZJ8fYO
         pNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KwqDl7Ku0++kd3bGbvwgzs1gT1laIcj9GIfwKObRL9E=;
        b=R5k7EB70Vtn95Xmwq0JKnVWzD3MEcS6qG/4oC9hinb2iZ3fhpiKPMX5vZICFW75MiZ
         0XwUwiB631KHF8B07jBvTV0SMsyFdXcBCB9mDxdzuI4zZoFuntU+DawcUTuZ0JZdN/gn
         UKQFPS654AqAiklmoUbQgGZPBqANI+OmxECbWFbJ4MRY/CddmGxYHdmRhxuimyE+xxTt
         hjLVsLxehBecGymgBb0iNJYVEfdLy5JQTkvjn8sLLZDedylTw7IlN//ZC/9dP3xT/StZ
         A+c09qS0A79Ow2OlVDq9DrL73KcD6UjswfZh2ENakXmC20G8lhT09TK+0DCFfcjgkkgs
         EszQ==
X-Gm-Message-State: AJIora+P9eD8f+gOoXqrt28OWyDDiFJgI3VmsYaiJN8Sk/C2RU0aaOa/
        LHKQy0lZRuiiOWg+gWE/iNjIPducVV9tVJaXdg==
X-Google-Smtp-Source: AGRyM1sO9ieUDBnlX+/hb6X4MjMKGW7axAjbZt6eLMihv8A9ry56mIpW47+iL+E9JFdzcNk6h+YievpjxofEabG5Zw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:ac62:20a7:e3c5:c221])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6a00:885:b0:510:950f:f787 with
 SMTP id q5-20020a056a00088500b00510950ff787mr42464806pfj.83.1656021983532;
 Thu, 23 Jun 2022 15:06:23 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:06:05 -0700
Message-Id: <20220623220613.3014268-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 0/2] procfs: Add file path and size to /proc/<pid>/fdinfo
From:   Kalesh Singh <kaleshsingh@google.com>
To:     ckoenig.leichtzumerken@gmail.com, christian.koenig@amd.com,
        viro@zeniv.linux.org.uk, hch@infradead.org,
        stephen.s.brennan@oracle.com, David.Laight@ACULAB.COM
Cc:     ilkos@google.com, tjmercier@google.com, surenb@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mike Rapoport <rppt@kernel.org>,
        Colin Cross <ccross@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This is v2 of the fdinfo patches. The main update is adding path
field only for files with anon inodes. Rebased on 5.19-rc3.

The previous cover letter is copied below for convenience.

Thanks,
Kalesh

-----------

Processes can pin shared memory by keeping a handle to it through a
file descriptor; for instance dmabufs, memfd, and ashmem (in Android).

In the case of a memory leak, to identify the process pinning the
memory, userspace needs to:
  - Iterate the /proc/<pid>/fd/* for each process
  - Do a readlink on each entry to identify the type of memory from
    the file path.
  - stat() each entry to get the size of the memory.

The file permissions on /proc/<pid>/fd/* only allows for the owner
or root to perform the operations above; and so is not suitable for
capturing the system-wide state in a production environment.

This issue was addressed for dmabufs by making /proc/*/fdinfo/*
accessible to a process with PTRACE_MODE_READ_FSCREDS credentials[1]
To allow the same kind of tracking for other types of shared memory,
add the following fields to /proc/<pid>/fdinfo/<fd>:

path - This allows identifying the type of memory based on common
       prefixes: e.g. "/memfd...", "/dmabuf...", "/dev/ashmem..."

       This was not an issued when dmabuf tracking was introduced
       because the exp_name field of dmabuf fdinfo could be used
       to distinguish dmabuf fds from other types.

size - To track the amount of memory that is being pinned.

       dmabufs expose size as an additional field in fdinfo. Remove
       this and make it a common field for all fds.

Access to /proc/<pid>/fdinfo is governed by PTRACE_MODE_READ_FSCREDS
-- the same as for /proc/<pid>/maps which also exposes the path and
size for mapped memory regions.

This allows for a system process with PTRACE_MODE_READ_FSCREDS to
account the pinned per-process memory via fdinfo.


Kalesh Singh (2):
  procfs: Add 'size' to /proc/<pid>/fdinfo/
  procfs: Add 'path' to /proc/<pid>/fdinfo/

 Documentation/filesystems/proc.rst | 22 ++++++++++++++++++++--
 drivers/dma-buf/dma-buf.c          |  1 -
 fs/libfs.c                         |  9 +++++++++
 fs/proc/fd.c                       | 18 ++++++++++++++----
 include/linux/fs.h                 |  1 +
 5 files changed, 44 insertions(+), 7 deletions(-)


base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
-- 
2.37.0.rc0.161.g10f37bed90-goog

