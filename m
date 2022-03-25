Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94CF4E6FAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 09:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355983AbiCYI4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 04:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354281AbiCYI4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:56:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7755F44A2D;
        Fri, 25 Mar 2022 01:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 391C8B824E8;
        Fri, 25 Mar 2022 08:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD4CC340E9;
        Fri, 25 Mar 2022 08:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648198464;
        bh=9hytOMtTOBnafBj5UxposoR8sC86nfCae0S2BSIC3hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wNUhdvTywTFzC542loW+OvSYeepuTylRZfUgMu8VlO4ChLnSkGn6gkQo/+C8uCDPB
         TtEavdYBU4LpEwsdAhQpYf0Rmw7I7K9YXr62HghI3C87sh1sQCXrbmt9HG9UhWGLwR
         t/u9tGCkenb16ERR3bQm1rCaAFCPSf6W2F74R9QY=
Date:   Fri, 25 Mar 2022 09:54:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Theodore Ts'o <tytso@mit.edu>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <Yj2DPRusMAzV/N5U@kroah.com>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
 <YjudB7XARLlRtBiR@mit.edu>
 <CAJfpegtiRx6jRFUuPeXDxwJpBhYn0ekKkwYbGowUehGZkqVmAw@mail.gmail.com>
 <20220325084646.7g6oto2ce3vou54x@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325084646.7g6oto2ce3vou54x@ws.net.home>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 09:46:46AM +0100, Karel Zak wrote:
> On Thu, Mar 24, 2022 at 09:44:38AM +0100, Miklos Szeredi wrote:
> > > If so, have you benchmarked lsof using this new interface?
> > 
> > Not yet.  Looked yesterday at both lsof and procps source code, and
> > both are pretty complex and not easy to plug in a new interface.   But
> > I've not yet given up...
> 
> I can imagine something like getvalues(2) in lsblk (based on /sys) or
> in lsfd (based on /proc; lsof replacement). The tools have defined set
> of information to read from kernel, so gather all the requests to the
> one syscall for each process or block device makes sense and it will
> dramatically reduce number of open+read+close syscalls.

And do those open+read+close syscalls actually show up in measurements?

Again, I tried to find a real-world application that turning those 3
into 1 would matter, and I couldn't.  procps had no decreased system
load that I could notice.  I'll mess with lsof but that's really just a
stress-test, not anything that is run all the time, right?

And as others have said, using io_uring() would also solve the 3 syscall
issue, but no one seems to want to convert these tools to use that,
which implies that it's not really an issue for anyone :)

thanks,

greg k-h
