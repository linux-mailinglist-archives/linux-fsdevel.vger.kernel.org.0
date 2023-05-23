Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A85870E6CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 22:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbjEWUoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 16:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238519AbjEWUoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 16:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9B71BC
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684874600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2AXwrxmIeNRwbgPUcfTuA7DYIUBj+3M4SsEiMK2Pk9Y=;
        b=bthr68D5uNMxyio5CkbrXcXf3mS2HRD9OqddnfRb6VN/eKi7Mbk/J0y5AA8qqtKpInWwJQ
        4zFbzLBZjE6PI6SbnQ6uL8xkqhJTpaZ0T2vnGEQOCgpzSoYMB7/GsJh1F+9+hjmqjWtL+g
        BfLs6BwxZ36bwoAiACoy3US3Bm317T4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-l3glK4kQPEiT2-OmO-TScA-1; Tue, 23 May 2023 16:43:19 -0400
X-MC-Unique: l3glK4kQPEiT2-OmO-TScA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59C3B185A78B;
        Tue, 23 May 2023 20:43:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DC2A492B0A;
        Tue, 23 May 2023 20:43:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <12153db1-20af-040b-ded0-31286b5bafca@kernel.org>
References: <12153db1-20af-040b-ded0-31286b5bafca@kernel.org> <20230522135018.2742245-1-dhowells@redhat.com> <20230522135018.2742245-26-dhowells@redhat.com>
To:     Damien Le Moal <dlemoal@kernel.org>
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
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v22 25/31] zonefs: Provide a splice-read wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3071147.1684874594.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 23 May 2023 21:43:14 +0100
Message-ID: <3071148.1684874594@warthog.procyon.org.uk>
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

Damien Le Moal <dlemoal@kernel.org> wrote:

> > +	if (len > 0) {
> > +		ret =3D filemap_splice_read(in, ppos, pipe, len, flags);
> > +		if (ret =3D=3D -EIO)
> =

> Is -EIO the only error that filemap_splice_read() may return ? There are=
 other
> IO error codes that we could get from the block layer, e.g. -ETIMEDOUT e=
tc. So
> "if (ret < 0)" may be better here ?

It can return -ENOMEM, -EINTR and -EAGAIN at least, none of which really c=
ount
as I/O errors.  I based the splice function on what zonefs_file_read_iter(=
)
does:

	} else {
		ret =3D generic_file_read_iter(iocb, to);
		if (ret =3D=3D -EIO)
			zonefs_io_error(inode, false);
	}

David

