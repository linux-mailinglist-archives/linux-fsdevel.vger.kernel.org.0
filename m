Return-Path: <linux-fsdevel+bounces-76235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBaEApCWgmllWgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 01:45:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A78DCE017E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 01:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AD1D30BF637
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 00:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA66A221554;
	Wed,  4 Feb 2026 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="XJalUroZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A021576E;
	Wed,  4 Feb 2026 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165893; cv=none; b=qXZoHs3hQDEAdwKQPtQ0NF/4W1GnJP+waxXzGZG6yqAcsfekzQoTgoYDNa6rd0xGa32lM2w2lmpj9HqrR5rhLddGAYZ4j+EnauqYZIpfEHUhZvEKMMgOui8u3abf3zCD8AjtJtW1WJvvRodf18lUDh15iojhoWEcbZuAO76b7yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165893; c=relaxed/simple;
	bh=QbfZH5q6w4OI8YF3vuMiRli6CPe498AdBlcIsEP9usY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KD54HysBd3y6LsYrI2orElSN4/dVv4SbzEdE9r7BlaaRi5QgjgU85Ky6BiEO9cmhf8kOWw/7doLXwWuP+kdenUmfDLxQcV3Se3eXSKuPRWjbbBUggsity7YVma/gnQL5sc6WQUM/onKKbFIhTUPmQJ9hiLLjk6zJwMC1LFLUnZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=XJalUroZ; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 3543C241;
	Wed,  4 Feb 2026 00:42:31 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=XJalUroZ;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E3891244;
	Wed,  4 Feb 2026 00:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1770165884;
	bh=hf7RcZpOtGky+43DdWAzHuxOmZiJPotKax5NzbNOBAs=;
	h=From:To:CC:Subject:Date;
	b=XJalUroZu/DUy9WtoA8r8wSZh6mxX7gYclCh3CASxlNSRYnHC0z535vsrDysAHxAp
	 woD/ScSswxIG1P9VEDjnQfz5Qeov2fRwMPA+HEqiG0Tzir8u/4nCJazBu7M0It5Edn
	 2Y02Keo2dyynvqPJGAU3GgYWFRwzh4DH+cM40YQM=
Received: from localhost.localdomain (172.30.20.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 4 Feb 2026 03:44:43 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: allow explicit boolean acl/prealloc mount options
Date: Wed, 4 Feb 2026 01:44:34 +0100
Message-ID: <20260204004434.7998-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[paragon-software.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[paragon-software.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76235-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[paragon-software.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almaz.alexandrovich@paragon-software.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paragon-software.com:email,paragon-software.com:dkim,paragon-software.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A78DCE017E
X-Rspamd-Action: no action

This patch improves mount option parsing by allowing explicit boolean
values for acl and prealloc. Previously those options were exposed only
as presence/absence flags.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/super.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 5c104991b067..4f423d3a248c 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -264,8 +264,10 @@ enum Opt {
 	Opt_windows_names,
 	Opt_showmeta,
 	Opt_acl,
+	Opt_acl_bool,
 	Opt_iocharset,
 	Opt_prealloc,
+	Opt_prealloc_bool,
 	Opt_nocase,
 	Opt_err,
 };
@@ -285,9 +287,11 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag("hide_dot_files",	Opt_hide_dot_files),
 	fsparam_flag("windows_names",	Opt_windows_names),
 	fsparam_flag("showmeta",	Opt_showmeta),
-	fsparam_flag_no("acl",		Opt_acl),
+	fsparam_flag("acl",		Opt_acl),
+	fsparam_bool("acl",		Opt_acl_bool),
 	fsparam_string("iocharset",	Opt_iocharset),
-	fsparam_flag_no("prealloc",	Opt_prealloc),
+	fsparam_flag("prealloc",	Opt_prealloc),
+	fsparam_bool("prealloc",	Opt_prealloc_bool),
 	fsparam_flag("nocase",		Opt_nocase),
 	{}
 };
@@ -379,15 +383,16 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 	case Opt_showmeta:
 		opts->showmeta = 1;
 		break;
-	case Opt_acl:
-		if (!result.negated)
+	case Opt_acl_bool:
+		if (result.boolean) {
+		case Opt_acl:
 #ifdef CONFIG_NTFS3_FS_POSIX_ACL
 			fc->sb_flags |= SB_POSIXACL;
 #else
 			return invalf(
 				fc, "ntfs3: Support for ACL not compiled in!");
 #endif
-		else
+		} else
 			fc->sb_flags &= ~SB_POSIXACL;
 		break;
 	case Opt_iocharset:
@@ -396,7 +401,10 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 		param->string = NULL;
 		break;
 	case Opt_prealloc:
-		opts->prealloc = !result.negated;
+		opts->prealloc = 1;
+		break;
+	case Opt_prealloc_bool:
+		opts->prealloc = result.boolean;
 		break;
 	case Opt_nocase:
 		opts->nocase = 1;
-- 
2.43.0


