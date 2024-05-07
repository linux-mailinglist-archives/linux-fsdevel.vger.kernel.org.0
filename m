Return-Path: <linux-fsdevel+bounces-18886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B268BDE14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 11:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09AF71F20EC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 09:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67714D71A;
	Tue,  7 May 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gVyt63eS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9876414D451;
	Tue,  7 May 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073885; cv=none; b=UW/Lv/x8m1wxv0exZoIwvOIuOmGPsxjHU6iZFQ0J8y2VngvF1PmXFADR1LRYAwFKuRUpJlJdrrJmhEG8qFMdYdZVhYgnsi3woPlGjrgFfYuXPuChMoDMGyyvc3CvXWFt1ajOjM90TbhUS0zheEYsTRJ80nv5Ijg/MmWrLvFdGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073885; c=relaxed/simple;
	bh=+yW59onyXg0Pbvf487LVUARxqJvPaBeg6/Sc/ikl7Nw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=R2M6+5k+KnPvFJaQB6f34jkmFET74+X2NCarso4ka5t6DWyt+fkIkK9dPL4vn1t0UeIOD/Z8TRRtJl0C/aNcyNTX8wEx6AURLE4tcctjOxzhmsdEaMGK0KUh8k006IEHgZMKzi+bNXf64Oow9uC3DPP3eyHUpgxDZSz1ABHrqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gVyt63eS; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1715073576; bh=yO/k90JymUOXJTCvLXq3LY5H5yoKY6KSmEgQ9wMKlJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gVyt63eSG4URXpc+GaOAIBpWiMDj4in5Tlrb84tjARNEAt0YfDMuD0ZcnQxgb9RYQ
	 iHMJtSdxXJN89EJ58BNxfByWFy5nk+s4yY1bK0UJKbaj5fU9weAGmbrgyeZ8C8PT4C
	 nyokwNbAsBK4WMGYbTQ2kxH9QjcTTKRCsTBvQxlw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 4DCB0648; Tue, 07 May 2024 17:19:28 +0800
X-QQ-mid: xmsmtpt1715073568t102emhnj
Message-ID: <tencent_816D842DE96C309554E8E2ED9ACC6078120A@qq.com>
X-QQ-XMAILINFO: MZChPk4K8ikNlT2Eddi9Ggrs0oV4G9NbiHl6MtG6ekOPsfZopI6QIM/z/aIUSO
	 goslJ60GRySBTLq1ngjWjUItTYKOInN+rKDsQj1lXUOaKrAy2xb3k/g7opZJGfA5tS80axKCTdbM
	 FbJCtj93Em7qowzBXjUSDBZVRSa3oTkCmArSaPyAlcrQuOQbIH7XeVR01ecsiBRpH3kEDLeCTOzf
	 UhoOq3XXWJhFkp+KjGlG4yZz301QSR24RQmOqzRGZkunD2iPByVKS3eQRy1U7mYMGwtHGvk78lp/
	 SVzJdl0iXuJYqknPzgI8EWaz2vCT7z+jHxhtI0ihlzbDXGwnRIoyoGOmVzRQ6tRo7Dg25HcjONW8
	 /O9rFDYzp/48tIsf1aHg9j4oMnpIKWQ7QxT8BCh5vXkgQ4UcNEO6NYH7BoPpobmRgRywEnPJV4WG
	 czoC30voVF2ILfkwGk4nHFmL9rBH9Qt6Iv9uR1lISK3CIsz59VHPTljSiyUo0U0cclc1ysEBUBwO
	 dlgxxB8SeV5s1tXj+/YzB/dvNJjABSOocMzEHSydcUKhfyEZRfsl3JnI2kSmtQTfJR3PjrYYo9xS
	 CARXLrJKczs85wwFpC4Jf2MyEcfe9iuAACRB6XFf7YjhjDhUEHpyUvwB2oOd3n2u1xg7YUoLXVG/
	 l1AgzbIZchyLnMmR8SyQ+YUDTptGk+aOGRN6sxZZvdx48aXJOPjDNGFHp1yrj6zfVUugG3Q/oF6g
	 gTuWBrddmh2FSdGuULKPym9/5/jMjBoDRTi8h1Zf6mNFu7MbQTmGJlUDuQTzcyHt9JMmxX+M51zM
	 y7axxD4RjO7MCzBOSMi28IfBqfRIOVY545KEnozNg0At+S5o9d6ugvfrdLbafcMNDj8vJgYooz10
	 tfVe4iY5WBeO+GxXhjyKTm9SuXUf8GFJgHeEcAt3hE/lhxKTHJMC/IXFPO8TQ5cLvNnNvljJrN
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
Cc: bfoster@redhat.com,
	kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] bcachefs: fix oob in bch2_sb_clean_to_text
Date: Tue,  7 May 2024 17:19:29 +0800
X-OQ-MSGID: <20240507091928.2789219-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000918c290617b914ba@google.com>
References: <000000000000918c290617b914ba@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When got too small clean field, entry will never equal vstruct_end(&clean->field), 
the dead loop resulted in out of bounds access.

Fixes: 12bf93a429c9 ("bcachefs: Add .to_text() methods for all superblock sections")
Fixes: a37ad1a3aba9 ("bcachefs: sb-clean.c")
Reported-and-tested-by: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/bcachefs/sb-clean.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
index 5980ba2563fe..02101687853e 100644
--- a/fs/bcachefs/sb-clean.c
+++ b/fs/bcachefs/sb-clean.c
@@ -285,7 +285,7 @@ static void bch2_sb_clean_to_text(struct printbuf *out, struct bch_sb *sb,
 	prt_newline(out);
 
 	for (entry = clean->start;
-	     entry != vstruct_end(&clean->field);
+	     entry < vstruct_end(&clean->field);
 	     entry = vstruct_next(entry)) {
 		if (entry->type == BCH_JSET_ENTRY_btree_keys &&
 		    !entry->u64s)
-- 
2.43.0


