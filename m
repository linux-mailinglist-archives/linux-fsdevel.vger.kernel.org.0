Return-Path: <linux-fsdevel+bounces-56293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B14BB155E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF5918A7F05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 23:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB94C285CB7;
	Tue, 29 Jul 2025 23:22:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B42AE66;
	Tue, 29 Jul 2025 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831324; cv=none; b=ghjlmQbA6l7PGRRxqhHMUiQpBkgQRAtmtVSnkZzElI3uMRMNcwy8isKP2BaIMEqMTJdi03B5wuB1SNJddy4vH0HyRI2vM28tfgX8D4Rtjv41WfQcG+6f5VnCS6+hX3Sekn1ZsSBmSWGz0RjbmFMi+BUDohN2FnHYBKf6FCedvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831324; c=relaxed/simple;
	bh=quVU5GwWsj8WQozXUgeInT+A7+uoXfMFblBIZZ5aHdc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EYOW/RqOEC9ABYgERVnOJ+irgQU8HLuFIKettO0KNe99WWBTaZQysGKAZQ3nb0i8pffQfUkEcF7zAygHykjff+ZQ2FLGQuuC3DWA9TQ+3aNJKqaZtXPzsTVeclQC7+jSe4/zF20FJvN0Rx8tb+w05/KanNveKqxPTI3hEHrBfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56TNL8Aq084433;
	Wed, 30 Jul 2025 08:21:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56TNL8SQ084430
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 30 Jul 2025 08:21:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <427fcb57-8424-4e52-9f21-7041b2c4ae5b@I-love.SAKURA.ne.jp>
Date: Wed, 30 Jul 2025 08:21:06 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4] hfs: update sanity check of the root record
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Leo Stone
 <leocstone@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
 <aH-enGSS7zWq0jFf@casper.infradead.org>
 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
 <650d29da-4f3a-4cfe-b633-ea3b1f27de96@I-love.SAKURA.ne.jp>
 <6db77f5cb0a35de69a5b6b26719e4ffb3fdac8c5.camel@ibm.com>
 <1779f2ad-77da-40e3-9ee0-ef6c4cd468fa@I-love.SAKURA.ne.jp>
 <12de16685af71b513f8027a8bfd14bc0322eb043.camel@ibm.com>
 <0b9799d4-b938-4843-a863-8e2795d33eca@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <0b9799d4-b938-4843-a863-8e2795d33eca@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
operation when the inode number of the record retrieved as a result of
hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for
commit b905bafdea21 ("hfs: Sanity check the root record") checked
the record size and the record type but did not check the inode number.

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/hfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index fe09c2093a93..d231989b4e23 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -354,7 +354,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
-		if (rec.type != HFS_CDR_DIR)
+		if (rec.type != HFS_CDR_DIR || rec.dir.DirID != cpu_to_be32(HFS_ROOT_CNID))
 			res = -EIO;
 	}
 	if (res)
-- 
2.50.1



