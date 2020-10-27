Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EB129ADD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbgJ0NuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 09:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752691AbgJ0NuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603806608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2rnUKEZ22Vx5ogw1wCvAP9HIPkqe7RCtGF/gA32QhE=;
        b=OMpo2w/IFpjcPz7+qEXS2srehL8AaO1gLtEV1Dk7iVO5+6eK4R/3p2G6T7Mjx0h+eDZ/Wz
        R+nx3C1GC4oQSl3A+tedTyqcPcP/kvPpr9C2jRWr3EGi892WFGXkvGMBBpAefs1mwO+3T+
        Z+yqfQx0bqZJj5L85G2CQ3tQBRHhrds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-wVeQcTRKPwCO7Q_duK70uQ-1; Tue, 27 Oct 2020 09:50:06 -0400
X-MC-Unique: wVeQcTRKPwCO7Q_duK70uQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC9AFADC28;
        Tue, 27 Oct 2020 13:50:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03D235C1BB;
        Tue, 27 Oct 2020 13:50:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/10] afs: Fix copy_file_range()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 27 Oct 2020 13:50:03 +0000
Message-ID: <160380660321.3467511.6644741119983042797.stgit@warthog.procyon.org.uk>
In-Reply-To: <160380659566.3467511.15495463187114465303.stgit@warthog.procyon.org.uk>
References: <160380659566.3467511.15495463187114465303.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The prevention of splice-write without explicit ops made the
copy_file_write() syscall to an afs file (as done by the generic/112
xfstest) fail with EINVAL.

Fix by using iter_file_splice_write() for afs.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
---

 fs/afs/file.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 371d1488cc54..91225421ad37 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -33,6 +33,7 @@ const struct file_operations afs_file_operations = {
 	.write_iter	= afs_file_write,
 	.mmap		= afs_file_mmap,
 	.splice_read	= generic_file_splice_read,
+	.splice_write	= iter_file_splice_write,
 	.fsync		= afs_fsync,
 	.lock		= afs_lock,
 	.flock		= afs_flock,


