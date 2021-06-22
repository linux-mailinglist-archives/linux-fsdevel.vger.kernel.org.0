Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735483B08FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhFVPaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhFVPaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:30:18 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F80DC061574;
        Tue, 22 Jun 2021 08:28:02 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lviJT-00BEGJ-Qu; Tue, 22 Jun 2021 15:27:43 +0000
Date:   Tue, 22 Jun 2021 15:27:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
Message-ID: <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
References: <3221175.1624375240@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3221175.1624375240@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 04:20:40PM +0100, David Howells wrote:

> and wondering if the iov_iter_fault_in_readable() is actually effective.  Yes,
> it can make sure that the page we're intending to modify is dragged into the
> pagecache and marked uptodate so that it can be read from, but is it possible
> for the page to then get reclaimed before we get to
> iov_iter_copy_from_user_atomic()?  a_ops->write_begin() could potentially take
> a long time, say if it has to go and get a lock/lease from a server.

Yes, it is.  So what?  We'll just retry.  You *can't* take faults while holding
some pages locked; not without shitloads of deadlocks.
