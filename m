Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC43666FD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 11:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbjALKiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 05:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbjALKhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:37:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B49459D03
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 02:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673519467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dkFkRWZUyU5kEKDjRnjZ/+Iyi+3josF/HBLQ+8tNZk=;
        b=Q00lrvPXXxGt7ptyDFt+G77VEpCR9aFPrZu2PxZ1sFJdWnvO20joUV8vDs8o0oQurHbas5
        ijecRBK3qRYKFAsn6pipG3XIcIivK9ID7YSTcmrvlnhq89cvjtiyYmMHF+RZZuwKcPLShF
        KJHxk+a/9Ik4faMGF87mt8Vt0uZdtws=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-ZVbWRtqtPv2wt_KeEy-Jkg-1; Thu, 12 Jan 2023 05:31:04 -0500
X-MC-Unique: ZVbWRtqtPv2wt_KeEy-Jkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA00E3C22745;
        Thu, 12 Jan 2023 10:31:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DF202026D68;
        Thu, 12 Jan 2023 10:31:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y7+8r1IYQS3sbbVz@infradead.org>
References: <Y7+8r1IYQS3sbbVz@infradead.org> <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk> <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iov_iter: Use IOCB/IOMAP_WRITE if available rather than iterator direction
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15329.1673519461.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 12 Jan 2023 10:31:01 +0000
Message-ID: <15330.1673519461@warthog.procyon.org.uk>
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

Christoph Hellwig <hch@infradead.org> wrote:

> > This allows all but three of the users of iov_iter_rw() to be got rid =
of: a
> > consistency check and a warning statement in cifs
> =

> Let's just drop these two.
> =

> > and one user in the block
> > layer that has neither available.
> =

> And use the information in the request for this one (see patch below),
> and then move this patch first in the series, add an explicit direction
> parameter in the gup_flags to the get/pin helper and drop iov_iter_rw
> and the whole confusing source/dest information in the iov_iter entirely=
,
> which is a really nice big tree wide cleanup that remove redundant
> information.

Fine by me, but Al might object as I think he wanted the internal checks. =
 Al?

David

