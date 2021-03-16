Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE3933D320
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 12:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbhCPLf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 07:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237246AbhCPLe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615894497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlqsbtT9COsx+yKS+e8hs6ZYyJT5eXMndMhYe5Gjdjo=;
        b=M6+0cVOPBYubuhLr7m1vWnilvgjNWbS4w4VSeXMDcBc8GvKGUWjDTwHXRkF2B9W4X95e51
        x2QM8tvDcm2yIpzegU+twaNBuqFcTXPpwrfnc+OGMTTltFbZQSXti7sKBHamymY7w6xhnb
        raPZ82FCLjoRVeyVEZ26cLLJvqyeKm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-Q4Hxl9DtPsqAVRmB4OjmRQ-1; Tue, 16 Mar 2021 07:34:54 -0400
X-MC-Unique: Q4Hxl9DtPsqAVRmB4OjmRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 052CE193F561;
        Tue, 16 Mar 2021 11:34:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96C3C60C0F;
        Tue, 16 Mar 2021 11:34:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <161539537375.286939.16642940088716990995.stgit@warthog.procyon.org.uk>
References: <161539537375.286939.16642940088716990995.stgit@warthog.procyon.org.uk> <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
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
Content-ID: <3184203.1615894484.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 16 Mar 2021 11:34:44 +0000
Message-ID: <3184204.1615894484@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm going to make the code generate more information when warning about a
subread reporting having over-read (see attached).

David
---
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index ce11ca4c32e4..765e88ee132d 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -641,7 +641,10 @@ void netfs_subreq_terminated(struct netfs_read_subreq=
uest *subreq,
 		goto failed;
 	}
 =

-	if (WARN_ON(transferred_or_error > subreq->len - subreq->transferred))
+	if (WARN(transferred_or_error > subreq->len - subreq->transferred,
+		 "R%x[%x] %zd > %zu - %zu",
+		 rreq->debug_id, subreq->debug_index,
+		 transferred_or_error, subreq->len, subreq->transferred))
 		transferred_or_error =3D subreq->len - subreq->transferred;
 =

 	subreq->error =3D 0;

