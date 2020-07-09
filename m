Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456B721A6F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 20:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgGIS0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 14:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgGIS0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:26:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACA1C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2020 11:26:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so1313992pgm.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ah/xwyUwLDcO5c6QVFl6V0itB29Y6z2+QXTTe1nwKSY=;
        b=LLdYWtX2Ocxzeqrp4lxxrExn+xcyO48LOp5c6ZDWdc234/u9a5SODz90KAgrKxCN8W
         aNWPR4t1ijUoVqeoqb3RQCycFkimFWJYaV/kEuNOn2ZjD0QBAa0ao6eHZCm5TmkfcCgS
         w6JMIfWsigDUAVICaYgQjKNjyQ0WJHCeBLKpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ah/xwyUwLDcO5c6QVFl6V0itB29Y6z2+QXTTe1nwKSY=;
        b=Y8jE21P41ti5x9cAH5QYwCUJFWI89LsOIBZk2XEgxhjvR5clL93tsqfR6U1R/wm+QG
         Nb+1fbO0rFga1uSlP1FRepG/lnoxm4PhrT4pwma9suW+TNTE29uwzMscKDHBYS6lfrKG
         T2oIRxV+c8kSdJvti0Tphjd3BgAUD3XXyQRc0Wu4vqCCJdinHplZQCiP3tWrSJuJrPHH
         iRFTbGSPXgw91FKR8vbErBNVIhUbHVIWxmtj1jzt7TsEGKlQt4R+89WBnlK/xfOet0pd
         xquBnE3pe7p7Qlcu047A+mSJuI4qwyCE5KqsnTIY6+I3FNujlv7lnNR4K5Kl/XWT/qJZ
         hxLQ==
X-Gm-Message-State: AOAM530MqyqWAYXfNEw9sqIXO14EAm9g224LyPHNUg3nsfgQ9xzU0shS
        /XVY2WTVRAVm9DojikHK5Y+8Og==
X-Google-Smtp-Source: ABdhPJyj3kXdp3Y89vB25U3RAgnxdfxtaz0Z4xZpDPqeUGcsCQaO8cgdoenYnidhHgf9LaZ0+/Sm6A==
X-Received: by 2002:a65:6089:: with SMTP id t9mr56104275pgu.236.1594319209137;
        Thu, 09 Jul 2020 11:26:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n25sm3462318pff.51.2020.07.09.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:26:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v7 0/9] Add seccomp notifier ioctl that enables adding fds
Date:   Thu,  9 Jul 2020 11:26:33 -0700
Message-Id: <20200709182642.1773477-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

v7:
- break out sock usage counting fixes into more cleanly backportable pieces
- code style cleanups (christian)
- clarify addfd commit log (christian)
- add ..._SIZE_{VER0,LATEST} and BUILD_BUG_ON()s (christian)
- remove undef (christian)
- fix addfd embedded URL reference numbers
v6: https://lore.kernel.org/lkml/20200706201720.3482959-1-keescook@chromium.org/

This continues the thread-merge between [1] and [2]. tl;dr: add a way for
a seccomp user_notif process manager to inject files into the managed
process in order to handle emulation of various fd-returning syscalls
across security boundaries. Containers folks and Chrome are in need
of the feature, and investigating this solution uncovered (and fixed)
implementation issues with existing file sending routines.

I intend to carry this in the for-next/seccomp tree, unless someone
has objections. :) Please review and test!

-Kees

[1] https://lore.kernel.org/lkml/20200603011044.7972-1-sargun@sargun.me/
[2] https://lore.kernel.org/lkml/20200610045214.1175600-1-keescook@chromium.org/


Kees Cook (7):
  net/compat: Add missing sock updates for SCM_RIGHTS
  pidfd: Add missing sock updates for pidfd_getfd()
  net/scm: Regularize compat handling of scm_detach_fds()
  fs: Move __scm_install_fd() to __receive_fd()
  fs: Add receive_fd() wrapper for __receive_fd()
  pidfd: Replace open-coded receive_fd()
  fs: Expand __receive_fd() to accept existing fd

Sargun Dhillon (2):
  seccomp: Introduce addfd ioctl to seccomp user notifier
  selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD

 fs/file.c                                     |  57 +++++
 include/linux/file.h                          |  19 ++
 include/linux/seccomp.h                       |   4 +
 include/net/sock.h                            |   4 +
 include/uapi/linux/seccomp.h                  |  22 ++
 kernel/pid.c                                  |  14 +-
 kernel/seccomp.c                              | 173 ++++++++++++-
 net/compat.c                                  |  55 ++---
 net/core/scm.c                                |  50 +---
 net/core/sock.c                               |  21 ++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 229 ++++++++++++++++++
 11 files changed, 566 insertions(+), 82 deletions(-)

-- 
2.25.1

