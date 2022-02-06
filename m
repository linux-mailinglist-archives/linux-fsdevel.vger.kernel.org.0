Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D114AAF3C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 13:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiBFMsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 07:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiBFMsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 07:48:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43D5C06173B;
        Sun,  6 Feb 2022 04:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=RaIBDi78Pbwlg/14dg8eVIBaWSDVryrjs6pRfQqJGBE=; b=tReaU9QyNX4d63LHvOr35hR6NB
        VZ3IkQ8SAvdB0JEzZ3gvjbwGFEYUJRhCSlejzSZ1qEqCqG6PgPXIthj7h1l0z0edeVnP0k1tap4Jt
        9cpbVex2Ngzu20mI6rHKEKSZgmCSQWhcqjrRlvGUfbofMqP8LT5lW364wwTXFycaRvc5j6Ebs1AMl
        XvxvSHHCA6JuwUGH40tHz/JHHkQmznuPki1umrIMcAPlqsoCZj50kzkD13qwsgJyt68DQpLbvBbL7
        Rm7Y2FIgfZzCa4ObAXwIkvsq6aTv8yIZZUT+S9jzcvDITjrR8g58T/Tcn3eH/jxdiXxen4aPN9hCp
        C2VeRNuw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGgxd-00E3ht-D0; Sun, 06 Feb 2022 12:48:09 +0000
Date:   Sun, 6 Feb 2022 12:48:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     FMDF <fmdefrancesco@gmail.com>
Cc:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        linux-fsdevel@vger.kernel.org, BTRFS <linux-btrfs@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: How to debug stuck read?
Message-ID: <Yf/DiefrNOkib5mm@casper.infradead.org>
References: <CAOE4rSwfTEaJ_O9Bv1CkLRnLWYoZ7NSS=5pzuQz4mUBE-PXQ5A@mail.gmail.com>
 <YfrX1BVIlIwiVYzs@casper.infradead.org>
 <CAOE4rSz1OTRYQPa4PUrQ-=cwSM3iVY977Uz_d77E2j-kH0G3rA@mail.gmail.com>
 <CAPj211uKvndvR40Vjh9WAf4wRbaV5MSnmUsvDAEAKv3Q+2tDkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPj211uKvndvR40Vjh9WAf4wRbaV5MSnmUsvDAEAKv3Q+2tDkA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 06, 2022 at 12:01:02PM +0100, FMDF wrote:
> On Wed, Feb 2, 2022 at 10:50 PM Dāvis Mosāns <davispuh@gmail.com> wrote:
> >
> > trešd., 2022. g. 2. febr., plkst. 21:13 — lietotājs Matthew Wilcox
> > (<willy@infradead.org>) rakstīja:
> > >
> > > On Wed, Feb 02, 2022 at 07:15:14PM +0200, Dāvis Mosāns wrote:
> > > > I have a corrupted file on BTRFS which has CoW disabled thus no
> > > > checksum. Trying to read this file causes the process to get stuck
> > > > forever. It doesn't return EIO.
> > > >
> > > > How can I find out why it gets stuck?
> > >
> > > > $ cat /proc/3449/stack | ./scripts/decode_stacktrace.sh vmlinux
> > > > folio_wait_bit_common (mm/filemap.c:1314)
> > > > filemap_get_pages (mm/filemap.c:2622)
> > > > filemap_read (mm/filemap.c:2676)
> > > > new_sync_read (fs/read_write.c:401 (discriminator 1))
> > >
> > > folio_wait_bit_common() is where it waits for the page to be unlocked.
> > > Probably the problem is that btrfs isn't unlocking the page on
> > > seeing the error, so you don't get the -EIO returned?
> >
> >
> > Yeah, but how to find where that happens.
> > Anyway by pure luck I found memcpy that wrote outside of allocated
> > memory and fixing that solved this issue but I still don't know how to
> > debug this properly.
> >
> There is no special recipe for debugging "this properly" :)
> 
> You wrote that "by pure luck" you found a memcpy() that wrote beyond the
> limit of allocated memory. I suppose that you found that faulty memcpy()
> somewhere in one of the function listed in the stack trace.

I very much doubt that.  The code flow here is:

userspace calls read() -> VFS -> btrfs -> block layer -> return to btrfs
-> return to VFS, wait for read to complete.  So by the time anyone's
looking at the stack trace, all you can see is the part of the call
chain in the VFS.  There's no way to see where we went in btrfs, nor
in the block layer.  We also can't see from the stack trace what
happened with the interrupt which _should have_ cleared the lock bit
and didn't.

