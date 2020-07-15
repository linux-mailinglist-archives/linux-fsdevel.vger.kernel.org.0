Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E26220CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 14:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgGOM3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 08:29:24 -0400
Received: from [195.135.220.15] ([195.135.220.15]:42272 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgGOM3Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:29:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C2BCAC83;
        Wed, 15 Jul 2020 12:29:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 329081E12C9; Wed, 15 Jul 2020 14:29:23 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] fanotify: Avoid softlockups when reading many events
Date:   Wed, 15 Jul 2020 14:29:21 +0200
Message-Id: <20200715122921.5995-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When user provides large buffer for events and there are lots of events
available, we can try to copy them all to userspace without scheduling
which can softlockup the kernel (furthermore exacerbated by the
contention on notification_lock). Add a scheduling point after copying
each event.

Note that usually the real underlying problem is the cost of fanotify
event merging and the resulting contention on notification_lock but this
is a cheap way to somewhat reduce the problem until we can properly
address that.

Reported-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fanotify/fanotify_user.c | 5 +++++
 1 file changed, 5 insertions(+)

This is a quick mending we can do immediately and is probably a good idea
nevertheless... I'll queue it up if Amir agrees.

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 63b5dffdca9e..d7f63aeca992 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -412,6 +412,11 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 
 	add_wait_queue(&group->notification_waitq, &wait);
 	while (1) {
+		/*
+		 * User can supply arbitrarily large buffer. Avoid softlockups
+		 * in case there are lots of available events.
+		 */
+		cond_resched();
 		event = get_one_event(group, count);
 		if (IS_ERR(event)) {
 			ret = PTR_ERR(event);
-- 
2.16.4

