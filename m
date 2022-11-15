Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAC3628E8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 01:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiKOAmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 19:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiKOAmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:42:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581391B1C9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 16:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668472871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjYfp2hW5B/t44pYPHObfllFdrU8NC2GUrC2Ho+QsFY=;
        b=eh7bihopSjCNIX/RQTaEoXB9zbLbaRvgm8vj3Wj+CswdxLvAE83rWMjfj+09nG71xc/VmY
        0NDGAmzfXh7dKjqBi10rVF7VynWxcMFT5Y6eHpWVNVO8osjEVYanNqTKNDl74QpfqZQaou
        +LRvfNT63d/bVehoeGc7KmVHfWXtU40=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-1FDKG86uNcGiCRr5tfa-9Q-1; Mon, 14 Nov 2022 19:41:08 -0500
X-MC-Unique: 1FDKG86uNcGiCRr5tfa-9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 791EC3814587;
        Tue, 15 Nov 2022 00:41:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75D27400DFD4;
        Tue, 15 Nov 2022 00:41:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y3Lbul7FZncNVwVZ@codewreck.org>
References: <Y3Lbul7FZncNVwVZ@codewreck.org> <166844174069.1124521.10890506360974169994.stgit@warthog.procyon.org.uk>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, willy@infradead.org, dwysocha@redhat.com,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1457984.1668472862.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 15 Nov 2022 00:41:02 +0000
Message-ID: <1457985.1668472862@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> wrote:

> any harm in setting this if netfs isn't enabled?
> (just asking because you checked in fs/9p/cache.c above)

Well, it forces a call to ->release_folio() every time a folio is released=
, if
set, rather than just if PG_private/PG_private_2 is set.

> > +static inline void mapping_clear_release_always(struct address_space =
*mapping)
> > +{
> > +	set_bit(AS_RELEASE_ALWAYS, &mapping->flags);
> =

> clear_bit certainly?

Bah.  Yes.

> > -	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
> > +	if (!filemap_release_folio(folio, 0))
> =

> should this (and all others) check for folio_needs_release instead of ha=
s_private?
> filemap_release_folio doesn't check as far as I can see, but perhaps
> it's already fast and noop for another reason I didn't see.

Willy suggested merging the checks from folio_has_private() into
filemap_release_folio():

	https://lore.kernel.org/r/Yk9V/03wgdYi65Lb@casper.infradead.org/

David

