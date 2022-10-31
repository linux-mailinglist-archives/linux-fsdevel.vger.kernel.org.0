Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ECE613C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiJaRu4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 13:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJaRuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:50:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A360632F;
        Mon, 31 Oct 2022 10:50:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9E2C81F45B;
        Mon, 31 Oct 2022 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667238651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fGaXAxz7CkwLQu/39IaO5T1EcfCXLRmGolaSbwQbtTI=;
        b=NvwlYs4xa/YUsKy+ffJtq9E/5zltj04v6GSbXqmET3FPakxT1u/YkIHNJ9pa0IEG2Rc+sg
        jAJoT4GIRFHHyKOu8JVIOM/TeQwfFmjx0Lw9DGw5d/BPUC8wTycfzwA3HdfknxqAWzfnGR
        2NuZXXs6wY/xrvZHKD0v52UXrhT7do8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667238651;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fGaXAxz7CkwLQu/39IaO5T1EcfCXLRmGolaSbwQbtTI=;
        b=SI+64C3q91ppKQfwnJXTA5Dp4vET8w57dZyf5ybaOzTLV7u4xm4f9cVvuz2CW+G9KvHUnu
        ZzXT4uZ9AGCfxhBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F61E13AAD;
        Mon, 31 Oct 2022 17:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EOr2IvsKYGN0YgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 31 Oct 2022 17:50:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CCC68A070B; Mon, 31 Oct 2022 18:50:50 +0100 (CET)
Date:   Mon, 31 Oct 2022 18:50:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+06cc05ddc896f12b7ec5@syzkaller.appspotmail.com>
Cc:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        ntfs3@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [syzbot] kernel BUG in dnotify_free_mark
Message-ID: <20221031175050.xmhub66b6d4dvpcb@quack3>
References: <0000000000008b529305ec20dacc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008b529305ec20dacc@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

[added some CCs to gather more ideas]

On Fri 28-10-22 16:45:33, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    247f34f7b803 Linux 6.1-rc2
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=157f594a880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
> dashboard link: https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15585936880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ec85ba880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a5f39164dea4/disk-247f34f7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8d1b92f5a01f/vmlinux-247f34f7.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/1a4d2943796c/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+06cc05ddc896f12b7ec5@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at fs/notify/dnotify/dnotify.c:136!

OK, I've tracked this down to the problem in ntfs3 driver or maybe more
exactly in bad inode handling. What the reproducer does is that it mounts
ntfs3 image, places dnotify mark on filesystem's /, then accesses something
which finds that / is corrupted.  This calls ntfs_bad_inode() which calls
make_bad_inode() which sets inode->i_mode to S_IFREG. So when the file
descriptor is closed, dnotify doesn't get properly shutdown because it
works only on directories. Now calling make_bad_inode() on live inode is
problematic because it can change inode type (e.g. from directory to
regular file) and that tends to confuse things - dnotify in this case.

Now it is easy to blame filesystem driver for calling make_bad_inode() on
live inode but given it seems to be relatively widespread maybe
make_bad_inode() should be more careful not to screw VFS? What do other
people think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
