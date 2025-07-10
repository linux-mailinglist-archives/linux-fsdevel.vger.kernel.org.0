Return-Path: <linux-fsdevel+bounces-54406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B246AFF638
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 02:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316E1544251
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A814C588;
	Thu, 10 Jul 2025 00:58:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72F72636;
	Thu, 10 Jul 2025 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109119; cv=none; b=WDKopYji/7mW1InflJHpEkTp4a4xkzTT7Phxd2M38fORi3qMPie75U5fAgWbbvWboOZ5ev0UDZwFfnFSp/FGASW5Ozc82T0cV0pe+DL1kwcbWLFLofqKwi3+EmOCIj6l8RmBBmXAsfhI3ZMhZKxwAFXaEqc+vsThpC6wCOhMy7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109119; c=relaxed/simple;
	bh=XZbKtfqPPiCgKWUAMA7ouwhZLt7x2jDpVVWpB+SmN5A=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=W8TJ5CFubTiR/l3KmHo3EFuQOBpBeE7EmP0H6/uXJLddJghT9Mh/XvxdzZzRIKR/qWk3MQxxrTPOBxIZzbSf/VBET9H9mrEsCxODoaxQw8uGSJWVbn2y4NMXbp2R22vC6wbcSRQBAF0EosAjvldQlnMXzpKAYYAyU6cr/chuLGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uZfcO-001H9r-LD;
	Thu, 10 Jul 2025 00:58:34 +0000
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
In-reply-to: <474C8D99-6946-4CFF-A925-157329879DA9@meta.com>
References: <>, <474C8D99-6946-4CFF-A925-157329879DA9@meta.com>
Date: Thu, 10 Jul 2025 10:58:33 +1000
Message-id: <175210911389.2234665.8053137657588792026@noble.neil.brown.name>

On Thu, 10 Jul 2025, Song Liu wrote:
> 
> 
> > On Jul 9, 2025, at 3:24 PM, NeilBrown <neil@brown.name> wrote:
> [...]
> >> 
> >> How should the user handle -ECHILD without LOOKUP_RCU flag? Say the
> >> following code in landlocked:
> >> 
> >> /* Try RCU walk first */
> >> err = vfs_walk_ancestors(path, ll_cb, data, LOOKUP_RCU);
> >> 
> >> if (err == -ECHILD) {
> >> struct path walk_path = *path;
> >> 
> >> /* reset any data changed by the walk */
> >> reset_data(data);
> >> 
> >> /* now do ref-walk */
> >> err = vfs_walk_ancestors(&walk_path, ll_cb, data, 0);
> >> }
> >> 
> >> Or do you mean vfs_walk_ancestors will never return -ECHILD?
> >> Then we need vfs_walk_ancestors to call reset_data logic, right?
> > 
> > It isn't clear to me that vfs_walk_ancestors() needs to return anything.
> > All the communication happens through walk_cb()
> > 
> > walk_cb() is called with a path, the data, and a "may_sleep" flag.
> > If it needs to sleep but may_sleep is not set, it returns "-ECHILD"
> > which causes the walk to restart and use refcounts.
> > If it wants to stop, it returns 0.
> > If it wants to continue, it returns 1.
> > If it wants a reference to the path then it can use (new)
> > vfs_legitimize_path() which might fail.
> > If it wants a reference to the path and may_sleep is true, it can use
> > path_get() which won't fail.
> > 
> > When returning -ECHILD (either because of a need to sleep or because
> > vfs_legitimize_path() fails), walk_cb() would reset_data().
> 
> This might actually work. 
> 
> My only concern is with vfs_legitimize_path. It is probably safer if 
> we only allow taking references with may_sleep==true, so that path_get
> won’t fail. In this case, we will not need walk_cb() to call 
> vfs_legitimize_path. If the user want a reference, the walk_cb will 
> first return -ECHILD, and call path_get when may_sleep is true. 

What is your concern with vfs_legitimize_path() ??

I've since realised that always restarting in response to -ECHILD isn't
necessary and isn't how normal path-walk works.  Restarting might be
needed, but the first response to -ECHILD is to try legitimize_path().
If that succeeds, then it is safe to sleep.
So returning -ECHILD might just result in vfs_walk_ancestors() calling
legitimize_path() and then calling walk_cb() again.  Why not have
walk_cb() do the vfs_legitimize_path() call (which will almost always
succeed in practice).

NeilBrown


> 
> Does this make sense? Did I miss any cases? 
> 
> Thanks,
> Song
> 
> 


