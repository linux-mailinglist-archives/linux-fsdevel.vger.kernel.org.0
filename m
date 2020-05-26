Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583301E209C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 13:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbgEZLFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 07:05:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58649 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388968AbgEZLFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 07:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590491148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YL7I5JCIHEnCOMA27cTClA3wSdtYCHTGXJdbbFxfa+8=;
        b=WfzmWy96QKi5ekA1JKgXSwX1RSnZgHvJV9OKmTWFVTJ2AcC/9OXXOQLZ8XucgHO6QRPaXs
        1WgMwR71vkLGummXyeYBN2SsJ8tVPqE82xyBGByetceYpsMmPd2baKkh5KbYKJLXoRmuZO
        zfPLY7fRDwn8fzeQk7TK3/zu6GUlB0c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-oul4qWOMOT2afzDmlEs_tA-1; Tue, 26 May 2020 07:05:46 -0400
X-MC-Unique: oul4qWOMOT2afzDmlEs_tA-1
Received: by mail-wr1-f72.google.com with SMTP id l1so5986256wrc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 04:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YL7I5JCIHEnCOMA27cTClA3wSdtYCHTGXJdbbFxfa+8=;
        b=BgoBXP53FXzoUi80F2efeo83fp/d3Z8Oxe7ug+iUQ6bL38fazTHM1rcknIqhqN7nlo
         SflfKUZvOKYvMMIY7UGIB4UPOxw7trzSfCejpKT3A6F/qiKSi39KxTbb93Ml+/7TmB6v
         Tx/4WpThZ9mqGSB4SAC3/yteLTvzhExiQlTM84fbgKslcf16qBEbGxlNPhUBVO3pBn5B
         avob11DvHkcA7SvRS5mdqPlTD9OYBf35jtAX5pl2P/whAmdcVdabx97zQmSLsqcyE17R
         KcO4tzLEaxlyV1yTF8n3UH8VVaUkCj8NF8CZJ5nyIHqZPSlyn5fHZhhtFGO06canJ9YR
         IQSg==
X-Gm-Message-State: AOAM531StHrRuttpEfGShHcMJ3Lu8Eskln4a63q5uX6azvvjH0ZMFKSX
        ju+2fmCySRSSJ1VH5ZHuNOI92BwJkw2ksOu5CeIBT0wyI2J6ismgK8ECG0D/2cr8sKF2SJc0kCz
        eZ2a3piPzrMJCV364Tf99LclzVg==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr18085333wrs.356.1590491145437;
        Tue, 26 May 2020 04:05:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo4BV3xWVL52mX4Nu+TG9ys/JSV0Y3savYX2kM7iRzxuz+P1aX7wtkuMtb+MvbeCMZqXp14Q==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr18085316wrs.356.1590491145188;
        Tue, 26 May 2020 04:05:45 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.118])
        by smtp.gmail.com with ESMTPSA id d6sm22928240wrj.90.2020.05.26.04.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 04:05:36 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v3 7/7] [not for merge] netstats: example use of stats_fs API
Date:   Tue, 26 May 2020 13:03:17 +0200
Message-Id: <20200526110318.69006-8-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200526110318.69006-1-eesposit@redhat.com>
References: <20200526110318.69006-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Apply stats_fs on the networking statistics subsystem.

Currently it only works with disabled network namespace
(CONFIG_NET_NS=n), because multiple namespaces will have the same
device name under the same root source that will cause a conflict in
stats_fs.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 include/linux/netdevice.h |  2 ++
 net/Kconfig               |  1 +
 net/core/dev.c            | 66 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 130a668049ab..408c4e7b0e21 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -48,6 +48,7 @@
 #include <uapi/linux/if_bonding.h>
 #include <uapi/linux/pkt_cls.h>
 #include <linux/hashtable.h>
+#include <linux/stats_fs.h>
 
 struct netpoll_info;
 struct device;
