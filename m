Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F068966B972
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 09:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjAPIzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 03:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjAPIzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:55:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0701C13D5A
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 00:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0UWsapgUoOVMvQv6PjY0zlY78zJSlkYkDKlwFKIolPQ=; b=Z0KodtN0L42bsRBsgpO4T6vPhi
        9Qx683mxnIqYbI262J9wRoLkKaSTPg9pQIhtRcRPLNXC/3meGfI6O9GJqhfXv9biPdt4AVWt9sJe2
        v9OE6X/VsY250d/Zi1PG7wSXEcjpFTCxnNdsKv8vMWZkLsiGyl/WqUPmU0VVdhRayKyheHCFzDi84
        n+YiUlINRP5lV4XsxJLsexGt9ar3bM667lUhuuJwwbXdcryZzR3o/3ECHrkLJPdfM7hu1IXA1+CH2
        PK8WsVneScALkDnI6kOZv68rPwZzEgWR/6Vz7gLNJ1abFxHqrx32+Lyb37qWfTiTExam6aSxYNX5j
        f8ZzPNIw==;
Received: from [2001:4bb8:19a:2039:c63c:c37c:1cda:3fb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHLH3-009Ee2-BN; Mon, 16 Jan 2023 08:55:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: remove most callers of write_one_page
Date:   Mon, 16 Jan 2023 09:55:17 +0100
Message-Id: <20230116085523.2343176-1-hch@lst.de>
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

Changes since v1:
 - drop the btrfs changes (queue up in the btrfs tree)
 - drop the finaly move to jfs (can't be done without the btrfs patches)
 - fix the existing minix code to properly propagate errors

Diffstat:
 minix/dir.c          |   67 ++++++++++++++++++++++++++++++---------------------
 minix/minix.h        |    3 +-
 minix/namei.c        |    8 +++---
 ocfs2/refcounttree.c |    9 +++---
 sysv/dir.c           |   30 ++++++++++++++--------
 ufs/dir.c            |   29 ++++++++++++++--------
 6 files changed, 90 insertions(+), 56 deletions(-)
