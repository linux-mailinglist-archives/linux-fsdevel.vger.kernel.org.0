Return-Path: <linux-fsdevel+bounces-61052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED9DB54BD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD0F1CC4D98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F613093CD;
	Fri, 12 Sep 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aukpl3s3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1F301028;
	Fri, 12 Sep 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678021; cv=none; b=Z20mmHqLug6KnnmXhSN9PeopMMJd0wou5ViZ5tHjZOp+SXmh5187Xw0OBNMI7nJ4oUgstaMFm/4zdbKoYGMAw+vM7TghDscmDvBjpvWzlxx4hEqlD+SihG39o0AYdJcb7eu3Ia8XjyArBLwuyrGJSpgOFRpr81suwE7qA0vq4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678021; c=relaxed/simple;
	bh=kHbSsSe281A9HK5ilndBkB4/uR2tvAqfslNcU1dMChs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QoEj2Fzcwo4yilZ2j5yQDgoYvDNryKJ0Ao98Tay8mbSFUVrWd/Dfsx+CtiMcnguFk9iqn0pgNIVGcPfi9S2qAKTM+QK8HaZbgIe76KWFk1B56daY2psd+2cWqWx9m43idRTiRV/CuyNgMHGnhq66jZkPer/OYkEoF0XL9QHt6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aukpl3s3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E675C4CEF9;
	Fri, 12 Sep 2025 11:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678020;
	bh=kHbSsSe281A9HK5ilndBkB4/uR2tvAqfslNcU1dMChs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Aukpl3s3rifkqlWdL8pAQkvP3wwPN7eO73p2/c+R84/BjUhRZbw6SgF4TBSG6do0s
	 EE4MvgQG5nLnddp/oT/3T6XFuUcEcRNtIa9vz8Kq3YzydmymrYYC6WpGqFTV0tPTNZ
	 +NTUZ9lK0qI9HoJMULsx7unR5Ocz6FfycKNwIoo0oplTJuhKRXlP0gg49O5hhWVV1W
	 U63XhpASBYSwpWqkp8SzbOrT3vEhQDPy0c+z5pJ0NT0huN8gCJ90RcX0vIzxECM43Z
	 AQW1Ae6bEjHl6jCblmfkR+x1p1KRtseg+2YVTXYykv+D49PSwwaHiIWSqhN1l7l4cQ
	 escpCpM0cZyEg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:30 +0200
Subject: [PATCH v2 07/33] ns: uniformly initialize ns_common
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-7-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kHbSsSe281A9HK5ilndBkB4/uR2tvAqfslNcU1dMChs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZzCOCWvQ/hR5/MbNbce3c7/+Oiv58dHEtm1qR+2S
 5ecrn03raOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAivhcYGaaucjtz6rWSmDbn
 2vMlJ5u0Wbe5Pb7xZOd1nRNXEzP+f3BgZDht/PamqIzdvB0rmc5cvi+SZSvmnM7/NfyJh274shb
 /IE4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

No point in cargo-culting the same code across all the different types.
Use one common initializer.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/proc_ns.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 5e1a4b378b79..dbb119bda097 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -72,6 +72,22 @@ static inline int ns_alloc_inum(struct ns_common *ns)
 	return proc_alloc_inum(&ns->inum);
 }
 
+static inline int ns_common_init(struct ns_common *ns,
+				 const struct proc_ns_operations *ops,
+				 bool alloc_inum)
+{
+	if (alloc_inum) {
+		int ret;
+		ret = proc_alloc_inum(&ns->inum);
+		if (ret)
+			return ret;
+	}
+	refcount_set(&ns->count, 1);
+	ns->stashed = NULL;
+	ns->ops = ops;
+	return 0;
+}
+
 #define ns_free_inum(ns) proc_free_inum((ns)->inum)
 
 #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)

-- 
2.47.3


