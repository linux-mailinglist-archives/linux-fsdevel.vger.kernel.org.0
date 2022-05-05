Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA09551CA44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 22:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385691AbiEEUPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385692AbiEEUPE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 16:15:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FF25F270;
        Thu,  5 May 2022 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PM/ccdcCD65YSGdtLUhZqCD/2HMCRZs8uHjzR7djGJc=; b=0BiWRkfdPMosId3kf4yQdb54lq
        E0wUE7dJH1N4x/QTJyIUAdWRKMYdPGObO4CAF1i6UnVjQYsZAXNsteVHfLrv43c+BpZpB0hhBDw3O
        BIVTTJ6xjUe9ohXguAioDP4uksbyzEjjnp8uxtZ/Q7bx3Irw1I26/QBxAYAstcbQf16ncu8HSPLkj
        sxJp39YcqwvQUx0/FfnYVPGkO5csTywIU6Vxtxx+GTebnOnEsSr3pensS9e2H4baosbaWX9G/wa09
        yhJyRnNzCwk8SESNDcLvhJKCHHMUAmkKMUdo91ikFHAC4m5N1oWlfylz8g8jyR64XGC7PsNJCMHFG
        gsVAvjEA==;
Received: from 65-114-90-19.dia.static.qwest.net ([65.114.90.19] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmhoj-0006hV-B9; Thu, 05 May 2022 20:11:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: reduce memory allocation in the btrfs direct I/O path v2
Date:   Thu,  5 May 2022 15:11:08 -0500
Message-Id: <20220505201115.937837-1-hch@lst.de>
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

Changes since v1:
 - pass the private data direct to iomap_dio_rw instead of through the
   iocb
 - better document the bio_set in iomap_dio_ops
 - split a patch into three
 - use kcalloc to allocate the checksums

Diffstat:
 fs/btrfs/btrfs_inode.h |   25 --------
 fs/btrfs/ctree.h       |    6 -
 fs/btrfs/file.c        |    6 -
 fs/btrfs/inode.c       |  152 +++++++++++++++++++++++--------------------------
 fs/erofs/data.c        |    2 
 fs/ext4/file.c         |    4 -
 fs/f2fs/file.c         |    4 -
 fs/gfs2/file.c         |    4 -
 fs/iomap/direct-io.c   |   26 ++++++--
 fs/xfs/xfs_file.c      |    6 -
 fs/zonefs/super.c      |    4 -
 include/linux/iomap.h  |   16 ++++-
 12 files changed, 123 insertions(+), 132 deletions(-)
