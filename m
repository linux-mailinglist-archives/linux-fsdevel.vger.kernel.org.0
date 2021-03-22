Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464E9344CFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 18:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhCVROP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 13:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232119AbhCVRN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616433238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMbmUNAFvNWl2qhZsFpoWOGxDUGbmddTSEhEjr5Mf7I=;
        b=gAM22rBbJFJ2eXkIzQ3JMSPhPCNkekCpAj2d07RUslS3SgjBobqh4tXx742ng3euvmL5MS
        yQLLv0OvqOaaqtrYxRq6h+Bc8CD4HkvgLkGo0/HAWIK5lWBhjTHCE06q0qLGzN7r8ttCP9
        WHmI4DzXd9hUho8swUNKOjJ8qU2yCiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-03ysOJ7_MVCEbA-orqBIWQ-1; Mon, 22 Mar 2021 13:13:56 -0400
X-MC-Unique: 03ysOJ7_MVCEbA-orqBIWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 803B0801817;
        Mon, 22 Mar 2021 17:13:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8BF860C0F;
        Mon, 22 Mar 2021 17:13:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210321014202.GF3420@casper.infradead.org>
References: <20210321014202.GF3420@casper.infradead.org> <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk> <161539537375.286939.16642940088716990995.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        David Wysochanski <dwysocha@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/28] netfs: Provide readahead and readpage netfs helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2285031.1616433227.1@warthog.procyon.org.uk>
Date:   Mon, 22 Mar 2021 17:13:47 +0000
Message-ID: <2285032.1616433227@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > +	while ((page = readahead_page(ractl)))
> > +		put_page(page);
> 
> You don't need this pair of lines (unless I'm missing something).
> read_pages() in mm/readahead.c puts the reference and unlocks any
> pages which are not read by the readahead op.  Indeed, I think doing
> this is buggy because you don't unlock the page.

Actually, I do need them.  The pages haven't been removed from the ractl at
this point so just returning would cause them all to be unlocked prematurely.

I don't pass the ractl to the filesystem or the cache because I may be calling
them for partial pages, I may be issuing multiple ops sequentially on a page
and the ractl may have ceased to exist by the time I issue an op.

The unlocking is done by netfs_rreq_unlock(), even for pages that didn't get
read.

I've added a comment to this effect.

David

