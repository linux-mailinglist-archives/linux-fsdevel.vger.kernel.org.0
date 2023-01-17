Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448CC66DDC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 13:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbjAQMhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 07:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbjAQMhj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:37:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D2E252A0;
        Tue, 17 Jan 2023 04:37:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 41F1A37BC6;
        Tue, 17 Jan 2023 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673959057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=D/Gwv1OQXVt03JIY3T875i7foDn1vhu4dyLpEgQk+hk=;
        b=grjCvqvP9dywlcw43DCV5jmq+6yH2pIyVWgZDJu8Pp/FgJgk9BexIQwneUud8ZAhCP1AKB
        35Cz2an/3MSNhfIUlf8FeL3/gT+U/UIgMr3+afb/kRRw0Oqto9eTlKPXFNHupkVYZE93KY
        IrdKnu2eE9NbNKQ+pypAufeU+H4e77E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673959057;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=D/Gwv1OQXVt03JIY3T875i7foDn1vhu4dyLpEgQk+hk=;
        b=V2EkX1GQV8y/mqr9WNiNdzlvQzNM0eiuUbkg/2jwte18RiIvuv0/zS0gNKyvjZ0T4ff9kQ
        9f61xM6dWwTh+ZAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 228361390C;
        Tue, 17 Jan 2023 12:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xs5hCJGWxmMlaAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 17 Jan 2023 12:37:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BCB2DA06B2; Tue, 17 Jan 2023 13:37:35 +0100 (CET)
Date:   Tue, 17 Jan 2023 13:37:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-xfs@vger.kernel.org
Subject: Locking issue with directory renames
Message-ID: <20230117123735.un7wbamlbdihninm@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

I've some across an interesting issue that was spotted by syzbot [1]. The
report is against UDF but AFAICS the problem exists for ext4 as well and
possibly other filesystems. The problem is the following: When we are
renaming directory 'dir' say rename("foo/dir", "bar/") we lock 'foo' and
'bar' but 'dir' is unlocked because the locking done by vfs_rename() is

        if (!is_dir || (flags & RENAME_EXCHANGE))
                lock_two_nondirectories(source, target);
        else if (target)
                inode_lock(target);

However some filesystems (e.g. UDF but ext4 as well, I suspect XFS may be
hurt by this as well because it converts among multiple dir formats) need
to update parent pointer in 'dir' and nothing protects this update against
a race with someone else modifying 'dir'. Now this is mostly harmless
because the parent pointer (".." directory entry) is at the beginning of
the directory and stable however if for example the directory is converted
from packed "in-inode" format to "expanded" format as a result of
concurrent operation on 'dir', the filesystem gets corrupted (or crashes as
in case of UDF).

So we'd need to lock 'source' if it is a directory. Ideally this would
happen in VFS as otherwise I bet a lot of filesystems will get this wrong
so could vfs_rename() lock 'source' if it is a dir as well? Essentially
this would amount to calling lock_two_nondirectories(source, target)
unconditionally but that would become a serious misnomer ;). Al, any
thought?

								Honza

[1] https://lore.kernel.org/all/000000000000261eb005f2191696@google.com

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
