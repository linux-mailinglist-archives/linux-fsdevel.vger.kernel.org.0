Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DF9344BA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 17:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhCVQgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 12:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231793AbhCVQgi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616430997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0HrR+k5jZSd9kYmJq/jAeLaCIvotYxIelJeCRHk+SPA=;
        b=K7Xiid4V6MzE/bOFIl2UecTSMxsMxfTGUAeX6ZFpvatpxgGvclwD5FuwjU7aI4054vvV1B
        BaSNJmfkiqDmuYZmpkJ+QRiU3hsZmzdmb2v4AFUhYjTsggTVLDN37zCvtAPaMm2nL/Horu
        d7FBhyY2g/IbBRU8QAfxi3YMuWGzQnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-5baAX8LWNHi544SiaLTmlg-1; Mon, 22 Mar 2021 12:36:32 -0400
X-MC-Unique: 5baAX8LWNHi544SiaLTmlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B2C081621;
        Mon, 22 Mar 2021 16:36:31 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD52C5F9C9;
        Mon, 22 Mar 2021 16:36:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 12MGaUf1005434;
        Mon, 22 Mar 2021 12:36:30 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 12MGaUeT005430;
        Mon, 22 Mar 2021 12:36:30 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 22 Mar 2021 12:36:30 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] buffer: a small optimization in grow_buffers
In-Reply-To: <20210322151124.GP1719932@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2103221225330.1530@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2103221002360.19948@file01.intranet.prod.int.rdu2.redhat.com> <20210322151124.GP1719932@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 22 Mar 2021, Matthew Wilcox wrote:

> On Mon, Mar 22, 2021 at 10:05:05AM -0400, Mikulas Patocka wrote:
> > This patch replaces a loop with a "tzcnt" instruction.
> 
> Are you sure that's an optimisation?  The loop would execute very few
> times under normal circumstances (a maximum of three times on x86).
> Some numbers would be nice.

According to Agner's instruction tables, tzcnt has latency 3 on Skylake 
and 2 on Zen. (386, 486, Pentium and K6 didn't have hardware for the bsf 
instruction, they executed it in microcode bit-by-bit, but newer 
processors execute it quickly).

The patch reduces code size by 16 bytes.

Mikulas

> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > Index: linux-2.6/fs/buffer.c
> > ===================================================================
> > --- linux-2.6.orig/fs/buffer.c
> > +++ linux-2.6/fs/buffer.c
> 
> Are ... are you still using CVS?!
> 
> > @@ -1020,11 +1020,7 @@ grow_buffers(struct block_device *bdev,
> >  	pgoff_t index;
> >  	int sizebits;
> >  
> > -	sizebits = -1;
> > -	do {
> > -		sizebits++;
> > -	} while ((size << sizebits) < PAGE_SIZE);
> > -
> > +	sizebits = PAGE_SHIFT - __ffs(size);
> >  	index = block >> sizebits;
> >  
> >  	/*
> > 
> 

