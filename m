Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A89354FA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhDFJMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 05:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235194AbhDFJMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617700354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AhhENwozJo31QuZKH+YbzDdc3kpvbzwxPr4UskXPNXg=;
        b=V2MyQtUBTA6cBb/SgPLtB6f7WbsDAy8pTSJlSY6NZVSQFd5kZbUyVA6dd8uPoY/3u/g/Dv
        tyWvdjoREDOOGYktX/b0iWjyuxIUTZh3bpozZipUzEEjHBwd04kzGUya/d0oMkGoWDHWRs
        7PNYir+IKs732Zu4Yhb82fKgOsS1/sY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-NZ3xZAg-M_uGC_bNaZj5fw-1; Tue, 06 Apr 2021 05:12:32 -0400
X-MC-Unique: NZ3xZAg-M_uGC_bNaZj5fw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 963B410CE796;
        Tue,  6 Apr 2021 09:12:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEC5D59449;
        Tue,  6 Apr 2021 09:12:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210405164603.281189-1-brauner@kernel.org>
References: <20210405164603.281189-1-brauner@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH] cachefiles: use private mounts in cache->mnt
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <107462.1617700345.1@warthog.procyon.org.uk>
Date:   Tue, 06 Apr 2021 10:12:25 +0100
Message-ID: <107463.1617700345@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> wrote:

> Besides that - and probably irrelevant from the perspective of a
> cachefiles developer - it also makes things simpler for a variety of
> other vfs features. One concrete example is fanotify.

What about cachefilesd?  That walks over the tree regularly, stats things and
maybe deletes things.  Should that be in a private mount/namespace too?

> This seems a rather desirable property as the underlying path can't e.g.
> suddenly go from read-write to read-only and in general it means that
> cachefiles is always in full control of the underlying mount after the
> user has allowed it to be used as a cache.

That's not entirely true, but I guess that emergency R/O conversion isn't a
case that's worrisome - and, in any case, only affects the superblock.

>  	ret = -EINVAL;
> -	if (mnt_user_ns(path.mnt) != &init_user_ns) {
> +	if (mnt_user_ns(cache->mnt) != &init_user_ns) {
>  		pr_warn("File cache on idmapped mounts not supported");
>  		goto error_unsupported;
>  	}

Is it worth doing this check before calling clone_private_mount()?

> +	cache_path = path;
> +	cache_path.mnt = cache->mnt;

Seems pointless to copy all of path into cache_path rather than just
path.dentry.

Apart from that, looks okay.

David

