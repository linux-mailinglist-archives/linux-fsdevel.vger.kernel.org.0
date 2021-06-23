Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDFD3B1C23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhFWOOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 10:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhFWOOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:14:31 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38FAC061574;
        Wed, 23 Jun 2021 07:12:13 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 0FA6BE8094B;
        Wed, 23 Jun 2021 16:12:12 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id B4131160DC0; Wed, 23 Jun 2021 16:12:11 +0200 (CEST)
Date:   Wed, 23 Jun 2021 16:12:11 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 1/6] block: add disk sequence number
Message-ID: <YNNBOyUiztf2wxDu@gardel-login>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-2-mcroce@linux.microsoft.com>
 <YNMffBWvs/Fz2ptK@infradead.org>
 <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
 <YNM8T44v5FTViVWM@gardel-login>
 <3be63d9f-d8eb-7657-86dc-8d57187e5940@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3be63d9f-d8eb-7657-86dc-8d57187e5940@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mi, 23.06.21 16:01, Hannes Reinecke (hare@suse.de) wrote:

> > Thus: a global instead of local sequence number counter is absolutely
> > *key* for the problem this is supposed to solve
> >
> Well ... except that you'll need to keep track of the numbers (otherwise you
> wouldn't know if the numbers changed, right?).
> And if you keep track of the numbers you probably will have to implement an
> uevent listener to get the events in time.

Hmm? This is backwards. The goal here is to be able to safely match up
uevents to specific uses of a block device, given that block device
names are agressively recycled.

you imply it was easy to know which device use a uevent belongs
to. But that's the problem: it is not possible to do so safely. if i
see a uevent for a block device "loop0" I cannot tell if it was from
my own use of the device or for some previous user of it.

And that's what we'd like to see fixed: i.e. we query the block device
for the seqeno now used and then we can use that to filter the uevents
and ignore the ones that do not carry the same sequence number as we
got assigned for our user.

Lennart

--
Lennart Poettering, Berlin
