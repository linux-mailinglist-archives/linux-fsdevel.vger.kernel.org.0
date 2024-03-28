Return-Path: <linux-fsdevel+bounces-15520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB4E88FEB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 13:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978F4294FDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429547F7CC;
	Thu, 28 Mar 2024 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm1wJG5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928337F492;
	Thu, 28 Mar 2024 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627659; cv=none; b=BxCYxrmFoHq+3+y4WO0Y9zXON0Wzo1G+ZZevfUqj4DX8zZ1fmEk8rBwHC+m7jBNA0ildXHrJgx8DMDYGoCtSHZA+kZElcujvB+YBC9wpk84zBEKiSJw8zvWCEDmy6iCv128HgBVNxBJ2uBlF/8tnW8Y8kQUk8W8IkTVVDzpBYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627659; c=relaxed/simple;
	bh=6Sprpbd1J4ixBjfWxq7eYXtgePBQTW5+LF9lJpAp48E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lasc004UHxELin2Jct3OfRSjZWtR1+nLI5XmtX0fi92GOsw0DgXttP0DkGKDD0P4po542Tkx4TRNTeibcpUzxvOlp072SKTqM3q1sJTThCM5nQKGLrb9zwMi4mb3bfqFoaI35ZRiYLTOc/OTUqHqUbGW+hXRgs4+g04gBVOjaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm1wJG5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE126C433C7;
	Thu, 28 Mar 2024 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711627659;
	bh=6Sprpbd1J4ixBjfWxq7eYXtgePBQTW5+LF9lJpAp48E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lm1wJG5RHh/ru2UpvbHkaB1xswp+qwVU3wTbvWy6Z3t5A9nlCMuFSp7Hip030F5a2
	 6JnptxFB4BXinTXlXdlaMI0YhfQHJavaKWLU5z6FU1INfQTKlA8noN7i/ll9lwFnlQ
	 J7Ebh/0Eo0tPsO0KXmd75Od/Jyk0cSzq1tJpUKGfT8Fgf3W7i5tvoKuRk6X6OhJTe1
	 h21T2LcOZn750o4siUsC7Nkfr/pvLevDB1QFn/7U01hn+aHm10RdSiiPMLDjgsRj1a
	 f2fG40utRPLFee3aPTmGxz1qb+JXN3SYbEbDAGiTIXVXpWEhw96hGEuCvMBDfixf5j
	 BzUdQ2vL1x0UA==
Date: Thu, 28 Mar 2024 13:07:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@manguebit.com>, 
	Christian Brauner <christian@brauner.io>, Mimi Zohar <zohar@linux.ibm.com>, 
	Paul Moore <paul@paul-moore.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Subject: Re: kernel crash in mknod
Message-ID: <20240328-verfrachten-geebnet-19181fb9ad65@brauner>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV>
 <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
 <cb267d1c7988460094dbe19d1e7bcece@huawei.com>
 <20240326-halbkreis-wegstecken-8d5886e54d28@brauner>
 <4a0b28ba-be57-4443-b91e-1a744a0feabf@huaweicloud.com>
 <20240328-raushalten-krass-cb040068bde9@brauner>
 <4ad908dc-ddc5-492e-8ed4-d304156b5810@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ad908dc-ddc5-492e-8ed4-d304156b5810@huaweicloud.com>

On Thu, Mar 28, 2024 at 01:24:25PM +0200, Roberto Sassu wrote:
> On 3/28/2024 12:08 PM, Christian Brauner wrote:
> > On Thu, Mar 28, 2024 at 12:53:40PM +0200, Roberto Sassu wrote:
> > > On 3/26/2024 12:40 PM, Christian Brauner wrote:
> > > > > we can change the parameter of security_path_post_mknod() from
> > > > > dentry to inode?
> > > > 
> > > > If all current callers only operate on the inode then it seems the best
> > > > to only pass the inode. If there's some reason someone later needs a
> > > > dentry the hook can always be changed.
> > > 
> > > Ok, so the crash is likely caused by:
> > > 
> > > void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry
> > > *dentry)
> > > {
> > >          if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > > 
> > > I guess we can also simply check if there is an inode attached to the
> > > dentry, to minimize the changes. I can do both.
> > > 
> > > More technical question, do I need to do extra checks on the dentry before
> > > calling security_path_post_mknod()?
> > 
> > Why do you need the dentry? The two users I see are ima in [1] and evm in [2].
> > Both of them don't care about the dentry. They only care about the
> > inode. So why is that hook not just:
> 
> Sure, I can definitely do that. Seems an easier fix to do an extra check in
> security_path_post_mknod(), rather than changing the parameter everywhere.

You only have two callers and the generic implementation.

> 
> Next time, when we introduce new LSM hooks we can try to introduce more
> specific parameters.
> 
> Also, consider that the pre hook security_path_mknod() has the dentry as
> parameter. For symmetry, we could keep it in the post hook.

I think that's not that important.

> 
> What I was also asking is if I can still call d_backing_inode() on the
> dentry without extra checks, and avoiding the IS_PRIVATE() check if the
> former returns NULL.

