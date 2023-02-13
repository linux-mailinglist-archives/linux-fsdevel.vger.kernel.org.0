Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F1C69426A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 11:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjBMKMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 05:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjBMKLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:11:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46333E076
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 02:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676283072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mxvg2WeSSYepNmRAeMMprQgzHEYhBBIJc+RnE/mAhL0=;
        b=J2P1MYEjGVUdDUN+G/Uvv9wNATyKfoCIViudDJKoa9v/OwsqCW/JDDHcNZYN3Lf82PxSrY
        A5je5g5+4X3cwrQ1uDBvNArVOFn/YcgLqM7CyqKal1rMFjOWTx6rUFvGD+GRp+6n4oM7Vm
        PlcWlRgzTYTpfYwcN3gsGqpMtXwa/YA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-KbKwODwGPUWbTKJaN_2DPA-1; Mon, 13 Feb 2023 05:11:05 -0500
X-MC-Unique: KbKwODwGPUWbTKJaN_2DPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C53D29ABA1B;
        Mon, 13 Feb 2023 10:11:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1085E2026D76;
        Mon, 13 Feb 2023 10:11:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+n0n2UE8BQa/OwW@infradead.org>
References: <Y+n0n2UE8BQa/OwW@infradead.org> <20230209102954.528942-1-dhowells@redhat.com> <20230209102954.528942-4-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v13 03/12] splice: Do splice read from a buffered file without using ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1753988.1676283061.1@warthog.procyon.org.uk>
Date:   Mon, 13 Feb 2023 10:11:01 +0000
Message-ID: <1753989.1676283061@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> Also why doesn't this use init_sync_kiocb?

I'm not sure I want ki_flags.

> >  	if (in->f_flags & O_DIRECT)
> >  		return generic_file_direct_splice_read(in, ppos, pipe, len, flags);
> > +	return generic_file_buffered_splice_read(in, ppos, pipe, len, flags);
> 
> Btw, can we drop the verbose generic_file_ prefix here?

Probably.  Note that at some point cifs, for example, running in "unbuffered"
mode might want to call [generic_file_]direct_splice_read() directly.

David

