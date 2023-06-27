Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC48574068C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 00:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjF0WlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 18:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjF0WlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:41:16 -0400
Received: from out-3.mta0.migadu.com (out-3.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7171D212A
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 15:41:14 -0700 (PDT)
Date:   Tue, 27 Jun 2023 18:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687905672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MCOyXvQH1vh+16AdCtA2h/TxtP+27XdlCYVsV7ar0MU=;
        b=VDeCtPDb5tI6zYim17g3fBoJR+8/KM77xSyFpu0QrP4QfTs2zRgeg3NTd/S7qaxR8WyzXU
        ENlj3ZXqUAxaOQ06BP4+J49aoDt1aTPuJg4xmDZfs/kRklitcaBOU/Y60FoVrw5XQ1TWPs
        aTL5CV2NsP719/+6vCsw0HkK+xXU43I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230627224107.trexy3sanysgzorf@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <ZJtdEgbt+Wa8UHij@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJtdEgbt+Wa8UHij@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 08:05:06AM +1000, Dave Chinner wrote:
> On Tue, Jun 27, 2023 at 04:15:24PM -0400, Kent Overstreet wrote:
> > On Tue, Jun 27, 2023 at 11:16:01AM -0600, Jens Axboe wrote:
> > > On 6/26/23 8:59?PM, Jens Axboe wrote:
> > > > On 6/26/23 8:05?PM, Kent Overstreet wrote:
> > > >> On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
> > > >>> Doesn't reproduce for me with XFS. The above ktest doesn't work for me
> > > >>> either:
> > > >>
> > > >> It just popped for me on xfs, but it took half an hour or so of looping
> > > >> vs. 30 seconds on bcachefs.
> > > > 
> > > > OK, I'll try and leave it running overnight and see if I can get it to
> > > > trigger.
> > > 
> > > I did manage to reproduce it, and also managed to get bcachefs to run
> > > the test. But I had to add:
> > > 
> > > diff --git a/check b/check
> > > index 5f9f1a6bec88..6d74bd4933bd 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -283,7 +283,7 @@ while [ $# -gt 0 ]; do
> > >  	case "$1" in
> > >  	-\? | -h | --help) usage ;;
> > >  
> > > -	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
> > > +	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs|-bcachefs)
> > >  		FSTYP="${1:1}"
> > >  		;;
> > >  	-overlay)
> > 
> > I wonder if this is due to an upstream fstests change I haven't seen
> > yet, I'll have a look.
> 
> Run mkfs.bcachefs on the testdir first. fstests tries to probe the
> filesystem type to test if $FSTYP is not set. If it doesn't find a
> filesystem or it is unsupported, it will use the default (i.e. XFS).
> There should be no reason to need to specify the filesystem type for
> filesystems that blkid recognises. from common/config:

Actually ktest already does that, and it sets $FSTYP as well. Jens, are
you sure you weren't doing something funny?
