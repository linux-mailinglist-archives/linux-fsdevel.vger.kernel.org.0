Return-Path: <linux-fsdevel+bounces-21813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 725D590AC15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 12:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E45B25D5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4E91953A6;
	Mon, 17 Jun 2024 10:47:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4A1194120;
	Mon, 17 Jun 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621234; cv=none; b=CoAMvsl6deZXvun8rt/g5cdeW3t9cWvUHaBMxoFoQgxjNij6ek4cLBQOaJ/bkTSmj7YZvQHb1a7fWkb6CEQQ0rnl+usbn23NSnR3WqX+0r5XPAP+qZKDM2Jo16W/ixLft/cysIW7MBP7bXQ/wePU3Jfblwcfd2BysjYcVBCa9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621234; c=relaxed/simple;
	bh=tVhqmn9G7oaDbVcSKRh0Jw2Ci0zemD9jxwyqFrG/2AE=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=D4kZ0VDu/SUNvc1G+iwmxD2D5Y12r1KTcbFGMrNHaEKhignP+gzS0vUE7EMjcnMnlWpzISVNWSksSFcgMD0iRG2K95Aixgg3bEmlFVmgvLfDy60J/GIWCoruu2uc4kEJYjeaUa98Hu9zlViZ3NYp2REVMB7ksrXBDsBO36WPD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 1B17A3780A0B;
	Mon, 17 Jun 2024 10:47:04 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <20240617-emanzipation-ansiedeln-6fd2ae7659c8@brauner>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240613133937.2352724-1-adrian.ratiu@collabora.com> <20240617-emanzipation-ansiedeln-6fd2ae7659c8@brauner>
Date: Mon, 17 Jun 2024 11:47:03 +0100
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com, jorgelo@chromium.org, "Jann Horn" <jannh@google.com>, "Kees Cook" <keescook@chromium.org>, "Jeff Xu" <jeffxu@google.com>, "Kees Cook" <kees@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3304e0-66701400-f47-33d83680@2902777>
Subject: =?utf-8?q?Re=3A?= [PATCH v6 1/2] =?utf-8?q?proc=3A?= pass file instead of 
 inode to =?utf-8?q?proc=5Fmem=5Fopen?=
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Monday, June 17, 2024 11:48 EEST, Christian Brauner <brauner@kernel.=
org> wrote:

> On Thu, Jun 13, 2024 at 04:39:36PM GMT, Adrian Ratiu wrote:
> > The file struct is required in proc=5Fmem=5Fopen() so its
> > f=5Fmode can be checked when deciding whether to allow or
> > deny /proc/*/mem open requests via the new read/write
> > and foll=5Fforce restriction mechanism.
> >=20
> > Thus instead of directly passing the inode to the fun,
> > we pass the file and get the inode inside it.
> >=20
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jeff Xu <jeffxu@google.com>
> > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > ---
>=20
> I've tentatively applies this patch to #vfs.procfs.
> One comment, one question:
>=20
> > No changes in v6
> > ---
> >  fs/proc/base.c       | 6 +++---
> >  fs/proc/internal.h   | 2 +-
> >  fs/proc/task=5Fmmu.c   | 6 +++---
> >  fs/proc/task=5Fnommu.c | 2 +-
> >  4 files changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 72a1acd03675..4c607089f66e 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -794,9 +794,9 @@ static const struct file=5Foperations proc=5Fsi=
ngle=5Ffile=5Foperations =3D {
> >  };
> > =20
> > =20
> > -struct mm=5Fstruct *proc=5Fmem=5Fopen(struct inode *inode, unsigne=
d int mode)
> > +struct mm=5Fstruct *proc=5Fmem=5Fopen(struct file  *file, unsigned=
 int mode)
> >  {
> > -	struct task=5Fstruct *task =3D get=5Fproc=5Ftask(inode);
> > +	struct task=5Fstruct *task =3D get=5Fproc=5Ftask(file->f=5Finode)=
;
>=20
> Comment: This should use file=5Finode(file) but I've just fixed that =
when I
> applied.
>=20
> Question: Is this an equivalent transformation. So is the inode that =
was
> passed to proc=5Fmem=5Fopen() always the same inode as file=5Finode(f=
ile)?

Thank you!

Yes, the inode associated with the file struct should be always the sam=
e
while the file is opened, so the link set during the top-level mem=5Fop=
en()
callback should still hold while it itself calls into its sub-functions=
 like
proc=5Fmem=5Fopen().


