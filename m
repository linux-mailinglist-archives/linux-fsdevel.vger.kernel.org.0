Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDCF19A746
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 10:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbgDAI1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 04:27:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49916 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731981AbgDAI1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585729660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A6T4NzJaYrpl8sbGk+/56cI+lPm3tJ8OvumXbnFWNJs=;
        b=LDVal90ozh0D3vX2vbyYlQsxKi/jTKZqK9S1nICiuWNr4GgMeuXHLkP+ieRftCxB6D7MzC
        xtB0U/e1dSE6QfloV1Y1pv/YniMJcJ9SWp6QWBhHrSOzUN3Hp9umB5723o+EdgFKOBll0C
        TPe/YgIgtjR3QeCmzAWBc1KZKovzRps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-LPl4n2IlPVKc88TP8mowIg-1; Wed, 01 Apr 2020 04:27:37 -0400
X-MC-Unique: LPl4n2IlPVKc88TP8mowIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEE58800D53;
        Wed,  1 Apr 2020 08:27:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BEC296B72;
        Wed,  1 Apr 2020 08:27:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegvvMVoNp1QeXEZiNucCeuUeDP4tKqVfq2F4koQKzjKmvw@mail.gmail.com>
References: <CAJfpegvvMVoNp1QeXEZiNucCeuUeDP4tKqVfq2F4koQKzjKmvw@mail.gmail.com> <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk> <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com> <50caf93782ba1d66bd6acf098fb8dcb0ecc98610.camel@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux API <linux-api@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] VFS: Filesystem information [ver #19]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2465265.1585729649.1@warthog.procyon.org.uk>
Date:   Wed, 01 Apr 2020 09:27:29 +0100
Message-ID: <2465266.1585729649@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> According to dhowell's measurements processing 100k mounts would take
> about a few seconds of system time (that's the time spent by the
> kernel to retrieve the data,

But the inefficiency of mountfs - at least as currently implemented - scales
up with the number of individual values you want to retrieve, both in terms of
memory usage and time taken.

With fsinfo(), I've tried to batch values together where it makes sense - and
there's no lingering memory overhead - no extra inodes, dentries and files
required.

David

