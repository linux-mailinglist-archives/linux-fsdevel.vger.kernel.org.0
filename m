Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E53674445
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 22:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjASVYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 16:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjASVW3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:22:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F4CA295F
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 13:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674162895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1IMCqddgWykv8AXR/YeAqVJq9PsFQed00N0J64kJGo=;
        b=MpdbxkbQ8BHJ+SCUOPjSG6TsL9kIyZ08m44DPAo84draWE/fGQHZDJVKMdWqE3Zshay2Xg
        roOY+0nulyMwQcq+rhGled+TzFgAcP2tqhH+AYekziVElT4kAnMprxuaL+VGss1E/Ju+rG
        sqmiQfTK2K+IKS1UadvVx5C917eT98c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-hi1FagP5OzO-eBN77YCRog-1; Thu, 19 Jan 2023 16:14:49 -0500
X-MC-Unique: hi1FagP5OzO-eBN77YCRog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAE92181E3F4;
        Thu, 19 Jan 2023 21:14:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D291A51EF;
        Thu, 19 Jan 2023 21:14:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8l0Xdd0MKbuVa7z@infradead.org>
References: <Y8l0Xdd0MKbuVa7z@infradead.org> <Y8jYrahu45kkCRlq@infradead.org> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk> <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk> <Y8ZTyx7vM8NpnUAj@infradead.org> <Y8huoSe4j6ysLUTT@ZenIV> <2731230.1674128066@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/34] vfs: Unconditionally set IOCB_WRITE in call_write_iter()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3037548.1674162886.1@warthog.procyon.org.uk>
Date:   Thu, 19 Jan 2023 21:14:46 +0000
Message-ID: <3037549.1674162886@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> So what about deferring this whole cleanup for now?

So you'd rather I stick with the direction indicator in the iov_iter struct
for now?

I still want to add iov_iter_extract_pages(), netfs_extract_user_iter() and
netfs_extract_iter_to_sg(), even if it's only cifs and netfslib that use them
for the moment.

David

