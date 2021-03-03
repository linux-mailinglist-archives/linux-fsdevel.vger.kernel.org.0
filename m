Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A6C32C546
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450668AbhCDAT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359694AbhCCOue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614782946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZuoaDXYSYG3NYKLp8Ux68gUM1drqr9N/3rVBLbXLYRw=;
        b=eygtCgTdVgrwtAXI7xZ0JiWoQbRMqyBUF26YoAeUgcVpKu0KTku1shAugTi/OikWi/xmqg
        UX07ZW967OuZ9vCB0CJ5vXme4g9OiZrvRAADTo4jh/jFq5CGfj4iJnsuq730LJ5t+Pleh+
        CLo05EvClgen9uRBP7+Yjg05cKY8IrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-4skKp5o8OJ-uERkiZAmzGQ-1; Wed, 03 Mar 2021 09:45:12 -0500
X-MC-Unique: 4skKp5o8OJ-uERkiZAmzGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E4C31E564;
        Wed,  3 Mar 2021 14:45:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5496F5C241;
        Wed,  3 Mar 2021 14:45:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210303140522.jwlzrmhhho3lvpmv@wittgenstein>
References: <20210303140522.jwlzrmhhho3lvpmv@wittgenstein> <20210121131959.646623-10-christian.brauner@ubuntu.com> <20210121131959.646623-1-christian.brauner@ubuntu.com> <2129497.1614777842@warthog.procyon.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dhowells@redhat.com, Tycho Andersen <tycho@tycho.pizza>,
        Tycho Andersen <tycho@tycho.ws>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/40] xattr: handle idmapped mounts
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2203251.1614782707.1@warthog.procyon.org.uk>
Date:   Wed, 03 Mar 2021 14:45:07 +0000
Message-ID: <2203252.1614782707@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> wrote:

> In order to answer this more confidently I need to know a bit more about
> how cachefiles are supposed to work.
> 
> From what I gather here it seemed what this code is trying to set here
> is an internal "CacheFiles.cache" extended attribute on the indode. This
> extended attribute doesn't store any uids and gids or filesystem
> capabilities so the user namespace isn't relevant for that since there
> doesn't need to be any conversion.
> 
> What I need to know is what information do you use for cachefiles to
> determine whether someone can set that "Cachefiles.cache" extended
> attribute on the inode:
> - Is it the mnt_userns of a/the mount of the filesystem you're caching for?
> - The mnt_userns of the mnt of struct cachefiles_cache?
> - Or the stashed or current creds of the caller?

Mostly it's about permission checking.  The cache driver wants to do accesses
onto the files in cache using the context of whatever process writes the
"bind" command to /dev/cachefiles, not the context of whichever process issued
a read or write, say, on an NFS file that is being cached.

This causes standard UNIX perm checking, SELinux checking, etc. all to be
switched to the appropriate context.  It also controls what appears in the
audit logs.

There is an exception to this: It also governs the ownership of new files and
directories created in the cache and what security labels will be set on them.

Quite possibly this doesn't matter for the xattr stuff.  It's hard to tell
since we use user namespaces to convey so many different things at different
times.

David

