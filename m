Return-Path: <linux-fsdevel+bounces-56098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD74B1311F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 20:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECA0173D1D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2F8223316;
	Sun, 27 Jul 2025 18:17:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E1C26281;
	Sun, 27 Jul 2025 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753640235; cv=none; b=hH35nhbYdTV6TZecHpXPKupEayUHcBshWoG6/G4elb0VTxTDXC5IIggBI9Cy9PrNJ8ZyN/tUWC54m6hiA4n8wI04o3BbZ0TGuLD9iICRF97EqpTP3SCrBzdrj0t3v+6b1xPUKX+CdoM4HmFRf0PxsNxJ15NM/QEQiiXPSZxX8cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753640235; c=relaxed/simple;
	bh=VPCp179jNpPR33SDAmoGFeWAfSuZf2dhamBXawa8ptc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yl6DM7zLTJEU5g6WI3AjmgqWw08XKJnj76i6kOH9Ww84lw0uJHdoq54i6MiqX6lpb7q96sY6SLy/2yidpvyNUg5bshJVz3p2jHYPbGEUpJnBNoAuqujNRlpGyE747uO06iyBjk441e28pYCp9LO1eOJXLtwXqx/TBQ11zxCMs4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:d12b:14e4:b2a7:291a])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id C78824180E;
	Sun, 27 Jul 2025 18:17:09 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:d12b:14e4:b2a7:291a) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: syztest
Date: Sun, 27 Jul 2025 19:17:02 +0100
Message-ID: <20250727181702.32633-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000707b50060f85bb0e@google.com>
References: <000000000000707b50060f85bb0e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175364023034.21154.2201284229669043907@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -124,6 +124,12 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len)
 		data_rec_off += 2;
 	} while (data_rec_off < idx_rec_off);
 
+	if (end_off < data_off) {
+		hfs_dbg(BNODE_MOD, "corrupted node: end_off %u < data_off %u\n", end_off, data_off);
+		if (new_node)
+			hfs_bnode_put(new_node);
+		return -EIO;
+	}
 	/* move data away */
 	hfs_bnode_move(node, data_off + size, data_off,
 		       end_off - data_off);
-- 
2.43.0


