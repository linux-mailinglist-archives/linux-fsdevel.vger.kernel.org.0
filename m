Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AECB51A560
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353382AbiEDQ1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiEDQ1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 12:27:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C1C4617E;
        Wed,  4 May 2022 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BIya54tSTsUnhKbrLEUbCPjcYCkQsUtpSE+M0C/VidU=; b=VBMfxw2zBWf2kECxQpXimyXz2K
        OKEyuxJ1ApWz8Mc7/0GkchqYTeU6LyXUIR6WOaw1nV6F+iHOhN1g6qlIJ43Ja5EdBbaMlREXwSphM
        sCzi/I3Z0IfuEHRz45TEYdFT7rQsADY8+a8ct3vArDLAtce7GriwMgKG5xpVMs+59jmopBShxac9f
        0W6CmYIuNe4Bjcqqgjjuj5qMtRGeEBkrW4P6PDBwMQnb/ei8bMs/UDV3IkBoyydqGtHvWIUi0/k7C
        YB5MCk8fYnDJqziS/p8ZGAlPufUe2hsIJr2ovgSI85L8DG9Pru8h6xm8I/cbp1qbxLb73GafOwcu5
        siZNpPyw==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmHmw-00BeCv-Hk; Wed, 04 May 2022 16:23:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: reduce memory allocation in the btrfs direct I/O path
Date:   Wed,  4 May 2022 09:23:37 -0700
Message-Id: <20220504162342.573651-1-hch@lst.de>
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

this series adds two minor improvements to iomap that allow btrfs
to avoid a memory allocation per read/write system call and another
one per submitted bio.  I also have at last two other pending uses
for the iomap functionality later on, so they are not really btrfs
specific either.

Diffstat:
 fs/btrfs/btrfs_inode.h |   25 --------
 fs/btrfs/ctree.h       |    6 -
 fs/btrfs/file.c        |    6 -
 fs/btrfs/inode.c       |  152 +++++++++++++++++++++++--------------------------
 fs/iomap/direct-io.c   |   26 +++++++-
 include/linux/iomap.h  |    4 +
 6 files changed, 104 insertions(+), 115 deletions(-)
