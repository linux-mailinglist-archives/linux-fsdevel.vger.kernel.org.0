Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561825FEFC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 16:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJNOHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 10:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJNOHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C5F2CDC3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665756396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTDMT5dUS3Kh1fBWxDZJMEprgSmNC1zcod1UBzX5NVw=;
        b=O5RCUffuWQ3K17Dot6GgX/SmFwU5aRvfjPhgdPScGdiqbG9rgkHeHzsZGlnQnuO9/WjJ33
        CnQAH8dP1wmGQl3ExTrm4k5HkMpyhaK/2OC6oXnAHIlDKvPd+TpFiYvtXqWLcXDEcrQO/o
        l6SGUgMjZkXJqdm5EJr8ksagRaCdKdM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-CAqzT3VWOAucnqmqLG9C7g-1; Fri, 14 Oct 2022 10:06:32 -0400
X-MC-Unique: CAqzT3VWOAucnqmqLG9C7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F3DA832D3E;
        Fri, 14 Oct 2022 14:06:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EF761155889;
        Fri, 14 Oct 2022 14:06:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YwWgdekd+f3MqVmu@infradead.org>
References: <YwWgdekd+f3MqVmu@infradead.org> <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk> <166126393409.708021.16165278011941496946.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iov_iter: Add a function to extract an iter's buffers to a bvec iter
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1584070.1665756368.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 14 Oct 2022 15:06:08 +0100
Message-ID: <1584071.1665756368@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Aug 23, 2022 at 03:12:14PM +0100, David Howells wrote:
> > Copy cifs's setup_aio_ctx_iter() and to lib/iov_iter.c and generalise =
it as
> > extract_iter_to_iter().  This allocates and sets up an array of bio_ve=
cs
> > for all the page fragments in an I/O iterator and sets a second suppli=
ed
> > iterator to bvec-type pointing to the array.
> =

> Did you read my NACK and comments from last time?

No, because they ended up in a different mailbox from everything else for =
some
reason.

> I really do not like this as a general purpose helper.  This is an odd
> quirk that we really generally should not needed unless you have very
> convoluted locking.  So please keep it inside of cifs.

I'm using it in under-development netfslib code also.

Let me ask the question more generally in a separate email.

David

