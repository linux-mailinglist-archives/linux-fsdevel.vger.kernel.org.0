Return-Path: <linux-fsdevel+bounces-29438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB8F979BCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 09:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F82B1C22DEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 07:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7168B4C62A;
	Mon, 16 Sep 2024 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="uacM8CBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711AE1BDC8
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470219; cv=none; b=i2R9SqwmcdkVQltGfD2VBdk1Di0y4rQmuSiszddZw4ilbhgvgyZu7MCDWFntHpz6CIjuNEftpWYNXNQnvTxjatx1O7jc+VaHnPYgFbXAfY2EFlX2QPvkFxvXY9ZIzLaweBUJ7kBSESJoksYhmtYdBhWVo8pvVEHqilKzL1UinTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470219; c=relaxed/simple;
	bh=p0HRwb7dckvpqsAEI1/7frDLgt0lW6OPyF4zHs0P8lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkSVmYFB3YouBxwN/V2lf0D+v1QnABgIelVI1kSexNkWrxpcoWeTROgQSAUdGLbKvvDyIlUXSsVyzMelfI5+VEN6qVFakNEB8vXI5F5Q31V6ftrT8E7Yj6Go3ptPhE5j+WbCJ/OoyMAf4WQUI428XTzuVUC+TrdglG3j77lSzlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=uacM8CBQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so2698473a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 00:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726470218; x=1727075018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZLEn0Q9zViAeMpnzS+Dnq04taHJPJso6pfVCKuErcs=;
        b=uacM8CBQ2YTGMGXW9M1xXKYXDgwn8/OSFC33WCT3b6kiTcMp5H75DQFyTKUs5LVS6s
         56PPDBTfDxUwfXayNVVF93060ZWqV8Vzi+tomk1ZuAM4A33XwpXXBxbAkr1XaH+HdC1r
         +Z2Tvg1ZEregiWNZWUC4ZVrmfEjnIF5veYQFFP9UDXVvRNiJIuliVWN9RBlvqQpPJv7U
         t+MrxHLqhekD/DChZoSVH6gXtC+ekq8NTzQuYNJwtFRJk3XuodZs0gL5p9+Ph6PMWmtk
         FtHKkRgSXY4do+QrsunPd+Mv96KPaDyokG5CS5vygbIymSn5Duag07JNrJkVKV5vdfzx
         DvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726470218; x=1727075018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZLEn0Q9zViAeMpnzS+Dnq04taHJPJso6pfVCKuErcs=;
        b=e/ygAbOLdvB27go3huD1ONmSKloyGRh9AQ5iltJKhAWosueauwypsPM3AGYV4b/GJ9
         jZi09GNoK/mPGMDh26Kx3/qlOLFv42E6kq+YKJgGEg8Ga1/zyjLYxawD74J/q3N4eVx9
         yFG3OM+HQsbqYSID+sC/NcVVCZWurIOc61g2+RHcyb2LEMBEFTuj1Jj2lYLtG1vIfe9T
         WSG+Ndk0lo+AboIZHs2lPEEBncLBGIT0FvDbfp/MuZ1iHHXSmMFToBSefmwOMDj0VKIi
         sh/K6qjaLvM0mgbHUXT1xyFSw6ZLoADe2qXzmGaD8ykgf1V4Nn2flfSv+I4X0ElkHNkc
         z9uA==
X-Forwarded-Encrypted: i=1; AJvYcCUVEjIAET2qP9GGTjMIEATk58vbuPLeH6T9pU3TbUJLQSo4iYqtjMapUADqXA5WnBz7HfjtB/a/tYUjggG+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8OeLT4XZMk/3AOkadB1T6vXEXE/X7zBpb5292nLXp3AgWYQRR
	97y7jpFeYRTlkhVPlN+Z/QGi+HcRpN/y8c7LzK+JuZ5ZM8n0SXDncfpz+oY6NN0=
X-Google-Smtp-Source: AGHT+IGq42CTY7GghG9ZTc+fqKHl5k23VXJfZNsjb0N1GaK6i7O2LyGs84PhBoOXpuTO1FVLs75q9Q==
X-Received: by 2002:a17:90a:684c:b0:2d3:d414:4511 with SMTP id 98e67ed59e1d1-2db9ffefa37mr16283390a91.24.1726470217587;
        Mon, 16 Sep 2024 00:03:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c7c7b4sm6581412a91.17.2024.09.16.00.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 00:03:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sq5lm-005pLT-1M;
	Mon, 16 Sep 2024 17:03:34 +1000
Date: Mon, 16 Sep 2024 17:03:34 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <ZufYRolfyUqEOS1c@dread.disaster.area>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com>
 <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <877cbq3g9i.fsf@gmail.com>
 <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
 <8734m7henr.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734m7henr.fsf@gmail.com>

On Tue, Sep 10, 2024 at 06:03:12PM +0530, Ritesh Harjani wrote:
> >> Is it something to just prevent users from destroying their own data
> >> by not allowing a rw mount from an older kernel where users could do
> >> unaligned writes to files marked for atomic writes?
> >> Or is there any other reasoning to prevent XFS filesystem from becoming
> >> inconsistent if an older kernel does a rw mount here.
> >
> > The older kernel does not know what the unknown inode flag means
> > (i.e. atomic writes) and so, by definition, we cannot allow it to
> > modify metadata or file data because it may not modify it in the
> > correct way for that flag being set on the inode.
> >
> > Kernels that don't understand feature flags need to treat the
> > filesystem as read-only, no matter how trivial the feature addition
> > might seem.
> >
> 
> 1. Will it require a fresh formatting of filesystem with mkfs.xfs for
> enabling atomic writes (/forcealign) on XFS?

Initially, yes.

>   a. Is that because reflink is not support with atomic writes
>   (/forcealign) today?

It's much more complex than that.

e.g. How does force-align and COW interact, especially w.r.t.
sub-alloc unit overwrites, cowextsz based preallocation and
unwritten extents in the COW fork?

> As I understand for setting forcealign attr on any inode it checks for
> whether xfs_has_forcealign(mp). That means forcealign can _only_ be
> enabled during mkfs time and it also needs reflink to be disabled with
> -m reflink=0. Right?

forcealign doesn't need to be completely turned off when reflink is
enabled and/or vice versa. Both can co-exist in the filesytsem at
the same time, but the current implementation does not allow
forcealign and reflink to be used on the same inode at the same
time.

It was decided that the best way to handle the lack of reflink
support initially was to make the two feature bits incompatible at
mount time. Hence we currently have to make a non-reflink filesystem
to test forcealign based functionality.

However, doing it this way means that when we fix the implementation
to support reflink and forcealign together, we just remove the mount
time check and all existing reflink filesystems can be immediately
upgraded to support forcealign.

OTOH, we can't do this with atomic writes. Atomic writes require
some mkfs help because they require explicit physical alignment of
the filesystem to the underlying storage. Hence we'll eventually end
up with atomic writes needing to be enabled at mkfs time, but force
align will be an upgradeable feature flag.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

