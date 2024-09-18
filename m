Return-Path: <linux-fsdevel+bounces-29661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2970997BDD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C41C1C228F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B615C18C938;
	Wed, 18 Sep 2024 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1r1mFyY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5844B18B472;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668769; cv=none; b=W3n0SukYMmrbGxj5ENFLjbDDa59VR9UuqclTuV9yTWXTwes47V2QjluJ+sb9n1UTaKw3XDicEKODQHJtTeu5BpY3CY+ozoOFaHEbra+LHimZ+jBWsCy/sewaRTJPMhfNZ8bPaRNMTJOr1aio95vA4BSLMoWvEVNcEHSuxno5DWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668769; c=relaxed/simple;
	bh=PVnzNCLQ68jsbupEGVL68Tb95X/C81NbWR59p/QEj7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2aJyGkp52uqKrfuOGLQz7gTWHBIrNmlllEpvNxR3Afk8HhrOpsjVEF5oQ9sQiq+oGfZvlfRt001aQQV4OntZu0F4K5XXY89yUXf4e4OUYbh1K5ESv2kXv5OWdxAgvT4LncFQEyXkvhNtJxsxcXbMiSk9GuXSgn1oMyz6udi8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1r1mFyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B537C4CECF;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668769;
	bh=PVnzNCLQ68jsbupEGVL68Tb95X/C81NbWR59p/QEj7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S1r1mFyYRot4UMStkYiFI9qjuW3QAiRyYl6MVPMWDgH+I7N/wkbupaqMz8oaEOq+0
	 48xMdoKwHqNMYaIEGYW5/pKdrbH9Mt7qtjyChKlX5m/3Y3Eg0mz+UpddlEWpRpWWOm
	 KV2agL5QfVuCf398LBWUGRd21I9xGEq5YLS4d3KAJp5MTuCrL0tpyKjyc1PK5OEmcQ
	 EaWFw9H3393UDBfq1B67XRe4xiOs6iNjh/drMe/NNR9h7xAwYsSemiekdSAP2sQBsT
	 1CrQsDmnYp2Ad0UYwYLf/5xqjKwrSb0MdZhIXZ8FpghnUqywNS7Su7z2ktofg4vVIh
	 JLwCDWyOT9iZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04525CCD1B9;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:12:22 +0800
Subject: [PATCH v5.4-v4.19 3/6] vfs: mostly undo glibc turning 'fstat()'
 into 'fstatat(AT_EMPTY_PATH)'
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-5-4-y-v1-3-8a771c9bbe5f@gmail.com>
References: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mateusz Guzik <mjguzik@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2833;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=Ob5pdDkBmzfI4CRiHVry9bYgBpFtcO+hUY8vOastWdQ=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t/dkhe4gnLosFQYQGgAjw7HgtvKBijoVz7Qh
 jYM5QOhLIaJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurf3QAKCRCwMePKe/7Z
 blK0D/95LpkFK/leLf1q4EmJiRPaQZZeIx0+uHa7VtIXcjbwDjN6DHRFLlJcQ8lnc1HaIf0NpZx
 Ur7emkfeutwuMrIgf3yDnvN0vhl5+13CbvJZPUnAnDJqqscoqj9InpIoPdbaOQNjiFIQ9fItajH
 Jj0WcfHkoJWp8X2C/yy7maTuQ2VeRmHaXtzVAfKYwV1ckdl6UkuzNg4r4d7C+uCbvXlDAEghL3R
 PxAHoGouQsUQvaOT4Ow03TUUrXH+thTXHLItU76UyhwWXSVna0cgimSbYhIUTgCtAaAA9e0Wdu3
 s9dimC31fy9B3wsALIeOd7stElIwCtH51ZIaFZsD5N4OA2dPKi3LTv9gzqN0gKwhQO/IZFu43Em
 9Y/R3tJJZabuM0UbXLf5MgzB1on76HmDtJEDkCNXGh7Ig7U191NDo4rr4i86tNjqT4oeV+L/XpS
 MVQExf+jfuFT6oSQZ9qtolVYfF4QAiAJZt9WQRDsGDzXFQcrhxERUIKHgxnBchPx/6qUwHzjdFn
 Wy/y3gISELKQco8Qzqz2wCj9gzdevgDKkr0FjIHe8xilebFoZyEjiGSb9YccLCK0QMHdfFyfeJl
 +AUiT9jiBhZL6Dtk4JiqkkF/2yiq2tDNMTBCPZe5V/X1AUiKX2N1oA2qTOqqJl2hQ+4V137EAEk
 4ZxCqcwWoPQIzJA==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 9013c51 upstream.

Mateusz reports that glibc turns 'fstat()' calls into 'fstatat()', and
that seems to have been going on for quite a long time due to glibc
having tried to simplify its stat logic into just one point.

This turns out to cause completely unnecessary overhead, where we then
go off and allocate the kernel side pathname, and actually look up the
empty path.  Sure, our path lookup is quite optimized, but it still
causes a fair bit of allocation overhead and a couple of completely
unnecessary rounds of lockref accesses etc.

This is all hopefully getting fixed in user space, and there is a patch
floating around for just having glibc use the native fstat() system
call.  But even with the current situation we can at least improve on
things by catching the situation and short-circuiting it.

Note that this is still measurably slower than just a plain 'fstat()',
since just checking that the filename is actually empty is somewhat
expensive due to inevitable user space access overhead from the kernel
(ie verifying pointers, and SMAP on x86).  But it's still quite a bit
faster than actually looking up the path for real.

To quote numers from Mateusz:
 "Sapphire Rapids, will-it-scale, ops/s

  stock fstat	5088199
  patched fstat	7625244	(+49%)
  real fstat	8540383	(+67% / +12%)"

where that 'stock fstat' is the glibc translation of fstat into
fstatat() with an empty path, the 'patched fstat' is with this short
circuiting of the path lookup, and the 'real fstat' is the actual native
fstat() system call with none of this overhead.

Link: https://lore.kernel.org/lkml/20230903204858.lv7i3kqvw6eamhgz@f/
Reported-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Cc: <stable@vger.kernel.org> # 4.19.x-5.4.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/stat.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index b09a0e2a6681..526fa0801cad 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -201,6 +201,22 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 int vfs_fstatat(int dfd, const char __user *filename,
 			      struct kstat *stat, int flags)
 {
+	/*
+	 * Work around glibc turning fstat() into fstatat(AT_EMPTY_PATH)
+	 *
+	 * If AT_EMPTY_PATH is set, we expect the common case to be that
+	 * empty path, and avoid doing all the extra pathname work.
+	 */
+	if (dfd >= 0 && flags == AT_EMPTY_PATH) {
+		char c;
+
+		ret = get_user(c, filename);
+		if (unlikely(ret))
+			return ret;
+
+		if (likely(!c))
+			return vfs_fstat(dfd, stat);
+	}
 	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
 			 stat, STATX_BASIC_STATS);
 }

-- 
2.43.0



