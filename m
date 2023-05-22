Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D6770B508
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 08:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjEVG32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 02:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjEVG31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 02:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76705DB
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 23:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684736927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L51D923F/Qnr60svKwlOplic/YuXek4iXgzeRvfwk/0=;
        b=H+1d1j9aLq3Oq18E3f7GEC9EMUO3aH3I/kEF/VOdz2LK+Jck/TNaXydsJDOZrbnnQx8rl1
        73KySKx79/YYwj4w5hzBsW8JtdbLG6gSjOHZgX3rOKdkmHf2U9UreHvkXwKADzXFPHEpG8
        /MctF5H0lfRF/UhaIvF+1ArJxrqrUFA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-_JqmLVPHOXevZRe0HvSLeg-1; Mon, 22 May 2023 02:28:41 -0400
X-MC-Unique: _JqmLVPHOXevZRe0HvSLeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F1933C025A2;
        Mon, 22 May 2023 06:28:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC7E8C54184;
        Mon, 22 May 2023 06:28:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <376ab23b-52d0-d7fd-2dd9-414cbb474e01@linux.alibaba.com>
References: <376ab23b-52d0-d7fd-2dd9-414cbb474e01@linux.alibaba.com> <20230520000049.2226926-1-dhowells@redhat.com> <20230520000049.2226926-23-dhowells@redhat.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v21 22/30] ocfs2: Provide a splice-read stub
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2362050.1684736916.1@warthog.procyon.org.uk>
Date:   Mon, 22 May 2023 07:28:36 +0100
Message-ID: <2362051.1684736916@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Joseph Qi <joseph.qi@linux.alibaba.com> wrote:

> Don't see direct IO logic now. Am I missing something?

See that patch description ;-)

    Provide a splice_read stub for ocfs2.  This emits trace lines and does an
    atime lock/update before calling filemap_splice_read().  Splicing from
    direct I/O is handled by the caller.

David

