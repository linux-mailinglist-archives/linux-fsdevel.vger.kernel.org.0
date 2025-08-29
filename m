Return-Path: <linux-fsdevel+bounces-59604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744C1B3B10D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 04:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4760158202A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 02:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A57D21A458;
	Fri, 29 Aug 2025 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZJeP1ySK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716DB42056;
	Fri, 29 Aug 2025 02:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435099; cv=none; b=VUcuji72YS1ra1tgflcAuJUqWbu2fkilwZHfE+lazQh/f2Alie2Bn9s/aeyAf/akFIFkU4NMMdtWhL/e4CGstJQE8RTbz9pPYGz7Fulv3dcRsP+OX+9UxK57mkcTEjvf1O2Va3zcx/A5kTirAm19NKRJ39nKypSetfUjQRs+kds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435099; c=relaxed/simple;
	bh=G9Jh42iBHhSm/oDAYHio+jtrARjUwoavfZEQolKGfAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbXDwinv40uM/5uzEGARnPircQnOtrdQninjzP0yDZVU7a+4SJxV5KFh+yhCuXA6S4+2gya2trpKbBJYGnh2mOG9Q6B1yPOJwfBv0k+YDal3KvzJ6MOXMArK8Y5+U40mgIKo0X70HW3k8krQzB7N3WaFSfkfWYVGnbN8ETDhNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZJeP1ySK; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=JH
	5gu/wbTJ157lbspmx3uKDsuxuH/lv85Oq2Ti6Vn8w=; b=ZJeP1ySKqmB3QwqZx9
	Wz6lI2hsPvE2/GQTg5BG04rvUSBL6d/eoMhcZZPr/jt0CFeOiesSOEg01MfJQHr3
	DSkjTc+1MGn34KgmCZgJp3rfUJY2PRoQ5S9t0T57yNIbH5PsJFCAQpGh0MqjMEAv
	2QOhrkc8afTFcpWkXUM2mivPo=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAHFm5vErFoPaFJFA--.713S2;
	Fri, 29 Aug 2025 10:37:37 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 1/2] mpage: terminate read-ahead on read error
Date: Fri, 29 Aug 2025 10:36:58 +0800
Message-ID: <20250829023659.688649-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHFm5vErFoPaFJFA--.713S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4rCFWUWry3tr18Wr4DArb_yoW8uFWrpr
	W0kryvyrsxJrWfXa97JFZrAr1fC3929a15GFykJ342yrs8WFZIyryftayj9ay2yr18XanY
	vw10vFW3Z3WDZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbkuxUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFA24nWixEMErIAAAs-

From: Chi Zhiling <chizhiling@kylinos.cn>

For exFAT filesystems with 4MB read_ahead_size, removing the storage device
during read operations can delay EIO error reporting by several minutes.
This occurs because the read-ahead implementation in mpage doesn't handle
errors.

Another reason for the delay is that the filesystem requires metadata to
issue file read request. When the storage device is removed, the metadata
buffers are invalidated, causing mpage to repeatedly attempt to fetch
metadata during each get_block call.

The original purpose of this patch is terminate read ahead when we fail
to get metadata, to make the patch more generic, implement it by checking
folio status, instead of checking the return of get_block().

So, if a folio is synchronously unlocked and non-uptodate, should we 
quit the read ahead?

I think it depends on whether the error is permanent or temporary, and 
whether further read ahead might succeed.
A device being unplugged is one reason for returning such a folio, but 
we could return it for many other reasons (e.g., metadata errors).
I think most errors won't be restored in a short time, so we should quit 
read ahead when they occur.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---

diff from v1:
No functional changes. Improved code style as suggested

[v1]: https://lore.kernel.org/all/20250812072225.181798-1-chizhiling@163.com/T/#u

Just submit the final version, it doesn't matter to me if it doesn't merge :)

 fs/mpage.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/mpage.c b/fs/mpage.c
index c5fd821fd30e..e4c11831f234 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -369,6 +369,12 @@ void mpage_readahead(struct readahead_control *rac, get_block_t get_block)
 		args.folio = folio;
 		args.nr_pages = readahead_count(rac);
 		args.bio = do_mpage_readpage(&args);
+		/*
+		 * If read ahead failed synchronously, it may cause by removed
+		 * device, or some filesystem metadata error.
+		 */
+		if (!folio_test_locked(folio) && !folio_test_uptodate(folio))
+			break;
 	}
 	if (args.bio)
 		mpage_bio_submit_read(args.bio);
-- 
2.43.0


