Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6444CAF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 22:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhKJVLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 16:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233226AbhKJVLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 16:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636578504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACbG/FwjyxRlnMgIISLIimd21y8r4Isd1KnKpMPaz4E=;
        b=Ie9tGbDMohI/e/x4M+zWvH/KZShQ8YCrK2ocrRKiqLbqmTZqaE1Y79AGgEjXV0j0SUI0af
        ccl4RSuGPzSVCxaIkaq25CUJQlWUJROxKmgnS853Q+eJFLRuNnHOvkALozGOeS+8L1Kr7H
        ON07FTgM1yXcfFjKNjYLS9woMuoEbFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-2kH5HUYCNtatfqP1AiC6Qw-1; Wed, 10 Nov 2021 16:08:21 -0500
X-MC-Unique: 2kH5HUYCNtatfqP1AiC6Qw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4123802C8F;
        Wed, 10 Nov 2021 21:08:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24263BC880;
        Wed, 10 Nov 2021 21:08:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v5 1/4] folio: Add a function to change the private data
 attached to a folio
From:   David Howells <dhowells@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        kafs-testing@auristor.com, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Nov 2021 21:08:05 +0000
Message-ID: <163657848531.834781.14269656212269187893.stgit@warthog.procyon.org.uk>
In-Reply-To: <163657847613.834781.7923681076643317435.stgit@warthog.procyon.org.uk>
References: <163657847613.834781.7923681076643317435.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function, folio_change_private(), that will change the private data
attached to a folio, without the need to twiddle the private bit or the
refcount.  It assumes that folio_add_private() has already been called on
the page.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Dominique Martinet <asmadeus@codewreck.org>
Tested-by: kafs-testing@auristor.com
Link: https://lore.kernel.org/r/162981149911.1901565.17776700811659843340.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/163005743485.2472992.5100702469503007023.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163584180781.4023316.5037526301198034310.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/163649324326.309189.17817587229450840783.stgit@warthog.procyon.org.uk/ # v4
---

 include/linux/pagemap.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 6a30916b76e5..1f560aecd9b5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -279,6 +279,25 @@ static inline void folio_attach_private(struct folio *folio, void *data)
 	folio_set_private(folio);
 }
 
+/**
+ * folio_change_private - Change private data on a folio.
+ * @folio: Folio to change the data on.
+ * @data: Data to set on the folio.
+ *
+ * Change the private data attached to a folio and return the old
+ * data.  The page must previously have had data attached and the data
+ * must be detached before the folio will be freed.
+ *
+ * Return: Data that was previously attached to the folio.
+ */
+static inline void *folio_change_private(struct folio *folio, void *data)
+{
+	void *old = folio_get_private(folio);
+
+	folio->private = data;
+	return old;
+}
+
 /**
  * folio_detach_private - Detach private data from a folio.
  * @folio: Folio to detach data from.


