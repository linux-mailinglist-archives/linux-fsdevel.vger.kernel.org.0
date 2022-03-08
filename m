Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9932A4D274A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 05:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiCIBjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 20:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiCIBjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:39:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D976D108A
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 17:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646789935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UdOgDnE1tPhxPwKj+dzga7GCH2QN5VPxiT3X8/my5Mg=;
        b=LQFCnuZdnONR8OF3Q89XXD2sk51SBvVVcT963tIT/e+tA/UTzV8MUA5ltQyluf88grHsE2
        IkTy6465bl4uYq20bQTT6qg84D+jvep6styJJfZ6hQ9fJE3mqM+pCPaQm7UeUkclIqgzL0
        hMOTL1bS5uzPqqdobqRpyGbyPplu5hA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-7r9rJDxVPWWPW0jfCOA-5Q-1; Tue, 08 Mar 2022 18:25:48 -0500
X-MC-Unique: 7r9rJDxVPWWPW0jfCOA-5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55F98801AEB;
        Tue,  8 Mar 2022 23:25:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66E2C2D1F4;
        Tue,  8 Mar 2022 23:25:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 02/19] netfs: Generate enums from trace symbol mapping
 lists
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Mar 2022 23:25:24 +0000
Message-ID: <164678192454.1200972.4428834328108580460.stgit@warthog.procyon.org.uk>
In-Reply-To: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

netfs has a number of lists of symbols for use in tracing, listed in an
enum and then listed again in a symbol->string mapping for use with
__print_symbolic().  This is, however, redundant.

Instead, use the symbol->string mapping list to also generate the enum
where the enum is in the same file.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com

Link: https://lore.kernel.org/r/164622980839.3564931.5673300162465266909.stgit@warthog.procyon.org.uk/ # v1
---

 include/trace/events/netfs.h |   57 ++++++++++--------------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index e6f4ebbb4c69..88d9a74dd346 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -15,49 +15,6 @@
 /*
  * Define enums for tracing information.
  */
-#ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
-#define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
-
-enum netfs_read_trace {
-	netfs_read_trace_expanded,
-	netfs_read_trace_readahead,
-	netfs_read_trace_readpage,
-	netfs_read_trace_write_begin,
-};
-
-enum netfs_rreq_trace {
-	netfs_rreq_trace_assess,
-	netfs_rreq_trace_done,
-	netfs_rreq_trace_free,
-	netfs_rreq_trace_resubmit,
-	netfs_rreq_trace_unlock,
-	netfs_rreq_trace_unmark,
-	netfs_rreq_trace_write,
-};
-
-enum netfs_sreq_trace {
-	netfs_sreq_trace_download_instead,
-	netfs_sreq_trace_free,
-	netfs_sreq_trace_prepare,
-	netfs_sreq_trace_resubmit_short,
-	netfs_sreq_trace_submit,
-	netfs_sreq_trace_terminated,
-	netfs_sreq_trace_write,
-	netfs_sreq_trace_write_skip,
-	netfs_sreq_trace_write_term,
-};
-
-enum netfs_failure {
-	netfs_fail_check_write_begin,
-	netfs_fail_copy_to_cache,
-	netfs_fail_read,
-	netfs_fail_short_readpage,
-	netfs_fail_short_write_begin,
-	netfs_fail_prepare_write,
-};
-
-#endif
-
 #define netfs_read_traces					\
 	EM(netfs_read_trace_expanded,		"EXPANDED ")	\
 	EM(netfs_read_trace_readahead,		"READAHEAD")	\
@@ -98,6 +55,20 @@ enum netfs_failure {
 	EM(netfs_fail_short_write_begin,	"short-write-begin")	\
 	E_(netfs_fail_prepare_write,		"prep-write")
 
+#ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
+#define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
+
+#undef EM
+#undef E_
+#define EM(a, b) a,
+#define E_(a, b) a
+
+enum netfs_read_trace { netfs_read_traces } __mode(byte);
+enum netfs_rreq_trace { netfs_rreq_traces } __mode(byte);
+enum netfs_sreq_trace { netfs_sreq_traces } __mode(byte);
+enum netfs_failure { netfs_failures } __mode(byte);
+
+#endif
 
 /*
  * Export enum symbols via userspace.


