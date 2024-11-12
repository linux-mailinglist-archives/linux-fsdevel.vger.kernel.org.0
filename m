Return-Path: <linux-fsdevel+bounces-34553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDBD9C6406
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 23:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D13AB33932
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE0321A4C8;
	Tue, 12 Nov 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QULZpPQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C720C460;
	Tue, 12 Nov 2024 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447331; cv=none; b=hIjg7Ed2dUugg0BMY9e38fQSU6u152wPBHUSPgTrjm15CHhtAw1+ko22e5sBCYL3aEdhgNDWY4ijefiVzE42Wtn46eW46HiQK0P3GH67h5TjATFAVOdDj4OSnqPgAZuvBwZk5+f3++KYZHVNhhet3ZFYVy6nG/ZI+UaQ3on3Gcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447331; c=relaxed/simple;
	bh=T+jMI6+eAbrAo+uy7XLNAisi2jYzNP+6eAI9rthHNJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JWJo15pIGROl8VmtbqBJcpwwLZ1AG5mNIKgg8/csgBtPZxbfMiKFVgwV0GlIJgNvW4wMH4GBbxvwauh5Tord+Zx+zbSLI0nlm8EpxnZnqdw+ydp47fTwa/eTG8xLMR84Jji9kQfFz2GaZ2xbdy/rUUaMIAHYChjL/sgHpqkWet4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QULZpPQM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EGYcJKWF9kLJOyRbrp+CVIxufIHX8fsp0Gk+GWXeJ/Q=; b=QULZpPQMQ7NbzSMf2TV+ZsNKz/
	waWZuAQOFljDua3zuUxEwnAk6E/E8hFBlec04DhOcvc/OiMG6yvqmqs1smY0qm8uI9Fww8UmVlpzN
	l3Hmx/3j6t+6taA2/rMzxVeJpp81nuJGrg2t4EIsXGf+YhBS75502htQM6Zs9Evokh24XVLuQ1EWX
	JKrNTsg8/cGrJlD1Uwl23fDSAN94cSTvT0X2IM92gImcS0HbRt/i2qU/2BDLv+ytMsHzjAUK/LcwP
	twKogIO5ZgabCLtDHiKOtAWUKMyrV/MeK+a2FD95UdGI/FQlg4D0UQ001i/UDlZYwntUxJQ1tyEN9
	egjwDD1g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAyXk-0000000EFeP-49mE;
	Tue, 12 Nov 2024 21:35:25 +0000
Date: Tue, 12 Nov 2024 21:35:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] nfsd: get rid of include ../internal.h
Message-ID: <20241112213524.GB3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

added back in 2015 for the sake of vfs_clone_file_range(),
which is in linux/fs.h these days

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
[I don't care which tree does that go in - if nfs folks pick it, great,
if not - viro/vfs.git#work.misc or vfs/vfs.git#vfs.misc would do just
fine]
 fs/nfsd/vfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 22325b590e17..f59c8ada322b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -35,7 +35,6 @@
 #include "xdr3.h"
 
 #ifdef CONFIG_NFSD_V4
-#include "../internal.h"
 #include "acl.h"
 #include "idmap.h"
 #include "xdr4.h"
-- 
2.39.5


