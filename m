Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4EF4D3F96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 04:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbiCJDRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 22:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbiCJDRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:17:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 701F4128DE0
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 19:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646882213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aApHfNMuw8TT668OaBqabvBGvYDjjIpeBjZgNCUi6hQ=;
        b=gIQrZ2eOhfwgEv6fHJh368hbCu2koVAuOrEI5M7i/m8zWtjpNaxpvmH1o1FnppV4Ga8RyV
        hbsZnNZCu7NVbDJYEAyXhD6C19EdFflrPZMqFw909nkyAIJ0wUc37FQvdG5qYTcMPL/yRz
        FIAKs5X6V3H4RhbTcF7Hs3SkEL0nvdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-1lvPABATNDC9RbIDcmTeEQ-1; Wed, 09 Mar 2022 22:16:50 -0500
X-MC-Unique: 1lvPABATNDC9RbIDcmTeEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BABD21091DA0;
        Thu, 10 Mar 2022 03:16:48 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5B725DB83;
        Thu, 10 Mar 2022 03:16:41 +0000 (UTC)
Date:   Thu, 10 Mar 2022 11:16:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Significant brokenness in DIO loopback path
Message-ID: <Yiltk3RWTPJvPJph@T590>
References: <YilX4PHgulMi3vhb@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YilX4PHgulMi3vhb@moria.home.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 09, 2022 at 08:44:00PM -0500, Kent Overstreet wrote:
> So I'm testing bcachefs with the loopback driver in dio mode, and noticing
> _significant_ brokenness in the bio_iov_iter_get_pages() path and elsewhere.
> 
> 1) We don't check that we're not asking for more pages than we're in the
> original bio
> 
> Noticed this because of another bug:
> 
> 2) the loopback driver appears to never look at the underlying filesystem's
> block size, meaning if the filesystem advertises a block size of 4k the loopback
> device's blocksize will still be 512, and we'll end up issuing IOs the DIO path
> shouldn't allow due to alignment.

I tried to fallback to buffered IO for unaligned dio, it was rejected.

https://lore.kernel.org/linux-block/20211025094437.2837701-1-ming.lei@redhat.com/

Also the ahead of time check may not work as expected because of ioctl
order, I guess that is why you see loop 512 bs even the underlying advertises
big 4k size.

Also loop 512 bs is often useful since the upper FS image may need that.

> 
> 3) iov_iter_bvec_advance() looks like utter nonsense. We're synthesizing a fake
> bvec_iter and never using or even looking at one from the original bio, looking
> at the construction in iov_iter_bvec().
> 
> This is broken; you're assuming you're never going to see bios with partially
> completed bvec_iters, or things are going to explode.
> 
> Try putting a md raid0 on top of two loopback devices with a sub page block
> size, things are just going to explode.
> 
> iov_iter_bvec() needs to be changed to take a bio, not a bvec array, and
> iov_iter_bvec_advance() should probably just call bio_advance() - and
> bio_iov_bvec_set() needs to be changed to just copy bi_iter from the original
> bio into the dest bio. You guys made this way more complicated than it needed to
> be.

Can you share the function in loop.c you are talking? Is it lo_rw_aio()? What is
the exact issue in current way?

If the request has > 1 bio, one bvec array is made for call_write_iter.


Thanks
Ming

