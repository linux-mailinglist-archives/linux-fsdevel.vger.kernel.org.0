Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8516AA42B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 23:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjCCWWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 17:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjCCWVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:21:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C76D6A426;
        Fri,  3 Mar 2023 14:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UjDrE6h6eOtudC1+hnlOXsdAsqR8czaP1R+p5WwwtDk=; b=pOCrpkGaK8v1NjY+j6Np9yYkTa
        tH0uYMWTngwT5EsfGE57b15s/MNB6Zs1YS0Bs04O/Zdir8KasPiemSpaylEpzoPkFht3YDiWbCFQx
        Fi6usWROX0D+0dcvofIHxVMKb3uk1KMVmPuDIWdoNnUOVJkAsZbfAjLcQSZWoXpkfqcPBxFPRF3b0
        /v0gh+56wvgbW0xBtjST4TjUjCSQW+h44HNH0InTO9jFLOUaWXtSWRksEIH+LAvUznqL5jTfi3hIV
        WiQ8qbW5I+5NAB84IBknw+uisiB/67H0Hd2+B7jHffCUGt3hXhYOP4YdsE9OyVzN2JbpOcEP9rw6e
        t+AjjVyw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYDDo-007XSE-I4; Fri, 03 Mar 2023 21:45:48 +0000
Date:   Fri, 3 Mar 2023 13:45:48 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
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

On Fri, Mar 03, 2023 at 03:49:29AM +0000, Matthew Wilcox wrote:
> On Thu, Mar 02, 2023 at 06:58:58PM -0700, Keith Busch wrote:
> > That said, I was hoping you were going to suggest supporting 16k logical block
> > sizes. Not a problem on some arch's, but still problematic when PAGE_SIZE is
> > 4k. :)
> 
> I was hoping Luis was going to propose a session on LBA size > PAGE_SIZE.
> Funnily, while the pressure is coming from the storage vendors, I don't
> think there's any work to be done in the storage layers.  It's purely
> a FS+MM problem.

You'd hope most of it is left to FS + MM, but I'm not yet sure that's
quite it yet. Initial experimentation shows just enabling > PAGE_SIZE
physical & logical block NVMe devices gets brought down to 512 bytes.
That seems odd to say the least. Would changing this be an issue now?

I'm gathering there is generic interest in this topic though. So one
thing we *could* do is perhaps review lay-of-the-land of interest and
break down what we all think are things likely could be done / needed.
At the very least we can come out together knowing the unknowns together.

I started to think about some of these things a while ago and with the
help of Willy I tried to break down some of the items I gathered from him
into community OKRs (super informal itemization of goals and sub tasks which
would complete such goals) and started trying to take a stab at them
with our team, but obviously I think it would be great if we all just
divide & and conquer here. So maybe reviewing these and extending them
as a community would be good:

https://kernelnewbies.org/KernelProjects/large-block-size

I'm recently interested in tmpfs so will be taking a stab at higher
order page size support there to see what blows up.

The other stuff like general IOMAP conversion is pretty well known, and
we already I think have a proposed session on that. But there is also
even smaller fish to fry, like *just* doing a baseline with some
filesystems with 4 KiB block size seems in order.

Hearing filesystem developer's thoughts on support for larger block
size in light of lower order PAGE_SIZE would be good, given one of the
odd situations some distributions / teams find themselves in is trying
to support larger block sizes but with difficult access to higher
PAGE_SIZE systems. Are there ways to simplify this / help us in general?
Without it's a bit hard to muck around with some of this in terms of
support long term. This also got me thinking about ways to try to replicate
larger IO virtual devices a bit better too. While paying a cloud
provider to test this is one nice option, it'd be great if I can just do
this in house with some hacks too. For virtio-blk-pci at least, for instance,
I wondered whether using just the host page cache suffices, or would a 4K
page cache on the host modify say a 16 k emualated io controller results
significantly? How do we most effectively virtualize 16k controllers
in-house?

To help with experimenting with large io and NVMe / virtio-blk-pci I
recented added support to intantiate tons of large IO devices to kdevops
[0], with it it should be easy to reproduce odd issues we may come up
with. For instnace it should be possible to subsequently extend the
kdevops fstests or blktests automation support with just a few Kconfig files
to use some of these largio devices to see what blows up.

If we are going to have this session I'd like to encourage & invite Pankaj and
Daniel who have been doing great work on reviewing all this too and can give
some feedback on some of their own findings!

[0] https://github.com/linux-kdevops/kdevops/commit/af33568445111cc114653264f6dbc8684f3b10e8

  Luis
