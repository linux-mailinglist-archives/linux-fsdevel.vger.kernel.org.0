Return-Path: <linux-fsdevel+bounces-75114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO0pGD9bcmn5iwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:15:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EF56AFC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B353830267B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2D63C23D7;
	Thu, 22 Jan 2026 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/Wwrzyw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27143A2AE9
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099771; cv=none; b=BbZ6Ww3pMaGL/OOiHXyyyqtnZ58WOeYYsd5Ld4kPFNz2wJCX4u3doBM56AB8C94u9/DYL7VRy9HwdaXixnNC7ii852DVjK0bMI7KOp2aLsrd0l5QE2qIWY4frkE6yqwV/suAnzvExpobXx/RukoQ8EeLYeW/obny0LkCmTMQaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099771; c=relaxed/simple;
	bh=slb/GGM+dDvhj/vRE0/DHMfg6wYcuMLRVsOLLU+nlSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxGcW2WZ2+ZxwZmZNT+Iv3Y97dseNMPd7+ze5jUgvuJVHRul+1Z5s/62lSxeOvoUVBdHSDM1DyPRR/1bY9SrcAf1gA8aWgNtKW0VBXvm9phsx/FzKlA8xz2YRYlSKUABJl5Akmt1qI8eVgzR2aluMstgRmTZhYphB9Wb/hBUj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/Wwrzyw; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-123320591a4so1372158c88.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 08:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769099760; x=1769704560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78HgOhT4Kw2q12pLeDbNDTx/e26eJDuxp0giAwSWLiw=;
        b=E/Wwrzyw4ja0O0zAFgX9K74S0kBrTf2YDlPK3LOLp1vOD0PCJmHmlIYYBHaWrCKwmR
         XLYrBAu2n92XCwp6WkM8qO9EjPvukHKKWUx5YStA2txzblw0Rx2/o4htYlabVt9SrMoe
         X2+oA6VXikfoQ+i2muP7I17EeNT4nNpWKM7wDRhFZ5YuTV12azA20A4v4l96A3sa1BDr
         8a9O661PUaVR8ZdXqzQvAPZ6hhnmdg+mCUh+85/nCfE7yKKe6z0wsNbLdF73D0BoWUhy
         UT6pbvkSSORDiusDTEXzRO/uHBYM705VdtufKmp0xu4/11VGFHyehA7makX0TkHbeZ7Y
         gk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099760; x=1769704560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78HgOhT4Kw2q12pLeDbNDTx/e26eJDuxp0giAwSWLiw=;
        b=QZyxjO1tne1U723ekpWyfyJNILaW0hxbji8UBl2HEXklK0XQH1MC3bwaNGlTc/c/js
         EEfk5J9m2Tf8asaXUJhspSknhQIkV9YGCzReE0D826FaWiRxvX7fO/rwJNyVXCzFaefi
         7pxPDbasxbbCST5pRIAAyQvEkwkmziAmbwQ/rvm70mrHc86f64MDkf6BVysqoYNXX8YR
         0ONAQcbbDquHOQ0wih5tI8y1TLBJ3tkt4IlxVTwBJSFhChw9iE21jsCipC0J3wmxFoi2
         QsVbjVFRTjyvGRcABluhC4zDJmtEXO1B8Y8X2fOjAHQ69D3W0am+Vb7V14rU3v+kDK0L
         tBDw==
X-Forwarded-Encrypted: i=1; AJvYcCW6zodRDqw5Nsm2OoWAqa+KrnJnqHFpE1AVfH3b+UjEhbKZvjEOQis2gJ1GIw08XJB3eGyMJ+2wBtgivORM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn7yVbvQJ9gP8kztfnbdXWt8Wll44l4WIrfhLZiHw9REDJO8JH
	qe8629h8iv2zH0NmAUiynXYIQ7Z9LzcrNHXFXIzaGfwHAKhwqKGYYBkMwbYCXA==
X-Gm-Gg: AZuq6aIX8K0jXOgdd35aIrkDFRlJe/8sSvtXD6276zU570W9ZIfD8w0wlvvzWHliE4L
	b1rEP7pPEQaNrbCb5Q+qmgpIM2aN1AglMrtoM2HBjUDsHEKLVv0Q60W8VpwW/LE225zcgDYgx+x
	q0j5aqrXDphezfdxm2v72226h89+PgGJWmfH6IkWgS8gRcfmElBe2pLgeoSoXqg+R8chB0YKOlW
	WZ9aGti4isKo8tHvu/zU6m4xnT8eSd53fV/F0R7cs51BPfzs2f/hgurze3fN6ytA+qiC6BKXAhA
	68LCX995QfNUKMIOnRXwzDvqhofrof44X0BwrsGcNKsESUB6NjttR6h5BzprqfcxvqR7xPmlvVr
	eFkOoULOFzdywf3l+n7SCpVtq+eFxu15voq+Aoi3zP34IpT8tTHk4wdfsgz5udjbFeEMsS6fIC4
	vWJKk=
X-Received: by 2002:a05:7300:80c8:b0:2b7:2daf:34cd with SMTP id 5a478bee46e88-2b72daf34edmr860373eec.12.1769099759921;
        Thu, 22 Jan 2026 08:35:59 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b71d3d2da2sm5525543eec.6.2026.01.22.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:35:58 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanql9@chinatelecom.cn,
	Qiliang Yuan <realwujing@gmail.com>
Subject: [PATCH] fs/file: optimize close_range() complexity from O(N) to O(Sparse)
Date: Thu, 22 Jan 2026 11:35:53 -0500
Message-ID: <20260122163553.147673-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,chinatelecom.cn,gmail.com];
	TAGGED_FROM(0.00)[bounces-75114-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07EF56AFC1
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
 fs/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 0a4f3bdb2dec..c7c3ee03f8df 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -777,13 +777,17 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
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
-- 
2.51.0


