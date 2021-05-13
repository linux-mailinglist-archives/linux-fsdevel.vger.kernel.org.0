Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E681737F5DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 12:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhEMKui (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 06:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231956AbhEMKud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 06:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620902963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hLTy2FqhYn8UYNDDx5zbQVMO+wFz0eJkwnkoKVTwuLc=;
        b=QCZpILTy3l7Cce0cDz30Cj6oG3f6NuveDDN16X+dW0AwqvMyD84xTSx5MTGICdT3eqPWgf
        D9jW8raCxwNVokS+aLicWRsV9lQQbbqrxdzv9xNMfshOGU7AGps3MgJLn8Q6Ru9i+wP9tC
        AryIn30A1C8aNHRT5DnWwyCKtb+Md9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-_zrl2b_yMqSu5EjZ_hHK9w-1; Thu, 13 May 2021 06:49:21 -0400
X-MC-Unique: _zrl2b_yMqSu5EjZ_hHK9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0822B80DE1E;
        Thu, 13 May 2021 10:49:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9756919D7C;
        Thu, 13 May 2021 10:49:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] netfs: Pass flags through to grab_cache_page_write_begin()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     linux-mm@kvack.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com
Date:   Thu, 13 May 2021 11:49:13 +0100
Message-ID: <162090295383.3165945.13595101698295243662.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In netfs_write_begin(), pass the AOP flags through to
grab_cache_page_write_begin() so that a request to use GFP_NOFS is honoured.

Fixes: e1b1240c1ff5 ("netfs: Add write_begin helper")
Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-mm@kvack.org
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
---

 fs/netfs/read_helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 193841d03de0..725614625ed4 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1068,7 +1068,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
 
 retry:
-	page = grab_cache_page_write_begin(mapping, index, 0);
+	page = grab_cache_page_write_begin(mapping, index, flags);
 	if (!page)
 		return -ENOMEM;
 


