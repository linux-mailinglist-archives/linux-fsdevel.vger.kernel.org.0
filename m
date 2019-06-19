Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438F34BCEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 17:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfFSPgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 11:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfFSPgF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:36:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AD2B308339E;
        Wed, 19 Jun 2019 15:36:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2137C19C6F;
        Wed, 19 Jun 2019 15:36:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/6] keys: Fix request_key() lack of Link perm check on
 found key [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jun 2019 16:36:03 +0100
Message-ID: <156095856342.25264.11029423243013014147.stgit@warthog.procyon.org.uk>
In-Reply-To: <156095855610.25264.16666970456822465537.stgit@warthog.procyon.org.uk>
References: <156095855610.25264.16666970456822465537.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 19 Jun 2019 15:36:05 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The request_key() syscall allows a process to gain access to the 'possessor'
permits of any key that grants it Search permission by virtue of request_key()
not checking whether a key it finds grants Link permission to the caller.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/security/keys/core.rst |    4 ++++
 security/keys/request_key.c          |   10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 823d29bf44f7..82dd457ff78d 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -433,6 +433,10 @@ The main syscalls are:
      /sbin/request-key will be invoked in an attempt to obtain a key. The
      callout_info string will be passed as an argument to the program.
 
+     To link a key into the destination keyring the key must grant link
+     permission on the key to the caller and the keyring must grant write
+     permission.
+
      See also Documentation/security/keys/request-key.rst.
 
 
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 857da65e1940..a6543ed98b1f 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -564,6 +564,16 @@ struct key *request_key_and_link(struct key_type *type,
 	key_ref = search_process_keyrings(&ctx);
 
 	if (!IS_ERR(key_ref)) {
+		if (dest_keyring) {
+			ret = key_task_permission(key_ref, current_cred(),
+						  KEY_NEED_LINK);
+			if (ret < 0) {
+				key_ref_put(key_ref);
+				key = ERR_PTR(ret);
+				goto error_free;
+			}
+		}
+
 		key = key_ref_to_ptr(key_ref);
 		if (dest_keyring) {
 			ret = key_link(dest_keyring, key);

