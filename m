Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD027765C78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 21:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjG0TwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 15:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjG0TwC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C893AAE
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690487452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/nw8whqMcC5WOFFNcrWxqOQTv8DnzLwL5HhkU05t3og=;
        b=Qcgbi3RhCY+0d0wvUFPoyMeREbstVDJyHoy6fs+zn9zpKxfaHDcHdjsX7ilJLZuMZWESSC
        TKwAPqkdo5WiXwost/XMfDbJrjPF+BOM0TzZSHqkP0ecqRTjZEUEEiQ7MFPVHb6LIw+f3Q
        hDNk6U4/d6Z+NqWz7RWOey8cwGKQNOM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-USy43ND5Ooy4YgNf-hLNXQ-1; Thu, 27 Jul 2023 15:50:47 -0400
X-MC-Unique: USy43ND5Ooy4YgNf-hLNXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72F801044589;
        Thu, 27 Jul 2023 19:50:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05C7E4094DC0;
        Thu, 27 Jul 2023 19:50:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <bd497349-1cce-7c29-8b8f-d95f10e534e6@google.com>
References: <bd497349-1cce-7c29-8b8f-d95f10e534e6@google.com> <20230727161016.169066-1-dhowells@redhat.com> <20230727161016.169066-3-dhowells@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] shmem: Apply a couple of filemap_splice_read() fixes to shmem_splice_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <178917.1690487444.1@warthog.procyon.org.uk>
Date:   Thu, 27 Jul 2023 20:50:44 +0100
Message-ID: <178918.1690487444@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hugh Dickins <hughd@google.com> wrote:

> Which made me wonder whether the file_inode -> f_mapping->host
> change was appropriate elsewhere.

It's sometimes confusing.  There are several (potentially) different inodes
available at some points.

David

