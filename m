Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64BE698004
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 16:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBOP5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 10:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjBOP5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:57:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E759A8
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 07:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676476583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nm0HPTn1WBz7EEySW5XokT/OmRqPcGxSZjzB2Xj17F8=;
        b=DvZUbSpgxOMd6osP1fqhajfXtco/BkN2cztH+lv1WdQu2rGd3tO/zHE7Bl5DC9BUcKnC2d
        DH7OkESVWDy/UN6p4aQvzKNIX1awE3c8RhYLekh7pHSICBJ99MtSrqOQ7PWr5GuPZjkxNy
        pYcdWiAoWJTNhw70WAmXkqqXsOIS+eA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-e4UuQIm_MQKz2GqYpEKZQQ-1; Wed, 15 Feb 2023 10:56:15 -0500
X-MC-Unique: e4UuQIm_MQKz2GqYpEKZQQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7DA68027EB;
        Wed, 15 Feb 2023 15:56:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C337492B0E;
        Wed, 15 Feb 2023 15:56:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+zrNiDsC0Mt7JAc@infradead.org>
References: <Y+zrNiDsC0Mt7JAc@infradead.org> <Y+nzO2H8AizX4lAQ@infradead.org> <Y+UJAdnllBw+uxK+@casper.infradead.org> <20230209102954.528942-1-dhowells@redhat.com> <20230209102954.528942-2-dhowells@redhat.com> <909202.1675959337@warthog.procyon.org.uk> <3057147.1676467076@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, smfrench@gmail.com
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3370609.1676476569.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Feb 2023 15:56:09 +0000
Message-ID: <3370610.1676476569@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

> On Wed, Feb 15, 2023 at 01:17:56PM +0000, David Howells wrote:
> > Probably not, but I don't want to fiddle with that right now.  I can s=
end a
> > follow up patch for it.
> =

> Honestly, I think this rush for 6.3 inclusion is a really bad idea.
>
> This series fundamentally changes how splice reads work, and has only
> been out for about a week.  It hasn't even been Cc'ed to Al

Sorry, what?!  Al has been To'd or cc'd on every patch.

> and Linus

I don't know that it's necessary to cc Linus on everything.  Jens is the
splice maintainer, I thought.

> which generally have a good knowledge of the splice code and an opinion
> on it.
> =

> I think it is a good change, but I'd feel much more comfortable with
> it for the next merge window rather than rushing it.

The lack of iov_iter_extract_pages() is blocking other things I want to wo=
rk
on - and will push those out another 3 months further beyond this.

I'm fine with dropping the block layer changes and most of the splice chan=
ges,
but I do want to try to get patches 1-3, 10 and 11:

 mm: Pass info, not iter, into filemap_get_pages()
 splice: Add a func to do a splice from a buffered file without ITER_PIPE
 splice: Add a func to do a splice from an O_DIRECT file without ITER_PIPE
 iov_iter: Add a function to extract a page list from an iterator
 iov_iter: Define flags to qualify page extraction.

upstream through the cifs tree if you, Jens and Steve French have no
objection, with my cifs iteratorisation patches on top.  It shouldn't affe=
ct
anything other than cifs in this merge window, barring the change to the f=
lags
to iov_iter_get_pages*().

David

