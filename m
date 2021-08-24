Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD933F6099
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbhHXOjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 10:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237903AbhHXOjt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629815945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIzJFNtN7r1shXWsohSNVJgyFOeYy/KSnJVcAMNs8DQ=;
        b=a0H0xyjLjODqmbCymz6WQa/ZsGyVPuJvmBYhEz7WhcxCriT72ntACF8wTyJ8xcz6ySSUod
        bH088+OSxM/W58kmq/xLiI1ZpXeC3yY0D5uGlPc1oriiIcJ6WiORcmS92OThKAZUvliShb
        JMoFNFtHDT+/P83vw4EYl3Tb7F8otUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-ukmS65bfOAWoX3lGu4KGeA-1; Tue, 24 Aug 2021 10:39:03 -0400
X-MC-Unique: ukmS65bfOAWoX3lGu4KGeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DADBC1082921;
        Tue, 24 Aug 2021 14:39:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 697AD1036D27;
        Tue, 24 Aug 2021 14:38:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YST/0e92OdSH0zjg@casper.infradead.org>
References: <YST/0e92OdSH0zjg@casper.infradead.org> <162981147473.1901565.1455657509200944265.stgit@warthog.procyon.org.uk> <162981148752.1901565.3663780601682206026.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] afs: Fix afs_launder_page() to set correct start file position
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1953536.1629815935.1@warthog.procyon.org.uk>
Date:   Tue, 24 Aug 2021 15:38:55 +0100
Message-ID: <1953537.1629815935@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> 
> This could be page_offset(page), which reads better to me:
> 
> 		ret = afs_store_data(vnode, &iter, page_offset(page) + f, true);

True.  It gets converted to folio_pos() in patch #5 - will that do?

David

