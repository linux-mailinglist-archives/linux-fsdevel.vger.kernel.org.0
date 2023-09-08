Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1D079844B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjIHImx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 04:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjIHImh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF61BDA
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694162507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hY8tZO882Jl0E+LR6+k1KutgEB/prW8NTGo4X92b6p4=;
        b=A0zgYvdlhQnrAeWIepXFolyft/4cNVkDxmCzS6/V3NJrz5uVM6xWKOYzr/eh8YS+Wpmrjx
        SBeW3szu6XNtpW5eNQOkjFLp2H4gvU7ngp7jeNYuY5n133GQr8SRw2VN3OAdzh0X8Pctxr
        BIFcEe1hAQXB3JaQO30zZANXnZK1RBY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-cb6fuJdoPgeyTvXtnnt2jQ-1; Fri, 08 Sep 2023 04:41:42 -0400
X-MC-Unique: cb6fuJdoPgeyTvXtnnt2jQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FCE2817077;
        Fri,  8 Sep 2023 08:41:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85397525726;
        Fri,  8 Sep 2023 08:41:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230905141604.GA27370@lst.de>
References: <20230905141604.GA27370@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Lei Huang <lei.huang@linux.intel.com>, miklos@szeredi.hu,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Boris Pismenny <borisp@nvidia.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-mm@kvack.org, v9fs@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: getting rid of the last memory modifitions through gup(FOLL_GET)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1520559.1694162496.1@warthog.procyon.org.uk>
Date:   Fri, 08 Sep 2023 09:41:36 +0100
Message-ID: <1520560.1694162496@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> we've made some nice progress on converting code that modifies user
> memory to the pin_user_pages interface, especially though the work
> from David Howells on iov_iter_extract_pages.  This thread tries to
> coordinate on how to finish off this work.

Right at this moment, I'm writing some kunit tests for iov_iter and I've found
at least one bug.

David

