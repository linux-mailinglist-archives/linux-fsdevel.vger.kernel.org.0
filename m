Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F30677C54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 14:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjAWNUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 08:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjAWNUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:20:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B70244BE
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 05:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674479999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2dXPaoH2gVDFVTSGvvio+eGDLGhUPptB34DHJn1Fsns=;
        b=A6QygSiYjMJKLnb8bw/VuRnAqkev+fJr9svfnNz8ap9RhQ1IkQnGSWOSjCKbxUixMBnYJ8
        93aPri67ujBh96IVGyaRPN9nsqDMg9FT1IXsfGMCE3UXNlvrYV8lFEvFZCKa9SmJtfmY56
        EpWnzjFDZpwtXip8V9cjdcqYDPXvoH8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-MArzK175NrugE9CKytvGCg-1; Mon, 23 Jan 2023 08:19:55 -0500
X-MC-Unique: MArzK175NrugE9CKytvGCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B59F31C29D41;
        Mon, 23 Jan 2023 13:19:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA1E9175A2;
        Mon, 23 Jan 2023 13:19:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
References: <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com> <246ba813-698b-8696-7f4d-400034a3380b@redhat.com> <20230120175556.3556978-1-dhowells@redhat.com> <20230120175556.3556978-3-dhowells@redhat.com> <3814749.1674474663@warthog.procyon.org.uk>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list from an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3903249.1674479992.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 23 Jan 2023 13:19:52 +0000
Message-ID: <3903251.1674479992@warthog.procyon.org.uk>
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

David Hildenbrand <david@redhat.com> wrote:

> Switching from FOLL_GET to FOLL_PIN was in the works by John H. Not sure=
 what
> the status is. Interestingly, Documentation/core-api/pin_user_pages.rst
> already documents that "CASE 1: Direct IO (DIO)" uses FOLL_PIN ... which=
 does,
> unfortunately, no reflect reality yet.

Yeah - I just came across that.

Should iov_iter.c then switch entirely to using pin_user_pages(), rather t=
han
get_user_pages()?  In which case my patches only need keep track of
pinned/not-pinned and never "got".

David

