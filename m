Return-Path: <linux-fsdevel+bounces-34698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6429C7CF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 21:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43458281F7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 20:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FFF2064E9;
	Wed, 13 Nov 2024 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Dp0lW7Bq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F12AF00;
	Wed, 13 Nov 2024 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529881; cv=none; b=HZtSylYbC6ooN5jJsbQ8t5GcKcuOiFWtWWK5NUER6VuUpd/a53UUBxlxeIkeFND8ItKUm3N9Hmk9narO1q4A4ijklJnOiqB42nW3pg5WaEvv+uTqzn01EnGqiEA48ixZr6U1vnTzjZPDR/E8dbXBIljLYGYkxfX4s7p0oOcKLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529881; c=relaxed/simple;
	bh=1KoW9lkE2j3hH8vAJUo/fP2tINo05xrrANj5xwxv5xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h794KEPIXJKkeWfHWAC7j8NvelAxgkoZChl41TaVXrL7NajVZWeuaXaFdVfQxNNonZSe0YNDqOObkjv/AcrbCi3enH7HmcCREcJRNqNzcDLSiUWDq2abw2ZyRXNyu8cAbBgWLcIEbKam7R13xFRRrOXlInQv7ccqQ0fGA0Mmfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Dp0lW7Bq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uBOk39HO5marrjmAPTj5btVGIMvjnKV9Fn7MUaxbEpk=; b=Dp0lW7BqSOlcJA51VtHwe564wV
	bnUOR8BBbkRAur4PjGE1BSuYnNSS+FYXd0XvM31Y4dxBkG78PBnOo5/eO0CMOC9muhV7t1SEvK+p3
	sjYerInIF1c7dYfxq38gWEnFTp+VLqXD+AVuxrgIB0k8CS997hVB//fBUYl5W53mWINzHZAsPkOZO
	IPxEFvpNqy7eFQ3WepBlIahA4uLon9res3epmB4ywsx/CuS6ec9v5sdGZKDy3VLT085LtjwVhDzQK
	0odxif7J3+KG0flpwujrcodDpBSPXi5I/dMR2gCQ2tpy/eFCTK8RG2gSdAgNB0eaYybdb/XH5qnSe
	qk9i9eTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBK1A-0000000EctM-2Gpv;
	Wed, 13 Nov 2024 20:31:12 +0000
Date: Wed, 13 Nov 2024 20:31:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission
 events
Message-ID: <20241113203112.GI3387508@ZenIV>
References: <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
 <20241113001251.GF3387508@ZenIV>
 <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
 <CAHk-=wgVzOQDNASK8tU3JoZHUgp7BMTmuo2Njmqh4NvEMYTrCw@mail.gmail.com>
 <20241113011954.GG3387508@ZenIV>
 <20241113043003.GH3387508@ZenIV>
 <CAOQ4uxj01mrrPQMyygdyDAGpyA=K=SPH88E2tpY5RuSsqG9iiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj01mrrPQMyygdyDAGpyA=K=SPH88E2tpY5RuSsqG9iiA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 13, 2024 at 03:36:33PM +0100, Amir Goldstein wrote:

> I would make this a bit more generic helper and the comment above
> is truly clueless:
> 
>         /*
> -        * we need a new file handle for the userspace program so it
> can read even if it was
> -        * originally opened O_WRONLY.
> +        * We provide an fd for the userspace program, so it could access the
> +        * file without generating fanotify events itself.
>          */
> -       new_file = dentry_open(path,
> -                              group->fanotify_data.f_flags | __FMODE_NONOTIFY,
> -                              current_cred());
> +       new_file = dentry_open_fmode(path, group->fanotify_data.f_flags,
> +                                    FMODE_NONOTIFY, current_cred());

Hmm...  Not sure I like that, TBH, since that'll lead to temptation to
turn dentry_open() into a wrapper for that thing and I would rather
keep them separate.

> > -       fd = anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_flags);
> > +       fd = get_unused_fd_flags(flags);
> 
> s/flags/f_flags

ACK - thanks for catching that one.

