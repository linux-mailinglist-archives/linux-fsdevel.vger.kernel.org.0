Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB23193EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 13:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgCZMYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 08:24:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgCZMYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xyyTb0+i+AMch+w5Hz5JqGdUkomd7RsodjoZ9/zMceM=; b=LlyYUlD2f6KjrTQfNDod1JtocW
        qZ0Dt9/J7X3i21JNljBzjWslwtwFOXr+ldiGwT19YdpOE5u9fpD+GDTnQjGVEaDApjlmpMmLi2y88
        DCz2/xrL+SrNFTqwJFgoH+OqRV2NZ/eVd9SzM49ynaMwQ7TJPFkwopGr6nksOzp020f/dYFcckGNI
        tyZ/2Rc8wMN1BeO4575F8wsig3/FsN1N7r4po2mPUou92l0fN6NecsRKhwzdVTwJXfwwhl4uBTbej
        rniV5b4bkw2I2itJvkvEeykc3+/kRt/mWSzjxhFSdlo3LbxAuAruDnx9I5RO2nfb5Idio1Hk2zAUz
        T9HqkSng==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHRYk-0005Ow-5O; Thu, 26 Mar 2020 12:24:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/2] Make PageWriteback use the PageLocked optimisation
Date:   Thu, 26 Mar 2020 05:24:27 -0700
Message-Id: <20200326122429.20710-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

PageWaiters is used by PageWriteback and PageLocked (and no other page
flags), so it makes sense to use the same codepaths that have already been
optimised for PageLocked, even if there's probably no real performance
benefit to be had.

Matthew Wilcox (Oracle) (2):
  mm: Remove definition of clear_bit_unlock_is_negative_byte
  mm: Use clear_bit_unlock_is_negative_byte for PageWriteback

 include/linux/page-flags.h |  6 +++---
 mm/filemap.c               | 42 ++++++--------------------------------
 mm/page-writeback.c        | 37 ++++++++++++++++++---------------
 3 files changed, 29 insertions(+), 56 deletions(-)


base-commit: 5149100c3aebe5e640d6ff68e0b5e5a7eb8638e0
-- 
2.25.1

