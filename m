Return-Path: <linux-fsdevel+bounces-15628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC08910B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EE31C26D7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 01:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9389739AEC;
	Fri, 29 Mar 2024 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izwZp+BM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5838DE0
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677255; cv=none; b=LovzFMtQW6zcso/+bfPB7BseeFXvNOstLj7xOdPW507vAUBNp9t3CaS+XztDqYwolquLh+ZGAjDZAHK5aASpG+sEzwywnhdw9YPuTfPc86VwZz+vdIwn3s2WFUYjV80MRlDuujsCvai/qM2/Ej/fDp/GzKT7fxotomJHMdRtkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677255; c=relaxed/simple;
	bh=eksvIxAmmQXuXXW8c6928tLpQjkLP4OTZFUN7IvQeAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U3TQ7sAEL5B8eZJnXESJetorimKGnmK5ARYr9+Iy4CVwiHv0rZVE7gCKMEmPpL70awcYcO+rwJvz/KJM8H6LAcf04hjBpA1oJfoFyGv8ZX/KRaZdXIsAz1kOWBxmQeBkz1vbFz/xIEOtdvaQIsRA6wKDRpk6NjwEni5vDhXlZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izwZp+BM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6fa0bso29197217b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677252; x=1712282052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MmbRuGQ/QD3ODDkbWEuu2YWzLi7SZ6xa0DaniExgEL0=;
        b=izwZp+BMYISb1jG3g8WkhEkmwaGBXQcVF5KA84EDfxMQRwssSDCNH2O+QRdsW10UNn
         PvRZ3moPyi8KRkUdsWgMBHi5FCCGG5usvt0qIebLoxhsEqotNFamSD1y/rUbfvnSzzTD
         MdduiNUmO7ZLKHom7E1RRbnsd618QjpJywNm5lft8tiK/KR0DSvaR9cDvZxQEjks6wqw
         67RGbNMYH8plU8rJUsM6OY65jj0Umme/lS/goQG0KCSUljM/0E3ealzhaMDGHYd0rNJo
         OFTrIWkKMPEHHwcqJV38LDPrQ6Xb9fgxmH/j771u/vwBUMsxRKJsaarIeEav1T1jVAXb
         OEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677252; x=1712282052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmbRuGQ/QD3ODDkbWEuu2YWzLi7SZ6xa0DaniExgEL0=;
        b=feE4YNf5flZYFt8pEW9UsVt6XlgYr8Iou5qKNBhwj0kQA1GH75VIPNXd281NKD/zsw
         YXEC/tk8qlzrN/YJ2vXVAmjFhlOcljjo//PAp+a9YpQucqcSVivuVyn5uW5Ta+5CW5RK
         tW+14t+DsGyug5czQLoiVQ81rgDU1bPSVnVWZbm5RyYZB3qbJBaiyPzYInd0wgzvVJuW
         x2ZtGj5jaA2cZN+Rfouul1pB2ehRqtVJCSI7JDZK+GrDHM82invFn2qkbjuy3db04FIa
         eu5V8uKgbKxxjhIkKuwFYKgcPVXKax4a7I70S8hL0eoHMJ39E0dnDxXgjdG7k5/oxFvI
         6wgA==
X-Forwarded-Encrypted: i=1; AJvYcCWfEijMQXIs5UQiK+Um65A+/71WQTU3TQMMT4KTYynDWNbltv1z+hyQ81m+LQrWAM2FSKByPSuRdufiqJR4EptZ3E2GtHYh8xcfJJZ73g==
X-Gm-Message-State: AOJu0YxQQyjdKgZ/GDYWeo2sGCN8lx3lngbnK8bma2S6o8HE2kU2AGon
	Ade/V3kqsy2Vu/fNh6sOjTaPvDxtuE7L8e/zMVrClKTjrj0dBFvmA41WeuzJ+DN3zdzljt9SgZq
	/gQ==
X-Google-Smtp-Source: AGHT+IHTtbLuJY0/Xd21xc4JGUtsmkGoiiTVX+jnYhPEA0lXMA0moNx8uO5mPUiTFXzzmc0XQmcHJ+pEMF4=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:1b84:b0:dcc:e1a6:aca9 with SMTP id
 ei4-20020a0569021b8400b00dcce1a6aca9mr294907ybb.9.1711677252599; Thu, 28 Mar
 2024 18:54:12 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:21 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-7-drosen@google.com>
Subject: [RFC PATCH v4 06/36] fuse-bpf: Don't support export_operations
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

In the future, we may choose to support these, but it poses some
challenges. In order to create a disconnected dentry/inode, we'll need
to encode the mountpoint and bpf into the file_handle, which means we'd
need a stable representation of them. This also won't hold up to cases
where the bpf is not stateless. One possibility is registering bpf
programs and mounts in a specific order, so they can be assigned
consistent ids we can use in the file_handle. We can defer to the lower
filesystem for the lower inode's representation in the file_handle.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6570fe7a9b53..b47b2e41e5e4 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1187,6 +1187,14 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	nodeid = get_fuse_inode(inode)->nodeid;
 	generation = inode->i_generation;
 
+#ifdef CONFIG_FUSE_BPF
+	/* TODO: Does it make sense to support this in some cases? */
+	if (!nodeid && get_fuse_inode(inode)->backing_inode) {
+		*max_len = 0;
+		return FILEID_INVALID;
+	}
+#endif
+
 	fh[0] = (u32)(nodeid >> 32);
 	fh[1] = (u32)(nodeid & 0xffffffff);
 	fh[2] = generation;
-- 
2.44.0.478.gd926399ef9-goog


