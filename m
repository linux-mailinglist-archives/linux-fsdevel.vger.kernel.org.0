Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7EFC3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 17:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfD3PHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 11:07:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfD3PHA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:07:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F28830BA1E9;
        Tue, 30 Apr 2019 15:07:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B96866D080;
        Tue, 30 Apr 2019 15:06:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/11] keys: Kill off request_key_async{,
 _with_auxdata} [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     ebiederm@xmission.com
Cc:     keyrings@vger.kernel.org, dhowells@redhat.com,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwalsh@redhat.com, vgoyal@redhat.com
Date:   Tue, 30 Apr 2019 16:06:51 +0100
Message-ID: <155663681116.31331.16982339995377317063.stgit@warthog.procyon.org.uk>
In-Reply-To: <155663679069.31331.3777091898004242996.stgit@warthog.procyon.org.uk>
References: <155663679069.31331.3777091898004242996.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 30 Apr 2019 15:07:00 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kill off request_key_async{,_with_auxdata}() as they're not currently used.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/key.h         |   11 ---------
 security/keys/request_key.c |   50 -------------------------------------------
 2 files changed, 61 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 7099985e35a9..aaa93fe3f587 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -280,17 +280,6 @@ extern struct key *request_key_with_auxdata(struct key_type *type,
 					    size_t callout_len,
 					    void *aux);
 
-extern struct key *request_key_async(struct key_type *type,
-				     const char *description,
-				     const void *callout_info,
-				     size_t callout_len);
-
-extern struct key *request_key_async_with_auxdata(struct key_type *type,
-						  const char *description,
-						  const void *callout_info,
-						  size_t callout_len,
-						  void *aux);
-
 extern int wait_for_key_construction(struct key *key, bool intr);
 
 extern int key_validate(const struct key *key);
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index a7b698394257..a5b74b7758f7 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -687,53 +687,3 @@ struct key *request_key_with_auxdata(struct key_type *type,
 	return key;
 }
 EXPORT_SYMBOL(request_key_with_auxdata);
-
-/*
- * request_key_async - Request a key (allow async construction)
- * @type: Type of key.
- * @description: The searchable description of the key.
- * @callout_info: The data to pass to the instantiation upcall (or NULL).
- * @callout_len: The length of callout_info.
- *
- * As for request_key_and_link() except that it does not add the returned key
- * to a keyring if found, new keys are always allocated in the user's quota and
- * no auxiliary data can be passed.
- *
- * The caller should call wait_for_key_construction() to wait for the
- * completion of the returned key if it is still undergoing construction.
- */
-struct key *request_key_async(struct key_type *type,
-			      const char *description,
-			      const void *callout_info,
-			      size_t callout_len)
-{
-	return request_key_and_link(type, description, callout_info,
-				    callout_len, NULL, NULL,
-				    KEY_ALLOC_IN_QUOTA);
-}
-EXPORT_SYMBOL(request_key_async);
-
-/*
- * request a key with auxiliary data for the upcaller (allow async construction)
- * @type: Type of key.
- * @description: The searchable description of the key.
- * @callout_info: The data to pass to the instantiation upcall (or NULL).
- * @callout_len: The length of callout_info.
- * @aux: Auxiliary data for the upcall.
- *
- * As for request_key_and_link() except that it does not add the returned key
- * to a keyring if found and new keys are always allocated in the user's quota.
- *
- * The caller should call wait_for_key_construction() to wait for the
- * completion of the returned key if it is still undergoing construction.
- */
-struct key *request_key_async_with_auxdata(struct key_type *type,
-					   const char *description,
-					   const void *callout_info,
-					   size_t callout_len,
-					   void *aux)
-{
-	return request_key_and_link(type, description, callout_info,
-				    callout_len, aux, NULL, KEY_ALLOC_IN_QUOTA);
-}
-EXPORT_SYMBOL(request_key_async_with_auxdata);

