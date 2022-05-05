Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1132351BB53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 11:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiEEJEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 05:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiEEJEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 05:04:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8F71FCF7
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 02:01:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9C9AB218F2;
        Thu,  5 May 2022 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651741262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDo27eh8JDaR4e2Fv+OryKwE09e8IYTXDEaW5hZ9iko=;
        b=nq9KzSgUTCCIl+L+Dc8IUr6+VQUlZVouJ7ieATrscMfP1wZijQHujRKwoJdJ9qXESZ+Zt5
        NU4CRv34Btgay9XyJwSjniZjejZN2hw2sovjTD9OYhX2oFakAYjz28yz/k12M/oMr+0pIS
        whCmpx/PbTxwEa76bXEtSwxqRHhnaxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651741262;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDo27eh8JDaR4e2Fv+OryKwE09e8IYTXDEaW5hZ9iko=;
        b=6SAkjjBslsTemZBeUdpfyLULXTi2oCaMLTDQDUO8YSPx4QB/zxDiv9A5Lm8F4jv7s4sC+Y
        cgzCrrpDA5DHQqBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8D6A12C141;
        Thu,  5 May 2022 09:01:02 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BEB9AA0627; Thu,  5 May 2022 11:00:59 +0200 (CEST)
Date:   Thu, 5 May 2022 11:00:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jchao sun <sunjunchao2870@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] writeback: Fix inode->i_io_list not be protected by
 inode->i_lock error
Message-ID: <20220505090059.bgbn7lv2jsvo3vu3@quack3.lan>
References: <20220504143924.ix2m3azbxdmx67u6@quack3.lan>
 <20220504182514.25347-1-sunjunchao2870@gmail.com>
 <20220504193847.lx4eqcnqzqqffbtm@quack3.lan>
 <CAHB1Naif38Cib5xMLa1nK7-5H4FeLgPMLbBCi-Ze=YNna8ymYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHB1Naif38Cib5xMLa1nK7-5H4FeLgPMLbBCi-Ze=YNna8ymYA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 05-05-22 12:45:56, Jchao sun wrote:
> On Thu, May 5, 2022 at 3:38 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 04-05-22 11:25:14, Jchao Sun wrote:
> > > Commit b35250c0816c ("writeback: Protect inode->i_io_list with
> > > inode->i_lock") made inode->i_io_list not only protected by
> > > wb->list_lock but also inode->i_lock, but inode_io_list_move_locked()
> > > was missed. Add lock there and also update comment describing things
> > > protected by inode->i_lock.
> > >
> > > Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with
> inode->i_lock")
> > > Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>
> >
> > Almost there :). A few comments below:
> >
> > > @@ -2402,6 +2404,9 @@ void __mark_inode_dirty(struct inode *inode, int
> flags)
> > >                       inode->i_state &= ~I_DIRTY_TIME;
> > >               inode->i_state |= flags;
> > >
> > > +             wb = locked_inode_to_wb_and_lock_list(inode);
> > > +             spin_lock(&inode->i_lock);
> > > +
> >
> 
> > > We don't want to lock wb->list_lock if the inode was already dirty (which
> > > is a common path). So you want something like:
> > >
> > >                 if (was_dirty)
> > >                         wb = locked_inode_to_wb_and_lock_list(inode);
> 
> I'm a little confused about here. The logic of the current source tree is
> like this:
>                        if (!was_dirty) {
>                                struct bdi_writeback *wb;
>                                wb =
> locked_inode_to_wb_and_lock_list(inode);
>                                ...
>                                dirty_list = &wb-> b_dirty_time;
>                                assert_spin_locked(&wb->list_lock);
>                        }
> The logic is the opposite of the logic in the comments, and it seems like
> that wb will
> absolutely not be NULL.
> Why is this? What is the difference between them?

Sorry, that was a typo in my suggestion. It should have been

                 if (!was_dirty)
                         wb = locked_inode_to_wb_and_lock_list(inode);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
