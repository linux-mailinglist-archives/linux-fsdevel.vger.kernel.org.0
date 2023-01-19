Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4AF673659
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 12:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjASLHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 06:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjASLHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:07:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B144AA6B
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 03:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674126418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0iBRCuE35ufrccluuz5wzolK9I4l2Ow06A6e8hFso8=;
        b=ajPVHWR8szkpcN2wN5SnWSOVJRqVTmxKktzrGEkIxCIrNW8RxVwHGUvXRq/kwWbR1x9INd
        c0VhjljDzDlk/TChMy+72faFKWaAb9iq/RVutue2XjHtkF8Orr2yeCnWPrlFfkHLjv9Y0r
        k5MEMf5TofQjCL4GgXcVFmxiLkAjlZY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-hCORopCjOFu2yZVg-MnL3Q-1; Thu, 19 Jan 2023 06:06:55 -0500
X-MC-Unique: hCORopCjOFu2yZVg-MnL3Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA3E18A010B;
        Thu, 19 Jan 2023 11:06:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58764492B01;
        Thu, 19 Jan 2023 11:06:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8htMvG33I73oG9z@ZenIV>
References: <Y8htMvG33I73oG9z@ZenIV> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk> <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/34] vfs: Unconditionally set IOCB_WRITE in call_write_iter()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2728921.1674126412.1@warthog.procyon.org.uk>
Date:   Thu, 19 Jan 2023 11:06:52 +0000
Message-ID: <2728922.1674126412@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> ->write_iter() <- nvmet_file_submit_bvec()
> ->write_iter() <- call_write_iter() <- lo_rw_aio()

Could call init_kiocb() in lo_rw_aio() and then just overwrite ki_ioprio.

> ->write_iter() <- call_write_iter() <- fd_execute_rw_aio()

fd_execute_rw_aio() perhaps should call init_kiocb() since the struct is
allocated with kmalloc() and not fully initialised.

> ->write_iter() <- call_write_iter() <- vfs_iocb_iter_write()
>
> The last 4 neither set KIOCB_WRITE nor call init_sync_kiocb().

vfs_iocb_iter_write() is given an initialised kiocb.  It should not be calling
init_sync_kiocb() itself.

It's called from two places: cachefiles, which initialises the kiocb itself
and sets IOCB_WRITE, and overlayfs, which gets the kiocb from the VFS via its
->write_iter hook the caller of which should have already set IOCB_WRITE.

cachefiles should be using init_kiocb() - though since it used kzalloc,
init_kiocb() clearing the struct is redundant.

> What's more, there are places that call instances (or their guts - look at
> btrfs_do_write_iter() callers) directly...

At least in the case of btrfs_ioctl_encoded_write(), that can call
init_kiocb().  But as you say, there are more to be found.

David

