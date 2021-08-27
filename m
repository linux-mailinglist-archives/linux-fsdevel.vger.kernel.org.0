Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C483FA011
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 21:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhH0TiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 15:38:23 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:43162 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhH0TiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:38:23 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJhfJ-00GZrY-Mi; Fri, 27 Aug 2021 19:37:25 +0000
Date:   Fri, 27 Aug 2021 19:37:25 +0000
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
Message-ID: <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
 <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:33:00PM -0700, Linus Torvalds wrote:
> On Fri, Aug 27, 2021 at 12:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Could you show the cases where "partial copy, so it's OK" behaviour would
> > break anything?
> 
> Absolutely.
> 
> For example, i t would cause an infinite loop in
> restore_fpregs_from_user() if the "buf" argument is a situation where
> the first page is fine, but the next page is not.
> 
> Why? Because __restore_fpregs_from_user() would take a fault, but then
> fault_in_pages_readable() (renamed) would succeed, so you'd just do
> that "retry" forever and ever.
> 
> Probably there are a number of other places too. That was literally
> the *first* place I looked at.

OK...

Let me dig out the notes from the last time I looked through that area
and grep around a bit.  Should be about an hour or two.
