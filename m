Return-Path: <linux-fsdevel+bounces-75238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKZ7EGkuc2mTswAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:16:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B7572505
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0074C304C97B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ABD350D42;
	Fri, 23 Jan 2026 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atcHtk62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF230C602
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155954; cv=none; b=gO92CLfWHMsNy3DYJJmpMfvnUebBj9DTG5HpK6uZFBwP4Ly9Mt/USj0ckFYZdm8Kc6mpAR6jLLdORDTLxjKPvw1CS/dNe04RT7LCO0G/kfE1dpKPdFCIKLzYibbab5idKpfHiom0i4xST927Kti/5XfXr5SnlWqAjjN+TREM8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155954; c=relaxed/simple;
	bh=Ecrm2+6N6Z/T/n+8rsIboMq5D9ci8gPIweMR0A03Q0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzRQ0WImTcuU7J0qT6HxnhYHZIPQg2TYrs2idyGDkUaeA1usODkEjSc/2fj+qDNgDTLW01kf+uKJlabwzcVquVk6Y8PBISyI0U/ELLbLEFFk2UkoUS1GII3ynW+WiSg+3iqjnBtGzadozxt1xiJ7JaFcSm7dhhvgZbwguxooT9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atcHtk62; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b7070acfdcso1955439eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 00:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769155952; x=1769760752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDt4ubMlKawjVjnkE1M7nH+9HIsoLEd8+NCdahhhvGE=;
        b=atcHtk62omvCxdYm9xtnlWgPE1Ax5tc1lyXL/jmJOCZTDyL+2jJKVESyXBhWHnB+Ux
         R+NQFxGt+OWE9IbCa9hm2IKRQAorVsyfu6QmjlTlpT/k5uT7Iw1sI4/yYwmCjKkyC2dV
         RKsJa2VKHm3ity2+kE8MRBP1n+JPz8Nwhus/rLwIQ5W8CabtbH6ILi8bu8GN/v/NNScW
         l+r1DNEqpiMiRe9sWDwIjw3F79iT7u/Rsq8e87407vZXEs3dH/En0ZKlekwEiVgkbKtc
         blcOgzAIDpG6u3wNdeL4d6hVpTYk9+AgK2kmi3A/M53Rv/qTuXhc5g+G6aQCy6gJ4NeT
         YZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769155952; x=1769760752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDt4ubMlKawjVjnkE1M7nH+9HIsoLEd8+NCdahhhvGE=;
        b=YbfbQXagwBVJJcNVEesxt1cskfaq2k8ey9+5H+k6HaGEE6Hcaf+0JUK3DA5U5nQJdZ
         UIy5bOfmDtCjhfsyF7+YClsLg0yxL33COhrLzW2eNXpTZqFCH6/vZ/oAhR5yHXj8qtrS
         jMUKCAFh4viGznYuw3wthTEBs7ZkhPy2FSDgTtsOj0ZRTF0ej4u6Cd/60rzGUD3KX4hR
         HqXlyLncHiQJIJJ90TfkR7vQBQFlB6X/VWCBCrLDFj/ykEWfi4qnatd+35n0jcFJFqBB
         uF3YMakhC2gzdgjv34LM9JD8rrml/ikWEe6HCj4JPj+hesGAH+J/B/G05SSLfgJUMDyX
         ZHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS4uNgF/2hQ3uqkx9oqV3j+ktZGyqV9cqHaM6GAKK4eU0mgRXwacuzY+gsubhPmdf4s5MLdXnOJrMG2vBB@vger.kernel.org
X-Gm-Message-State: AOJu0YyEl7MG7IeiK8mfgbZZaWXK2bQjgZFfn94mkEIIrfUvH8N62R4e
	Ne8at+LXHSeyVP6hGB+yWRwOJvrD/Blh1cA+AaPKqgWFSpnPHY6ycf3m
