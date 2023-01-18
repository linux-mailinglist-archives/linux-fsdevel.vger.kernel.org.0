Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1536724F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 18:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjARRbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 12:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjARRbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:31:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCA54B189
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 09:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IB6WV4RAFpXXvsO5sBFMk+O+geVt8PsPN31oUBOFl9k=; b=cy9FW+bOa13ByFBuCfAvfL/v8q
        NS1mxTNJf/T38OgWLc5a8VnouHuTDQJBbc1BjHuGyBh2TFkGfdKHzIBE3MYwEprvh5abAENudfpk+
        E8K51u3tZUT4jO3uZ91Mf8R/wDuKuQ9C7fQJk/JZX6ai8CL5vdB2/Dovn5I1GRxjLrJSeTI40pmUW
        uQRxpGUFJpXlOg5RiOfIfE63/QT1tFRff7ydAT4rtsxb7OiOFB3p45G63u2OxKrVHhGF7qo3VinQi
        iBQR5lg6roGhzoccKYSrPZ+8N8Dn2JdXK4CLioeITx5MA1iOZE31iVLb5P4fUf7QfXtDzMcda0SN2
        smzE/r5A==;
Received: from [2001:4bb8:19a:2039:cce7:a1cd:f61c:a80d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pICGc-00224b-6w; Wed, 18 Jan 2023 17:30:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: remove most callers of write_one_page v3
Date:   Wed, 18 Jan 2023 18:30:20 +0100
Message-Id: <20230118173027.294869-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series removes most users of the write_one_page API.  These helpers
internally call ->writepage which we are gradually removing from the
kernel.

Changes since v2:
 - more minix error handling fixes

Changes since v1:
 - drop the btrfs changes (queue up in the btrfs tree)
 - drop the finaly move to jfs (can't be done without the btrfs patches)
 - fix the existing minix code to properly propagate errors

Diffstat:
 minix/dir.c          |   62 +++++++++++++++++++++++++++------------------------
 minix/minix.h        |    3 +-
 minix/namei.c        |   27 ++++++++++++----------
 ocfs2/refcounttree.c |    9 ++++---
 sysv/dir.c           |   30 +++++++++++++++---------
 ufs/dir.c            |   29 +++++++++++++++--------
 6 files changed, 94 insertions(+), 66 deletions(-)
