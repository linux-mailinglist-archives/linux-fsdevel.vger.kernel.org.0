Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012AF362C1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 02:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhDPX7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 19:59:22 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:35542 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDPX7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:59:22 -0400
Received: by mail-pj1-f47.google.com with SMTP id j21-20020a17090ae615b02901505b998b45so1927946pjy.0;
        Fri, 16 Apr 2021 16:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yc6/O6ItT9BvcJf7D3/AKKkQGKBmdsKi/XWtpIpZKuI=;
        b=Qzyx8gef7sbPc+g2Pncna0AczH+hK1H+bSruQWqKyBvc8qCbtGE/OhECJuvGr+V5Ye
         aal5B23SsimzAMBQ5jfQalIHZ2KWRG+I+pNFU1omROzHP5T9ljwVLay9a5/w5tMYIY5R
         25OPDzBCHuXS5SW7cGEb9muYEHAj+DHNmZecv/N5shu9nsxKq4tawqiqABrI8s002B2h
         EbkBN9/lyWmQOmBsdDQeOlpkDrSQgTc+e6EJgmIj4xhBBCyll1R0LfoKkYHTxpGGzIOP
         RHl2VdGAW8gKYCMnU6PdLJbVthTd5GuqQpZbHAVX/CXxk9l/VI0vEWVvWx/1MgWjRJpz
         +L8g==
X-Gm-Message-State: AOAM530L6/RorJyf+5nYRDDniTnYMGHcORDhjrc801XDZ6sCXtJNPW7s
        TbrKPNs24T4fdXlHExe3WRI=
X-Google-Smtp-Source: ABdhPJxhyoB7ChsXUF+GYTaAc8CBGnRYH+wZetrV5rP6NKD+EjVeaF5kuUqJ5YqLR7ITZYwYoSs/Ew==
X-Received: by 2002:a17:902:ea93:b029:eb:65ee:ddd3 with SMTP id x19-20020a170902ea93b02900eb65eeddd3mr11836848plb.24.1618617536716;
        Fri, 16 Apr 2021 16:58:56 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e190sm5677416pfe.3.2021.04.16.16.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:58:55 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D4DD2403A2; Fri, 16 Apr 2021 23:58:54 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/2] fs: provide a stop gap fix for buggy resume firmware API calls
Date:   Fri, 16 Apr 2021 23:58:48 +0000
Message-Id: <20210416235850.23690-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lukas has reported an issue [0] with a media driver which causes stall on
resume. At first his suspicion was that this issue was due to a bug in
btrfs. I managed to build a custom driver to reproduce the issue and
confirmed it was not a bug in btrfs. The issue is reproducible in XFS
as well. This issue is a demonstration of how broken the filesystem
suspend / resume cycle is and how easy it can be to trigger an issue.

By only doing reads with the firmware API used incorrectly, a simple
suspend / resume cycle can stall a system. The stall happens since
the hardware never gets read request issued by the filesystem as it
was already suspended. The fs waits forever. The stall also happens
because resume calls are synchronous and if one does not complete
we'll wait forever.

My new unposted VFS series for the fs freezer / resume work fixes this,
however this series will require a bit more discussion before this lands
upstream. And so this series provides a test case for the issue and an
intermediate stop-gap patch which resolves the issue for now. We can
remove this once the VFS freeze work lands upstream.

[0] https://lkml.kernel.org/r/c79e24a5-f808-d1f0-1f09-ee6f135d9679@tuxforce.de

Luis Chamberlain (2):
  test_firmware: add suspend support to test buggy drivers
  fs/kernel_read_file: use usermodehelper_read_trylock() as a stop gap

 fs/kernel_read_file.c                         |  37 ++++-
 kernel/kexec_file.c                           |   9 +-
 kernel/module.c                               |   8 +-
 lib/test_firmware.c                           | 136 ++++++++++++++++--
 tools/testing/selftests/firmware/fw_lib.sh    |   8 +-
 .../selftests/firmware/fw_test_resume.sh      |  80 +++++++++++
 6 files changed, 261 insertions(+), 17 deletions(-)
 create mode 100755 tools/testing/selftests/firmware/fw_test_resume.sh

-- 
2.29.2

