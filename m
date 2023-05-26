Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE7B71224B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242732AbjEZIe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbjEZIep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835371B3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 01:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685090034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZdbB846VP2Mif8vkzLshswwvIDgJcVcn/Vxjtn6SVU=;
        b=MK9DPKNKoWivszFvR7xVLNa5ILRs5Ny25JgE3t7sbMgHVBp4HHCeTv2J1FVBhdTfQbNR8O
        yZrrJh+Iy/qpIcqxTY182URQQgLfvWc+GE1+q3ipHdGN+/V0ekS4HwqhU0kqu7CA+rB+LC
        XwE2Z78/ahfGrBeu7P9vtg4n4AM+NlI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-7sMtwyH8MCSL5zzDtp_gYw-1; Fri, 26 May 2023 04:33:51 -0400
X-MC-Unique: 7sMtwyH8MCSL5zzDtp_gYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 626FE1C04180;
        Fri, 26 May 2023 08:33:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3E5C200AD47;
        Fri, 26 May 2023 08:33:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZHBtGJ3SzJtr5HZP@infradead.org>
References: <ZHBtGJ3SzJtr5HZP@infradead.org> <20230525223953.225496-1-dhowells@redhat.com> <20230525223953.225496-4-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 3/3] block: Use iov_iter_extract_pages() and page pinning in direct-io.c
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <520476.1685090027.1@warthog.procyon.org.uk>
Date:   Fri, 26 May 2023 09:33:47 +0100
Message-ID: <520477.1685090027@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> I'm not seeing where we skip the unpin of the zero page, as commented
> in patch 1 (but maybe I'm not reviewing carefully enough as I'm at a
> conference right now).

It's done by unpin_user_page{,s}(), hidden away in gup.c.  See the commit
message for patch 1:

	Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a
	pointer to it from the page tables and make unpin_user_page*()
	correspondingly ignore a ZERO_PAGE when unpinning.

David

