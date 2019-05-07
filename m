Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50FB16BC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 21:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEGTzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 15:55:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51248 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfEGTzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 15:55:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hO6B5-0006uV-Gs; Tue, 07 May 2019 19:55:03 +0000
Date:   Tue, 7 May 2019 20:55:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     yangerkun <yangerkun@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        yi.zhang@huawei.com, houtao1@huawei.com, miaoxie@huawei.com
Subject: Re: system panic while dentry reference count overflow
Message-ID: <20190507195503.GJ23075@ZenIV.linux.org.uk>
References: <af9a8dec-98a2-896f-448b-04ded0af95f0@huawei.com>
 <20190507004046.GE23075@ZenIV.linux.org.uk>
 <CAHk-=wjjK16yyug_5-xjPjXniE_T9tzQwxW45JJOHb=ho9kqrA@mail.gmail.com>
 <20190507041552.GH23075@ZenIV.linux.org.uk>
 <CAHk-=wiQ-SdFKP_7TpM3qzNR85S8mxhpzMG0U-H-t4+KRiP35g@mail.gmail.com>
 <20190507191613.GI23075@ZenIV.linux.org.uk>
 <CAHk-=whbaKc+5HvXypMTrS9qGzL=QCuY9U_27Yo8=bHC6BpDsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whbaKc+5HvXypMTrS9qGzL=QCuY9U_27Yo8=bHC6BpDsg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 07, 2019 at 12:23:23PM -0700, Linus Torvalds wrote:
> On Tue, May 7, 2019 at 12:16 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Negative ->d_lockref.count are used for "lockref is dead"...
> 
> We can change that to just -1, can't we? It's equally easy to test for.

	Provided that lockref.c is updated accordingly (look at e.g.
lockref_get_not_zero()).

> Those aren't supposed to be incremented anyway, which is the whole point.
> 
> But we could do what the page refs also did: consider refcounts in the
> "small negative range" to be very special, because they are either
> critically close to an overflow, or they are actually a sign of a
> fatal underflow due to some bug. And make one of those be the dead
> marker.

	lockref_get_not_zero() hitting dead dentry is not abnormal,
so we'd better not complain in such case...  BTW, wouldn't that WARN_ON()
in dget() belong in lockref_get()?
