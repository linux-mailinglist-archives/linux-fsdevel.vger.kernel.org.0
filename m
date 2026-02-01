Return-Path: <linux-fsdevel+bounces-76000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8lLYD6PPfmn2ewIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 04:59:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E956C4E1D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 04:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 041C23012E8B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Feb 2026 03:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69BE2C234C;
	Sun,  1 Feb 2026 03:59:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9BC1A08A3
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Feb 2026 03:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769918364; cv=none; b=he8l2oAJDwQpY97+UHVgaDDhUqOtBGI2/WnA8pAft1JRfRW1ofPK+fBUmeHOv3HYtNfT+jlUbv2WYAmANxa0wiLcE0sARP++EpsrL79j/oZzNRz5UdB7vhuCnkJat3ee7WWHVpg+meeU7+QRwstJO+vdM74r+QsndsCW90PKUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769918364; c=relaxed/simple;
	bh=aegIILmL5ZBAk6vO9u3EpCfz/3Piv8T5f1OPjUJGgj4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=MWrsVs6p6657OfyMZeicARoOVm+tjNcgg5MdXwk9PK8HjdSb30ENJkOK+PVBNj44/IQIfG2OwRq4BwbnQKBpLED+mgV1cbb2UH67BrHqWj+//pgTPBG5zoS4kELzPKEmsTjDi68eDuHQ/THbsSgLmYD1HC2Hw8zoyoQ9B7ihygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6113wsf0012432;
	Sun, 1 Feb 2026 12:58:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6113wsWB012426
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Feb 2026 12:58:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <36addde7-e150-45c5-b86c-fe44a2942906@I-love.SAKURA.ne.jp>
Date: Sun, 1 Feb 2026 12:58:55 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 (repost)] hfsplus: pretend special inodes as regular files
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>
References: <8ce587c5-bc3e-4fc9-b00d-0af3589e2b5a@I-love.SAKURA.ne.jp>
 <86ac2d5c35aa2dc44e16d8d41cf09cebbcae250a.camel@ibm.com>
 <bfa47de0-e55e-419c-9572-2d8a7b3b99f8@I-love.SAKURA.ne.jp>
 <5369106f-97ab-49e6-bc99-517d642b02b8@I-love.SAKURA.ne.jp>
 <443c081b0d0d116827adfc3eed5bc5cba4cf7f30.camel@ibm.com>
 <d0a07b1b-8b73-4002-8e29-e2bd56871262@I-love.SAKURA.ne.jp>
Content-Language: en-US
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
In-Reply-To: <d0a07b1b-8b73-4002-8e29-e2bd56871262@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76000-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E956C4E1D
X-Rspamd-Action: no action

Since commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
requires any inode be one of S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/
S_IFIFO/S_IFSOCK type, use S_IFREG for special inodes.

Reported-by: syzbot <syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com>
Closes:https://syzkaller.appspot.com/bug?extid=f98189ed18c1f5f32e00
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/hfsplus/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index aaffa9e060a0..7f327b777ece 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -53,6 +53,12 @@ static int hfsplus_system_read_inode(struct inode *inode)
 		return -EIO;
 	}
 
+	/*
+	 * Assign a dummy file type, for may_open() requires that
+	 * an inode has a valid file type.
+	 */
+	inode->i_mode = S_IFREG;
+
 	return 0;
 }
 
-- 
2.47.3


