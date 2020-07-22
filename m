Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC34229822
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 14:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbgGVMUG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 08:20:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32756 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbgGVMUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595420404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCtk9GnBiOAqU3k+W1SQe7KIu+zVdj7N1c33spXO6As=;
        b=NLOKRJDiHmIDOfYSGu4kMA7sm75Dxry3Hv5r3S5pDmfGg4+VpwhYJ0ff8bKm1MlO+NbC/u
        emTpF6Y0+sieoRz9hC9iUVRjaSQcmUetN5m/4aaXErbyTonhpBnpSRGXn6SfErqDfJstnq
        tutOhG5waE5as5OfXnZjp4gMR3n+UnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-EWS-2KU8MuGqDl5cYcroPw-1; Wed, 22 Jul 2020 08:20:01 -0400
X-MC-Unique: EWS-2KU8MuGqDl5cYcroPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A09980BCAF;
        Wed, 22 Jul 2020 12:19:59 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 804715D9D3;
        Wed, 22 Jul 2020 12:19:59 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5D27E730D3;
        Wed, 22 Jul 2020 12:19:59 +0000 (UTC)
Date:   Wed, 22 Jul 2020 08:19:58 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-ext4@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-fsdevel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Message-ID: <595939815.7378944.1595420398243.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200721203749.GF3151642@magnolia>
References: <20200721183157.202276-1-hch@lst.de> <20200721183157.202276-4-hch@lst.de> <20200721203749.GF3151642@magnolia>
Subject: Re: [Cluster-devel] [PATCH 3/3] iomap: fall back to buffered writes
 for invalidation failures
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.145, 10.4.195.20]
Thread-Topic: iomap: fall back to buffered writes for invalidation failures
Thread-Index: PLuOF8kQrR0wpZuOBcUe+YqC5MOZSw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Original Message -----
> On Tue, Jul 21, 2020 at 08:31:57PM +0200, Christoph Hellwig wrote:
> > Failing to invalid the page cache means data in incoherent, which is
> > a very bad state for the system.  Always fall back to buffered I/O
> > through the page cache if we can't invalidate mappings.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Acked-by: Dave Chinner <dchinner@redhat.com>
> > Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> For the iomap and xfs parts,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> But I'd still like acks from Ted, Andreas, and Damien for ext4, gfs2,
> and zonefs, respectively.
> 
> (Particularly if anyone was harboring ideas about trying to get this in
> before 5.10, though I've not yet heard anyone say that explicitly...)
> 
> --D
> 
> > ---
> >  fs/ext4/file.c       |  2 ++
> >  fs/gfs2/file.c       |  3 ++-
> >  fs/iomap/direct-io.c | 16 +++++++++++-----
> >  fs/iomap/trace.h     |  1 +
> >  fs/xfs/xfs_file.c    |  4 ++--
> >  fs/zonefs/super.c    |  7 +++++--
> >  6 files changed, 23 insertions(+), 10 deletions(-)

Hi,

I think Andreas is on holiday this week, but the gfs2 portion looks good to me:

For the gfs2 portion:
Acked-by: Bob Peterson <rpeterso@redhat.com>

Regards,

Bob Peterson

