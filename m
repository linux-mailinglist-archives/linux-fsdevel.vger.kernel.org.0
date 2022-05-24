Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C334353286C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 13:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiEXK7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 06:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiEXK7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 06:59:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFABE8BD01;
        Tue, 24 May 2022 03:59:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8ADB71F8A8;
        Tue, 24 May 2022 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653389952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7NEjm8TbLkASNUN8YDLrp/m7e0j21/9HBactdTlGXXM=;
        b=i1l7yTMRNn9ZxkqZx56APrIUcyUb8nb+r3EMmUiJgfYQUFKaq3NHrU3zaHSbOEYSH2ZyHe
        OnaSzGmsUucBRd/n1YicLUZuFQKrImnwybiFEmeFQ9jzko1cYAn8llxZtYxTmEYpHm45WP
        AnmcJyG+BNc5u0F7EnYPniWbxuFsZzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653389952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7NEjm8TbLkASNUN8YDLrp/m7e0j21/9HBactdTlGXXM=;
        b=LtxHqZKIDDpx4O91CGEWFnrehFUapw8MnfY3Eyik8OLktGF3pHX8Z4BjXhoZpfm/l+rz3X
        21Yc2UDeRmFcqpCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4F5E62C141;
        Tue, 24 May 2022 10:59:12 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F1EBCA0632; Tue, 24 May 2022 12:59:10 +0200 (CEST)
Date:   Tue, 24 May 2022 12:59:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+9c3fb12e9128b6e1d7eb@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>,
        Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [syzbot] INFO: task hung in jbd2_journal_commit_transaction (3)
Message-ID: <20220524105910.ijkcppxzddrfrmop@quack3.lan>
References: <00000000000032992d05d370f75f@google.com>
 <20211219023540.1638-1-hdanton@sina.com>
 <Yb6zKVoxuD3lQMA/@casper.infradead.org>
 <20211221090804.1810-1-hdanton@sina.com>
 <20211222022527.1880-1-hdanton@sina.com>
 <YcKrHc11B/2tcfRS@mit.edu>
 <CACT4Y+YHxkL5aAgd4wXPe-J+RG6_VBcPs=e8QpRM8=3KJe+GCg@mail.gmail.com>
 <YogL6MCdYVrqGcRf@mit.edu>
 <CACT4Y+ZHCawp__HvJAFPXp+z6XdiVEgwrh8dvDR+cDfQywr20w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZHCawp__HvJAFPXp+z6XdiVEgwrh8dvDR+cDfQywr20w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 23-05-22 13:34:23, Dmitry Vyukov wrote:
> +Aleksandr added this feature recently.
> 
> Console output will contain strace output for reproducers (when the
> run under strace reproduced the same kernel crash as w/o strace).
> 
> Here is a recently reported bug:
> https://syzkaller.appspot.com/bug?id=53c9bd2ca0e16936e45ff1333a22b838d91da0a2
> 
> "log" link for the reproducer crash shows:
> https://syzkaller.appspot.com/text?tag=CrashLog&x=14f791aef00000
> ...
> 
> [   26.757008][ T3179] 8021q: adding VLAN 0 to HW filter on device bond0
> [   26.766878][ T3179] eql: remember to turn off Van-Jacobson
> compression on your slave devices
> Starting sshd: OK
> Warning: Permanently added '10.128.0.110' (ECDSA) to the list of known hosts.
> execve("./syz-executor1865045535", ["./syz-executor1865045535"],
> 0x7ffdc91edf40 /* 10 vars */) = 0
> brk(NULL)                               = 0x555557248000
> brk(0x555557248c40)                     = 0x555557248c40
> arch_prctl(ARCH_SET_FS, 0x555557248300) = 0
> uname({sysname="Linux", nodename="syzkaller", ...}) = 0
> readlink("/proc/self/exe", "/root/syz-executor1865045535", 4096) = 28
> brk(0x555557269c40)                     = 0x555557269c40
> brk(0x55555726a000)                     = 0x55555726a000
> mprotect(0x7f37f8ecc000, 16384, PROT_READ) = 0
> mmap(0x1ffff000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS,
> -1, 0) = 0x1ffff000
> mmap(0x20000000, 16777216, PROT_READ|PROT_WRITE|PROT_EXEC,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x20000000
> mmap(0x21000000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS,
> -1, 0) = 0x21000000
> socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER) = 3
> syzkaller login: [   58.834018][ T3600] ------------[ cut here ]------------
> [   58.839772][ T3600] WARNING: CPU: 0 PID: 3600 at
> net/netfilter/nfnetlink.c:703 nfnetlink_unbind+0x357/0x3b0
> [   58.849856][ T3600] Modules linked in:
> ...
> 
> 
> The same is available in the report emails, e.g.:
> https://lore.kernel.org/all/000000000000ff239c05df391402@google.com/
> ...
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14f791aef00000
> ...

Wow, cool! Thanks for adding that! This was often one of the first steps I
did when looking into what the problem could be so it saves me some manual
work :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
