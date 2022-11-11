Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CEC625B06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 14:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiKKNMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 08:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiKKNL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:11:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F16B38;
        Fri, 11 Nov 2022 05:11:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E188B8260B;
        Fri, 11 Nov 2022 13:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5C2C433D6;
        Fri, 11 Nov 2022 13:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668172316;
        bh=CHrjjH0ATPTGyysAWUcGpQRDKql67WVacSe/cGeGyRw=;
        h=From:To:Cc:Subject:Date:From;
        b=nj+y7dBbEqEHcaNlbrvEYnhkq7D3ZK7DHVna7z2NO/NKeYZMI6eTrOXlpy4tQnct9
         or77p928FH58kqlKcvZYFymWiIL5Jjw/p2HZ1rXRe0WhucZXbS8mbcBBWoITdAxux+
         VUSMJjOpuxlPzSN6JLGW1hXiNDxNmJAlT7vDiMf+PIa/MpOX9smyRg8PXPNn6IPlfW
         cMA2mcS34Sf1fXPQcdcEHpBg9SmOF84dgad/bHO22QeUeixOzR/m6dCYRA3MfSK4Sd
         3XmNTxxQP0crDX/3ztVIHEX2P6pMDDetAYDLLKVe7FdncrL41qKL7o5jq129Fdf0Rf
         9rfqbHkGIoy2w==
From:   Jeff Layton <jlayton@kernel.org>
To:     linkinjeon@kernel.org, sfrench@samba.org
Cc:     senozhatsky@chromium.org, tom@talpey.com,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: [PATCH] ksmbd: use F_SETLK when unlocking a file
Date:   Fri, 11 Nov 2022 08:11:53 -0500
Message-Id: <20221111131153.27075-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ksmbd seems to be trying to use a cmd value of 0 when unlocking a file.
That activity requires a type of F_UNLCK with a cmd of F_SETLK. For
local POSIX locking, it doesn't matter much since vfs_lock_file ignores
@cmd, but filesystems that define their own ->lock operation expect to
see it set sanely.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index b2fc85d440d0..f2bcd2a5fb7f 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6751,7 +6751,7 @@ static int smb2_set_flock_flags(struct file_lock *flock, int flags)
 	case SMB2_LOCKFLAG_UNLOCK:
 		ksmbd_debug(SMB, "received unlock request\n");
 		flock->fl_type = F_UNLCK;
-		cmd = 0;
+		cmd = F_SETLK;
 		break;
 	}
 
@@ -7129,7 +7129,7 @@ int smb2_lock(struct ksmbd_work *work)
 		rlock->fl_start = smb_lock->start;
 		rlock->fl_end = smb_lock->end;
 
-		rc = vfs_lock_file(filp, 0, rlock, NULL);
+		rc = vfs_lock_file(filp, F_SETLK, rlock, NULL);
 		if (rc)
 			pr_err("rollback unlock fail : %d\n", rc);
 
-- 
2.38.1

