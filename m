Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA05AD6AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 12:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390553AbfIIKXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 06:23:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50332 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390544AbfIIKXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id c10so13188064wmc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1vHqtKr8cw0KtYdhkEFzC4ar+CMf7Z34S1HppPU/IU=;
        b=Q4JxbKZdEH7ikJJbSjezmyCl1O2EZRxd1Sj9Ut+gYPy58Okwm3OttXqK0uZKzD7JvP
         NDmvDYb/h4jZ3BkW50xvchvhmfH6OXoZyc8VSAH6PkX/PaKQcINbJYwmy6ErGwbY2Qn3
         Fn+OtWKkAXtTpPGQFXt62GAjO5odgq5XITsU6ghsSOAWOSP49Q4oBJZmY0xuL/53iqFW
         I+0OGhAoX60F0qo37D7WO4NjuUEghOZF5hENOnMcqEc7RZ0UlzRyl/raxJ0bKi255v1J
         qoZXhYAHTNOFwJRcpHssfnD27PnMFD1ZDWqSa0gnUnZhAm5reSObhmZ0KgPPKo9Ut0xo
         D3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1vHqtKr8cw0KtYdhkEFzC4ar+CMf7Z34S1HppPU/IU=;
        b=Z0o4GL1L10gWRuy0XPuQE5NOleZEzyQQ0VLTE2Qtpkj83Lgj6pwxDQCSUmUBTOhsQH
         OpDELH33Icn/a7Tbb7L4gIYXompkNhIRRbpV2PZRQTO+LTAQ7DyrHhMthFhXU3gozPwj
         61FSg7V9sdU3RFNy8+1ksptzrM3PcGaKYOwEa7AYpJ0me/DodlF4xjCcxWpYkl7RZCjr
         ZTxxvikN3hYxfB3SOnlUzIVHGM7YlgAjYNI9yNb043ewvqwqVc5OMMeef49jhX9V7bs5
         d7Mt0dOoovzFUXi81dPCNXjeR1MNBRgM4Qr5jmIPWmV1OLHrNgdddS9e9CkcXyHABzRs
         6IAQ==
X-Gm-Message-State: APjAAAUrL2hpy1+KstA3rZf5PYVEUvnY83g5fZnbwkPBOnNTAZcjI3Df
        qkFXFwuvy6HizJqr0cho07jhIw==
X-Google-Smtp-Source: APXvYqx4fN/DN0uw+61dCgR+XviXlOSxx0lVzi+c/Vk8VC/qESo+wgcA4sINAtlrlROnJJrJ2vtAsA==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr18044183wmm.45.1568024623543;
        Mon, 09 Sep 2019 03:23:43 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:42 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/9] restart_block: Prepare the ground for dumping timeout
Date:   Mon,  9 Sep 2019 11:23:31 +0100
Message-Id: <20190909102340.8592-1-dima@arista.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I'm trying to address an issue in CRIU (Checkpoint Restore In Userspace)
about timed syscalls restart. It's not possible to use restart_syscall()
as the majority of applications does, as after restore the kernel doesn't
know anything about a syscall that may have been interrupted on
checkpoint. That's because the tasks are re-created from scratch and so
there isn't task_struct::restart_block set on a new task.

As a preparation, unify timeouts for different syscalls in
restart_block.

On contrary, I'm struggling with patches that introduce the new ptrace()
request API. I'll speak about difficulties of designing new ptrace
operation on Containers Microconference at Plumbers [with a hope to
find the sensible solution].

Cc: Adrian Reber <adrian@lisas.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: containers@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org

Dmitry Safonov (9):
  futex: Remove unused uaddr2 in restart_block
  restart_block: Prevent userspace set part of the block
  select: Convert __esimate_accuracy() to ktime_t
  select: Micro-optimise __estimate_accuracy()
  select: Convert select_estimate_accuracy() to take ktime_t
  select: Extract common code into do_sys_ppoll()
  select: Use ktime_t in do_sys_poll() and do_poll()
  select/restart_block: Convert poll's timeout to u64
  restart_block: Make common timeout

 fs/eventpoll.c                 |   4 +-
 fs/select.c                    | 214 ++++++++++++---------------------
 include/linux/poll.h           |   2 +-
 include/linux/restart_block.h  |  11 +-
 kernel/futex.c                 |  14 +--
 kernel/time/alarmtimer.c       |   6 +-
 kernel/time/hrtimer.c          |  14 ++-
 kernel/time/posix-cpu-timers.c |  10 +-
 kernel/time/posix-stubs.c      |   8 +-
 kernel/time/posix-timers.c     |   8 +-
 10 files changed, 115 insertions(+), 176 deletions(-)

-- 
2.23.0