X-Gm-Gg: AZuq6aKjuczsdYcivUcEyfwqkbMJGYCGCHm50nY3dxHmPvRfU5nGjoHvh/hyqyUKOkl
	aobDEaHY+imGPqh0wnXQuqy/4c5ORmag3giOz5uWYrKZNGZVQaz3H9oZTeAHSEMLN7E8f5LBOWq
	mnUi76xGiKmmah1midwmgXGQTtxuBTEtzNR/SrGkZ2plcCRToyVfpcoY6EzFyuNRv48z7KFkZNv
	hamnIsE/VRyTaWE4Rilnn42bdHe8cvs0EJImdBsyxSF+DO79YDdqhsTN7QkqpcIzriizuDFJCXw
	KCCqoWnUNkor+aXbXk8/i20Dnu8mbYybZupytoBNAzsRegdWaI/qcQIFMF/dBY+8F3OA60ct0Cm
	R6ue4oSo1qDL4jwhtWxqdRma8c7XZnbmSSUMolmlh7OXwp1xgF8uDDDlByVYfR6UoWFm6/MlCoj
	+qyyk=
X-Received: by 2002:a05:7300:a49a:b0:2b0:4c5f:c05c with SMTP id 5a478bee46e88-2b7399b0eeamr934441eec.4.1769155952292;
        Fri, 23 Jan 2026 00:12:32 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a9e1ad3sm2055819eec.19.2026.01.23.00.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 00:12:32 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	realwujing@gmail.com,
	yuanql9@chinatelecom.cn
Subject: [PATCH v2] fs/file: optimize close_range() complexity from O(N) to O(Sparse)
Date: Fri, 23 Jan 2026 03:12:21 -0500
Message-ID: <20260123081221.659125-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122171408.GF3183987@ZenIV>
References: <20260122171408.GF3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-75238-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,vger.kernel.org,gmail.com,chinatelecom.cn];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88B7572505
X-Rspamd-Action: no action

In close_range(), the kernel traditionally performs a linear scan over the
[fd, max_fd] range, resulting in O(N) complexity where N is the range size.
For processes with sparse FD tables, this is inefficient as it checks many
unallocated slots.

This patch optimizes __range_close() by using find_next_bit() on the
open_fds bitmap to skip holes. This shifts the algorithmic complexity from
O(Range Size) to O(Active FDs), providing a significant performance boost
for large-range close operations on sparse file descriptor tables.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
v2:
  - Recalculate fdt after re-acquiring file_lock to avoid UAF if the
    table is expanded/reallocated during filp_close() or cond_resched().
v1:
  - Initial optimization using find_next_bit() on open_fds bitmap to
    skip holes, improving complexity to O(Active FDs).

 fs/file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 0a4f3bdb2dec..51ddcff0081a 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -777,23 +777,29 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
 				 unsigned int max_fd)
 {
 	struct file *file;
+	struct fdtable *fdt;
 	unsigned n;
 
 	spin_lock(&files->file_lock);
-	n = last_fd(files_fdtable(files));
+	fdt = files_fdtable(files);
+	n = last_fd(fdt);
 	max_fd = min(max_fd, n);
 
-	for (; fd <= max_fd; fd++) {
+	for (fd = find_next_bit(fdt->open_fds, max_fd + 1, fd);
+	     fd <= max_fd;
+	     fd = find_next_bit(fdt->open_fds, max_fd + 1, fd + 1)) {
 		file = file_close_fd_locked(files, fd);
 		if (file) {
 			spin_unlock(&files->file_lock);
 			filp_close(file, files);
 			cond_resched();
 			spin_lock(&files->file_lock);
+			fdt = files_fdtable(files);
 		} else if (need_resched()) {
 			spin_unlock(&files->file_lock);
 			cond_resched();
 			spin_lock(&files->file_lock);
+			fdt = files_fdtable(files);
 		}
 	}
 	spin_unlock(&files->file_lock);
-- 
2.51.0


