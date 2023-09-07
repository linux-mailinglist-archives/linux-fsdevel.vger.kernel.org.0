Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27332797D84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 22:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbjIGUnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 16:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjIGUnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:43:31 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C3D1BCB;
        Thu,  7 Sep 2023 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gb76rMu1s/otiIX9SWmc+H7OVxlaShMYbogoHQw/eG4=; b=VEhHrkTMJJ2KYIHPow3dpn2Vh2
        /IV7E267/o0KkeCgiZzwbpG0JJDKAyjm6A3/vS4DO06oHXEHDKaqD26CbupT8bs2BYEA0g/bTR0eZ
        BUowW7MygmJkiZjuJxH6+JbguKr0DJ1sGWNWVx9vjWmydx2EdPK0tYiOvxaBxFBpAmfTPM6q43mhR
        NWdzspEEvDRIz7LcwOi43KIG0b934HWvnDu3YznIb8EBoNanwoKBwtA/ZcQpznU8ig8iVV7BxV4F5
        tsK92qzFvt24+T81GUklsRFbdlb3BPFa2gkBU66Y/EL5RJOQWNoJBGRzs68fOfSH8D/7JXr8cY+9e
        oHByqHEQ==;
Received: from [179.232.147.2] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qeLqL-000goB-IB; Thu, 07 Sep 2023 22:43:15 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        keescook@chromium.org, ebiederm@xmission.com, oleg@redhat.com,
        yzaikin@google.com, mcgrof@kernel.org, akpm@linux-foundation.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk, willy@infradead.org,
        david@redhat.com, dave@stgolabs.net, sonicadvance1@gmail.com,
        joshua@froggi.es, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [RFC PATCH 0/2] Introduce a way to expose the interpreted file with binfmt_misc
Date:   Thu,  7 Sep 2023 17:24:49 -0300
Message-ID: <20230907204256.3700336-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the kernel provides a symlink to the executable binary, in the
form of procfs file exe_file (/proc/self/exe_file for example). But what
happens in interpreted scenarios (like binfmt_misc) is that such link
always points to the *interpreter*. For cases of Linux binary emulators,
like FEX [0] for example, it's then necessary to somehow mask that and
emulate the true binary path.

We hereby propose a way to expose such interpreted binary as exe_file if
the flag 'I' is selected on binfmt_misc. When that flag is set, the file
/proc/self/exe_file points to the *interpreted* file, be it ELF or not.
In order to allow users to distinguish if such flag is used or not without
checking the binfmt_misc filesystem, we propose also the /proc/self/interpreter
file, which always points to the *interpreter* in scenarios where
interpretation is set, like binfmt_misc. This file is empty / points to
nothing in the case of regular ELF execution, though we could consider
implementing a way to point to the LD preloader if that makes sense...

This was sent as RFC because of course it's a very core change, affecting
multiple areas and there are design choices (and questions) in each patch
so we could discuss and check the best way to implement the solution as
well as the corner cases handling. This is a very useful feature for
emulators and such, like FEX and Wine, which usually need to circumvent
this kernel limitation in order to expose the true emulated file name
(more examples at [1][2][3]).

This patchset is based on the currently v6.6-rc1 candidate (Linus tree
from yesterday) and was tested under QEMU as well as using FEX.
Thanks in advance for comments, any feedback is greatly appreciated!
Cheers,

Guilherme


[0] https://github.com/FEX-Emu/FEX

[1] Using an environment variable trick to override exe_file:
https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/util/u_process.c#L209 

[2] https://github.com/baldurk/renderdoc/pull/2694

[3] FEX handling of the exe_file parsing:
https://github.com/FEX-Emu/FEX/blob/main/Source/Tools/FEXLoader/LinuxSyscalls/FileManagement.cpp#L499


Guilherme G. Piccoli (2):
  binfmt_misc, fork, proc: Introduce flag to expose the interpreted binary in procfs
  fork, procfs: Introduce /proc/self/interpreter symlink

 Documentation/admin-guide/binfmt-misc.rst |  11 ++
 arch/arc/kernel/troubleshoot.c            |   5 +
 fs/binfmt_elf.c                           |   7 ++
 fs/binfmt_misc.c                          |  11 ++
 fs/coredump.c                             |   5 +
 fs/exec.c                                 |  26 ++++-
 fs/proc/base.c                            |  48 +++++---
 include/linux/binfmts.h                   |   4 +
 include/linux/mm.h                        |   7 +-
 include/linux/mm_types.h                  |   2 +
 kernel/audit.c                            |   5 +
 kernel/audit_watch.c                      |   7 +-
 kernel/fork.c                             | 131 +++++++++++++++++-----
 kernel/signal.c                           |   7 +-
 kernel/sys.c                              |   5 +
 kernel/taskstats.c                        |   7 +-
 security/tomoyo/util.c                    |   5 +
 17 files changed, 241 insertions(+), 52 deletions(-)

-- 
2.42.0

