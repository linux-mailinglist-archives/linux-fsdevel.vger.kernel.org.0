Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2126D26D667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 10:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgIQIZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 04:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgIQIY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:24:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E408C06174A;
        Thu, 17 Sep 2020 01:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Dv3rGFm1Kct421bC4ikilNsrxpM6Mgb8/oXPwK5ENVk=; b=j7Y+k4l3TyDcf89UtdqgGjIGxl
        h4jq9Ekj+WZrxuJtFRYsIghVbyktSEIRLzh2f0Y1BHlGLoClXQseIx2oNy+aDX1UV/TZDiz3At2SW
        PNR9/okKDUrOJ3UMLcEAxG0O/muyWsah+9ntiGzgPmlpPAgwXX4jCy4cviYtFkuWpeaSRB53qrKkW
        l5XRzuwt7KiuW2CXZF84PeNeTYHAnNCTIe71RJrgoI+yjzUW1muogLu8OCPOKfZodCHKrGljPG6Ai
        sFBjo1v/PvsaGcnw2XFAKpMNJmtE48kUHfwRYU3HM064RZnaFJuf2V1IDPwaKxR33sp4eN4s/vkSf
        4Q0IE0Tg==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIpDi-0000wS-VP; Thu, 17 Sep 2020 08:24:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: remove compat_sys_mount
Date:   Thu, 17 Sep 2020 10:22:31 +0200
Message-Id: <20200917082236.2518236-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

this series moves the NFSv4 binary mount data compat handling to fs/nfs/,
and removes the now pointless compat_sys_mount.

Diffstat:
 b/arch/alpha/kernel/osf_sys.c                        |  116 +++--------
 b/arch/arm64/include/asm/unistd32.h                  |    2 
 b/arch/mips/kernel/syscalls/syscall_n32.tbl          |    2 
 b/arch/mips/kernel/syscalls/syscall_o32.tbl          |    2 
 b/arch/parisc/kernel/syscalls/syscall.tbl            |    2 
 b/arch/powerpc/kernel/syscalls/syscall.tbl           |    2 
 b/arch/s390/kernel/syscalls/syscall.tbl              |    2 
 b/arch/sparc/kernel/syscalls/syscall.tbl             |    2 
 b/arch/x86/entry/syscalls/syscall_32.tbl             |    2 
 b/fs/Makefile                                        |    1 
 b/fs/internal.h                                      |    3 
 b/fs/namespace.c                                     |   29 --
 b/fs/nfs/fs_context.c                                |  195 ++++++++++++-------
 b/include/linux/compat.h                             |    6 
 b/include/linux/fs.h                                 |    2 
 b/include/uapi/asm-generic/unistd.h                  |    2 
 b/tools/include/uapi/asm-generic/unistd.h            |    2 
 b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |    2 
 b/tools/perf/arch/s390/entry/syscalls/syscall.tbl    |    2 
 fs/compat.c                                          |  132 ------------
 20 files changed, 179 insertions(+), 329 deletions(-)
