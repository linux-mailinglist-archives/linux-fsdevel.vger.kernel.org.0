Return-Path: <linux-fsdevel+bounces-42020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E0A3ACE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 00:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3199B7A609F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 23:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A151DE3AF;
	Tue, 18 Feb 2025 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V8zhOo3P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892B17A308;
	Tue, 18 Feb 2025 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922772; cv=none; b=OfxDGsZe1fr7AXaUnFxNkt66rEhQjrqU0Wk+l5Em7txgRrzwHxtdbBcktp8SKfg99JqeUI1vikOM0fa6vaWZb8CK9OGnI0FXMqm244wQLYODEqLxm7N/b1Gzgdp77n+9exytqaVwdGGqf3gWOF7YSnBA01DJRKRnU243T9nCRvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922772; c=relaxed/simple;
	bh=GkOmTamKZFz1yM++5iZCqVCojGOHtb+PWZ8HE/wb53o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS3TdcnnDJG8zQNjrUb7jW8T2xLHPFXHkslFnvYUedv8EOgYuwbZLI30rfyZTPnZ1DaxXb9oTjFOH/JRrDOWlg8KHhyRT15UdYvZc2Bersxhl6pEPUPPxadfvEe+3Z9tJ7naGx/ujSWyzvuqn00w9h69TBCaIqsGEsQrpKc47W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V8zhOo3P; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ltgy3La3BgPp7+U5F31r+gFzeGWv0iasamXiuEAjUcc=; b=V8zhOo3PoEyXL7MHNmwtiRcHpM
	14sJAebQThu+bKnRIZUHTF+re52y2IkoD/67NdFxBYA8Bl+S/NeQW3stD5ihPMmYbmFMjsZntqSYW
	McLpdU1nB/EPPmwycH320LKEMZprz2F9tDlplk4bmj4l5wNFnDmZOomrwasE85qzFlxZ5SaGJ26SK
	6jQhjA99oUU70vWXdDe3OK2wyT5rAc7uhMy0yDdhIle+T7Ds3BBIxUu42RVX8DE+eHEiHYYR2HYuN
	KBV54zoRyOVZGG4lxOe4FVUExw9j75Y+IB/T55/HmR/JJzzfMiSb9p1mxFqf7eYSMcKpOa1lCcRRw
	w4BEhMMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkXOQ-00000000nqA-0aAz;
	Tue, 18 Feb 2025 23:52:46 +0000
Date: Tue, 18 Feb 2025 23:52:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "luis@igalia.com" <luis@igalia.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] odd check in ceph_encode_encrypted_dname()
Message-ID: <20250218235246.GA191109@ZenIV>
References: <20250214024756.GY1977892@ZenIV>
 <20250214032820.GZ1977892@ZenIV>
 <bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
 <87frkg7bqh.fsf@igalia.com>
 <20250215044616.GF1977892@ZenIV>
 <877c5rxlng.fsf@igalia.com>
 <4ac938a32997798a0b76189b33d6e4d65c23a32f.camel@ibm.com>
 <87cyfgwgok.fsf@igalia.com>
 <2e026bd7688e95440771b7ad4b44b57ab82535f6.camel@ibm.com>
 <20250218012132.GJ1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218012132.GJ1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 18, 2025 at 01:21:32AM +0000, Al Viro wrote:

> See the problem?  strrchr() expects a NUL-terminated string; giving it an
> array that has no zero bytes in it is an UB.
> 
> That one is -stable fodder on its own, IMO...

FWIW, it's more unpleasant; there are other call chains for parse_longname()
where it's not feasible to NUL-terminate in place.  I suspect that the
patch below is a better way to handle that.  Comments?

From ed016e5ea89550b567306207ba3ca8b60e147d89 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 18 Feb 2025 17:57:17 -0500
Subject: [PATCH 1/3] [ceph] parse_longname(): strrchr() expects NUL-terminated
 string

... and parse_longname() is not guaranteed that.  That's the reason
why it uses kmemdup_nul() to build the argument for kstrtou64();
the problem is, kstrtou64() is not the only thing that need it.

Just get a NUL-terminated copy of the entire thing and be done
with that...

Fixes: dd66df0053ef "ceph: add support for encrypted snapshot names"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/crypto.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 3b3c4d8d401e..164e7981aecb 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -215,35 +215,30 @@ static struct inode *parse_longname(const struct inode *parent,
 	struct ceph_client *cl = ceph_inode_to_client(parent);
 	struct inode *dir = NULL;
 	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
-	char *inode_number;
 	char *name_end;
-	int orig_len = *name_len;
 	int ret = -EIO;
-
+	/* NUL-terminate */
+	char *s __free(kfree) = kmemdup_nul(name, *name_len, GFP_KERNEL);
+	if (!s)
+		return ERR_PTR(-ENOMEM);
 	/* Skip initial '_' */
-	name++;
-	name_end = strrchr(name, '_');
+	s++;
+	name_end = strrchr(s, '_');
 	if (!name_end) {
-		doutc(cl, "failed to parse long snapshot name: %s\n", name);
+		doutc(cl, "failed to parse long snapshot name: %s\n", s);
 		return ERR_PTR(-EIO);
 	}
-	*name_len = (name_end - name);
+	*name_len = (name_end - s);
 	if (*name_len <= 0) {
 		pr_err_client(cl, "failed to parse long snapshot name\n");
 		return ERR_PTR(-EIO);
 	}
 
 	/* Get the inode number */
-	inode_number = kmemdup_nul(name_end + 1,
-				   orig_len - *name_len - 2,
-				   GFP_KERNEL);
-	if (!inode_number)
-		return ERR_PTR(-ENOMEM);
-	ret = kstrtou64(inode_number, 10, &vino.ino);
+	ret = kstrtou64(name_end + 1, 10, &vino.ino);
 	if (ret) {
-		doutc(cl, "failed to parse inode number: %s\n", name);
-		dir = ERR_PTR(ret);
-		goto out;
+		doutc(cl, "failed to parse inode number: %s\n", s);
+		return ERR_PTR(ret);
 	}
 
 	/* And finally the inode */
@@ -252,11 +247,8 @@ static struct inode *parse_longname(const struct inode *parent,
 		/* This can happen if we're not mounting cephfs on the root */
 		dir = ceph_get_inode(parent->i_sb, vino, NULL);
 		if (IS_ERR(dir))
-			doutc(cl, "can't find inode %s (%s)\n", inode_number, name);
+			doutc(cl, "can't find inode %s (%s)\n", name_end + 1, name);
 	}
-
-out:
-	kfree(inode_number);
 	return dir;
 }
 
-- 
2.39.5


