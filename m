Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E1170A2CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 00:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjESW2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 18:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjESW2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 18:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622B51A8
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684535276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N8SCLY3o4J6b9Y2pJlg3hyrvURsXqrxf9JlUVv4zhn4=;
        b=Zt17/oDUwxQIaMgJRDfpoTbQqJry8YkbMQf/gD3ZsLdEF9FqapRKlHYrcERwmQDD6I5tyM
        FJbWdliFo3GFOWG5cfX+hTuJ2TXC/9cJrDqxs3zadiaFP5Xc2gP1dEe2M8BN6K8MgDUzOk
        EUDh2uthQTtZl/aaERPVky5km/SyeNk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-CHpRL3_TMzyLAsNxrRHseg-1; Fri, 19 May 2023 18:27:54 -0400
X-MC-Unique: CHpRL3_TMzyLAsNxrRHseg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 124DF2A59551;
        Fri, 19 May 2023 22:27:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7BB5492B0A;
        Fri, 19 May 2023 22:27:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZGc3vUU/bUpt+3Tm@infradead.org>
References: <ZGc3vUU/bUpt+3Tm@infradead.org> <ZGcusJQfz68H1s7S@infradead.org> <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-4-dhowells@redhat.com> <1742093.1684485814@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v20 03/32] splice: Make direct_read_splice() limit to eof where appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2154517.1684535271.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 19 May 2023 23:27:51 +0100
Message-ID: <2154518.1684535271@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Okay.  Let's go with that.  So I have to put the handling in vfs_splice_re=
ad():

	long vfs_splice_read(struct file *in, loff_t *ppos,
			     struct pipe_inode_info *pipe, size_t len,
			     unsigned int flags)
	{
	...
		if (unlikely(!in->f_op->splice_read))
			return warn_unsupported(in, "read");
		/*
		 * O_DIRECT and DAX don't deal with the pagecache, so we
		 * allocate a buffer, copy into it and splice that into the pipe.
		 */
		if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
			return copy_splice_read(in, ppos, pipe, len, flags);
		return in->f_op->splice_read(in, ppos, pipe, len, flags);
	}

which leaves very little in generic_file_splice_read:

	ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
					 struct pipe_inode_info *pipe, size_t len,
					 unsigned int flags)
	{
		if (unlikely(*ppos >=3D in->f_mapping->host->i_sb->s_maxbytes))
			return 0;
		if (unlikely(!len))
			return 0;
		return filemap_splice_read(in, ppos, pipe, len, flags);
	}

so I wonder if the tests in generic_file_splice_read() can be folded into
vfs_splice_read(), pointers to generic_file_splice_read() be replaced with
pointers to filemap_splice_read() and generic_file_splice_read() just be
removed.

I suspect we can't quite do this because of the *ppos check - but I wonder=
 if
that's actually necessary since filemap_splice_read() checks against
i_size... or if the check can be moved there if we definitely want to do i=
t.

Certainly, the zero-length check can be done in vfs_splice_read().

David

