Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D591D4D3A3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 20:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiCITZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 14:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbiCITYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:24:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E1821D0FB
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 11:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646853808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Z5XscNfbcs+yg9O+mP46TlJqahAAprLj05WH8utWWM=;
        b=LcoYPrPKGmSsv2NWjJmHVTYX0GyYdeOd/48+7EwaTpCjqifnH1EDp9AziK7/VdF0m+Wttc
        L17j9CzVpXCPs5BiN9sNmPbha9jVAVo+KjFUo+XC15ro9YZnTavYh2EzlSy4lf6QT65Pw+
        ENNuiXgIs5IvhIqPshePxAq/Hsm0Zu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-YdxP3QPhOBahVoSrble-Vg-1; Wed, 09 Mar 2022 14:23:24 -0500
X-MC-Unique: YdxP3QPhOBahVoSrble-Vg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E7EB1854E21;
        Wed,  9 Mar 2022 19:23:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAFF345D76;
        Wed,  9 Mar 2022 19:23:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <8af0d47f17d89c06bbf602496dd845f2b0bf25b3.camel@kernel.org>
References: <8af0d47f17d89c06bbf602496dd845f2b0bf25b3.camel@kernel.org> <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk> <164678213320.1200972.16807551936267647470.stgit@warthog.procyon.org.uk>
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
Subject: Re: [PATCH v2 12/19] netfs: Add a netfs inode context
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1790299.1646853782.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 09 Mar 2022 19:23:02 +0000
Message-ID: <1790300.1646853782@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> > Add a netfs_i_context struct that should be included in the network
> > filesystem's own inode struct wrapper, directly after the VFS's inode
> > struct, e.g.:
> > =

> > 	struct my_inode {
> > 		struct {
> > 			struct inode		vfs_inode;
> > 			struct netfs_i_context	netfs_ctx;
> > 		};
> =

> This seems a bit klunky.
>
> I think it'd be better encapsulation to give this struct a name (e.g.
> netfs_inode) and then have the filesystems replace the embedded
> vfs_inode with a netfs_inode.

I think what you really want is:

	struct my_inode : netfs_inode {
	};

right? ;-)

> That way it's still just pointer math to get to the context from the
> inode and vice versa, but the replacement seems a bit cleaner.
> =

> It might mean a bit more churn in the filesystems themselves as you
> convert them, but most of them use macros or inline functions as
> accessors so it shouldn't be _too_ bad.

That's a lot of churn - and will definitely cause conflicts with other
patches aimed at those filesystems.  I'd prefer to avoid that if I can.

> > +static int ceph_init_request(struct netfs_io_request *rreq, struct fi=
le *file)
> > +{
> > ...
> > +}
> > +
> =

> ^^^
> The above change seems like it should be in its own patch. Wasn't it at
> one point? Converting this to use init_request doesn't seem to rely on
> the new embedded context.

Well, I wrote it as a separate patch on the end for convenience, but I
intended to merge it here otherwise ceph wouldn't be able to do readahead =
for
a few patches.

I was thinking that it would require the context change to work and certai=
nly
it requires the error-return-from-init_request patch to work, but actually=
 it
probably doesn't require the former so I could probably separate that bit =
out
and put it between 11 and 12.

David

