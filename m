Return-Path: <linux-fsdevel+bounces-36312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB87A9E12CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 06:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4672827D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 05:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F9166F25;
	Tue,  3 Dec 2024 05:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2vwkOAxl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C81817
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 05:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202771; cv=none; b=BvZhgGwEYFxoiRcxkJLTJMdr6yvPcznRhYMD5mWTVjcmBN/41+FXgnKW8wKDYZfJJWnnK+PALfsmq7mIiGEVgbq6HryrHgpdpXtjHFUBPuBYmz5kedTXaEurUJqZeAtpwNl7cZJK3RXIl0WmoI+wDS6bfhXFQcOzQxowWovOZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202771; c=relaxed/simple;
	bh=b48g4LKSiwiiTSzXL69+UPIfbmjZka+UXatcYP/TR0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGCMYCJwd/4O/pXKJE91rdyhI48RdR96JqPYl6yCo4kse22zn5egJMyEZvpE805GNgxFtGFlVJ7vaai7d1uZH2DckweqemoTr0NXdkBXpSxgSTDTo2jIJnpWlHBNsh+up5DBN1tMkS/yORo0wqIEYZF6n8qGLjb2dIA3fyOKHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2vwkOAxl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2153e642114so35330555ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 21:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733202769; x=1733807569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvAZgkvoeFuwJr2vN/xb6iPfAzzjAFXfx0pAb8Ga6n4=;
        b=2vwkOAxlxcSfSjE2LATW9zsNIe07CW50gsYAG17FkjjiXPNd7N1+ZRclj9469qfA+i
         aDA+uTKPC/TAPYyNZbzkR6LHEGgKTBg2xKHa0RAO3cprElLC1hyc3/+m0evkD+yVaaU2
         3cb/rV/XZwythkoBbXdEVD5c6Y7cMTYjiX4eDJDA55fEp+sW+7S78u2n3ludly+vyRP9
         C32w5t935PIIxAtQVsR+xtmgdmUWjPvp+nM43LMxIaZSD+tHQW8yDaTAenBwVT+Ek9uz
         zDNmO8+fcfTRScp3NUaxfcOwtpRTL4TvTgwYfmlI1EmwR0Pt1+8RjuP/lb+e5I4dN5Ug
         MP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733202769; x=1733807569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvAZgkvoeFuwJr2vN/xb6iPfAzzjAFXfx0pAb8Ga6n4=;
        b=SDwqfzjA4n5rG6lIH1gCobJo9OvjyYguN7PUkrhjaRTTTocfBhRkjIIwm3BfnlB9No
         GbRtFxUrrBAXfypmiG6Grmpk8L4hF0wUbmrRfE2d5NXKz7wMtl5CPnvmbP0CHOQPiYKx
         ZpvixemHMrvVKdyEw+Nhb41AJK1G7g4H5MJdM9rxfK9peXBSTPTTKo2TVHfGfjJwhNzq
         z2iB/8KiiePdueSZZVnZFPtqiXzWmvZzf+4TrEna+6q7zEpXIm16VO7J9EKJp1qezsc8
         iFTl9PUf8RE33sQW7KUKzSX1EG9OecxfY4hiNG7ndUsD8nXo5bP+w8O9oGGMW+F/VMnq
         c8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfXRpLPyM9N1q5bLM15RSumsbSgIvtQ9uilh6qlj3Yq3CrjkmXIL4hFkaxpkJnSi2L0djz9qhs0yv4i/It@vger.kernel.org
X-Gm-Message-State: AOJu0YwucSz1PL9icvVz3xLfhyNRoz6UsjBNRBDglv+EZooPcLT6w6Qj
	bB1yH7qO2/g/DwfposkUFjD8qLBoNmUxdZqKVLhR6KHGDk6xI3AuuodqMPY/8IipJoxFK0v7/tC
	k
X-Gm-Gg: ASbGncv3zStrvtWHlx6IuCjdNCaeOusC9Pv7smgSUvroU6Z3lMhSNF8stBgPDwYJ2R4
	SMtdrWJv7lMxtW6AfrVwCH7H5U9O+uwKI3Z4ODt8AUs7LWBIP9lAQ7HnejdHS1pZ7UugtuvrDdI
	8LLnG240WfddBuZpyGSX2QKgAuUFMk/mLYfBdJKYIamHbqTLX428x2eZzxZdCrm3u+H7EG4cfzU
	JyhuQH4PqQE6PPS62ajc2L4qMtbqnUteUed68ey5uPpAH2SlDZeyN43bkHHdWoWp0OLhX6ifz/I
	Y1E0ju9GDxQ7/frPav+Jkjry3Q==
X-Google-Smtp-Source: AGHT+IGRdweGNHko0nzZAdOWtKe26+Z0FHG5/mcWDUcn92IVlPRyZDLZRrvkEzXqUEPAmGbsRod+DA==
X-Received: by 2002:a17:902:ec8e:b0:215:7a1a:cb9b with SMTP id d9443c01a7336-215bd1cd7ebmr14199955ad.21.1733202768743;
        Mon, 02 Dec 2024 21:12:48 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215964b6b81sm26221265ad.167.2024.12.02.21.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 21:12:48 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tILDJ-000000060iN-1BXy;
	Tue, 03 Dec 2024 16:12:45 +1100
