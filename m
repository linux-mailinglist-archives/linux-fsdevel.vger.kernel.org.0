Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E699931E29C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 23:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhBQWlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 17:41:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234050AbhBQWge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 17:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613601301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zG7FxA5GztnCQS45ZSuVJT+MqV0RLaZ+4XZ4Hnsp3v0=;
        b=CpM4WhmBRay0voC79V0t7fgc+U+Foegh/AQ4GYaammhRlqMA78vr1JafD30KzBr/6Ibzi9
        b7jphbSUyo+v5sTLUc2rVgGOeRgGaKqLuNGN+oU+5BmPOeTPezWslLC0toVPYArRw00icx
        /NZjRES/oAkCFXaNBuvXZu6SPCYuoAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-q2CSv0q5Mky64VzDZGuXqA-1; Wed, 17 Feb 2021 17:34:57 -0500
X-MC-Unique: q2CSv0q5Mky64VzDZGuXqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEC63189CD2E;
        Wed, 17 Feb 2021 22:34:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0F6E60C61;
        Wed, 17 Feb 2021 22:34:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210217161358.GM2858050@casper.infradead.org>
References: <20210217161358.GM2858050@casper.infradead.org> <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
        Mike Marshall <hubcap@omnibond.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/33] mm: Implement readahead_control pageset expansion
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1901186.1613601279.1@warthog.procyon.org.uk>
Date:   Wed, 17 Feb 2021 22:34:39 +0000
Message-ID: <1901187.1613601279@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> We're defeating the ondemand_readahead() algorithm here.  Let's suppose
> userspace is doing 64kB reads, the filesystem is OrangeFS which only
> wants to do 4MB reads, the page cache is initially empty and there's
> only one thread doing a sequential read.  ondemand_readahead() calls
> get_init_ra_size() which tells it to allocate 128kB and set the async
> marker at 64kB.  Then orangefs calls readahead_expand() to allocate the
> remainder of the 4MB.  After the app has read the first 64kB, it comes
> back to read the next 64kB, sees the readahead marker and tries to trigger
> the next batch of readahead, but it's already present, so it does nothing
> (see page_cache_ra_unbounded() for what happens with pages present).

It sounds like Christoph is right on the right track and the vm needs to ask
the filesystem (and by extension, the cache) before doing the allocation and
before setting the trigger flag.  Then we don't need to call back into the vm
to expand the readahead.

Also, there's Steve's request to try and keep at least two requests in flight
for CIFS/SMB at the same time to consider.

David

