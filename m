Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156B14F7676
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 08:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbiDGGoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 02:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiDGGoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DD8411BD97
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 23:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649313724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ghX0s+qnM0zTWcdVKam262S3A8knYr1UnlFhPf0e+YY=;
        b=VFiNnRWi1NcGMCujg3ydJvn5O9/GB5O91eNT4Q8hVL01LubHGoCltJ+ja7GT6O71hRmV8A
        TVgxdmnoOjnH6rVj52W9E4aAqUzNAfmF7p7B1o+3vsHAh2wxgn4OZCJxWZOBBJ6fDex3EH
        n6Zbpsv9SFL/5l+BCZEX4FB88npX1Fc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-HESEfiTVOlu5reogbnkCLQ-1; Thu, 07 Apr 2022 02:42:01 -0400
X-MC-Unique: HESEfiTVOlu5reogbnkCLQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B4DA811E80;
        Thu,  7 Apr 2022 06:41:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E753D401E2B;
        Thu,  7 Apr 2022 06:41:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yk5W6zvvftOB+80D@casper.infradead.org>
References: <Yk5W6zvvftOB+80D@casper.infradead.org> <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk> <164928630577.457102.8519251179327601178.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 14/14] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <469868.1649313707.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 07 Apr 2022 07:41:47 +0100
Message-ID: <469869.1649313707@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Thu, Apr 07, 2022 at 12:05:05AM +0100, David Howells wrote:
> > Fix this by adding an extra address_space operation, ->removing folio(=
),
> > and flag, AS_NOTIFY_REMOVING_FOLIO.  The operation is called if the fl=
ag is
> > set when a folio is removed from the pagecache.  The flag should be se=
t if
> > a non-NULL cookie is obtained from fscache and cleared in ->evict_inod=
e()
> > before truncate_inode_pages_final() is called.
> =

> What's wrong with ->freepage?

It's too late.  The optimisation must be cancelled before there's a chance
that a new page can be allocated and attached to the pagecache - but
->freepage() is called after the folio has been removed.  Doing it in
->freepage() would allow ->readahead(), ->readpage() or ->write_begin() to
jump in and start a new read (which gets skipped because the optimisation =
is
still in play).

Another possibility could be that the FSCACHE_COOKIE_HAVE_DATA and
FSCACHE_COOKIE_NO_DATA_TO_READ flags could be moved from cookie->flags to
mapping->flags and the VM could do the twiddling itself (no aop required) =
-
except that fscache can't currently then find them (maybe use an aop for
that?).

David

