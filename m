Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 396894BCF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 17:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfFSPgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 11:36:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfFSPgN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:36:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6279A3001470;
        Wed, 19 Jun 2019 15:36:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 338531001DDC;
        Wed, 19 Jun 2019 15:36:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/6] keys: Invalidate used request_key authentication keys
 [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jun 2019 16:36:10 +0100
Message-ID: <156095857042.25264.613840154126127744.stgit@warthog.procyon.org.uk>
In-Reply-To: <156095855610.25264.16666970456822465537.stgit@warthog.procyon.org.uk>
References: <156095855610.25264.16666970456822465537.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 19 Jun 2019 15:36:13 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Invalidate used request_key authentication keys rather than revoking them
so that they get cleaned up immediately rather than potentially hanging
around.  There doesn't seem any need to keep the revoked keys around.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/key.c         |    4 ++--
 security/keys/request_key.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index bba71acec886..e792d65c0af8 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -459,7 +459,7 @@ static int __key_instantiate_and_link(struct key *key,
 
 			/* disable the authorisation key */
 			if (authkey)
-				key_revoke(authkey);
+				key_invalidate(authkey);
 
 			if (prep->expiry != TIME64_MAX) {
 				key->expiry = prep->expiry;
@@ -616,7 +616,7 @@ int key_reject_and_link(struct key *key,
 
 		/* disable the authorisation key */
 		if (authkey)
-			key_revoke(authkey);
+			key_invalidate(authkey);
 	}
 
 	mutex_unlock(&key_construction_mutex);
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index a6543ed98b1f..244e538d113f 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -222,7 +222,7 @@ static int construct_key(struct key *key, const void *callout_info,
 	/* check that the actor called complete_request_key() prior to
 	 * returning an error */
 	WARN_ON(ret < 0 &&
-		!test_bit(KEY_FLAG_REVOKED, &authkey->flags));
+		!test_bit(KEY_FLAG_INVALIDATED, &authkey->flags));
 
 	key_put(authkey);
 	kleave(" = %d", ret);

