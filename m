Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DA5490B54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 16:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiAQPYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 10:24:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240406AbiAQPYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642433085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D0EKPYhKbnUV4EKNstvISBeawh1wW6zNUbDlwrY8aQs=;
        b=ZAVLlYq/2uNbYTj0kW8XrfkjF2isipUJxjfQvpawH0ErG8VkL/zbkJN5LeFiW8yS95FRCs
        uOxAi97rKtBdB1nnC0UkBAOGxOsR/I1Y5LS7iqPmxqOLFaMDb4/bSYDiJpXQFzTA333nbV
        /uzumWYgW8+bZjhKbaoBQKoyuHw9eE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-cfzkIH6iNmGIFntsF-bZAg-1; Mon, 17 Jan 2022 10:24:32 -0500
X-MC-Unique: cfzkIH6iNmGIFntsF-bZAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8653110247B1;
        Mon, 17 Jan 2022 15:24:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88D787BB48;
        Mon, 17 Jan 2022 15:24:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <240e60443076a84c0599ccd838bd09c97f4cc5f9.camel@kernel.org>
References: <240e60443076a84c0599ccd838bd09c97f4cc5f9.camel@kernel.org> <164242347319.2763588.2514920080375140879.stgit@warthog.procyon.org.uk> <YeVzZZLcsX5Krcjh@casper.infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] ceph: Uninline the data on a file opened for writing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2807616.1642433067.1@warthog.procyon.org.uk>
Date:   Mon, 17 Jan 2022 15:24:27 +0000
Message-ID: <2807617.1642433067@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> On Mon, 2022-01-17 at 13:47 +0000, Matthew Wilcox wrote:
> > This all falls very much under "doing it the hard way", and quite
> > possibly under the "actively buggy with races" category.
> > 
> > read_mapping_folio() does what you want, as long as you pass 'filp'
> > as your 'void *data'.  I should fix that type ...


How much do we care about the case where we don't have either the
CEPH_CAP_FILE_CACHE or the CEPH_CAP_FILE_LAZYIO caps?  Is it possible just to
shove the page into the pagecache whatever we do?  At the moment there are two
threads, both of which get a page - one attached to the page cache, one not.
The rest is then common because from that point on, it doesn't matter where
the folio resides.

David

