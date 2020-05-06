Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF91C6AA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 09:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgEFH6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 03:58:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38223 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728482AbgEFH6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 03:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588751891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3XSAt+Mkup/SofBBKUCYx2i7ecGmmjnSIl1ryVz58Ao=;
        b=RdzmCiik0QQ2MCLzl6AESa1zQD3kk9f/KaMA1xntinlnJVefKXXi6mwwuDk/iFlGXt1Xb/
        GD3LAj6uCrzsaK9ApSAAbdUV0sCnxAH5yNveZ529MI+mV/yyoYxshbkTrvgiyIMSU15Wwp
        4czdUHfYyuuzea/yUc/qbwCOHG99LQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459--Q3klqpZNS2sU59OYqcCAQ-1; Wed, 06 May 2020 03:58:03 -0400
X-MC-Unique: -Q3klqpZNS2sU59OYqcCAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A672B835B49;
        Wed,  6 May 2020 07:58:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 014C45D9DA;
        Wed,  6 May 2020 07:57:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200505115946.GF16070@bombadil.infradead.org>
References: <20200505115946.GF16070@bombadil.infradead.org> <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk> <158861253957.340223.7465334678444521655.stgit@warthog.procyon.org.uk>
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
Content-ID: <683738.1588751878.1@warthog.procyon.org.uk>
Date:   Wed, 06 May 2020 08:57:58 +0100
Message-ID: <683739.1588751878@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > PG_fscache is going to be used to indicate that a page is being written to
> > the cache, and that the page should not be modified or released until it's
> > finished.
> > 
> > Make afs_invalidatepage() and afs_releasepage() wait for it.
> 
> Well, why?  Keeping a refcount on the page will prevent it from going
> away while it's being written to storage.  And the fact that it's
> being written to this cache is no reason to delay the truncate of a file
> (is it?)

Won't that screw up ITER_MAPPING?  Does that mean that ITER_MAPPING isn't
viable?

David

