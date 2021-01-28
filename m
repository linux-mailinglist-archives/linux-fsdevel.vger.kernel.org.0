Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCE0307034
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhA1HNr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:13:47 -0500
Received: from mail.synology.com ([211.23.38.101]:51592 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231659AbhA1HNU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:13:20 -0500
Received: from localhost.localdomain (unknown [10.17.32.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 8FADCCE781E9;
        Thu, 28 Jan 2021 15:12:37 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1611817957; bh=R4KeaYF2/mSonW5sbKKW6KXiw+UWGiwQrlYs1JRLISs=;
        h=From:To:Cc:Subject:Date;
        b=OpBjaZP5D0xajNTTvjPnkOrwKZGK6irL1R6sq9P/YW/4+Zl+x9rHYI5dw/cWe3xRi
         Xq/UMr0bMWUt3AZyAT3sZKsC4czZJqGOvmD/1PN52JArJ3bwGyg7e49GvBlCdYfTrR
         VWwVwaSWbQBvv7xI36mdoVJwt7IbtsRYGOHSlas4=
From:   bingjingc <bingjingc@synology.com>
To:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        bingjingc@synology.com, robbieko@synology.com, willy@infradead.org,
        rdunlap@infradead.org
Subject: [PATCH v2 0/3] handle large user and group ID for isofs and udf
Date:   Thu, 28 Jan 2021 15:12:27 +0800
Message-Id: <1611817947-2839-1-git-send-email-bingjingc@synology.com>
X-Mailer: git-send-email 2.7.4
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

The uid/gid (unsigned int) of a domain user may be larger than INT_MAX.
The parse_options of isofs and udf will return 0, and mount will fail
with -EINVAL. These patches try to handle large user and group ID.

BingJing Chang (3):
  parser: add unsigned int parser
  isofs: handle large user and group ID
  udf: handle large user and group ID

 fs/isofs/inode.c       |  9 +++++----
 fs/udf/super.c         |  9 +++++----
 include/linux/parser.h |  1 +
 lib/parser.c           | 44 +++++++++++++++++++++++++++++++++-----------
 4 files changed, 44 insertions(+), 19 deletions(-)

-- 
2.7.4

