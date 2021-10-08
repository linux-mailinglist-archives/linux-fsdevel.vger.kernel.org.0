Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1A426B8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 15:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbhJHNPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 09:15:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35764 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242558AbhJHNPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:15:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D0CFE2012E;
        Fri,  8 Oct 2021 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633698834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugDtUlYWNamC1wVk99SJQfcQCo8cBWNlkB8aWdjRG/Q=;
        b=MwaLbrnDI9nPWKefsT9kREclrK/WRJ269jjuYM4JWcuknUEehSkSQblsyg2WBrPK4TpDW9
        5rOX7rd0a2RsqGAEEcFhIr+K6DDARnlDsNjHdLvSxfzWzt43ChVc3WJL/0FAZrRZa0hUBj
        +wFAzKldEBYkS/9ufr6nbYwmvPgkPZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633698834;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugDtUlYWNamC1wVk99SJQfcQCo8cBWNlkB8aWdjRG/Q=;
        b=svewaWRaCt5qQyLUDqoU4/tFzQy7sdFsCCeQMawmWISUqMWFYVfFLOPHUQi8foAljygp9p
        T81e9w++i7jdiSCg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 7452BA3B83;
        Fri,  8 Oct 2021 13:13:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E10321F2C8D; Fri,  8 Oct 2021 15:13:51 +0200 (CEST)
Date:   Fri, 8 Oct 2021 15:13:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
 operation
Message-ID: <20211008131351.GA15930@quack2.suse.cz>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
 <20210923130814.140814-7-cgxu519@mykernel.net>
 <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
 <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
 <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com>
 <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
 <20211007144646.GL12712@quack2.suse.cz>
 <17c5b3e4f2b.113dc38cd26071.2800661599712778589@mykernel.net>
 <CAJfpegvek6=+Xk+jLNYnH0piQKRqb9CWst_aNHWExZeq+7jOQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegvek6=+Xk+jLNYnH0piQKRqb9CWst_aNHWExZeq+7jOQw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 07-10-21 20:51:47, Miklos Szeredi wrote:
> On Thu, 7 Oct 2021 at 16:53, Chengguang Xu <cgxu519@mykernel.net> wrote:
> >
> >  ---- 在 星期四, 2021-10-07 22:46:46 Jan Kara <jack@suse.cz> 撰写 ----
> >  > On Thu 07-10-21 15:34:19, Miklos Szeredi wrote:
> >  > > On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu519@mykernel.net> wrote:
> >  > > >  > However that wasn't what I was asking about.  AFAICS ->write_inode()
> >  > > >  > won't start write back for dirty pages.   Maybe I'm missing something,
> >  > > >  > but there it looks as if nothing will actually trigger writeback for
> >  > > >  > dirty pages in upper inode.
> >  > > >  >
> >  > > >
> >  > > > Actually, page writeback on upper inode will be triggered by overlayfs ->writepages and
> >  > > > overlayfs' ->writepages will be called by vfs writeback function (i.e writeback_sb_inodes).
> >  > >
> >  > > Right.
> >  > >
> >  > > But wouldn't it be simpler to do this from ->write_inode()?
> >  >
> >  > You could but then you'd have to make sure you have I_DIRTY_SYNC always set
> >  > when I_DIRTY_PAGES is set on the upper inode so that your ->write_inode()
> >  > callback gets called. Overall I agree the logic would be probably simpler.
> >  >
> >
> 
> And it's not just for simplicity.  The I_SYNC logic in
> writeback_single_inode() is actually necessary to prevent races
> between instances on a specific inode.  I.e. if inode writeback is
> started by background wb then syncfs needs to synchronize with that
> otherwise it will miss the inode, or worse, mess things up by calling
> ->write_inode() multiple times in parallel.  So going throught
> writeback_single_inode() is actually a must AFAICS.

Yes, you are correct.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
