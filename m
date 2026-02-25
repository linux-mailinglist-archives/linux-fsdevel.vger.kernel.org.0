Return-Path: <linux-fsdevel+bounces-78379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aENJGu0Pn2neYgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 16:06:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 055981992EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8660B315684E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB573D3D1D;
	Wed, 25 Feb 2026 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca5R3R7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6093B52F8
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031591; cv=none; b=nY6MGsgoyLxpMADflLdbZGLpUbWJDUZO8esw1/OUAeSrRYUUHt//tEyPZJjGwm4TrOtww/2WdfkPOOwBVu3VBv0mYtazo3Iax2GSF1cnDnIp7k+TdZ0HCMzBjPWq0etFTcp985m+ntIdxuxLWewDP5ifeMKRzsvxaD7u5A5o54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031591; c=relaxed/simple;
	bh=JibzVB5UOqv/89d8ZY8kyrZOK+BKtD7PvKnNb3F8n2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfGkT3bjUwoixxf1x/THB86Bu4j8avrKJwIWpfKYfks1JoJ9gVD+A3XfjioaXZuUxL45rHKh48k/dNLczsefJQ1wAEJqA+YNBYGJTkKo8mWtVDfOPohQb/YThGzybcuL2m3TtHvRvFTkX6amF0HFRke8j+yHwOVEBz5JEKiItVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca5R3R7J; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab46931cf1so6533325ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 06:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772031590; x=1772636390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+u7hSCxEMKiJ69447WUw1L3ZEVyxGWh32c1ay2FN54=;
        b=Ca5R3R7JgLaGZbM46uJ33CHhhx9WydcQceCG1clVSvz98I1La2HtnOnp2WOcAP9Z5F
         5phUgWG8EeTHNv5tpyHILj1iTV5ystJTnKM+SIsv4Ix18R1wzTDUGH9f9Jn0LwX8xmIB
         AAFUhgRHymMrLdxJiWppW4uFlXUxa0xz3IYWYe1UfpAvkgO9/z7hpKZn2Jq/8IdPI2El
         3VrRHDNwy1nV9q+qnZziMrhVHX7YhEoSyJatArmz6WkyfGUiDirl8UiRuisYw7Bxt4KC
         Q+1eFR5rUaC/bj2fsd/+Tk1q0uDGZH6dGhGrgZgOeDC1klIBtEwex1pQxNvYHh2MD/GP
         jvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772031590; x=1772636390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+u7hSCxEMKiJ69447WUw1L3ZEVyxGWh32c1ay2FN54=;
        b=svizdK8Ipz5KrQlSKUubUk+vFUIAxx7ZizWKdWks7cbKHU+YWmfahdUEtGYFfh5w1s
         hXukrOfuU5zA17EHSEd2qvANRH92asPuqBworfj3LvPZDAW+hvYfSyjwFE3gyEIlXzqY
         TFZI1rESZJO6NLyEjN5qJZ0vGe2VRcVCY6wtQOBy4aaqj0LaAvpSAc7ZAVjBP2nKcbHV
         Vh1wr+lwfmBYn/Ahe9IKq8q+9yt1dBX1k2lSFHz20e4Z+uBEM1aFfGbHoMyW00aV1cNm
         rL78RLWzLhGuZMTcZmLYSxL+8g+ZXEtkeNVuLWFaUsWZHMLiudPKTUZKuYSb4vnZVsmx
         04LA==
X-Forwarded-Encrypted: i=1; AJvYcCVesBjxHGBhjHWBcKGnl8DwIzVfTrhGEoqJxloizlB2DZF4zMr/NntNftPawGFhwvK68J0KfUrT63TdU6TS@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGDuB7NTTb4oBWbiykRcFmSkb8QuexXh7gCJaqdMaMSCrShB2
	IS99EQzSLQJ2V+E3ppGkeG2dFlkp/tDaNsu1va4VzRqryko1dpGsKKl7
X-Gm-Gg: ATEYQzzAa+Mbzn/gECJhIWYMVBuLSqrGigwZT66ssnQosjn9TGyxVmqYhT0TB+Jfmqm
	gwiBE5U53lfV72XYACibNuMfDYQShMLUubcKQRrmCuvVkdSE126qgNiUiwmNWnbvO2klMXRmEzC
	He3/A0ukM8zCvgJQbnHIXlE4j/azYbcQDxW5A7Ijws9Fc1OovPmUCif1sTRHyDq0rVQeyCLmua9
	ajTnlmxmd0bG//FiofPo9TmLoeVNzQeMG0pU/6V1UeiN02YZdsIVkjkMrI12SbBQJ+cvH/XDhgt
	aL1hSp/Fd+YrV8hQdPx3hFBQkEkQlGGqb8ktoliDy2H4Jt9Mp0jAHCW/sVLDbQTqyBiKgS9jzxk
	b5JRtJPSowAt4siJOicdp+rWYdMtXLXZXT6TKzXfxBBsjgCbFHQOGTYG8+yd4Z0Y3ghYY4ElAi9
	pk5VUHiZP5u42VyWjqAfzeLq9L+RqO48n1dqlx/hS01KVf
X-Received: by 2002:a17:903:f83:b0:2a0:fb1c:144e with SMTP id d9443c01a7336-2adbdc3f5d7mr36317765ad.7.1772031589582;
        Wed, 25 Feb 2026 06:59:49 -0800 (PST)
Received: from yangwen.localdomain ([121.225.53.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f770b9sm136852475ad.41.2026.02.25.06.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 06:59:49 -0800 (PST)
From: Yang Wen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Wen <anmuxixixi@gmail.com>
Subject: [PATCH] Subject: [PATCH] exfat: use truncate_inode_pages_final() at evict_inode()
Date: Wed, 25 Feb 2026 22:59:42 +0800
Message-ID: <20260225145942.191-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sony.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78379-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anmuxixixi@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 055981992EF
X-Rspamd-Action: no action

Currently, exfat uses truncate_inode_pages() in exfat_evict_inode().
However, truncate_inode_pages() does not mark the mapping as exiting,
so reclaim may still install shadow entries for the mapping until
the inode teardown completes.

In older kernels like Linux 5.10, if shadow entries are present
at that point,clear_inode() can hit

    BUG_ON(inode->i_data.nrexceptional);

To align with VFS eviction semantics and prevent this situation,
switch to truncate_inode_pages_final() in ->evict_inode().

Other filesystems were updated to use truncate_inode_pages_final()
in ->evict_inode() by commit 91b0abe36a7b ("mm + fs: store shadow
entries in page cache")'.

Signed-off-by: Yang Wen <anmuxixixi@gmail.com>
---
 fs/exfat/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 2fb2d2d5d503..567308aff726 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -686,7 +686,7 @@ struct inode *exfat_build_inode(struct super_block *sb,
 
 void exfat_evict_inode(struct inode *inode)
 {
-	truncate_inode_pages(&inode->i_data, 0);
+	truncate_inode_pages_final(&inode->i_data);
 
 	if (!inode->i_nlink) {
 		i_size_write(inode, 0);
-- 
2.43.0


