Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE0458741C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 00:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbiHAWyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 18:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiHAWyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:54:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8789927175
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 15:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659394474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rn5k9k8I5p59lLzq68XgYiQT1jU+ItZ4YYaYlxXyIrE=;
        b=DZqiG8vtrUN8BdH+L02Ypz4PZkn/jwhZsDzCivTSK86tqa84rJRIb+LOsTwDcCxfjiVVG4
        rWJ+Q/o29653CApm5CEn3f/nMC+C01hid5Lziwady0f6WEx4lqsFK7k56In9zKrVpPGZyy
        8YwXxlh9VFm4nNT9/0WiodJkYMqnaMU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-AJQfUCzNMzq-dlC0oR88hw-1; Mon, 01 Aug 2022 18:54:31 -0400
X-MC-Unique: AJQfUCzNMzq-dlC0oR88hw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6874811E76;
        Mon,  1 Aug 2022 22:54:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D869B492C3B;
        Mon,  1 Aug 2022 22:54:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YuhCRa9XFfacwWgU@ZenIV>
References: <YuhCRa9XFfacwWgU@ZenIV> <20220622041552.737754-9-viro@zeniv.linux.org.uk> <YrKWRCOOWXPHRCKg@ZenIV> <20220622041552.737754-1-viro@zeniv.linux.org.uk> <2806275.1659357724@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 09/44] new iov_iter flavour - ITER_UBUF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <437170.1659394469.1@warthog.procyon.org.uk>
Date:   Mon, 01 Aug 2022 23:54:29 +0100
Message-ID: <437172.1659394469@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

>  	if (iov_iter_is_bvec(new))
>  		return new->bvec = kmemdup(new->bvec,
>  				    new->nr_segs * sizeof(struct bio_vec),
>  				    flags);
> -	else
> +	else if (iov_iter_is_kvec(new) || iter_is_iovec(new))

The else is redundant.

David

