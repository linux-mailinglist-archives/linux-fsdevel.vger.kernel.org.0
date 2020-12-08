Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94E2D205D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 02:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgLHBwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 20:52:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgLHBwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607392244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7uidQSRWovqSGyr2eKHppMK/Pin50WJWnRi+lM7zbE=;
        b=fs+4j3oAfdewk3kzkoTgOy+cSiPVDUHRDIESXXE4OAgN8k4/EUcHj1bJ5jkL81pbpLdKy4
        ES9AghF9A/1SCFVk8IgN5bV+6JDp8Upwb6uEepQfaZNSRdySQZIWQ3/JxhA2rxxsi5vIy1
        U+N109EhBinJrQ4sUrTtv0ldI3EJ0KA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-gi9zAyrUP_mmn_kxtEv_wQ-1; Mon, 07 Dec 2020 20:50:42 -0500
X-MC-Unique: gi9zAyrUP_mmn_kxtEv_wQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DA01C28E;
        Tue,  8 Dec 2020 01:50:41 +0000 (UTC)
Received: from T590 (ovpn-13-16.pek2.redhat.com [10.72.13.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 715725D9DE;
        Tue,  8 Dec 2020 01:50:34 +0000 (UTC)
Date:   Tue, 8 Dec 2020 09:50:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201208015030.GC1059392@T590>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <3eb1020d-c336-dbe6-d75e-70c388464e6e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eb1020d-c336-dbe6-d75e-70c388464e6e@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 06:07:39PM +0000, Pavel Begunkov wrote:
> On 01/12/2020 12:06, Ming Lei wrote:
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
> 
> Tried this, the system didn't boot + discovered a filesystem blowned after
> booting with a stable kernel. That's on top of 4498a8536c816 ("block: use
> an xarray for disk->part_tbl"), which works fine. Ideas?

I guess it is caused by Christoph's "store a pointer to the block_device in struct bio (again)"
which has been reverted in for-5.11/block.

I'd suggest to run your test against the latest for-5.11/block one more time.

thanks,
Ming

