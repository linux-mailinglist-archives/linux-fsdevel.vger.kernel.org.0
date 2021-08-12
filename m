Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB933EA652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 16:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhHLORG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 10:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229841AbhHLORE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628777798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2bMfhHAv15CDN98DVHmVRNFcfhw0V+S5BAUtt4n1y8U=;
        b=h+l6x/aKpqq0sdCMpUGj1zs5aF/ydVA3kJ/1/jC3yt+0MTGc8f96YJSV8RoJ9RfCnU6BXK
        Xt389qg8gz3sbn7DXt6JYyhqwN1/+iRvImg/7TIqQA6hK1EFXZXeQFt/xHZuhxCq1XgBCN
        i0yJSEG11FaXZ6KTlVk9wJwDfuiOPmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-tJAOs35jM9iYqWetyHiFnA-1; Thu, 12 Aug 2021 10:16:36 -0400
X-MC-Unique: tJAOs35jM9iYqWetyHiFnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86E5418C89C4;
        Thu, 12 Aug 2021 14:16:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6708218AD4;
        Thu, 12 Aug 2021 14:16:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YRUnN+Y2CQ0qcjO6@casper.infradead.org>
References: <YRUnN+Y2CQ0qcjO6@casper.infradead.org> <3088327.1628774588@warthog.procyon.org.uk> <YRUbXoMzWVX9X/Vf@casper.infradead.org> <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk> <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk> <3088958.1628775479@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, trond.myklebust@primarydata.com,
        darrick.wong@oracle.com, hch@lst.de, jlayton@kernel.org,
        sfrench@samba.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make swap_readpage() for SWP_FS_OPS use ->direct_IO() not ->readpage()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3122383.1628777791.1@warthog.procyon.org.uk>
Date:   Thu, 12 Aug 2021 15:16:31 +0100
Message-ID: <3122384.1628777791@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> This is a read, not a write ... but we don't care about ki_pos being
> updated, so that store can be conditioned on IOCB_SWAP being clear.
> Or instead of storing directly to ki_pos, we take a pointer to ki_pos
> and then redirect that pointer somewhere harmless.

But see also ext4_dio_read_iter(), for example.  That touches ki_filp after
starting the op.

David

