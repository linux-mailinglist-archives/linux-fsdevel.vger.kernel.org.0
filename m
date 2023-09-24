Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C027ACC22
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 23:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjIXV4u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 17:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIXV4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 17:56:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EDBFC
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=t0dWRs0AcgJslUYwJm+3ICfi/SDNmg7iKfq/0Kh1WAc=; b=hj/JQqXGV4LZ1Z56d6uW9HOEmC
        h2nSL/RQeHQdmbLgcsXYyTTIhfVpUfzo0RSpfO8Qy/0NaJMG5mUjzTQXFsRcpa2iHCgFB2OxKpjrf
        mEnjzJQUAfWuhgE/E6fYv1IYmk5xyimJpfVJnJzRrj4la+FwJFrZSJqMqV3oLI29NO6Ed42pxpVxk
        RGtSU8OgA6Fdn0hlSTypKCnmQBXDzEnOZAXEzOuAopSjNtIVXQ4l+zFIHGWdPTxzwXIQ7RBLEm5GE
        YwZl9gqhnzKo36mTX6VfjbwharVBeq53EXWAJVI5OWxPQwVTk7qIf8XPDeed+smEANcyzcxih4nzL
        JlLG2VSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qkX5Y-00FGVf-Mo; Sun, 24 Sep 2023 21:56:28 +0000
Date:   Sun, 24 Sep 2023 22:56:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Reuben Hawkins <reubenhwk@gmail.com>, brauner@kernel.org,
        Cyril Hrubis <chrubis@suse.cz>, mszeredi@redhat.com,
        lkp@intel.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev,
        ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
Message-ID: <ZRCwjGSF//WUPohL@casper.infradead.org>
References: <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
 <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org>
 <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 24, 2023 at 06:32:30PM +0300, Amir Goldstein wrote:
> On Sun, Sep 24, 2023 at 5:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Sep 24, 2023 at 02:47:42PM +0300, Amir Goldstein wrote:
> > > Since you joined the discussion, you have the opportunity to agree or
> > > disagree with our decision to change readahead() to ESPIPE.
> > > Judging  by your citing of lseek and posix_fadvise standard,
> > > I assume that you will be on board?
> >
> > I'm fine with returning ESPIPE (it's like ENOTTY in a sense).  but
> > that's not what kbuild reported:
> 
> kbuild report is from v1 patch that was posted to the list
> this is not the patch (v2) that is applied to vfs.misc
> and has been in linux-next for a few days.

Ah!  I was confused.

> > I think that should
> > also return ESPIPE.  I think posix_fadvise() should return ESPIPE on a
> > socket too, but reporting bugs to the Austin Group seems quite painful.
> > Perhaps somebody has been through this process and can do that for us?
> 
> This is Reuben's first kernel patch.
> Let's agree that changing the standard of posix_fadvise() for socket is
> beyond the scope of his contribution :)

Thank you for shepherding his first contribution.  Unfortunately, this
is rather the way of it when you start to pick at something ... you find
more things that are broken.  It's rather unusual that this one turned
out to be "The POSIX spec has a defect" ;-)

But yes, I'm content with v2 if v2 does in fact return ESPIPE for
readahead() on a socket.  Let's wait to find out.  We can address the
POSIX defect later.
