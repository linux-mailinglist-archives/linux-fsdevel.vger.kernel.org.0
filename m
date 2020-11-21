Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D006B2BBFFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgKUOoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgKUOoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:44:05 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D90C0613CF;
        Sat, 21 Nov 2020 06:44:05 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id m2so876722qka.3;
        Sat, 21 Nov 2020 06:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b1YsIwwUIN4rYNJz4bNr3pgQUADYxpKbFfwui8E1kVk=;
        b=LF3CR/lH4Pkt6bqErxou/dv4op9wa9S8xbgYEw9tFFeZdj8ETu5DjCeWOTaXEmC1/b
         KWJxJNTqBX/wE/wqQd1hAPLOJoK3pVxovMeqg51ClH/uLp6+IEY8bz6dE8TcpzcKsv//
         fNEeLKXjNP/XotaxfAui87UMpr6nUHrsa2MgIBjvzfNDjL4YoT01zrg+kx8LpOFC240F
         vKC9XXImD6VPD4/st+tmk4ePCK4lQQdcyRfzf3qcxoful5M+k9F9tDtS58U3QiRK6j9g
         ng+f6uogrtjxOLkT5lo4Yynb3j8+WE/rRZTfhxoXkkaVkDpxKZaJxY+S5WT0dnxnueAh
         MMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b1YsIwwUIN4rYNJz4bNr3pgQUADYxpKbFfwui8E1kVk=;
        b=ZyCzNLtOvc53Wkc0HuXyYDp8K4CfyviGFHLS0RkZ5UEQRwhc+iaxTKTCFMxTtGg/7w
         aSLNO/Dhwf2UdhLlSjRqfu19MRCiJDwWUxjVkZWfd9minuX88BHqfPZuAlSye2fxL2qu
         Qic9C8UcsfDToLLngvcOoekSDadsGnc6k0PkH7qVx6t5i8q3Fy6ZkPBvn8aVyHTLSLsA
         T2psNewdbLF0TuKC5qaQDBFKUvYOCnZZJ7lIPFYE6DkJIHQ0MKi7fz19NmXfq9622y8p
         2OUYaA8471E4QH6H9qNIqn8HerHmwYEPMqgB/leblHZYcVockP8w9IzpiEudJlvmMOXj
         USPQ==
X-Gm-Message-State: AOAM531H/8Y3WpTftdSgPuvHLLzpXKnjCdg91yNLzNGQ4XTaD0lO9rW3
        mrCOJog+7/7YBXJad3Xzmm+1jRUXr8E=
X-Google-Smtp-Source: ABdhPJxxK+sVIb9gXaO6vIpinvm4SWyrCKjaFjMTLxuNiHPTirtw1msOuhdVY0ctV9ShJT7hyz0qRg==
X-Received: by 2002:a37:9a94:: with SMTP id c142mr695606qke.480.1605969843846;
        Sat, 21 Nov 2020 06:44:03 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id q15sm4055137qki.13.2020.11.21.06.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 06:44:03 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, soheil.kdev@gmail.com,
        willy@infradead.org, arnd@arndb.de, shuochen@google.com,
        linux-man@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: [PATCH v4 0/4] add epoll_pwait2 syscall
Date:   Sat, 21 Nov 2020 09:43:56 -0500
Message-Id: <20201121144401.3727659-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Enable nanosecond timeouts for epoll.

Analogous to pselect and ppoll, introduce an epoll_wait syscall
variant that takes a struct timespec instead of int timeout.

See patch 2 for more details.

patch 1: pre patch cleanup: convert internal epoll to timespec64
patch 2: add syscall
patch 3: wire up syscall
patch 4: selftest

Applies cleanly to next-20201120
No update to man-pages since v3, see commit
https://lore.kernel.org/patchwork/patch/1341103/

Willem de Bruijn (4):
  epoll: convert internal api to timespec64
  epoll: add syscall epoll_pwait2
  epoll: wire up syscall epoll_pwait2
  selftests/filesystems: expand epoll with epoll_pwait2

 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 fs/eventpoll.c                                | 130 ++++++++++++++----
 include/linux/compat.h                        |   6 +
 include/linux/syscalls.h                      |   5 +
 include/uapi/asm-generic/unistd.h             |   4 +-
 kernel/sys_ni.c                               |   2 +
 .../filesystems/epoll/epoll_wakeup_test.c     |  72 ++++++++++
 24 files changed, 210 insertions(+), 29 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

