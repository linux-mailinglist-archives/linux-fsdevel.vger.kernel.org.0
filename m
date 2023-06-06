Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90C872456F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 16:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbjFFOOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjFFOOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:14:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0798A6;
        Tue,  6 Jun 2023 07:14:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 66A381FD76;
        Tue,  6 Jun 2023 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686060844;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v+fE+p+3UhAy5b8jQdixuYCW4EqmLwbeYafiuZSgPwY=;
        b=uO6pZ+e/J4mikdtwr14P7262oxXyqPoq5g/O7G0Gb4DzfEErgmOol8LfHud1VepoR3dzkX
        9OScMH8kPAx4PhVVL6n2a4f7UFCmz97IEhoVE32SfGWIZ/DUtpDLgSP233QbljWQ2dbcql
        eX5nNeynTJ6PByiVy+1xu2wa1GCkvMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686060844;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v+fE+p+3UhAy5b8jQdixuYCW4EqmLwbeYafiuZSgPwY=;
        b=iav13bkcUTvxafxR826yHTm8Ff1lXAPcDFAu5jW9Hb4MBBrSlwCsNAGqTq/t8dU7XjD4Mg
        PFcuHFW9RDrkhqBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33EA513519;
        Tue,  6 Jun 2023 14:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N/voCyw/f2TjdQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Jun 2023 14:14:04 +0000
Date:   Tue, 6 Jun 2023 16:07:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+5e466383663438b99b44@syzkaller.appspotmail.com>
Cc:     chris@chrisdown.name, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_exclop_balance (2)
Message-ID: <20230606140749.GH25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000725cab05f55f1bb0@google.com>
 <000000000000e7582c05fafc8901@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e7582c05fafc8901@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 06:43:55PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    7163a2111f6c Merge tag 'acpi-6.4-rc1-3' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=175bb84c280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
> dashboard link: https://syzkaller.appspot.com/bug?extid=5e466383663438b99b44
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12048338280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ff7314280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/01051811f2fe/disk-7163a211.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a26c68e4c8a6/vmlinux-7163a211.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/17380fb8dad4/bzImage-7163a211.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/b30a249e8609/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5e466383663438b99b44@syzkaller.appspotmail.com

#syz fix: btrfs: fix assertion of exclop condition when starting balance

> assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED, in fs/btrfs/ioctl.c:463

Likely the same problem as https://syzkaller.appspot.com/bug?extid=afdee14f9fd3d20448e7
