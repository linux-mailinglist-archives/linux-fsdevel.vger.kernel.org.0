Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0266617F10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 15:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiKCOOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 10:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiKCONu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920231580B
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667484763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cj1dbbZ4AJTxCmYzDOfjdAdaVz3PfhRhTZbkt1+9cFE=;
        b=ZFRKoG3OkhOtdbmX3+pDDPOT42p6j8Nkc0hLgJdAXNa7XjHLl4662LWwzZ7EPnuPtiCkMu
        by45hLWsy7f1kWohBwjOi7Q/alXHGMvlb9U7n+up8LdwlIh+Zhr66Oh9w8a2cyWH4hL9gH
        Rc+RPZP0aaHxDkP+YNQeRCwDMtOOE6E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-6diFqltBP1K2ItDiZxUPAw-1; Thu, 03 Nov 2022 10:12:40 -0400
X-MC-Unique: 6diFqltBP1K2ItDiZxUPAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0194F85A5A6;
        Thu,  3 Nov 2022 14:12:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E210E1401C22;
        Thu,  3 Nov 2022 14:12:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y19EXLfn8APg3adO@casper.infradead.org>
References: <Y19EXLfn8APg3adO@casper.infradead.org> <cover.1666928993.git.ritesh.list@gmail.com> <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com> <20221028210422.GC3600936@dread.disaster.area>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Dave Chinner <david@fromorbit.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve write performance
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6821.1667484757.1@warthog.procyon.org.uk>
Date:   Thu, 03 Nov 2022 14:12:37 +0000
Message-ID: <6822.1667484757@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> ... His solution is a bit more complex than I really want to see, at least
> partially because he's trying to track dirtiness at byte granularity, no
> matter how much pain that causes to the server.

Actually, I'm looking at page-level granularity at the moment.

David

