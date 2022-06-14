Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB51354B2A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 15:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiFNN6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 09:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343608AbiFNN6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:58:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9251A2E696;
        Tue, 14 Jun 2022 06:58:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2C44B1F984;
        Tue, 14 Jun 2022 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655215118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CeiLcPaUWpFLyUL+9AfxzQ6cCLGBau32H4tijDd9jqk=;
        b=nTBARfnLs4xqal0/JTkbIDZlKIg8p/c6pqNEIzOBzKMJh6ZxTO8uc9V3JB2zxJ+mzBkOIl
        len1iN+co9yZfNxXip8sirINpP0bWdJQkjl7/Bd2Dj8O/TXETPsPOkqUwx4VfWnZLSYtjv
        7NfnJknbXbvnm0DSQhNNYEqohtnuS34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655215118;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CeiLcPaUWpFLyUL+9AfxzQ6cCLGBau32H4tijDd9jqk=;
        b=Gp7XaVEqQ5AwGE4SIN4e1AWnakNRl3vK1lqe/keGYSlZ9PP9Eb/siFJSVmuirbU1d/8HMs
        Md9NdyeL5Dx/AKAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C687D2C143;
        Tue, 14 Jun 2022 13:58:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 835F9A062E; Tue, 14 Jun 2022 15:58:37 +0200 (CEST)
Date:   Tue, 14 Jun 2022 15:58:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>, jack@suse.cz,
        sunjunchao2870@gmail.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, maco@android.com, hch@lst.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Subject: Re: [BUG] rockpro64 board hangs in console_init() after commit
 10e14073107d
Message-ID: <20220614135837.3doyrnekzja6grzc@quack3.lan>
References: <Yqdry+IghSWnJ6pe@monolith.localdoman>
 <Yqh9xIwBVcabpSLe@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqh9xIwBVcabpSLe@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 14-06-22 14:23:32, Petr Mladek wrote:
> On Mon 2022-06-13 17:54:35, Alexandru Elisei wrote:

<snip>

> > Config can be found at [1] (expires after 6 months). I've also built the
> > kernel with gcc 10.3.1 [2] (aarch64-none-linux-gnu), same issue.
> > 
> > I've bisected the build failure to commit 10e14073107d ("writeback: Fix
> > inode->i_io_list not be protected by inode->i_lock error"); I've confirmed
> > that that commit is responsible by successfully booting the board with a
> > kernel built from v5.19-rc2 + the above commit reverted.
> 
> It is strange. I can't see how consoles are related to filesystem
> writeback.
> 
> Anyway, the commit 10e14073107d ("writeback: Fix inode->i_io_list not
> be protected by inode->i_lock error") modifies some locking and
> might be source of possible deadlocks.

Yes, I've got other reports from ARM people that this commit causes issues
for them (kernel oops or so) so the locking changes are likely at fault...

> I am not familiar with the fs code. But I noticed the following.
> The patch adds:
> 
> +               if (!was_dirty) {
> +                       wb = locked_inode_to_wb_and_lock_list(inode);
> +                       spin_lock(&inode->i_lock);
> 
> And locked_inode_to_wb_and_lock_list() is defined this way:
> 
> /**
>  * locked_inode_to_wb_and_lock_list - determine a locked inode's wb and lock it
>  * @inode: inode of interest with i_lock held
>  *
>  * Returns @inode's wb with its list_lock held.  @inode->i_lock must be
>  * held on entry and is released on return.  The returned wb is guaranteed
>  * to stay @inode's associated wb until its list_lock is released.
>  */
> static struct bdi_writeback *
> locked_inode_to_wb_and_lock_list(struct inode *inode)
> 	__releases(&inode->i_lock)
> 	__acquires(&wb->list_lock)
> {
> 	while (true) {
> 		struct bdi_writeback *wb = inode_to_wb(inode);
> 
> 		/*
> 		 * inode_to_wb() association is protected by both
> 		 * @inode->i_lock and @wb->list_lock but list_lock nests
> 		 * outside i_lock.  Drop i_lock and verify that the
> 		 * association hasn't changed after acquiring list_lock.
> 		 */
> 		wb_get(wb);
> 		spin_unlock(&inode->i_lock);
> 
> It expects that inode->i_lock is taken before. But the problematic
> commit takes it later. It might mess the lock and cause a deadlock.

No. AFAICS inode->i_lock is held on entry to
locked_inode_to_wb_and_lock_list(). The function releases it so we have to
grab it again. The locking is ugly here but correct in this regard.

It rather likely has to do something with reordering the checks and running
locked_inode_to_wb_and_lock_list() on inodes for which we previously didn't
do it but I have to yet fully understand why things crash...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
