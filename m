Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC103570DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353833AbhDGPsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 11:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353783AbhDGPsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617810476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3CyPEeAcTKQx8RGoMbGB/HBds9zsaqzdPRLMV+TNb98=;
        b=hJkBvnfozgbj0Emy8HDeLh4IcLcWGVT48qmKe6wy6F7Rr8TokJs05KeVtkeG+28VV0CqUM
        XDf8TKmDdp24mxAZvP0myBO365WIxsOMXWc/a/mhgC+XbHkvRP770H91vE7Q7SORHasXCX
        Y/3IDAKbYbyAGpCMaOsdub4jhQWZLb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-B4ol7rNSMWWLrHlE7ZDzNg-1; Wed, 07 Apr 2021 11:47:52 -0400
X-MC-Unique: B4ol7rNSMWWLrHlE7ZDzNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B26D95B393;
        Wed,  7 Apr 2021 15:47:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-201.rdu2.redhat.com [10.10.115.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 670E95D9DC;
        Wed,  7 Apr 2021 15:47:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/5] netfs: Don't record the copy termination error
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org
Cc:     dwysocha@redhat.com, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Apr 2021 16:47:42 +0100
Message-ID: <161781046256.463527.18158681600085556192.stgit@warthog.procyon.org.uk>
In-Reply-To: <161781041339.463527.18139104281901492882.stgit@warthog.procyon.org.uk>
References: <161781041339.463527.18139104281901492882.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't record the copy termination error in the subrequest.  We shouldn't
return it through netfs_readpage() or netfs_write_begin() as we don't let
the netfs see cache errors.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/netfs/read_helper.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 8040b76da1b6..ad0dc01319ce 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -270,10 +270,8 @@ static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
 	struct netfs_read_request *rreq = subreq->rreq;
 
 	if (IS_ERR_VALUE(transferred_or_error)) {
-		subreq->error = transferred_or_error;
 		netfs_stat(&netfs_n_rh_write_failed);
 	} else {
-		subreq->error = 0;
 		netfs_stat(&netfs_n_rh_write_done);
 	}
 


