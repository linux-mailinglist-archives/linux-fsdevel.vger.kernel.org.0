Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1980697CFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjBONS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjBONS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:18:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAE2B749
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676467085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2VI9LQ93QCS9/VaDCzNyslbiwpgq4KQbuN5xAQtK3uM=;
        b=D55hPOJsJfXKbZ1b+9TbJnzUg5O4eu14Tx6dP9418PhH2GAAv5TDCoxQ/MjfCvli2Y4rlX
        DW1kBwiB0tbxKcPvj8WmgVBrtMGyXSPnWmBc1pE1RVT0H0bYUdp45FHtAQH0EstuAoOXS3
        ijvBTJwd/G9GkV1JY7n1L4ryRfmadJA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-4hfXO2ydNASLc3T-rKl-Qg-1; Wed, 15 Feb 2023 08:18:02 -0500
X-MC-Unique: 4hfXO2ydNASLc3T-rKl-Qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0020C28004E9;
        Wed, 15 Feb 2023 13:18:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 016712026D4B;
        Wed, 15 Feb 2023 13:17:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+nzO2H8AizX4lAQ@infradead.org>
References: <Y+nzO2H8AizX4lAQ@infradead.org> <Y+UJAdnllBw+uxK+@casper.infradead.org> <20230209102954.528942-1-dhowells@redhat.com> <20230209102954.528942-2-dhowells@redhat.com> <909202.1675959337@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v14 01/12] splice: Fix O_DIRECT file read splice to avoid reversion of ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Feb 2023 13:17:56 +0000
Message-ID: <3057147.1676467076@warthog.procyon.org.uk>
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

> > +	pages =3D (void *)(bv + npages);
>=20
> I think this cast should be to struct page **=E2=80=A6 not void *.

Yeah.  Doesn't change anything functionally, though, I think.

> > +	/* Free any pages that didn't get touched at all. */
> > +	reclaim /=3D PAGE_SIZE;
>=20
> Any reason not to keep reclaim in PAGE_SIZE units to start with?

Probably not, but I don't want to fiddle with that right now.  I can send a
follow up patch for it.

David

