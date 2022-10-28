Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B876E611804
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJ1QtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 12:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJ1Qsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CC6148FDD
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666975663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lINxhsqMpOdjiC2dtBaOrXCk/sAH+QCARq0KZ4Gkpt0=;
        b=Yg7/2nmQt7VDXm1h8uzOcJ+ZoSi3y7ryV2VYvUuSi+UX3eBHTwqzqo3tiORKM4y/ZavoI/
        QertnPapMx2p33nPCUEFRuFUfxlpOh3QK/qJCn+Gaf8El2rboA+/Y0SAXHsqqy01zrWL8L
        YpUNq2Zhqk3l2Hk4d6/2lweSIDtHhEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-45EZoGBPPW6yfVTL_AZnnQ-1; Fri, 28 Oct 2022 12:47:27 -0400
X-MC-Unique: 45EZoGBPPW6yfVTL_AZnnQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2195C88F474;
        Fri, 28 Oct 2022 16:45:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92546492B20;
        Fri, 28 Oct 2022 16:45:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221028151526.319681-2-willy@infradead.org>
References: <20221028151526.319681-2-willy@infradead.org> <20221028151526.319681-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-mm@kvack.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/1] mm: Add folio_map_local()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64544.1666975529.1@warthog.procyon.org.uk>
Date:   Fri, 28 Oct 2022 17:45:29 +0100
Message-ID: <64545.1666975529@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Some filesystems benefit from being able to map the entire folio.
> On 32-bit platforms with HIGHMEM, we fall back to using vmap, which
> will be slow.  If it proves to be a performance problem, we can look at
> optimising it in a number of ways.

Here's a thought: If a highmem arch has a huge PTEs available, can you create
a huge PTE to cover the folio?

> @@ -426,5 +465,4 @@ static inline void folio_zero_range(struct folio *folio,
>  {
>  	zero_user_segments(&folio->page, start, start + length, 0, 0);
>  }
> -
>  #endif /* _LINUX_HIGHMEM_H */

Did you want to remove that blank line?

David

