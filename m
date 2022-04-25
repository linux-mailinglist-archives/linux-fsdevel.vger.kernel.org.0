Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AE250DECB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 13:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbiDYLdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 07:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiDYLdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:33:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC72D636B;
        Mon, 25 Apr 2022 04:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF4CEB815DE;
        Mon, 25 Apr 2022 11:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5240CC385A4;
        Mon, 25 Apr 2022 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650886197;
        bh=rPTeVumN/3uTXCzwa3jZ1Wd2mxsB9yPE4zyMKNbMFdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O70SYSg9yKUMfATi2sbfEiqzC/r2IIAwU59QoY0d9NX6YSxrRis9x8J23xOSfj29+
         mT2lPK5ra7ijpCz3qBz8HbaLeK13+S2hRyTLT2f+A1ynLPvD8AsHBmOuqvDL2bMo7a
         SZ8XvMINuWLupG9q+uPh1HN1uE93xv9JfkPu1DkEz1tzrvqL5AuhDnf4kpvUCGrrrW
         9gzwDzKFZQLY18AknskD3TciobQDsW79f6ABxmBnZM5d7eVBZ+wmu1AK3qDhHplEv3
         fKxED23X6aYFg/c21ZhTZmhenjtZNja+eR59K/5OJklfvryPe4EG/LzBcH4Z461eUz
         8zBLUJaDgnR5Q==
Date:   Mon, 25 Apr 2022 13:29:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v6 1/4] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Message-ID: <20220425112947.higk7uawxkcdcjgj@wittgenstein>
References: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YmYLVfZC3h8l7XY1@casper.infradead.org>
 <62661F19.3020805@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62661F19.3020805@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 03:08:36AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/25 10:45, Matthew Wilcox wrote:
> > On Mon, Apr 25, 2022 at 11:09:38AM +0800, Yang Xu wrote:
> >> This has no functional change. Just create and export inode_sgid_strip
> >> api for the subsequent patch. This function is used to strip inode's
> >> S_ISGID mode when init a new inode.
> >
> > Why would you call this inode_sgid_strip() instead of
> > inode_strip_sgid()?
> 
> Because I treated "inode sgid(inode's sgid)" as a whole.
> 
> inode_strip_sgid sounds also ok, but now seems strip_inode_sgid seem 
> more clear because we strip inode sgid depend on not only inode's 
> condition but also depend on parent directory's condition.
> 
> What do you think about this?
> 
> ps: I can aceept the above several way, so if you insist, I can change 
> it to inode_strip_sgid.

I agree with Willy. I think inode_strip_sgid() is better. It'll be in
good company as <object>_<verb>_<what?> is pretty common:

inode_update_atime()
inode_init_once()
inode_init_owner()
inode_init_early()
inode_add_lru()
inode_needs_sync()
inode_set_flags()

Maybe mode_remove_sgid() is even better because it makes it clear that
the change happens to @mode and not @dir. But I'm fine with
inode_strip_sgid() or inode_remove_sgid() too.
