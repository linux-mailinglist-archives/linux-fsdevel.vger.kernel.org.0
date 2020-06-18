Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AB1FF556
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgFROqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbgFROqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:46:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0076CC06174E;
        Thu, 18 Jun 2020 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8QjkAe3/WcEFMISjfM9pTovm01qLhHp9DQnrjNzziO4=; b=iQdiM599hgB2VTm8/MEfD5e9/h
        IO+hz1X0s5Cn8wiQUVQtVfCpXN59W+JiOWbUz/qJ+Wi+5bUk+U1urz45Ia/FGyF1aSr3MZF7Rg/RO
        9l/NhXWgIFhwKv7iM8TBk9QM9JZaMJlnOKs46CqmjjC7PvYBa7IB9dsmrqZegeIraDlbLZVnHa1Ry
        MB8cB00346xJgkB5dzB+ZgbJy2kUELzEQMHasMsO9m6eD/c6LMDo7CAQj0xy7Id7nKDZ4tXmEE8r2
        eXLQH6EWKGpzA918dD+CZQD7w06kzvF4KETxfdtIlU9jidmRg2U4PNNHtcGi4earl04GyeDkRZpG4
        skbgKaNw==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlvoD-0006Ge-VD; Thu, 18 Jun 2020 14:46:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: properly support exec and wait with kernel pointers v2
Date:   Thu, 18 Jun 2020 16:46:21 +0200
Message-Id: <20200618144627.114057-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
 include/linux/sched/task.h                         |    1 
 include/uapi/asm-generic/unistd.h                  |    4 
 init/main.c                                        |    5 
 kernel/exit.c                                      |   16 +
 kernel/umh.c                                       |   43 ---
 tools/include/uapi/asm-generic/unistd.h            |    4 
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |    4 
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |    4 
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |    4 
 22 files changed, 170 insertions(+), 223 deletions(-)
