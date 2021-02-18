Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8826D31EF45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 20:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhBRTId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 14:08:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234582AbhBRRsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613670434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vh8JVeAq553dnjUjXxpSp+/x6fHtJkixwlI1e+/bfY8=;
        b=D0ltEqDHzz+O5R9uzG1lWvXLWNOsTtoS4eKgoRhnlKGEdWagczQx8HQ1KXZDFQYXo/qYuA
        TStT1QppC4wbsbZe/YYRaj4UJR0XpUHpJbSohbx9hsB2TgSS3+1UVP7/mFyV4u27okaPb+
        frax6pKXV5DE4pmVlEFvDzQj5GDiWS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-qum9-M-dOJ-dh4Cpmuan6A-1; Thu, 18 Feb 2021 12:47:10 -0500
X-MC-Unique: qum9-M-dOJ-dh4Cpmuan6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C51CF107ACF4;
        Thu, 18 Feb 2021 17:47:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C64060877;
        Thu, 18 Feb 2021 17:47:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210217161358.GM2858050@casper.infradead.org>
References: <20210217161358.GM2858050@casper.infradead.org> <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/33] mm: Implement readahead_control pageset expansion
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2083367.1613670420.1@warthog.procyon.org.uk>
Date:   Thu, 18 Feb 2021 17:47:00 +0000
Message-ID: <2083368.1613670420@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> So readahead_expand() needs to adjust the file's f_ra so that when the
> application gets to 64kB, it kicks off the readahead of 4MB-8MB chunk (and
> then when we get to 4MB+256kB, it kicks off the readahead of 8MB-12MB,
> and so on).

Ummm...  Two questions:

Firstly, how do I do that?  Set ->async_size?  And to what?  The expansion
could be 2MB from a ceph stripe, 256k from the cache.  Just to add to the fun,
the leading edge of the window might also be rounded downwards and the RA
trigger could be before where the app is going to start reading.

Secondly, what happens if, say, a 4MB read is covered by a single 4MB THP?

David

