Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6801D3084B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 05:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhA2Exj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 23:53:39 -0500
Received: from mail.synology.com ([211.23.38.101]:44290 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231734AbhA2Ew7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 23:52:59 -0500
Received: from localhost.localdomain (unknown [10.17.36.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id A96FDCE781E9;
        Fri, 29 Jan 2021 12:52:15 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1611895935; bh=jUI4TSnNm0L8h5II2hAHJvIBRgJU3O5PBwhenxlur8k=;
        h=From:To:Cc:Subject:Date;
        b=AnQwzm+jxfz1BcuRlsqmmdDrnY5LOTKc7oxdv/E4SHpdH586VF2XfkL6lIkS/ferP
         yuvQZg5TZyk2XJbMhMa6+e/zKB6nOYajRJyu21s0M13YrBgnqwLihpkd2+QqQ+Qs+Y
         vXhhxTjYDRIzTjJr25kK7tC7U69CsvQjluQMNaBU=
From:   bingjingc <bingjingc@synology.com>
To:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        bingjingc@synology.com, robbieko@synology.com, willy@infradead.org,
        rdunlap@infradead.org, miklos@szeredi.hu
Subject: [PATCH v3 0/3] handle large user and group ID for isofs and udf
Date:   Fri, 29 Jan 2021 12:51:48 +0800
Message-Id: <20210129045148.10155-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 lib/parser.c           | 22 ++++++++++++++++++++++
 4 files changed, 33 insertions(+), 8 deletions(-)

-- 
2.7.4

