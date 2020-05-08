Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF41CAA7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 14:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgEHMXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 08:23:33 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:34772 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727124AbgEHMXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 08:23:31 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id C19C22E158B;
        Fri,  8 May 2020 15:23:26 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id CMbOpsqaf5-NPAKSseD;
        Fri, 08 May 2020 15:23:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588940606; bh=gAc8zimgDuqoVSCzjYmfsuvcNfaJdwfxgsEnXz43eRQ=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=Dudi4cnwJ7t5xj12iPVVfiBK1+NBPLvmfgEDa3uLI21UMZu+g4jxgwiqUQzMkFq2L
         2yptU+ynirEEliWdMzQntV7Y9Uj6YtqlJQnZGHLdge2EEphAu+qaE/aZodpzCOKE8z
         PfrjiH4Ms99VevQrQltHSx3Ij7B4tUi8LDePTgvM=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7008::1:4])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id rgqNvxq2Fn-NPWiN7wm;
        Fri, 08 May 2020 15:23:25 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 5/8] dcache: add action D_WALK_SKIP_SIBLINGS to d_walk()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>
Date:   Fri, 08 May 2020 15:23:25 +0300
Message-ID: <158894060525.200862.12478833917149869939.stgit@buzz>
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

This lets skip remaining siblings at seeing d_is_tail_negative().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/dcache.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 743255773cc7..44c6832d21d6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1303,12 +1303,14 @@ EXPORT_SYMBOL(shrink_dcache_sb);
  * @D_WALK_QUIT:	quit walk
  * @D_WALK_NORETRY:	quit when retry is needed
  * @D_WALK_SKIP:	skip this dentry and its children
+ * @D_WALK_SKIP_SIBLINGS: skip siblings and their children
  */
 enum d_walk_ret {
 	D_WALK_CONTINUE,
 	D_WALK_QUIT,
 	D_WALK_NORETRY,
 	D_WALK_SKIP,
+	D_WALK_SKIP_SIBLINGS,
 };
 
 /**
@@ -1339,6 +1341,7 @@ static void d_walk(struct dentry *parent, void *data,
 		break;
 	case D_WALK_QUIT:
 	case D_WALK_SKIP:
+	case D_WALK_SKIP_SIBLINGS:
 		goto out_unlock;
 	case D_WALK_NORETRY:
 		retry = false;
@@ -1370,6 +1373,9 @@ static void d_walk(struct dentry *parent, void *data,
 		case D_WALK_SKIP:
 			spin_unlock(&dentry->d_lock);
 			continue;
+		case D_WALK_SKIP_SIBLINGS:
+			spin_unlock(&dentry->d_lock);
+			goto skip_siblings;
 		}
 
 		if (!list_empty(&dentry->d_subdirs)) {
@@ -1381,6 +1387,7 @@ static void d_walk(struct dentry *parent, void *data,
 		}
 		spin_unlock(&dentry->d_lock);
 	}
+skip_siblings:
 	/*
 	 * All done at this level ... ascend and resume the search.
 	 */

