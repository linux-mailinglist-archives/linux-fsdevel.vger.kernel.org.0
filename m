Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9043D49D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 22:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhGXTqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 15:46:02 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:47568 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhGXTqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:46:02 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7OC1-003eaC-FU; Sat, 24 Jul 2021 20:24:17 +0000
Date:   Sat, 24 Jul 2021 20:24:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable
 helper
Message-ID: <YPx28cEvrVl6YrDk@zeniv-ca.linux.org.uk>
References: <20210724193449.361667-1-agruenba@redhat.com>
 <20210724193449.361667-2-agruenba@redhat.com>
 <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 24, 2021 at 12:52:34PM -0700, Linus Torvalds wrote:
> ...
> > +                       if (fault_in_user_pages(start, len, true) != len)
> > +                               return -EFAULT;
> 
> Looking at this once more, I think this is likely wrong.
> 
> Why?
> 
> Because any user can/should only care about at least *part* of the
> area being writable.
> 
> Imagine that you're doing a large read. If the *first* page is
> writable, you should still return the partial read, not -EFAULT.

Agreed.

> So I think the code needs to return 0 if _any_ fault was successful.

s/any/the first/...

The same goes for fault-in for read, of course; I've a half-baked conversion
to such semantics (-EFAULT vs. 0; precise length is unreliable anyway,
especially if you have sub-page failure areas), need to finish and post
it...
