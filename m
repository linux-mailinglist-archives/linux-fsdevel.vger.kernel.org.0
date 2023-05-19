Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A717092FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 11:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjESJZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 05:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjESJZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 05:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED4919A
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684488297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pfV01EUVDAMlcQXaMvsw0JKN2NbqBChEQxXiVek1+Jc=;
        b=LGlX7mZn3kFk6t8mMbaA2X1FI1065IdUmzgfoqclBX5rKElN6hILu1m07SJpvZbltzDLnM
        6ga8FhJtN1l7E+z81NH9x791e6Ks9wC9o4alHfkMnX0LGUo/2cCfFIsObxNwD1bjUuAVCL
        9fVQNca0fp9Oew09qDTXXIqIogIR6Sw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-10XT3QEBNXKSe4Iyf6x2aw-1; Fri, 19 May 2023 05:24:52 -0400
X-MC-Unique: 10XT3QEBNXKSe4Iyf6x2aw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0901F185A791;
        Fri, 19 May 2023 09:24:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 027F540D1B60;
        Fri, 19 May 2023 09:24:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <c1fd63b9-42ea-fa83-ecb1-9af715e37ffa@redhat.com>
References: <c1fd63b9-42ea-fa83-ecb1-9af715e37ffa@redhat.com> <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-14-dhowells@redhat.com>
To:     Xiubo Li <xiubli@redhat.com>
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
        Christoph Hellwig <hch@lst.de>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Subject: Re: [PATCH v20 13/32] ceph: Provide a splice-read stub
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1743655.1684488288.1@warthog.procyon.org.uk>
Date:   Fri, 19 May 2023 10:24:48 +0100
Message-ID: <1743656.1684488288@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Xiubo Li <xiubli@redhat.com> wrote:

> > +	ret = ceph_get_caps(in, CEPH_CAP_FILE_RD, want, -1, &got);
> > +	if (ret < 0) {
> > +		ceph_end_io_read(inode);
> > +		return ret;
> > +	}
> > +
> > +	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) == 0) {
> > +		dout("splice_read/sync %p %llx.%llx %llu~%zu got cap refs on %s\n",
> > +		     inode, ceph_vinop(inode), *ppos, len,
> > +		     ceph_cap_string(got));
> > +
> > +		ceph_end_io_read(inode);
> > +		return direct_splice_read(in, ppos, pipe, len, flags);
> 
> Shouldn't we release cap ref before returning here ?

Ummm...  Even if we got no caps?

David

