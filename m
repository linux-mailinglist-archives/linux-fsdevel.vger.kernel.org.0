Return-Path: <linux-fsdevel+bounces-57809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6DAB256CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD555C1777
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662E2F3C1B;
	Wed, 13 Aug 2025 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="G2vsXMgx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993343002B3;
	Wed, 13 Aug 2025 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124668; cv=none; b=KjkdzI3MDRJ6FPPzNDdvRXVx2TZ50+tKQFjHUbd91z5wogigxbM7kwhSP9niaspddNJX2O5zXXMG+13vQTXP2CkfS1bbwFAD6gl80KcxBpV/ILWu6W0jy+6PAvzPoG7SdkMCBfRMy2MKGFAqcMAdrJht/iS7/K7WDYFOKgdYRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124668; c=relaxed/simple;
	bh=QHij3AaEqB5Gm/MJ+xxCWHvXRMF3eJjlbymbW1o6oL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eW+aC6irjlY7tNX4onOvDFS4cvkSg4NmTIAWBENqvvHBRNCNB3lCda5o0BQYRgOs5v3v3HzdXAUQ+3IBeFiGHDgUEW8dm18gjUzhuNStwlPyRgOrfSrxp/40JsrrBSJwfoguzqNrNrDkyVVW234cG2tsbvWmO1LGStk+ikrBnVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=G2vsXMgx; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T/YfUC/mXfWI3UBte6AV9vZQ18fOmpiqBAEfdLjA9sg=; b=G2vsXMgxepdjvoBJinbWly9da5
	IhbatT2/vAZCAlBve6NTHwurStWBEtwwQsBOTomsak87uy42C4QTkPY9rLN9DCIBDlXbIm2kAqWLb
	gnC6GxqHYC/kj0zeYKpprNtnp/I3vRGE25QgyhMT6fFZI2xqUCgsZZsN8wSfbkA0tVhNYzJHTa6ZE
	Nl7RR0epGCqLc1w+9XESQeYln6/lFmfWXqFKNcO7LBGsp6Iqv9jdAx55k8oFVfXaqELw/AqFPxTB/
	Spb66QaRCzTcbF2iXmU7WExz8e+UtdjiE4FOPjvESPiA93dqZrSRChMKlOpzEe5B72U+458OuJOZL
	4KJP+R1g==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umK6H-00Ds0c-Mz; Thu, 14 Aug 2025 00:37:41 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 13 Aug 2025 19:36:44 -0300
Subject: [PATCH v4 8/9] ovl: Check for casefold consistency when creating
 new dentries
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250813-tonyk-overlayfs-v4-8-357ccf2e12ad@igalia.com>
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

In a overlayfs with casefold enabled, all new dentries should have
casefold enabled as well. Check this at ovl_create_real()

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v3:
- New patch
---
 fs/overlayfs/dir.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 70b8687dc45e8e33079c865ae302ac58464224a6..be8c5d02302de7a3ee63220a69f99a808fde3128 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -187,6 +187,11 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
 			/* mkdir is special... */
 			newdentry =  ovl_do_mkdir(ofs, dir, newdentry, attr->mode);
 			err = PTR_ERR_OR_ZERO(newdentry);
+			/* expect to inherit casefolding from workdir/upperdir */
+			if (!err && ofs->casefold != ovl_dentry_casefolded(newdentry)) {
+				dput(newdentry);
+				err = -EINVAL;
+			}
 			break;
 
 		case S_IFCHR:

-- 
2.50.1


