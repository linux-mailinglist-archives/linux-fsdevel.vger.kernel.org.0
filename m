Return-Path: <linux-fsdevel+bounces-56709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2826B1ACA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1BC518A1C5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 03:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE26A1E8322;
	Tue,  5 Aug 2025 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BcgMcsTQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3C1A23B9;
	Tue,  5 Aug 2025 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754363373; cv=none; b=J4o4XQfLoK05MmSC1YGFA2W/MJqBtC3vm18Yk9T8H0xWVA732Lwm5GIzW+OF0aKZn3F12isorIbTTJmt24KXth0maYLQxS8Qy/4r5SNor59LLuAgZiuIaCiqBgZFoCeOPQyDTfBVQHEW2fVwKRNrvoNTTl+dndJIrALiiaem06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754363373; c=relaxed/simple;
	bh=LY/VUiqBCx9iQ9lvHNZ+xNQrDjaq0r1TZBPbRYI/Br0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/Rq6XcO+Eh6sht7IMHwk1bnRW2R3lL5aeFYLdNBGDwlpVChUGQu4sNIK4qiZ9BAGp7z9juW+5PCdqMZo0N5bvxYPMg1edkwMLjuhNTXHmsm/TyNy+qujpnl4pJ6Qium/cLHdldelUpk/zEYtIn8yjNK7YNiiUhbXSkRHljE4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BcgMcsTQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4OxS0Na1+fzCuirl+2tIZhSP5el2IUXZmaUJ4/W74+s=; b=BcgMcsTQUGcoaikeEUPimR4fTp
	SkNpXqoU8cwiJZTbtsJARziq2GxgW+Iqr2RQH+6Liz1cN+AJqRuNogonnEbh07GiQcBCLUvsCzYOF
	VvgAZm12PV5mV5rb1kBrZNPotbB5p2q4U865aq8wYqW5VQBmMvnbYfhplS/wa9pTCCr+XRjutEf/w
	+3gUtQDcDe9XLI1mLMTz7a9c6vEWI87zyjbnxjWwMzF03Vk91lgusPAMiE9d0mBui85eSDMaej0au
	f8euOY0IDjdtfmJx/xJsLssz9mVF1Vw6gwon1RUx1wtqIJs6APGuCC74M1FjaM5mM8NhQie51T42Z
	9M7YgMEQ==;
Received: from [191.204.199.202] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uj83M-009TiJ-Gr; Tue, 05 Aug 2025 05:09:28 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Tue, 05 Aug 2025 00:09:09 -0300
Subject: [PATCH RFC v2 5/8] ovl: Set case-insensitive dentry operations for
 ovl sb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-tonyk-overlayfs-v2-5-0e54281da318@igalia.com>
References: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
In-Reply-To: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

For filesystems with encoding (i.e. with case-insensitive support), set
the dentry operations for the super block with generic_set_sb_d_ops().
Also, use the upper layer encoding as the ovl super block encoding.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/overlayfs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index cfe8010616414a5ec0421b9ac5947596bfd0a5bd..5d55a287a8c0f69aeaf2ada862c59bd7eb7b10f2 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1423,6 +1423,16 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 
 		sb->s_stack_depth = upper_sb->s_stack_depth;
 		sb->s_time_gran = upper_sb->s_time_gran;
+
+#if IS_ENABLED(CONFIG_UNICODE)
+		if (sb_has_encoding(upper_sb)) {
+			sb->s_encoding = upper_sb->s_encoding;
+			sb->s_encoding_flags = upper_sb->s_encoding_flags;
+		}
+
+		generic_set_sb_d_ops(sb);
+#endif
+
 	}
 	oe = ovl_get_lowerstack(sb, ctx, ofs, layers);
 	err = PTR_ERR(oe);

-- 
2.50.1


