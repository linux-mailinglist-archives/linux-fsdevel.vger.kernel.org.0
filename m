Return-Path: <linux-fsdevel+bounces-54400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB30AFF4A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7542F64520F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37072459F8;
	Wed,  9 Jul 2025 22:24:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C04242D76;
	Wed,  9 Jul 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099860; cv=none; b=tDS/CysrFgGLqjG5HiSN5WBtC9eZrHnYfK7Ax6OeTi0smK0to4OltcR9YKywYITP0aePVqfijLLnt63GNV1+yEMrMej6+GRvVBlajiTXOpcnkBNDhe0E2qpnggj74bfN9XtjDp1izKo4J1poFxborvk7UY1bjnP02ultVIeHg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099860; c=relaxed/simple;
	bh=CbHFJShFE8DpTC/MzdtDKAEYS5cu2PsOLLa0V3B56V4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JBGDSquBvGiOmtEPrVuzDpdZ1fFH1Aar2bEvipFA9Lf2ZRpuwHgstHQKACmd/YGhA0885J4+7zSe71f62Hz1+Rw+XxxC+RgsYt37CDasVvAcBIxl8lce0c7MpNzPcbQMKxbIxUEPW1p99mlKPGfSbjOpwpbONioDKPGcgSxUMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uZdD3-001GGv-Iu;
	Wed, 09 Jul 2025 22:24:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Song Liu" <songliubraving@meta.com>
Cc: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 "Christian Brauner" <brauner@kernel.org>, "Tingmao Wang" <m@maowtm.org>,
 "Song Liu" <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "Kernel Team" <kernel-team@meta.com>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>,
 =?utf-8?q?G=C3=BCnther?= Noack <gnoack@google.com>,
 "Jann Horn" <jannh@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
In-reply-to: <C8FA6AFF-704B-4F8D-AE88-68E6046FBE01@meta.com>
References: <>, <C8FA6AFF-704B-4F8D-AE88-68E6046FBE01@meta.com>
Date: Thu, 10 Jul 2025 08:24:14 +1000
Message-id: <175209985487.2234665.6008354090530669455@noble.neil.brown.name>

On Thu, 10 Jul 2025, Song Liu wrote:
> 
> 
> > On Jul 9, 2025, at 9:06 AM, Mickaël Salaün <mic@digikod.net> wrote:\
> 
> [...]
> 
> >> If necessary, we hide “root" inside @data. This is good. 
> >> 
> >>> @path would be updated with latest ancestor path (e.g. @root).
> >> 
> >> Update @path to the last ancestor and hold proper references. 
> >> I missed this part earlier. With this feature, vfs_walk_ancestors 
> >> should work usable with open-codeed bpf path iterator. 
> >> 
> >> I have a question about this behavior with RCU walk. IIUC, RCU 
> >> walk does not hold reference to @ancestor when calling walk_cb().
> > 
> > I think a reference to the mount should be held, but not necessarily to
> > the dentry if we are still in the same mount as the original path.
> 
> If we update @path and do path_put() after the walk, we have to hold 
> reference to both the mnt and the dentry, no? 
> 
> > 
> >> If walk_cb() returns false, shall vfs_walk_ancestors() then
> >> grab a reference on @ancestor? This feels a bit weird to me.
> > 
> > If walk_cb() checks for a root, it will return false when the path will
> > match, and the caller would expect to get this root path, right?
> 
> If the user want to walk to the global root, walk_cb() may not 
> return false at all, IIUC. walk_cb() may also return false on 
> other conditions. 
> 
> > 
> > In general, it's safer to always have the same behavior when holding or
> > releasing a reference.  I think the caller should then always call
> > path_put() after vfs_walk_ancestors() whatever the return code is.
> > 
> >> Maybe “updating @path to the last ancestor” should only apply to
> >> LOOKUP_RCU==false case? 
> >> 
> >>> @flags could contain LOOKUP_RCU or not, which enables us to have
> >>> walk_cb() not-RCU compatible.
> >>> 
> >>> When passing LOOKUP_RCU, if the first call to vfs_walk_ancestors()
> >>> failed with -ECHILD, the caller can restart the walk by calling
> >>> vfs_walk_ancestors() again but without LOOKUP_RCU.
> >> 
> >> 
> >> Given we want callers to handle -ECHILD and call vfs_walk_ancestors
> >> again without LOOKUP_RCU, I think we should keep @path not changed
> >> With LOOKUP_RCU==true, and only update it to the last ancestor 
> >> when LOOKUP_RCU==false.
> > 
> > As Neil said, we don't want to explicitly pass LOOKUP_RCU as a public
> > flag.  Instead, walk_cb() should never sleep (and then potentially be
> > called under RCU by the vfs_walk_ancestors() implementation).
> 
> How should the user handle -ECHILD without LOOKUP_RCU flag? Say the
> following code in landlocked:
> 
> /* Try RCU walk first */
> err = vfs_walk_ancestors(path, ll_cb, data, LOOKUP_RCU);
> 
> if (err == -ECHILD) {
> 	struct path walk_path = *path;
> 
> 	/* reset any data changed by the walk */
> 	reset_data(data);
> 	
> 	/* now do ref-walk */
> 	err = vfs_walk_ancestors(&walk_path, ll_cb, data, 0);
> }
> 
> Or do you mean vfs_walk_ancestors will never return -ECHILD?
> Then we need vfs_walk_ancestors to call reset_data logic, right?

It isn't clear to me that vfs_walk_ancestors() needs to return anything.
All the communication happens through walk_cb()

walk_cb() is called with a path, the data, and a "may_sleep" flag.
If it needs to sleep but may_sleep is not set, it returns "-ECHILD"
which causes the walk to restart and use refcounts.
If it wants to stop, it returns 0.
If it wants to continue, it returns 1.
If it wants a reference to the path then it can use (new)
vfs_legitimize_path() which might fail.
If it wants a reference to the path and may_sleep is true, it can use
path_get() which won't fail.

When returning -ECHILD (either because of a need to sleep or because
vfs_legitimize_path() fails), walk_cb() would reset_data().

NeilBrown

