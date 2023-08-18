Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A90F780A93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 12:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376476AbjHRK5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 06:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376528AbjHRK5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3A230C2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 03:57:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9A7564DBB
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 10:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D157AC433CA;
        Fri, 18 Aug 2023 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692356222;
        bh=pfE1upJuBUNMVBimeW5+Ir6M/4IWNF/nx+dQY617W/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DB0A9VdJfFeFdrAX5mkWpRx7nH2/GOc9jBVBFqzpzb0nwms4TlnUqWRwSd5dsRkXx
         Wax+vrFxs0KlOFcOWXM9Dz4GUDUrPRodYqSOXp/sI2ixv9ghYeofLfVbJa+F/MEbtn
         onTt4vEN9k7hU19DtX312rzz56Nj6QkOJ/L0DhwkSD/t+5B+BpFoIBTgAZDtKgYetA
         MKc5/rvYPrw+pVCCpfTSUa4zEaBCU49SDKj/dmuo1hUsf51xD3yDxw4iVAi1MAXzNe
         SIusrteWbnGyWurszwBzSrk4iTCzsqgumCXy3T7hbntfD6CKtjXTmeiXf8/WB9MhC0
         PXsk5muorQs8g==
Date:   Fri, 18 Aug 2023 12:56:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] super: wait for nascent superblocks
Message-ID: <20230818-befreiend-engagiert-1fbf520070d5@brauner>
References: <20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org>
 <20230817-vfs-super-fixes-v3-v1-2-06ddeca7059b@kernel.org>
 <20230817125021.l6h4ipibfuzd3xdx@quack3>
 <ZN6I12YthkzAnpzo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZN6I12YthkzAnpzo@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 09:53:43PM +0100, Matthew Wilcox wrote:
> On Thu, Aug 17, 2023 at 02:50:21PM +0200, Jan Kara wrote:
> > > +/**
> > > + * super_wait - wait for superblock to become ready
> > > + * @sb: superblock to wait for
> > > + * @excl: whether exclusive access is required
> > > + *
> > > + * If the superblock has neither passed through vfs_get_tree() or
> > > + * generic_shutdown_super() yet wait for it to happen. Either superblock
> > > + * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
> > > + * woken and we'll see SB_DYING.
> > > + *
> > > + * The caller must have acquired a temporary reference on @sb->s_count.
> > > + *
> > > + * Return: true if SB_BORN was set, false if SB_DYING was set.
> > 
> > The comment should mention that this acquires s_umount and returns with it
> > held. Also the name is a bit too generic for my taste and not expressing
> > the fact this is in fact a lock operation. Maybe something like
> > super_lock_wait_born()?
> 
> Isn't this actually the normal function we want people to call?  So maybe
> this function should be called super_lock() and the functions in the
> last patch get called __super_lock() for raw access to the lock.

I think that's a good point. I've renamed them accordingly.

> 
> I'm also a little wary that this isn't _killable.  Are we guaranteed
> that a superblock will transition to BORN or DYING within a limited
> time?

Yes, it should. If this would be an issue it's something we should have
seen already. Random example being s_umount being held over a
filesytem's fill_super() method all while concurrent iterators are
sleeping on s_umount unconditionally. It is ofc always possible for us
to make this killable in the future should it become an issue.
