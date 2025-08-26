Return-Path: <linux-fsdevel+bounces-59244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A5CB36E22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8009B1BA8996
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7241C35A284;
	Tue, 26 Aug 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="q3nfGKKA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8F235209F
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222870; cv=none; b=LWGhdiqWVA0op/ea8vWjG8R0uwrw/BI5JD9g/2STneI4t3JnLAMOzaHQqL9mGIa80UXoEjnSIqcAP+D+VuEP3GSADYlbBL23ynaddB5yvffAZ5ZhnyD5ifJvHXwT7kf/VUeR16zXZGtzvAtu2v6yaT07Bwpyix/LF3V8CeDq4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222870; c=relaxed/simple;
	bh=nmdvl9jauNYDtI954LQe8Lq2K6dYkRbi47i+ppOrCYk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eh0DtAN6EE9jrUhO8oPbbk1GFziK4EJoBeeasByLbZKw9H6oA+Ea638MoNi4K0iTqppo+PDnxUydSx+km9bslDX2xc6FxMXARLAv4mWIkanU9zBIqi3CdwLTLGULs7Dy/NE8YohFcchx8rEmH8zDr0TZgOqu5jJBlixt5HUL31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=q3nfGKKA; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d60593000so43515017b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222865; x=1756827665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+H1oFX30E0HNNRPQLcGTuC/g8Ntf7m1XHDxknfLx+E=;
        b=q3nfGKKAZ9sC0To7VQ+4dnl4vSnn5AndB/eo/ehq0nfeX0TA+WPKYtWxQ0K3eE+p/D
         4oGjW5WZeeFKvMwDUcHG/gvFVrp7Guet6BIdjns6yDOnD+OYcDlGXcSbQ9DhJqV4KIcX
         Wfq3xP1lHv8KhQXyVgpl4D2yuaftpcHXRIRAvP5tLyY4lM8//6gyHmmeLZJb3311RtHL
         UyfzooKIO22PCH8q3XUjQ3dT2vehBYGbdiAA5WtK+uqgxbnHnE9bIsqA2tgL3EB4Pl5z
         fER4PX0iAemjmygv0NazK+WZZBcG81qnJt2qlveFpP3k/OhsUvBF5CMDQil4jn0Yt/US
         b8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222865; x=1756827665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+H1oFX30E0HNNRPQLcGTuC/g8Ntf7m1XHDxknfLx+E=;
        b=KBah0fDycPvpIhj1cIVzbIRt/R4aDw982YZJH2pHlwmrkQGupb0hIwuZ/Re7V6sPsN
         FEK7TK15QLRNhkiXLLqvCcc5kE+fkpn3uYvvOTPHDQpf/ilwPW9LdpuII6L2oKs5qqWR
         ZIQ97jt9o3kogaCQY+s3uv38OtQxdwQx+2PFtBOP0eV2x69fOOrQAznDEspT4OHUzDCG
         zCyGtHcSWyvwLew6JsCqnL18ccnjFiHJs2M2L6hz7AyisIIwdcjx18Hhy11yf5eMMVrT
         +aimxqZ8BZiOUWumu8gsuI0Nx2Uf+Tl30CuPYuxRtTq0p9drzvkOSYgclkdC4/IcsPCa
         NU8w==
X-Gm-Message-State: AOJu0YwNrjJnqYb7yu1pvPEQRQMsvqxKjQEDgWyrC0/pDNzcUuVzBJIg
	2uYxZeHAePcSNux+1LTL66/IS7NS+sZku1FO1WWVJgPRIb3r4mX+1u0QjGssWzYBuPGxf+mlvcD
	VTdZV
X-Gm-Gg: ASbGncuZSTRknlI8Q+TnNZ5ywuUyo75Q0eGV/hjC1nidQhsF1RYYv2/N8yYERJtYho5
	OE61jXZdiz7deHBMDFWHGdCNmllj9w9eY66VHmS9PT07P/R9pBvsN1ewsgSjnYbU+XGG4iFbuoC
	YQ4TIBF3Xq+vKiSYBhSuiQXiTN0z1fIq3/pTWPXtGPI6/u2bka2bQlO/8k5cAhUNMDdmtho4i4L
	G5g/zMmESXOKBJh3bAMRfp6bCCbZwECg7biamySDgJF4TU7pzcWeOn1T3/N976TFaUGSPBMfdCq
	4fqnrMoVvHFvzO6sTwKfnAUskiDomuRr+bx98oulEzaCFUdaS2yueex/RuWShrCFIHYc2vhfQe3
	LbaXcy4P74P8s0dkDYTktWlT0EU70qcnKij0xxggbPBWzg3nW+W34HvbJyzyTSzE7VkqFDw==
X-Google-Smtp-Source: AGHT+IGf/vXHdzIVCUBDcyspP6L3gezeLKadrkozOYbpyFddznFi3iBWOvI6XcY42p18ka0bO6bSFQ==
X-Received: by 2002:a05:690c:680c:b0:71e:7e24:41e1 with SMTP id 00721157ae682-71fdc3db18fmr172652127b3.32.1756222864568;
        Tue, 26 Aug 2025 08:41:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b3794sm25075497b3.63.2025.08.26.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 11/54] fs: hold an i_obj_count reference while on the sb inode list
Date: Tue, 26 Aug 2025 11:39:11 -0400
Message-ID: <f5f18f2d7275128e742ef97c7be13de46e65019d.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are holding this inode on a sb list, make sure we're holding an
i_obj_count reference while it exists on the list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 0ca0a1725b3c..b146b37f7097 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -630,6 +630,7 @@ void inode_sb_list_add(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
+	iobj_get(inode);
 	spin_lock(&sb->s_inode_list_lock);
 	list_add(&inode->i_sb_list, &sb->s_inodes);
 	spin_unlock(&sb->s_inode_list_lock);
@@ -644,6 +645,7 @@ static inline void inode_sb_list_del(struct inode *inode)
 		spin_lock(&sb->s_inode_list_lock);
 		list_del_init(&inode->i_sb_list);
 		spin_unlock(&sb->s_inode_list_lock);
+		iobj_put(inode);
 	}
 }
 
-- 
2.49.0


