Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB8C42C9F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 21:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbhJMTZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 15:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJMTZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:25:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643BAC061570
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 12:23:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k23so3058911pji.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=f83NlsNXjMg5QDwE3dqfC8dTeYtf/vdW3ZOd3Omo9rc=;
        b=g/vAfOHiq9i34ozOpZngme9idv+KwO6KRzk+EqRmuWrF9SxgrFVCPVp1yzMi5gznyQ
         qI5Z1X4fdM4w7fJWPVdAU6j4Pn2ymxli4PnNYnxurPuK9y7p3UTd3IR28W1ONqlS8edc
         YcOC8jv5xaZwTvkt7bsUd+a8OcjLzQIHovzrbzXQKcwtkEzUBPXQmGXPrP5sQk9dbzGf
         mqfdBsei9udsXlihndHTrjYcP4KYUlb26TqJ6SE2cdCGCEbffjCjukOdsK3y8HqWrIaJ
         eX2MBqb5EyvxX13QGtrX9E27HrggpQP0cG1pyY4nJ7d9p1wFhCCBBuURlxVDCr8eyEVU
         CeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=f83NlsNXjMg5QDwE3dqfC8dTeYtf/vdW3ZOd3Omo9rc=;
        b=vjlsj7nsH3Q1TGoeMf2WRzVSpoHR9G+HzNM1H/d/IWdPc1QJYyGqbjQNH2iUKHliBY
         EysoiuwLLArrBRQlZ0g0UmTNHohqZSoKicVdlgqs9dGcWxdCXnzU5AzooUGw2ToiOCh0
         HJ8TnH6I+7e3xGEIhZap2m2yqIedsguPNOrLpbAadP5IlEb8T1v5MqWFSCJGpB+9mZvw
         k8ABWLPZaXunNgr86FKf6raEsWeFeSDm4A1TBnF9Uo+ES36M46vxDjsqUI1ez6pxPsmr
         z1xOKR9xm4YSlkG3F+Qe3BNm16pK+cJcpNWu3a90nscED4oTJnAut9w1KzWN01Y9I9gy
         EfMA==
X-Gm-Message-State: AOAM5325EGg7wFeBokzDY9QLagRhqniHkZsWU9iFJAvMk4wSUSmO9TUt
        Am/Ig6rR9Vt9Xyo7ITwisJz4g2Zg5ls0iWlFAapCaw==
X-Google-Smtp-Source: ABdhPJx7B4wbxUigj3YkCzr4ajJ5PrOzGyI3Sp5lpbipGlagpogxA6eKEteE1V3/8BXY06a8GNqWVU4AwQRGk530ZBw=
X-Received: by 2002:a17:903:22cc:b0:13e:fa73:6fef with SMTP id
 y12-20020a17090322cc00b0013efa736fefmr1015863plg.25.1634153010612; Wed, 13
 Oct 2021 12:23:30 -0700 (PDT)
MIME-Version: 1.0
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 13 Oct 2021 12:23:19 -0700
Message-ID: <CAHS8izMpzTvd5=x_xMhDJy1toV-eT3AS=GXM2ObkJoCmbDtz6w@mail.gmail.com>
Subject: [RFC Proposal] Deterministic memcg charging for shared memory
To:     Roman Gushchin <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>, cgroups@vger.kernel.org,
        riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Below is a proposal for deterministic charging of shared memory.
Please take a look and let me know if there are any major concerns:

Problem:
Currently shared memory is charged to the memcg of the allocating
process. This makes memory usage of processes accessing shared memory
a bit unpredictable since whichever process accesses the memory first
will get charged. We have a number of use cases where our userspace
would like deterministic charging of shared memory:

1. System services allocating memory for client jobs:
We have services (namely a network access service[1]) that provide
functionality for clients running on the machine and allocate memory
to carry out these services. The memory usage of these services
depends on the number of jobs running on the machine and the nature of
the requests made to the service, which makes the memory usage of
these services hard to predict and thus hard to limit via memory.max.
These system services would like a way to allocate memory and instruct
the kernel to charge this memory to the client=E2=80=99s memcg.

2. Shared filesystem between subtasks of a large job
Our infrastructure has large meta jobs such as kubernetes which spawn
multiple subtasks which share a tmpfs mount. These jobs and its
subtasks use that tmpfs mount for various purposes such as data
sharing or persistent data between the subtask restarts. In kubernetes
terminology, the meta job is similar to pods and subtasks are
containers under pods. We want the shared memory to be
deterministically charged to the kubernetes's pod and independent to
the lifetime of containers under the pod.

3. Shared libraries and language runtimes shared between independent jobs.
We=E2=80=99d like to optimize memory usage on the machine by sharing librar=
ies
and language runtimes of many of the processes running on our machines
in separate memcgs. This produces a side effect that one job may be
unlucky to be the first to access many of the libraries and may get
oom killed as all the cached files get charged to it.

Design:
My rough proposal to solve this problem is to simply add a
=E2=80=98memcg=3D/path/to/memcg=E2=80=99 mount option for filesystems (name=
ly tmpfs):
directing all the memory of the file system to be =E2=80=98remote charged=
=E2=80=99 to
cgroup provided by that memcg=3D option.

Caveats:
1. One complication to address is the behavior when the target memcg
hits its memory.max limit because of remote charging. In this case the
oom-killer will be invoked, but the oom-killer may not find anything
to kill in the target memcg being charged. In this case, I propose
simply failing the remote charge which will cause the process
executing the remote charge to get an ENOMEM This will be documented
behavior of remote charging.
2. I would like to provide an initial implementation that adds this
support for tmpfs, while leaving the implementation generic enough for
myself or others to extend to more filesystems where they find the
feature useful.
3. I would like to implement this for both cgroups v2 _and_ cgroups
v1, as we still have cgroup v1 users. If this is unacceptable I can
provide the v2 implementation only, and maintain a local patch for the
v1 support.

If this proposal sounds good in principle. I have an experimental
implementation that I can make ready for review. Please let me know of
any concerns you may have. Thank you very much in advance!
Mina Almasry

[1] https://research.google/pubs/pub48630/
