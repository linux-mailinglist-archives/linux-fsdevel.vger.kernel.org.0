Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FA4658EC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 17:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiL2QLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 11:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiL2QKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:10:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C81210A7;
        Thu, 29 Dec 2022 08:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rRMjyybI4BLGnpomTYi5lWNLUT7Kcy+Hv5Mat8aX7RQ=; b=30PC0fVD2644K3q35Oc0cw5f1v
        LTpWsGmTAvtWdovsneRivRCLXQqwtM1G/u5qMZ5ReUGiW2Bqqbmpak/j5/zXkmZE70FB7O3OIzsPw
        bnM+fLK7J9EoU3zXk5qFE5qD0b4FftkAYzJbSDH8SyjZzLfSLu8MinxJO6b5m0Y3eHuy0fPDRKsdz
        MQ1tnejaevDS0o1+/tm8Uhlrx2xgd6/YjnsvkyvwBiI/b/8osn+I7sutWA8g4koNVqcjSQY1ulCGe
        7bYVL4pD9JBD2CGWxGIZ0qwEV/fMEKKx0GrCUmjV5QQYg2eju3SaZHsWOZq67PuuaYSXwL7trb+2q
        bCFKXNtQ==;
Received: from rrcs-67-53-201-206.west.biz.rr.com ([67.53.201.206] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAvUI-00HKJB-Qm; Thu, 29 Dec 2022 16:10:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org
Subject: remove generic_writepages
Date:   Thu, 29 Dec 2022 06:10:25 -1000
Message-Id: <20221229161031.391878-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series removes generic_writepages by open coding the current
functionality in the three remaining callers.  Besides removing some
code the main benefit is that one of the few remaining ->writepage
callers from outside the core page cache code go away.

Note that testing has been a bit limited - ntfs3 does not seem to
be supported by xfstests at all, and xfstests on ocfs2 is a complete
shit show even for the base line.

Diffstat:
 fs/jbd2/commit.c          |   25 ---------------------
 fs/jbd2/journal.c         |    1 
 fs/mpage.c                |    8 ------
 fs/ntfs3/inode.c          |   33 +++++++++++++---------------
 fs/ocfs2/journal.c        |   16 +++++++++++++
 include/linux/jbd2.h      |    2 -
 include/linux/writeback.h |    2 -
 mm/page-writeback.c       |   53 +++++++++++++---------------------------------
 8 files changed, 45 insertions(+), 95 deletions(-)
