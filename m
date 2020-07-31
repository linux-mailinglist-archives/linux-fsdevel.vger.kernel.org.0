Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA662345AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 14:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbgGaMWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 08:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733283AbgGaMWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:22:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBFAC061574;
        Fri, 31 Jul 2020 05:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9uobcNq4xnks0xuZFqsb4L1vX6lu2ZzJrjBZkoGvKIg=; b=HVR60Foe6Jwbbk3eyWFKnqiWUJ
        kRHzd5fEOlD2Ra24dhIxR21iHdOAgywXsD9oeRf5cXQ6L9JaMN6j9lS+JZPbxpoXaBeLu2kJ0AOwj
        dJW2otfOm9g7GA22FWO97ZJzmKMTh1hmzSHq0WLvU/0QaNMJqOrKGvi2dBYw8yI9tE1W/Af/zZzdC
        /np8onjsYtFwryiFxMVAPNKraBbqEfblPmuwL43IM/dR11tXO2xqlTDUULxFw+T1djBjS2GK59Nlb
        j0UCvqB8pb2qi34ymIs+S/dq+3uvdusgtUWkptaB+v3Yhfnjsj/YDbkzB5a53Zm7y+qpkIR5eNKrw
        DaDGIlpA==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1U31-000256-PI; Fri, 31 Jul 2020 12:22:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Jan Kara <jack@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: improve compat handling for the i386 u64 alignment quirk v2
Date:   Fri, 31 Jul 2020 14:21:59 +0200
Message-Id: <20200731122202.213333-1-hch@lst.de>
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

Changes since v1:
 - use asm-generic/compat.h instead of linux/compat.h for
   compat_u64 and compat_s64
 - fix a typo

Diffstat:
 b/arch/arm64/include/asm/compat.h        |    2 
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
 b/include/asm-generic/compat.h           |    8 ++
 b/include/linux/compat.h                 |    9 ++
 b/include/linux/quotaops.h               |    3 
 b/kernel/sys_ni.c                        |    1 
 fs/quota/compat.c                        |  120 -------------------------------
 17 files changed, 113 insertions(+), 159 deletions(-)
