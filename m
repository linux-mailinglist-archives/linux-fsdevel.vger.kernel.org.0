Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FA435C94B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 16:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbhDLO7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 10:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237526AbhDLO7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618239566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=rcBbpi/wLA7kr8xf4pgFDYrl6w+cpuLGr7hp8o+h5Bk=;
        b=AmXr+tBZES+niuKTlYnMpm0BSneCQ9cXauq5ob79RY039qijw/abDEmKI+PMWgxm6YxroT
        RTYPvt8LSvkuIemFD1S1TBni2trVjI4rbb5jkFisSU2493+lG3kS0AvxOYPP+mvPE4QwkI
        sf/qQrjBYTM+2aNrL+QjhkqroAaey6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-BsZMSZSqPKyiMq4KHM8J4A-1; Mon, 12 Apr 2021 10:59:24 -0400
X-MC-Unique: BsZMSZSqPKyiMq4KHM8J4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36A6E83DD21;
        Mon, 12 Apr 2021 14:59:23 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-141.rdu2.redhat.com [10.10.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A52B110023AF;
        Mon, 12 Apr 2021 14:59:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 11ABF22054F; Mon, 12 Apr 2021 10:59:19 -0400 (EDT)
Date:   Mon, 12 Apr 2021 10:59:19 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        virtio-fs-list <virtio-fs@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Robert Krawitz <rkrawitz@redhat.com>
Subject: Query about fuse ->sync_fs and virtiofs
Message-ID: <20210412145919.GE1184147@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

Robert Krawitz drew attention to the fact that fuse does not seem to
have a ->sync_fs implementation. That probably means that in case of
virtiofs, upon sync()/syncfs(), host cache will not be written back
to disk. And that's not something people expect.

I read somewhere that fuse did not implement ->sync_fs because file
server might not be trusted and it could block sync().

In case of virtiofs, file server is trusted entity (w.r.t guest kernel),
so it probably should be ok to implement ->sync_fs atleast for virtiofs?

Was looking for your thoughts on this before I look into implementing it.

Thanks
Vivek

