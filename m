Return-Path: <linux-fsdevel+bounces-12374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D071085EAA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B9AB27642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6051350D6;
	Wed, 21 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4NDZ9Yn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC9129A66;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=PW9yPz5xZBz4e/8ZDHG/QhwWbmae9CMKl7ZJgv+I227ztFV24o4Gs3V7kWX7qepelMoaf7QobYEIiykOPw0EHbEBZLDvnl6LirdejzZUipxatoMkoUUd4pz/zFV7MqAH3ESgDW5AXovfUl19RviveDOeJ4HHw5oWF1GiG6Q83kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=4t7VYe2pfzhO0kZ+94iPfJDYCD1vDaacDt9TOtFcBjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZiN6/S4x5rCfz5ZDSdocvpHcrRS8Utix04RHxBfIV8QF5e1b1/48XanMunTdHIiUXYqmRh6aCQLsCPLZbrYXkKm2LYa+YTB1NXSs6qD53ABOPobqvqQiExl5x0sjoJBptMPadRvPl9xzm1dBwtSNIy0WFuUfr0qAl0ZoIQiJSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4NDZ9Yn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56CF4C32781;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550706;
	bh=4t7VYe2pfzhO0kZ+94iPfJDYCD1vDaacDt9TOtFcBjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H4NDZ9Yn8LguadXM61Cv/+vC8MjNfXRmyxgNTVcyElmxvP+ZVw35iZ9BJ7IdwcyOr
	 klDsbyltojrU0OZIrg8apY3dBD2mSdC9xU4iNyYTVOU+M7zy9hRPndMTn9IsdtNmGd
	 +NGF0WBfpQ/oslQMoZB282va2ZI//vz8DD+t6UG5UTpaoI7rIHvvb7jfcDYEcaa+Mb
	 giTO54jW/xYtFV4hilLZPOJpxEgkHYGZnrNk0IHVgTmsWiPXt0ryuHgHBoBoVoQ3bT
	 oqSiQ+KhKGX5vi4s7hXECA+uIRFLqgZfgsuBoIokLmn0KsVR1p8kXZYZqesP1XLXpj
	 NjPpJnOPGKXBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A39C48BEB;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:40 -0600
Subject: [PATCH v2 09/25] commoncap: use is_fscaps_xattr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-9-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=4t7VYe2pfzhO0kZ+94iPfJDYCD1vDaacDt9TOtFcBjg=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1mogZOFLFrTJHOsqMGqEXCfSc?=
 =?utf-8?q?BiIf9AXwC8KoSVV_frhhLcCJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqIAAKCRBTA5mu5fQxyQbxCA_CB/noEJJlpI9g151/fViGjdeWOgiQrNeYPr?=
 =?utf-8?q?agty6p9bGZUks5yPjNApObB+aefC+H5tKHvGXzIrbEB_n9MzhIumjZYNHrsibS1d5?=
 =?utf-8?q?sAG1Bwqgggfi9Sx3VOvIsDip4pg6NtDhmVtW5+Yt20+5GnTd/jGezJryP_a1EhXCI?=
 =?utf-8?q?xhToqhCm8BjKwufrx88FED6FORWo9DmD92IwhJWEvf6SQrnn5DKY/aXw9kF7Fzdce?=
 =?utf-8?q?VCDrAw_kxY/MZXXVqwEedLkAlP4Q3sx8JCqZPzpoVZj2Q7z9g1oNDJDGWXr/KWOlB?=
 =?utf-8?q?YRxWFr5V1dFQ0WXy9iP4?= Ig0HUzkQv1L68QjY8iH4SVVE9ldej/
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 security/commoncap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 289530e58c37..19affcfa3126 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1205,7 +1205,7 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
 	 * For XATTR_NAME_CAPS the check will be done in
 	 * cap_convert_nscap(), called by setxattr()
 	 */
-	if (strcmp(name, XATTR_NAME_CAPS) == 0)
+	if (is_fscaps_xattr(name))
 		return 0;
 
 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
@@ -1242,7 +1242,7 @@ int cap_inode_removexattr(struct mnt_idmap *idmap,
 			XATTR_SECURITY_PREFIX_LEN) != 0)
 		return 0;
 
-	if (strcmp(name, XATTR_NAME_CAPS) == 0) {
+	if (is_fscaps_xattr(name)) {
 		/* security.capability gets namespaced */
 		struct inode *inode = d_backing_inode(dentry);
 		if (!inode)

-- 
2.43.0


