Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D7E6F600F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 22:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjECU2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 16:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjECU2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 16:28:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DAF5FE7
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 13:28:46 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 343KSV7c003833
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 16:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683145714; bh=aEB1wzggINOG9//I4Uz8LAAk2hMw0VvHmmcvM4Bk38I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=X2Mrz4OQHFKa7EXgs5ypd3VBJwNnHk9AFXpo7fRo61TLHdjsqktMFa3MvM8cCCtQb
         Zto7RbNvHZp42GD19xhI3yLJn0XoliUS7wP+3neffXfbm69y4xJEoisLs8kADwF7WN
         6i8omh1/nZxz1+4SoxoJ1mDbZ1xaz5UARgRLrv2x4ZwcTMGzLp3N/Lg5JbUGplNeH2
         dACp08D9C9WA1EKy3/3Zi8IOKXGLJHXYNYsiK3TbzX9kmICXbWxSlh3MG/08ZST8WU
         bWUwUbkLAyUOlMfrPZ80jOKlvQIVZujox+ZBDJEZ+SniTXQiH8DpEfbSHmWF7akOLm
         AjubzHhw4bLcQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D746D15C02E2; Wed,  3 May 2023 16:28:30 -0400 (EDT)
Date:   Wed, 3 May 2023 16:28:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+6385d7d3065524c5ca6d@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_block_set (2)
Message-ID: <20230503202830.GA695988@mit.edu>
References: <00000000000006a0df05f6667499@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000006a0df05f6667499@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 39f00f05f981..dab33412b858 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6638,6 +6638,14 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	return 0;
 
 restore_opts:
+	if ((sb->s_flags & SB_RDONLY) &&
+	    !(old_sb_flags & SB_RDONLY)) {
+		ext4_warning(sb, "failing rw->ro transition");
+		if (sb_any_quota_suspended(sb)) {
+			ext4_warning(sb, "would resume quotas");
+//			dquot_resume(sb, -1);
+		}
+	}
 	sb->s_flags = old_sb_flags;
 	sbi->s_mount_opt = old_opts.s_mount_opt;
 	sbi->s_mount_opt2 = old_opts.s_mount_opt2;

