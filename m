Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC41F70FBBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 18:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjEXQfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 12:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEXQfH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 12:35:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E06E7;
        Wed, 24 May 2023 09:35:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 12AB4219B3;
        Wed, 24 May 2023 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684946105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Un5QTjftH9dU+V3I75wkntprxt44198mJ0mxj5LY1F4=;
        b=NzKoCE7pFgM8m61Eg2c1UZyAoxaQvU3JNYHAwKLp+JBiRpfR3G5QFrfQXcbJ5AdjqV8XTg
        qzNlEdAduRnLOe55mRKC3zM3nQyRJ6kbSUthMpZZHXvmkY2Bo170XAVeIRbQAOGy6W5anM
        uuEb+IKgJIElS7mRh7LjENXusMp/Il8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684946105;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Un5QTjftH9dU+V3I75wkntprxt44198mJ0mxj5LY1F4=;
        b=+WalUnwpayJnChGvTi5UKB5EVBifyu1ulwWMiaNudtQgcJnaeKW8YzjjM+HOQJdc+iriz4
        VT4dTzLMeotCMcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 056D213425;
        Wed, 24 May 2023 16:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yRBHAbk8bmSSZQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 24 May 2023 16:35:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 98CDFA075C; Wed, 24 May 2023 18:35:04 +0200 (CEST)
Date:   Wed, 24 May 2023 18:35:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>,
        'David Laight <David.Laight@ACULAB.COM>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Locking for RENAME_EXCHANGE
Message-ID: <20230524163504.lugqgz2ibe5vdom2@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

This is again about the problem with directory renames I've already
reported in [1]. To quickly sum it up some filesystems (so far we know at
least about xfs, ext4, udf, reiserfs) need to lock the directory when it is
being renamed into another directory. This is because we need to update the
parent pointer in the directory in that case and if that races with other
operation on the directory, bad things can happen.

So far we've done the locking in the filesystem code but recently Darrick
pointed out [2] that we've missed the RENAME_EXCHANGE case in our ext4 fix.
That one is particularly nasty because RENAME_EXCHANGE can arbitrarily mix
regular files and directories. Couple nasty arising cases:

1) We need to additionally lock two exchanged directories. Suppose a
situation like:

mkdir P; mkdir P/A; mkdir P/B; touch P/B/F

CPU1						CPU2
renameat2("P/A", "P/B", RENAME_EXCHANGE);	renameat2("P/B/F", "P/A", 0);

Both operations need to lock A and B directories which are unrelated in the
tree. This means we must establish stable lock ordering on directory locks
even for the case when they are not in ancestor relationship.

2) We may need to lock a directory and a non-directory and they can be in
parent-child relationship when hardlinks are involved:

mkdir A; mkdir B; touch A/F; ln A/F B/F
renameat2("A/F", "B");

And this is really nasty because we don't have a way to find out whether
"A/F" and "B" are in any relationship - in particular whether B happens to
be another parent of A/F or not.

What I've decided to do is to make sure we always lock directory first in
this mixed case and that *should* avoid all the deadlocks but I'm spelling
this out here just in case people can think of some even more wicked case
before I'll send patches.

Also I wanted to ask (Miklos in particular as RENAME_EXCHANGE author): Why
do we lock non-directories in RENAME_EXCHANGE case? If we didn't have to do
that things would be somewhat simpler...

								Honza

[1] https://lore.kernel.org/all/20230117123735.un7wbamlbdihninm@quack3
[2] https://lore.kernel.org/all/20230517045836.GA11594@frogsfrogsfrogs

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
