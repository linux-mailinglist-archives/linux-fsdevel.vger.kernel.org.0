Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032012019E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 20:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbgFSSAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 14:00:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:32618 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732997AbgFSSAn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:00:43 -0400
IronPort-SDR: rYqr94gPMFjVsqpA6GDlcqSsjACWk1Jv8kaM5c6ji5fR9OEQRlN049T1SH1oAP1DkENOxosELy
 DT8P4kRC8BrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="123312556"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="123312556"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 11:00:43 -0700
IronPort-SDR: UH7WCQr/m4YfL9/5O8NecLYlWg90MJvgDxgVqeN0w6oAMZNDzIbReM1CE4eFXzjX1rA1aw3Ool
 HtjourtbcCog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="274361863"
Received: from arch-p28.jf.intel.com ([10.166.187.31])
  by orsmga003.jf.intel.com with ESMTP; 19 Jun 2020 11:00:43 -0700
From:   Sridhar Samudrala <sridhar.samudrala@intel.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        netdev@kernel.org
Subject: [PATCH] fs/epoll: Enable non-blocking busypoll with epoll timeout of 0
Date:   Fri, 19 Jun 2020 11:00:42 -0700
Message-Id: <1592589642-35380-1-git-send-email-sridhar.samudrala@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch triggers non-blocking busy poll when busy_poll is enabled and
epoll is called with a timeout of 0 and is associated with a napi_id.
This enables an app thread to go through napi poll routine once by calling
epoll with a 0 timeout.

poll/select with a 0 timeout behave in a similar manner.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 fs/eventpoll.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 12eebcdea9c8..5f55078d6381 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1847,6 +1847,19 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		eavail = ep_events_available(ep);
 		write_unlock_irq(&ep->lock);
 
+		/*
+		 * Trigger non-blocking busy poll if timeout is 0 and there are
+		 * no events available. Passing timed_out(1) to ep_busy_loop
+		 * will make sure that busy polling is triggered only once and
+		 * only if sysctl.net.core.busy_poll is set to non-zero value.
+		 */
+		if (!eavail) {
+			ep_busy_loop(ep, timed_out);
+			write_lock_irq(&ep->lock);
+			eavail = ep_events_available(ep);
+			write_unlock_irq(&ep->lock);
+		}
+
 		goto send_events;
 	}
 
-- 
2.25.4

