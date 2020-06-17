Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFF11FD83A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 00:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgFQWEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgFQWDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:03:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62B7C061795
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 15:03:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h95so1715177pje.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2q7bLMUd5vfYPBehCH2qcIvt1dDMWXzsM1rSr8xASEs=;
        b=fiquKUdyAlyN5DN55k77fJo/naedBS1mJ6UPcwZUUzNVbhK6HBR2lN9vkr/JQ4toCx
         dncsX1dNE5j6lxBS7GZWAMyhdOA95exy4UqW2G53ACGN7/yiUulBC9tSekOj3i7WRpAR
         q91Ikv3l4LUdzw/5lIaj5dL5WFyrEGxRvY6MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2q7bLMUd5vfYPBehCH2qcIvt1dDMWXzsM1rSr8xASEs=;
        b=oRIjclRhCfZirEhGDCSvYt6EqFTjTrFmhrWEs8CtGJG138JCjog9f8CUQU9FVmcPGr
         MjmLW3J1VHP8fP85PjnLZ5Z0gsLA2adObfJhlqFcu/wvEK2VFm5RAgQ7TLD/rmz/13ta
         k+eDmfjFT0W0eKhCJ+LIUvpBqqoNBd/arwmJZocmUV0d2KEdBUrQp6J+Fgupb+DwSj2m
         6CeBmBbPQ10+YErilsSsRTHzixxs7ABCv9B0Xs/onIweBbpylwKEIGKDjnX2l59x92Ih
         n3ecZdT9TTBZwLRLSmeOrR/1YsNzyp4aTr2WgeG/yM3XjBNqsSESFqA8FuhUl6Bv+jnf
         KgbA==
X-Gm-Message-State: AOAM531t5SRL3eQSc7aVfRJNqWm2GXCz0WW7fBGhjwLlTPJ2WjoGDD8X
        2ZdBZHeLUpzS8ek+30gyZ14Ksg==
X-Google-Smtp-Source: ABdhPJwWiHmF17czxWIFIza6ENA/VAOzxqML/oF2F5VpOl/XEl59WcAXnyHbcoCd9YUHlSOmjcqCKA==
X-Received: by 2002:a17:90a:20a2:: with SMTP id f31mr1193084pjg.34.1592431414361;
        Wed, 17 Jun 2020 15:03:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d23sm467248pjv.45.2020.06.17.15.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:03:30 -0700 (PDT)
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
Subject: [PATCH v5 0/7] Add seccomp notifier ioctl that enables adding fds
Date:   Wed, 17 Jun 2020 15:03:20 -0700
Message-Id: <20200617220327.3731559-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

v5:
- merge ioctl fixes into Sargun's patches directly
- adjust new API to avoid "ufd_required" argument
- drop general clean up patches now present in for-next/seccomp
v4: https://lore.kernel.org/lkml/20200616032524.460144-1-keescook@chromium.org/

This continues the thread-merge between [1] and [2]. tl;dr: add a way for
a seccomp user_notif process manager to inject files into the managed
process in order to handle emulation of various fd-returning syscalls
across security boundaries. Containers folks and Chrome are in need
of the feature, and investigating this solution uncovered (and fixed)
implementation issues with existing file sending routines.

I intend to carry this in the seccomp tree, unless someone has objections.
:) Please review and test!

-Kees

[1] https://lore.kernel.org/lkml/20200603011044.7972-1-sargun@sargun.me/
[2] https://lore.kernel.org/lkml/20200610045214.1175600-1-keescook@chromium.org/


Kees Cook (5):
  net/scm: Regularize compat handling of scm_detach_fds()
  fs: Move __scm_install_fd() to __fd_install_received()
  fs: Add fd_install_received() wrapper for __fd_install_received()
  pidfd: Replace open-coded partial fd_install_received()
  fs: Expand __fd_install_received() to accept fd

Sargun Dhillon (2):
  seccomp: Introduce addfd ioctl to seccomp user notifier
  selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD

 fs/file.c                                     |  63 +++++
 include/linux/file.h                          |  19 ++
 include/uapi/linux/seccomp.h                  |  22 ++
 kernel/pid.c                                  |  11 +-
 kernel/seccomp.c                              | 172 ++++++++++++-
 net/compat.c                                  |  55 ++---
 net/core/scm.c                                |  50 +---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 229 ++++++++++++++++++
 8 files changed, 540 insertions(+), 81 deletions(-)

-- 
2.25.1

