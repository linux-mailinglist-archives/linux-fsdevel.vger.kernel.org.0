Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B767447E56D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 16:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbhLWPYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 10:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234595AbhLWPYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640273069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8xvHhyqpJnfAF4nzjhPGcOWeASMzT5CGLatcRq8FkGU=;
        b=Ao0Gy1sVDD24y9fQRdk+YdPjwPUbyaJQ91nJMWovh8zVJoFpR7grPn3LAwKjFRdLbWsFIz
        mvfivAPqBQuMMdPsb43nouDn9f4ZmFe20lShKVehkv5AOoI6UobPWvmpmV4sZK4FM3vxXn
        qkQsZfvjOq+BmGgr2175ekANC8kXjPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-cFA9QJpoPXC-y6nZ_4xKOw-1; Thu, 23 Dec 2021 10:24:24 -0500
X-MC-Unique: cFA9QJpoPXC-y6nZ_4xKOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29B978042E1;
        Thu, 23 Dec 2021 15:24:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DF73610A6;
        Thu, 23 Dec 2021 15:24:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YcQd2Fw7atXoU3Dn@infradead.org>
References: <YcQd2Fw7atXoU3Dn@infradead.org> <20211208042256.1923824-1-willy@infradead.org> <20211208042256.1923824-8-willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/48] iov_iter: Convert iter_xarray to use folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <800799.1640273061.1@warthog.procyon.org.uk>
Date:   Thu, 23 Dec 2021 15:24:21 +0000
Message-ID: <800800.1640273061@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > +		size_t offset = offset_in_folio(folio, start + __off);	\
> > +		if (xas_retry(&xas, folio))			\
> >  			continue;				\
> > +		if (WARN_ON(xa_is_value(folio)))		\
> >  			break;					\
> > +		if (WARN_ON(folio_test_hugetlb(folio)))		\
> >  			break;					\
> > +		while (offset < folio_size(folio)) {		\
> 
> Nit: I'd be tempted to use a for loop on offset here.

A while-loop makes more sense here.  The adjustment you need for offset
(ie. len) is overwritten after offset is altered at the end of the loop:

> +			offset += len;				\
> +			len = PAGE_SIZE;			\
>  		}						\

So you'd have to move both of these into the for-incrementor expression, in
addition to moving in the initialiser expression, making the thing less
readable.

David

