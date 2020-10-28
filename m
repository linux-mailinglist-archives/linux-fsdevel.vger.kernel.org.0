Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41629DCE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbgJ1WXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732717AbgJ1WWt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OTPRsRoa6aTzrrWDY9eL0bnLjHcEQKuNhpOoC7QlSR8=;
        b=Eo7sTueq/CbF6wjNUxtOFQhUmu/X73XPBbZG8AoEXkOfOX8QgsnCWCAUCEutwC6ukPSLUA
        Z/2ANV27ZdlKmLSU29uhNewd0CMV1WYuJOoJf64AjdCzi7Zwl4ieT7nWPzGk9jSk5gRmZV
        If3ESYCW/zHw7maToUq7nwEfWSzFaBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-7m3OfVqHNJSAm8rswS73VA-1; Wed, 28 Oct 2020 18:22:46 -0400
X-MC-Unique: 7m3OfVqHNJSAm8rswS73VA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A9FA186DD32;
        Wed, 28 Oct 2020 22:22:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C1CB60BF1;
        Wed, 28 Oct 2020 22:22:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/11] afs: Fix copy_file_range()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 22:22:43 +0000
Message-ID: <160392376353.592578.14940506424316813241.stgit@warthog.procyon.org.uk>
In-Reply-To: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
References: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The prevention of splice-write without explicit ops made the
copy_file_write() syscall to an afs file (as done by the generic/112
xfstest) fail with EINVAL.

Fix by using iter_file_splice_write() for afs.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


