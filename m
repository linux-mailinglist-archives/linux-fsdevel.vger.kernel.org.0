Return-Path: <linux-fsdevel+bounces-60434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 694C6B46A94
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599E4188EE07
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BC3283FF7;
	Sat,  6 Sep 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="munASuBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC4929B8E6
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149904; cv=none; b=if/roEc1Wii5fFVYluS70OJVZVmpDlVmEVZ7FdYSzsxnljGU5DHLqTfVm4Da8QC4HhAj1FqpbExyBaDBB61WDfd+Y/fnomlKjOucQTyM1CIy+anbOwV3cFNJeC8fVS1ln6A0LtGE0O9AKrJwRJqw6d31wiQXOlHGQS+FcT5Iv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149904; c=relaxed/simple;
	bh=OcU5ITTaswkP7rAvhxXg9KVxpjfLtJ7ZBR7oNlf99+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuS740Y/UXkqepF8Fa0BSI+NO62DuLuWr0gur6qw8ewJMkbgw3JsEB/gdDAedYpKCaUrH2HFMCsmukWWCLxLIBBtwXl5jIUiBBQ63pe1in8C9WAybmAJFiAptMxtU6yh4kIOENphczuUniHHDJq2HZfTWySIv+x7phzD3VHFY8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=munASuBU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GqFDFOPDQppc9tqF24fiGjrZ0SSid6aQC75XRsTqMOo=; b=munASuBU7z0feyl6w0SurdAqmO
	lCpVVaA2Jqt+1+9arRZnOPIsh7FgF/Hrer6TSx5tLWs33IMafI1ek4pEqkqsJi8AW38LeqGmO+Ddi
	dknzixgeGGfAy9iJfJQeKDgc+HK2PPxdwTvbCVE/B2doAx9izNmta6Hysc81Ugu6o/t/wJSyhYZ7H
	wWAnD4SLjed6csM/pE39I9egBkcBKoB8ai/ElCKN/DBz9yxLlvL5TT+kBpFdNgjy3UmVnwC6gu6Ho
	fyNYoiDGl2aZ2ESk76caXcXRyjN7AcmEYUAZG+yLQrqwGPENuaxEqpkBESOJQ9D08v2z8meuxOXxl
	5srHh6RQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxQ-00000000Oua-2tpR;
	Sat, 06 Sep 2025 09:11:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 17/21] ovl_lower_dir(): constify path argument
Date: Sat,  6 Sep 2025 10:11:33 +0100
Message-ID: <20250906091137.95554-17-viro@zeniv.linux.org.uk>
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
 fs/overlayfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index df85a76597e9..e3d0e86bb7c4 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -394,7 +394,7 @@ static int ovl_check_namelen(const struct path *path, struct ovl_fs *ofs,
 	return err;
 }
 
-static int ovl_lower_dir(const char *name, struct path *path,
+static int ovl_lower_dir(const char *name, const struct path *path,
 			 struct ovl_fs *ofs, int *stack_depth)
 {
 	int fh_type;
-- 
2.47.2


