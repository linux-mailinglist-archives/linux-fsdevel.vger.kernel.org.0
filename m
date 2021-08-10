Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490343E8516
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhHJVTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:19:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46010 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbhHJVTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:19:03 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628630319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6HvQmuAr7zH8MRjkD0GpzlB1BXRdBBbNp7feKrK3i+U=;
        b=hOzvYeGsi0KBYeat3TbMXKfpVjhUQPZ0eVcYjCW2NyjygELL7lLoL9IQp9IftaCHXCip3i
        GIjgyHRumkpaONHfD+TKNmOlYLUeYLGGEw8FFyAcAFq+aUTAWIAIeIwNH2/aI2dVJS9+zp
        t7Gf/v1aqTTFnWpQvZVMwQjXX5Wje3oCuaRtdnNy3z6uy8mLapsmMLiVv9R6mxOa8k0ZBu
        N3umWNQXi4xX/L1XFrnFNGSogAWkLkkrz5KDqCRfnOOIoFcfGYUyLtuFUJZkWSFnvkxl7+
        pFhpGKaYzZNkrp17B6yxAGOA5quZyEWhCwGO2bEd0750OCJgp9nUfvQWpdiYfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628630319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6HvQmuAr7zH8MRjkD0GpzlB1BXRdBBbNp7feKrK3i+U=;
        b=feDyEsBeq6VikFaGcfDfIUhKH6CHLmS+nXHbyAEWCtD30w2Lcl/ICDaJKbz3KfyhOGDGpv
        AZ+zgQ8NSvUi/KAg==
To:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] iomap: Use kmap_local_page instead of kmap_atomic
In-Reply-To: <YQws3DQyk6pnyiBY@casper.infradead.org>
References: <20210803193134.1198733-1-willy@infradead.org>
 <20210805173104.GF3601405@magnolia> <20210805173903.GH3601405@magnolia>
 <YQws3DQyk6pnyiBY@casper.infradead.org>
Date:   Tue, 10 Aug 2021 23:18:38 +0200
Message-ID: <87mtppov69.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05 2021 at 19:24, Matthew Wilcox wrote:
> On Thu, Aug 05, 2021 at 10:39:03AM -0700, Darrick J. Wong wrote:
>> Though now that I think about it: Why does iomap_write_actor still use
>> copy_page_from_iter_atomic?  Can that be converted to use regular
>> copy_page_from_iter, which at least sometimes uses kmap_local_page?
>
> I suspect copy_page_from_iter_atomic() should be converted to use
> kmap_local_page(), but I don't know.  generic_perform_write() uses
> the _atomic() version, so I'm not doing anything different without
> understanding more than I currently do.

Most of the kmap_atomic() usage can be converted to kmap_local(). There
are only a few usage sites which really depend on the implicit preempt
disable.

The reason why we cannot convert the bulk blindly is that quite some
usage sites have user memory access nested inside. As kmap_atomic()
disables preemption and page faults the error handling needs to be
outside the atomic section, i.e. after kunmap_atomic(). So if you
convert that you have to get rid of that extra error handling and just
use the regular user memory accessors.

IIRC there are a few places which really want pagefaults disabled, but
those do not necessarily need preemption disabled. So they need to be
converted to kmap_local(); pagefault_disable(); err = dostuff(); ....

Hope that helps.

Thanks

        tglx
