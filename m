Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32EA619BCF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 16:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiKDPfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiKDPff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04A52BB3B
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667576077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LT0M84RHennN0dW2EE8vvps3ib1aZORs0vuNv4tzMCA=;
        b=fEem2w2LPswJoghFneAlHyA2pLr7ZH8BzQo6Z9QDbK4RFF3U0S9ouz8y/Au5tjNqXZv8Iy
        o7TAx83fEvatC/zO1iJTgVr20WFp/MzxlOfVF9W9juXIfb8B4Zd6lKtKtEbgk4F5MAz3/5
        y9S8vsXLFPGD8hBQU1spvL5qzFBNgmY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-K-iw9RHjM9KFnyQt1xVSMA-1; Fri, 04 Nov 2022 11:34:27 -0400
X-MC-Unique: K-iw9RHjM9KFnyQt1xVSMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EAA4833A0D;
        Fri,  4 Nov 2022 15:34:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C84B2166B26;
        Fri,  4 Nov 2022 15:34:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y2SJw7w1IsIik3nb@casper.infradead.org>
References: <Y2SJw7w1IsIik3nb@casper.infradead.org> <166751120808.117671.15797010154703575921.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, George Law <glaw@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix missing xas_retry() calls in xarray iteration
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <931864.1667576065.1@warthog.procyon.org.uk>
Date:   Fri, 04 Nov 2022 15:34:25 +0000
Message-ID: <931865.1667576065@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> "unsigned int" assumes that the number of bytes isn't going to exceed 32
> bits.  I tend to err on the side of safety here and use size_t.

Not unreasonable.

> > +		pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
> > +		pgend = pgpos + folio_size(folio);
> 
> What happens if start_page is somewhere inside folio?  Seems to me
> that pgend ends up overhanging into the next folio?

Yeah, I think my maths is dodgy.  I should probably use folio_pos() and/or
offset_in_folio().

David

