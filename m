Return-Path: <linux-fsdevel+bounces-14779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EF387F312
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 23:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C5E1C21519
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 22:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A815A4C4;
	Mon, 18 Mar 2024 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="hhfOO/cn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A059B76
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800581; cv=none; b=fTqXhHmt16G4NkzGjlbidYcc8Rz/Ha1K4kOowJ08K3t6g93LKBC/IjKYSzC2wn7DsiaJMQCGe3yvVbMVgMf+qrv+FWu4WcL63A7k8PvHkh94x8yEwfHzyVkhp+Fy5eDSjPS4rntdsjUguJYjiCgvNBnWTWcAfatoSCFlRbLX1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800581; c=relaxed/simple;
	bh=NqI0VTZW80xtuCGyeObiIog7FSq9YX7JYVoRKPWyAsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbQWXiJDfy+YtRI4k3qsQxEHc9fmGDNgSRyH8LgU0+IkY1g2BmoWvAS6wRHWlxXUh1qOc8msIkX2MxpuLSRaRCOnsrfs0zWXC6TMXKuZ1J0qWawnkJuznDNfy2jZHQrWrxAAlaZkgywFdW4zFlMRpkMRLlL9g0zmjpHWf1QsIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=hhfOO/cn; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a47abe2ff7so1868214eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 15:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710800578; x=1711405378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCCQCvkYtGuuihvS9ju13jWtjvlJYDKT9jyxnBBJm5s=;
        b=hhfOO/cnoOU3wnrH1TbsSuGUEZTtNBJPUDUIbIAw5mre3kMg5Q2CKR2Kyj5ZdgPqYj
         L59Hc5IG1vEkH6kMNEMU+NGk4dmZokTStw+YOyuNaRBD9KaavjAG3GAo+VWrvcIt0ezv
         J6zCf3W+rPjJKZhIdewcStElPotBuTlh+jd+U0/2gHu52tCxBqzm9o6s7Kr1FX/KMnCh
         pcTWN+t2vHrFJq0yxrqcgf/6RWQ5L5Y1y54x+MjP24en8VttiVvw1Iy7Ges0vbru+9o9
         qAZM6/TgKk30AlXLTRsze7+vMESCdieBkoMP5z88IMY3EmGxscSo2HXrqy8HTEfuhyvQ
         dDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710800578; x=1711405378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCCQCvkYtGuuihvS9ju13jWtjvlJYDKT9jyxnBBJm5s=;
        b=iLBRWu6bqgetSTXhGELmWDKrKq5DMUSSSyTMvzPgjPd17bPEjj8WALX+xX+8wLYWg2
         3NjyPgb+947e7DD34oc52dsbP+5u88lfnzF/2K90Dy6b0QI1kEEh/+X4PaCv9pM6tQJc
         jeHDRe/3vey0OBw00ngfafLSrvtEYphiAydn+jYxxDB5kO7ZXC6nXTOtB9p6SsI0MD2f
         L9jgKz+0B5v4vOztDfSSJeGOEkpT4VKU14N2k4ykw5pxp+hGB6yIbZk/gAjRZtPCgh2Q
         kqe9nZHCbAWZiqb9cL0s0NMBNhPyxXgc1ufoDDi59l2KCAci8EOtUloHrXlEFxclfzVT
         GoTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGt6yCpIWL77yLh6KgKXZyM4H0qcc6GTyUJtkjRcy5+3Avrb+tMdpJx0yl7sYXD4ge55Zt4PXED3coBzepZm32uvcd+1n52Uz9vo8FXw==
X-Gm-Message-State: AOJu0YxEYX2Qa4hDdtoJHLD60L+JSOtL7Tp9fdbFMaQowowuQUBDer3U
	BnO23n68dJnmuTwYCPkIu0zb2qN6SLJtf8UUhtUhjtST6nKQNCDX+7OZ+PeS++U=
X-Google-Smtp-Source: AGHT+IHyckCjaxFsQHMtIDAZv7wEdAat6m2tUFjdH9I1ji+XQfTeAoj5hu9HAz770Ekw5+eb0V75BA==
X-Received: by 2002:a05:6358:3389:b0:17e:8e40:47f5 with SMTP id i9-20020a056358338900b0017e8e4047f5mr8624180rwd.11.1710800578468;
        Mon, 18 Mar 2024 15:22:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-185-123.pa.nsw.optusnet.com.au. [49.180.185.123])
        by smtp.gmail.com with ESMTPSA id k12-20020aa790cc000000b006e71cd9c02bsm3240212pfk.129.2024.03.18.15.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 15:22:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rmLNf-003nTk-25;
	Tue, 19 Mar 2024 09:22:55 +1100
Date: Tue, 19 Mar 2024 09:22:55 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Kiselev, Oleg" <okiselev@amazon.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Theodore Ts'o <tytso@mit.edu>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
Message-ID: <Zfi+v/9vF+mfZ4Bl@dread.disaster.area>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
 <20240315035308.3563511-4-kent.overstreet@linux.dev>
 <20240315164550.GD324770@mit.edu>
 <l3dzlrzaekbxjryazwiqtdtckvl4aundfmwff2w4exuweg4hbc@2zsrlptoeufv>
 <A0A342BA-631D-4D6E-B6D2-692A45509F63@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A0A342BA-631D-4D6E-B6D2-692A45509F63@amazon.com>

On Mon, Mar 18, 2024 at 09:51:04PM +0000, Kiselev, Oleg wrote:
> On 3/15/24, 09:51, "Kent Overstreet" <kent.overstreet@linux.dev <mailto:kent.overstreet@linux.dev>> wrote:
> > On Fri, Mar 15, 2024 at 12:45:50PM -0400, Theodore Ts'o wrote:
> > > On Thu, Mar 14, 2024 at 11:53:02PM -0400, Kent Overstreet wrote:
> > > > the new sysfs path ioctl lets us get the /sys/fs/ path for a given
> > > > filesystem in a fs agnostic way, potentially nudging us towards
> > > > standarizing some of our reporting.
> > > >
> > > > --- a/fs/ext4/super.c
> > > > +++ b/fs/ext4/super.c
> > > > @@ -5346,6 +5346,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> > > > sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
> > > > #endif
> > > > super_set_uuid(sb, es->s_uuid, sizeof(es->s_uuid));
> > > > + super_set_sysfs_name_bdev(sb);
> > >
> > > Should we perhaps be hoisting this call up to the VFS layer, so that
> > > all file systems would benefit?
> >
> >
> > I did as much hoisting as I could. For some filesystems (single device
> > filesystems) the sysfs name is the block device, for the multi device
> > filesystems I've looked at it's the UUID.
> 
> Why not use the fs UUID for all cases, single device and multi device?

Because the sysfs directory heirachy has already been defined for
many filesystems, and technically sysfs represents a KABI that we
can't just break for the hell of it.

e.g. changing everything to use uuid will break fstests
infrastructure because it assumes that it can derive the sysfs dir
location for the filesystem from the *device name* the filesystem is
mounted on. btrfs has a special implementation of that derivation
that runs the btrfs command to retreive the UUID of the filesysem.

So, yes, while we could technically change it, we break anything in
userspace that has introduced a dependency on bdev name as the sysfs
fs identifier. We're not going to break userspace like this,
especially as it is trivial to avoid.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