@@ -2117,6 +2118,7 @@ struct net_device {
 	unsigned		wol_enabled:1;
 
 	struct list_head	net_notifier_list;
+	struct stats_fs_source	*stats_fs_src;
 
 #if IS_ENABLED(CONFIG_MACSEC)
 	/* MACsec management functions */
diff --git a/net/Kconfig b/net/Kconfig
index df8d8c9bd021..3441d5bb6107 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -8,6 +8,7 @@ menuconfig NET
 	select NLATTR
 	select GENERIC_NET_UTILS
 	select BPF
+	select STATS_FS_API
 	---help---
 	  Unless you really know what you are doing, you should say Y here.
 	  The reason is that some programs need kernel networking support even
diff --git a/net/core/dev.c b/net/core/dev.c
index 522288177bbd..3db48cd1a097 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -142,6 +142,7 @@
 #include <linux/net_namespace.h>
 #include <linux/indirect_call_wrapper.h>
 #include <net/devlink.h>
+#include <linux/stats_fs.h>
 
 #include "net-sysfs.h"
 
@@ -150,6 +151,11 @@
 /* This should be increased if a protocol with a bigger head is added. */
 #define GRO_MAX_HEAD (MAX_HEADER + 128)
 
+#define NETDEV_STAT(str, m, ...)						\
+	{ str, offsetof(struct rtnl_link_stats64, m),				\
+	  &stats_fs_type_netdev_u64,						\
+	  STATS_FS_SUM, ## __VA_ARGS__ }
+
 static DEFINE_SPINLOCK(ptype_lock);
 static DEFINE_SPINLOCK(offload_lock);
 struct list_head ptype_base[PTYPE_HASH_SIZE] __read_mostly;
@@ -196,6 +202,53 @@ static DEFINE_READ_MOSTLY_HASHTABLE(napi_hash, 8);
 
 static seqcount_t devnet_rename_seq;
 
+static uint64_t stats_fs_get_netdev_u64(struct stats_fs_value *val,
+					void *base)
+{
+	struct net_device *netdev = (struct net_device *)base;
+	struct rtnl_link_stats64 net_stats;
+
+	dev_get_stats(netdev, &net_stats);
+
+	return stats_fs_get_u64(val, &net_stats);
+}
+
+static struct stats_fs_type stats_fs_type_netdev_u64 = {
+	.get = stats_fs_get_netdev_u64,
+	.clear = NULL,
+	.sign = false
+};
+
+static struct stats_fs_source *netdev_root;
+
+static struct stats_fs_value stats_fs_netdev_entries[] = {
+	NETDEV_STAT("rx_packets", rx_packets),
+	NETDEV_STAT("tx_packets", tx_packets),
+	NETDEV_STAT("rx_bytes", rx_bytes),
+	NETDEV_STAT("tx_bytes", tx_bytes),
+	NETDEV_STAT("rx_errors", rx_errors),
+	NETDEV_STAT("tx_errors", tx_errors),
+	NETDEV_STAT("rx_dropped", rx_dropped),
+	NETDEV_STAT("tx_dropped", tx_dropped),
+	NETDEV_STAT("multicast", multicast),
+	NETDEV_STAT("collisions", collisions),
+	NETDEV_STAT("rx_length_errors", rx_length_errors),
+	NETDEV_STAT("rx_over_errors", rx_over_errors),
+	NETDEV_STAT("rx_crc_errors", rx_crc_errors),
+	NETDEV_STAT("rx_frame_errors", rx_frame_errors),
+	NETDEV_STAT("rx_fifo_errors", rx_fifo_errors),
+	NETDEV_STAT("rx_missed_errors", rx_missed_errors),
+	NETDEV_STAT("tx_aborted_errors", tx_aborted_errors),
+	NETDEV_STAT("tx_carrier_errors", tx_carrier_errors),
+	NETDEV_STAT("tx_fifo_errors", tx_fifo_errors),
+	NETDEV_STAT("tx_heartbeat_errors", tx_heartbeat_errors),
+	NETDEV_STAT("tx_window_errors", tx_window_errors),
+	NETDEV_STAT("rx_compressed", rx_compressed),
+	NETDEV_STAT("tx_compressed", tx_compressed),
+	NETDEV_STAT("rx_nohandler", rx_nohandler),
+	{ NULL }
+};
+
 static inline void dev_base_seq_inc(struct net *net)
 {
 	while (++net->dev_base_seq == 0)
@@ -8783,6 +8836,11 @@ static void rollback_registered_many(struct list_head *head)
 	ASSERT_RTNL();
 
 	list_for_each_entry_safe(dev, tmp, head, unreg_list) {
+		stats_fs_source_remove_subordinate(netdev_root,
+						   dev->stats_fs_src);
+		stats_fs_source_revoke(dev->stats_fs_src);
+		stats_fs_source_put(dev->stats_fs_src);
+
 		/* Some devices call without registering
 		 * for initialization unwind. Remove those
 		 * devices and proceed with the remaining.
@@ -9436,6 +9494,11 @@ int register_netdevice(struct net_device *dev)
 	    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
 		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL);
 
+	dev->stats_fs_src = stats_fs_source_create(0, dev->name);
+	stats_fs_source_add_subordinate(netdev_root, dev->stats_fs_src);
+	stats_fs_source_add_values(dev->stats_fs_src, stats_fs_netdev_entries,
+				   dev, 0);
+
 out:
 	return ret;
 
@@ -10500,6 +10563,9 @@ static int __init net_dev_init(void)
 	if (netdev_kobject_init())
 		goto out;
 
+	netdev_root = stats_fs_source_create(0, "net");
+	stats_fs_source_register(netdev_root);
+
 	INIT_LIST_HEAD(&ptype_all);
 	for (i = 0; i < PTYPE_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&ptype_base[i]);
-- 
2.25.4

