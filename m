Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DA23AF7A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 23:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhFUVrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 17:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231745AbhFUVrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624311905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P12DHTvROaKPzooVSFg2eC6cY1TPe7SDCVWufI7SqWQ=;
        b=RB5HrQ9sVRFb6tKtc87LE/Fk3G7+/yaoHmErSjBuP+umJmqlmocLbuW3A1E2U1f0mtkrBq
        dfQl3lPn2PNqfNwRoILxJxGua0X4c1Pf5hCFRuKQ55ToLaGWC1pBYfH9xoC0ZQW6V+S9Cc
        UZsTLbdMJY1dm0ckkYFzNrHMed84jLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-k2ZRPku-Nke9YSCC_h4IqQ-1; Mon, 21 Jun 2021 17:45:04 -0400
X-MC-Unique: k2ZRPku-Nke9YSCC_h4IqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AC84100C610;
        Mon, 21 Jun 2021 21:45:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16E595C1C2;
        Mon, 21 Jun 2021 21:44:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/12] fscache: Select netfs stats if fscache stats are
 enabled
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Jun 2021 22:44:56 +0100
Message-ID: <162431189627.2908479.9165349423842063755.stgit@warthog.procyon.org.uk>
In-Reply-To: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
References: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unconditionally select the stats produced by the netfs lib if fscache stats
are enabled as the former are displayed in the latter's procfile.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
index 427efa73b9bd..92c87d8e0913 100644
--- a/fs/fscache/Kconfig
+++ b/fs/fscache/Kconfig
@@ -14,6 +14,7 @@ config FSCACHE
 config FSCACHE_STATS
 	bool "Gather statistical information on local caching"
 	depends on FSCACHE && PROC_FS
+	select NETFS_STATS
 	help
 	  This option causes statistical information to be gathered on local
 	  caching and exported through file:


