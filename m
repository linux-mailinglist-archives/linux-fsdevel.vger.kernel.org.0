Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80287EDCE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfKDKwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:52:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:46616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728481AbfKDKwK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:52:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A259B1F9;
        Mon,  4 Nov 2019 10:52:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 35F3B1E4AA0; Mon,  4 Nov 2019 11:52:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH 7/7] quota: Handle quotas without quota inodes in dquot_get_state()
Date:   Mon,  4 Nov 2019 11:51:55 +0100
Message-Id: <20191104105207.1530-7-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104091335.7991-1-jack@suse.cz>
References: <20191104091335.7991-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make dquot_get_state() gracefully handle a situation when there are no
quota files present even though quotas are enabled.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 4c3da4ea31bc..a69a657209a6 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2787,8 +2787,10 @@ int dquot_get_state(struct super_block *sb, struct qc_state *state)
 			tstate->flags |= QCI_LIMITS_ENFORCED;
 		tstate->spc_timelimit = mi->dqi_bgrace;
 		tstate->ino_timelimit = mi->dqi_igrace;
-		tstate->ino = dqopt->files[type]->i_ino;
-		tstate->blocks = dqopt->files[type]->i_blocks;
+		if (dqopt->files[type]) {
+			tstate->ino = dqopt->files[type]->i_ino;
+			tstate->blocks = dqopt->files[type]->i_blocks;
+		}
 		tstate->nextents = 1;	/* We don't know... */
 		spin_unlock(&dq_data_lock);
 	}
-- 
2.16.4

