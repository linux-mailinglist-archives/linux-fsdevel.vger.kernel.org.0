Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E976672EE1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 23:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjFMVhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 17:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjFMVhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC341FFB
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686692177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ds/y7lH76obKk3se56kRnUXeuApDjVV7xaTlhnaSY1k=;
        b=Ogr2VtLpMJkng8vuKQnBkvzW/Qm+RgJobt+r0bHQ0F9mgp9EhAdag6NFQhCwQLg6kLKaPS
        rjUGGkNA1cniEBs7VNaNTBD5YAak1GbO3owIAuqb90FZgREgZBwA/jZVW8Zg0g/bekHAov
        +rLfTb+TENGQ15p1CUQpmOzW1E4cIS4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-eu5Jh_yLPdaKczsKDCMpHA-1; Tue, 13 Jun 2023 17:36:15 -0400
X-MC-Unique: eu5Jh_yLPdaKczsKDCMpHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4F90811E8D;
        Tue, 13 Jun 2023 21:36:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D5D140C6F5D;
        Tue, 13 Jun 2023 21:36:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1156283.1686692027@warthog.procyon.org.uk>
References: <1156283.1686692027@warthog.procyon.org.uk> <f50b438f-90bc-36b1-c943-18d7a4b3f441@redhat.com> <431929.1686588681@warthog.procyon.org.uk>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <oliver.sang@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix dio_bio_alloc() to set BIO_PAGE_PINNED
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1157973.1686692171.1@warthog.procyon.org.uk>
Date:   Tue, 13 Jun 2023 22:36:11 +0100
Message-ID: <1157974.1686692171@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 static inline void dio_cleanup(struct dio *dio, struct dio_submit *sdio)
 {
-       while (sdio->head < sdio->tail)
-               put_page(dio->pages[sdio->head++]);
+       if (dio->is_pinned)
+               unpin_user_pages(dio->pages + sdio->head,
+                                sdio->tail - sdio->head);
 }
 
 /*

Meh.  It's obvious.  Need to advance head.

David

