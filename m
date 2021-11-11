Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045EB44D80D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhKKOTV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:19:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:50160 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233551AbhKKOTU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:19:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="319117507"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="319117507"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:16:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="492556049"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 06:16:18 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: [RFC PATCH 09/13] qmp: Include "guest-private" property for memory backends
Date:   Thu, 11 Nov 2021 22:13:48 +0800
Message-Id: <20211111141352.26311-10-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 hw/core/machine-hmp-cmds.c | 3 +++
 hw/core/machine-qmp-cmds.c | 1 +
 qapi/machine.json          | 3 +++
 qapi/qom.json              | 3 +++
 4 files changed, 10 insertions(+)

diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 76b22b00d6..6bd66c25b7 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -112,6 +112,9 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict)
                        m->value->prealloc ? "true" : "false");
         monitor_printf(mon, "  share: %s\n",
                        m->value->share ? "true" : "false");
+        monitor_printf(mon, "  guest private: %s\n",
+                       m->value->guest_private ? "true" : "false");
+
         if (m->value->has_reserve) {
             monitor_printf(mon, "  reserve: %s\n",
                            m->value->reserve ? "true" : "false");
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 216fdfaf3a..2c1c1de73f 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -174,6 +174,7 @@ static int query_memdev(Object *obj, void *opaque)
         m->dump = object_property_get_bool(obj, "dump", &error_abort);
         m->prealloc = object_property_get_bool(obj, "prealloc", &error_abort);
         m->share = object_property_get_bool(obj, "share", &error_abort);
+        m->guest_private = object_property_get_bool(obj, "guest-private", &error_abort);
         m->reserve = object_property_get_bool(obj, "reserve", &err);
         if (err) {
             error_free_or_abort(&err);
diff --git a/qapi/machine.json b/qapi/machine.json
index 157712f006..f568a6a0bf 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -798,6 +798,8 @@
 #
 # @share: whether memory is private to QEMU or shared (since 6.1)
 #
+# @guest-private: whether memory is private to guest (since X.X)
+#
 # @reserve: whether swap space (or huge pages) was reserved if applicable.
 #           This corresponds to the user configuration and not the actual
 #           behavior implemented in the OS to perform the reservation.
@@ -818,6 +820,7 @@
     'dump':       'bool',
     'prealloc':   'bool',
     'share':      'bool',
+    'guest-private':      'bool',
     '*reserve':    'bool',
     'host-nodes': ['uint16'],
     'policy':     'HostMemPolicy' }}
diff --git a/qapi/qom.json b/qapi/qom.json
index a25616bc7a..93af9b106e 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -550,6 +550,8 @@
 # @share: if false, the memory is private to QEMU; if true, it is shared
 #         (default: false)
 #
+# @guest-private: if true, the memory is guest private memory (default: false)
+#
 # @reserve: if true, reserve swap space (or huge pages) if applicable
 #           (default: true) (since 6.1)
 #
@@ -580,6 +582,7 @@
             '*prealloc': 'bool',
             '*prealloc-threads': 'uint32',
             '*share': 'bool',
+            '*guest-private': 'bool',
             '*reserve': 'bool',
             'size': 'size',
             '*x-use-canonical-path-for-ramblock-id': 'bool' } }
-- 
2.17.1

