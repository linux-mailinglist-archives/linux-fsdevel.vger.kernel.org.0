Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D7262F34C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 12:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241766AbiKRLIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 06:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbiKRLIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:08:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E299E93
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 03:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668769641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=brWgx9l6F8XGhC0KzgNYXhkmuY06b6mqU4fM8yW3Sac=;
        b=MaCWquTlBFWPiIRtwa7IhXQi1I+6VoGzlozU+xjhtPOHDsapTTD5NNyQK7CVS+PvNm7gcN
        3uAhZIOdQcvnLLhdTblunn2D1IGCfAALFFqG9zpcwDlrKyBeim10Z5K05R42NZRasunKjY
        wkBVYdGB8rOJpUu+vk0kkKDe+RmCNqM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-Q1xq2j-BOCWc9Bu79GAhmw-1; Fri, 18 Nov 2022 06:07:17 -0500
X-MC-Unique: Q1xq2j-BOCWc9Bu79GAhmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45F80185A79C;
        Fri, 18 Nov 2022 11:07:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D418640C6EC3;
        Fri, 18 Nov 2022 11:07:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <166869690376.3723671.8813331570219190705.stgit@warthog.procyon.org.uk>
References: <166869690376.3723671.8813331570219190705.stgit@warthog.procyon.org.uk> <166869687556.3723671.10061142538708346995.stgit@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <231862.1668769633.1@warthog.procyon.org.uk>
Date:   Fri, 18 Nov 2022 11:07:13 +0000
Message-ID: <231863.1668769633@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I updated the commit message to stop using pinning in a general sense:

    netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator
    
    Add a function to extract the pages from a user-space supplied iterator
    (UBUF- or IOVEC-type) into a BVEC-type iterator, retaining the pages by
    getting a ref on them (WRITE) or pinning them (READ) as we go.
    
    This is useful in three situations:
    
     (1) A userspace thread may have a sibling that unmaps or remaps the
         process's VM during the operation, changing the assignment of the
         pages and potentially causing an error.  Retaining the pages keeps
         some pages around, even if this occurs; futher, we find out at the
         point of extraction if EFAULT is going to be incurred.
    
     (2) Pages might get swapped out/discarded if not retained, so we want to
         retain them to avoid the reload causing a deadlock due to a DIO
         from/to an mmapped region on the same file.
    
     (3) The iterator may get passed to sendmsg() by the filesystem.  If a
         fault occurs, we may get a short write to a TCP stream that's then
         tricky to recover from.
    
    We don't deal with other types of iterator here, leaving it to other
    mechanisms to retain the pages (eg. PG_locked, PG_writeback and the pipe
    lock).

David

