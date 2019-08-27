Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929239F3F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbfH0UVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 16:21:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:47008 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731237AbfH0UVV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:21:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0A9AB0E5;
        Tue, 27 Aug 2019 20:21:18 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Allison Randal <allison@lohutok.net>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] Disable compat cruft on ppc64le
Date:   Tue, 27 Aug 2019 22:21:05 +0200
Message-Id: <cover.1566936688.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With endian switch disabled by default the ppc64le compat supports
ppc32le only which is something next to nobody has binaries for.

Less code means less bugs so drop the compat stuff.

I am not particularly sure about the best way to resolve the llseek
situation. I don't see anything in the syscal tables making it
32bit-only so I suppose it should be available on 64bit as well.

This is tested on ppc64le top of

https://patchwork.ozlabs.org/cover/1141078/
https://patchwork.ozlabs.org/cover/1153556/
https://patchwork.ozlabs.org/cover/1150815/

Thanks

Michal

Michal Suchanek (4):
  fs: always build llseek.
  powerpc: move common register copy functions from signal_32.c to
    signal.c
  powerpc/64: make buildable without CONFIG_COMPAT
  powerpc/64: Disable COMPAT if littleendian.

 arch/powerpc/Kconfig               |   2 +-
 arch/powerpc/include/asm/syscall.h |   2 +
 arch/powerpc/kernel/Makefile       |  15 ++-
 arch/powerpc/kernel/entry_64.S     |   2 +
 arch/powerpc/kernel/signal.c       | 146 ++++++++++++++++++++++++++++-
 arch/powerpc/kernel/signal_32.c    | 140 ---------------------------
 arch/powerpc/kernel/syscall_64.c   |   5 +-
 arch/powerpc/kernel/vdso.c         |   4 +-
 arch/powerpc/perf/callchain.c      |  14 ++-
 fs/read_write.c                    |   2 -
 10 files changed, 177 insertions(+), 155 deletions(-)

-- 
2.22.0

