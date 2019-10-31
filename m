Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56284EADA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 11:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfJaKj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 06:39:29 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:39044 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbfJaKj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:39:29 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 767022E0DC6;
        Thu, 31 Oct 2019 13:39:26 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 55UrcCtsWr-dPiqKoIV;
        Thu, 31 Oct 2019 13:39:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572518366; bh=g3jMoOgCIV+oJdbBwMXSmMefvpQfsP/udePjE7IgkA0=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=kDteKn5X2Jv9cxfWOVFnCYgvL8M2nBvClu1WnYrbyCxh7exoJKQla+hEdUVbPGJ5M
         b8rJ57LHsL4v18r0+kw7G2gWo4setPYN36f9YGWFrE5QyDQYXMg/gSUbihFLkVLtWx
         FT4A9SZxBKBE0NaSQvbmi5C9WEgF0kYhuKsbIGjM=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id ab6iIZdbUM-dPVKTtPu;
        Thu, 31 Oct 2019 13:39:25 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@openvz.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [PATCH 1/2] fs/quota: fix livelock in dquot_writeback_dquots
Date:   Thu, 31 Oct 2019 10:39:19 +0000
Message-Id: <20191031103920.3919-1-dmonakhov@openvz.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

Write only quotas which are dirty at entry.


XFSTEST: https://github.com/dmonakhov/xfstests/commit/b10ad23566a5bf75832a6f500e1236084083cddc

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 fs/quota/dquot.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 26812a6..b492b9e 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -622,7 +622,7 @@ EXPORT_SYMBOL(dquot_scan_active);
 /* Write all dquot structures to quota files */
 int dquot_writeback_dquots(struct super_block *sb, int type)
 {
-	struct list_head *dirty;
+	struct list_head dirty;
 	struct dquot *dquot;
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int cnt;
@@ -636,9 +636,10 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 		if (!sb_has_quota_active(sb, cnt))
 			continue;
 		spin_lock(&dq_list_lock);
-		dirty = &dqopt->info[cnt].dqi_dirty_list;
-		while (!list_empty(dirty)) {
-			dquot = list_first_entry(dirty, struct dquot,
+		/* Move list away to avoid livelock. */
+		list_replace_init(&dqopt->info[cnt].dqi_dirty_list, &dirty);
+		while (!list_empty(&dirty)) {
+			dquot = list_first_entry(&dirty, struct dquot,
 						 dq_dirty);
 
 			WARN_ON(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags));
-- 
2.7.4

