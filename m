Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95459307DF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhA1S3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 13:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhA1SZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:25:28 -0500
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ADEC0617A9
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 10:24:47 -0800 (PST)
Received: by mail-ua1-x94a.google.com with SMTP id r13so1698527uao.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 10:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=cHIvwUXm0lHuy8rQzrOgn2oz2Aq5uQKCMOMrBcKZwBg=;
        b=Zc99w0hKc7U8hNCoPJDy9cvpaEfnjCHz+dH+XBgm5zAmXTTLaglY0QZ+xewQSHkXDB
         xOzLPxKUqfoX69HUflAkk5SVsvrLU9yedbGZVCA98fwvlaSAIS3S/zp8mVGd6ywKiKpi
         IcBrcmJAv1ow6QN5MLJiF0/UJ29JNPDTX5vrbFDH7zIXudgNkb7biFgC+6QMR6IwUOvN
         3lVpfjg+fzannImonM+QVX0zCX7wz61NABL/Y4xSO28FZUEZWM0w+poVt809HPQoCW82
         cl2RCr3NCpxwOA7gySz+fi86VicU7XbIKlWOv6+46w7gEH7vPDZP2tLy+TyHNI8EF8T4
         FcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc:content-transfer-encoding;
        bh=cHIvwUXm0lHuy8rQzrOgn2oz2Aq5uQKCMOMrBcKZwBg=;
        b=c5ambfnFmwXhAgAobx1fO2yeQhP8Qzm/2j9NasBwSifkXgR4m5Jrxu+iiBI4je3vVd
         RG5HgCYsLcm7yq/X6dr5rlj1dGo+B1r4Bvp2thXELYsSB+Xb23voWtbw6yT+wYHdnBwm
         0NPDVIpYGmaGo8t4gCD9zrEs4Y7UxiYv5SOoxR1DdDc4cW4RSUN7Mrd9hn3EiYsPvjAe
         cICtc/NSNNuNaBgWNJBpoE6Y0KGMOw8t/eQhUj8Qvz/YyKU6aMc+cEHSQGTBxuFnPRzz
         TH934yMpvXyxfh5dkujjWR/HlYwwvzRmnn47FUvA7BvqVF4x2OxujSGZoRQJGnTkXVs4
         5VtQ==
X-Gm-Message-State: AOAM530BwQ547fHIcMSOzFWX1hBH1Wi8D3Yzss52Z+NmvlJw57bWhiVi
        z+Yj5CeW8hOVp7dxuYzqSpWFn2gRt7CB4iBkKg==
X-Google-Smtp-Source: ABdhPJxjOgT+zASwb9ZYuq0uI6fVz8Lr4Lk+05wuK0BleAbT7nbROSuQIr3xjDt42c7GZUo8Tn1YW1FsSYhCEyIssw==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a67:eac2:: with SMTP id
 s2mr963597vso.22.1611858286409; Thu, 28 Jan 2021 10:24:46 -0800 (PST)
Date:   Thu, 28 Jan 2021 18:24:29 +0000
Message-Id: <20210128182432.2216573-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 0/2] Allow reading process DMA buf stats from fdinfo
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Android captures per-process system memory state when certain low memory
events (e.g a foreground app kill) occur, to identify potential memory
hoggers. In order to measure how much memory a process actually consumes,
it is necessary to include the DMA buffer sizes for that process in the
memory accounting. Since the handle to DMA buffers are raw FDs, it is
important to be able to identify which processes have FD references to
a DMA buffer.

Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
/proc/<pid>/fdinfo -- both are only readable by the process owner,
as follows:
  1. Do a readlink on each FD.
  2. If the target path begins with "/dmabuf", then the FD is a dmabuf FD.
  3. stat the file to get the dmabuf inode number.
  4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.

Accessing other processes=E2=80=99 fdinfo requires root privileges. This li=
mits
the use of the interface to debugging environments and is not suitable
for production builds.  Granting root privileges even to a system process
increases the attack surface and is highly undesirable.

This series proposes making the requirement to read fdinfo less strict
with PTRACE_MODE_READ.


Kalesh Singh (2):
  procfs: Allow reading fdinfo with PTRACE_MODE_READ
  dmabuf: Add dmabuf inode no to fdinfo

 drivers/dma-buf/dma-buf.c |  1 +
 fs/proc/base.c            |  4 ++--
 fs/proc/fd.c              | 15 ++++++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

--=20
2.30.0.365.g02bc693789-goog

