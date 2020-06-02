Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F21EBF78
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 17:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFBP4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 11:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgFBP4b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:56:31 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CAA820674;
        Tue,  2 Jun 2020 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591113390;
        bh=H8aFPeriX1h4g9Bou5pcBah39lJlaBgwVrbWD5pRuGo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NOI35UWkEu0Q34beBsvrOogHXtSMtf0F+DjfrEKxIr/Fl4ZvkzQfcu+bPjnnj2hA4
         ofrZ+gBKhtFkL8hy+YuiR1FQz6tKfCScbiLdFj/pnABSHSD34sOm9huwdREsKDepdY
         ZBJOoKYAZEyT5ZayJGNYgDMbvbYf8DO2QdEX64kQ=
Message-ID: <63020790a240cfcd1d798147edebbc231b1ff32b.camel@kernel.org>
Subject: Re: [PATCH] locks: add locks_move_blocks in posix_lock_inode
From:   Jeff Layton <jlayton@kernel.org>
To:     yangerkun <yangerkun@huawei.com>, NeilBrown <neilb@suse.de>,
        viro@zeniv.linux.org.uk, neilb@suse.com
Cc:     linux-fsdevel@vger.kernel.org,
        "bfields@vger.kernel.org" <bfields@vger.kernel.org>
Date:   Tue, 02 Jun 2020 11:56:29 -0400
In-Reply-To: <eaf471c1-ef00-beb5-3143-fdcc62a7058a@huawei.com>
References: <20200601091616.34137-1-yangerkun@huawei.com>
         <877dwq757c.fsf@notabene.neil.brown.name>
         <eaf471c1-ef00-beb5-3143-fdcc62a7058a@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-06-02 at 21:49 +0800, yangerkun wrote:
> 
> 在 2020/6/2 7:10, NeilBrown 写道:
> > On Mon, Jun 01 2020, yangerkun wrote:
> > 
> > > We forget to call locks_move_blocks in posix_lock_inode when try to
> > > process same owner and different types.
> > > 
> > 
> > This patch is not necessary.
> > The caller of posix_lock_inode() must calls locks_delete_block() on
> > 'request', and that will remove all blocked request and retry them.
> > 
> > So calling locks_move_blocks() here is at most an optimization.  Maybe
> > it is a useful one.
> > 
> > What led you to suggesting this patch?  Were you just examining the
> > code, or was there some problem that you were trying to solve?
> 
> 
> Actually, case of this means just replace a exists file_lock. And once 
> we forget to call locks_move_blocks, the function call of 
> posix_lock_inode will also call locks_delete_block, and will wakeup all 
> blocked requests and retry them. But we should do this until we UNLOCK 
> the file_lock! So, it's really a bug here.
> 

Waking up waiters to re-poll a lock that's still blocked seems wrong. I
agree with Neil that this is mainly an optimization, but it does look
useful.

Unfortunately this is the type of thing that's quite difficult to test
for in a userland testcase. Is this something you noticed due to the
extra wakeups or did you find it by inspection? It'd be great to have a
better way to test for this in xfstests or something.

I'll plan to add this to linux-next. It should make v5.9, but let me
know if this is causing real-world problems and maybe we can make a case
for v5.8.

Thanks,
Jeff

> > 
> > > Signed-off-by: yangerkun <yangerkun@huawei.com>
> > > ---
> > >   fs/locks.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index b8a31c1c4fff..36bd2c221786 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -1282,6 +1282,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
> > >   				if (!new_fl)
> > >   					goto out;
> > >   				locks_copy_lock(new_fl, request);
> > > +				locks_move_blocks(new_fl, request);
> > >   				request = new_fl;
> > >   				new_fl = NULL;
> > >   				locks_insert_lock_ctx(request, &fl->fl_list);
> > > -- 
> > > 2.21.3

-- 
Jeff Layton <jlayton@kernel.org>

