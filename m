Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D483570CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353752AbhDGPrq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 11:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353758AbhDGPrl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617810451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axULdzcQx68+oS63cjAxzUVds96V+wt/l0Sxopf5YMM=;
        b=Yti2tFxwPqjHPxP7o5LxGNy3K8gy1joIpd9AJBykpY3DlrJBTeiipa8DY0zo0BDSgaHa8/
        mMsOjuNr/seK5bIoCMhfT5CsEBGKHtcDSgFe+M9DL2D1s+vmYYSrgiSiNHfOM21hn7m32Y
        D+bD+Jb49qaq/Nnp8Sqg0LTI1CKwqL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-_0wcNwU5NAO4X8QXnKaQBA-1; Wed, 07 Apr 2021 11:47:27 -0400
X-MC-Unique: _0wcNwU5NAO4X8QXnKaQBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0405E10054F6;
        Wed,  7 Apr 2021 15:47:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-201.rdu2.redhat.com [10.10.115.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EE071045D01;
        Wed,  7 Apr 2021 15:47:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/5] netfs: Fix a missing rreq put in netfs_write_begin()
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org
Cc:     dwysocha@redhat.com, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Apr 2021 16:47:01 +0100
Message-ID: <161781042127.463527.9154479794406046987.stgit@warthog.procyon.org.uk>
In-Reply-To: <161781041339.463527.18139104281901492882.stgit@warthog.procyon.org.uk>
References: <161781041339.463527.18139104281901492882.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

netfs_write_begin() needs to drop a ref on the read request if the network
filesystem gives an error when called to begin the caching op.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/netfs/read_helper.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 3498bde035eb..0066db21aa11 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1169,6 +1169,8 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	_leave(" = 0");
 	return 0;
 
+error_put:
+	netfs_put_read_request(rreq, false);
 error:
 	unlock_page(page);
 	put_page(page);


