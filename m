Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B0969B906
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 10:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBRJTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 04:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBRJTW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:19:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC65FF745
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Feb 2023 01:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676711901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R3BrmhBgQgWTKEiCYwN2vM7iyjzhHhTKrOpbAg9oclw=;
        b=NMaqYUDvWpCClU8+OFzgitq0Fm85bZyi5Nge2JlF9NqhwxONkapZPxkr3OU7LptZAnWUZE
        JsF2ZDfqKVvWMQoC6gjBsujJCR34ccAVjhbTtN5v9IMpXEgkpW/5SUgcp2CsEfe3DuvpRO
        greQ6kl6xq7b5Nyz7Ka9cS+I/GUzXTU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-J1y4fjxvOBaocJW_UBOeNQ-1; Sat, 18 Feb 2023 04:18:17 -0500
X-MC-Unique: J1y4fjxvOBaocJW_UBOeNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84A2980352D;
        Sat, 18 Feb 2023 09:18:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F7A6492B00;
        Sat, 18 Feb 2023 09:18:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87a61b9y20.fsf@oc8242746057.ibm.com>
References: <87a61b9y20.fsf@oc8242746057.ibm.com> <87a61ckowk.fsf@oc8242746057.ibm.com> <732891.1676670463@warthog.procyon.org.uk>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     dhowells@redhat.com, axboe@kernel.dk, david@redhat.com,
        hch@infradead.org, hch@lst.de, hdanton@sina.com, jack@suse.cz,
        jgg@nvidia.com, jhubbard@nvidia.com, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        logang@deltatee.com, viro@zeniv.linux.org.uk, willy@infradead.org,
        Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH v14 08/17] splice: Do splice read from a file without using ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1085543.1676711893.1@warthog.procyon.org.uk>
Date:   Sat, 18 Feb 2023 09:18:13 +0000
Message-ID: <1085544.1676711893@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexander Egorenkov <egorenar@linux.ibm.com> wrote:

> > +			n = min_t(loff_t, len, isize - *ppos);
> > +			n = splice_folio_into_pipe(pipe, folio, *ppos, n);
> >  			if (!n)
> >  				goto out;
> >  			len -= n;
> 
> Yes, this change fixed the problem.

Thanks!

David

