Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9959836E72F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 10:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbhD2Imk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 04:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231701AbhD2Imj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619685710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nhLq7LUYLoOj4b9P22BfA2y71v1kgsQwevldanfEtCY=;
        b=M5ZbxAs/a7wycvuVqP172Thr0r6778Ee+ftBDqPHa/fuBmKCs4lQrjNWCtImWqDVRNG332
        5zHYVM+c0KwKLL3ePbaX/oAHR/DLZ3gPCVlclujf+oSGqFTXYgQKQwaxzDrAw0yb6t8HU4
        DO7r2Hkj6qn0dKubgnny2M6PgTg+8hs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-pgMPVsLoOwWuQOuEz2kDFQ-1; Thu, 29 Apr 2021 04:41:47 -0400
X-MC-Unique: pgMPVsLoOwWuQOuEz2kDFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B34C9F933;
        Thu, 29 Apr 2021 08:41:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-20.rdu2.redhat.com [10.10.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 928387012B;
        Thu, 29 Apr 2021 08:41:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAMuHMdXJZ7iNQE964CdBOU=vRKVMFzo=YF_eiwsGgqzuvZ+TuA@mail.gmail.com>
References: <CAMuHMdXJZ7iNQE964CdBOU=vRKVMFzo=YF_eiwsGgqzuvZ+TuA@mail.gmail.com> <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk> <161918455721.3145707.4063925145568978308.stgit@warthog.procyon.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     dhowells@redhat.com,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Linux MM <linux-mm@kvack.org>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-cifs@vger.kernel.org,
        ceph-devel <ceph-devel@vger.kernel.org>,
        V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 07/31] netfs: Make a netfs helper module
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <442392.1619685697.1@warthog.procyon.org.uk>
Date:   Thu, 29 Apr 2021 09:41:37 +0100
Message-ID: <442393.1619685697@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> I see later patches make AFS and FSCACHE select NETFS_SUPPORT.  If this
> is just a library of functions, to be selected by its users, then please
> make the symbol invisible.

Ideally, yes, it would be an invisible symbol enabled by select from the
network filesystems that use it - but doing that means that you can't choose
whether to build it in or build it as a module.

David

