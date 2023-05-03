Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08D26F5D2E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 19:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjECRnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjECRnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 13:43:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4071E4EC9;
        Wed,  3 May 2023 10:42:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC31222B29;
        Wed,  3 May 2023 17:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683135777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vMRb6YixvaXRrTTXEMUc7Ew/vp3Ex6L4GYbhpZg+Cxc=;
        b=qr/k6Nx1QqblgGx3If8I3F7C92ZEMfmQ3uDTtGhVuUjTHG36FYyXNHvlwJVA0VexHAmN/L
        zosA4egvWy3ReOiZYo1HOYnOaKfmt5V8fIGwymyCF7vB/N5tmr5oXrRisp+vtGPzWNK7RJ
        bucE+PID5Z2cvkbWxUYX5LgkxVDAyn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683135777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vMRb6YixvaXRrTTXEMUc7Ew/vp3Ex6L4GYbhpZg+Cxc=;
        b=3N3tm83zW2Xj0CKBMB1xd9Svim/jAW8DeYjn/crMGp+Dzn5i4xqgt+PUKKwUhYRIsoUeeP
        s9uFdPg2SquP6DAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AB9113584;
        Wed,  3 May 2023 17:42:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +kMsEiGdUmRoKwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 17:42:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2F197A0744; Wed,  3 May 2023 19:42:54 +0200 (CEST)
Date:   Wed, 3 May 2023 19:42:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] KCSAN: data-race in __es_find_extent_range /
 __es_find_extent_range (6)
Message-ID: <20230503174254.xbggzuzej6bbugts@quack3>
References: <000000000000d3b33905fa0fd4a6@google.com>
 <CACT4Y+a20C5kUHRKbFB08QsLbdia+ELCOcKibJVY_v+xmjMPow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a20C5kUHRKbFB08QsLbdia+ELCOcKibJVY_v+xmjMPow@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 24-04-23 09:27:00, Dmitry Vyukov wrote:
> On Mon, 24 Apr 2023 at 09:19, syzbot
> <syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    44149752e998 Merge tag 'cgroup-for-6.3-rc6-fixes' of git:/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=100db37bc80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=710057cbb8def08c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4a03518df1e31b537066
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/7bfa303f05cc/disk-44149752.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/4e8ea8730409/vmlinux-44149752.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/e584bce13ba7/bzImage-44149752.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com
> 
> The race is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/extents_status.c?id=44149752e9987a9eac5ad78e6d3a20934b5e018d#n271
> 
> If I am reading this correctly, it can lead to returning a wrong
> extent if tree->cache_es is re-read after the range check.
> I think tree->cache_es read/write should use READ/WRITE_ONCE.

Right. I'll send a fix.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
