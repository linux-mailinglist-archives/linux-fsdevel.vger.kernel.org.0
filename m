Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627E77383F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 14:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjFUMkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 08:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFUMkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:40:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9578B9B;
        Wed, 21 Jun 2023 05:40:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3BFCC21C99;
        Wed, 21 Jun 2023 12:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687351214;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fFl+TwM20LVAi4D/M42g+0o8Juj67CDLcdDgvpi5mGk=;
        b=2FPVqngejQ6nbFfhWhapGLmZpDHw6BVy8/mlH5YZ5kpptEdS0oRwhJuBfnnpkuZpbv1uOm
        L9oZmWHbuzhc1ihKKk2l5VkbYnj2nbdJggbx7yrGbWNBVPHvGgv+ZUf6OhBgIOzL106MxH
        9BeTN2dUokYmMBAI0GWR5BlMqx8BwJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687351214;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fFl+TwM20LVAi4D/M42g+0o8Juj67CDLcdDgvpi5mGk=;
        b=D+LeytsQ+1KY5k+wYxnYApJQ9IVKTvtEW3lRs8hBUhQOSs5GBZLYb6vs2ZhA2/oVZQSIOb
        BB6KwNEjAz36kBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1152D133E6;
        Wed, 21 Jun 2023 12:40:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1kRSA67vkmRpUAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Jun 2023 12:40:14 +0000
Date:   Wed, 21 Jun 2023 14:33:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+9992306148b06272f3bb@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING in emit_fiemap_extent
Message-ID: <20230621123350.GP16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000091164305fe966bdd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000091164305fe966bdd@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 20, 2023 at 02:34:46PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=166d2acf280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
> dashboard link: https://syzkaller.appspot.com/bug?extid=9992306148b06272f3bb
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c65e87280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1094a78b280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2dc89d5fee38/disk-40f71e7c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0ced5a475218/vmlinux-40f71e7c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d543a4f69684/bzImage-40f71e7c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/7cde8d2312ae/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9992306148b06272f3bb@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5351 at fs/btrfs/extent_io.c:2824 emit_fiemap_extent+0xee/0x410

2804 static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
2805                                 struct fiemap_cache *cache,
2806                                 u64 offset, u64 phys, u64 len, u32 flags)
2807 {
2808         int ret = 0;
2809
2810         /* Set at the end of extent_fiemap(). */
2811         ASSERT((flags & FIEMAP_EXTENT_LAST) == 0);
2812
2813         if (!cache->cached)
2814                 goto assign;
2815
2816         /*
2817          * Sanity check, extent_fiemap() should have ensured that new
2818          * fiemap extent won't overlap with cached one.
2819          * Not recoverable.
2820          *
2821          * NOTE: Physical address can overlap, due to compression
2822          */
2823         if (cache->offset + cache->len > offset) {
2824                 WARN_ON(1);
2825                 return -EINVAL;
2826         }

Either we can drop the warning as the error is handled, or there was
another issue that was supposed to be caught earlier.
