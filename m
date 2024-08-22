Return-Path: <linux-fsdevel+bounces-26797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA01B95BB0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFD92814CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D81CE6FF;
	Thu, 22 Aug 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="SXYszqrF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CCA1CCEF6;
	Thu, 22 Aug 2024 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341951; cv=none; b=tz0qbRHpeNKMt6uDg7rYMiQFJ56DS1XqN4FtmYeBgZwXIg6ecxLwC893HgxSHRXI+MgYoeeqpoWjg53ko5TpiJU/ngfM8uwc65gQE8eXjyMuX7ROOipJLD8h2x4XM2Y7cS2Q/zYB4cvM0c4FXb3YHDXrauWAOHQTC/TwUH2v3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341951; c=relaxed/simple;
	bh=3SKp8aYlDsCqWU4dbaWh+zkwvruZn1ACKiQ2AjPqP68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqrdDF9clmeDtky/v2WXcXQdBzUrENgA8qzK6e9T7+a/0F+YwZIaHPAT1omlIJjaoaeOJ10vvccZx2PwFFZ0IhuqFhS5u5jnP1xd8SoXvB7Sx5MMPjF2YMnnkaY8Bq7DWaRYqvAjOARe5IIUy02SO/jfgv2NHfz21GwJXC36veY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=SXYszqrF; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id AFF2D21E1;
	Thu, 22 Aug 2024 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341467;
	bh=GcsqVnU5oVW9Ak+nWjkL10pRQjeyJMt7xWaBkafjdFw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SXYszqrF8sw3j3JEzfPf0EZjqIOdXeAH4fDsOfg39KfQKFk96lMli/Hbyu30bjNY9
	 Asl2/zBhKv94xWE85cLppsOOblkdg1FmCtWvQj6lfUieStn6JKZBkwoHEwo8mC3I9l
	 kazgevWIjAQUQ5KQok8R79ojc0GCNdiGSte2sgL4=
Received: from ntfs3vm.paragon-software.com (192.168.211.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Aug 2024 18:52:23 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 13/14] fs/ntfs3: Replace fsparam_flag_no -> fsparam_flag
Date: Thu, 22 Aug 2024 18:52:06 +0300
Message-ID: <20240822155207.600355-14-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
References: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Based on the experience with an error related to incorrect parsing of the
'nocase' option, I decided to simplify the list and type of parameters.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/super.c | 54 ++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 28fed4072f67..128d49512f5d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -259,23 +259,23 @@ enum Opt {
 
 // clang-format off
 static const struct fs_parameter_spec ntfs_fs_parameters[] = {
-	fsparam_uid("uid",			Opt_uid),
-	fsparam_gid("gid",			Opt_gid),
-	fsparam_u32oct("umask",			Opt_umask),
-	fsparam_u32oct("dmask",			Opt_dmask),
-	fsparam_u32oct("fmask",			Opt_fmask),
-	fsparam_flag_no("sys_immutable",	Opt_immutable),
-	fsparam_flag_no("discard",		Opt_discard),
-	fsparam_flag_no("force",		Opt_force),
-	fsparam_flag_no("sparse",		Opt_sparse),
-	fsparam_flag_no("hidden",		Opt_nohidden),
-	fsparam_flag_no("hide_dot_files",	Opt_hide_dot_files),
-	fsparam_flag_no("windows_names",	Opt_windows_names),
-	fsparam_flag_no("showmeta",		Opt_showmeta),
-	fsparam_flag_no("acl",			Opt_acl),
-	fsparam_string("iocharset",		Opt_iocharset),
-	fsparam_flag_no("prealloc",		Opt_prealloc),
-	fsparam_flag_no("case",		Opt_nocase),
+	fsparam_uid("uid",		Opt_uid),
+	fsparam_gid("gid",		Opt_gid),
+	fsparam_u32oct("umask",		Opt_umask),
+	fsparam_u32oct("dmask",		Opt_dmask),
+	fsparam_u32oct("fmask",		Opt_fmask),
+	fsparam_flag("sys_immutable",	Opt_immutable),
+	fsparam_flag("discard",		Opt_discard),
+	fsparam_flag("force",		Opt_force),
+	fsparam_flag("sparse",		Opt_sparse),
+	fsparam_flag("nohidden",	Opt_nohidden),
+	fsparam_flag("hide_dot_files",	Opt_hide_dot_files),
+	fsparam_flag("windows_names",	Opt_windows_names),
+	fsparam_flag("showmeta",	Opt_showmeta),
+	fsparam_flag("acl",		Opt_acl),
+	fsparam_string("iocharset",	Opt_iocharset),
+	fsparam_flag("prealloc",	Opt_prealloc),
+	fsparam_flag("nocase",		Opt_nocase),
 	{}
 };
 // clang-format on
@@ -345,28 +345,28 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 		opts->fmask = 1;
 		break;
 	case Opt_immutable:
-		opts->sys_immutable = result.negated ? 0 : 1;
+		opts->sys_immutable = 1;
 		break;
 	case Opt_discard:
-		opts->discard = result.negated ? 0 : 1;
+		opts->discard = 1;
 		break;
 	case Opt_force:
-		opts->force = result.negated ? 0 : 1;
+		opts->force = 1;
 		break;
 	case Opt_sparse:
-		opts->sparse = result.negated ? 0 : 1;
+		opts->sparse = 1;
 		break;
 	case Opt_nohidden:
-		opts->nohidden = result.negated ? 1 : 0;
+		opts->nohidden = 1;
 		break;
 	case Opt_hide_dot_files:
-		opts->hide_dot_files = result.negated ? 0 : 1;
+		opts->hide_dot_files = 1;
 		break;
 	case Opt_windows_names:
-		opts->windows_names = result.negated ? 0 : 1;
+		opts->windows_names = 1;
 		break;
 	case Opt_showmeta:
-		opts->showmeta = result.negated ? 0 : 1;
+		opts->showmeta = 1;
 		break;
 	case Opt_acl:
 		if (!result.negated)
@@ -385,10 +385,10 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 		param->string = NULL;
 		break;
 	case Opt_prealloc:
-		opts->prealloc = result.negated ? 0 : 1;
+		opts->prealloc = 1;
 		break;
 	case Opt_nocase:
-		opts->nocase = result.negated ? 1 : 0;
+		opts->nocase = 1;
 		break;
 	default:
 		/* Should not be here unless we forget add case. */
-- 
2.34.1


