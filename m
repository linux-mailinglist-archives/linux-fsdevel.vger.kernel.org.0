Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C2B1C72B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 16:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgEFOYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 10:24:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24559 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727084AbgEFOYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 10:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588775080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbddwc8AWoCH822EokkiRcp0XFOdJXpCOboNl38sqMs=;
        b=Ec5egBY7MQtrsi+HfvGFiG2yB8hL0u9v8a4bF5O/swX57l8qXcM0uz5IfUF3zW+cZRb0mU
        C/1Q7ZJNNxpNrh77XnxbywI7c7IJrssKx79dghteYOjUw8jnvgVm2jmxXedVuankpOC2+p
        MIeHNlCwKM0MnNKfWuQNIkGQSheYbtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-7dSlh3iYM9GY009Ms9gsRQ-1; Wed, 06 May 2020 10:24:39 -0400
X-MC-Unique: 7dSlh3iYM9GY009Ms9gsRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1CE281CBE1;
        Wed,  6 May 2020 14:24:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2557E6299C;
        Wed,  6 May 2020 14:24:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200506110942.GL16070@bombadil.infradead.org>
References: <20200506110942.GL16070@bombadil.infradead.org> <20200505115946.GF16070@bombadil.infradead.org> <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk> <158861253957.340223.7465334678444521655.stgit@warthog.procyon.org.uk> <683739.1588751878@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 54/61] afs: Wait on PG_fscache before modifying/releasing a page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <713140.1588775072.1@warthog.procyon.org.uk>
Date:   Wed, 06 May 2020 15:24:32 +0100
Message-ID: <713141.1588775072@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > Won't that screw up ITER_MAPPING?  Does that mean that ITER_MAPPING isn't
> > viable?
> 
> Can you remind me why ITER_MAPPING needs:
> 
> "The caller must guarantee that the pages are all present and they must be
> locked using PG_locked, PG_writeback or PG_fscache to prevent them from
> going away or being migrated whilst they're being accessed."
> 
> An elevated refcount prevents migration, and it also prevents the pages
> from being freed.  It doesn't prevent them from being truncated out of
> the file, but it does ensure the pages aren't reallocated.

ITER_MAPPING relies on the mapping to maintain the pointers to the pages so
that it can find them rather than being like ITER_BVEC where there's a
separate list.

Truncate removes the pages from the mapping - at which point ITER_MAPPING can
no longer find them.

David

