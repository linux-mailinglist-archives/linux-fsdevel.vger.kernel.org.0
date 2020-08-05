Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB1523D0E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgHETx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 15:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgHEQtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:49:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71793C034626;
        Wed,  5 Aug 2020 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=aQaNuTuKrv/QpgSuKkWo+skzZpmsy56Ti//TuRZUJ/o=; b=KAxbeNa8Sc0qbF7vMs7exLRKW/
        r07rdTZDoU658JGP/zM4K8pbrXHc8vZ8F1lfh6xl5Cwz+XrgNLZecJDGyeFLJ+E3enVzL97zS/J9E
        X4XY7H+djuNDSTwr0ehHq3NlnUysRoTIA4HpKVLnIWZ46mOeRLPNj9tRfe78qoatIVWJZbZyVEEu0
        FjUACpRyQOCkVYcKm7eBRV7O3l6tMrxKYN+g6C7QGeYE6ETxFGPmwA2Iyl7uWAqDpDgP4AFs+yMxO
        2AX4kRFtc96qYaEa9MfM7kC/BpoCHXGSpl8RkYFnTGsyyOO2LIh3X2Mbbl7HucEO5DAKf9lNjLZm1
        VMfw+f2Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3JCg-00045d-SL; Wed, 05 Aug 2020 13:11:35 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] fs: mount_notify.c: fix build without CONFIG_FSINFO
Message-ID: <cb34df80-d6af-507d-9935-1685b787f7a3@infradead.org>
Date:   Wed, 5 Aug 2020 06:11:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix mount_notify.c build errors when CONFIG_FSINFO is not set/enabled:

../fs/mount_notify.c:94:28: error: 'struct mount' has no member named 'mnt_unique_id'; did you mean 'mnt_group_id'?
../fs/mount_notify.c:109:28: error: 'struct mount' has no member named 'mnt_unique_id'; did you mean 'mnt_group_id'?

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/mount_notify.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20200805.orig/fs/mount_notify.c
+++ linux-next-20200805/fs/mount_notify.c
@@ -91,7 +91,9 @@ void notify_mount(struct mount *trigger,
 	n.watch.type	= WATCH_TYPE_MOUNT_NOTIFY;
 	n.watch.subtype	= subtype;
 	n.watch.info	= info_flags | watch_sizeof(n);
+#ifdef CONFIG_FSINFO
 	n.triggered_on	= trigger->mnt_unique_id;
+#endif
 
 	smp_wmb(); /* See fsinfo_generic_mount_info(). */
 
@@ -106,7 +108,9 @@ void notify_mount(struct mount *trigger,
 	case NOTIFY_MOUNT_UNMOUNT:
 	case NOTIFY_MOUNT_MOVE_FROM:
 	case NOTIFY_MOUNT_MOVE_TO:
+#ifdef CONFIG_FSINFO
 		n.auxiliary_mount = aux->mnt_unique_id;
+#endif
 		atomic_long_inc(&trigger->mnt_topology_changes);
 		atomic_long_inc(&aux->mnt_topology_changes);
 		break;

