Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFFC6B984A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 15:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCNOvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjCNOvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:51:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19F2A2F1E;
        Tue, 14 Mar 2023 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=H1QGXFGueBuHBkdVnY1gVNgWxdg/uqRKaISs/k4X5k8=; b=S7EeSUpGaZlBdHu4WUHAIdr25V
        ixFY7YsdAbe5O4aABq5JSzhjm6AQQEt3eXVPOFTCWjSNtDCgQFZErMmKupnpF9Y/4skbRxraN6HkX
        TqmDE1TcO5R6zBSPSKRc5doATbZgmLE4SGmmnROLttR98UmmdtbKjQjHzeTUwv1E1p/bjEoFFy+iH
        nyqmOOJUi5ry9SunSrF7pQBYspmk5uLVQJF6SmWk5LWJAeaLgy3Zr7wr5xxwd+hQMMwpvWD+yVxuy
        /CaVhXopsc+90LrYwApR0yOX/0l4LaCriYpzBh1LHFmzupT2UryDjtJai0v3ndjSU6zPsYceoZ+bh
        bp/MSRHg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pc5zT-00CzPv-OB; Tue, 14 Mar 2023 14:51:03 +0000
Date:   Tue, 14 Mar 2023 14:51:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, devel@lists.orangefs.org,
        reiserfs-devel@vger.kernel.org,
        Evgeniy Dushistov <dushistov@mail.ru>
Subject: RFC: Filesystem metadata in HIGHMEM
Message-ID: <ZBCJ11qT8AWGA9y8@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TLDR: I think we should rip out support for fs metadata in highmem

We want to support filesystems on devices with LBA size > PAGE_SIZE.
That's subtly different and slightly harder than fsblk size > PAGE_SIZE.
We can use large folios to read the blocks into, but reading/writing
the data in those folios is harder if it's in highmem.  The kmap family
of functions can only map a single page at a time (and changing that
is hard).  We could vmap, but that's slow and can't be used from atomic
context.  Working a single page at a time can be tricky (eg consider an
ext2 directory entry that spans a page boundary).

Many filesystems do not support having their metadata in highmem.
ext4 doesn't.  xfs doesn't.  f2fs doesn't.  afs, ceph, ext2, hfs,
minix, nfs, nilfs2, ntfs, ntfs3, ocfs2, orangefs, qnx6, reiserfs, sysv
and ufs do.

Originally, ext2 directories in the page cache were done by Al Viro
in 2001.  At that time, the important use-case was machines with tens of
gigabytes of highmem and ~800MB of lowmem.  Since then, the x86 systems
have gone to 64-bit and the only real uses for highmem are cheap systems
with ~8GB of memory total and 2-4GB of lowmem.  These systems really
don't need to keep directories in highmem; using highmem for file &
anon memory is enough to keep the system in balance.

So let's just rip out the ability to keep directories (and other fs
metadata) in highmem.  Many filesystems already don't support this,
and it makes supporting LBA size > PAGE_SIZE hard.

I'll turn this into an LSFMM topic if we don't reach resolution on the
mailing list, but I'm optimistic that everybody will just agree with
me ;-)
