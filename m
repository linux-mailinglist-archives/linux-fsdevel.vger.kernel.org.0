Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED491D56D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 18:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgEOQyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 12:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726179AbgEOQyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 12:54:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D2EC061A0C;
        Fri, 15 May 2020 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=35Zii6i4JvBVIwt++4MobD5fmQN+0ZMev0/6oq2FWlU=; b=sKR9XMpoy2Gw1a2SclRMC7M5h8
        dMp9OGfIHk5Dlc7qP+GJC4+TnUureCvxAkkgmKj5uRtXS9xTYkOwVK7icAvyKpnV151QOsZgjY+D2
        /eIByASXq4bSkMug0HXGMPHw6P5QaFQJcPBU0j2s5CshFkryj1cwDNk1u41QiswTvKnmWNunaaBX0
        6xfKMup1PgYGaEFkVWxIPfS8N1WzfnETFfQhVe877oDiBFjeOW9+xAPEL8WF5NZ1KUK5ayVbAv8uK
        npS+VpLD1Xuun6BIyNMLPkMyzNQw9B9NXK501OWWVpE5mMyJqGjWT3kDn/98+wZ850EEn+UVc07CG
        dEa3UJEA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZdbR-0001p8-IH; Fri, 15 May 2020 16:54:29 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] fs: fix namespace.c build error when
 CONFIG_MOUNT_NOTIFICATIONS is not set
Message-ID: <f1ada6bd-5d57-eaf2-f834-9975361b2a21@infradead.org>
Date:   Fri, 15 May 2020 09:54:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error when CONFIG_MOUNT_NOTIFICATIONS is not set/enabled.

../fs/namespace.c:4320:42: error: 'struct mount' has no member named 'mnt_topology_changes'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/namespace.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20200515.orig/fs/namespace.c
+++ linux-next-20200515/fs/namespace.c
@@ -4317,7 +4317,11 @@ int fsinfo_generic_mount_topology(struct
 
 	m = real_mount(path->mnt);
 
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
 	p->mnt_topology_changes	= atomic_read(&m->mnt_topology_changes);
+#else
+	p->mnt_topology_changes	= 0;
+#endif
 	p->parent_id = m->mnt_parent->mnt_id;
 
 	if (path->mnt == root.mnt) {

