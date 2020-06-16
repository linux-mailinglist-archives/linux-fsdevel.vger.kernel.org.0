Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A671FB015
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 14:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgFPMR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 08:17:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57790 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728818AbgFPMRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592309858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALxbec16ACec59XBUz3lxih0+JjDkzRnQj2wRSNF7zM=;
        b=Q5UhV61zTLysXR42wziMVb7022+QSp/TJMwNWHK6Zrurh/1IkkzC5u6hBC5F7Kj7PTr6lJ
        zs5ZPB6ip9/z//OmRXzv8lYyiDh5r8BWs5C7mhkSNomekZzv8anuzZYgmf2R1h09O0qftd
        PwQIzfxhJXnkEG0hR2CLHZT7wdCcxws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-b-yjdPF-PTK-esfOHyqPkA-1; Tue, 16 Jun 2020 08:17:32 -0400
X-MC-Unique: b-yjdPF-PTK-esfOHyqPkA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39B781009445;
        Tue, 16 Jun 2020 12:17:31 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2ED9D7C375;
        Tue, 16 Jun 2020 12:17:31 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 1F8D81809543;
        Tue, 16 Jun 2020 12:17:31 +0000 (UTC)
Date:   Tue, 16 Jun 2020 08:17:28 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <315900873.34076732.1592309848873.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200616003903.GC2005@dread.disaster.area>
References: <20200615160244.741244-1-agruenba@redhat.com> <20200615233239.GY2040@dread.disaster.area> <20200615234437.GX8681@bombadil.infradead.org> <20200616003903.GC2005@dread.disaster.area>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.115.80, 10.4.195.27]
Thread-Topic: iomap: Make sure iomap_end is called after iomap_begin
Thread-Index: WWz+urK5/eoXxwmGC0zTU+oujNHV9w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Original Message -----
> > I'd assume Andreas is looking at converting a filesystem to use iomap,
> > since this problem only occurs for filesystems which have returned an
> > invalid extent.
> 
> Well, I can assume it's gfs2, but you know what happens when you
> assume something....

Yes, it's gfs2, which already has iomap. I found the bug while just browsing
the code: gfs2 takes a lock in the begin code. If there's an error,
however unlikely, the end code is never called, so we would never unlock.
It doesn't matter to me whether the error is -EIO because it's very unlikely
in the first place. I haven't looked back to see where the problem was
introduced, but I suspect it should be ported back to stable releases.

Bob Peterson

