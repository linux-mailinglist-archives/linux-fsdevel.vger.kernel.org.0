Return-Path: <linux-fsdevel+bounces-42013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257F8A3AB47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 22:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F99188D4B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 21:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876251CF5E2;
	Tue, 18 Feb 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="cvnrRz2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B52862A5
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915057; cv=none; b=ZYWlTmE1o53SMq1F3EVvG9LBkFYzg+LEh8nNZ7viw4rQtdofXDpow6rTKW2riP6Fs6l/MRefU6W1aZjl/lFUqwzwvk93fO9dhYx8jbn0lr56tf/1LOhnxAK/BnbE5qCa5kib38ct7xOshdoc0wSUfKcVyCN/kAVJViQQUb/JVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915057; c=relaxed/simple;
	bh=PFXhz57Z0ZV3oSGooDqtlhSsF0Civ47fG/LGQSAKfWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLsucxSyVJvj0GzLwFifUa3a+XbH8bqB2OxXK5ElQtCPuCeF3AF0//MfPVQD5xt8oC1UtnWHEhbCv/vVts8j1MeZKZmych/o/WaFldNVgmrsGCaTTOX8Ggqo4KrNRyt1snuTCoguPRcFWkY4t+VhnkmMSGe2lEoBZI3YNmL5VBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=cvnrRz2x; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so8285287a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 13:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739915055; x=1740519855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMMHB9m8GqtBCBfwV8z0m8dhT5zsmWs508QeIMPsM0E=;
        b=cvnrRz2xbXbCI+uBLD1zxWjsynnR2yrZUUtWRqmFKb3CfFI45jbi9MV2ijhUMpJsTU
         F/lhlSvfeoSj8FdmJa7S/SgUuWUvrlDWXrwqQQsmkddHTGTcPi9V2aOnVFm0gYnYxatN
         +GPS0cR4oD9F+2qgKK3F3ybc07OAPjQjtJjYFQGehJea5fGqUB7cFk6o/aDcQQRRRQdS
         aQh+Qm2dM7ZCOlszM0vuYSkqoEbK68cgGysct8yIIqu5o5N52qW8RmUpZ23G+j99cG3D
         7h4/ner+/Scz5SsSkZeo+7F6jDfJiDR/Tj1Y+bBxZwuaQkupjFjuz79ieWqmvh6fCwhR
         pHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739915055; x=1740519855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMMHB9m8GqtBCBfwV8z0m8dhT5zsmWs508QeIMPsM0E=;
        b=V+K3m5RLqsndkP2v1AhSHlX3a5/jp1DD5lWkABZbMeVvoFYDvAWmuYKGINaY4Gz0b4
         S7UqejI/+F3Q1V93YOhkqtHlboqioRiBtZw81unS5Y1KK05ljJgEUQ+cSgx+8A6BU6XI
         fuYwLFV7HFAnRXQ+YA6RV13tENaKcV6nHnYTn9JshHJ+L4sjkymtBl5WGr8U7afG4XIk
         /gT1kAY4l/grV7f8POXXBLHDqP8kiWBri4zDnvZUuHwvvUr67TfpXuLPCXIUsr9X5vs+
         1yQbAI7buZHLpmhho3QHeS5wkmwTf5AHW8oa2l/vwe2lehOfSGDGZWVpKxATVrXj+Wu5
         etaw==
X-Forwarded-Encrypted: i=1; AJvYcCU7bwXNesGSvty113u3f7CGzMCWZrXHrzLG7Ur67lVJrvADoSaK06eCY9O6Vb72DwmbV2cFL56CA8X2oryI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/YEoIvwOzxeT1Gin/+gHdVwkefgMJz4GXYccIiZ7YoYRQKzKv
	8QSbreGMa6K8TBGqpWSnBLct0gLNEf3AvJO5YlnwmKVxJHxhRO6YlrrlcweR+Dk=
X-Gm-Gg: ASbGncskpVjcKpr1ilK/iKaymqXrblFToayfaf7JUEOE5wNBt+CW5ceYb4O3yc3dxlX
	OZJ5F/KuDYPG5kSkMoyW5EXSxHPDcsy9yP93fjIYmUIkXF4CUftNQ436rSL8egRmIvNao/np75Y
	9Y19KDAMF90H8JYCIi8P9b3MuhHzBzhjNAkg2jfyA5lygGOXGYn0UUcR3G00afA93hK++4xyZjb
	mcxU5/jsqhroHT4pPpeLa5E0RSLolGZ9Rj/pXZvv15drInIQ28LzaaRTuDSPJGRqLs9dziQOVaa
	5G0x6+ZIx2awSurOI0V02/DqYvHUpddZ6Cidsb6+h8P0obq04ZdhSPUu/QGEOUL5uuE=
