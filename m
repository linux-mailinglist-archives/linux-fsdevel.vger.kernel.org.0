Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47256EC53D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjDXFtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDXFtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:49:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D5119B3;
        Sun, 23 Apr 2023 22:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rxuwauPRwLemTJXwY3VrKMRJhs+GgwhnyBD4s7nm7AY=; b=3MpQEmnJ4id5J1jZ4YFohK5H8q
        bs7ciFKUIE9sA5F//wk8TThxaPzhLwI6FsUH1vKzNkmpHyq88uhXgF7wTEHMLlqIzGShUjm1tpoQ/
        V9Tji0dQSyZQM/K5ekDNoH5faw93KpoQQtAuWkTbvGbcl7apn0KwIYdsbsU9S2n8QH5hFEZJO4yZ5
        yp8GdzGRgc1AHk7t7DD60UmLFSqOCfsXJza1GpGtauNVHkVJvJiQUeDviaHbb72Zouz31uRXC/4XE
        B+bfmZC/bCU0vqPNw8dnGTB4G0skWpel5LUkS6Ua52Z/N1nKMNRb49n9vt5etsldL20AA2wC69Vmq
        TVA2auLw==;
Received: from [2001:4bb8:189:a74f:e8a5:5f73:6d2:23b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqp4s-00FOtV-2G;
        Mon, 24 Apr 2023 05:49:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: RFC: allow building a kernel without buffer_heads
Date:   Mon, 24 Apr 2023 07:49:09 +0200
Message-Id: <20230424054926.26927-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

after all the talk about removing buffer_heads, here is a series that
shows how to build a kernel without buffer_heads.  And how unrealistic
it is to remove the entirely.

Most of the series refactors some common code to make implementing direct
I/O easier without use of the ->direct_IO method and the helpers based
around it.  It then switches buffered writes (but not writeback) for
block devices to use iomap unconditionally, but still using buffer_heads.

The final patch then adds a CONFIG_BUFFER_HEAD selected by all file
systems that need it (which is most block based file systems), makes the
buffer_head support in iomap optional, and adds an alternative
implementation of the block device address_operations using iomap.

With this you can build a kernel with block device support, but without
buffer_heads.  This kernel supports xfs and btrfs as full blown block
based filesystems, and a bunch of read-only ones like cramfs, erofs and
squashfs.  Note that the md software raid drivers is also disabled as it
has some (rather questionable) buffer_head usage in the unconditionally
built bitmap code.

The series is based on Linux 6.3 and will need some rebasing before it
can be fed to the maintainers incrementally.  All but the last patch
definitively seem useful for me.  The last one I think is just to avoid
introducing new buffer_head dependencies, even if I suspect the real
life usefulness of a !CONFIG_BUFFER_HEAD kernel might be rather limited.
