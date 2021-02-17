Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1831E203
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 23:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhBQWW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 17:22:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233716AbhBQWWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 17:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613600453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B3y9B+k/z5xQZKi1oGvlGylvRbdgqvzBX+Fa2hqmNlA=;
        b=QOpK/K99f+2JUzkdNUrAESPorhVBzI1Do5M4e1U7zngU0sRVfgoTt/OT7FQh9D37zQGtdI
        vNVjktZGut0/ZGt7hsM5JP9fyJGndxLhzec2JNtX9WC1t1Aq9lOEE3i8Zvln/r1eYkZ9Wh
        UXvlk9VImDF8AQK0cBg5KN0mrYbUcsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-GNHqtBxsM-aKk7S1VsT3AA-1; Wed, 17 Feb 2021 17:20:52 -0500
X-MC-Unique: GNHqtBxsM-aKk7S1VsT3AA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77D1D803648;
        Wed, 17 Feb 2021 22:20:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C26510016DB;
        Wed, 17 Feb 2021 22:20:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOg9mSTyFX+2MMSV77hLDUpHogQ=KXO5oNduA90FLoowPGk0Jw@mail.gmail.com>
References: <CAOg9mSTyFX+2MMSV77hLDUpHogQ=KXO5oNduA90FLoowPGk0Jw@mail.gmail.com> <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk> <20210216103215.GB27714@lst.de> <20210216132251.GI2858050@casper.infradead.org> <CAOg9mSQYBjnMsDj5pMd6MOGTY5w_ZR=pw7VRYKfP5ZwmHBj2=Q@mail.gmail.com> <1586931.1613576553@warthog.procyon.org.uk>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-mm <linux-mm@kvack.org>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-cifs@vger.kernel.org,
        ceph-devel <ceph-devel@vger.kernel.org>,
        V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/33] mm: Implement readahead_control pageset expansion
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1900213.1613600436.1@warthog.procyon.org.uk>
Date:   Wed, 17 Feb 2021 22:20:36 +0000
Message-ID: <1900214.1613600436@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mike Marshall <hubcap@omnibond.com> wrote:

> Matthew has looked at how I'm fumbling about
> trying to deal with Orangefs's need for much larger
> than page-sized IO...
> 
> I think I need to implement orangefs_readahead
> and from there fire off an asynchronous read
> and while that's going I'll call readahead_page
> with a rac that I've cranked up with readahead_expand
> and when the read gets done I'll have plenty of pages
> for the large IO I did.

Would the netfs helper lib in patches 5-13 here be of use to orangefs?  Most
of the information about it is on patch 8.

David

