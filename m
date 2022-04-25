Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06FC50E760
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244019AbiDYRhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 13:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiDYRhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:37:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD636D1BC;
        Mon, 25 Apr 2022 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3HRykZfhFQlUA9mo6JlzyNhcWbuWLV1lxnc6LbaGpKM=; b=aaFjv5L3eBguFpcpde6lkfi5Oo
        Q363Tx5wLZm8eK2NJAPosTPeiJV/o35yKr12LcSbgRmR59xKyFbgWqyPqEUEk1UkLixKzEj5lmzTc
        9tZHheQ8+Qa6E+KmsIXpy5lKCRM4oF1NTAHNdDyxLYOncxDFym2P4wm05arC+Wdwoqhd8iB6T4+j6
        geZmFU7iHWOpnxW06ywCdLodCiCGA61px/cV13clbnXgF8ACoKbplf8fPtBUVHbPRvAu8g7rSkX2f
        0NI5mZV8qChTDMjuo3Adzyz87SuGc+iOb+la+VvAuMgo79DACJJDQ9hlvGmNYsomyYIa1JGppooBG
        o67w22rQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj2ax-008tDU-8x; Mon, 25 Apr 2022 17:33:55 +0000
Date:   Mon, 25 Apr 2022 18:33:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v6 1/4] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Message-ID: <Ymbbg3XbN17l3Jir@casper.infradead.org>
References: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YmYLVfZC3h8l7XY1@casper.infradead.org>
 <62661F19.3020805@fujitsu.com>
 <20220425112947.higk7uawxkcdcjgj@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425112947.higk7uawxkcdcjgj@wittgenstein>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 01:29:47PM +0200, Christian Brauner wrote:
> On Mon, Apr 25, 2022 at 03:08:36AM +0000, xuyang2018.jy@fujitsu.com wrote:
> > on 2022/4/25 10:45, Matthew Wilcox wrote:
> > > On Mon, Apr 25, 2022 at 11:09:38AM +0800, Yang Xu wrote:
> > >> This has no functional change. Just create and export inode_sgid_strip
> > >> api for the subsequent patch. This function is used to strip inode's
> > >> S_ISGID mode when init a new inode.
> > >
> > > Why would you call this inode_sgid_strip() instead of
> > > inode_strip_sgid()?
> > 
> > Because I treated "inode sgid(inode's sgid)" as a whole.
> > 
> > inode_strip_sgid sounds also ok, but now seems strip_inode_sgid seem 
> > more clear because we strip inode sgid depend on not only inode's 
> > condition but also depend on parent directory's condition.
> > 
> > What do you think about this?
> > 
> > ps: I can aceept the above several way, so if you insist, I can change 
> > it to inode_strip_sgid.
> 
> I agree with Willy. I think inode_strip_sgid() is better. It'll be in
> good company as <object>_<verb>_<what?> is pretty common:
> 
> inode_update_atime()
> inode_init_once()
> inode_init_owner()
> inode_init_early()
> inode_add_lru()
> inode_needs_sync()
> inode_set_flags()
> 
> Maybe mode_remove_sgid() is even better because it makes it clear that
> the change happens to @mode and not @dir. But I'm fine with
> inode_strip_sgid() or inode_remove_sgid() too.

Oh!  Yes, mode_strip_sgid() is better.  We're operating on the mode,
not the inode.
