Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996065398AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 23:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347999AbiEaVZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 17:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348019AbiEaVZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 17:25:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD39E9E8
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 14:25:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc7bdd666fso124597297b3.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=L5daPTOP8huWXGF9zZZ/YOQgC5+YhUKYKEYEGgJKuXI=;
        b=ni+vDj4JsvkDI6uQO/dBS970cz6dZc8DyFe2Zer4xTkNxkSHvK+9iWBnPWmPFlu+yM
         GldK8tXmwDcVnPqD5rTmrw1O/5Fx84SqlvyYy1O+NdSXpTGCmxmOP42PbCZEsmapK/pI
         LdPWt3eWdMCmmsdUAyhxzJwSk4K/f3XFD8JLMQDfFMKoV7yl3wD7c0YEyQZkVTKpKRls
         bQIXSiUx6bvVEbfIXw2C31CtGBGyRZKnhhZI0oqDXke/z5Cd5Z5SAktEbZN0415/W9kX
         oeGofIRzd3K6V4+k9c5ZaCl6y2CNVM4tUzcRZzthBuZX0q0DdV2YxdbJ4DLgGVowVllW
         //UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=L5daPTOP8huWXGF9zZZ/YOQgC5+YhUKYKEYEGgJKuXI=;
        b=brZUsXvVLr+xgwzyn3TWe6djGlFnb1cZkjsKtOgPQ9ENz3H1znAOpziE4MSMlBcI8c
         DpAPEDGbKPb405BqzdBO5tp2N3R4bAtgHoeMWNNuiJhpu+7Fb0su6I7lpSMBsygZd9rH
         OMVI5uRMhd+P6hJLHbCoJwiMtNThhtR7ZNbvofDa/NPMgaLC1GgXsSO5avWulG3UXj1x
         VDhK9ib5Yt0p250uy1ARHfJJeze4d+2KuWWezTSCavDTYMm0KGsRVDmFfqJiVVNoD7+U
         q85Aq5D4EaFNjLqxlF3KlERZcHvHkHHgBHQe9WWY5aW0Fy6g7Ir+cTc202cvJsGpxJ/w
         Ps7g==
X-Gm-Message-State: AOAM533Ioob3VGZOjc1L25Zsfhxji4rKF+Kp10ZH2b5p80JVLHHNOsp9
        MY8bzPw2eOrjPrqYvGJnqn1wUMJiJK4xupWgcQ==
X-Google-Smtp-Source: ABdhPJxWIiQFRYynwXQQYY0IBjtnA6j7FHVKcbmfGUIrmeVszzJonKHXPDCnsP8F5SOq9IOCJF3wUkeCrypYAVu4VA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:a3c0:2a66:b25c:16df])
 (user=kaleshsingh job=sendgmr) by 2002:a25:6588:0:b0:65d:57b9:c470 with SMTP
 id z130-20020a256588000000b0065d57b9c470mr4071204ybb.142.1654032327734; Tue,
 31 May 2022 14:25:27 -0700 (PDT)
Date:   Tue, 31 May 2022 14:25:13 -0700
Message-Id: <20220531212521.1231133-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 0/2] procfs: Add file path and size to /proc/<pid>/fdinfo
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     ilkos@google.com, tjmercier@google.com, surenb@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Hildenbrand <david@redhat.com>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

-----

There was some concern about exposing the file path in the RFC[2], to that
effect the change was split into separte patches. Also retrieving the file
path from fdinfo is guarded by the same capability (PTRACE_MODE_READ) as
/proc/<pid>/maps which also exposes file path, so this may not be an issue.

[1] https://lore.kernel.org/r/20210308170651.919148-1-kaleshsingh@google.com/
[2] https://lore.kernel.org/r/20220519214021.3572840-1-kaleshsingh@google.com/


Kalesh Singh (2):
  procfs: Add 'size' to /proc/<pid>/fdinfo/
  procfs: Add 'path' to /proc/<pid>/fdinfo/

 Documentation/filesystems/proc.rst | 22 ++++++++++++++++++++--
 drivers/dma-buf/dma-buf.c          |  1 -
 fs/proc/fd.c                       | 13 +++++++++----
 3 files changed, 29 insertions(+), 7 deletions(-)


base-commit: 8ab2afa23bd197df47819a87f0265c0ac95c5b6a
-- 
2.36.1.255.ge46751e96f-goog

