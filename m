Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6322D3FA14D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 23:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhH0V6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 17:58:09 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:45154 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhH0V6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:58:09 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJjqY-00Gbep-Jz; Fri, 27 Aug 2021 21:57:10 +0000
Date:   Fri, 27 Aug 2021 21:57:10 +0000
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
Subject: Re: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
Message-ID: <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
 <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 09:48:55PM +0000, Al Viro wrote:

> 	[btrfs]search_ioctl()
> Broken with memory poisoning, for either variant of semantics.  Same for
> arm64 sub-page permission differences, I think.


> So we have 3 callers where we want all-or-nothing semantics - two in
> arch/x86/kernel/fpu/signal.c and one in btrfs.  HWPOISON will be a problem
> for all 3, AFAICS...
> 
> IOW, it looks like we have two different things mixed here - one that wants
> to try and fault stuff in, with callers caring only about having _something_
> faulted in (most of the users) and one that wants to make sure we *can* do
> stores or loads on each byte in the affected area.
> 
> Just accessing a byte in each page really won't suffice for the second kind.
> Neither will g-u-p use, unless we teach it about HWPOISON and other fun
> beasts...  Looks like we want that thing to be a separate primitive; for
> btrfs I'd probably replace fault_in_pages_writeable() with clear_user()
> as a quick fix for now...
> 
> Comments?

Wait a sec...  Wasn't HWPOISON a per-page thing?  arm64 definitely does have
smaller-than-page areas with different permissions, so btrfs search_ioctl()
has a problem there, but arch/x86/kernel/fpu/signal.c doesn't have to deal
with that...

Sigh...  I really need more coffee...
