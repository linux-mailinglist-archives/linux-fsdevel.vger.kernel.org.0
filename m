Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9F3583A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 14:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhDHMv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 08:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhDHMv1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617886276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKMmQQAIPSzXF3Uyz4vJn25BHWiB2y9JZrHeB/ymjfo=;
        b=ennNN1TDQuEzLEKadyqxc+5JoKXTW1u6ypd0zwXbxeknaEswzikpybEcKlDuXjlhrnoz0Z
        v+CZrW+SDJ8GYJ3FSgA9zd+cXV1zSp+ijPT5toj9yA6g6mmUW3XVa6xwtO5UPKmPDoi+S2
        /4ppxbCrhV0/mjtC+SeYDtn/VpbYrXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-8M_oQuwtNpu6ut2GboIXvA-1; Thu, 08 Apr 2021 08:51:14 -0400
X-MC-Unique: 8M_oQuwtNpu6ut2GboIXvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BC24107ACE8;
        Thu,  8 Apr 2021 12:51:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-201.rdu2.redhat.com [10.10.115.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96A9960864;
        Thu,  8 Apr 2021 12:51:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210407201857.3582797-4-willy@infradead.org>
References: <20210407201857.3582797-4-willy@infradead.org> <20210407201857.3582797-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, jlayton@kernel.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH] mm, netfs: Fix readahead bits
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1234932.1617886271.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 08 Apr 2021 13:51:11 +0100
Message-ID: <1234933.1617886271@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Willy, Jeff,

I think we need the attached change to readahead_expand() to fix the oops =
seen
when it tries to dereference ractl->ra when called indirectly from
netfs_write_begin().

netfs_write_begin() should also be using DEFINE_READAHEAD() rather than
manually initialising the ractl variable so that Willy can find it;-).

David
---
commit 9c0931285131c3b65ab4b58b614c30c7feb1dbd4
Author: David Howells <dhowells@redhat.com>
Date:   Thu Apr 8 13:39:54 2021 +0100

    netfs: readahead fixes

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 762a15350242..1d3b50c5db6d 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1065,12 +1065,7 @@ int netfs_write_begin(struct file *file, struct add=
ress_space *mapping,
 	loff_t size;
 	int ret;
 =

-	struct readahead_control ractl =3D {
-		.file		=3D file,
-		.mapping	=3D mapping,
-		._index		=3D index,
-		._nr_pages	=3D 0,
-	};
+	DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
 =

 retry:
 	page =3D grab_cache_page_write_begin(mapping, index, 0);
diff --git a/mm/readahead.c b/mm/readahead.c
index 65215c48f25c..f02dbebf1cef 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -706,8 +706,10 @@ void readahead_expand(struct readahead_control *ractl=
,
 			return;
 		}
 		ractl->_nr_pages++;
-		ra->size++;
-		ra->async_size++;
+		if (ra) {
+			ra->size++;
+			ra->async_size++;
+		}
 	}
 }
 EXPORT_SYMBOL(readahead_expand);

