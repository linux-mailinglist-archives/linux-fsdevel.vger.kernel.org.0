Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4A323A739
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgHCNGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:06:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36889 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727785AbgHCNGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596460006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylt84/QjuXGByWDOUhtjvYR5Fe+CedjDeH1XsQdkc6w=;
        b=WOe4nwI7C1e8gDhclejmEILJJ8eS85SQf6BwBLqeh3jvonxVJ+n8eMscW920kQZBZmKMe8
        NL31MOgwdZxu5SgL6xJ0zKveSDi25Jsf/I4uozZdtBD4kCFh9LkKNMXQdha5ntVZ0Hdyl7
        BpLoARJ14DPiFQLuKoSK9YiwC88gx3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-XkGgyoVaPC-uDhmHYj-5Pg-1; Mon, 03 Aug 2020 09:06:42 -0400
X-MC-Unique: XkGgyoVaPC-uDhmHYj-5Pg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC3008017FB;
        Mon,  3 Aug 2020 13:06:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3399471760;
        Mon,  3 Aug 2020 13:06:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/5] watch_queue: Make watch_sizeof() check record size [ver
 #2]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Miklos Szeredi <mszeredi@redhat.com>, dhowells@redhat.com,
        torvalds@linux-foundation.org, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, nicolas.dichtel@6wind.com, raven@themaw.net,
        christian@brauner.io, jlayton@redhat.com, kzak@redhat.com,
        mszeredi@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:06:37 +0100
Message-ID: <159645999738.1779777.4882634293182825979.stgit@warthog.procyon.org.uk>
In-Reply-To: <159645997768.1779777.8286723139418624756.stgit@warthog.procyon.org.uk>
References: <159645997768.1779777.8286723139418624756.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make watch_sizeof() give a build error if the size of the struct won't fit
into the size field in the header.

Reported-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/watch_queue.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 5e08db2adc31..38e04c7a7951 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -120,7 +120,12 @@ static inline void remove_watch_list(struct watch_list *wlist, u64 id)
  * watch_sizeof - Calculate the information part of the size of a watch record,
  * given the structure size.
  */
-#define watch_sizeof(STRUCT) (sizeof(STRUCT) << WATCH_INFO_LENGTH__SHIFT)
+#define watch_sizeof(STRUCT) \
+	({								\
+		size_t max = WATCH_INFO_LENGTH >> WATCH_INFO_LENGTH__SHIFT; \
+		BUILD_BUG_ON(sizeof(STRUCT) > max);			\
+		sizeof(STRUCT) << WATCH_INFO_LENGTH__SHIFT;		\
+	})
 
 #endif
 


