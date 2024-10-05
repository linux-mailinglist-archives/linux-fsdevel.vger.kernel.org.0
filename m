Return-Path: <linux-fsdevel+bounces-31062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6DF99180C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1797C1C2123B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9472156C74;
	Sat,  5 Oct 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="r0yKtELM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC215444E
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144215; cv=none; b=Qewgh+b9SbxFRXbk93SNyp5nzis7IJDx/ehxf62Afmzh7ChALaDhM6P8bTI8uVmxVpeYg6h1ZG3Y1T266sOQm2YV4m0BOa/kih0ZqI5Q588at8dWkzMR6NXd/xwgToAJa1NVTYyg+ludjP0O1NPJCFAaYkJvvx/3M9r5WTsis44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144215; c=relaxed/simple;
	bh=K7O/IKTj7JAMERpvVB67YoFT1tQi7t3qQXWQjya8WlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux2uWNaLKghXNJNbEk0nsdzZ8VnniF/pKRavZBuZIIaGLTsxj2rXdjbeVI2/yDMVP22+cZtBxq5K9lbLhvBl5aXrLQAudCzR1d8roqi0/irSUJwe/0kwYPCoJbrbJt5TRPo16qDP5XQdVlB/FR0sqWyQZa20Z2hlbl/TU1aZE+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=r0yKtELM; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XLVZL4w5fzKsf;
	Sat,  5 Oct 2024 18:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728144202;
	bh=/46zxzMRhFBNtUJv6VsdBeWbXBpEeOG8UcnJk197lAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0yKtELM42JYTUJHwjJVGNIObv/XXq/xn76mfKNMKw/7gdEw6mspsa0b6BKLhb9rS
	 mWRmC7jxob/xQSv6N/3wqhdaj197blHI0ym8O/lvVFimxJcsUFNryymB80w9k8Eimg
	 /JDZZiYJ+Do4jh08pFEqM+oL6U6ne1J2XNL4N710=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XLVZK4W6tzN2w;
	Sat,  5 Oct 2024 18:03:21 +0200 (CEST)
Date: Sat, 5 Oct 2024 18:03:19 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev, torvalds@linux-foundation.org, 
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, 
	Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241005.euDithie4Ue0@digikod.net>
References: <Zv6J34fwj3vNOrIH@infradead.org>
 <20241003122657.mrqwyc5tzeggrzbt@quack3>
 <Zv6Qe-9O44g6qnSu@infradead.org>
 <20241003125650.jtkqezmtnzfoysb2@quack3>
 <Zv6jV40xKIJYuePA@dread.disaster.area>
 <20241003161731.kwveypqzu4bivesv@quack3>
 <Zv8648YMT10TMXSL@dread.disaster.area>
 <20241004-abgemacht-amortisieren-9d54cca35cab@brauner>
 <ZwBy3H/nR626eXSL@dread.disaster.area>
 <20241005.phah4Yeiz4oo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241005.phah4Yeiz4oo@digikod.net>
X-Infomaniak-Routing: alpha

On Sat, Oct 05, 2024 at 05:21:30PM +0200, Mickaël Salaün wrote:
> On Sat, Oct 05, 2024 at 08:57:32AM +1000, Dave Chinner wrote:

> > Actually, it's not as bad as I thought it was going to be. I've
> > already moved both fsnotify and LSM inode eviction to
> > evict_inodes() as preparatory patches...
> 
> Good, please Cc me and Günther on related patch series.
> 
> FYI, we have the two release_inodes tests to check this hook in
> tools/testing/selftests/landlock/fs_test.c
> 
> > 
> > Dave Chinner (2):
> >       vfs: move fsnotify inode eviction to evict_inodes()
> >       vfs, lsm: rework lsm inode eviction at unmount
> > 
> >  fs/inode.c                    |  52 +++++++++++++---
> >  fs/notify/fsnotify.c          |  60 -------------------
> >  fs/super.c                    |   8 +--
> >  include/linux/lsm_hook_defs.h |   2 +-
> >  include/linux/security.h      |   2 +-
> >  security/landlock/fs.c        | 134 ++++++++++--------------------------------

Please run clang-format -i security/landlock/fs.c

> >  security/security.c           |  31 ++++++----
> > 7 files changed, 99 insertions(+), 190 deletions(-)
> > 
> > -Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> > 

