Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F977471F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjGDM5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGDM5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:57:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BF5E7E;
        Tue,  4 Jul 2023 05:57:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 909F221F5B;
        Tue,  4 Jul 2023 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688475423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8Frnr5bafH2W6/hFkNEv3X1Ko9j8KIcqLuflxjlgiKY=;
        b=3HqBkYgtXgiff3jm7bA3mRSvoptszTVy2K3i0SyU/z7KJhSgo2YTMdkZPEwQX92CfxQYSz
        r98WAi+SoxoUrSMjF0OaOWHu+hSvTf4pVfd+T0DgHXHdMdIBoqqBkjtn2YdjvWLlrv9kIX
        s9+JUG0z5Uwo+fKdmHfEC15iR3XyHGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688475423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8Frnr5bafH2W6/hFkNEv3X1Ko9j8KIcqLuflxjlgiKY=;
        b=1PZBPW43Bvd9QJZe5f421OZ668cCEGgX2lB2rNhJoKG2gJP2riVshedX4A0B0+HL592JAx
        j0hPkvrKw21T/hBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BBEF139ED;
        Tue,  4 Jul 2023 12:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0FuxHR8XpGRBQwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:57:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DAF6CA0722; Tue,  4 Jul 2023 14:57:02 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>,
        <linux-xfs@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH RFC 0/6 v2] block: Add config option to not allow writing to mounted devices
Date:   Tue,  4 Jul 2023 14:56:48 +0200
Message-Id: <20230704122727.17096-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1798; i=jack@suse.cz; h=from:subject:message-id; bh=KUi4tNTbTT+xwpWlH09l6o2cJZWimnXu/7ZM2ytMZNc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpBcQkhtjK9cI7uI0V9xuPGxhXN5zd6nnkPNpwvoN JS2eJ6SJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQXEAAKCRCcnaoHP2RA2WB9B/ 9e564CcjLDZSWB1fDdxrNRXktQLy35neJ2nuyLhCR6ipiv4hiZA9r4l/ppyyyB4VJZdlYnWXQyfg4b HOsG9uvdW0Kh1an36QDsEectiVBbytR0M6/9FiefGkUbhpv+qHLdUrA72vSn1wyszG1MeubyjM09iv cA3HAk9SmH54tiMT96IFxIrezBEGWEhr2ZeOmTt110NLHyii59+8uLvrzQ4q+jezJBtpXJRh2LnyNJ /CPIUUnU0zMWRy1ZDdaWwakbzcEb5HqdXhb0TCZ+D+ons39KuwOb2CFDOByFahe3M8hr1mg2coZSIP +mxnBlEKFu7jcYZ/1OF4YCfekQ4qoT
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

Hello!

This is second version of the patches to add config option to not allow writing
to mounted block devices. For motivation why this is interesting see patch 1/6.
I've been testing the patches more extensively this time and I've found couple
of things that get broken by disallowing writes to mounted block devices:
1) Bind mounts get broken because get_tree_bdev() / mount_bdev() first try to
   claim the bdev before searching whether it is already mounted. Patch 6
   reworks the mount code to avoid this problem.
2) btrfs mounting is likely having the same problem as 1). It should be fixable
   AFAICS but for now I've left it alone until we settle on the rest of the
   series.
3) "mount -o loop" gets broken because util-linux keeps the loop device open
   read-write when attempting to mount it. Hopefully fixable within util-linux.
4) resize2fs online resizing gets broken because it tries to open the block
   device read-write only to call resizing ioctl. Trivial to fix within
   e2fsprogs.

Likely there will be other breakage I didn't find yet but overall the breakage
looks minor enough that the option might be useful. Definitely good enough
for syzbot fuzzing and likely good enough for hardening of systems with
more tightened security.

This patch set is based on the patches making blkdev_get_by_*() return
bdev_handle [1].

Changes since v1:
* Added kernel cmdline argument to toggle whether writing to mounted block
  devices is allowed or not
* Fixed handling of partitions
* Limit write blocking only to devices open with explicit BLK_OPEN_BLOCK_WRITES
  flag

								Honza

[1] https://lore.kernel.org/all/20230629165206.383-1-jack@suse.cz

Previous versions:
v1: https://lore.kernel.org/all/20230612161614.10302-1-jack@suse.cz
