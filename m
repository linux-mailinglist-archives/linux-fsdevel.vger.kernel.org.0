Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D431216B04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 21:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfEGTQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 15:16:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50786 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGTQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 15:16:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hO5ZV-0005QU-LQ; Tue, 07 May 2019 19:16:13 +0000
Date:   Tue, 7 May 2019 20:16:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     yangerkun <yangerkun@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        yi.zhang@huawei.com, houtao1@huawei.com, miaoxie@huawei.com
Subject: Re: system panic while dentry reference count overflow
Message-ID: <20190507191613.GI23075@ZenIV.linux.org.uk>
References: <af9a8dec-98a2-896f-448b-04ded0af95f0@huawei.com>
 <20190507004046.GE23075@ZenIV.linux.org.uk>
 <CAHk-=wjjK16yyug_5-xjPjXniE_T9tzQwxW45JJOHb=ho9kqrA@mail.gmail.com>
 <20190507041552.GH23075@ZenIV.linux.org.uk>
 <CAHk-=wiQ-SdFKP_7TpM3qzNR85S8mxhpzMG0U-H-t4+KRiP35g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiQ-SdFKP_7TpM3qzNR85S8mxhpzMG0U-H-t4+KRiP35g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 07, 2019 at 08:26:06AM -0700, Linus Torvalds wrote:
> On Mon, May 6, 2019 at 9:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Umm...  Where would you put the cutoff for try_dget()?  1G?  Because
> > 2G-<something relatively small> is risky - have it reached, then
> > get the rest of the way to 2G by normal dget() and you've got trouble.
> 
> I'd make the limit be 2G exactly like the page count. Negative counts
> are fine - they work exactly like large integers. It's only 0 that is
> special.

Negative ->d_lockref.count are used for "lockref is dead"...

>  - add the "limit negative dentries" patches that were already written
> for other reasons by Waiman Long.

Irrelevant here, IMO - negative or not (and evictable or pinned, for that
matter) it's easier solved by having d_alloc() fail on parent's ->d_count
overflow.  And I'm pretty sure we can hit that crap without creating any
negative dentries.
