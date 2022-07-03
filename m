Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E555564786
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 15:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiGCNap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 09:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCNao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:30:44 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777F863DC
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Jul 2022 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=TwGXx+r3+9ZCR7/02cY8pYnDGmveOvfix0E0wLTE2v4=; b=w0wOBR3pZgYLCZgqnQUAZI8UQj
        3RZJKmx90Nev01yl5SnE+1Tx1GLSr2qpPPZJMe31W4NB/WtXjfl1Sm8TRmoNEHTmXGLnNwqLQyj4C
        FgAOiF39hbmg4q4xiRB/p1hTXaOmakTOl3kqOcuAaawdv1sub5M1RFJx3b/1L5Mzn7GzAqhmKPYCL
        TpJ3LDPF85dKk35vvKPUNC/dy6luY1txbHxtNoQNDpYKCHY8QME5zsA8Jlc3TqQoPuXm2jyUd2YcZ
        Rae92y1eo2yQR0+npJkdpLO4jTuSXCqAbKtj3CANbAzL6Uzz/CT++XmKCbD4ZSzP0sffWC01VA3GF
        QSUlETPxPuM6orIVdGgXSBTfLEn0/bdrt9L41oTfcPUnHHCWfSbOt2NgN2Mq7VA6Yz9jpt9Cf20T3
        213lGlWgXdGAmMVDFfn3s0O8LwQyRLAUoUQL10bB6EckZR/gDKRNUshk3WMgSof/38RMq3i85ompv
        62ZvbvSpAuvpuguxEyMFakh8zrSW8li6ttuvxXRIiRjSeN/2LndgJFNGwMX78xVJcH0D6M15MDkzO
        BaUMM5Eb3CN48trPtgvUHMPj9yXGYO0GuFIF+MZneG8Kz73+p/Ph7Pur6N8r9o7jBhKOJVtxqRBCc
        4PcRe6qx6o/fTuUb/8QImk99aCNkwe1pWiMAEQr0A=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 01/44] 9p: handling Rerror without copy_from_iter_full()
Date:   Sun, 03 Jul 2022 15:30:38 +0200
Message-ID: <14408937.dLXoRf4GRQ@silver>
In-Reply-To: <Yr9gVtOKPiDR/IP6@codewreck.org>
References: <YrKWRCOOWXPHRCKg@ZenIV> <6628265.VPEUYjqhpI@silver>
 <Yr9gVtOKPiDR/IP6@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Freitag, 1. Juli 2022 23:00:06 CEST Dominique Martinet wrote:
> Christian Schoenebeck wrote on Fri, Jul 01, 2022 at 06:02:31PM +0200:
> > > I also tried 9p2000.u for principle and ... I have no idea if this works
> > > but it didn't seem to blow up there at least.
> > > The problem is that 9p2000.u just doesn't work well even without these
> > > patches, so I still stand by what I said about 9p2000.u and virtio (zc
> > > interface): we really can (and I think should) just say virtio doesn't
> > > support 9p2000.u.
> > > (and could then further simplify this)
> > > 
> > > If you're curious, 9p2000.u hangs without your patch on at least two
> > > different code paths (trying to read a huge buffer aborts sending a
> > > reply because msize is too small instead of clamping it, that one has a
> > > qemu warning message; but there are others ops like copyrange that just
> > > fail silently and I didn't investigate)
> > 
> > Last time I tested 9p2000.u was with the "remove msize limit" (WIP)
> > patches:
> > https://lore.kernel.org/all/cover.1640870037.git.linux_oss@crudebyte.com/
> > Where I did not observe any issue with 9p2000.u.
> > 
> > What msize are we talking about, or can you tell a way to reproduce?
> 
> I just ran fsstress on a
> `mount -t 9p -o cache=none,trans=virtio,version=9p2000.u` mount on
> v5.19-rc2:
> 
> fsstress -d /mnt/fstress -n 1000 -v
> 
> If that doesn't reproduce for you (and you care) I can turn some more
> logs on, but from the look of it it could very well be msize related, I
> just didn't check as I don't expect any real user

Confirmed. :/ I tested with various kernel versions (also w/wo "remove msize 
limit" WIP patches), different combinations of msize and cache options. They 
all start to hang the fsstress app with 9p2000.u protocol version, sometimes 
sooner, sometimes later.

BTW, fsstress does not pass with 9p2000.L here either, it would not hang, but 
it consistently terminates fsstress with (cache=none|mmap):

    posix_memalign: Invalid argument

@Greg: JFYI

Best regards,
Christian Schoenebeck


