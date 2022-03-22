Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E684E409C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiCVOQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbiCVOPu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F0C88B16;
        Tue, 22 Mar 2022 07:14:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57D9361617;
        Tue, 22 Mar 2022 14:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACACC340EE;
        Tue, 22 Mar 2022 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958440;
        bh=/gxeEbNRrhQUUKat+3pmAKrCE5MwF5L1g1xQKvPeLuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MukAyGxPuQ9w/fFYYg1FiprSCI4ckndR1qX/Hjika5sBjMMrWImc6LxFp6q7RoXxV
         FJTOakYzd8cACm/Y8FVHuEhzwbcUWG7TEeKAMEBdSUhQx86c8T4JHoEzj9x97dBT+q
         8CoEQaQotc9OepA1AlIowb3oky9atZDhiOhuMChdwNnpy9niCGfaTp0501ytonAR/z
         Gp3tPE/10rjxE2D2RlgWnOCjPZhqpz345gvdKazwm6znFqF3nuVfxx7E2PjPi4jBdJ
         JwhfXmty6BFFd8xlN04cGicnt/ffYU8WQdrbMCFWmWUDrgIvtw0iJvsAWTeeha9/I+
         /YVuxnDeGudJA==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 44/51] ceph: don't use special DIO path for encrypted inodes
Date:   Tue, 22 Mar 2022 10:13:09 -0400
Message-Id: <20220322141316.41325-45-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eventually I want to merge the synchronous and direct read codepaths,
possibly via new netfs infrastructure. For now, the direct path is not
crypto-enabled, so use the sync read/write paths instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index ba17288b1db3..5a637158f9c5 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1705,7 +1705,9 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		     ceph_cap_string(got));
 
 		if (ci->i_inline_version == CEPH_INLINE_NONE) {
-			if (!retry_op && (iocb->ki_flags & IOCB_DIRECT)) {
+			if (!retry_op &&
+			    (iocb->ki_flags & IOCB_DIRECT) &&
+			    !IS_ENCRYPTED(inode)) {
 				ret = ceph_direct_read_write(iocb, to,
 							     NULL, NULL);
 				if (ret >= 0 && ret < len)
@@ -1931,7 +1933,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 		/* we might need to revert back to that point */
 		data = *from;
-		if (iocb->ki_flags & IOCB_DIRECT)
+		if ((iocb->ki_flags & IOCB_DIRECT) && !IS_ENCRYPTED(inode))
 			written = ceph_direct_read_write(iocb, &data, snapc,
 							 &prealloc_cf);
 		else
-- 
2.35.1

