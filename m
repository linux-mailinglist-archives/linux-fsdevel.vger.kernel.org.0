Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93E5365884
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 14:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhDTMHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 08:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhDTMHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:07:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD96C06174A;
        Tue, 20 Apr 2021 05:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xYzD95OKA5ENyepa0XjcyYKTLHpDMzNXh5eqp/f42yQ=; b=OV04XzyNdjZ+hXo40rUDDreOqJ
        mOHWE7RZ69yNJkAK9W1kGjXgL9S2T1Y7zlQ/ONWctzfImP0UUcFaqZo2auK8DoPxC0bc6Zh98pi84
        NzK824I1F/d1K3OocowDvmMv0w4O45Cpsj8Kp08NzbsXZ/Q2aYOLYXJ5375fJbH0nVj6mdfQAQ+Yb
        DydA1Qb41vyWz5vL07Jqh+faTcWOMCjB1hNHh0BYFXjU340/028m5CQYpWpyrg7NEo9kSqSj5DjI3
        stxODaDBWQMVzBzvPuut+UuZdV8v56tRFFxFvi7eJmxRMbnrN0p8Kq6qR6U3FulHUXAns1LPwRI+3
        qG0U16mw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYp6N-00F826-Jq; Tue, 20 Apr 2021 12:03:43 +0000
Date:   Tue, 20 Apr 2021 13:03:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC v2 1/6] fs: provide unlocked helper for freeze_super()
Message-ID: <20210420120335.GA3604224@infradead.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
 <20210417001026.23858-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417001026.23858-2-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 17, 2021 at 12:10:21AM +0000, Luis Chamberlain wrote:
> freeze_super() holds a write lock, however we wish to also enable
> callers which already hold the write lock. To do this provide a helper
> and make freeze_super() use it. This way, all that freeze_super() does
> now is lock handling and active count management.

Can we take a step back and think about this a bit more?

freeze_super() has three callers:

 1) freeze_bdev
 2) ioctl_fsfreeze
 3) freeze_store (in gfs2)

The first gets its reference from get_active_super, and is the only
caller of get_active_super.  So IMHO we should just not drop the lock
in get_active_super and directly call the unlocked version.

The other two really should just call grab_super to get an active
reference and s_umount.

In other words: I don't think we need both variants, just move the
locking and s_active acquisition out of free_super.  Same for the
thaw side.
