Return-Path: <linux-fsdevel+bounces-49576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A90AABF299
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 13:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D7F4E5C09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF39262FF8;
	Wed, 21 May 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ/Hi/Ns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86121262FDD;
	Wed, 21 May 2025 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747826409; cv=none; b=WqFLcULx4tUG3HN9MWA6qT0cfkSOum+Jvm+hZH5DfS26HiFOkTjY0TCpI5c8ILjX9HrSTvNoimewBqV9UyxAv+55bG+CI3x36kwuwRivCx8WIHOY88ZxkZ13c4IpemytqHfkE7B40k5Xw5th5P4tsPG+1INRTZ7RJdB2jKCYK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747826409; c=relaxed/simple;
	bh=wW0hEV1mNUbqTboy57J3jEefXVRcae1zbMD8mRZMiXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXIgKI1fn4+783PzDa1CQjxqEYwZfGcd1zKb4yrn0Thc3KQE9/JNKa/yAJm8nOgGRApG58roTOEmhf1THqVhibnL+t1sOzRYBfE0h6qblrjkX5mgoxYpewqYxtxMR60ghBUYbJJlD5EyOc2DwHtzVr9FrFvayyuf8hUXR6bo+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ/Hi/Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49986C4CEE4;
	Wed, 21 May 2025 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747826409;
	bh=wW0hEV1mNUbqTboy57J3jEefXVRcae1zbMD8mRZMiXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJ/Hi/NsTaccxbZluXz1JZNO8gNZVoofLPR13syPQBml3q4NcLflJ7HWEtu5AcxEE
	 wUhN69UHsTwn7YJpNKy7xWUlxaYBscRA0U8Rya46Gx7Ajwct0eteoSOGHHnkQ3s0HZ
	 QwN6Ss2rUEgZMLyyiFAgTUCEalH0iT1E3LCwUo+oZLicqPWR4y8Ptr2TBAZbZSM/nI
	 sS+Bwa8A0AKb8Aw5Wa3IBfbN6Aseptysk2eiXWcj8ROV6UL6ao/OFoMtTu9GSfWZvA
	 36119+SXKJSEhmi2tDk7DNMqdA0T3Aa0e5Q/ey/hPLsbc23DAnU/WqvC88rCkCQFWv
	 LTTzHZVS61Ucw==
Date: Wed, 21 May 2025 13:20:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ovl: Allow mount options to be parsed on remount
Message-ID: <20250521-blusen-bequem-4857e2ce9155@brauner>
References: <20250521-ovl_ro-v1-1-2350b1493d94@igalia.com>
 <CAOQ4uxgXP8WrgLvtR6ar+OncP6Fh0JLVO0+K+NtDX1tGa2TVxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgXP8WrgLvtR6ar+OncP6Fh0JLVO0+K+NtDX1tGa2TVxA@mail.gmail.com>

