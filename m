Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D208A306AFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 03:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhA1CTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 21:19:24 -0500
Received: from mail.synology.com ([211.23.38.101]:45140 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229586AbhA1CTR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:19:17 -0500
Received: from localhost.localdomain (unknown [10.17.32.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 47CBFCE781BB;
        Thu, 28 Jan 2021 10:18:34 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1611800314; bh=QgX9+6FHKz0dcOJG5mIY/ZmH7A6RaT0lXd/ds9DU9Qg=;
        h=From:To:Cc:Subject:Date;
        b=XA2Vbiqtaiwn19Q+DSBytmPZrEly6AGCnmT4OIkbRrvFhZAMjhrDLuv9P9HfL4AM/
         LRKd++FOyz7oJDcVEE6m/Y5p/MbbY8MFN3V84HL+BUKQ6oOFMaqiTCbxeINhF5gfKF
         axpRCDp9Sp/luBdy+l3qu3zeIkCrqxI2ryVeaefc=
From:   bingjingc <bingjingc@synology.com>
To:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        bingjingc@synology.com, robbieko@synology.com
Subject: [PATCH 0/3] handle large user and group ID for isofs and udf
Date:   Thu, 28 Jan 2021 10:17:00 +0800
Message-Id: <1611800220-9481-1-git-send-email-bingjingc@synology.com>
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
  isofs: handle large user and group ID
  udf: handle large user and group ID
  parser: add unsigned int parser

 fs/isofs/inode.c       |  9 +++++----
 fs/udf/super.c         |  9 +++++----
 include/linux/parser.h |  1 +
 lib/parser.c           | 22 ++++++++++++++++++++++
 4 files changed, 33 insertions(+), 8 deletions(-)

-- 
2.7.4

