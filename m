Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F01CAA82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 14:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEHMXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 08:23:39 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:57310 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727774AbgEHMXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 08:23:34 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 20EE72E1612;
        Fri,  8 May 2020 15:23:32 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id ca7YkIQC43-NVbiCTJc;
        Fri, 08 May 2020 15:23:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588940612; bh=JCfV9a+6LV7lO3l6vs+TYqJodxqNVXpsp3UM6EFrsaU=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=GB1sHnQLxmHeY5kYs6x5t0JS4qxbIgMT4npqmTRhL4nq211peBqHxULbblvWc6RNI
         NdcAdlZYpnAl6sRV19ayiqoCglrGK2rryvjg4ifVoJ3sWLaN1CX9jDEqejWApa7iuQ
         CNvETOlNi/7mABcXwm9qNZIZ8bTp4XnhRf4kk8MQ=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7008::1:4])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 74uZNHjqL4-NVWKuJN9;
        Fri, 08 May 2020 15:23:31 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 7/8] dcache: push releasing dentry lock into
 sweep_negative
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>
Date:   Fri, 08 May 2020 15:23:30 +0300
Message-ID: <158894061026.200862.15846101347037556126.stgit@buzz>
In-Reply-To: <158893941613.200862.4094521350329937435.stgit@buzz>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is preparation for the next patch.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/dcache.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0fd2e02e507b..60158065891e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -636,15 +636,17 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
  * Move cached negative dentry to the tail of parent->d_subdirs.
  * This lets walkers skip them all together at first sight.
  * Must be called at dput of negative dentry.
+ * dentry->d_lock must be held, returns with it unlocked.
  */
 static void sweep_negative(struct dentry *dentry)
+	__releases(dentry->d_lock)
 {
 	struct dentry *parent;
 
 	if (!d_is_tail_negative(dentry)) {
 		parent = lock_parent(dentry);
 		if (!parent)
-			return;
+			goto out;
 
 		if (!d_count(dentry) && d_is_negative(dentry) &&
 		    !d_is_tail_negative(dentry)) {
@@ -654,6 +656,8 @@ static void sweep_negative(struct dentry *dentry)
 
 		spin_unlock(&parent->d_lock);
 	}
+out:
+	spin_unlock(&dentry->d_lock);
 }
 
 /*
@@ -747,7 +751,8 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 		spin_unlock(&parent->d_lock);
 	if (d_is_negative(dentry))
 		sweep_negative(dentry);
-	spin_unlock(&dentry->d_lock);
+	else
+		spin_unlock(&dentry->d_lock);
 	return NULL;
 }
 
@@ -905,7 +910,8 @@ void dput(struct dentry *dentry)
 		if (likely(retain_dentry(dentry))) {
 			if (d_is_negative(dentry))
 				sweep_negative(dentry);
-			spin_unlock(&dentry->d_lock);
+			else
+				spin_unlock(&dentry->d_lock);
 			return;
 		}
 

