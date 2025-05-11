Return-Path: <linux-fsdevel+bounces-48685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB30AB2A12
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 19:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EB3188B0E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0CD25D534;
	Sun, 11 May 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fp8KPFDU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40461885B8;
	Sun, 11 May 2025 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746985327; cv=none; b=PXMQZfR5+RQGv4KZ7GO7jdK3TSE6dJCz/yiJ9IKeEh4BAv+ew+YS4NSmxJdLxyFP4+0D0Z7hDGRW35ZlFfj5yI5idyeae91gFNOkNhfK+BmGXCoUmfpQoEWspyTrP9iuD5thtCwh0Kstu0N2IYP5ZfN6fjNA+YpheKBM+kQXEX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746985327; c=relaxed/simple;
	bh=bGHI9wIVRM2wuSWI0IWazEuw/hfpSCGFqcPibrTf7MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VD+Yn+pyp98RVctyV/cjEzt5q0DdrmaEZE5ybLNnaLcRHcyCwfGv3yZ/w2JN+59n8Tlx+KImOQFEz720QJFnx8ExEr4/zfp1KBVDaV4XHX6Reb3/K1h33Xvlq4pQ7J2z7O8PDJPdakIsZEVzTvZbORR48fbnYarcqvWhEmbrU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fp8KPFDU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=zpu8YKxAyQqf1PwyBYJmSGQ6Olgq5AHM+Ja+9mIqmH4=; b=fp8KPFDUsjwwYEwxqANo7IUr4f
	FUvoPzxHkw2syWikp3xUxwEdy6UlXV806TbzcoSYnZb9oyjF5L/OrdTOeqRCOTR0Dl1aFGBL1x89T
	NugWuoimafyrYTfVxh02xH0+xlpZQJDikVwN7BxYZimx1m2TwpUaHR4Y3HW1fiuWkfqacdv0WFK+B
	TkkiYrrad/GlLahgk7LAj2bFAj8H4EKdX0GUmV2F1u1yOZ0vGvvrlkp26eoZi+HZ13kd9jf35aX3z
	ghoeUzI6d3G3EuZ1XD2DL9hyjhMGYH1ARKNqSP7PJx5sgTjNCRPed3c611MRunpFcuC6kC1C9LQZO
	7aAn+tNQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEAgT-0000000AV95-0TCj;
	Sun, 11 May 2025 17:41:53 +0000
Date: Sun, 11 May 2025 18:41:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: WangYuli <wangyuli@uniontech.com>, brauner@kernel.org, jack@suse.cz,
	akpm@linux-foundation.org, tglx@linutronix.de, jlayton@kernel.org,
	frederic@kernel.org, xu.xin16@zte.com.cn,
	adrian.ratiu@collabora.com, lorenzo.stoakes@oracle.com,
	mingo@kernel.org, felix.moessbauer@siemens.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com
Subject: Re: [PATCH] proc: Show the mountid associated with exe
Message-ID: <20250511174153.GB2023217@ZenIV>
References: <3885DACAB5D311F7+20250511114243.215132-1-wangyuli@uniontech.com>
 <20250511142237.GA2023217@ZenIV>
 <CAC1kPDP4MCfUFkrQu0-Fg3Du7bz25QAY1Wyqdi_HGVbw326U1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC1kPDP4MCfUFkrQu0-Fg3Du7bz25QAY1Wyqdi_HGVbw326U1w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 12, 2025 at 12:19:01AM +0800, Chen Linxuan wrote:
> On Sun, May 11, 2025 at 10:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > Excuse me, just what is that path_get/path_put for?  If you have
> > an opened file, you do have its ->f_path pinned and unchanging.
> > Otherwise this call of path_get() would've itself been unsafe...
> 
> I am not very familiar with how these functions should be used.
> I just copied similar logic from proc_exe_link and added a path_put.
> Maybe I made a stupid mistake...

path_get() grabs an extra reference to mount and dentry; that is enough
to guarantee that their refcount will not drop to zero at least until
we drop the references.

To use it safely you need to be sure that currently refcounts are non-zero
and won't be dropped to zero right under you - for rather obvious reasons.

Your code also clearly relies upon ->f_path being unchanging - otherwise
you would've risked to drop the references not to the objects you've
grabbed earlier.

If both conditions are satisfied, what's the point of grabbing and dropping
these references in the first place?

*IF* there was a chance of mount going away under you, what would prevent
that happening right before that path_get()?

IOW, these dances with path_get()/path_put() are either nowhere near enough
or not needed at all.  As it is, ->f_path of an open file *IS* stable and
mount and dentry references in it do contribute towards mount and dentry
refcounts.  But my point is, that code does not pass the basic "how could
that possibly be right?" test.

PS: since you've mentioned proc_exe_link()... the difference there is that
we want the reference to be used by the caller.  If the file happens to
be closed just as we return (that can't happen until proc_exe_link() drops
the reference to struct file it got from get_task_exe_file(), but as soon
as fput() had been called, there's nothing to guarantee the safety),
file's contributions to refcounts are dropped, so we can't count upon them
to stay for as long as we need.  So in that case we fetch the references
out of ->f_path and pin them before we drop the file reference with fput().

PPS: I'm still not convinced regarding the usefulness of having that
information; "just because we can display it" isn't a strong argument
on its own...

