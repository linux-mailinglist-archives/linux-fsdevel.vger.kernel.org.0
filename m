Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A12CB278
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 02:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgLBBse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 20:48:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727924AbgLBBse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606873627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IP0Aieu6kqIL09lNyhRGJvXhQboPOH1LjqLNy6tHc/4=;
        b=fVfFQYfyGEN/kRiLxPRC/e71CNqA4y7VAsZZTvrNtZmocoNot1jT5V4FmhHhoem8xq5bak
        aWz0JQQIry85aKR7EaUeSx6DZtHaqVGNow5vzs44Uh1jWvEbOyfPe5u8seiyEqhTYy22Zw
        byAVIO592CTKhZh/0R3PL39u0kZ6gtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-rQSFvIS5MTiOe8Y9zO26xA-1; Tue, 01 Dec 2020 20:47:04 -0500
X-MC-Unique: rQSFvIS5MTiOe8Y9zO26xA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 140BA5F9E7;
        Wed,  2 Dec 2020 01:47:02 +0000 (UTC)
Received: from T590 (ovpn-13-72.pek2.redhat.com [10.72.13.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CFDC85D9DD;
        Wed,  2 Dec 2020 01:46:54 +0000 (UTC)
Date:   Wed, 2 Dec 2020 09:46:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201202014650.GA494805@T590>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201125251.GA11935@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 12:52:51PM +0000, Matthew Wilcox wrote:
> On Tue, Dec 01, 2020 at 08:06:52PM +0800, Ming Lei wrote:
> > Pavel reported that iov_iter_npages is a bit heavy in case of bvec
> > iter.
> > 
> > Turns out it isn't necessary to iterate every page in the bvec iter,
> > and we call iov_iter_npages() just for figuring out how many bio
> > vecs need to be allocated. And we can simply map each vector in bvec iter
> > to bio's vec, so just return iter->nr_segs from bio_iov_iter_nvecs() for
> > bvec iter.
> > 
> > Also rename local variable 'nr_pages' as 'nr_vecs' which exactly matches its
> > real usage.
> > 
> > This patch is based on Mathew's post:
> > 
> > https://lore.kernel.org/linux-block/20201120123931.GN29991@casper.infradead.org/
> 
> But the only reason we want to know 'nr_vecs' is so we can allocate a
> BIO which has that many vecs, right?  But we then don't actually use the
> vecs in the bio because we use the ones already present in the iter.
> That was why I had it return 1, not nr_vecs.
> 
> Did I miss something?

Please see bio_iov_iter_get_pages():

  do {
  		...
      	if (is_bvec)
        	ret = __bio_iov_bvec_add_pages(bio, iter);
		...
   } while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));


So all bvecs in bvec iter will be added to the bio, and it isn't
correct or efficient to just return 1.

thanks,
Ming

