Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7998F64F743
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 04:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLQDGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 22:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLQDGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 22:06:08 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E523BFA;
        Fri, 16 Dec 2022 19:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jWtc9HV4mZkcQQqnBoDACVfU97buWMoTCyNNR31hoNA=; b=mGWFtYubZCf15iI7riYCznZTlg
        DMzSV1J/8G/hqclJ5D3XF7KDHCzKaNAkKQJHucyZ0vskCaoeOO0E+T3joXHDJm+a40OGTEHVlhS//
        ogTQCNrBtRRNednyZDK5P5X0Cd+h99iB2DnH6Cs6L2QxDpjX5GFZVwGvm1XGzi33SW/wg1zIBA7sl
        d9lQd6LD6+X6W2Ra1ldh79ltdDV3Tw4s/iPZbS59WS5JvL05fIl3FFQHAgB+lQOSMI3/UxiejZSKB
        AAmPViH17agF4OkT6MIkRWTz1RiZ0qenMh+GKBZNLK+xKmoPe2E+NpEswPzhLDXk/qzLt1HaH9Ri2
        ZQAFtytQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p6NWP-00CMqi-2K;
        Sat, 17 Dec 2022 03:05:57 +0000
Date:   Sat, 17 Dec 2022 03:05:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible deadlock in __ata_sff_interrupt
Message-ID: <Y50yFYjysKQlLWtK@ZenIV>
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
 <Y5s7F/4WKe8BtftB@ZenIV>
 <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com>
 <Y5vo00v2F4zVKeug@ZenIV>
 <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
 <Y50BqT3nSF7+JEzt@ZenIV>
 <Y50FIckzrV9sWlid@boqun-archlinux>
 <CAHk-=wj7FpAXZ0hnPKh-5CG-ZW8BmOhd4tEW+J7ryW26fkcDNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7FpAXZ0hnPKh-5CG-ZW8BmOhd4tEW+J7ryW26fkcDNA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 08:31:54PM -0600, Linus Torvalds wrote:
> Ok, let's bring in Waiman for the rwlock side.
> 
> On Fri, Dec 16, 2022 at 5:54 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Right, for a reader not in_interrupt(), it may be blocked by a random
> > waiting writer because of the fairness, even the lock is currently held
> > by a reader:
> >
> >         CPU 1                   CPU 2           CPU 3
> >         read_lock(&tasklist_lock); // get the lock
> >
> >                                                 write_lock_irq(&tasklist_lock); // wait for the lock
> >
> >                                 read_lock(&tasklist_lock); // cannot get the lock because of the fairness
> 
> But this should be ok - because CPU1 can make progress and eventually
> release the lock.
> 
> So the tasklist_lock use is fine on its own - the reason interrupts
> are special is because an interrupt on CPU 1 taking the lock for
> reading would deadlock otherwise. As long as it happens on another
> CPU, the original CPU should then be able to make progress.
> 
> But the problem here seems to be thst *another* lock is also involved
> (in this case apparently "host->lock", and now if CPU1 and CPU2 get
> these two locks in a different order, you can get an ABBA deadlock.
> 
> And apparently our lockdep machinery doesn't catch that issue, so it
> doesn't get flagged.

Lockdep has actually caught that; the locks involved are mention in the
report (https://marc.info/?l=linux-ide&m=167094379710177&w=2).  The form
of report might have been better, but if anything, it doesn't mention
potential involvement of tasklist_lock writer, turning that into a deadlock.

OTOH, that's more or less implicit for the entire class:

read_lock(A)		[non-interrupt]
			local_irq_disable()	local_irq_disable()
			spin_lock(B)		write_lock(A)
			read_lock(A)
[in interrupt]
spin_lock(B)

is what that sort of reports is about.  In this case A is tasklist_lock,
B is host->lock.  Possible call chains for CPU1 and CPU2 are reported...

I wonder why analogues of that hadn't been reported for other SCSI hosts -
it's a really common pattern there...

> I'm not sure what the lockdep rules for rwlocks are, but maybe lockdep
> treats rwlocks as being _always_ unfair, not knowing about that "it's
> only unfair when it's in interrupt context".
> 
> Maybe we need to always make rwlock unfair? Possibly only for tasklist_lock?

ISTR threads about the possibility of explicit read_lock_unfair()...
