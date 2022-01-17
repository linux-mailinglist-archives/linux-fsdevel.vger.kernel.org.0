Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3317490FBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 18:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbiAQRhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 12:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbiAQRg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:36:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278C7C06161C;
        Mon, 17 Jan 2022 09:36:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9893B81055;
        Mon, 17 Jan 2022 17:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9530DC36AE7;
        Mon, 17 Jan 2022 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642441015;
        bh=UzJhQ0AKfaTOBAIKVFEkFv4qjL1yQovrHGMFvlWtiSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzFg1p7KQSLRjAvAvEX47s6FXHk6GCMvsdDJm6whcQFjL9CSqvbM2kxWoPUKZWWdP
         ZTmlcxncM71us6hP7im+f5nVW6aOhsd51C5zmjUmuocKLYRuYfVQ2Cs23SREP84i4r
         MG54olTlPugZ73zm5Q4Hi6XMdG3PIzhMEbfCpx17TTB5bILrdnJMPXDrQTbV8tznr2
         2PWyakt/uO3PsaoJE/A326e3vJuj9L8g4aKahsFA5NJXdYvO/HJYOabpF8tj+Pp4pO
         NpJErxbnOtMZd1rFxJkiAb25WKV9h3az1/4iGyOhbF7cpgFMlL+7FKhfdOQw1UyHzM
         HOzvy0npta+Zg==
Date:   Mon, 17 Jan 2022 09:36:55 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Cc:     "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220117173655.GA13563@magnolia>
References: <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <0996c40657b5873dda5119344bf74556491e27b9.camel@hammerspace.com>
 <c9d9b7850c6086b123b4add4de7b1992cb62f6ad.camel@hammerspace.com>
 <20220105224829.GO945095@dread.disaster.area>
 <28e975e8235a41c529bccb2bc0e73b4bb2d1e45e.camel@hammerspace.com>
 <20220110233746.GB945095@dread.disaster.area>
 <ac3d6ea486e9992fe38bc76426070b38d712e44a.camel@hammerspace.com>
 <47240d293a6ce4d0119563989cba42f46dcaa4e3.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47240d293a6ce4d0119563989cba42f46dcaa4e3.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 05:24:50PM +0000, Trond Myklebust wrote:
> Hi Dave & Brian,
> 
> On Thu, 2022-01-13 at 12:01 -0500, Trond Myklebust wrote:
> > 
> > Yesterday I figured out a testing issue that was causing confusion
> > among the people doing the actual testing. They were seeing hangs,
> > which were not soft lockups, and which turned out to be artifacts of
> > the testing methodology.
> > 
> > With this patch, it appears that we are not reproducing the soft
> > lockups.
> > 
> 
> What are the next steps you need from me at this point?

Can someone (Dave?) please re-send whatever the latest version of the
fixpatch is to the list as a new thread?  With Tested-by tags, etc.?
Once that's done I'll push it to for-next as a 5.17 bugfix.

(/me is on vacation today; see you all tomorrow.)

--D

> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
