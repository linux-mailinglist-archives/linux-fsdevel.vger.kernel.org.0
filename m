Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8414631B6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 09:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKUIaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 03:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKUIaC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:30:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C326D19294
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 00:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669019347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nnjcm4Pb+dz4fQWD/2OgzoCAE3SVBNMrS92FUG2w2Lk=;
        b=Gkt5cfUu08epBTtGMJeqDj9Gwxklal+T7vBe3It47eiRkTK8OjGGHeUiRZyR2Q5Hw8rpI0
        dZFIfrl44FgQxWG7o6W/XdHz59aYM6IeWJlgNG7okzUa7GOj2FkiQ4DeuudQgbC74gupr+
        SwaueAsji4AQl83ev+LygQRXWMQe0Y4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-wjl7HxPAO8yzBriWblAZ5g-1; Mon, 21 Nov 2022 03:29:01 -0500
X-MC-Unique: wjl7HxPAO8yzBriWblAZ5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B1F1101A5DC;
        Mon, 21 Nov 2022 08:29:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05AA42027061;
        Mon, 21 Nov 2022 08:28:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221121071704.GC23882@lst.de>
References: <20221121071704.GC23882@lst.de> <166876785552.222254.4403222906022558715.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] afs: Stop implementing ->writepage()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <150666.1669019337.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 21 Nov 2022 08:28:57 +0000
Message-ID: <150667.1669019337@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> >  (1) afs_write_back_from_locked_folio() could be called directly rathe=
r
> >      than calling filemap_fdatawrite_wbc(), but that would avoid the
> >      control group stuff that wbc_attach_and_unlock_inode() and co. se=
em to
> >      do.  Do I actually need to do this?
> =

> That would be much preferred over the for_write_begin hack, given that
> write_begin really isn't a well defined method but a hacky hook for
> legacy write implementations.

So I don't need to worry about the control group stuff?  I'll still need s=
ome
way to flush a conflicting write whatever mechanism is being used to write=
 to
the page cache.

David

