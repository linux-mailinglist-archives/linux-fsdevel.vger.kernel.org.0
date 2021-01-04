Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0412E9B61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbhADQzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 11:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhADQzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:55:19 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974ACC061793
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jan 2021 08:54:38 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwT7m-006pWK-7W; Mon, 04 Jan 2021 16:54:30 +0000
Date:   Mon, 4 Jan 2021 16:54:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK
Message-ID: <20210104165430.GI3579531@ZenIV.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20210104053112.GH3579531@ZenIV.linux.org.uk>
 <a51a2db9-716a-be20-5f71-5180394a992b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a51a2db9-716a-be20-5f71-5180394a992b@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 07:43:17AM -0700, Jens Axboe wrote:

> > I've not put it into #for-next yet; yell if you see any problems with that
> > branch, or it'll end up there ;-)
> 
> Thanks Al - but you picked out of v3, not v4. Not that there are huge
> changes between the two, from the posting of v4:
> 
> - Rename LOOKUP_NONBLOCK -> LOOKUP_CACHED, and ditto for the RESOLVE_
>   flag. This better explains what the feature does, making it more self
>   explanatory in terms of both code readability and for the user visible
>   part.
> 
> - Remove dead LOOKUP_NONBLOCK check after we've dropped LOOKUP_RCU
>   already, spotted by Al.
> 
> - Add O_TMPFILE to the checks upfront, so we can drop the checking in
>   do_tmpfile().
> 
> and it sounds like you did the last two when merging yourself.

Yes - back when I'd posted that review.

> I do like
> LOOKUP_CACHED better than LOOKUP_NONBLOCK, mostly for the externally
> self-documenting feature of it. What do you think?

Agreed, especially since _NONBLOCK would confuse users into assumption
that operation is actually non-blocking...

> Here's the v4 posting, fwiw:
> 
> https://lore.kernel.org/linux-fsdevel/20201217161911.743222-1-axboe@kernel.dk/

Sorry, picked from the local branch that sat around since Mid-December ;-/
Fixed.  Another change: ..._child part in unlazy_child() is misleading -
it might as well be used for .. traversal, where dentry is usually the
_parent_ of nd->path.dentry.  The real constraint here is that dentry/seq pair
had been valid next position at some point during the RCU walk.  Renamed to
try_to_unlazy_next(), (hopefully) fixed the comment...

Updated variant force-pushed.
