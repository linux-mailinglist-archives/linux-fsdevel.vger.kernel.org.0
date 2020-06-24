Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFF2078CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404767AbgFXQOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404235AbgFXQOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:14:02 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55344C061573;
        Wed, 24 Jun 2020 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=90OlxAKKJk4MpfGF1wAK+VcXxFJhMFQm3EERw9Z5SnM=; b=gY7cW0jyIntr1TMC49eyr8618s
        pp7PTXnQGIfLOzJhZrUt7AKPtN7e5veG32FkbWOnsBdcKISt7caT3QrJqO3tXiLzLW8JrImMsZcpo
        4Pv1tVxQ5hc0Dmk763ZRBduhuQC4nmmuM1MCjYAIisGws+cWSdZO4S4c8SpwJ2Aup5MKRG2xovdEf
        lU+I6pL16Qw44QQ/sy10leiibrFdZRFXCwMyvqVymtLmW1WXuZC/dD8mz3KgIy+vowJ4+6qHsKEv1
        tMLqzPy0Y8NscRvPZqg7+4Ng62bVC1ovT3Evc/wvkJoJexju596z3TJ2tEzxsFjGBrHi6MGracAqG
        eS1my67g==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo81p-0005xR-56; Wed, 24 Jun 2020 16:13:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: clean up kernel_{read,write} & friends v5
Date:   Wed, 24 Jun 2020 18:13:21 +0200
Message-Id: <20200624161335.1810359-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

this series fixes a few issues and cleans up the helpers that read from
or write to kernel space buffers, and ensures that we don't change the
address limit if we are using the ->read_iter and ->write_iter methods
that don't need the changed address limit.

I did not add your suggested comments on the instances using
uaccess_kernel as all of them already have comments.  If you have
anything better in mind feel free to throw in additional comments.


Changes since v4:
 - warn on calling __kernel_write on files not open for write
 - add a FMODE_READ check and warning in __kernel_read
 - add a new patch to remove kernel_readv
 - stop preferring the iter variants if normal read/write is
   present

Changes since v3:
 - keep call_read_iter/call_write_iter for now
 - don't modify an existing long line
 - update a change log

Changes since v2:
 - picked up a few ACKs

Changes since v1:
 - __kernel_write must not take sb_writers
 - unexport __kernel_write

Diffstat:
 fs/autofs/waitq.c            |    2 
 fs/cachefiles/rdwr.c         |    2 
 fs/read_write.c              |  171 ++++++++++++++++++++++++++-----------------
 fs/splice.c                  |   53 +++----------
 include/linux/fs.h           |    4 -
 net/bpfilter/bpfilter_kern.c |    2 
 security/integrity/iint.c    |   14 ---
 7 files changed, 125 insertions(+), 123 deletions(-)
