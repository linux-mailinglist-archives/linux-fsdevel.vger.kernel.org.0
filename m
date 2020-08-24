Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BAB24FFCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 16:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgHXO2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 10:28:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46658 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725968AbgHXO2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 10:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598279309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fI05Fs4HjD1Fspp+mWg44gsKdGpjEIRqNmomRhV5I5A=;
        b=gvn438qFxjroBE6OVNCIbn4wnC2wqqSPdVim0bLRHF+cyTj7my4Ktn0Jz3yXZwLzFAdQNp
        si1wVy0PzlYRD2JZMdoMJtsMyw6iOFTEtsbYdYqOuLDijJnN738pCSAiDKKEUyCO2lx2wg
        e2MMAIdtZFDab+/6btblVeK65gGJDnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-XFK-FZUrPsutsyHWEvahyw-1; Mon, 24 Aug 2020 10:28:27 -0400
X-MC-Unique: XFK-FZUrPsutsyHWEvahyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FB7F81F018;
        Mon, 24 Aug 2020 14:28:26 +0000 (UTC)
Received: from bfoster (ovpn-112-11.rdu2.redhat.com [10.10.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B1F727CD4;
        Mon, 24 Aug 2020 14:28:25 +0000 (UTC)
Date:   Mon, 24 Aug 2020 10:28:23 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200824142823.GA295033@bfoster>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200820231140.GE7941@dread.disaster.area>
 <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
 <20200821215358.GG7941@dread.disaster.area>
 <20200822131312.GA17997@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822131312.GA17997@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 22, 2020 at 02:13:12PM +0100, Christoph Hellwig wrote:
> On Sat, Aug 22, 2020 at 07:53:58AM +1000, Dave Chinner wrote:
> > but iomap only allows BIO_MAX_PAGES when creating the bio. And:
> > 
> > #define BIO_MAX_PAGES 256
> > 
> > So even on a 64k page machine, we should not be building a bio with
> > more than 16MB of data in it. So how are we getting 4GB of data into
> > it?
> 
> BIO_MAX_PAGES is the number of bio_vecs in the bio, it has no
> direct implication on the size, as each entry can fit up to UINT_MAX
> bytes.
> 

Do I understand the current code (__bio_try_merge_page() ->
page_is_mergeable()) correctly in that we're checking for physical page
contiguity and not necessarily requiring a new bio_vec per physical
page?

With regard to Dave's earlier point around seeing excessively sized bio
chains.. If I set up a large memory box with high dirty mem ratios and
do contiguous buffered overwrites over a 32GB range followed by fsync, I
can see upwards of 1GB per bio and thus chains on the order of 32+ bios
for the entire write. If I play games with how the buffered overwrite is
submitted (i.e., in reverse) however, then I can occasionally reproduce
a ~32GB chain of ~32k bios, which I think is what leads to problems in
I/O completion on some systems. Granted, I don't reproduce soft lockup
issues on my system with that behavior, so perhaps there's more to that
particular issue.

Regardless, it seems reasonable to me to at least have a conservative
limit on the length of an ioend bio chain. Would anybody object to
iomap_ioend growing a chain counter and perhaps forcing into a new ioend
if we chain something like more than 1k bios at once?

Brian

