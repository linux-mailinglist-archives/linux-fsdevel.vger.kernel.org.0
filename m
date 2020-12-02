Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755232CB2A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 03:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgLBCMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 21:12:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbgLBCMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 21:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606875039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sY7/IufYoJYEkg/XQ54kbpFtGBvNVqqBTbMlk//HqTc=;
        b=hxwkPPnWAkAhAyUslONFREEU1uZbVsek2qJ0YaOwxRe2ZNkYwpL5/r+GlWTrhZ8caELBi+
        FKVVqddjD6imzhRENMZpUVO/PEjs1U6e6jOqjx3B4ttOqH8g3KLAnDps8PjY0pjU04//Ig
        HlExHz7WpmG21yes/vgZhTjA/pNzOkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-5AdSIn6OOcq0_Yj9jfMfjw-1; Tue, 01 Dec 2020 21:10:37 -0500
X-MC-Unique: 5AdSIn6OOcq0_Yj9jfMfjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7D431005E44;
        Wed,  2 Dec 2020 02:10:35 +0000 (UTC)
Received: from T590 (ovpn-13-72.pek2.redhat.com [10.72.13.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 213655C1D5;
        Wed,  2 Dec 2020 02:10:25 +0000 (UTC)
Date:   Wed, 2 Dec 2020 10:10:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201202021021.GB494805@T590>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
 <20201201125936.GA25111@infradead.org>
 <fdbfe981-0251-9641-6ed8-db034c0f0148@gmail.com>
 <20201201133226.GA26472@infradead.org>
 <6cbce034-b8c9-35d5-e805-f5ed0c169e2a@gmail.com>
 <20201201134542.GA2888@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201134542.GA2888@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:45:42PM +0000, Christoph Hellwig wrote:
> On Tue, Dec 01, 2020 at 01:36:22PM +0000, Pavel Begunkov wrote:
> > Yeah, that's the idea, but also wanted to verify that callers don't
> > free it while in use, or if that's not the case to make it conditional
> > by adding a flag in iov_iter.
> > 
> > Can anybody vow right off the bat that all callers behave well?
> 
> Yes, this will need a careful audit, I'm not too sure offhand.  For the
> io_uring case which is sortof the fast path the caller won't free them
> unless we allow the buffer unregistration to race with I/O.

Loop's aio usage is fine, just found fd_execute_rw_aio() isn't good.


Thanks,
Ming

