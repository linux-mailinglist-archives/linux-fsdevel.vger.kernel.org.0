Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A5D671F5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 15:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjAROVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 09:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjAROUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:20:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B2663E06
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 06:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674050486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ciJVSFE+YF6g3e2z4P8ZEvg2a2y1ihge8c1pR/PRMpg=;
        b=XFG7RRoEiwa+w5bQSeMzN82/uosMCvv6JwD7LEnKzA//B3RzhMbbejmRmySJ6b/vw7xxdu
        mvbq9sQu5bofe3e0pBq6+flYTxK7W8P483JEjUtYDn+VLwIVjpSJAhkYGCP3++L9w5KHk0
        acQ5SRKY9eKajxFU25Ta3zERb+3qc6U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-vjE-fqjJOoKFX9u26vYQ6w-1; Wed, 18 Jan 2023 09:01:25 -0500
X-MC-Unique: vjE-fqjJOoKFX9u26vYQ6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3FF984B097;
        Wed, 18 Jan 2023 14:00:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E59E040C2006;
        Wed, 18 Jan 2023 14:00:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <167391054631.2311931.7588488803802952158.stgit@warthog.procyon.org.uk>
References: <167391054631.2311931.7588488803802952158.stgit@warthog.procyon.org.uk> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/34] bio: Rename BIO_NO_PAGE_REF to BIO_PAGE_REFFED and invert the meaning
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2673695.1674050454.1@warthog.procyon.org.uk>
Date:   Wed, 18 Jan 2023 14:00:54 +0000
Message-ID: <2673696.1674050454@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Actually, should I make it so that the bottom two bits of bi_flags are a
four-state variable and make it such that bio_release_page() gives a warning
if the state is 0 - ie. unset?

The states would then be, say:

	0	WARN(), do no cleanup
	1	FOLL_GET
	2	FOLL_PUT
	3	do no cleanup

This should help debug any places, such as iomap_dio_zero() that I just found,
that add pages with refs without calling iov_iter_extract_pages().

David

