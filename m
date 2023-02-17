Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAD869A7B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 10:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBQJBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 04:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjBQJA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:00:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC65E604FE
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 01:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676624410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPCk17Mouat/TBH5mlaAsgT9/3K10wB1QNqvj5iJ3ZA=;
        b=XaWdWpNFE1Wbr/iFDXIa+W4PZp8ZoQLjtGdH6VKVMx865SCDspl/1LHM1+YraAQdOTbAeI
        l838SHb6RZmN2PTJktVj35loitGKbz96ezjPN8Bxa3HwxVhwJ+WGQn3V65ESBydk9OWiki
        YRNTnzbb4JZAGsfDQa2D4aIzy4iUIqQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-Go1PN4SZM9SYllW9uTMn5w-1; Fri, 17 Feb 2023 04:00:04 -0500
X-MC-Unique: Go1PN4SZM9SYllW9uTMn5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 132CA299E75E;
        Fri, 17 Feb 2023 09:00:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F076F1121314;
        Fri, 17 Feb 2023 09:00:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230216214745.3985496-4-dhowells@redhat.com>
References: <20230216214745.3985496-4-dhowells@redhat.com> <20230216214745.3985496-1-dhowells@redhat.com>
Cc:     dhowells@redhat.com, Steve French <smfrench@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 03/17] splice: Add a func to do a splice from an O_DIRECT file without ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4125891.1676624401.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 17 Feb 2023 09:00:01 +0000
Message-ID: <4125892.1676624401@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index 6cb65df3e3ba..d2c3f16cf6b1 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -156,6 +156,26 @@ static inline bool pipe_full(unsigned int head, uns=
igned int tail,
>  	return pipe_occupancy(head, tail) >=3D limit;
>  }
>  =

> +/**
> + * pipe_buf - Return the pipe buffer for the specified slot in the pipe=
 ring
> + * @pipe: The pipe to access
> + * @slot: The slot of interest
> + */
> +static inline struct pipe_buffer *pipe_buf(const struct pipe_inode_info=
 *pipe,
> +					   unsigned int slot)
> +{
> +	return &pipe->bufs[slot & (pipe->ring_size - 1)];
> +}
> +
> +/**
> + * pipe_head_buf - Return the pipe buffer at the head of the pipe ring
> + * @pipe: The pipe to access
> + */
> +static inline struct pipe_buffer *pipe_head_buf(const struct pipe_inode=
_info *pipe)
> +{
> +	return pipe_buf(pipe, pipe->head);
> +}
> +
>  /**
>   * pipe_buf_get - get a reference to a pipe_buffer
>   * @pipe:	the pipe that the buffer belongs to
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index f9a3ff37ecd1..47c484551c59 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -186,12 +186,6 @@ static int copyin(void *to, const void __user *from=
, size_t n)
>  	return res;
>  }
>  =

> -static inline struct pipe_buffer *pipe_buf(const struct pipe_inode_info=
 *pipe,
> -					   unsigned int slot)
> -{
> -	return &pipe->bufs[slot & (pipe->ring_size - 1)];
> -}
> -
>  #ifdef PIPE_PARANOIA
>  static bool sanity(const struct iov_iter *i)
>  {

This needs moving to the previous patch, but no code change overall.

David

