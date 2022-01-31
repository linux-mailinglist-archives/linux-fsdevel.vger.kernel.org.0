Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6FD4A4D8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 18:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354952AbiAaRxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 12:53:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354941AbiAaRxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643651583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Dad+NRO6CeianVL7/Op9DvhkqOApC5yos9M42t9RgSs=;
        b=FYSwW5CREfe0Kq6Oa/pTDXYNVWUSZOhnqlIbJdBih4tj7rouSTk2dNB1MENPAbqgjn9aVz
        L6gbW9QWSwhn1XEXpEAbJm7apIHPtlpOmGdTlv3cHDQL0mW3Ry5w4vZnW3SZJB5XUcgLbc
        UkHOdVtGvG+4WaG5syikzD8WBLpnD5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-ExP3oVaSOZW5qjvIia2n6A-1; Mon, 31 Jan 2022 12:53:01 -0500
X-MC-Unique: ExP3oVaSOZW5qjvIia2n6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4EE3101F001;
        Mon, 31 Jan 2022 17:52:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A3D0838D2;
        Mon, 31 Jan 2022 17:52:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] cachefiles: Fix the volume coherency check
From:   David Howells <dhowells@redhat.com>
To:     smfrench@gmail.com
Cc:     Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-cachefs@redhat.com, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 31 Jan 2022 17:52:47 +0000
Message-ID: <164365156782.2040161.8222945480682704501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the cache volume coherency attribute check.  It was copied from the
file coherency check which uses as struct to lay out the xattr, and so
needs to add a bit on to find the coherency data - but the volume coherency
attribute only contains the coherency data, so we shouldn't be using the
layout struct for it.

This has passed unnoticed so far because it only affects cifs at the
moment, and cifs had its fscache component disabled.

This can now be checked by enabling CONFIG_CIFS_FSCACHE, enabling the
following tracepoint:

	/sys/kernel/debug/tracing/events/cachefiles/cachefiles_vol_coherency/enable

and making a cifs mount.  Without this change, the trace shows a
cachefiles_vol_coherency line with "VOL BAD cmp" in it; with this change it
shows "VOL OK" instead.

Fixes: 32e150037dce ("fscache, cachefiles: Store the volume coherency data")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <smfrench@gmail.com>
cc: linux-cifs@vger.kernel.org
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/xattr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 83f41bd0c3a9..c6171e818a7c 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -218,10 +218,10 @@ bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
  */
 int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
 {
-	struct cachefiles_xattr *buf;
 	struct dentry *dentry = volume->dentry;
 	unsigned int len = volume->vcookie->coherency_len;
 	const void *p = volume->vcookie->coherency;
+	void *buf;
 	enum cachefiles_coherency_trace why;
 	ssize_t xlen;
 	int ret = -ESTALE;
@@ -245,7 +245,7 @@ int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
 					"Failed to read xattr with error %zd", xlen);
 		}
 		why = cachefiles_coherency_vol_check_xattr;
-	} else if (memcmp(buf->data, p, len) != 0) {
+	} else if (memcmp(buf, p, len) != 0) {
 		why = cachefiles_coherency_vol_check_cmp;
 	} else {
 		why = cachefiles_coherency_vol_check_ok;


