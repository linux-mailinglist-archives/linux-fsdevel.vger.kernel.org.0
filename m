Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A4A3FD646
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 11:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbhIAJOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbhIAJOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:14:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D5AC061575;
        Wed,  1 Sep 2021 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kkri7tT4fIBDPfIQhCUKK7u4nuQgtfBcg/qedosEIiw=; b=eG14zmp6Kro2k7a7jO1uyoWiU+
        n8Cw/wj2cIFmXIqZZV0e56pLJ8hCGxMEz1F6P6Y9uSwXhT/xhlPG60ppbnfn9BN4lJkyObTdtsyYK
        LmrSYhIhJTzsf7m8ryNIQZbO8xrIFPAYw+zgb10xMkiHCW+xn6i4/fuYNqQOzBEewR/dMNKnfrO0F
        uSY5nBB7K64btU/rKlHuVn2+FAUxPGjruNVVuF5PIj8G3rF2qsmwxrmEeEkk5COYdJr3kAyWrZc19
        rgxJmZQbblDO5wmBRzlIVQ77I7SUnbtv2Tr8vZRKvxh/+q2BkfpQREUQFlPINsxK+QlfAbhvTWuwP
        5zNGXJnA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLMHo-00256D-3O; Wed, 01 Sep 2021 09:12:15 +0000
Date:   Wed, 1 Sep 2021 10:12:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] namei: Fix use after free in kern_path_locked
Message-ID: <YS9D4AlEsaCxLFV0@infradead.org>
References: <20210901001341.79887-1-stephen.s.brennan@oracle.com>
 <CAOKbgA49wFL3+-QAQ+DEnNVzCjYcN0qmnVHGo1x=eXeyzNxvsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOKbgA49wFL3+-QAQ+DEnNVzCjYcN0qmnVHGo1x=eXeyzNxvsw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 01, 2021 at 02:35:08PM +0700, Dmitry Kadashev wrote:
> On Wed, Sep 1, 2021 at 7:13 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
> >
> > In 0ee50b47532a ("namei: change filename_parentat() calling
> > conventions"), filename_parentat() was made to always put the struct
> > filename before returning, and kern_path_locked() was migrated to this
> > calling convention. However, kern_path_locked() uses the "last"
> > parameter to lookup and potentially create a new dentry. The last
> > parameter contains the last component of the path and points within the
> > filename, which was recently freed at the end of filename_parentat().
> > Thus, when kern_path_locked() calls __lookup_hash(), it is using the
> > filename after it has already been freed.
> >
> > To avoid this, switch back to __filename_parentat() and place a putname
> > at the end of the function, once all uses are completed.
> 
> Ouch. Thanks for taking care of this, Stephen. I guess
> filename_parentat() should be killed, since kern_path_locked() was the
> only place it's used in and it always results in danging "last",
> provoking bugs just like this one. I can send a patch on top of this if
> you prefer.

Yes.  And then rename __filename_parentat to filename_parentat, please.
