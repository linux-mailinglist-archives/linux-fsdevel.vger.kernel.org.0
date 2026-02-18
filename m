Return-Path: <linux-fsdevel+bounces-77573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOdcB8K+lWkfUgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 14:29:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9A9156A68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 14:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F164301BF6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8582D73BD;
	Wed, 18 Feb 2026 13:29:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6BF2D0600
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421367; cv=none; b=FUkA/ul26CKTmwbMvemWuTRD2LhuRCdhYXQ/lKx0JDpMYk2nqvBaFJQeSonSGWAlDTiLclAzJ7q8ugsHCdxGSC79q2Zwxa+a0ZF6AtvmLV72pP/gih9Q0D87UZNGFgGAx13wp318qxoofYF4NfmqIOW8KnpSEDbSGQelXC9X5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421367; c=relaxed/simple;
	bh=s/XMvdTBdPd1f+58sWF7/9G1CtnmywoXRvwCmobe9yY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DWLY5XCVMBxFEj4rwofji/e8da+wyls2kiD0EfJbxEC93XYpAatVe9BNhxpCxum6mBdgzDQeH2OOLqXPuX4Y696rgzsqU4l2InC0/EUFVt6v9jv9IdrJpQKJrfC1XJ7UK04CsaYBWtiZoB+jwqS6zMlt6p84hVggJAAJoJr581g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61IDSrbU097444;
	Wed, 18 Feb 2026 22:28:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61IDSrER097441
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 18 Feb 2026 22:28:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ade617e7-553d-477a-95e7-aa1598b6a8c9@I-love.SAKURA.ne.jp>
Date: Wed, 18 Feb 2026 22:28:50 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6] hfs: update sanity check of the root record
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: George Anthony Vernon <contact@gvernon.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
 <20251104014738.131872-3-contact@gvernon.com>
 <df9ed36b-ec8a-45e6-bff2-33a97ad3162c@I-love.SAKURA.ne.jp>
 <a31336352b94595c3b927d7d0ba40e4273052918.camel@ibm.com>
 <aSTuaUFnXzoQeIpv@Bertha>
 <43eb85b9-4112-488b-8ea0-084a5592d03c@I-love.SAKURA.ne.jp>
 <75fd5e4a-65af-48b1-a739-c9eb04bc72c5@I-love.SAKURA.ne.jp>
 <d1e3e3f6-e0c4-4e70-8759-c8aa273cbe37@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <d1e3e3f6-e0c4-4e70-8759-c8aa273cbe37@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77573-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 6E9A9156A68
X-Rspamd-Action: no action

syzbot is reporting that BUG() in hfs_write_inode() fires
when the inode number of the record retrieved as a result of
hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for
commit b905bafdea21 ("hfs: Sanity check the root record") checked
the record size and the record type but did not check the inode number.

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Viacheslav Dubeyko and George Anthony Vernon are trying to fix this problem
in hfs_read_inode(), but no new patch is proposed for three months
( https://lkml.kernel.org/r/20251104014738.131872-3-contact@gvernon.com ) .
This problem is "one of top crashers which is wasting syzbot resources" and
"a very low-hanging fruit which can be trivially avoided". I already tested
this patch using linux-next tree for two weeks, and syzbot did not find
problems. Therefore, while what they would propose might partially overwrap
with my proposal, let's make it possible to utilize syzbot resources for
finding other bugs.

 fs/hfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 97546d6b41f4..c283fc9c5e88 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -361,7 +361,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
-		if (rec.type != HFS_CDR_DIR)
+		if (rec.type != HFS_CDR_DIR || rec.dir.DirID != cpu_to_be32(HFS_ROOT_CNID))
 			res = -EIO;
 	}
 	if (res)
-- 
2.53.0



