Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EAE4D3CE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 23:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbiCIW3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 17:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbiCIW3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:29:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5279F11943F
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 14:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646864884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVaegIYPMNuliKEZs1hQ0iCOAz5kKxaMcLvAsoa4pRE=;
        b=JG/j/SvptyO+bq6Na9b4tpgok9hrCjqPoQrhPpEa/vshn++pI/x/djWKO8AGYxCNLDGeiz
        GIAO4ENEjT3vGjXz3+ohf/b6JllMmayMWrek1ampeAVXNuwHIaRGS5sRCF2g/9OiDlCq24
        fBePSxfvMbGOyyV8J2iv+v/WZ41Uy+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-dFWyF8bnPDmAjCcY4C1Buw-1; Wed, 09 Mar 2022 17:28:01 -0500
X-MC-Unique: dFWyF8bnPDmAjCcY4C1Buw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74E6D1854E21;
        Wed,  9 Mar 2022 22:27:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB20E4E2AE;
        Wed,  9 Mar 2022 22:27:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2ebfd2f772ceef605896e58bbd0e733e1413ff71.camel@kernel.org>
References: <2ebfd2f772ceef605896e58bbd0e733e1413ff71.camel@kernel.org> <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk> <164678219305.1200972.6459431995188365134.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/19] netfs: Keep track of the actual remote file size
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1841544.1646864871.1@warthog.procyon.org.uk>
Date:   Wed, 09 Mar 2022 22:27:51 +0000
Message-ID: <1841545.1646864871@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> This seems like something useful, but I wonder if it'll need some sort
> of serialization vs. concurrent updates.

Quite possibly, though that may be something that we have to delegate to the
network filesystem.  kafs, for instance, performs local serialisation of
StoreData RPCs to any given inode because the server will exclusively lock the
remote vnode around the write-to-disk and callback break (ie. change
notification) phases.  This does not preclude, however, another client making
a change whilst the local lock is held.  Of course, in such a case, we're into
conflict resolution and may end up invalidating the local copy.

> Can we assume that netfs itself will never call netfs_resize_file?

Probably.  Depends on how truncation gets handled.

> Ceph already has some pretty complicated size tracking, since it can get
> async notifications of size changes from the MDS. We'll have to consider
> how to integrate this with what it does. Probably this will replace one
> (or more?) of its fields.

ceph's i_reported_size maybe?  cifs has server_eof.

> We may need to offer up some guidance wrt locking.

i_lock may be a good fit.  I wonder if it's worth at some point moving i_lock
to being a seqlock so that various values ordinarily protected by it are
accessible using read_seqbegin().

David

