Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D44B13C32F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgAONcn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:32:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49733 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729396AbgAONcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579095160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z1+VHuLnJ0MCQ+84p0mYLHXrc1fZa14EGegTn1GnyOY=;
        b=Hu/J9C9+Vd/x2UQ6CR6W93Ur4L//+roDEQsZfNTLNtN0UUqry7IKIzgqxcZYYAImWu9O3R
        /kodmLLP0/7Go4b/zguq2fjnliO8mBqJxKxr/pzVFlRoyTOBBhpPbapg0sdv8vwf7AiDWp
        3YJ1LZ7M26meTXpKl0gWThLYLS8e0Jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-wXKwK-g-ORe-6M08iyOlWg-1; Wed, 15 Jan 2020 08:32:36 -0500
X-MC-Unique: wXKwK-g-ORe-6M08iyOlWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4943107ACC5;
        Wed, 15 Jan 2020 13:32:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7067B19C5B;
        Wed, 15 Jan 2020 13:32:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 13/14] selinux: Implement the watch_key security hook
 [ver #3]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 15 Jan 2020 13:32:31 +0000
Message-ID: <157909515176.20155.5691408493465374252.stgit@warthog.procyon.org.uk>
In-Reply-To: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
References: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the watch_key security hook to make sure that a key grants the
caller View permission in order to set a watch on a key.

For the moment, the watch_devices security hook is left unimplemented as
it's not obvious what the object should be since the queue is global and
didn't previously exist.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
---

 security/selinux/hooks.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 116b4d644f68..d838d1b58d88 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6587,6 +6587,17 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 	*_buffer = context;
 	return rc;
 }
+
+#ifdef CONFIG_KEY_NOTIFICATIONS
+static int selinux_watch_key(struct key *key)
+{
+	struct key_security_struct *ksec = key->security;
+	u32 sid = current_sid();
+
+	return avc_has_perm(&selinux_state,
+			    sid, ksec->sid, SECCLASS_KEY, KEY_NEED_VIEW, NULL);
+}
+#endif
 #endif
 
 #ifdef CONFIG_SECURITY_INFINIBAND
@@ -7081,6 +7092,9 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(key_free, selinux_key_free),
 	LSM_HOOK_INIT(key_permission, selinux_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
+#ifdef CONFIG_KEY_NOTIFICATIONS
+	LSM_HOOK_INIT(watch_key, selinux_watch_key),
+#endif
 #endif
 
 #ifdef CONFIG_AUDIT

