Return-Path: <linux-fsdevel+bounces-12370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F2D85EA99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73DEAB26FA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C753133420;
	Wed, 21 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+32nzQs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A761292F2;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=OUhjUqUp9GAagDE/p+8QTS7s6gMyuGFOZT58Kp08OSIDhHok3xTJPp07e0nedtkrVzyCp6V7Fh5U1P9Ekq8CaD7XetOwP2knhK3aVundWbkH/KRGrF4JvnjmEs7KwRbW+FtGa+qwQN0lKS7GgRi+wGMDM48l+HWKYfVenduRtOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=MjPDmuGYxTwVV3XD9s9x96VSdlRd13Fx8UY16afoWLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHBnN2FQAk/IZKQ+qavkZvjRz2BAu24srcaL3wQqWxH5JT0sxHYWSrkndUr/TFV9BK4d83pUBHACMm6VNHLi36D1l7oLePl+Uo8UrgvM4IvEs0Y5QeYjxTjCJbr47vlXPiBCke8XZl3kjBTE3yX1poXeih9vfVbyFRMkGAyNUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+32nzQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4790EC43390;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550706;
	bh=MjPDmuGYxTwVV3XD9s9x96VSdlRd13Fx8UY16afoWLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G+32nzQsv2yA6coHTy2HUa1t9RBiDR2AasBhQofnI4QyW/IVAwvXXtib5syKL9VI1
	 XYeuJazXkEnUDWxhHFfB30px/QQ4SZ/lM2CQjtlruAVC7gHMI5V339a0r19mU3WKr7
	 pxQFGREc7DUro23NFpTz4WpsaaqIhWsbSeSqXDix962HqnmSMg38nn8fZcH+cp4GpR
	 y8cRFE8J63EdITcOIkUI6OFpmlgs0znPBuyzPWB2OFW4RKCYY32zWkqnziQ+o0/LDA
	 mFAYc2ntRvNmb8wPKZXXv+G9IziYus6/LQ1MFu9rb5vtZr1bAxNPAGvKYyTt3yocWG
	 RUyg3VTXWCdwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F87C5478B;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:39 -0600
Subject: [PATCH v2 08/25] xattr: add is_fscaps_xattr() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-8-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=MjPDmuGYxTwVV3XD9s9x96VSdlRd13Fx8UY16afoWLI=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1mofpeDW0VRFpT+qzsFdS/fHW?=
 =?utf-8?q?j5IKuhck4JZotJG_3ni+RRWJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqHwAKCRBTA5mu5fQxyRAAB/_9E0ZBYKot+MRKSR27p0Kv0vDG4b1T8VUYNX?=
 =?utf-8?q?dxn7GTVrucCBGVtpVtqSyN8mJcxmFFj6dgjcjWE/8Fq_5ZjeTdXL+YyPRBKcf0KBr?=
 =?utf-8?q?bLryipvjsqSujzheGkbqC8maXAS3ScS4R+vuzpQuiMRBhwd432RWhFkRu_ALGbz9F?=
 =?utf-8?q?zAX6BGGK/+JaabY7XD/jynxRjg5i8POSN19q0OJlsOqUpYJrmjTusaT4lCzgC+6ix?=
 =?utf-8?q?XcwFzw_+z6fBZXxwGNAJ/G0yohMDqfv4/nS298M7iKZhieHyKr5Hz/dZ+rOFIiwoG?=
 =?utf-8?q?WzyRw8ccnmGTkNSWT3Dq?= Yxtsflp7R+yVNxyPqIPgRpugwoXtdA
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Add a helper to determine if an xattr time is XATTR_NAME_CAPS instead of
open-coding a string comparision.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/linux/xattr.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index d20051865800..cbacfb4d74fa 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -28,6 +28,11 @@ static inline bool is_posix_acl_xattr(const char *name)
 	       (strcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0);
 }
 
+static inline bool is_fscaps_xattr(const char *name)
+{
+	return strcmp(name, XATTR_NAME_CAPS) == 0;
+}
+
 /*
  * struct xattr_handler: When @name is set, match attributes with exactly that
  * name.  When @prefix is set instead, match attributes with that prefix and

-- 
2.43.0


