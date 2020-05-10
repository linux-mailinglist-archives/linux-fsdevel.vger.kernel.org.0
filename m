Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982D41CC7D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgEJHzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgEJHzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:55:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE92FC061A0E;
        Sun, 10 May 2020 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7/gXVwxfQCALl/htOL9nGBBdk9CR2DqbWyS3c9DzJzg=; b=TvxbsuwUX/hm6+Z8fi/17h3sCr
        V6hTHGgSMnPIXClp9WBd4xHpkact4TdSPlY40kgpTlFrc4X0TcbVrodeZch2eF33X40QtPmPFET1U
        Tys5kVImtNbCnWZn12idX8lvZh32iDnfxIDeXhSFPGHn0PMIm30TD0pbjnUShEADOadDDfLCmcKnm
        wKfgOhNBY1n/ICaPIfQgdGgBtYZHWT6fzJbX2O0Ol1Icyt3JJoleMMbRsBA4C7Ht6DLkc7DlYLbcX
        cjmyou6JXKISuiamP88TvDgJ4S2xixwnMizgAVSPuwNbaVDo6GTG7tK/YFq90voaly/1rUW1zB1cS
        ecEzX6Qw==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXgno-0007lE-9T; Sun, 10 May 2020 07:55:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org
Subject: sort out the flush_icache_range mess
Date:   Sun, 10 May 2020 09:54:39 +0200
Message-Id: <20200510075510.987823-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

flush_icache_range is mostly used for kernel address, except for the following
cases:

 - the nommu brk and mmap implementations,
 - the read_code helper that is only used for binfmt_flat, binfmt_elf_fdpic,
   and binfmt_aout including the broken ia32 compat version
 - binfmt_flat itself,

none of which really are used by a typical MMU enabled kernel, as a.out can
only be build for alpha and m68k to start with.

But strangely enough commit ae92ef8a4424 ("PATCH] flush icache in correct
context") added a "set_fs(KERNEL_DS)" around the flush_icache_range call
in the module loader, because apparently m68k assumed user pointers.

This series first cleans up the cacheflush implementations, largely by
switching as much as possible to the asm-generic version after a few
preparations, then moves the misnamed current flush_icache_user_range to
a new name, to finally introduce a real flush_icache_user_range to be used
for the above use cases to flush the instruction cache for a userspace
address range.  The last patch then drops the set_fs in the module code
and moves it into the m68k implementation.

A git tree is available here:

    git://git.infradead.org/users/hch/misc.git flush_icache_range

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/flush_icache_range
