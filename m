Return-Path: <linux-fsdevel+bounces-55263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FDDB090A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 17:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BC15875C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983E32F9483;
	Thu, 17 Jul 2025 15:33:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97952F85DE;
	Thu, 17 Jul 2025 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766382; cv=none; b=cZ0TCmwLDXMZQupbkJCVfwsHhm2c/qUJ+FADY9nXohvXOUWRMCuqOEuBkJNMEF9AudXzeNrPIEiiceByvotU8wu+CfNFeYRGzyZgcJ1H87sbATJC0gKRmO7Gn7nvjT06FHCdywArnW7ockD2PaZwpL6fn97A2RLoec/qHEtcuo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766382; c=relaxed/simple;
	bh=d8avnly59DzE9xTlJc28/o49+M5mXJgB8dlDd57ZxBE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gKLI2LOT1EpD7iOjKgKhTaHw5eKkemeGpYXn3GdD7383xW9vPC9dSS0gFxwUnjA9hRz1EvRoNKT49yxbTzj8YSl16FpKs9yOLGE04U/47AnuREMK6lKipjK+QkoB8aeI8Ej8i7oq63nRvoPmEOouhem84CSe7qyjMQo6ISpdusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56HFWkhK050739;
	Fri, 18 Jul 2025 00:32:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56HFWk1l050734
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 18 Jul 2025 00:32:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
Date: Fri, 18 Jul 2025 00:32:46 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
 <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
 <Z1GxzKmR-oA3Fmmv@casper.infradead.org>
 <b992789a-84f5-4f57-88f6-76efedd7d00e@I-love.SAKURA.ne.jp>
 <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
 <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
 <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

Since syzkaller can mount crafted filesystem images with inode->i_ino == 0
(which is not listed as "Some special File ID numbers" in fs/hfs/hfs.h ),
replace BUG() with pr_err().

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/hfs/inode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a81ce7a740b9..9bbf2883bb8f 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -81,7 +81,8 @@ static bool hfs_release_folio(struct folio *folio, gfp_t mask)
 		tree = HFS_SB(sb)->cat_tree;
 		break;
 	default:
-		BUG();
+		pr_err("detected unknown inode %lu, running fsck.hfs is recommended.\n",
+		       inode->i_ino);
 		return false;
 	}
 
@@ -305,7 +306,7 @@ static int hfs_test_inode(struct inode *inode, void *data)
 	case HFS_CDR_FIL:
 		return inode->i_ino == be32_to_cpu(rec->file.FlNum);
 	default:
-		BUG();
+		pr_err("detected unknown type %u, running fsck.hfs is recommended.\n", rec->type);
 		return 1;
 	}
 }
@@ -441,7 +442,8 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
 			return 0;
 		default:
-			BUG();
+			pr_err("detected unknown inode %lu, running fsck.hfs is recommended.\n",
+			       inode->i_ino);
 			return -EIO;
 		}
 	}
-- 
2.50.1



