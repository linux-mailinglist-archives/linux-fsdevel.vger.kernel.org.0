Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB7B618016
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 15:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiKCOwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 10:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiKCOwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:52:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8B8193DB
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667487076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sDvbxldJL9NfWM/rF7vRKE9v471dsOifP77yfjP0j/4=;
        b=Q2rMxuJvb9W8qDaK1IGiEidoIdeWpej9LFlqCN235qihXRY6cD0/5L3e2fzY5sVeCLNAVO
        UQ0VoxWymeY1DNmuRQYxLLRqaRjvc94h2Naxr0nHWwNs5QyKoeSdnUZgmteElr6FsE6aA1
        tnW/IYixjFk+Dw0ADL67qRVUCpAK/rc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-aMoNoN09N2-yJG8Z6evDcA-1; Thu, 03 Nov 2022 10:51:12 -0400
X-MC-Unique: aMoNoN09N2-yJG8Z6evDcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13D063C3C963;
        Thu,  3 Nov 2022 14:51:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E93121121331;
        Thu,  3 Nov 2022 14:51:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y2IyTx0VwXMxzs0G@infradead.org>
References: <Y2IyTx0VwXMxzs0G@infradead.org> <cover.1666928993.git.ritesh.list@gmail.com> <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com> <20221028210422.GC3600936@dread.disaster.area> <Y19EXLfn8APg3adO@casper.infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve write performance
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7698.1667487070.1@warthog.procyon.org.uk>
Date:   Thu, 03 Nov 2022 14:51:10 +0000
Message-ID: <7699.1667487070@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > filesystems right now.  Dave Howells' netfs infrastructure is trying
> > to solve the problem for everyone (and he's been looking at iomap as
> > inspiration for what he's doing).
> 
> Btw, I never understod why the network file systems don't just use
> iomap.  There is nothing block specific in the core iomap code.

It calls creates and submits bio structs all over the place.  This seems to
require a blockdev.

Anyway, netfs lib supports, or hopefully will support in the future, the
following:

 (1) Fscache.  netfslib will construct a read you're asking for from cached
     data and data from the server and stitch them together (where a folio may
     comprise pieces from more than once source), and then write the bits it
     read from the server out to the cache...  And handle content encryption
     for you such that the data stored in the cache is content-encrypted.

     On writeback, the dirty data must be written to both the cache (if you
     have one) and the server (if you're not in disconnected operation).

 (2) Disconnected operation.  netfslib will, in the future, handle storing
     data and changes in the cache and then sync'ing on reconnection of an
     object.

 (3) I want to hand persistent (for the life of an op) iov_iters to the
     filesystem so that the filesystem can, if it wants to, pass these to the
     kernel_sendmsg() and kernel_recvmsg() in the bottom.

     The aim is to get knowledge of pages out of the network filesystem
     entirely.  A network filesystem would then provide two basic hooks to the
     server: async direct read and as async direct write.  netfslib will use
     these to access the pagecache on behalf of the filesystem.

 (4) Reads and writes might want to/need to be non-block-size aligned.  If we
     have a byte-range file lock, for example, or if we have a max block size
     (eg. rsize/wsize) set that's not a multiple of 512, say.

 (5) Compressed I/O.  You get back more data than you asked for and you want
     to paste the rest into the pagecache (if buffered) or discard it (if
     DIO).  Further, to make this work on write, we may need to hold on to
     pages on the sides of the one we modified to make sure we keep the right
     size blob of data to recompress and send back.

 (6) Larger cache block granularity.  One thing I want to explore is the
     ability to have blocks in the cache that are larger than PAGE_SIZE.  If I
     can't use the backing filesystem's knowledge of holes in a file, then I
     have to store my own metadata (ie. effectively build a filesystem on top
     of a filesystem).  To reduce that amount of metadata that I need, I can
     make the cache granule size larger.

     In both 5 and 6, netfslib gets to tell the VM layer to increase the size
     of the blob in readahead() - and then may have to forcibly keep the pages
     surrounding the page of interest if it gets modified in order to be able
     to write to the cache correctly, depending on how much integrity I want
     to try and keep in the cache.

 (7) Not-quite-direct-I/O.  cifs, for example, has a number of variations on
     read and write modes that are kind of but not quite direct I/O.

David

