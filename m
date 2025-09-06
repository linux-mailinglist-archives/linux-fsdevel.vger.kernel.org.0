Return-Path: <linux-fsdevel+bounces-60422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD02B46A8B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FCAA625D1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10752BE05B;
	Sat,  6 Sep 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dax1ZgTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B47C287257
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149902; cv=none; b=LuSGVZPNio0rUjOqiOyqPs9oGUH0jMmAGGM4scOFP/V6HnbyiyjpqwjfOfljhLsDFJg7vP5pvV2zQUkV8k9oFaaorEwjw6/Fh38jN1sXlFRvPEJ9N5o+Ljo0N/USQnabQCQmJ5etQ/s1Xo+H2zSl/8PqJtKQQxDybBNu2uHsOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149902; c=relaxed/simple;
	bh=VuPBd01FByqwsSzQlaoEZnURgpIJvsBQ/xI/IizyDWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0t71Mk5eL4alGyD8fTw86m2yOJLZLdc5OcVSHwMGN9O/698w85X64ctJ56afdcM3SUJYA2Wy3l+MsmCT2zMfy8njZlfHaAIyaGxbNEGLWtTCEKFAxRa+KO7SlJaImDMhA6kF3oxvFGyoPv5K0YJrL0g7TBmu3ANEhXKGbgGhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dax1ZgTz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=h7XvpzPXpfca89exOlHyLkb0uMMEO/72nI17ihUB0Hs=; b=dax1ZgTz3/M0zepSKp2Mg/E49L
	KaGJYDN0jpF8J2I7I7ni32pYYDGNkp98ZdVXHpwZnnMm2hWn45SobPGbzWG3m761xzjc4cxW/o39F
	1BEluipdx3cuf7NCumpsNfa2wBV2wo8WlIdyaJOglvoMtpwcdSwK/NyrAvWO+wjuDDRc08q82y56B
	/pnkhJM3kYAdvnMKL7jg9l8P9CquQrtcXpOJQURwxYe1rYfpJStw/jdKBVeZd0KNj4/Um1Hqxq48h
	4+GhfV/qYLnOZV0UhcaHZTo6G0bxZzBve4iHTPRnf+fK/hVFYi89VsO7FEVda82yrKCnNXe/ATA2V
	1j7ZGzQA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxO-00000000OsC-3wdw;
	Sat, 06 Sep 2025 09:11:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 07/21] rqst_exp_get_by_name(): constify path argument
Date: Sat,  6 Sep 2025 10:11:23 +0100
Message-ID: <20250906091137.95554-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/export.c | 2 +-
 fs/nfsd/export.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index cadfc2bae60e..dffb24758f60 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1181,7 +1181,7 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
  * use exp_get_by_name() or exp_find().
  */
 struct svc_export *
-rqst_exp_get_by_name(struct svc_rqst *rqstp, struct path *path)
+rqst_exp_get_by_name(struct svc_rqst *rqstp, const struct path *path)
 {
 	struct svc_export *gssexp, *exp = ERR_PTR(-ENOENT);
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index b9c0adb3ce09..cb36e6cce829 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -111,7 +111,7 @@ int			nfsd_export_init(struct net *);
 void			nfsd_export_shutdown(struct net *);
 void			nfsd_export_flush(struct net *);
 struct svc_export *	rqst_exp_get_by_name(struct svc_rqst *,
-					     struct path *);
+					     const struct path *);
 struct svc_export *	rqst_exp_parent(struct svc_rqst *,
 					struct path *);
 struct svc_export *	rqst_find_fsidzero_export(struct svc_rqst *);
-- 
2.47.2


