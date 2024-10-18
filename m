Return-Path: <linux-fsdevel+bounces-32366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B949A442A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 18:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175341F23BB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2422038A3;
	Fri, 18 Oct 2024 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="U3A4YHBz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99AB201273
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270324; cv=none; b=H88iDY+33rTH/I5e4lhau/F3UeffPf7Fo/zunqAyF/aO9ScBlncoZEBkqyniPOff+tqyXB68QGJPKZ6Bbbr1jr3LTcuWvxRchPkMtnNtKgnbGbMYGQKvgz2ZvixX4Ffj/Ki15lQ3cBkAQQRWS4uwHysYkxneU+vQCDPXh5DEpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270324; c=relaxed/simple;
	bh=IJb6VdQrpFUrYHQ6Xihi7A1aVyq46m1HFQrrMy/uueA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifO6OJxmxaBz07zT4sWvbkA/BwZEs95wlA3g5MqdVa+dx7fYJnDX5GmmEpgUscSYNm3tB3+VrF9rC47Chpy6ddIPWa+non6qIFP44ymv/BqRM7978XfkxMDdYtNWrGFGXNtHXY3aLyaCSdBi6zhx9/lbmBKGBckHH3YDelvAZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=U3A4YHBz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HdSulM3JfAcBAO411JA1kX/hplxSLw3D/pWpMvw9kKM=; b=U3A4YHBzzhTmtLhgvTRP95UAdo
	IgIGp+bDn28NBrbXSstacx9vICtJupM3wwaTbd8UkTDA0V1tBQNa97nd9RoGBnZDh1PHsrN+DP/Nc
	UEP/tIigLlG5xYpI7UBkcme1AtXxO0Gkdy7POaHqEOr48YDuI1fUdgG8ua2zqH3+XepTdMUkvfu0K
	MU50xcw6lbmI/ErlQz8KDgKHscKQNYk8OAfyhtv4qhiDEaFdLA0iv1y39kFtS7jSMpQHKpiqeQ/aa
	qYcPNetiC+Ldlfcc2M0vmHujx3ColBpr3rd4TTT0J7gMfyxwht40nzUFSPtJjnoE/D/jd/18HFoqm
	qOJ+q6sQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1qCk-000000056qF-1WlL;
	Fri, 18 Oct 2024 16:51:58 +0000
Date: Fri, 18 Oct 2024 17:51:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241018165158.GA1172273@ZenIV>
References: <20241009040316.GY4017910@ZenIV>
 <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-stadien-einweichen-32632029871a@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 18, 2024 at 01:06:12PM +0200, Christian Brauner wrote:
> > Look: all it takes is the following trick
> > 	* add const char *pathname to struct nameidata
> > 	* in __set_nameidata() add
> >         p->pathname = likely(name) ? name->name : "";
> > 	* in path_init() replace
> > 	const char *s = nd->name->name;
> > with
> > 	const char *s = nd->pathname;
> > and we are done.  Oh, and teach putname() to treat NULL as no-op.
> 
> I know, that's what I suggested to Linus initially but he NAKed it
> because he didn't want the extra cycles.

Extra cycles where?  If anything, I'd expect a too-small-to-measure
speedup due to dereference shifted from path_init() to __set_nameidata().
Below is literally all it takes to make filename_lookup() treat NULL
as empty-string name.

NOTE: I'm not talking about forcing the pure by-descriptor case through
the dfd+pathname codepath; not without serious profiling.  But treating
AT_FDCWD + NULL by the delta below and passing NULL struct filename to
filename_lookup()?  Where do you expect to have the lost cycles on that?

diff --git a/fs/namei.c b/fs/namei.c
index 4a4a22a08ac2..fc2053877e5c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -264,7 +264,7 @@ EXPORT_SYMBOL(getname_kernel);
 
 void putname(struct filename *name)
 {
-	if (IS_ERR(name))
+	if (IS_ERR_OR_NULL(name))
 		return;
 
 	if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
@@ -588,6 +588,7 @@ struct nameidata {
 		unsigned seq;
 	} *stack, internal[EMBEDDED_LEVELS];
 	struct filename	*name;
+	const char *pathname;
 	struct nameidata *saved;
 	unsigned	root_seq;
 	int		dfd;
@@ -606,6 +607,7 @@ static void __set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 	p->depth = 0;
 	p->dfd = dfd;
 	p->name = name;
+	p->pathname = likely(name) ? name->name : "";
 	p->path.mnt = NULL;
 	p->path.dentry = NULL;
 	p->total_link_count = old ? old->total_link_count : 0;
@@ -2439,7 +2441,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 static const char *path_init(struct nameidata *nd, unsigned flags)
 {
 	int error;
-	const char *s = nd->name->name;
+	const char *s = nd->pathname;
 
 	/* LOOKUP_CACHED requires RCU, ask caller to retry */
 	if ((flags & (LOOKUP_RCU | LOOKUP_CACHED)) == LOOKUP_CACHED)

