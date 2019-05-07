Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43416CF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 23:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfEGVO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 17:14:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52552 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfEGVO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 17:14:59 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hO7QM-0001Hp-IN; Tue, 07 May 2019 21:14:54 +0000
Date:   Tue, 7 May 2019 22:14:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     yangerkun <yangerkun@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        yi.zhang@huawei.com, houtao1@huawei.com, miaoxie@huawei.com
Subject: Re: system panic while dentry reference count overflow
Message-ID: <20190507211454.GO23075@ZenIV.linux.org.uk>
References: <af9a8dec-98a2-896f-448b-04ded0af95f0@huawei.com>
 <20190507004046.GE23075@ZenIV.linux.org.uk>
 <CAHk-=wjjK16yyug_5-xjPjXniE_T9tzQwxW45JJOHb=ho9kqrA@mail.gmail.com>
 <20190507041552.GH23075@ZenIV.linux.org.uk>
 <CAHk-=wiQ-SdFKP_7TpM3qzNR85S8mxhpzMG0U-H-t4+KRiP35g@mail.gmail.com>
 <20190507191613.GI23075@ZenIV.linux.org.uk>
 <CAHk-=whbaKc+5HvXypMTrS9qGzL=QCuY9U_27Yo8=bHC6BpDsg@mail.gmail.com>
 <20190507195503.GJ23075@ZenIV.linux.org.uk>
 <CAHk-=whj-JPwYzmn6tCJHV219Z4nOPrNCYJr04DyCzoNZb79AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whj-JPwYzmn6tCJHV219Z4nOPrNCYJr04DyCzoNZb79AQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 07, 2019 at 01:47:31PM -0700, Linus Torvalds wrote:
> On Tue, May 7, 2019 at 12:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >
> >         Provided that lockref.c is updated accordingly (look at e.g.
> > lockref_get_not_zero()).
> 
> Yeah, we should likely just make this all a lockref feature.
> 
> The dcache is *almost* the only user of lockrefs. We've got them in
> gfs2 too, but that looks like it would be perfectly happy with the
> same model.
> 
> >         lockref_get_not_zero() hitting dead dentry is not abnormal,
> > so we'd better not complain in such case...  BTW, wouldn't that WARN_ON()
> > in dget() belong in lockref_get()?
> 
> Yeah.

	OK...  Lockref parts aside, I suspect that the right sequence
would be
	* make d_alloc() and d_alloc_cursor() check for excessive
growth of parent's refcount and fail if it's about to occur.  That will
result in -ENOMEM for now, if we want another errno value, we can
follow with making d_alloc() return ERR_PTR() on failure (instead of
NULL)
	* lift the increment of new parent's refcount into the
callers of __d_move(..., false)
	* make the callers in d_splice_alias() fail if refcount is
about to overflow
	* add a reference-consuming variant of d_move()
	* switch d_move() callers to that one by one, lifting
the refcount increment into those, with bailout on overflow
	* make complete_walk() check for overflow, bail out
if it happens.
	* ditto for clone_mnt().

That would take care of the majority of long-term references; then
we'll see what's left...
