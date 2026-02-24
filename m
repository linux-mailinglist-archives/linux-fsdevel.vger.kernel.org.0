Return-Path: <linux-fsdevel+bounces-78234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNf/CjFznWmAQAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:45:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC3F184DF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0D3830F9E47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2246336D507;
	Tue, 24 Feb 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="Ehr8TQsq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0236D51A;
	Tue, 24 Feb 2026 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926264; cv=none; b=CLdaq3ovcBrmb1nVFiFXe/SGvRrl0oGtzaR/FK2sdM8lWMDoZWwnXmdQuNAb5vQOo+49Mq/CYs6w2uPyZF2cAH9VGnIj7caui7JeQGY36GOax65TV8FJQN+6tDEIaO9ISqoTrDdMTN2XacFgaGmeKTVOXJaqkRp26UuCecIF0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926264; c=relaxed/simple;
	bh=OmPphWIswswzkb8ygwgtW6VZUdzTMmZz7ARHmGWQNwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LdgABJmt56dZUo2YLt3TeHgKCrcP2CaEMovp4OD+kukXQThsbR+V/2whD1+8rcVtkRVVNnJiBHRg+iPzC3CA1TEwocVibguK5xUyCKvVIqAdCMUfIFQnNiPrLWdmaUu23SMaJjU+IFPL+SowehfJMQ/ZfuNq0y5UjrWfJbvq7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=Ehr8TQsq; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
From: Chia-Ming Chang <chiamingc@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1771925697; bh=OmPphWIswswzkb8ygwgtW6VZUdzTMmZz7ARHmGWQNwI=;
	h=From:To:Cc:Subject:Date;
	b=Ehr8TQsqdHuX5XfMp3dWLA2nvxJCM8zgTT2LbIkd3ou4gcEqqWDIrBHxWNryXiE1M
	 J0NLsXEDyzgfIcUQvqvpnEhjJh6n9AhqswFgFHbbbWB8KBUBlVZkH7pNPtpN1PnYTc
	 0Tvro0YBq3fZf/wFBkxyhlpIE+5WpMPSUCvvwcDE=
To: jack@suse.cz
Cc: amir73il@gmail.com,
	serge@hallyn.com,
	ebiederm@xmission.com,
	n.borisov.lkml@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chia-Ming Chang <chiamingc@synology.com>,
	stable@vger.kernel.org,
	robbieko <robbieko@synology.com>
Subject: [PATCH] inotify: fix watch count leak when fsnotify_add_inode_mark_locked() fails
Date: Tue, 24 Feb 2026 17:34:42 +0800
Message-Id: <20260224093442.3076294-1-chiamingc@synology.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,hallyn.com,xmission.com,vger.kernel.org,synology.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78234-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chiamingc@synology.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synology.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAC3F184DF6
X-Rspamd-Action: no action

When fsnotify_add_inode_mark_locked() fails in inotify_new_watch(),
the error path calls inotify_remove_from_idr() but does not call
dec_inotify_watches() to undo the preceding inc_inotify_watches().
This leaks a watch count, and repeated failures can exhaust the
max_user_watches limit with -ENOSPC even when no watches are active.

Prior to commit 1cce1eea0aff ("inotify: Convert to using per-namespace
limits"), the watch count was incremented after fsnotify_add_mark_locked()
succeeded, so this path was not affected. The conversion moved
inc_inotify_watches() before the mark insertion without adding the
corresponding rollback.

Add the missing dec_inotify_watches() call in the error path.

Fixes: 1cce1eea0aff ("inotify: Convert to using per-namespace limits")
Cc: stable@vger.kernel.org
Signed-off-by: Chia-Ming Chang <chiamingc@synology.com>
Signed-off-by: robbieko <robbieko@synology.com>
---
 fs/notify/inotify/inotify_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index b372fb2c56bd..0d813c52ff9c 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -621,6 +621,7 @@ static int inotify_new_watch(struct fsnotify_group *group,
 	if (ret) {
 		/* we failed to get on the inode, get off the idr */
 		inotify_remove_from_idr(group, tmp_i_mark);
+		dec_inotify_watches(group->inotify_data.ucounts);
 		goto out_err;
 	}
 
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

