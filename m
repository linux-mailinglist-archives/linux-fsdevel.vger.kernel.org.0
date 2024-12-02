Return-Path: <linux-fsdevel+bounces-36226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E29DFCE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 10:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18387B21172
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB651FA27C;
	Mon,  2 Dec 2024 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4BtJDz9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E41F9F63;
	Mon,  2 Dec 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131155; cv=none; b=KuTCTqY+VY3NuttHvyScYRT6FOSxDmb+vwghXJ/PLg1qj/XxEUhKDizjKkSo3mmR+nOpyATWkYlKOMtpU3skBTqURuvJctUzlD7tQDNyKfM7/2ghSavKfqN7TrLU2lT85XTdti569ZQWAXCOCp9/oZjJqcVPGDhtWhDORygC9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131155; c=relaxed/simple;
	bh=MK5G0zxP8zA/OoPHL7AWEIh4OCB2UGd/11e3UiMV2cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekOkfSQGVtfuC3kdcMXNUAzwrIKYbIvfHi2V0pRcYNT0aX7VxiUnA8oyAz+Czymx9OTtm9yDcxd36SdWhTL93Qz8yqRScQA0ch0SLw92rzGi+0CbuV7UWVamnSRTQhfb6dTyZdRqgfnBQcbuWsSj7DYWGau5LnXrvxYDqMb1UJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4BtJDz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DEFC4CED2;
	Mon,  2 Dec 2024 09:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733131154;
	bh=MK5G0zxP8zA/OoPHL7AWEIh4OCB2UGd/11e3UiMV2cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4BtJDz9IEZ25s9kQROzHxcBLzxX42qxUjw55etrmFvE92WkYzG3OM4GfWYucznta
	 HqeINYdJeQEQWn75c/wXme2XyUOLpbEAVo5lKYthKFurg2r2GNiNOVn9sjAwywx+KM
	 SbhfveOjpECQGJDVnj+F1fBGdXZH0z5M1XYXeFOaEvYLy/Eyh6xXuZE5gY2JgMBciw
	 VQd2QVLHJIql6B3/ZkTsU0ZIHgvEpbhL99kpLvxr/X+PilYILM0X7rwZVHbQwaljP7
	 5AYl7h2LMdKncP9ILeX/wy4/FAgZUN7IXlYrNXp+Ie32z5M7SsiW40SU4e7B9rZfMp
	 ZUYqgUDZ3z2Dg==
Date: Mon, 2 Dec 2024 10:19:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Erin Shepherd <erin.shepherd@e43.eu>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable <stable@kernel.org>
Subject: Re: [PATCH 1/4] exportfs: add flag to indicate local file handles
Message-ID: <20241202-aufpeppen-parolen-a17bf56086e2@brauner>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <20241201-work-exportfs-v1-1-b850dda4502a@kernel.org>
 <Z0ztcToKjCY05xq9@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0ztcToKjCY05xq9@dread.disaster.area>

On Mon, Dec 02, 2024 at 10:12:49AM +1100, Dave Chinner wrote:
> On Sun, Dec 01, 2024 at 02:12:25PM +0100, Christian Brauner wrote:
> > Some filesystems like kernfs and pidfs support file handles as a
> > convenience to use name_to_handle_at(2) and open_by_handle_at(2) but
> > don't want to and cannot be reliably exported. Add a flag that allows
> > them to mark their export operations accordingly.
> > 
> > Fixes: aa8188253474 ("kernfs: add exportfs operations")
> > Cc: stable <stable@kernel.org> # >= 4.14
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/nfsd/export.c         | 8 +++++++-
> >  include/linux/exportfs.h | 1 +
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index eacafe46e3b673cb306bd3c7caabd3283a1e54b1..786551595cc1c2043e8c195c00ca72ef93c769d6 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -417,6 +417,7 @@ static struct svc_export *svc_export_lookup(struct svc_export *);
> >  static int check_export(struct path *path, int *flags, unsigned char *uuid)
> >  {
> >  	struct inode *inode = d_inode(path->dentry);
> > +	const struct export_operations *nop;
> >  
> >  	/*
> >  	 * We currently export only dirs, regular files, and (for v4
> > @@ -449,11 +450,16 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
> >  		return -EINVAL;
> >  	}
> >  
> > -	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> > +	if (!exportfs_can_decode_fh(nop)) {
> 
> Where is nop initialised?

Yep, already fixed in tree yesterday. Thanks for catching this though!

> 
> >  		dprintk("exp_export: export of invalid fs type.\n");
> >  		return -EINVAL;
> >  	}
> >  
> > +	if (nop && nop->flags & EXPORT_OP_LOCAL_FILE_HANDLE) {
> 
> Also, please use () around & operations so we can understand that
> this is not an accidental typo. i.e:
> 
> 	if (nop && (nop->flags & EXPORT_OP_LOCAL_FILE_HANDLE)) {
> 
> clearly expresses the intent of the code, and now it is obviously
> correct at a glance.

Done.

