Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32CE3AC195
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 05:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhFRDsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 23:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhFRDsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 23:48:39 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC09C061574;
        Thu, 17 Jun 2021 20:46:30 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lu5Sa-009UL9-7S; Fri, 18 Jun 2021 03:46:24 +0000
Date:   Fri, 18 Jun 2021 03:46:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Andrew W Elble <aweits@rit.edu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] netfs, afs: Fix netfs_write_begin and THP handling
Message-ID: <YMwXEAMxEgGADeiG@zeniv-ca.linux.org.uk>
References: <162391823192.1173366.9740514875196345746.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162391823192.1173366.9740514875196345746.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 09:23:51AM +0100, David Howells wrote:
> 
> Here are some patches to fix netfs_write_begin() and the handling of THPs in
> that and afs_write_begin/end() in the following ways:
> 
>  (1) Use offset_in_thp() rather than manually calculating the offset into
>      the page.
> 
>  (2) In the future, the len parameter may extend beyond the page allocated.
>      This is because the page allocation is deferred to write_begin() and
>      that gets to decide what size of THP to allocate.
> 
>  (3) In netfs_write_begin(), extract the decision about whether to skip a
>      page out to its own helper and have that clear around the region to be
>      written, but not clear that region.  This requires the filesystem to
>      patch it up afterwards if the hole doesn't get completely filled.
> 
>  (4) Due to (3), afs_write_end() now needs to handle short data write into
>      the page by generic_perform_write().  I've adopted an analogous
>      approach to ceph of just returning 0 in this case and letting the
>      caller go round again.

Series looks sane.  I'd like to hear about the thp-related plans in
more detail, but that's a separate story.

> I wonder if generic_perform_write() should pass in a flag indicating
> whether this is the first attempt or a second attempt at this, and on the
> second attempt we just completely prefill the page and just let the partial
> write stand - which we have to do if the page was already uptodate when we
> started.

Not really - we'll simply get a shorter chunk next time around (with
the patches in -next right now it'll be "the amount we'd actually
managed to copy this time around" in case ->write_begin() tells us
to take a hike), and that shorter chunk is what ->write_begin() will
see.  No need for the flags...
