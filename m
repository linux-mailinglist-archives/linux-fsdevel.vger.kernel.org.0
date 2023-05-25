Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD77109C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 12:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbjEYKQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 06:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbjEYKQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 06:16:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1207710B;
        Thu, 25 May 2023 03:16:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1845B21C08;
        Thu, 25 May 2023 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685009785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AasYIWFI1S7OWlc46V78pNTXYji7OAdfudjyszTriMw=;
        b=mWH844KEiJBA1aZq1NytWIyeLer3NOjjdeY8DR7hO07w3I+IHXnxl+SrS16nEkQV+HZNLb
        uvQESm3OCthfc02m80uTeMbwRov1icKXWebSgS+qwAJvsf1tB3oxK9S69SMJo7ZzuRL5bx
        4aPqc+JZNp4XQyLlMJP9J9WILa14P1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685009785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AasYIWFI1S7OWlc46V78pNTXYji7OAdfudjyszTriMw=;
        b=JAspCTzdhb5BLxVjzC9E1jjnrPIVPBwaqQKmWOxQR3nZa5P9WH3EGZHOOPI7Qst34zB4uY
        Ma/tFSPgjMV0p8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0688813A88;
        Thu, 25 May 2023 10:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WhMeAXk1b2RJdgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 10:16:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 52BCDA075C; Thu, 25 May 2023 12:16:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        <linux-xfs@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/6] fs: Fix directory corruption when moving directories
Date:   Thu, 25 May 2023 12:16:06 +0200
Message-Id: <20230525100654.15069-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=jack@suse.cz; h=from:subject:message-id; bh=+SElWakzHXlPrUsPVn2OpQA3AfdfztYzyPNqGfZYghU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkbzVdxe0FvekPZapZQzM3DTu4EGJWLISXiQyJth5w rhLVGYaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZG81XQAKCRCcnaoHP2RA2ZJ2CA Czq+c06ImKsEJ7Ml6bBcSTNMoqJbKxDWot8ruFWwB69bocSyVn+Et6BD1EWfID+4Su3doANPMimhj5 Cbct+zb2X5MtEVuocqaqTMhapWmj3EEME6oTzvgw7/yrhpeQygsZ7ZP3LvF/cw52EBdg+nLDfjw+4s GHEpw6ZBvokOhfJtpij1FRZIjg621Vq9ryBBY96RL72ubNtjzhSX5CtNTzegajAT9PP9ZR4pk0hI4o /NRB9XJ9gZCT4beVEfp8FVQicy9SeVPvR+Iik7L2lVtqV4WXcPl412g0Hfc5hiZ3yqc9ZHRY9ri3HZ MA/0r7lOkSYS3I/+tUbULxHeoSaINx
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this patch set fixes a problem with cross directory renames originally reported
in [1]. To quickly sum it up some filesystems (so far we know at least about
ext4, udf, f2fs, ocfs2, likely also reiserfs, gfs2 and others) need to lock the
directory when it is being renamed into another directory. This is because we
need to update the parent pointer in the directory in that case and if that
races with other operation on the directory (in particular a conversion from
one directory format into another), bad things can happen.

So far we've done the locking in the filesystem code but recently Darrick
pointed out [2] that we've missed the RENAME_EXCHANGE case in our ext4 fix.
That one is particularly nasty because RENAME_EXCHANGE can arbitrarily mix
regular files and directories and proper lock ordering is not achievable in the
filesystems alone.

This patch set adds locking into vfs_rename() so that not only parent
directories but also moved inodes (regardless whether they are directories or
not) are locked when calling into the filesystem.

								Honza

[1] https://lore.kernel.org/all/20230117123735.un7wbamlbdihninm@quack3
[2] https://lore.kernel.org/all/20230517045836.GA11594@frogsfrogsfrogs
