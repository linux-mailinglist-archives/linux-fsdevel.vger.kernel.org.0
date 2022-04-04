Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB73F4F0E34
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 06:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377136AbiDDErh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 00:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiDDErg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:47:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3832EEB;
        Sun,  3 Apr 2022 21:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kvaN7bSubGJEvqAl+rPwCFczeM3RZMixNCagJ9CiKZk=; b=1nAMrwihcVMSkZbF/Hr4fkWwv7
        eGe2AvJRRAsIW1qpXNOLG+xNfP/ikWMKe8bnr1u46u+8xUurv4EYPtjV3v3rRWuNhbIlKEhvQxj0K
        cdF9gMl1SMiCrewEJrNj0/gBV1rrQhF2DRcZVG+ag+3GJrwcsGYNJ8mx8rK0LTVZwFukmpAhvsvDK
        JHg4w9XfbsfdpnXB7JePvq1uasnllOBrOGVbSnawXPLw2VYA/Pzm/In0aWWtWrb1B+pf8joIKNuYg
        1BQiDIIAZecgie4f7jkHan3qEbvyZgm0+oT6XUPJecyQ5WBEdni8TiqehvRnMe+elC7A38FsElDvE
        wEt4pJ0A==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEaq-00D3UL-Iu; Mon, 04 Apr 2022 04:45:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: cleanup btrfs bio handling, part 1
Date:   Mon,  4 Apr 2022 06:45:16 +0200
Message-Id: <20220404044528.71167-1-hch@lst.de>
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

this series  moves btrfs to use the new as of 5.18 bio interface and
cleans up a few close by areas.  Larger cleanups focussed around
the btrfs_bio will follow as a next step.

Diffstat:
 check-integrity.c |  165 +++++++++++++++++++++++++-----------------------------
 check-integrity.h |    8 +-
 disk-io.c         |    6 +
 extent_io.c       |   55 ++++++++----------
 extent_io.h       |    2 
 raid56.c          |   46 ++++++---------
 scrub.c           |   92 ++++++++++++------------------
 volumes.c         |   12 ++-
 8 files changed, 179 insertions(+), 207 deletions(-)
