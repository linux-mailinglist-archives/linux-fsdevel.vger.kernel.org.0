Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561BE3F9FD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 21:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhH0TTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 15:19:20 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:42758 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhH0TTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:19:19 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJhKn-00GZbg-UX; Fri, 27 Aug 2021 19:16:13 +0000
Date:   Fri, 27 Aug 2021 19:16:13 +0000
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
Subject: Re: [PATCH v7 04/19] iov_iter: Turn iov_iter_fault_in_readable into
 fault_in_iov_iter_readable
Message-ID: <YSk5/ebFimHTmIYn@zeniv-ca.linux.org.uk>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-5-agruenba@redhat.com>
 <YSk0pAWx7xO/39A6@zeniv-ca.linux.org.uk>
 <CAHk-=wj8Q6PtnQqamACJU1TWpT4+nr2+YGhVwMTuU=-NJEm5Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj8Q6PtnQqamACJU1TWpT4+nr2+YGhVwMTuU=-NJEm5Rg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 11:57:19AM -0700, Linus Torvalds wrote:
> On Fri, Aug 27, 2021 at 11:53 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > I really disagree with these calling conventions.  "Number not faulted in"
> > is bloody useless
> 
> It's what we already have for copy_to/from_user(), so it's actually
> consistent with that.

After copy_to/copy_from you've got the data copied and it's not going
anywhere.  After fault-in you still have to copy, and it still can give
you less data than fault-in had succeeded for.  So you must handle short
copies separately, no matter how much you've got from fault-in.

> And it avoids changing all the existing tests where people really
> cared only about the "everything ok" case.

The thing is, the checks tend to be wrong.  We can't rely upon the full
fault-in to expect the full copy-in/copy-out, so the checks downstream
are impossible to avoid anyway.  And fault-in failure is always a slow
path, so we are not saving time here.

And for the memory poisoining we end up aborting a copy potentially
a lot earlier than we should.

> Andreas' first patch did that changed version, and was ugly as hell.
> 
> But if you have a version that avoids the ugliness...

I'll need to dig my notes out...
