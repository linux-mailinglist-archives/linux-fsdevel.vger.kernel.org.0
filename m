Return-Path: <linux-fsdevel+bounces-2649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34847E73BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642BB2813BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3638DE9;
	Thu,  9 Nov 2023 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Bi3yt5dg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4B838DF5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:38:24 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84156420F;
	Thu,  9 Nov 2023 13:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=M/fWRyp8GxWkUswIUSN/tlr3Lm4Oy3tnZdgRLeTz0Zc=;
	t=1699565903; x=1700775503; b=Bi3yt5dg4Lb471Hyb3UC9fCaGIF059ok5lmHYgDUiQCP4tS
	B7PqVlm7nLjPMQrRa5kX6qtLWQlu+Fiy7qv16CKFy8rSVFgk0TwQRLBdA6O8THOPCG12ylqgbyoVv
	yGXnmFAfWGYteseUWI5pD3LaaHv1X/OI9DfjqphV7jaQMBWPjIyIEdl6UXr/JEHyxKWgyjPvN5sVu
	ex69pjRF5TYLHn1aB8VgP87z68IC/WE2Q+NTFPZJ0nsZU79ZJQZQkYj8QWnWP+Jml/07EQcQqEgEK
	pPDwN03WyFZFOO475AUV9IWMRW8WgsdmUlZX/TeRU3x8cQfk5iwVVbMW2TJqgFJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1CjE-00000001znF-3mWA;
	Thu, 09 Nov 2023 22:38:21 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolai Stange <nicstange@gmail.com>,
	Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 5/6] wifi: mac80211: use wiphy locked debugfs helpers for agg_status
Date: Thu,  9 Nov 2023 22:22:57 +0100
Message-ID: <20231109222251.186dcaf8bdcc.Id4251db174cdd42519a5ef19cbb08d7ed8f65397@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109212251.213873-7-johannes@sipsolutions.net>
References: <20231109212251.213873-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The read is currently with RCU and the write can deadlock,
convert both for the sake of illustration.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs_sta.c | 74 +++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 06e3613bf46b..5bf507ebb096 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -312,23 +312,14 @@ static ssize_t sta_aql_write(struct file *file, const char __user *userbuf,
 STA_OPS_RW(aql);
 
 
-static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
-					size_t count, loff_t *ppos)
+static ssize_t sta_agg_status_do_read(struct wiphy *wiphy, struct file *file,
+				      char *buf, size_t bufsz, void *data)
 {
-	char *buf, *p;
-	ssize_t bufsz = 71 + IEEE80211_NUM_TIDS * 40;
+	struct sta_info *sta = data;
+	char *p = buf;
 	int i;
-	struct sta_info *sta = file->private_data;
 	struct tid_ampdu_rx *tid_rx;
 	struct tid_ampdu_tx *tid_tx;
-	ssize_t ret;
-
-	buf = kzalloc(bufsz, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	p = buf;
-
-	rcu_read_lock();
 
 	p += scnprintf(p, bufsz + buf - p, "next dialog_token: %#02x\n",
 			sta->ampdu_mlme.dialog_token_allocator + 1);
@@ -338,8 +329,8 @@ static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
 		bool tid_rx_valid;
 
-		tid_rx = rcu_dereference(sta->ampdu_mlme.tid_rx[i]);
-		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[i]);
+		tid_rx = wiphy_dereference(wiphy, sta->ampdu_mlme.tid_rx[i]);
+		tid_tx = wiphy_dereference(wiphy, sta->ampdu_mlme.tid_tx[i]);
 		tid_rx_valid = test_bit(i, sta->ampdu_mlme.agg_session_valid);
 
 		p += scnprintf(p, bufsz + buf - p, "%02d", i);
@@ -358,31 +349,39 @@ static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
 				tid_tx ? skb_queue_len(&tid_tx->pending) : 0);
 		p += scnprintf(p, bufsz + buf - p, "\n");
 	}
-	rcu_read_unlock();
 
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	return p - buf;
+}
+
+static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
+				   size_t count, loff_t *ppos)
+{
+	struct sta_info *sta = file->private_data;
+	struct wiphy *wiphy = sta->local->hw.wiphy;
+	size_t bufsz = 71 + IEEE80211_NUM_TIDS * 40;
+	char *buf = kmalloc(bufsz, GFP_KERNEL);
+	ssize_t ret;
+
+	if (!buf)
+		return -ENOMEM;
+
+	ret = wiphy_locked_debugfs_read(wiphy, file, buf, bufsz,
+					userbuf, count, ppos,
+					sta_agg_status_do_read, sta);
 	kfree(buf);
+
 	return ret;
 }
 
-static ssize_t sta_agg_status_write(struct file *file, const char __user *userbuf,
-				    size_t count, loff_t *ppos)
+static ssize_t sta_agg_status_do_write(struct wiphy *wiphy, struct file *file,
+				       char *buf, size_t count, void *data)
 {
-	char _buf[25] = {}, *buf = _buf;
-	struct sta_info *sta = file->private_data;
+	struct sta_info *sta = data;
 	bool start, tx;
 	unsigned long tid;
-	char *pos;
+	char *pos = buf;
 	int ret, timeout = 5000;
 
-	if (count > sizeof(_buf))
-		return -EINVAL;
-
-	if (copy_from_user(buf, userbuf, count))
-		return -EFAULT;
-
-	buf[sizeof(_buf) - 1] = '\0';
-	pos = buf;
 	buf = strsep(&pos, " ");
 	if (!buf)
 		return -EINVAL;
@@ -420,7 +419,6 @@ static ssize_t sta_agg_status_write(struct file *file, const char __user *userbu
 	if (ret || tid >= IEEE80211_NUM_TIDS)
 		return -EINVAL;
 
-	wiphy_lock(sta->local->hw.wiphy);
 	if (tx) {
 		if (start)
 			ret = ieee80211_start_tx_ba_session(&sta->sta, tid,
@@ -432,10 +430,22 @@ static ssize_t sta_agg_status_write(struct file *file, const char __user *userbu
 					       3, true);
 		ret = 0;
 	}
-	wiphy_unlock(sta->local->hw.wiphy);
 
 	return ret ?: count;
 }
+
+static ssize_t sta_agg_status_write(struct file *file,
+				    const char __user *userbuf,
+				    size_t count, loff_t *ppos)
+{
+	struct sta_info *sta = file->private_data;
+	struct wiphy *wiphy = sta->local->hw.wiphy;
+	char _buf[26];
+
+	return wiphy_locked_debugfs_write(wiphy, file, _buf, sizeof(_buf),
+					  userbuf, count,
+					  sta_agg_status_do_write, sta);
+}
 STA_OPS_RW(agg_status);
 
 /* link sta attributes */
-- 
2.41.0


