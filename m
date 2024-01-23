Return-Path: <linux-fsdevel+bounces-8498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203C4837CC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 02:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E3F285773
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31FD1586FE;
	Tue, 23 Jan 2024 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="khxnD3rI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB6755E5E
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969738; cv=none; b=lFIcDAe0ahOan+BIx52BOCqsNo2+cBnovJR18RJnEVBaUqEInsEpwh0+1qVLkye9dIMJhyxoJHQDLS9o6zs9KFyHQnk2szbFvi0dsQAt69PRFKrQL3Nr8H/xoo2Fm15bRYJIbU6FjD2+0mPo5SMA1rWHrQ3ua4Z3BX5n4Et4MYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969738; c=relaxed/simple;
	bh=hmcJNNt4Q4VRdZF2vWAi73bsrPppPr3nSkhgxxWjJIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLC4vyodZZqawuhI79USLLvLgDfrC8miKoEzkD4saj5z551lGJ1igFY72NDDCm4+M0hrEPueJM7XpFVhxOx7OinUEZRDwI69BAaVbtoRcb66BGnKQGxAzYuv8BnMtlLTptKc9zYn7d4IgYvWxEKHZ7Td4nljsnop6M3vD8Ck42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=khxnD3rI; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59969ec581aso1446917eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969736; x=1706574536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj0wfLNXUIfcFcpxjFCj6rC1hxMeO39B1XcxU2Z6FQQ=;
        b=khxnD3rIeNf8wx6F/TQfF4EEXCdrUsJ4+NeWzVmT1mI1f+lo+i4Dk7LgSq+osT3SEA
         KxgxZpCW92L3GUsZh5Jyaz2aWeyeJRR/3iIi/HwlPFThTDlD1mrZopKzTtjEKgD7QVAh
         g71KNRZ9m20hb9ja0eqTu2qjZUyFjs032ZAKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969736; x=1706574536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lj0wfLNXUIfcFcpxjFCj6rC1hxMeO39B1XcxU2Z6FQQ=;
        b=YV1rXk9zKqkvTOFtJ+wWCHbvs61ckMLw6e52E8U+gvBmxHxirQZX08Jdz9k4nCMXYn
         Tr7aFe2AAEnxRZ8mR7Ax2kGmUFS9fxWYzbgh5t4odJM44lx4z56xVYopo4dUEpsnHF0A
         /4pfh/ejwxWf32lZV6tstn70W/03VEJ5U0vtaf/TI6T383hVuSzHKKUEp3IR2WTu2Rk+
         U5KvCO7PE8AbrpB8gvarzUb2bTrMlz/VxnekGK6gVdGDtUl2lRcPFZlc5PW6FmItQl1F
         UB/xHyPrvSQ6e6FhkiJuLnnp4nIcv2z3AAb214NeQgbp7GphqY7Hdx9mN84Nhuo2sQdn
         18Qg==
X-Gm-Message-State: AOJu0YydYhsRJzrndFSBbpttAdZ6JQlzWNamw+K9brKh7c8YO0xtvRWI
	08D09O8tLCoPMNmy1ItX+OPpcnUUfiTQ/T04Srl9QpML1bB9/xydB3dIVN6VJA==
X-Google-Smtp-Source: AGHT+IGxMyxotbMc1Cchrsm3rFcXhbTFlmI7s6erqf4s8ue04bzsUyGWqJUWv1AxYbLOpHQJNEDrtg==
X-Received: by 2002:a05:6358:9044:b0:171:4aa4:51 with SMTP id f4-20020a056358904400b001714aa40051mr2816637rwf.54.1705969735934;
        Mon, 22 Jan 2024 16:28:55 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sv13-20020a17090b538d00b0028d8fa0171asm10226018pjb.35.2024.01.22.16.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:49 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/82] fs: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:26:54 -0800
Message-Id: <20240123002814.1396804-19-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2642; i=keescook@chromium.org;
 h=from:subject; bh=hmcJNNt4Q4VRdZF2vWAi73bsrPppPr3nSkhgxxWjJIU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgFKlHII6LhFKix+ewETmVbpfBbbfsybJbPD
 x+7qNyR682JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBQAKCRCJcvTf3G3A
 JliJD/sHf6ZqD8B/KWziPKmgyfqtW/R2omfg5NRF8ncdgxikerGRRFZGCvxzR4FW8MnjOxVf1uq
 VTlOujj9IdXmUGBNs6tlOuMkwDYDNxnpu2AhJz2L1ONpzLxW1Wo9TMy8M28suhDxJcE4bIhyVGL
 Fx2SEqEqstNDAG3Rd3j69TdEahfsyFepNOoEczntilqiJVXn+EVQfiYKnLqJOs/ClIXcT4I3UA0
 K5aspcqb7nZa9d9oLHl/gnMr+7tzhUthPyt2nmE9yXR1trn1C7UxLbzym+BovDdAEmBNHATqitV
 gowcGG8q+UqAhrey3vsLtf5HImIOfkVd+TOcmaqoeKn0pdU+2ClklkZWWuSPZ487SM0cmDnz2C1
 iGtEgxQSBrtf6GBC2d/etauF2TPzcSWLiA50TwSZMMnEv0e4ZAjBomBLGt6/oodBN4EEKFko0IC
 z7lNnU1chyMq5++BG9oppW4tU35qUGbM70e7vW5R2VenZeVNle7WRMV9PM7aoCll9FDyToggtFh
 y3nM1tyfxmnPcmhkmr6Arv/MeRImecDofJlbA8Gq1/NTHBdFh5h7VJz33oSPSRmR4KNJajQwru0
 oV6bvQm+LM2rktW39ya9RNbnqonExofCyI0arK6BQ3PYO4mcSczuAwRcMy9ABCKxBGIs9zpXCoo aXWaEhK33clY8pQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/read_write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index d4c036e82b6c..e24b94a8937d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1417,6 +1417,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	struct inode *inode_out = file_inode(file_out);
 	uint64_t count = *req_count;
 	loff_t size_in;
+	loff_t sum_in, sum_out;
 	int ret;
 
 	ret = generic_file_rw_checks(file_in, file_out);
@@ -1451,7 +1452,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 		return -ETXTBSY;
 
 	/* Ensure offsets don't wrap. */
-	if (pos_in + count < pos_in || pos_out + count < pos_out)
+	if (check_add_overflow(pos_in, count, &sum_in) ||
+	    check_add_overflow(pos_out, count, &sum_out))
 		return -EOVERFLOW;
 
 	/* Shorten the copy to EOF */
@@ -1467,8 +1469,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 
 	/* Don't allow overlapped copying within the same file. */
 	if (inode_in == inode_out &&
-	    pos_out + count > pos_in &&
-	    pos_out < pos_in + count)
+	    sum_out > pos_in &&
+	    pos_out < sum_in)
 		return -EINVAL;
 
 	*req_count = count;
-- 
2.34.1


