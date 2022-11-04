Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DF161A03F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 19:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKDSsf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 14:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKDSs1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0833B59FC0
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667587650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lJfsTHY6tba7ZQacb0L0SXoAUwbrxp/Y0LpbDnploq0=;
        b=O+E6iJRFzl7QUrpGAM8lti6czUmXneKzMvTa4miZnuHnXqpvvhRC0lnEA5gGSw6ftwvpIs
        p4KSf7LFeS5h0+N3LoN2yAonQYWIob+3OEW6rOnPEOSdK2WPFPHQPX/foskKnqbMrFx2J1
        ym4kZa23HTG0zc1EP3Ud3IxkcBu2Gvw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-zAFmLBlFNrCWx9rm7prL4w-1; Fri, 04 Nov 2022 14:47:27 -0400
X-MC-Unique: zAFmLBlFNrCWx9rm7prL4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73AEC185A78F;
        Fri,  4 Nov 2022 18:47:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD547400EA89;
        Fri,  4 Nov 2022 18:47:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <67142.1666978314@warthog.procyon.org.uk>
References: <67142.1666978314@warthog.procyon.org.uk> <Y1btOP0tyPtcYajo@ZenIV> <Y01VjOE2RrLVA2T6@infradead.org> <1762414.1665761217@warthog.procyon.org.uk> <1415915.1666274636@warthog.procyon.org.uk> <Y1an1NFcowiSS9ms@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        willy@infradead.org, dchinner@redhat.com,
        Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlayton@redhat.com
Subject: Re: How to convert I/O iterators to iterators, sglists and RDMA lists
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1014263.1667587643.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 04 Nov 2022 18:47:23 +0000
Message-ID: <1014264.1667587643@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > What protects pages involved in ITER_XARRAY iterator created by
> > afs_read_dir()?  Note that we are not guaranteed inode_lock() on
> > the directory in question...
> =

> Yeah - that needs fixing.  The size of the data can change, but I don't =
update
> the iterator.

Actually, no.  The iterator is the output buffer for afs_fetch_data().  If=
 the
buffer turned out to be too small we drop the validate_lock and go round a=
nd
try again.

req->actual_len and req->file_size are updated by afs_fetch_data() from th=
e
RPC reply.  req->len tells the RPC delivery code how big the buffer is (wh=
ich
we don't have to fill if there's less data available than we have buffer
space).

David

