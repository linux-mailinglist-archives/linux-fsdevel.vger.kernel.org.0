Return-Path: <linux-fsdevel+bounces-76-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419D27C57AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B55C2826EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3062031C;
	Wed, 11 Oct 2023 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eyKIUODB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="frINkbYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2896F1EA93
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 15:02:57 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA196A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 08:02:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2BABA1FE05;
	Wed, 11 Oct 2023 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697036573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fhw6kQPzB9h0p5+gRMGAklQ+jFCAltTtEIT1nsXiUnM=;
	b=eyKIUODBu/RkxjxtJovC2x4MbCPVZCFUmENMUI+0LyGpEIJRYhWaormCPAPJx7pDhVvVoh
	0T0TRPR8I2HaULQ1UU6VQPIia/I/XilQ16Q0ARQ+Vf0JBhR64MI7laWypbsGm9lZcXh5Mb
	E7all/glSHngrSm8XjB+0Ba5azJLYHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697036573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fhw6kQPzB9h0p5+gRMGAklQ+jFCAltTtEIT1nsXiUnM=;
	b=frINkbYxuA+TKn45a/zI9aX6VV18sHJfIzE0pkrGzbQtrbBkKaeUUcxF5VKwcL+bCT+zKY
	kutVshBYMaIQTLCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A64F138EF;
	Wed, 11 Oct 2023 15:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WipmBh25JmVSfwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 11 Oct 2023 15:02:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 99567A061C; Wed, 11 Oct 2023 17:02:52 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] xarray: Fix race in xas_find_chunk()
Date: Wed, 11 Oct 2023 17:02:32 +0200
Message-Id: <20231011150252.32737-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231011144320.29201-1-jack@suse.cz>
References: <20231011144320.29201-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; i=jack@suse.cz; h=from:subject; bh=RjhxKJpTLf50b6cWTvI9YLm8dChFGGQIJKDw0sZFIJk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlJrkH80jApU9HQctTO4kSkXckPC/CE6mfLxzRkotG LwIfI0OJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZSa5BwAKCRCcnaoHP2RA2dfOCA CQMcT2ngmEYEOlPH5BoIejy9mPm6cy0r0Jvzn0HoL1vO5m1LVuUxPJ4ZsXCpGLPKNxc7ArX9/EuktL 3WrFntJJ0UulUxnogRiNwbhAwiDnojTy3Xz96JyyBifdtANSJV8xvRJBMBTcGM53gM13ExJ5M3gCX7 j75Ij7z5uve4a7Aaab0ZekALP1ssFkF0Mjr5o/ZspzR42/ctQObbZ44vmhtqeYz2kZmRi0QA3fM5Kp WxlXMr2S0wxbRZhA4ZiWoCGYutoBZcBOKhgKznzTG5GJ1hFdf1+OR/f89HzWQa1nhYlxt3abf8TMFD e6aQi+Oc7aEn0CKVwYtKn24OwQDm0g
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

xas_find_chunk() can be called only under RCU protection and thus tags
can be changing while it is working. Hence the code:

	unsigned long data = *addr & (~0UL << offset);
	if (data)
		return __ffs(data);

is prone to 'data' being refetched from addr by the compiler and thus
calling __ffs() with 0 argument and undefined results.

Fix the problem by removing XA_CHUNK_SIZE == BITS_PER_LONG special case
completely. find_next_bit() gets this right and there's no performance
difference because it is inline and has the very same special branch for
const-sized bitmaps anyway.

Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
CC: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/xarray.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b1..07700a2c8870 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1718,15 +1718,6 @@ static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
 
 	if (advance)
 		offset++;
-	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
-		if (offset < XA_CHUNK_SIZE) {
-			unsigned long data = *addr & (~0UL << offset);
-			if (data)
-				return __ffs(data);
-		}
-		return XA_CHUNK_SIZE;
-	}
-
 	return find_next_bit(addr, XA_CHUNK_SIZE, offset);
 }
 
-- 
2.35.3


