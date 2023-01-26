Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCBE67D08A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 16:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjAZPpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 10:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjAZPo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:44:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C8C144
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 07:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674747851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rr0bJKYD7HW0bq2QjmRCIf4xDMJorjCKl6OiT/Ad0U=;
        b=U73Tl/gB3ZmOKTC3/NvLmiBTaLHCreckhow842z5EVf24nllYw0rqnGJ/FI/lL/ngRAf/d
        ycdKUcVodDYMdr2mqvUQGABinZrTx57iA3AfAjdrZLAfqmNOXx28+Dv183EbTVOHWEhtIi
        udzb1Q1MCuI+rIxaJcABTjNsVk9m43I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-1URoSKkwPB2aeBwaq-7GZg-1; Thu, 26 Jan 2023 10:44:08 -0500
X-MC-Unique: 1URoSKkwPB2aeBwaq-7GZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B57C855711;
        Thu, 26 Jan 2023 15:44:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F54A2026E04;
        Thu, 26 Jan 2023 15:44:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <0d53a3cc9f9448298bba04d06f51b23d@AcuMS.aculab.com>
References: <0d53a3cc9f9448298bba04d06f51b23d@AcuMS.aculab.com> <20230125214543.2337639-1-dhowells@redhat.com> <20230125214543.2337639-9-dhowells@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com, Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        "Tom Talpey" <tom@talpey.com>, Stefan Metzmacher <metze@samba.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>
Subject: Re: [RFC 08/13] cifs: Add a function to read into an iter from a socket
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2862712.1674747841.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 26 Jan 2023 15:44:01 +0000
Message-ID: <2862713.1674747841@warthog.procyon.org.uk>
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

David Laight <David.Laight@ACULAB.COM> wrote:

> On the face of it that passes a largely uninitialised 'struct msghdr'
> to cifs_readv_from_socket() in order to pass an iov_iter.
> That seems to be asking for trouble.
> =

> If cifs_readv_from_socket() only needs the iov_iter then wouldn't
> it be better to do the wrapper the other way around?
> (Probably as an inline function)
> Something like:
> =

> int
> cifs_readv_from_socket(struct TCP_Server_Info *server, struct msghdr *sm=
b_msg)
> {
> 	return cifs_read_iter_from_socket(server, &smb_msg->msg_iter, smb_msg->=
msg_iter.count);
> }
> =

> and then changing cifs_readv_from_socket() to just use the iov_iter.

Yeah.  And smbd_recv() only cares about the iterator too.

> I'm also not 100% sure that taking a copy of an iov_iter is a good idea.

It shouldn't matter as the only problematic iterator is ITER_PIPE (advanci=
ng
that has side effects) - and splice_read is handled specially by patch 4. =
 The
problem with splice_read with the way cifs works is that it likes to subdi=
vide
its read/write requests across multiple reqs and then subsubdivide them if
certain types of failure occur.  But you can't do that with ITER_PIPE.

I build an ITER_BVEC from ITER_PIPE, ITER_UBUF and ITER_IOVEC in the top
levels with pins inserted as appropriate and hand the ITER_BVEC down.  For
user-backed iterators it has to be done this way because the I/O may get
shuffled off to a different thread.

Reqs can then just copy the BVEC/XARRAY/KVEC and narrow the region because=
 the
master request at the top does holds the vector list and the top cifs leve=
l or
the caller above the vfs (eg. sys_execve) does what is necessary to retain=
 the
pages.

David

