Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3D177FF56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 22:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355054AbjHQUyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 16:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355083AbjHQUxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:53:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333F510E9
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 13:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K+LAKzJk0BcOTbtaac37iWA6ZE66UyHURd7CeWTrzCw=; b=WRX+4E7Le3XkNZnXCMJ/QgGUAu
        UIGVS510t+q2Ejx1jux11uBvRKUWCK6S8BYf9DBowLuibFbDpnL3zLDITiJgKYAqb3UeBDwmhzmBT
        R8ZC0UKBVpayj9UrSqoJTLbiqIsp5HM3UU1rfTEMn55LwV1D/yJtNadvTneg4AJTtkHVjHvwuAvFu
        ySO61rcxhvi/pZt2oJqIg1NnVkr/bjhqv6cbcYhdjFDUUgCVsM0kE/CJNYQXQ7s3u2Q7gDMElSA96
        Pj5OEFLo9ZPiKJFLjaAnbgw+kOyM9F7fSkhEqULnYE0y3CnwiVe7QPlQ9ry2hdej8DOYiGd9IEwV3
        YsG08wqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWjzz-005Pwr-Bs; Thu, 17 Aug 2023 20:53:43 +0000
Date:   Thu, 17 Aug 2023 21:53:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] super: wait for nascent superblocks
Message-ID: <ZN6I12YthkzAnpzo@casper.infradead.org>
References: <20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org>
 <20230817-vfs-super-fixes-v3-v1-2-06ddeca7059b@kernel.org>
 <20230817125021.l6h4ipibfuzd3xdx@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817125021.l6h4ipibfuzd3xdx@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:50:21PM +0200, Jan Kara wrote:
> > +/**
> > + * super_wait - wait for superblock to become ready
> > + * @sb: superblock to wait for
> > + * @excl: whether exclusive access is required
> > + *
> > + * If the superblock has neither passed through vfs_get_tree() or
> > + * generic_shutdown_super() yet wait for it to happen. Either superblock
> > + * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
> > + * woken and we'll see SB_DYING.
> > + *
> > + * The caller must have acquired a temporary reference on @sb->s_count.
> > + *
> > + * Return: true if SB_BORN was set, false if SB_DYING was set.
> 
> The comment should mention that this acquires s_umount and returns with it
> held. Also the name is a bit too generic for my taste and not expressing
> the fact this is in fact a lock operation. Maybe something like
> super_lock_wait_born()?

Isn't this actually the normal function we want people to call?  So maybe
this function should be called super_lock() and the functions in the
last patch get called __super_lock() for raw access to the lock.

I'm also a little wary that this isn't _killable.  Are we guaranteed
that a superblock will transition to BORN or DYING within a limited
time?

This isn't part of the VFS I know well.
