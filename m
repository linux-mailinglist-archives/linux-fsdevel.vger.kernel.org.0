Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE253F76DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 16:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbhHYOGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 10:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240571AbhHYOGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629900360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ye7x7ROLpLa4uVII3MBvGoJurLkOurh44zhhrnNWmF8=;
        b=HPBRid/g2C8PHLReiH2/wrhxi18AP0edi5UsaruB+4sVXq6pCfEhtGnnk1YCj2lIEonM+e
        UeCTUcjQ26J1s+8w3iwQwJfTNs9jMIV95r7kyszNUUNXwC4bunXfHHteaPQUy5wkK3c2cL
        dmvbkWF/Xr3umZSrU1P6vDoO5RPYu9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-8zB0ShKZMiSW63FKSCZu_g-1; Wed, 25 Aug 2021 10:05:57 -0400
X-MC-Unique: 8zB0ShKZMiSW63FKSCZu_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3302B101C8AE;
        Wed, 25 Aug 2021 14:05:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A820060C04;
        Wed, 25 Aug 2021 14:05:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6370d0a74c3ceb79c53305a64ba7a982d16d34b4.camel@redhat.com>
References: <6370d0a74c3ceb79c53305a64ba7a982d16d34b4.camel@redhat.com> <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk> <162431203107.2908479.3259582550347000088.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] fscache: Fix fscache_cookie_put() to not deref after dec
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2030918.1629900351.1@warthog.procyon.org.uk>
Date:   Wed, 25 Aug 2021 15:05:51 +0100
Message-ID: <2030919.1629900351@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> > fscache_cookie_put() accesses the cookie it has just put inside the
> > tracepoint that monitors the change - but this is something it's not
> > allowed to do if we didn't reduce the count to zero.
> 
> Do you mean "if the count went to zero." ?

No.  If *we* reduced the count to zero, it falls to us to destroy the object,
so we're allowed to look into it again.

If we didn't reduce the count to zero, then someone else might destroy it
before we look into it again.

David

