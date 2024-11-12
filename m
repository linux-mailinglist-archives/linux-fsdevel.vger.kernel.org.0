Return-Path: <linux-fsdevel+bounces-34555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F729C639F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA212851CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB3219C94;
	Tue, 12 Nov 2024 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ttfkYLb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32343AA1;
	Tue, 12 Nov 2024 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447678; cv=none; b=sA01W7hwMOdU1kFvyLtvnwxKAlAw9ZO++B48SoLDo9C9Y5mXP3WFLACeCC+V8d+N/LOe7CTkCaTbK/JFUaiMfoOtZxbWiJ9fHqhrATa+quUFDGbT97Zf1tlO9qA0CePDaROVmHuIbeRKoyDmY5TgtnM8bm3BWyunIvqPxIMs/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447678; c=relaxed/simple;
	bh=5fZUwKytbsAmkLDw9NSkYklLMjXoT6wxH2W2j56gfdI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pevUL/LDYRwVg4R0vmtpbFVfBCWXH5gGWyulKGWHPqdGVEOl4XC4A++0cV5hpiLcG6qnhqIqfIH+Vusr3mQVv9soiu7seCyfsqMbyAy9eZmgkrrZjLlMoT1iR1lJi0DxYv+cV/7Un1LwPY2zc7xDmeK2wbxJ0C7IVMDUEVxsNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ttfkYLb6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UODY4oFrGh0OPJEw/PnXTIR6ukiA1LQMYg8Lcody64Q=; b=ttfkYLb6SHLLj+BNRKaL2I1veG
	sO25rhx32NEMy97NaUcIY/5U3zco0Nx7iaOA74IaXjFTIsYZpcg0EaTF6CfNQ3X3S3o6wX2Qy0DTv
	xmBHz8M65posAgRS+5uedSk3PtzMjYxaRhA1o+02v+36CeXghPDlaCuE7vi1XfhTqWncLT/yMrybq
	Thq8dUPyDkTbvtaRBJ1CL9vZK1oSB/P6VO49+w0Dt4Q9H22KZA7ltKiE1OdzgVD4wYaBFc/vx8WCM
	zIDDmmAtFwHCVT/Y2ZQ+1FXKkKBHRhK9UbPe0jooJnI8wslVLNeLIWtjkPK5IQk7zDTGVT1B2TmjH
	gUpdOnQA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAydO-0000000EFjd-24Dr;
	Tue, 12 Nov 2024 21:41:14 +0000
Date: Tue, 12 Nov 2024 21:41:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Subject: [PATCH] fs/overlayfs/namei.c: get rid of include ../internal.h
Message-ID: <20241112214114.GD3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Added for the sake of vfs_path_lookup(), which is in linux/namei.h
these days.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 5764f91d283e..527837358e3a 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -14,8 +14,6 @@
 #include <linux/exportfs.h>
 #include "overlayfs.h"
 
-#include "../internal.h"	/* for vfs_path_lookup */
-
 struct ovl_lookup_data {
 	struct super_block *sb;
 	const struct ovl_layer *layer;
-- 
2.39.5


