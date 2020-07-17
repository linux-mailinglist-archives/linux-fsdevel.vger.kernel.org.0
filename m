Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86C0224223
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGQRnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgGQRnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:43:15 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148CBC0619D5
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so5768576plk.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wV1gvV23mO4MSWHgMeM+r7999nuQAFQGTkfq3zyvhrU=;
        b=TkI+hwhyWG7WZvnJTwRRMikLIXphh/PU89bCIE8P6SFs0SaHpCf4VAcMkSYIWejrmC
         UHjYj/pWqealOdMvuvGnbGyDGiR092Y/coL6eRwohd6FSkw/1x0lTSsWwdlxAmTbJF9z
         MG+bnlBW3Pz3hPqkiZYjpkgP2T6E3WFs4nd00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wV1gvV23mO4MSWHgMeM+r7999nuQAFQGTkfq3zyvhrU=;
        b=khMbFrv1edzYKhCeifMuMR9Ttg/sWB5QJtwdb//r+aEK6fBJpTBRY5TTN9eux9Djzh
         MBEekyWjCYQqJZ5WysmtNW+waaxWLYvrt8uigPoVWoqyMWoatlnt+LAPXr1YjmLCyrBW
         y6aoNDazveNeRfuKLb4jdtzND/GtLmK0qwwK8Cjn75TFkDllAdbfs71X/McbB1L/mh7x
         YqvgoomAZittVF6hupW6OT3wRqjTuY0jnwA/ifMTpN+8jObxVwn9FvnNqlY/7/bzQptC
         lgPwzhmBxF7+u7fPMvWRT5WNv1iVGJbsvvlDY+p+AN+yop3TfPoXQqrwx5/Mhz/nYxbY
         OTfg==
X-Gm-Message-State: AOAM531irrqK3VT/dHGhgJGsg6ZO4Kf1Ne4yJzN0j6noIb3xdTCHfvds
        ZdUPC0K/mbSAeFz7RlbZp3MYiw==
X-Google-Smtp-Source: ABdhPJxKZBG7RqgWoCxDb3CWPD97sCGFFzSrqXIIWjriKiDJA4WPNj/7bJe6bdbUYimvfgj8GzzH+g==
X-Received: by 2002:a17:90b:1386:: with SMTP id hr6mr10767858pjb.93.1595007794310;
        Fri, 17 Jul 2020 10:43:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 21sm8245611pfu.124.2020.07.17.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] Introduce partial kernel_read_file() support
Date:   Fri, 17 Jul 2020 10:42:55 -0700
Message-Id: <20200717174309.1164575-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Here's my attempt at clearing the path to partial read support in
kernel_read_file(), which fixes a number of issues along the way. I'm
still fighting with the firmware test suite (it doesn't seem to pass
for me even in stock v5.7... ?) But I don't want to block Scott's work[1]
any this week, so here's the series as it is currently.

The primary difference to Scott's approach is to avoid adding a new set of
functions and just adapt the existing APIs to deal with "offset". Also,
the fixes for the enum are first in the series so they can be backported
without the header file relocation.

I'll keep poking at the firmware tests...

-Kees

[1] https://lore.kernel.org/lkml/202007161415.10D015477@keescook/

Kees Cook (12):
  firmware_loader: EFI firmware loader must handle pre-allocated buffer
  fs/kernel_read_file: Remove FIRMWARE_PREALLOC_BUFFER enum
  fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED enum
  fs/kernel_read_file: Split into separate source file
  fs/kernel_read_file: Remove redundant size argument
  fs/kernel_read_file: Switch buffer size arg to size_t
  fs/kernel_read_file: Add file_size output argument
  LSM: Introduce kernel_post_load_data() hook
  firmware_loader: Use security_post_load_data()
  module: Call security_kernel_post_load_data()
  LSM: Add "contents" flag to kernel_read_file hook
  fs/kernel_file_read: Add "offset" arg for partial reads

Scott Branden (1):
  fs/kernel_read_file: Split into separate include file

 drivers/base/firmware_loader/fallback.c       |   8 +-
 .../base/firmware_loader/fallback_platform.c  |  12 +-
 drivers/base/firmware_loader/main.c           |  13 +-
 fs/Makefile                                   |   3 +-
 fs/exec.c                                     | 132 +-----------
 fs/kernel_read_file.c                         | 189 ++++++++++++++++++
 include/linux/fs.h                            |  39 ----
 include/linux/ima.h                           |  19 +-
 include/linux/kernel_read_file.h              |  55 +++++
 include/linux/lsm_hook_defs.h                 |   6 +-
 include/linux/lsm_hooks.h                     |  12 ++
 include/linux/security.h                      |  19 +-
 kernel/kexec.c                                |   2 +-
 kernel/kexec_file.c                           |  18 +-
 kernel/module.c                               |  24 ++-
 security/integrity/digsig.c                   |   8 +-
 security/integrity/ima/ima_fs.c               |   9 +-
 security/integrity/ima/ima_main.c             |  58 ++++--
 security/integrity/ima/ima_policy.c           |   1 +
 security/loadpin/loadpin.c                    |  17 +-
 security/security.c                           |  26 ++-
 security/selinux/hooks.c                      |   8 +-
 22 files changed, 432 insertions(+), 246 deletions(-)
 create mode 100644 fs/kernel_read_file.c
 create mode 100644 include/linux/kernel_read_file.h

-- 
2.25.1

