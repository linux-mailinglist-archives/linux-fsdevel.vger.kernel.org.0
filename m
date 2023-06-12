Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8866072CB61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 18:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbjFLQWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 12:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjFLQWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D562F9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686586882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BIokZ+83bpQiYOFz/AxkVvDOS90+kiJUUNctri+wFZ8=;
        b=XyzT41K5GxrRfrb+XWiufuOdsX3psNlzr5WzYGHDWNkShCtmEtMkWeJJwphhOvFZD5Hw8h
        1CDWdfeIaWXICMa0CxyvVK9vPgCPwLSLUrw3GCkLOac+oqUkDFzOqRfTzjPsu8Dp8Rpcr/
        2nmwdXYJTkov8SqMRm4z6brTxYXpetc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-HxveCVQAM0W6_Ytnfnkd3A-1; Mon, 12 Jun 2023 12:21:20 -0400
X-MC-Unique: HxveCVQAM0W6_Ytnfnkd3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7480101A53B;
        Mon, 12 Jun 2023 16:21:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFEC240C98D6;
        Mon, 12 Jun 2023 16:21:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <080538f2-defc-2000-c9f2-fb520448c93c@redhat.com>
References: <080538f2-defc-2000-c9f2-fb520448c93c@redhat.com> <202306120931.a9606b88-oliver.sang@intel.com> <108491.1686573741@warthog.procyon.org.uk>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [axboe-block:for-6.5/block] [block] 1ccf164ec8: WARNING:at_mm/gup.c:#try_get_folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <387985.1686586876.1@warthog.procyon.org.uk>
Date:   Mon, 12 Jun 2023 17:21:16 +0100
Message-ID: <387987.1686586876@warthog.procyon.org.uk>
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

The problem is in dio_bio_alloc() where it sets BIO_PAGE_REFFED and not
BIO_PAGE_PINNED.

David

