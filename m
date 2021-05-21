Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A13D38C0C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 09:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhEUHcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 03:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235958AbhEUHck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 03:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621582277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jrUX7SgWhIOOVjL/umQGCC5+PLm24QICxWfvJF3miQU=;
        b=fBXlHT1MbeacBThttwW85+M/iX+KAg5/WSO56MObq7J7Em9SDthmy6SKBvTOVO9UlVOKFr
        JsyNQxMOD7BYWn+8ESOVKNkMXVHPGQryyyyF6b/g+22RDww/9zGlOd05CvjCBf2Le8McMJ
        eTOL+rU9jPVKtfv3ZK+hMDBw7MSjp7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-dbWhAcToMB-JlzFDXdtz4w-1; Fri, 21 May 2021 03:31:15 -0400
X-MC-Unique: dbWhAcToMB-JlzFDXdtz4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32813107ACE4;
        Fri, 21 May 2021 07:31:14 +0000 (UTC)
Received: from T590 (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB5A460CCC;
        Fri, 21 May 2021 07:31:10 +0000 (UTC)
Date:   Fri, 21 May 2021 15:31:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: iomap: writeback ioend/bio allocation deadlock risk
Message-ID: <YKdhuUZBtKMxDpsr@T590>
References: <YKcouuVR/y/L4T58@T590>
 <20210521071727.GA11473@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521071727.GA11473@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 09:17:27AM +0200, Christoph Hellwig wrote:
> On Fri, May 21, 2021 at 11:27:54AM +0800, Ming Lei wrote:
> >         if %__gfp_direct_reclaim is set then bio_alloc will always be able to
> >         allocate a bio.  this is due to the mempool guarantees.  to make this work,
> >         callers must never allocate more than 1 bio at a time from the general pool.
> >         callers that need to allocate more than 1 bio must always submit the
> >         previously allocated bio for io before attempting to allocate a new one.
> >         failure to do so can cause deadlocks under memory pressure.
> > 
> > 1) more than one ioends can be allocated from 'iomap_ioend_bioset'
> > before submitting them all, so mempoll guarantee can't be made, which can
> > be observed frequently in writeback over ext4
> > 
> > 2) more than one chained bio(allocated from fs_bio_set) via iomap_chain_bio,
> > which is easy observed when writing big files on XFS:
> 
> The comment describing bio_alloc_bioset is actually wrong.  Allocating

OK, we can fix the doc, but...

> more than 1 at a time is perfectly fine, it just can't be more than
> the pool_size argument passed to bioset_init.
> 
> iomap_ioend_bioset is sized to make sure we can always complete up
> to 4 pages, and the list is only used inside a page, so we're fine.

The number itself does not matter, because there isn't any limit on how
many ioends can be allocated before submitting, for example, it can be
observed that 64 ioends is allocated before submitting when writing
5GB file to ext4. So far the reserved pool size is 32.

> 
> fs_bio_set always has two entries to allow exactly for the common
> chain and submit pattern.

It is easy to trigger dozens of chained bios in one ioend when writing
big file to XFS.


Thanks,
Ming

