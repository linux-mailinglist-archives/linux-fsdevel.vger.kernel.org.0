Return-Path: <linux-fsdevel+bounces-36536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB19E5780
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 14:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35E01622A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF24218AC5;
	Thu,  5 Dec 2024 13:45:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213C1D52B;
	Thu,  5 Dec 2024 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406324; cv=none; b=Kzq7xzfO1rYv3Y65P7bLrPEXFE9xGfYW8wVlknVOUNY99+vOWLmvGlqLjAhN5A8nfhjGYZ+NO0FnwY9h6V/YEx3V397B+Cob/dQsIsLmsqRMAMX9yux9MYacu1n/GX30gxyw2jAmnL3YAWwpn0nLef5HyuR6GLuv3M/QSp781Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406324; c=relaxed/simple;
	bh=HJmkkxRyUful3cxYBbxXfhhekFdA0s2rCgRiOghD7/s=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=HSr2jmdbGumC14o7GZrInC9IrdqGfR+WUuWov9RxDgGoGaVGUAFFkPokHG6CrqeckEjLLNCLWL/fx2VKi3xc12Kq2dtKHTwGQZI4wBuhZP4rn6QJwn07p1aXohDxeuonrpK7ES8AW6541yGVyqNDZK7jqEWXS2/nnu+6LRyu598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4B5DjCsW059676;
	Thu, 5 Dec 2024 22:45:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4B5DjCF0059672
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 5 Dec 2024 22:45:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
Date: Thu, 5 Dec 2024 22:45:11 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH (REPOST)] hfs: don't use BUG() when we can continue
Content-Language: en-US
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
X-Forwarded-Message-Id: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean

syzkaller can mount crafted filesystem images.
Don't crash the kernel when we can continue.

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/hfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a81ce7a740b9..794d710c3ae0 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -81,7 +81,7 @@ static bool hfs_release_folio(struct folio *folio, gfp_t mask)
 		tree = HFS_SB(sb)->cat_tree;
 		break;
 	default:
-		BUG();
+		pr_warn("unexpected inode %lu at %s()\n", inode->i_ino, __func__);
 		return false;
 	}
 
@@ -305,7 +305,7 @@ static int hfs_test_inode(struct inode *inode, void *data)
 	case HFS_CDR_FIL:
 		return inode->i_ino == be32_to_cpu(rec->file.FlNum);
 	default:
-		BUG();
+		pr_warn("unexpected type %u at %s()\n", rec->type, __func__);
 		return 1;
 	}
 }
@@ -441,7 +441,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
 			return 0;
 		default:
-			BUG();
+			pr_warn("unexpected inode %lu at %s()\n", inode->i_ino, __func__);
 			return -EIO;
 		}
 	}
-- 
2.47.0


