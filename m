Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19923324F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgG3Mga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:36:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38745 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727797AbgG3Mg3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596112588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31PzmvZoLrb+VBxM22N3vxrRxLtADMFNugnbQ/5/Q1U=;
        b=CRUSw+V2sn26NN5Tk0vnVHg0OoEUvUn5JKpcU2BM1XlDpfg35C9nDfgARgsVeev1G+XGaj
        XBpJyBELSp5NO4D2GMlBvWfv50TmR7JGzVXFX4uL/JE7I7DTpo4jtl0YHosx0VTPPa4V9i
        0NuWVz9F1obYN48dnHyzgoNCsNCAAfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-RA2a7GGdO5qhhZezBS-zyQ-1; Thu, 30 Jul 2020 08:36:24 -0400
X-MC-Unique: RA2a7GGdO5qhhZezBS-zyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9F0C800685;
        Thu, 30 Jul 2020 12:36:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 895FC87B07;
        Thu, 30 Jul 2020 12:36:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200730121622.GB23808@casper.infradead.org>
References: <20200730121622.GB23808@casper.infradead.org> <447452.1596109876@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Upcoming: fscache rewrite
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <488586.1596112574.1@warthog.procyon.org.uk>
Date:   Thu, 30 Jul 2020 13:36:14 +0100
Message-ID: <488587.1596112574@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> I suspect you don't need to call find_get_pages_contig().  If you look
> at __readahead_batch() in pagemap.h, it does basically what you want
> (other than being wrapped up inside the readahead iterator).  You require
> the pages already be pinned in the xarray, so there's no need for the
> page_cache_get_speculative() dance that find_get_pages_contig) does,
> nor the check for xa_is_value().

I'll have a look at that.

> My main concern with your patchset is that it introduces a new page flag

Technically, the flag already exists - I'm just using it for something
different than the old fscache code used it for.

> to sleep on which basically means "I am writing this page to the fscache".
> I don't understand why you need it; you've elevated the refcount on
> the pages so they're not going to get reused for another purpose.
> All it does (as far as I can tell) is make a task calling truncate()
> wait for the page to finish being written to cache, which isn't actually
> necessary.

It's also used to prevent starting overlapping async DIO writes to the cache.

See fscache_read_done(), where it's set to cover writing what we've just read
from the server to the cache, and afs_write_back_from_locked_page(), where
it's set to cover writing the data to be written back to the cache.

David

