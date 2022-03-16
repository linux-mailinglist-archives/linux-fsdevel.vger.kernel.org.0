Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD5E4DAD34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 10:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbiCPJHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 05:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354808AbiCPJHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D51B652F1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647421592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zCjdD5IbiVsEi6ffMk7QaDoa7R2A531SKqpiy5P2wyI=;
        b=Qm+8Lwb5wRa7iiOqOkUAr7BIPP8E7NCtwPnpfQW/xYYfYDMSddDpu9Q/nXQdWeRgwfZRl3
        yPCsKs097G6v7grYkxnXUU+VeZXN4E9lVPlhuJBc0ETmYjvfi3PGVWcI7lzSgu9vJppWJO
        x8FJVbbQkS29Y2aWkyNpp5c8rSCy9Gw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-v24-5oqOOmS0sM5icREgvQ-1; Wed, 16 Mar 2022 05:06:29 -0400
X-MC-Unique: v24-5oqOOmS0sM5icREgvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFEAE85A5BE;
        Wed, 16 Mar 2022 09:06:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA000C28100;
        Wed, 16 Mar 2022 09:06:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <164692909854.2099075.9535537286264248057.stgit@warthog.procyon.org.uk>
References: <164692909854.2099075.9535537286264248057.stgit@warthog.procyon.org.uk> <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/20] netfs: Add a netfs inode context
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3536451.1647421585.1@warthog.procyon.org.uk>
Date:   Wed, 16 Mar 2022 09:06:25 +0000
Message-ID: <3536452.1647421585@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I found a couple of issues here:

Firstly, netfs_is_cache_enabled() causes the generic/522 xfstest to take 60s
longer.  This can be fixed by:

-       return fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie);
+       return fscache_cookie_valid(cookie) && cookie->cache_priv &&
+               fscache_cookie_enabled(cookie);

There's no point trying to do caching if there's no cache actually attached.
I wonder if I should actually make this change in fscache_cookie_enabled()
rather than here.


Secondly, the above causes netfs_skip_folio_read() to be skipped a lot more
often than it should, and this hides an incorrect change there.  I made
netfs_skip_folio_read() copy the folio size into a variable to avoid issuing
the calculation multiple times, but I then gave the wrong length when clearing
the tail of the page.  This can be fixed by:

-       zero_user_segments(&folio->page, 0, offset, offset + len, len);
+       zero_user_segments(&folio->page, 0, offset, offset + len, plen);

David