Date: Tue, 3 Dec 2024 16:12:45 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jon DeVree <nuxi@vault24.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] 2038 warning is not printed with new mount API
Message-ID: <Z06TTb3Jel0QEZry@dread.disaster.area>
References: <Z00wR_eFKZvxFJFW@feynman.vault24.org>
 <20241202-natur-davor-864eb423be9c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-natur-davor-864eb423be9c@brauner>

On Mon, Dec 02, 2024 at 12:55:13PM +0100, Christian Brauner wrote:
> On Sun, Dec 01, 2024 at 10:57:59PM -0500, Jon DeVree wrote:
> > When using the old mount API, the linux kernel displays a warning for
> > filesystems that lack support for timestamps after 2038. This same
> > warning does not display when using the new mount API
> > (fsopen/fsconfig/fsmount)
> > 
> > util-linux 2.39 and higher use the new mount API when available which
> > means the warning is effectively invisible for distributions with the
> > newer util-linux.
> > 
> > I noticed this after upgrading a box from Debian Bookworm to Trixie, but
> > its also reproducible with stock upstream kernels.
> > 
> > From a box running a vanilla 6.1 kernel:
> > 
> > With util-linux 2.38.1 (old mount API)
> > [11526.615241] loop0: detected capacity change from 0 to 6291456
> > [11526.618049] XFS (loop0): Mounting V5 Filesystem
> > [11526.621376] XFS (loop0): Ending clean mount
> > [11526.621600] xfs filesystem being mounted at /mnt supports timestamps until 2038 (0x7fffffff)
> > [11530.275460] XFS (loop0): Unmounting Filesystem
> > 
> > With util-linux 2.39.4 (new mount API)
> > [11544.063381] loop0: detected capacity change from 0 to 6291456
> > [11544.066295] XFS (loop0): Mounting V5 Filesystem
> > [11544.069596] XFS (loop0): Ending clean mount
> > [11545.527687] XFS (loop0): Unmounting Filesystem
> > 
> > With util-linux 2.40.2 (new mount API)
> > [11550.718647] loop0: detected capacity change from 0 to 6291456
> > [11550.722105] XFS (loop0): Mounting V5 Filesystem
> > [11550.725297] XFS (loop0): Ending clean mount
> > [11552.009042] XFS (loop0): Unmounting Filesystem
> > 
> > All of them were mounting the same filesystem image that was created
> > with: mkfs.xfs -m bigtime=0
> 
> With the new mount api the placement of the warning isn't clear:
> 
> - If we warn at superblock creation time aka
>   fsconfig(FSCONFIG_CMD_CREATE) time but it's misleading because neither
>   a mount nor a mountpoint do exist. Hence, the format of the warning
>   has to be different.
> 
> - If we warn at fsmount() time a mount exists but the
>   mountpoint isn't known yet as the mount is detached. This again means
>   the format of the warning has to be different.
> 
> - If we warn at move_mount() we know the mount and the mountpoint. So
>   the format of the warning could be kept.
> 
>   But there are considerable downsides:
> 
>   * The fs_context isn't available to move_mount()
>     which means we cannot log this into the fscontext as well as into
>     dmesg which is annoying because it's likely that userspace wants to
>     see that message in the fscontext log as well.
> 
>   * Once fsmount() has been called it is possible for
>     userspace to interact with the filesystem (open and create
>     files etc.).
> 
>     If userspace holds on to to the detached mount, i.e., never calls
>     move_mount(), the warning would never be seen.
> 
>   * We'd have to differentiate between adding the first mount for a
>     given filesystems and bind-mounts.
> 
> IMHO, the best place to log a warning is either at fsmount() time or at
> superblock creation time

It has to be done either during or after the ->fill_super() call
where the filesystems read their superblocks from disk and set up
the VFS superblock timestamp limits.

Some of use filesystem developers wanted this timestamp warning to
be implemented in each filesystem ->fill_super method for this
reason - on-disk format information/warnings should be located with
the code that sets up the filesystem state from the on-disk
information.

> but then the format of the warning will have to
> be slightly, changed.

Yes please!

This was the other main objection to a generic VFS timestamp warning
- inconsistent mount time log message formats.  Filesytsems have
their own message formats with consistent identifiers, and that's
really what we should be using here.

> We could change it to:

> [11526.621600] xfs filesystem supports timestamps until 2038 (0x7ffffff

Nope, now we have -zero- idea what filesystem emitted that warning
when multiple filesystem are being mounted concurrently.

i.e. it should be formatted exactly as xfs_notice(mp, ....) would
format it:

 [11526.618049] XFS (loop0): Mounting V5 Filesystem
 [11526.621376] XFS (loop0): Ending clean mount
 [11526.621600] XFS (loop0): Filesystem supports timestamps until 2038
 [11530.275460] XFS (loop0): Unmounting Filesystem

We really -do not care- what the mount point is - it only needs to
be emitted once, and should be emitted at the same time and format
as all the other on-disk format feature messages that the filesystem
emits from ->fill_super context.

> libmount will log additional information about the mount to figure out
> what filesystem caused this warning to be logged.

No.

That does not work when all you have to debug a crash is the
dmesg log output and a stack trace. We have no idea what filesystem
that log message belongs to. This is a real problem - just look at a
typical syzbot failure trace. Which of the multiple filesystems it
has mounted at any given time triggered that message? 

-Dave.
-- 
Dave Chinner
david@fromorbit.com

