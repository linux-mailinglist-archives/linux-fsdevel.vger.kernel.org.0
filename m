Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD334DDC25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 15:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbiCROuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiCROuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D15C41C8858
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647614894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXh1kXJA2Arm+k9zVpD08NoMYuNv/3gU6u7CxBA2E8s=;
        b=GDWuPfhfR4RmL1qjwQsntfRuWmDRSDtQTRKQYHVyYCujqNiv6M73BUhNRv0YmfTnerRWxF
        pALo0Iajjxh5xVHjd0Q9k8RoPFVHL/mEQk/EgwVG6wn8bMnBapIZQ7DdgdfR14H+2i8fVV
        qdeG3g1ktcYajqSz5QatEXD2nzTcy7Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-ZiK8pNwNPmCjf2x7J_dSuQ-1; Fri, 18 Mar 2022 10:48:13 -0400
X-MC-Unique: ZiK8pNwNPmCjf2x7J_dSuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80D99296A625;
        Fri, 18 Mar 2022 14:48:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16A4040D282F;
        Fri, 18 Mar 2022 14:48:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <f5633dea0bfabd40ba548fc8502e5838c033fbae.camel@kernel.org>
References: <f5633dea0bfabd40ba548fc8502e5838c033fbae.camel@kernel.org> <164692909854.2099075.9535537286264248057.stgit@warthog.procyon.org.uk> <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk> <306388.1647595110@warthog.procyon.org.uk>
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
Subject: Re: [PATCH v4 13/20] netfs: Add a netfs inode context
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <666407.1647614889.1@warthog.procyon.org.uk>
Date:   Fri, 18 Mar 2022 14:48:09 +0000
Message-ID: <666408.1647614889@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> > +static inline bool netfs_is_cache_enabled(struct netfs_i_context *ctx)
> > +{
> > +#if IS_ENABLED(CONFIG_FSCACHE)
> > +	struct fscache_cookie *cookie = ctx->cache;
> > +
> > +	return fscache_cookie_valid(cookie) && cookie->cache_priv &&
> > +		fscache_cookie_enabled(cookie);
> 
> 
> As you mentioned in the other thread, it may be cleaner to move the
> cookie->cache_priv check into fscache_cookie_enabled. Is there ever a
> case where you'd need to separate the two checks?

I'm not sure, but I'd prefer not to do it in this series as it would affect
NFS plus some other operations, so will need retesting thoroughly.  I'd prefer
to defer it.

David

