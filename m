Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF9FFA3968
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 16:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfH3Ole convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 10:41:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfH3Ole (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:41:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A45901053717;
        Fri, 30 Aug 2019 14:41:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F31AF414B;
        Fri, 30 Aug 2019 14:41:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <21eb33e8-5624-0124-8690-bbea41a1b589@tycho.nsa.gov>
References: <21eb33e8-5624-0124-8690-bbea41a1b589@tycho.nsa.gov> <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk> <156717352079.2204.16378075382991665807.stgit@warthog.procyon.org.uk>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] selinux: Implement the watch_key security hook [ver #7]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13307.1567176090.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 30 Aug 2019 15:41:30 +0100
Message-ID: <13308.1567176090@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Fri, 30 Aug 2019 14:41:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

How about the attached instead, then?

David
---
commit 00444a695b35c602230ac2cabb4f1d7e94e3966d
Author: David Howells <dhowells@redhat.com>
Date:   Thu Aug 29 17:01:34 2019 +0100

    selinux: Implement the watch_key security hook
    
    Implement the watch_key security hook to make sure that a key grants the
    caller View permission in order to set a watch on a key.
    
    For the moment, the watch_devices security hook is left unimplemented as
    it's not obvious what the object should be since the queue is global and
    didn't previously exist.
    
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 74dd46de01b6..88df06969bed 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6533,6 +6533,17 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
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
@@ -6965,6 +6976,9 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(key_free, selinux_key_free),
 	LSM_HOOK_INIT(key_permission, selinux_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
+#ifdef CONFIG_KEY_NOTIFICATIONS
+	LSM_HOOK_INIT(watch_key, selinux_watch_key),
+#endif
 #endif
 
 #ifdef CONFIG_AUDIT
