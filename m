Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8FD719A55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjFAK6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 06:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjFAK6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:58:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C20E124;
        Thu,  1 Jun 2023 03:58:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AEAEA1FDA5;
        Thu,  1 Jun 2023 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685617110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0DzWy5kExCz1dSPChCQvEKrJzhHmLyM85G+sXWlLMTs=;
        b=O8fbyQ3Qfgilzk4ztIxRWXNswx8WxStxJH7Ro86uTmTrniGGwYpyAtacV4AvbfMtchEnFK
        7C2xejbwsT+PBZ5P/2MoBAv/Ola39ZDfmsLATy8NeEBSBOCiNGCMX1aLx1s3ZCRWv4jopL
        N1htniSMG77/DaC1/kH67u4cr6gMfMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685617110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0DzWy5kExCz1dSPChCQvEKrJzhHmLyM85G+sXWlLMTs=;
        b=S3Cqa74WhoF+oaTGeRolNYwpAq9Rx53NMUnTdMaZIRewUzrBJgDeIA2gTYcgh51peH0HaG
        40WThMrSNLK/sbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E13D13A39;
        Thu,  1 Jun 2023 10:58:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BZiUJtZ5eGRxWAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Jun 2023 10:58:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0DEBBA0754; Thu,  1 Jun 2023 12:58:30 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 0/6] fs: Fix directory corruption when moving directories
Date:   Thu,  1 Jun 2023 12:58:20 +0200
Message-Id: <20230601104525.27897-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583; i=jack@suse.cz; h=from:subject:message-id; bh=A4NuJIA5fRnO81BQCFQ+qouMN01g1n5f8YwBgH7IRjw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkeHnEqJRcmewHp/J45UlUgDFD/bRSALsTL4CM7NWS Eh9nkW2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZHh5xAAKCRCcnaoHP2RA2ZmLB/ 9x4VWtvxhWmDLhsrxitQaHFrtDSoj/0K7wjjyc4b4KJ13VG8n+u2jMsfjFDkVPFhCukC4iWnvbAGvZ KsCP9RARf4MI54Qcp5Rnn0UjxjqndVS8ykU4hryIqsuW/gUEw90SSLkVLSwqvdHJSkUvIgupPMjDfy jN+hRrVpZhEl4kqu6PEnbHPMNUVWZ2HP3BVViT3MZYqJeiV9Fb2+o5twQ7wTibwcsLjTGiLIbrJuzH wpLohc909nVMtxB3h7pBGdTwVQKu8UUPQqEdwszBOnXs/PaCi/d21gfKNr5TneJMd677HOz8cZwlkM LfbExF6oneWJCISfoAZ815x3/NufMs
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes since v1:
* Made sure lock_two_inodes() uses subclass1 for the obtained lock in case
  there is only one inode locked
* Fixes unlocked_two_nondirectories() to properly unlock inodes even if
  directories are accidentally passed in.

								Honza

[1] https://lore.kernel.org/all/20230117123735.un7wbamlbdihninm@quack3
[2] https://lore.kernel.org/all/20230517045836.GA11594@frogsfrogsfrogs

Previous versions:
Link: http://lore.kernel.org/r/20230525100654.15069-1-jack@suse.cz # v1