X-Google-Smtp-Source: AGHT+IE5J0tSmSk6GcvsE2/fLt/3Q20eFVMVq5jC4RvCsoasCOuL8fOSx0O/M7FGfNya/xrTxu6lbA==
X-Received: by 2002:a17:90b:1dc3:b0:2ee:7c65:ae8e with SMTP id 98e67ed59e1d1-2fcb5a1105bmr1616124a91.11.1739915054735;
        Tue, 18 Feb 2025 13:44:14 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d6a1sm91643905ad.179.2025.02.18.13.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:44:14 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkVNz-00000002yN7-2Jyw;
	Wed, 19 Feb 2025 08:44:11 +1100
Date: Wed, 19 Feb 2025 08:44:11 +1100
From: Dave Chinner <david@fromorbit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bschubert@ddn.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for
 all inodes
Message-ID: <Z7T_K8xdJOxN7C0D@dread.disaster.area>
References: <20250217133228.24405-1-luis@igalia.com>
 <20250217133228.24405-3-luis@igalia.com>
 <Z7PaimnCjbGMi6EQ@dread.disaster.area>
 <CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>

On Tue, Feb 18, 2025 at 10:15:26AM +0100, Miklos Szeredi wrote:
> On Tue, 18 Feb 2025 at 01:55, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Feb 17, 2025 at 01:32:28PM +0000, Luis Henriques wrote:
> > > Currently userspace is able to notify the kernel to invalidate the cache
> > > for an inode.  This means that, if all the inodes in a filesystem need to
> > > be invalidated, then userspace needs to iterate through all of them and do
> > > this kernel notification separately.
> > >
> > > This patch adds a new option that allows userspace to invalidate all the
> > > inodes with a single notification operation.  In addition to invalidate
> > > all the inodes, it also shrinks the sb dcache.
> >
> > You still haven't justified why we should be exposing this
> > functionality in a low level filesystem ioctl out of sight of the
> > VFS.
> >
> > User driven VFS cache invalidation has long been considered a
> > DOS-in-waiting, hence we don't allow user APIs to invalidate caches
> > like this. This is one of the reasons that /proc/sys/vm/drop_caches
> > requires root access - it's system debug and problem triage
> > functionality, not a production system interface....
> >
> > Every other situation where filesystems invalidate vfs caches is
> > during mount, remount or unmount operations.  Without actually
> > explaining how this functionality is controlled and how user abuse
> > is not possible (e.g. explain the permission model and/or how only
> > root can run this operation), it is not really possible to determine
> > whether we should unconditional allow VFS cache invalidation outside
> > of the existing operation scope....
> 
> I think you are grabbing the wrong end of the stick here.
> 
> This is not about an arbitrary user being able to control caching
> behavior of a fuse filesystem.

Except the filesytsem is under control of some user, yes? Nobody has
explained why such functionality is actually safe to expose to user
controlled filesystems from a security and permissions perspective.
At minimum, this needs to be explained in the commit message so when
it gets abused years down the track we have a record of why we
thought this was a safe thing to do...

> It's about the filesystem itself being
> able to control caching behavior.

I'll give the same response regardless of the filesystem - walking
the list of all VFS cached inodes to invalidate them -does not work-
to invalidate the entire VFS inode cache. That guarantee is only
provided in unmount and mount contexts once we have guaranteed that
there are no remaining active references to any cached inode.

i.e. this is functionality that -does not work- as the filesystem
might want it to work. revoke() is what is needed to do full VFS
cache invaliadtions, but that does not exist....

> I'm not arguing for the validity of this particular patch, just saying
> that something like this could be valid.  And as explained in my other
> reply there's actually a real problem out there waiting for a
> solution.

And I've already pointed out that the solution lies within that
filesystem impementation, not the VFS.

i.e. If a filesystem needs to invalidate all existing inode objects
it has instantiated regardless of whether they are actively
referenced or not by other VFS objects, then the filesystem itself
needs to implement the invalidation mechanism itself to ensure
persistently referenced VFS inodes are correctly handled....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

