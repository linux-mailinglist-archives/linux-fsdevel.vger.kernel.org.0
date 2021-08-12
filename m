Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D890E3EA5CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 15:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhHLNie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 09:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230033AbhHLNid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628775488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oiGXmDTLhiS3oN2r9OJ7cRVpEzCCbBrauFWnA55fp7U=;
        b=SQfu2oAWcvf3xCvln3s1UKb+HqyTLFrxTOKvjyWu3SKpYCjzt8vpi247+bQJq1x7B2F79u
        e1Lftp9qoPEn2sntgjbp5eoJydUc+F8OAGsQsYpc0iEZ3BXqkF4P4JCrlcOh8TJEgS4gYx
        SFivcRcH41jf3hVMNs8NIuPGOh8V7Rc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-TZtzByDUPuGJ6gxXgq_XZA-1; Thu, 12 Aug 2021 09:38:04 -0400
X-MC-Unique: TZtzByDUPuGJ6gxXgq_XZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C80358015C7;
        Thu, 12 Aug 2021 13:38:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0F335D9C6;
        Thu, 12 Aug 2021 13:38:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <3088327.1628774588@warthog.procyon.org.uk>
References: <3088327.1628774588@warthog.procyon.org.uk> <YRUbXoMzWVX9X/Vf@casper.infradead.org> <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk> <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, trond.myklebust@primarydata.com,
        darrick.wong@oracle.com, hch@lst.de, jlayton@kernel.org,
        sfrench@samba.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make swap_readpage() for SWP_FS_OPS use ->direct_IO() not ->readpage()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3088957.1628775479.1@warthog.procyon.org.uk>
Date:   Thu, 12 Aug 2021 14:37:59 +0100
Message-ID: <3088958.1628775479@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > After submitting the IO here ...
> > 
> > > +	if (ret != -EIOCBQUEUED)
> > > +		swapfile_read_complete(&ki->iocb, ret, 0);
> > 
> > We only touch the 'ki' here ... if the caller didn't call read_complete
> > 
> > > +	swapfile_put_kiocb(ki);
> > 
> > Except for here, which is only touched in order to put the refcount.
> > 
> > So why can't swapfile_read_complete() do the work of freeing the ki?
> 
> When I was doing something similar for cachefiles, I couldn't get it to work
> like that.  I'll have another look at that.

Ah, yes.  generic_file_direct_write() accesses in the kiocb *after* calling
->direct_IO(), so the kiocb *must not* go away until after
generic_file_direct_write() has returned.

David

