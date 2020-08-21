Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3746C24D5C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 15:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgHUNFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 09:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgHUNFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:05:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09365C061385;
        Fri, 21 Aug 2020 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/frFlWk/DH7UmMNwwzKlH5Kh+sKeUOmfANQte5CZqRw=; b=qQAt4ncNWg2XdtrVsuzWeJNF5E
        R3ocFyZH0LZFQvn2d1ZM0b6OQpWbxO8rKqfkeyFbrDG8AT8Zd0rgqetjCzRMK3ikDiWviFiN4g6K6
        3vk+xTo/vrN5jTwQ5AniTfQisHA7dKEWc4FFhSlxjEA5/dHIInmA0fknQwBW1cn870uq9DU//1KeT
        SmGICfk/UDZ40Nc1NlSmeU+w9YprzKKDecp5eoyDo6M5HczQOHG9IgMHEqLiiStPkf1tosTleslTS
        pp/BefGKDT6dKzH7Jc5mNuIrbAWU8pVODLdCBcxLyrHdvw2gzrAO0GUJhXjA4xso0mnnGb4JMfYN5
        hLdH9MvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k96jS-0004Fr-Ef; Fri, 21 Aug 2020 13:05:23 +0000
Date:   Fri, 21 Aug 2020 14:05:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Yu Kuai <yukuai3@huawei.com>, david@fromorbit.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [RFC PATCH V2] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200821130522.GS17456@casper.infradead.org>
References: <20200818134618.2345884-1-yukuai3@huawei.com>
 <20200818155305.GR17456@casper.infradead.org>
 <20200818161229.GK6107@magnolia>
 <20200818165019.GT17456@casper.infradead.org>
 <20200821061019.GD31091@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821061019.GD31091@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 07:10:19AM +0100, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 05:50:19PM +0100, Matthew Wilcox wrote:
> > Looks like Christoph changed his mind sometime between that message
> > and the first commit: 9dc55f1389f9569acf9659e58dd836a9c70df217
> 
> No, as Darrick pointed out it was all about the header dependency.
> 
> > My THP patches convert the bit array to be per-block rather than
> > per-sector, so this is all going to go away soon ;-)
> 
> I've asked a while ago, but let me repeat:  Can you split out all the
> useful iomap bits that are not directly dependent on the new THP
> infrastructure and send them out ASAP?  I'd like to pre-load this
> work at least a merge window before the actual THP bits.

I've been working on that the past couple of days.  As always when
reviewing a patch series, I find things that need to be done differently.
And spot bugs (one pre-existing, one that I introduced).

You may not have noticed; I've sent out a couple of patch series to
linux-mm already this week:

https://lore.kernel.org/linux-mm/20200819150555.31669-1-willy@infradead.org/
https://lore.kernel.org/linux-mm/20200819184850.24779-1-willy@infradead.org/

plus this to linux-block:
https://lore.kernel.org/linux-block/20200817195206.15172-1-willy@infradead.org/

this patch series inadvertently breaks DAX and I need to debug that:
https://lore.kernel.org/linux-mm/20200804161755.10100-1-willy@infradead.org/

i also need to figure out what breaks for Hugh here (I may already have
fixed it, but I need to do more testing):
https://lore.kernel.org/linux-mm/20200629152033.16175-1-willy@infradead.org/

So the iomap chunks are next, and then I have another mm series in mind.
After all that is done, I'll have almost all the prep work merged for
5.10 and we can do the actual THP patchset in 5.11.  I'm sitting on
around 80 patches at this point although it varies from day to day
depending how I resplit things.
