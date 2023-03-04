Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E336AAC08
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 20:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCDTE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 14:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDTE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:04:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CF91714C;
        Sat,  4 Mar 2023 11:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gk7SjEpw3fRez1WAUe0E4mRcDbNV5fQmNUi1Uz2ZLys=; b=xdenxezCvtxLJClr279s1BNnLa
        caKlctrkgiAqM8+dwFbBO4LJgVrzN+uMtwNZEthCmLFh9iScomz7ueJIMNwjJpKCD97422QoVQ8a/
        KMhGmsKe/pdBdYS00M7nH1GBRsAOAQ/MAR+kToApg9A5WShYE72nt+bgN8tteZKYXmgHcyA0Us3lk
        Wc6XrsH8oe4rRPEW4ZdOCHo1/xnGes8OAWrZ726juNhPcTbIoVfUzBBp/LHAXVsDE0cuH/fXiB30O
        9SE7DkGGgxY1aVG/B5+N22V2c765XW07NfJJlPVrId7wab0qzYRwjBSF10ZDyhMRGplHgm50AiFuo
        7a9l+nIw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYXB7-009R33-28; Sat, 04 Mar 2023 19:04:21 +0000
Date:   Sat, 4 Mar 2023 11:04:21 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAOWNck7YLae02bQ@bombadil.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <f68905c5785b355b621847974d620fb59f021a41.camel@HansenPartnership.com>
 <ZAL0ifa66TfMinCh@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAL0ifa66TfMinCh@casper.infradead.org>
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

On Sat, Mar 04, 2023 at 07:34:33AM +0000, Matthew Wilcox wrote:
> The hard part is plugging your ears to the screams of the MM people
> who are convinced that fragmentation will make it impossible to mount
> your filesystem.

One doesn't just need to plug your ears, one can also be prepared for that,
should that actually end up being true, because frankly we don't have
the evidence yet. And it's something I have slowly started to think about --
because -- why not be ready?

In fact let's say the inverse is true, having the tooling to proove them
wrong is also a desirable outcome and that begs the question of proper
tooling to measure this, etc. Something probably more for an MM track.
What would satifsy proof and what tooling / metrics used?

It is *not* something that only is implicated by storage IO controllers
and so what we're looking at a generic device issue / concern for memory
fragmentation.

*If* the generalization of huge page uses for something like bpf-prog-pack ends
up materializing and we end up using it for even *all* module .text,
*then* I *think* it something similar be a way to address that concern
for devices with huge pages for CMA. This is one area where I think
device hints for large IO might come in handy, we can limit such
dedicated pools to only devices with hints and limit the amount of huge
pages used for this purpose.

But ask me 2 kernel releases from now again.

  Luis
