Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57132469B7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 16:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355915AbhLFPRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 10:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhLFPOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:14:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4911BC0698D2;
        Mon,  6 Dec 2021 07:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P8flnxbDbRp/vjwV/XpA+loIO7KGjb+X0sFwYxA/k8o=; b=vL4v+ndrovrS3GlbOyXK5czqaH
        T6Ot5n0PgzcpkLebnz7bwldy9jtogHha+Tgqn4J0ttbjVBOr0ER5XQri+qwFD6vAp8gBnuou8DDbH
        IwhFUSIuf6rMnmpjesnEjDaKntjSATzqiU+5LUeMhQN/zY/XCSu3APAobdge+98xFVNsADNkpMLqv
        0z9JEKiXALQ21X2/Uv2PGO/DM3RMzLiZB4wsH6kQzfpJyfmTQobaaK0vTAwCoZM2Ft8ZaA3kdKgel
        exph75VblHn7IR9JmH7gAXiehItv3Up2jZx9nMyE3zBjk1VVF9Fg1Hn6IJR67Yb8k7KJdB9H2RQQL
        sL4HYpgw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muFaF-004zQZ-2o; Mon, 06 Dec 2021 15:07:15 +0000
Date:   Mon, 6 Dec 2021 15:07:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 01/14] fs/proc/vmcore: Update read_from_oldmem() for
 user pointer
Message-ID: <Ya4nI7ly15pJA5xp@casper.infradead.org>
References: <20211203104231.17597-1-amit.kachhap@arm.com>
 <20211203104231.17597-2-amit.kachhap@arm.com>
 <20211206140451.GA4936@lst.de>
 <Ya4bdB0UBJCZhUSo@casper.infradead.org>
 <20211206145422.GA8794@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206145422.GA8794@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:54:22PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 06, 2021 at 02:17:24PM +0000, Matthew Wilcox wrote:
> > On Mon, Dec 06, 2021 at 03:04:51PM +0100, Christoph Hellwig wrote:
> > > This looks like a huge mess.  What speak against using an iov_iter
> > > here?
> > 
> > I coincidentally made a start on this last night.  Happy to stop.
> 
> Don't stop!
> 
> > What do you think to adding a generic copy_pfn_to_iter()?  Not sure
> > which APIs to use to implement it ... some architectures have weird
> > requirements about which APIs can be used for what kinds of PFNs.
> 
> Hmm.  I though kmap_local_pfn(_prot) is all we need?

In the !HIGHMEM case, that calls pfn_to_page(), and I think the
point of this path is that we don't have a struct page for this pfn.
