Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB64FBEE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245624AbiDKOWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 10:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347184AbiDKOWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:22:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC850E0F7
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 07:19:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 87CAD210E3;
        Mon, 11 Apr 2022 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649686758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PcYqNYLePt52+e8simnJyvhTPYaauhvjQNEhEOtnPmA=;
        b=eq7AwNDOeqLz1tvDHWSRbpFvzPb6HSRhPY5ljynmDeCNMGbZ+ZaUquBotP+zmYQRSKrYIv
        DGJ/hFE7D00OPq41giq1V4MhcwjFbj0J5SL2xYbV/wxl9pOK9H8RqQUCnXHf6le9yzr+Zm
        tyxpytySVLCJ/w9AVVrs/lkAZuYAPVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649686758;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PcYqNYLePt52+e8simnJyvhTPYaauhvjQNEhEOtnPmA=;
        b=t7jMnK9oeCrY/5o4bupj9AmYvD/uv0rIMY0sDOtxdm2nkmUQ8tXDCTpk0W7I3ZW7e+N856
        dw5PjZV4afMr5XBA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 69BB8A3B99;
        Mon, 11 Apr 2022 14:19:18 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 93D10A061B; Mon, 11 Apr 2022 16:19:12 +0200 (CEST)
Date:   Mon, 11 Apr 2022 16:19:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 13/16] fanotify: implement "evictable" inode marks
Message-ID: <20220411141912.ery2uhg3gqyt32oa@quack3.lan>
References: <20220329074904.2980320-1-amir73il@gmail.com>
 <20220329074904.2980320-14-amir73il@gmail.com>
 <20220411114752.jpn7kkxnqobriep3@quack3.lan>
 <CAOQ4uxjuYChExjsqPmczM9SzXapUR0bT8RTEbxaQsSacNOMV4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjuYChExjsqPmczM9SzXapUR0bT8RTEbxaQsSacNOMV4A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 11-04-22 15:57:30, Amir Goldstein wrote:
> On Mon, Apr 11, 2022 at 2:47 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 29-03-22 10:49:01, Amir Goldstein wrote:
> > > When an inode mark is created with flag FAN_MARK_EVICTABLE, it will not
> > > pin the marked inode to inode cache, so when inode is evicted from cache
> > > due to memory pressure, the mark will be lost.
> > >
> > > When an inode mark with flag FAN_MARK_EVICATBLE is updated without using
> > > this flag, the marked inode is pinned to inode cache.
> > >
> > > When an inode mark is updated with flag FAN_MARK_EVICTABLE but an
> > > existing mark already has the inode pinned, the mark update fails with
> > > error EEXIST.
> >
> > I was thinking about this. FAN_MARK_EVICTABLE is effectively a hint to the
> > kernel - you can drop this if you wish. So does it make sense to return
> > error when we cannot follow the hint? Doesn't this just add unnecessary
> > work (determining whether the mark should be evictable or not) to the
> > userspace application using FAN_MARK_EVICTABLE?
> 
> I do not fully agree about your definition of  "hint to the kernel".
> Yes, for a single inode it may be a hint, but for a million inodes it is pretty
> much a directive that setting a very large number of evictable marks
> CANNOT be used to choke the system.
> 
> It's true that the application should be able to avoid shooting its own
> foot and we do not need to be the ones providing this protection, but
> I rather prefer to keep the API more strict and safe than being sorry later.
> After all, I don't think this complicates the implementation nor documentation
> too much. Is it? see:
> 
> https://github.com/amir73il/man-pages/commit/b52eb7d1a8478cbd1456f4d9463902bbc4e80f0d

No, it is not complicating things too much and you're probably right that
having things stricter now may pay off in the future. I was just thinking
that app adding ignore mark now needs to remember whether it has already
added something else for the inode or not to know whether it can use
FAN_MARK_EVICTABLE. Which seemed like unnecessary complication.

> > I'd also note that FSNOTIFY_MARK_FLAG_NO_IREF needs to be stored only
> > because of this error checking behavior. Otherwise it would be enough to
> > have a flag on the connector (whether it holds iref or not) and
> > fsnotify_add_mark() would update the connector as needed given the added
> 
> I am not sure I agree to that.
> Maybe I am missing something, but the way fsnotify_recalc_mask() works now
> is by checking if there is any mark without FSNOTIFY_MARK_FLAG_NO_IREF
> attached to the object, so fsnotify_put_mark() knows to drop the inode when the
> last non-evictable mark is removed.

Right, I was confused and somehow thought that once connector has iref, it
will drop it only when the mark list gets empty which is obviously not
true.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
