Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31796AAE23
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 05:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjCEEQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 23:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEEP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 23:15:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC88D53A;
        Sat,  4 Mar 2023 20:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XZbX19UIOBgbhN58Zf8KUMwb/xPxPMAlTovGZ1xqlvs=; b=eoNxFie6n2xBw64ti9CbXcM2xL
        b0tb4yBx1mASTimsEwuaE758mUlXj0hEmnHDU2dj/elmN9DbkLstJgAgR3e+kst9kv3URQWRoDWZE
        06LKnkGW0QhvxRpFo089uUxTUYPnvHkeU1miaROA4/8+TQ98LOjYdY+RFh1Nk3WEbijwDX//YySRx
        B3F/NSY1sBL+YFhewXkzurfqHiYWweaL7i5sYbscaNfolaSTYtBMWrARValsEG1JFsYWICNhoYDQs
        3hBQyhQjoeNEbTfn2xqS6DR0Hsr5adK8swmnzUFy8n2c1bQ8KA/LK42GDzBuPkBO0YNH1aWI6/Fi4
        jh9FtPpQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYfmo-009oHB-LR; Sun, 05 Mar 2023 04:15:50 +0000
Date:   Sat, 4 Mar 2023 20:15:50 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAQXduwAcAtIZHkB@bombadil.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <f68905c5785b355b621847974d620fb59f021a41.camel@HansenPartnership.com>
 <ZAL0ifa66TfMinCh@casper.infradead.org>
 <2600732b9ed0ddabfda5831aff22fd7e4270e3be.camel@HansenPartnership.com>
 <ZAN0JkklyCRIXVo6@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAN0JkklyCRIXVo6@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 04, 2023 at 04:39:02PM +0000, Matthew Wilcox wrote:
> I'm getting more and more
> comfortable with the idea that "Linux doesn't support block sizes >
> PAGE_SIZE on 32-bit machines" is an acceptable answer.

First of all filesystems would need to add support for a larger block
sizes > PAGE_SIZE, and that takes effort. It is also a support question
too.

I think garnering consensus from filesystem developers we don't want
to support block sizes > PAGE_SIZE on 32-bit systems would be a good
thing to review at LSFMM or even on this list. I hightly doubt anyone
is interested in that support.

> XFS already works with arbitrary-order folios. 

But block sizes > PAGE_SIZE is work which is still not merged. It
*can* be with time. That would allow one to muck with larger block
sizes than 4k on x86-64 for instance. Without this, you can't play
ball.

> The only needed piece is
> specifying to the VFS that there's a minimum order for this particular
> inode, and having the VFS honour that everywhere.

Other than the above too, don't we still also need to figure out what
fs APIs would incur larger order folios? And then what about corner cases
with the page cache?

I was hoping some of these nooks and crannies could be explored with tmpfs.

  Luis
