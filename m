Return-Path: <linux-fsdevel+bounces-12365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD17F85EA71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924A41F23F30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEE712BF09;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXPYl07o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7EC126F2A;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=joUsvo0W/cyCmTR0gUF0Stldrr5XoHonDBnEkACQM5dAkQZ+9fmC/Skl9GTIJUowi13KL0wuXGsv+YJ5iAdllkGr/OF03CkDae4k51olsaejIS+HiL413pSMxF21Xfa5GzOWtAbufl84JBXjVQveEGGB9XatKavFtmtHLgJIPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=s8BhiBRhiwiAP2lDz8YD4FeHbwY0FdRcy4khC2QXOeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O0ZOSo3bUG4inu5/QzZDulXaIEk0zkszcoTjQUHgFtXHbLP8ULgEu1Rr2TuxCndOYDZVn4H2IHzip4hChwCHtWXQGnt0iu9nxU1LJbQWhAPnZhAe1S5tple5nIYdmGXNOoNXd23viUmnSTE+48zdfRAWT5s7V/WfYx8ShiNFn+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXPYl07o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B86F8C43399;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550705;
	bh=s8BhiBRhiwiAP2lDz8YD4FeHbwY0FdRcy4khC2QXOeo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uXPYl07oVJX+lSh2eI/G9ENNQzwWI9Mvd+lPPnS6208khlfYH04meDoyVGSUGw3vD
	 Y5dT61JFbTj9wiNDaIw/OrzWU9sphp7z0rSs4bU2n9aiPNCnvZiq1PgoJc6pv8ZUeK
	 iFQslb7CZGoiI7eahfCmzZiklTbrNC2fa6pYy5Q15bhI84I36YOjG/0nAz3cdtqBvp
	 mVdJlooRtDlj5cx14RgtR2sX1xQ4lRc0gLLmPpMa7YN0j4tLMP8bxmVhYkwg/4UEW3
	 NQJgDWDfuuWKAoe3A+ehgmX5GcrurfMsCXplT5qOaUjzLxp7o0QQkdgHx2gQ9meX2J
	 ZxY03ei4WaFIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987E5C48BEB;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:33 -0600
Subject: [PATCH v2 02/25] mnt_idmapping: include cred.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-2-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=615; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=s8BhiBRhiwiAP2lDz8YD4FeHbwY0FdRcy4khC2QXOeo=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1moZWJyTYqEQXXwQLJ5EhCO4I?=
 =?utf-8?q?sZaODJ1GwzPRkjR_O9Ooj0yJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqGQAKCRBTA5mu5fQxycLAB/_4gilqSDMXmqmW5ACdjlSaK8IVbKVXj692sO?=
 =?utf-8?q?mAd52ZU7RyDpRMqErfeo+jKA9HZ4jpNMRinnIbv5ZJc_IgyPm1VNoeYHtZ3uI+nzh?=
 =?utf-8?q?AuZFC6/OM+l+muPeJwJFVYuiRHY0MnqLcJ402ZyYNVL5NCRfHg0HB09x+_p8g4irx?=
 =?utf-8?q?XYe4CvbNPE7Hj4Nl8+MePzf15MKpUJS1fMu5eW+uEkv0BRqLqbIkXGqoGLyP28E8x?=
 =?utf-8?q?hjA0HY_Il7EAF6BoAhxoG52+v9loCyzJZjiN4oMZ5A1QRkvhA9MEZRXmz386l+/K1?=
 =?utf-8?q?dmGAwPxn6EbEOtRlfb55?= qnL3LrPDn/o6PZFFOlK7G26VetuwcU
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

mnt_idmapping.h uses declarations from cred.h, so it should include that
file directly.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/linux/mnt_idmapping.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index f463b9e1e258..6deba8d5481e 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/uidgid.h>
 #include <linux/vfsid.h>
+#include <linux/cred.h>
 
 struct mnt_idmap;
 struct user_namespace;

-- 
2.43.0


