Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFB91D190A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 17:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbgEMPVP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 11:21:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34255 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgEMPVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 11:21:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so7550192pfa.1;
        Wed, 13 May 2020 08:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vd8mN5eu82jR3IAsdSL8KCAElLuY0QvMKLQ4DV4/fDM=;
        b=oa7V1C/MEjzWRxJ/2JF4W0oUPiHG2ulxUCEGfDQYTB1hP8DEeRYLYF/KEpNrYLNIEm
         AlRDxsACr+ZrAm5kLxC1bFvATuECgIQYgtDVgHYhLLKOVwePgB2gGorgX3Z/UpFlEoA+
         TeAKx/9YWYhHWAT43uoe4YbrzETSc+imU6UP3TP0d+wIsgP7X+uOJ9atY1zbrrZ7/Gni
         GobE91AgpQg3AMpj40PqHrFnuzbEZ7ZiUGOeBT1cMfQVuDnrNA2HBfI4r7b+Vj0Q9BLH
         oDVjMSrZpMMSb7yquwEqXaHtqqDEXxGlKiZo80R+9yduwacCOsosNxyR7L/Sm6I5p/zG
         SM6A==
X-Gm-Message-State: AOAM533rtKtwbp0am2isPGeZ2rPWoKzhuOa/k3jM6dAlkKXXbWJRkbfi
        sQ0y6Ifqonu2xaFCdgqeOa0=
X-Google-Smtp-Source: ABdhPJz8JCGMh8sRdwYyCHudRzQBKdwiDqQQhE20Xn802xN18geL+qldVFqyq1i08EE9ulujdjpfQg==
X-Received: by 2002:a63:a01:: with SMTP id 1mr16798874pgk.428.1589383273914;
        Wed, 13 May 2020 08:21:13 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a2sm45859pgh.57.2020.05.13.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 08:21:12 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3FC514063E; Wed, 13 May 2020 15:21:12 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, ebiederm@xmission.com, jeyu@kernel.org,
        jmorris@namei.org, keescook@chromium.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nayna@linux.ibm.com, zohar@linux.ibm.com
Cc:     scott.branden@broadcom.com, dan.carpenter@oracle.com,
        skhan@linuxfoundation.org, geert@linux-m68k.org,
        tglx@linutronix.de, bauerman@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
Date:   Wed, 13 May 2020 15:21:05 +0000
Message-Id: <20200513152108.25669-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While reviewing Scott Branden's submission of the new Broadcom VK driver
driver upstream [0], part of which included 4 new pread varaints of the
existing kernel_read*(), calls I grew shivers of the possibility of drivers
using these exported symbols loosely. If we're going to grow these, it
seems best to restrict the symbols to a namespace so drivers and
subsystem maintainers don't use these carelessly.

This should also help with making it easier to audit future locations in
the kernel such read calls happen by just looking at the imports of the
namespace.

This goes compile tested with allyesconfig and allmodconfig on x86_64.
0-day should have a report on build status with other configs later of
my branch [1].

[0] https://lkml.kernel.org/r/20200508002739.19360-1-scott.branden@broadcom.com
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200513-kernel-read-sym

Luis Chamberlain (3):
  fs: unexport kernel_read_file()
  security: add symbol namespace for reading file data
  fs: move kernel_read*() calls to its own symbol namespace

 drivers/base/firmware_loader/fallback.c | 1 +
 drivers/base/firmware_loader/main.c     | 1 +
 fs/exec.c                               | 9 +++++----
 kernel/kexec.c                          | 2 ++
 kernel/kexec_file.c                     | 2 ++
 kernel/module.c                         | 3 +++
 security/integrity/digsig.c             | 3 +++
 security/integrity/ima/ima_fs.c         | 3 +++
 security/integrity/ima/ima_main.c       | 2 ++
 security/loadpin/loadpin.c              | 2 ++
 security/security.c                     | 8 +++++---
 security/selinux/hooks.c                | 2 ++
 12 files changed, 31 insertions(+), 7 deletions(-)

-- 
2.26.2

