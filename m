Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80AA33C799
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 21:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhCOUTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 16:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbhCOUSy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:18:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B5C06174A;
        Mon, 15 Mar 2021 13:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UW3UTD4AhKTrj1fB4wgUfBKoKLloAvTw+EnFzkAK904=; b=voXbyzKWfsQUUAwFzMchcMoBGF
        V5v6vsHGLN8Y1wE803Q/UAnvZNUtxpG+l7lfOLU3lsoEOfFCbDVYWJpXc4F3PyaNaw9WK7lukIry8
        hobRGysYs6WdS4yWX4HZFgZQf2Mqh3F81b14BJrqsm4iCbbz4G1fOlsCpYJWIx/1/inWVY6UidUmL
        FccCt+aJeQE3wNGLh6c0NBG4EZeWpLHuMr6KNYTIkZLYIVj2Gp4aYpFriSkqxXo2+aQdUbo0wNsgJ
        Mi7Y/jOudBFOiuHzLh+UBX0U8DtLgtFpC4ALrD3udL7bq5b45TcRKmH4kwN96OCbPIx25B8Xrg6GJ
        7Goi/8dQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLtfU-000iKd-KA; Mon, 15 Mar 2021 20:18:33 +0000
Date:   Mon, 15 Mar 2021 20:18:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH -next 1/5] block: add disk sequence number
Message-ID: <20210315201824.GB2577561@casper.infradead.org>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-2-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315200242.67355-2-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 09:02:38PM +0100, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Add a sequence number to the disk devices. This number is put in the
> uevent so userspace can correlate events when a driver reuses a device,
> like the loop one.

Should this be documented as monotonically increasing?  I think this
is actually a media identifier.  Consider (if you will) a floppy disc.
Back when such things were common, it was possible with personal computers
of the era to have multiple floppy discs "in play" and be prompted to
insert them as needed.  So shouldn't it be possible to support something
similar here -- you're really removing the media from the loop device.
With a monotonically increasing number, you're always destroying the
media when you remove it, but in principle, it should be possible to
reinsert the same media and have the same media identifier number.
