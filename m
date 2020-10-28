Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A7F29D5CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgJ1WHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730058AbgJ1WHR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603922836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O/BGLtzgfmF0SgLWDxB+OjnwScbwNx4rvirjwHvdxu8=;
        b=TkJlsHOTF19GsnnXXudJHW4flnIJnzy0DkLPUg/kXTVgZFpykQyE6mXFMnw6GszPbgzuS5
        xrfI7YNWrzphNXRbfNvUomCAO1VV7xB2Sx6+eJIuSRl8P8685ZLDYlT/7TyylM9wuCbvNK
        7t2QOTHdzUL0+oKAAozxaavUq5bNHJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-w0Cal7W0O1KKXv-zA7kNsg-1; Wed, 28 Oct 2020 13:05:11 -0400
X-MC-Unique: w0Cal7W0O1KKXv-zA7kNsg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F60B802B66;
        Wed, 28 Oct 2020 17:05:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1511D100164C;
        Wed, 28 Oct 2020 17:05:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201028143442.GA20115@casper.infradead.org>
References: <20201028143442.GA20115@casper.infradead.org> <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk> <160389426655.300137.17487677797144804730.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        kernel test robot <lkp@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] afs: Fix dirty-region encoding on ppc32 with 64K pages
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <548208.1603904708.1@warthog.procyon.org.uk>
Date:   Wed, 28 Oct 2020 17:05:08 +0000
Message-ID: <548209.1603904708@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > +{
> > +	if (PAGE_SIZE - 1 <= __AFS_PAGE_PRIV_MASK)
> > +		return 1;
> > +	else
> > +		return PAGE_SIZE / (__AFS_PAGE_PRIV_MASK + 1);
> 
> Could this be DIV_ROUND_UP(PAGE_SIZE, __AFS_PAGE_PRIV_MASK + 1); avoiding
> a conditional?  I appreciate it's calculated at compile time today, but
> it'll be dynamic with THP.

Hmmm - actually, I want a shift size, not a number of bytes as I divide by it
twice in afs_page_dirty().

David

