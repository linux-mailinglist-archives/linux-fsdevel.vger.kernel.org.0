Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F993233171
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgG3MAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:00:44 -0400
Received: from relay.sw.ru ([185.231.240.75]:56914 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbgG3MAk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:00:40 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17ET-0002yZ-U7; Thu, 30 Jul 2020 15:00:21 +0300
Subject: [PATCH 14/23] net: Add net namespaces into ns_idr
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:00:35 +0300
Message-ID: <159611043578.535980.14525601933828392397.stgit@localhost.localdomain>
In-Reply-To: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now they are exposed in /proc/namespace/ directory.

We already wait RCU grace period in cleanup_net()
before pernet_operations exit, so ns_idr_unregister()
works as expected.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 net/core/net_namespace.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 5f658cbedd34..f78655a670e5 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -701,14 +701,24 @@ EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
 
 static __net_init int net_ns_net_init(struct net *net)
 {
+	int ret;
 #ifdef CONFIG_NET_NS
 	net->ns.ops = &netns_operations;
 #endif
-	return ns_alloc_inum(&net->ns);
+	ret = ns_alloc_inum(&net->ns);
+	if (ret)
+		return ret;
+
+	ret = ns_idr_register(&net->ns);
+	if (ret < 0)
+		ns_free_inum(&net->ns);
+
+	return ret;
 }
 
 static __net_exit void net_ns_net_exit(struct net *net)
 {
+	ns_idr_unregister(&net->ns);
 	ns_free_inum(&net->ns);
 }
 


