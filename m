Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3A32B7FF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 16:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKRO70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 09:59:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgKRO70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605711565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RGAM19RAVfoEcH+r75a6/3V/vViiVIkjc5sfDpr2Uh8=;
        b=d2u8tfBMsoIl6a0Y/9mFRpiePT8eCJa9VOF+uJM9ktOfKs5hqKNVv9QK/wOs+1gFFM7fTC
        H3rpSPQwdJPaHs/zOweGtQuYAHFt8QL0jnj5f9p1JT5U2Cp1ILXwNRMhF9sNhGaJRCKMKa
        ziz0IzXLpj/48o4asOo+mW7YtKXC1I0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-PsWAZY6UNryCJfv0azWEjg-1; Wed, 18 Nov 2020 09:59:21 -0500
X-MC-Unique: PsWAZY6UNryCJfv0azWEjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6B5B1005D4D;
        Wed, 18 Nov 2020 14:59:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CA8B5C1A3;
        Wed, 18 Nov 2020 14:59:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1561011.1605706707@warthog.procyon.org.uk>
References: <1561011.1605706707@warthog.procyon.org.uk> <20201118124826.GA17850@nautica> <1514086.1605697347@warthog.procyon.org.uk>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p: Convert to new fscache API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1778742.1605711553.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 18 Nov 2020 14:59:13 +0000
Message-ID: <1778743.1605711553@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Another bit I forgot: you need something like:

int afs_set_page_dirty(struct page *page)
{
	return fscache_set_page_dirty(page, afs_vnode_cache(AFS_FS_I(page->mappin=
g->host)));
}

and point the set_page_dirty address space op at it.

David

