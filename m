Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401921A7238
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 06:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405041AbgDNECD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 00:02:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:28534 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgDNEAq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:00:46 -0400
IronPort-SDR: ArIqqU4UwnUEfs+D7gGtqAo/3RiSGuaf4RddB1a9ZiMMvkoGA3IXAAdz9QqkanDO+MoydGHqs9
 7NpqE3YF1wbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:46 -0700
IronPort-SDR: 3l/OIIHFT9+UJIHE/5rewB+qP+VXE3Bq53SDzxfibKMzFZVQELzhbwmSjAZVmAF/RTu/G9Qpgy
 CrLHCUnu0cAw==
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="298588252"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:45 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 2/8] fs/ext4: Disallow verity if inode is DAX
Date:   Mon, 13 Apr 2020 21:00:24 -0700
Message-Id: <20200414040030.1802884-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414040030.1802884-1-ira.weiny@intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Verity and DAX are incompatible.  Changing the DAX mode due to a verity
flag change is wrong without a corresponding address_space_operations
update.

Make the 2 options mutually exclusive by returning an error if DAX was
set first.

(Setting DAX is already disabled if Verity is set first.)

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/ext4/verity.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index dc5ec724d889..ce3f9a198d3b 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -113,6 +113,9 @@ static int ext4_begin_enable_verity(struct file *filp)
 	handle_t *handle;
 	int err;
 
+	if (WARN_ON_ONCE(IS_DAX(inode)))
+		return -EINVAL;
+
 	if (ext4_verity_in_progress(inode))
 		return -EBUSY;
 
-- 
2.25.1

