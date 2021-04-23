Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2AE369A6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 20:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhDWSx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 14:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWSx1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:53:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3503B6124B;
        Fri, 23 Apr 2021 18:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619203969;
        bh=ZP+B9swvvm4OM0Bsewe91DM7Jm2oEwdNMnbQCozRG/0=;
        h=From:To:Cc:Subject:Date:From;
        b=hWRKTvxmXxSylgeracfP+DjhZT+WrigFh0feobRz1FTIhQTULir0SpQRPoAAlNP9I
         28Gl265f8baiWVnrdc+LBBMwCQngHe3yXb1TXLRvkdItgtHO15gHY+RJtIyHYvFyWT
         p4bg7o/sEnBlbDMis2RfFfBU6NtK0fiKg3Om6zNu4tsaewZ1zv/OC4U1JX929I7i48
         yXl2gML2DVQK/X2uLEDRs3oWWnveIIt/PIC5wppMG4GRIvgA1HuG8kDmA5HPEWBLjD
         kyLXGnCiK2Nw4yDCVlBPVQqZMG0pYbsSVvkDBBCxGYaBjediXOariSTZDoIuCsKxhP
         aKmGukLctlheA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, xiublu@redhat.com, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        willy@infradead.org, lhenriques@suse.de
Subject: [PATCH] ceph: clamp length of a read to CEPH_MSG_MAX_DATA_LEN
Date:   Fri, 23 Apr 2021 14:52:48 -0400
Message-Id: <20210423185248.198750-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's a hard limit on how large a read we can do from the OSD, defined
as CEPH_MSG_MAX_DATA_LEN (currently, 64M). It's possible to create a
file that is backed by larger objects than that (and indeed, xfstest
ceph/001 does just that).

Ensure we clamp the final length of a read to CEPH_MSG_MAX_DATA_LEN.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I'm likely going to fold this patch into the one that introduces
ceph_netfs_issue_op, so we don't have a regression in the series.

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 9939100f9f9d..ba459b15604d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -212,7 +212,7 @@ static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
 	/* Truncate the extent at the end of the current block */
 	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
 				      &objno, &objoff, &xlen);
-	subreq->len = xlen;
+	subreq->len = min(xlen, (u32)CEPH_MSG_MAX_DATA_LEN);
 	return true;
 }
 
-- 
2.31.1

