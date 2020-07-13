Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8170521DC4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgGMQbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:31:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26371 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730033AbgGMQbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594657903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xY8bHMAAYMuhdLzdE9CY5HGi5hz2/1pR5v57pe/8g3I=;
        b=f4GU+aNgCUxemeObboKtNk/cd31aAWd5WVW9yblAlX/ZYfXb05nEevy2xWawN1ViUCcUDy
        xag2QGKMrnBcErfR/h0jX8Y9gf/aPW8QNg7ye9UPCQCrQOARnAGj0tp3FnLz02itWAlq4w
        v9u0OPwIk6LhDqLUfnkS5+81KBHh2DU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-x9G9ssjJP3ucHZsk_1l_bA-1; Mon, 13 Jul 2020 12:31:41 -0400
X-MC-Unique: x9G9ssjJP3ucHZsk_1l_bA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8716218FF669;
        Mon, 13 Jul 2020 16:31:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 299BF7621B;
        Mon, 13 Jul 2020 16:31:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/32] mm: Provide lru_to_last_page() to get last of a page
 list
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:31:33 +0100
Message-ID: <159465789337.1376674.4843292427395367970.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a macro, lru_to_last_page(), to find the last page in a page list
(the opposite of lru_to_page()).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/mm.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..9692b9b58b06 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -216,6 +216,7 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
 
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
+#define lru_to_last_page(head) (list_entry((head)->next, struct page, lru))
 
 /*
  * Linux kernel virtual memory manager primitives.


