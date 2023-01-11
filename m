Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB224665D55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 15:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjAKOKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 09:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjAKOK3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:10:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554F6270
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 06:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673446188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D39vXs2S/RnD+0E957Hp9KWXJdKMxGL7vQt2Nff943s=;
        b=f84ZNKte437x26BVXSqReaSxkDbcXH3Ixi47rGVk8oDkOfEw1HIFqD+cvBiQC/HYfjGSL4
        4vJy3XNxhqKAb+M4u0ngP3GQ4uBbBWC14H5OTAJK/fsUN61+9eLCioUJvvlgV9Yp+yd5q2
        /x/FTc05R6qkT84oZPEwEZhaCFL1ZX8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-dRM8KxJOMLKSMShZsFKKig-1; Wed, 11 Jan 2023 09:09:45 -0500
X-MC-Unique: dRM8KxJOMLKSMShZsFKKig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C96A380662D;
        Wed, 11 Jan 2023 14:09:43 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47570140EBF4;
        Wed, 11 Jan 2023 14:09:43 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Venkataramanan\, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
References: <20230109175629.9482-1-fmdefrancesco@gmail.com>
        <Y73+xKXDELSd14p1@ZenIV>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 11 Jan 2023 09:13:40 -0500
In-Reply-To: <Y73+xKXDELSd14p1@ZenIV> (Al Viro's message of "Wed, 11 Jan 2023
        00:11:48 +0000")
Message-ID: <x498ri9ma5n.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Al,

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Jan 09, 2023 at 06:56:29PM +0100, Fabio M. De Francesco wrote:
>
>> -	ring = kmap_atomic(ctx->ring_pages[0]);
>> +	ring = kmap_local_page(ctx->ring_pages[0]);
>>  	ring->nr = nr_events;	/* user copy */
>>  	ring->id = ~0U;
>>  	ring->head = ring->tail = 0;
>> @@ -575,7 +575,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>>  	ring->compat_features = AIO_RING_COMPAT_FEATURES;
>>  	ring->incompat_features = AIO_RING_INCOMPAT_FEATURES;
>>  	ring->header_length = sizeof(struct aio_ring);
>> -	kunmap_atomic(ring);
>> +	kunmap_local(ring);
>>  	flush_dcache_page(ctx->ring_pages[0]);
>
> I wonder if it would be more readable as memcpy_to_page(), actually...

I'm not sure I understand what you're suggesting.

>>  
>>  	return 0;
>> @@ -678,9 +678,9 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
>>  					 * we are protected from page migration
>>  					 * changes ring_pages by ->ring_lock.
>>  					 */
>> -					ring = kmap_atomic(ctx->ring_pages[0]);
>> +					ring = kmap_local_page(ctx->ring_pages[0]);
>>  					ring->id = ctx->id;
>> -					kunmap_atomic(ring);
>> +					kunmap_local(ring);
>
> Incidentally, does it need flush_dcache_page()?

Yes, good catch.

Cheers,
Jeff

