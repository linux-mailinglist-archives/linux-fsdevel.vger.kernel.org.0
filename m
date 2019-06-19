Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37604BD08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfFSPgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 11:36:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbfFSPgo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:36:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15EB53082B69;
        Wed, 19 Jun 2019 15:36:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A05CE19C6A;
        Wed, 19 Jun 2019 15:36:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 6/6] keys: Kill off request_key_async{,
 _with_auxdata} [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jun 2019 16:36:40 +0100
Message-ID: <156095860083.25264.540321479286679885.stgit@warthog.procyon.org.uk>
In-Reply-To: <156095855610.25264.16666970456822465537.stgit@warthog.procyon.org.uk>
References: <156095855610.25264.16666970456822465537.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 19 Jun 2019 15:36:44 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kill off request_key_async{,_with_auxdata}() as they're not currently used.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/security/keys/core.rst        |   32 -----------------
 Documentation/security/keys/request-key.rst |   23 +-----------
 include/linux/key.h                         |   11 ------
 security/keys/request_key.c                 |   50 ---------------------------
 4 files changed, 2 insertions(+), 114 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 003f1452a5b7..a0e245f9576f 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1115,38 +1115,6 @@ payload contents" for more information.
     is a blob of length callout_len, if given (the length may be 0).
 
 
- *  A key can be requested asynchronously by calling one of::
-
-	struct key *request_key_async(const struct key_type *type,
-				      const char *description,
-				      const void *callout_info,
-				      size_t callout_len);
-
-    or::
-
-	struct key *request_key_async_with_auxdata(const struct key_type *type,
-						   const char *description,
-						   const char *callout_info,
-					     	   size_t callout_len,
-					     	   void *aux);
-
-    which are asynchronous equivalents of request_key() and
-    request_key_with_auxdata() respectively.
-
-    These two functions return with the key potentially still under
-    construction.  To wait for construction completion, the following should be
-    called::
-
-	int wait_for_key_construction(struct key *key, bool intr);
-
-    The function will wait for the key to finish being constructed and then
-    invokes key_validate() to return an appropriate value to indicate the state
-    of the key (0 indicates the key is usable).
-
-    If intr is true, then the wait can be interrupted by a signal, in which
-    case error ERESTARTSYS will be returned.
-
-
  *  To search for a key under RCU conditions, call::
 
 	struct key *request_key_rcu(const struct key_type *type,
diff --git a/Documentation/security/keys/request-key.rst b/Documentation/security/keys/request-key.rst
index 45049abdf290..5a210baa583a 100644
--- a/Documentation/security/keys/request-key.rst
+++ b/Documentation/security/keys/request-key.rst
@@ -21,21 +21,6 @@ or::
 					     size_t callout_len,
 					     void *aux);
 
-or::
-
-	struct key *request_key_async(const struct key_type *type,
-				      const char *description,
-				      const char *callout_info,
-				      size_t callout_len);
-
-or::
-
-	struct key *request_key_async_with_auxdata(const struct key_type *type,
-						   const char *description,
-						   const char *callout_info,
-					     	   size_t callout_len,
-						   void *aux);
-
 or::
 
 	struct key *request_key_rcu(const struct key_type *type,
@@ -53,15 +38,11 @@ does not need to link the key to a keyring to prevent it from being immediately
 destroyed.  The kernel interface returns a pointer directly to the key, and
 it's up to the caller to destroy the key.
 
-The request_key*_with_auxdata() calls are like the in-kernel request_key*()
-calls, except that they permit auxiliary data to be passed to the upcaller (the
+The request_key_with_auxdata() calls is like the in-kernel request_key() call,
+except that they permit auxiliary data to be passed to the upcaller (the
 default is NULL).  This is only useful for those key types that define their
 own upcall mechanism rather than using /sbin/request-key.
 
-The two async in-kernel calls may return keys that are still in the process of
-being constructed.  The two non-async ones will wait for construction to
-complete first.
-
 The request_key_rcu() call is like the in-kernel request_key() call, except
 that it doesn't check for keys that are under construction and doesn't attempt
 to construct missing keys.
diff --git a/include/linux/key.h b/include/linux/key.h
index 3604a554df99..4cd5669184f3 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -283,17 +283,6 @@ extern struct key *request_key_with_auxdata(struct key_type *type,
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
index f289982cb5db..36c55ef47b9e 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -739,56 +739,6 @@ struct key *request_key_with_auxdata(struct key_type *type,
 }
 EXPORT_SYMBOL(request_key_with_auxdata);
 
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
-
 /**
  * request_key_rcu - Request key from RCU-read-locked context
  * @type: The type of key we want.

