Return-Path: <linux-fsdevel+bounces-12366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7523785EA52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A5E284BBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F78E12BF34;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOHOscL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A847126F37;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=s+Tyb/1adFhbgjmvpSOn16ahmo+bvHVa99SDNGqBz+iBTHEUM7SuJeBZzrvScsMEXqhTp1AwJcqmdHkHAz3ot+nZcnH9+Utjcn52sWNa7S5rSghCdG5zQXyaWVuFEqifVBoUQ3+U8MRR0Nms1+bExFY2WHY3mCEp01lGO7CBOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=bxTL27ZkILW3Z/PzdK+zkxv1J47CpCEVsrwmLCLu4uQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QF50VmNq9egvcicmhu7XRlB0hduNG4nQ0xCLssKiu6UcZnp4ennrpCGl32gBGOlpah/RKiM8IJM62IvD3QqL0qX0LMTAmSFOkK3f2ZahGzVwg4/EI2RgMTLJuQDoXiEWUpL7WZrju336yeCB5qaGRYYNA0Wt3WhoN2YcKn/VDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOHOscL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C711BC43394;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550705;
	bh=bxTL27ZkILW3Z/PzdK+zkxv1J47CpCEVsrwmLCLu4uQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AOHOscL/gjT4JPVPVXnI5f9pRqdhqa/wBBC75l1WdNJ6VbSJSV31AtM1BKILqsmUA
	 sjYzkl1/isGO7UsLJOsgrnlLXrX05mSEhr1WiSOTZEz7ig2nmpG7W8J6frSzVd9LG+
	 Z2ybF5x+PHjg1EAllZ3tvUZu2YDU8e7KnFimS2EFFEClLob/yjzuGf7jkU9sfYOZWq
	 /NWaLnD9y4GFIlQalpBw2q6tuQGWIJKUk3cObd/ODZW9JERyRtyJ1E9vKF8QEdwra4
	 MBeM617WCZQUqFp/utwbyPkujJtwOzKN3tQHgqTX1Gouv3+FIWWEosjryZOgo75+nS
	 pWriqrFtdh4yQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FDEC5478D;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:34 -0600
Subject: [PATCH v2 03/25] capability: add static asserts for comapatibility
 of vfs_cap_data and vfs_ns_cap_data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-3-3039364623bd@kernel.org>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
In-Reply-To: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Seth Forshee <sforshee@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=bxTL27ZkILW3Z/PzdK+zkxv1J47CpCEVsrwmLCLu4uQ=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1moa/fJIxAg3DN6LOTcQsDvH+?=
 =?utf-8?q?cZkYg8eiXdC9JTK_9qLOZZKJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqGgAKCRBTA5mu5fQxyYwTB/_0d04ClkP7dmDAlcfihBhhJW2R5p6fTL0P2e?=
 =?utf-8?q?SnUHdh3EIvIuiO7fUd8A1x3SG34fs+5Dvuh9su7zIEW_EIkSiAN6/ApACZYiaq8hA?=
 =?utf-8?q?6USOPOYTJoprKB9gxYdSZnwtM0jBsTQJJBWeniB0tmsNqNK5IcG+4zjzf_9T+E79h?=
 =?utf-8?q?tjMvGDgTfzhPO4Rz4RDUXIp4f743XGZig4ke+wGBits11N8mEtI93rEHrj2RYYHjs?=
 =?utf-8?q?bFC5wB_spyh4kqE0A8w5lxKuce5v4NGcHPr8rawPMXMe/3gbFJTGSB1biA/M9v2Sa?=
 =?utf-8?q?lORt97iZEgk3CuwSNFuW?= mtlO95lKDpr28Q6/Y6GSGWAay4GQM9
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Capability code depends on vfs_ns_cap_data being an extension of
vfs_cap_data, so verify this at compile time.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/uapi/linux/capability.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 5bb906098697..0fd75aab9754 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -16,6 +16,10 @@
 
 #include <linux/types.h>
 
+#ifdef __KERNEL__
+#include <linux/build_bug.h>
+#endif
+
 /* User-level do most of the mapping between kernel and user
    capabilities based on the version tag given by the kernel. The
    kernel might be somewhat backwards compatible, but don't bet on
@@ -100,6 +104,15 @@ struct vfs_ns_cap_data {
 #define _LINUX_CAPABILITY_VERSION  _LINUX_CAPABILITY_VERSION_1
 #define _LINUX_CAPABILITY_U32S     _LINUX_CAPABILITY_U32S_1
 
+#else
+
+static_assert(offsetof(struct vfs_cap_data, magic_etc) ==
+	      offsetof(struct vfs_ns_cap_data, magic_etc));
+static_assert(offsetof(struct vfs_cap_data, data) ==
+	      offsetof(struct vfs_ns_cap_data, data));
+static_assert(sizeof(struct vfs_cap_data) ==
+	      offsetof(struct vfs_ns_cap_data, rootid));
+
 #endif
 
 

-- 
2.43.0


