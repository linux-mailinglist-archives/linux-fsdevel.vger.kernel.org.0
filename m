Return-Path: <linux-fsdevel+bounces-6827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E786281D422
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 14:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9921F227BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DD6DDC5;
	Sat, 23 Dec 2023 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6qgc1pO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA5DD2EC;
	Sat, 23 Dec 2023 13:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C06FC433C7;
	Sat, 23 Dec 2023 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703336679;
	bh=pSQbXnxiyqNqmbq5Ho7XxCP4UcVUyAZ8MoVPSyk4+z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6qgc1pOwX7mfGWLVLcYJx+6peuoQfiZcxbmU76QVYG0g2xp+OYkFq3X0iwIT+5Co
	 CXyGWMNvlkgUv3KQ4LB5WCKIFtJjemhvLbMvHL3m15C+JnyvdMoPPHK4Wd24Oiyqh6
	 B4mSFPbV994esq8xk7OEv/wk6RFcxiH3HCTmz2Da5S7cS/rwwTcSk53W6XWyxVkRdr
	 KCQGxEJk4Fy6rv/jly1eU0HscCKwIwosA/onP53at2sP7mjTf8ec5n8zB31G2TO/mS
	 Xvn+K9RckaFunpU2GHC1SOKX6T8vhBhTWLWByxBiakAd3UQmxIMiFWc0wDlcxt2jrE
	 JBq6U0n0XbZmQ==
Date: Sat, 23 Dec 2023 14:04:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [RFC][PATCH 4/4] fs: factor out backing_file_mmap() helper
Message-ID: <20231223-zerlegen-eidesstattlich-a1f309e30dbc@brauner>
References: <20231221095410.801061-1-amir73il@gmail.com>
 <20231221095410.801061-5-amir73il@gmail.com>
 <20231222-gespeichert-prall-3183a634baae@brauner>
 <CAOQ4uxiL=DckFZqq1APPUaWwWynH6mAJk+VcKO46dwGD521FYw@mail.gmail.com>
 <CAOQ4uxiLB4c4WXjvyAzQdvWD23YgMVQPuTd9Fp=oUNy_uGdGTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiLB4c4WXjvyAzQdvWD23YgMVQPuTd9Fp=oUNy_uGdGTQ@mail.gmail.com>

On Sat, Dec 23, 2023 at 08:56:08AM +0200, Amir Goldstein wrote:
> On Sat, Dec 23, 2023 at 8:54 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Dec 22, 2023 at 2:54 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Thu, Dec 21, 2023 at 11:54:10AM +0200, Amir Goldstein wrote:
> > > > Assert that the file object is allocated in a backing_file container
> > > > so that file_user_path() could be used to display the user path and
> > > > not the backing file's path in /proc/<pid>/maps.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/backing-file.c            | 27 +++++++++++++++++++++++++++
> > > >  fs/overlayfs/file.c          | 23 ++++++-----------------
> > > >  include/linux/backing-file.h |  2 ++
> > > >  3 files changed, 35 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/fs/backing-file.c b/fs/backing-file.c
> > > > index 46488de821a2..1ad8c252ec8d 100644
> > > > --- a/fs/backing-file.c
> > > > +++ b/fs/backing-file.c
> > > > @@ -11,6 +11,7 @@
> > > >  #include <linux/fs.h>
> > > >  #include <linux/backing-file.h>
> > > >  #include <linux/splice.h>
> > > > +#include <linux/mm.h>
> > > >
> > > >  #include "internal.h"
> > > >
> > > > @@ -284,6 +285,32 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(backing_file_splice_write);
> > > >
> > > > +int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
> > > > +                   struct backing_file_ctx *ctx)
> > > > +{
> > > > +     const struct cred *old_cred;
> > > > +     int ret;
> > > > +
> > > > +     if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)) ||
> > >
> > > Couldn't that WARN_ON_ONCE() be in every one of these helpers in this
> > > series? IOW, when would you ever want to use a backing_file_*() helper
> > > on a non-backing file?
> >
> > AFAIK, the call chain below backing_file_splice*() and backing_file_*_iter()
> > helpers never end up accessing file_user_path() or assuming that fd of file
> > is installed in fd table, so there is no strong reason to enforce this with an
> > assertion.

Yeah, but you do use an override_cred() call and you do have that
backing_file_ctx. It smells like a bug if anyone would pass in a
non-backing file.

> >
> > We can do it for clarity of semantics, in case one of the call chains will
> > start assuming a struct backing_file in the future. WDIT?
> 
> Doh! WDYT?

I'd add it as the whole series is predicated on this being used for
backing files.

