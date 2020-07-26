Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D295822E115
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGZQEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 12:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgGZQEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:04:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55741C0619D4;
        Sun, 26 Jul 2020 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UyAQuKzOjtI/x1r3Rxgb+Q9XWacAff5rq+0vrGSNTvw=; b=FafvLAUw2Km0gfGFD6euiu6kRr
        AkfcGLFyA7DNFjZb+gYe7/VuiUDIQsKcqi3Mz/B74maTqHuig5mQ0FQqeXV4gCrQn7q7KGQT0oRgY
        UUQJBeI9Icto65wHQRDvNE+GaZFZDJeEJuxLtBaStcBBvyVuYz82cSJj0QesJdalXKgfLRUIssZol
        BNaj+YK9hDgc9BCY6h+6RU+mpefIEPlpqwczaa+SdGN4EoB4G7GHRfkuFVb2R5v0QcQwWcivty2u7
        1zld9ry8CAPrkWFpr14FZQ72uN6HzbqoiWLNqm0URIZrP+0GXSnC5wkZyt3oGX+hcwGHGpfIyadjp
        ptOJHnIw==;
Received: from [2001:4bb8:18c:2acc:2375:88ff:9f84:118d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzj87-0000YT-Ed; Sun, 26 Jul 2020 16:04:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Jan Kara <jack@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: improve compat handling for the i386 u64 alignment quirk
Date:   Sun, 26 Jul 2020 18:03:57 +0200
Message-Id: <20200726160401.311569-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

the i386 ABI is a little special in that it uses less than natural
alignment for 64-bit integer types (u64 and s64), and a significant
amount of our compat handlers deals with just that.  Unfortunately
there is no good way to check for this specific quirk at runtime,
similar how in_compat_syscall() checks for a compat syscall.  This
series adds such a check, and then uses the quota code as an example
of how this improves the compat handling.  I have a few other places
in mind where this will also be useful going forward.

Diffstat:
 b/arch/arm64/include/asm/compat.h        |    2 
 b/arch/arm64/include/asm/stat.h          |    2 
 b/arch/arm64/kernel/process.c            |    1 
 b/arch/arm64/kernel/ptrace.c             |    1 
 b/arch/mips/include/asm/compat.h         |    2 
 b/arch/parisc/include/asm/compat.h       |    2 
 b/arch/powerpc/include/asm/compat.h      |    2 
 b/arch/s390/include/asm/compat.h         |    2 
 b/arch/sparc/include/asm/compat.h        |    3 
 b/arch/x86/entry/syscalls/syscall_32.tbl |    2 
 b/arch/x86/include/asm/compat.h          |    3 
 b/fs/quota/Kconfig                       |    5 -
 b/fs/quota/Makefile                      |    1 
 b/fs/quota/compat.h                      |   34 ++++++++
 b/fs/quota/quota.c                       |   73 +++++++++++++++---
 b/include/linux/compat.h                 |   17 ++++
 b/include/linux/quotaops.h               |    3 
 b/kernel/sys_ni.c                        |    1 
 fs/quota/compat.c                        |  120 -------------------------------
 19 files changed, 114 insertions(+), 162 deletions(-)