On Wed, May 21, 2025 at 12:35:57PM +0200, Amir Goldstein wrote:
> On Wed, May 21, 2025 at 8:45 AM André Almeida <andrealmeid@igalia.com> wrote:
> >
> > Allow mount options to be parsed on remount when using the new mount(8)
> > API. This allows to give a precise error code to userspace when the
> > remount is using wrong arguments instead of a generic -EINVAL error.
> >
> > Signed-off-by: André Almeida <andrealmeid@igalia.com>
> > ---
> > Hi folks,
> >
> > I was playing with xfstest with overlayfs and I got those fails:
> >
> > $ sudo TEST_DIR=/tmp/dir1 TEST_DEV=/dev/vdb SCRATCH_DEV=/dev/vdc SCRATCH_MNT=/tmp/dir2 ./check -overlay
> 
> I advise you to set the base FSTYP as README.overlay suggests
> Some tests may require it to run properly or to run at all.
> Probably related to failures you are seeing though...
> 
> > ...
> > Failures: generic/294 generic/306 generic/452 generic/599 generic/623 overlay/035
> > Failed 6 of 859 tests
> >
> > 5 of those 6 fails were related to the same issue, where fsconfig
> > syscall returns EINVAL instead of EROFS:
> >
> 
> I see the test generic/623 failure - this test needs to be fixed for overlay
> or not run on overlayfs.
> 
> I do not see those other 5 failures although before running the test I did:
> export LIBMOUNT_FORCE_MOUNT2=always
> 
> Not sure what I am doing differently.
> 
> > -mount: cannot remount device read-write, is write-protected
> > +mount: /tmp/dir2/ovl-mnt: fsconfig() failed: overlay: No changes allowed in reconfigure
> >
> > I tracked down the origin of this issue being commit ceecc2d87f00 ("ovl:
> > reserve ability to reconfigure mount options with new mount api"), where
> > ovl_parse_param() was modified to reject any reconfiguration when using
> > the new mount API, returning -EINVAL. This was done to avoid non-sense
> > parameters being accepted by the new API, as exemplified in the commit
> > message:
> >
> >         mount -t overlay overlay -o lowerdir=/mnt/a:/mnt/b,upperdir=/mnt/upper,workdir=/mnt/work /mnt/merged
> >
> >     and then issue a remount via:
> >
> >             # force mount(8) to use mount(2)
> >             export LIBMOUNT_FORCE_MOUNT2=always
> >             mount -t overlay overlay -o remount,WOOTWOOT,lowerdir=/DOESNT-EXIST /mnt/merged
> >
> >     with completely nonsensical mount options whatsoever it will succeed
> >     nonetheless.
> >
> > However, after manually reverting such commit, I found out that
> > currently those nonsensical mount options are being reject by the
> > kernel:
> >
> > $ mount -t overlay overlay -o remount,WOOTWOOT,lowerdir=/DOESNT-EXIST /mnt/merged
> > mount: /mnt/merged: fsconfig() failed: overlay: Unknown parameter 'WOOTWOOT'.
> >
> > $ mount -t overlay overlay -o remount,lowerdir=/DOESNT-EXIST /mnt/merged
> > mount: /mnt/merged: special device overlay does not exist.
> >        dmesg(1) may have more information after failed mount system call
> >
> > And now 5 tests are passing because the code can now returns EROFS:
> > Failures: generic/623
> > Failed 1 of 1 tests
> >
> > So this patch basically allows for the parameters to be parsed and to
> > return an appropriated error message instead of a generic EINVAL one.
> >
> > Please let me know if this looks like going in the right direction.
> 
> The purpose of the code that you reverted was not to disallow
> nonsensical arguments.
> The purpose was to not allow using mount arguments that
> overlayfs cannot reconfigure.
> 
> Changing rw->ro should be allowed if no other arguments are
> changed, but I cannot tell you for sure if and how this was implemented.
> Christian?
> 
> >
> > Thanks!
> > ---
> >  fs/overlayfs/params.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> > index f42488c019572479d8fdcfc1efd62b21d2995875..f6b7acc0fee6174c48fcc8b87481fbcb60e6d421 100644
> > --- a/fs/overlayfs/params.c
> > +++ b/fs/overlayfs/params.c
> > @@ -600,15 +600,6 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >                  */
> >                 if (fc->oldapi)
> >                         return 0;
> > -
> > -               /*
> > -                * Give us the freedom to allow changing mount options
> > -                * with the new mount api in the future. So instead of
> > -                * silently ignoring everything we report a proper
> > -                * error. This is only visible for users of the new
> > -                * mount api.
> > -                */
> > -               return invalfc(fc, "No changes allowed in reconfigure");
> >         }
> >
> >         opt = fs_parse(fc, ovl_parameter_spec, param, &result);
> >
> 
> NACK on this as it is.
> 
> Possibly, we need to identify the "only change RDONLY" case
> and allow only that.

Agreed. And this patch is seriously buggy. Just look at this:

> > However, after manually reverting such commit, I found out that
> > currently those nonsensical mount options are being reject by the
> > kernel:
> >
> > $ mount -t overlay overlay -o remount,WOOTWOOT,lowerdir=/DOESNT-EXIST /mnt/merged
> > mount: /mnt/merged: fsconfig() failed: overlay: Unknown parameter 'WOOTWOOT'.
> >
> > $ mount -t overlay overlay -o remount,lowerdir=/DOESNT-EXIST /mnt/merged
> > mount: /mnt/merged: special device overlay does not exist.
> >        dmesg(1) may have more information after failed mount system call

Well of course that fails because the lowedir you're pointing this at
doesn't exist. But consider someone passing a valid lowerdir path or
other valid options then suddenly we're changing the lowerdir parameters
for a running overlayfs instance which is obviously an immediate
security issue because we've just managed to create UAFs all over the
place.

Either the EINVAL for the new mount api is removed and we continue
unconditionally returning 0 for both the new and old mount api or
we allow a limited set of safe remount options.

But changing layers definitely isn't one of them and unconditionally
letting this code reach fs_parse() is an absolute nono.

