Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7214BFD55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 16:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiBVPrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 10:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiBVPrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:47:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A76E1A804;
        Tue, 22 Feb 2022 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Huls1rFGB2qZ4Fp0OAzd0z5j8dCiIe4CcnDjsirdHE0=; b=NY5NPM4j7DAPbkK2cuMwVlfa9+
        pLtx2zKV51IUpxN7o0axOaaHbuz+beKtzWxc4XEL07ug7leB4Yspk738ozlaaKjWJovbBXQBqXNyf
        om34hTqCcGkdiUHf+j/bfamzv5QoP6KfFuYt2iBA9s5Y4ATbsQwK9gN/MJN48svGIBCqS9zotUV+L
        CTqIQMCatfRCPBM05BCxZnW65Ugl3HjvA8UkzHDlR4rS9aSSxve7S5y2Tl0bO4fthkP8GFtlc0YjN
        xl33J386SdqkhSC5ccdG2hBr/4vQv6x6zo+nDpY9jP1EcQLa4ccie6/aCoShiKC0TTSycbGcHjdEa
        XD5+2vxA==;
Received: from [2001:4bb8:198:f8fc:c22a:ebfc:be8d:63c2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMXN6-00ANW4-Kb; Tue, 22 Feb 2022 15:46:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, "Theodore Ts'o" <tytso@mit.edu>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: simple file system cleanups for the new bio_alloc calling conventions
Date:   Tue, 22 Feb 2022 16:46:31 +0100
Message-Id: <20220222154634.597067-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

this fixes up the remaining fairly trivial file system bio alloctions to
directly pass the bdev to bio_alloc.  f2fs and btrfs will need more work and
will be handled separately.

This is against Jens' for-5.18/block branch.  It would probably make sense to
also merge it through that.

Diffstat:
 ext4/page-io.c  |    7 +++----
 mpage.c         |   50 +++++++++++++++++++++-----------------------------
 nilfs2/segbuf.c |   20 +++++++++-----------
 3 files changed, 33 insertions(+), 44 deletions(-)
