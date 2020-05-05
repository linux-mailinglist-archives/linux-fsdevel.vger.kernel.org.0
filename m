Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6F1C4AFD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 02:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgEEAUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 20:20:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:23633 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgEEAUU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 20:20:20 -0400
IronPort-SDR: rk00TNmXbCQ9GCvmdKsthmSpSgeQkhh6rmOSFdYwjJdRH/FH2ojBQAEXf6QOSNJMrpUbb0r/nF
 jdTVlG2JQ+3w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 17:20:19 -0700
IronPort-SDR: k1vUVvQaEJMjKfp0O1z1GRkDHRmiJVeN2zx0krf5kg8Gclm9wzZR9p1+B8TOjDxPzIh6L0DJ8r
 feipGiwmSnQg==
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="259517993"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 17:20:18 -0700
From:   ira.weiny@intel.com
To:     mtk.manpages@gmail.com
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-man@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH] man/statx: Add STATX_ATTR_DAX
Date:   Mon,  4 May 2020 17:20:16 -0700
Message-Id: <20200505002016.1085071-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Linux 5.8 is slated to have STATX_ATTR_DAX support.

https://lore.kernel.org/lkml/20200428002142.404144-4-ira.weiny@intel.com/
https://lore.kernel.org/lkml/20200504161352.GA13783@magnolia/

Add the text to the statx man page.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 man2/statx.2 | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/man2/statx.2 b/man2/statx.2
index 2e90f07dbdbc..14c4ab78e7bd 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -468,6 +468,30 @@ The file has fs-verity enabled.
 It cannot be written to, and all reads from it will be verified
 against a cryptographic hash that covers the
 entire file (e.g., via a Merkle tree).
+.TP
+.BR STATX_ATTR_DAX (since Linux 5.8)
+The file is in the DAX (cpu direct access) state.  DAX state attempts to
+minimize software cache effects for both I/O and memory mappings of this file.
+It requires a file system which has been configured to support DAX.
+.PP
+DAX generally assumes all accesses are via cpu load / store instructions which
+can minimize overhead for small accesses, but may adversely affect cpu
+utilization for large transfers.
+.PP
+File I/O is done directly to/from user-space buffers and memory mapped I/O may
+be performed with direct memory mappings that bypass kernel page cache.
+.PP
+While the DAX property tends to result in data being transferred synchronously,
+it does not give the same guarantees of O_SYNC where data and the necessary
+metadata are transferred together.
+.PP
+A DAX file may support being mapped with the MAP_SYNC flag, which enables a
+program to use CPU cache flush instructions to persist CPU store operations
+without an explicit
+.BR fsync(2).
+See
+.BR mmap(2)
+for more information.
 .SH RETURN VALUE
 On success, zero is returned.
 On error, \-1 is returned, and
-- 
2.25.1

