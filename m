Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E1338C1ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 10:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhEUIgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 04:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229581AbhEUIgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 04:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621586127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kuYUhhL94LuypVQVU/8gmYiWpeDRn7eGERWqg/ZHe/c=;
        b=ZCkGNt4U6j4/8W2NjrZsmphl86H8Dsdlrv6ci+TGeV9fPwW+SP7Ok984AIwiUFsvGs9FPM
        No6zlaojJNVlsqRHZH71IQHqAmpwMoneh4BrNRM9PHRD0pmOwudd963FFeuw/DMkmWQb07
        cmqXVbPttIZzMofxHJKL4+akJgzRW5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-aC5dqfaKPPm0CTtZsWAbIg-1; Fri, 21 May 2021 04:35:26 -0400
X-MC-Unique: aC5dqfaKPPm0CTtZsWAbIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 448898186E1;
        Fri, 21 May 2021 08:35:25 +0000 (UTC)
Received: from T590 (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75791177F1;
        Fri, 21 May 2021 08:35:12 +0000 (UTC)
Date:   Fri, 21 May 2021 16:35:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: iomap: writeback ioend/bio allocation deadlock risk
Message-ID: <YKdwtzp+WWQ3krhI@T590>
References: <YKcouuVR/y/L4T58@T590>
 <20210521071727.GA11473@lst.de>
 <YKdhuUZBtKMxDpsr@T590>
 <20210521073547.GA11955@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521073547.GA11955@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 09:35:47AM +0200, Christoph Hellwig wrote:
> On Fri, May 21, 2021 at 03:31:05PM +0800, Ming Lei wrote:
> > > iomap_ioend_bioset is sized to make sure we can always complete up
> > > to 4 pages, and the list is only used inside a page, so we're fine.
> > 
> > The number itself does not matter, because there isn't any limit on how
> > many ioends can be allocated before submitting, for example, it can be
> > observed that 64 ioends is allocated before submitting when writing
> > 5GB file to ext4. So far the reserved pool size is 32.
> 
> How do you manage to allocate iomap ioends when writing to ext4?  ext4
> doesn't use iomap for buffered I/O.

Just double check, the multiple ioends allocation is from root XFS and
not from big file write to ext4, so looks it can be triggered easily in
background writeback.

> 
> > > fs_bio_set always has two entries to allow exactly for the common
> > > chain and submit pattern.
> > 
> > It is easy to trigger dozens of chained bios in one ioend when writing
> > big file to XFS.
> 
> Yes, we can still have one chained bio per ioend, so we need a bioset
> with the same size as iomap_ioend_bioset.  That still should not be
> dozends for a common setup, though.

Yeah, that can be one solution.

Just wondering why the ioend isn't submitted out after it becomes full?


Thanks, 
Ming

