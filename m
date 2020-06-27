Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B523D20BF68
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgF0H1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 03:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgF0H1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 03:27:35 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD82C03E97A;
        Sat, 27 Jun 2020 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=WF3lnu8Ab9pal8d+L5CJQSnF7YblfVXe9YB122JUEL8=; b=LnMGpzds0pKVb++Ll9qJeyPBlz
        bZLdBLNHbz+Z479r8nUV78+wnbcKgIp5Do++xHw8qv7SG4DBARi0P4MBiDZ9X6tSasRxUf+zEmYbc
        tZ3OHYrvlvIrwRAf5hb29Rwh8uD6Rv8E3Y6Lcrz/U5vlZbHRZLfhpp5iQS+POraJTB/yWxnOgrbrd
        fxJi2NPsxDTGPjozb+M7K41cPSxLW7V4OKc8by80DBew2jriADNi4Kb+AfnIVXpb4PONujdJWAfpB
        iz0eROiH1yRCN9g9pQyW7b53iCg4a0fH9msn4CpyIxpiDms1zVzkPhm64y7bwJGCQTjQ+uLWS74Kq
        0/cnXaDw==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5Ew-0006W3-6i; Sat, 27 Jun 2020 07:27:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: properly support exec with kernel pointers v3
Date:   Sat, 27 Jun 2020 09:26:59 +0200
Message-Id: <20200627072704.2447163-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series first cleans up the exec code and then adds proper
kernel_execveat and kernel_wait callers instead of relying on the fact
that the early init code and kernel threads implicitly run with
the address limit set to KERNEL_DS.

Note that the cleanup removes the compat execve(at) handlers entirely, as
we can handle the compat difference very nicely in a unified codebase.
x32 needs two hacky #defines for that for now, although those can go
away if the x32 syscall rework from Brian gets merged.

I think this is ready to get picked up.  What would the best tree be?
Most important a git tree would be good, as I have other work building
on top of it.


Changes since v2:
 - drop the kernel_wait addition, as this interacts with a series
   from Luis and should be merged together with that one

Changes since v1:
 - remove a pointless ifdef from get_user_arg_ptr
 - remove the need for a compat syscall handler for x32


Diffstat:
 arch/arm64/include/asm/unistd32.h                  |    4 
 arch/mips/kernel/syscalls/syscall_n32.tbl          |    4 
 arch/mips/kernel/syscalls/syscall_o32.tbl          |    4 
 arch/parisc/kernel/syscalls/syscall.tbl            |    4 
 arch/powerpc/kernel/syscalls/syscall.tbl           |    4 
 arch/s390/kernel/syscalls/syscall.tbl              |    4 
 arch/sparc/kernel/syscalls.S                       |    4 
 arch/x86/entry/syscall_x32.c                       |    7 
 arch/x86/entry/syscalls/syscall_32.tbl             |    4 
 arch/x86/entry/syscalls/syscall_64.tbl             |    4 
 fs/exec.c                                          |  248 ++++++++-------------
 include/linux/binfmts.h                            |   10 
 include/linux/compat.h                             |    7 
 include/uapi/asm-generic/unistd.h                  |    4 
 init/main.c                                        |    5 
 kernel/umh.c                                       |   14 -
 tools/include/uapi/asm-generic/unistd.h            |    4 
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |    4 
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |    4 
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |    4 
 20 files changed, 149 insertions(+), 198 deletions(-)
