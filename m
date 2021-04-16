Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1623626D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 19:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbhDPRbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 13:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242556AbhDPRbc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:31:32 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5FDC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 10:31:07 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXSIj-005odw-Gp; Fri, 16 Apr 2021 17:30:41 +0000
Date:   Fri, 16 Apr 2021 17:30:41 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Xie Yongji <xieyongji@bytedance.com>, hch@infradead.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, hridya@google.com, surenb@google.com,
        sargun@sargun.me, keescook@chromium.org, jasowang@redhat.com,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] binder: Use receive_fd() to receive file from
 another process
Message-ID: <YHnJwRvUhaK3IM0l@zeniv-ca.linux.org.uk>
References: <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com>
 <20210401104034.52qaaoea27htkpbh@wittgenstein>
 <YHkedhnn1wdVFTV3@zeniv-ca.linux.org.uk>
 <YHkmxCyJ8yekgGKl@zeniv-ca.linux.org.uk>
 <20210416134252.v3zfjp36tpk33tqz@wittgenstein>
 <YHmanzAMdeCtZUjy@zeniv-ca.linux.org.uk>
 <20210416151310.nqkxfwocm32lnqfq@wittgenstein>
 <YHmu3/Cw4bUnTSH9@zeniv-ca.linux.org.uk>
 <20210416155815.ayjpnx37dv3a4jos@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416155815.ayjpnx37dv3a4jos@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:58:15PM +0200, Christian Brauner wrote:

> They could probably refactor this but I'm not sure why they'd bother. If
> they fail processing any of those files they end up aborting the
> whole transaction.
> (And the original code didn't check the error code btw.)

Wait a sec...  What does aborting the transaction do to descriptor table?
<rereads>
Oh, lovely...

binder_apply_fd_fixups() is deeply misguided.  What it should do is
	* go through t->fd_fixups, reserving descriptor numbers and
putting them into t->buffer (and I'd probably duplicate them into
struct binder_txn_fd_fixup).  Cleanup in case of failure: go through
the list, releasing the descriptors we'd already reserved, doing
fput() on fixup->file in all entries and freeing the entries as
we go.
	* On success, go through the list, doing fd_install() and
freeing the entries.

That's it.  No rereading from the buffer, no binder_deferred_fd_close()
crap, etc.

Again, YOU CAN NOT UNDO fd_install().  Ever.  Kernel can not decide it
shouldn't have put something in descriptor table and take it back.
You can't unring that bell.
