Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B11A6A6C82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 13:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCAMnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 07:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCAMmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:42:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2730D103;
        Wed,  1 Mar 2023 04:42:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A994521A81;
        Wed,  1 Mar 2023 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677674569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lsv1DuXMnRsAXWN1/iMg2zCHw6wIP8mEYOtvYwGdNCU=;
        b=hT6F6gfxlhGLyH4lFvA8/XrwgfMxpIpX7voqeaDOHacYJEQFoqCjdseLrVa9Gh1AIT2AyS
        vv1wLQRR/w0VAdEX/8nt4V7Rvqy6lyJD/Yl3O3M0sUyyaPXsolE5kWTU6UTOrN9tNwUsd3
        HJ0BkFcr+gDBISQkpOShRCC+nEmm2uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677674569;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lsv1DuXMnRsAXWN1/iMg2zCHw6wIP8mEYOtvYwGdNCU=;
        b=oUQI3h05w/jZ2zPFPeJWyGpmk6PwrqMi7r8hpPIT5cgG9ykEsmZ+ts6yEUTNVyFdM1ahd1
        yV5ttFU9eeGODvAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C22613A63;
        Wed,  1 Mar 2023 12:42:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GagLJklI/2PaeAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 12:42:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2877EA06E5; Wed,  1 Mar 2023 13:42:49 +0100 (CET)
Date:   Wed, 1 Mar 2023 13:42:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, jack@suse.com, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] [ext4?] possible deadlock in jbd2_log_wait_commit
Message-ID: <20230301124249.tj7oub3r35q5z3rx@quack3>
References: <00000000000052865105f5c8f2c8@google.com>
 <0000000000003845ba05f5d3e416@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003845ba05f5d3e416@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 01-03-23 02:08:19, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 0813299c586b175d7edb25f56412c54b812d0379
> Author: Jan Kara <jack@suse.cz>
> Date:   Thu Jan 26 11:22:21 2023 +0000
> 
>     ext4: Fix possible corruption when moving a directory
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14845d50c80000
> start commit:   e492250d5252 Merge tag 'pwm/for-6.3-rc1' of git://git.kern..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16845d50c80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12845d50c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d16c39efb5fade84574
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d96208c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176d917f480000
> 
> Reported-by: syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com
> Fixes: 0813299c586b ("ext4: Fix possible corruption when moving a directory")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Drat, yeah, lockdep is actually right. We should not be grabbing i_rwsem
while having transaction started in ext4_rename(). I'm somewhat surprised
we didn't hit this lockdep warning earlier during the testing. So we need
to move the locking earlier in ext4_rename(). I'll send a patch...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
