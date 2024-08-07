Return-Path: <linux-fsdevel+bounces-25368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ABD94B38A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121291C20E78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF5B155725;
	Wed,  7 Aug 2024 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="zxHeIlyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53B1509A5
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072737; cv=none; b=R1zpTj9U7WdUjt0Fd5dtuq4heh9sTOFuHzyicXA2lc6tkf7JXI4k1gG0FbMkv74SF23ojFq4jX+rlIj1J6c5s8vlctGgm+yDTJl2DBM9IKO3WlS6bn0akfxOatjUd2opJCQlpB0P3mtUpg22Wq9x/HbQX5Dob/it8O4UWpmcH4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072737; c=relaxed/simple;
	bh=JvgOTrA8muLxkb9snio+SKveB5C92qAr1ig3sSnLIh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULkMxxeoIZTEpMwZ0em+J1hrawPkwXwRlRnvhfxf8V+pFzb8JWBrrJy5XYsGBOy9iumJCGfXSpe5eL2Wl4fL0xGEjR2N3vDWB4nutOmHXyurwm/fFpCVSrAeEd+KtjSoTutDZbamQXIGTHCeeqeYkTz8g8Ai4sK6YrxP0zxQZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=zxHeIlyt; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-81fd1e1d38bso15687339f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 16:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723072735; x=1723677535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lB5dWAtO9C/GZ2ZD8NoIfBvlhtrinFTt8QPSRvBFGjI=;
        b=zxHeIlytEHm4JTQAXhCLlLCJzs4s7NCDB4oUyafY7s6aulOFo73TH++FXji8MxUqGv
         V3QVwHqDUBMkm5kHGeCsfa1WXcSYPpBWkJUE19gmNsRa6/aFui3n0t4NFuQSvii4qRQp
         JlQw/XP5E1QqIRtOF0MGXu3TUGw9GW5r/LvpR8Ni2CePO4Fjhdd3OJGjHPbc4kC8zSpn
         +49nCYqoPkDCM8xN7EEM8vbTWc+SzjBM0qTV/DMAYUoVhsopQxctJ/UU1Ol2o8zRJENz
         SxX6ouLs+Hij8jPG0ZE9Kv4VtGJZW+aWIeDfwAkK52/tsVa8RzEHBIXXNh3boKd40m6d
         nNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723072735; x=1723677535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lB5dWAtO9C/GZ2ZD8NoIfBvlhtrinFTt8QPSRvBFGjI=;
        b=CgPDTfYh1zqXOOpUB61xp+ZFWQETRxHCp22LB2HLPLsbnzYZKIrf+qpE2www8hKbXf
         Y2xhYNyuXxRUPZa1xd16RBcjo7BFfk4S9TaU5Myz/Uv1Qpvx6MXLigDtw2t3XFMd4cq/
         WBlzfF1b0uGE7A1IH/qwbU3r7E8vxpTShRpUzvmIloYOhaZlbwoCpaeLkNjTr1MwHeUz
         eMSgFlOAjtE6C5u8Rqpt0jlnQiVJ87VXS/m5e7x9ybuli0mze+Puc+A9J0q+rU8ey6VE
         EAzmd/dTrhGbwT9zACfK84FohmO5la8NKgmnHCgfhx5crRQ3eS1xSkRwfFk/zqGIKG61
         1Nlw==
X-Gm-Message-State: AOJu0YztJQ+jCLzOZyWPguYwctJu0DZvxLTqUMXQPpDsYMZoK2rATDiW
	ej7XIG6DgzjMHd2EslMbpSq4UUa2BtwDgOg+ZKMcSUKc/FWgN2GXdtv6T5cjTqg=
X-Google-Smtp-Source: AGHT+IH4ttj7E/SWTwaASDIHMpt4C7Aeo1kR89aQhWdv5giATZYWL9lqyIeUrECvBYZUTsUBxhRaMg==
X-Received: by 2002:a05:6e02:1a4d:b0:375:da94:e46b with SMTP id e9e14a558f8ab-39b5ec7ff8emr1697095ab.5.1723072734970;
        Wed, 07 Aug 2024 16:18:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5cdsm8921081a12.2.2024.08.07.16.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:18:54 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sbpvf-0094rL-1h;
	Thu, 08 Aug 2024 09:18:51 +1000
Date: Thu, 8 Aug 2024 09:18:51 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH RFC 0/13] fs: generic filesystem shutdown handling
Message-ID: <ZrQA2/fkHdSReAcv@dread.disaster.area>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>

On Wed, Aug 07, 2024 at 08:29:45PM +0200, Jan Kara wrote:
> Hello,
> 
> this patch series implements generic handling of filesystem shutdown. The idea
> is very simple: Have a superblock flag, which when set, will make VFS refuse
> modifications to the filesystem. The patch series consists of several parts.
> Patches 1-6 cleanup handling of SB_I_ flags which is currently messy (different
> flags seem to have different locks protecting them although they are modified
> by plain stores). Patches 7-12 gradually convert code to be able to handle
> errors from sb_start_write() / sb_start_pagefault(). Patch 13 then shows how
> filesystems can use this generic flag. Additionally, we could remove some
> shutdown checks from within ext4 code and rely on checks in VFS but I didn't
> want to complicate the series with ext4 specific things.

Overall this looks good. Two things that I noticed that we should
nail down before anything else:

1. The original definition of a 'shutdown filesystem' (i.e. from the
XFS origins) is that a shutdown filesystem must *never* do -physical
IO- after the shutdown is initiated. This is a protection mechanism
for the underlying storage to prevent potential propagation of
problems in the storage media once a serious issue has been
detected. (e.g. suspect physical media can be made worse by
continually trying to read it.) It also allows the block device to
go away and we won't try to access issue new IO to it once the
->shutdown call has been complete.

IOWs, XFS implements a "no new IO after shutdown" architecture, and
this is also largely what ext4 implements as well.

However, this isn't what this generic shutdown infrastructure
implements. It only prevents new user modifications from being
started - it is effectively a "instant RO" mechanism rather than an
"instant no more IO" architecture.

Hence we have an impedence mismatch between existing shutdown
implementations that currently return -EIO on shutdown for all
operations (both read and write) and this generic implementation
which returns -EROFS only for write operations.

Hence the proposed generic shutdown model doesn't really solve the
inconsistent shutdown behaviour problem across filesystems - it just
adds a new inconsistency between existing filesystem shutdown
implementations and the generic infrastructure.

2. On shutdown, this patchset returns -EROFS.

As per #1, returning -EROFS on shutdown will be a significant change
of behaviour for some filesystems as they currently return -EIO when
the filesystem is shut down.

I don't think -EROFS is right, because existing shutdown behaviour
also impacts read-only operations and will return -EIO for them,
too.

I think the error returned by a shutdown filesystem should always be
consistent and that really means -EIO needs to be returned rather
than -EROFS.

However, given this is new generic infrastructure, we can define a
new error like -ESHUTDOWN (to reuse an existing errno) or even a
new errno like -EFSSHUTDOWN for this, document it man pages and then
convert all the existing filesystem shutdown checks to return this
error instead of -EIO...

> Also, as Dave suggested, we can lift *_IOC_{SHUTDOWN|GOINGDOWN} ioctl handling
> to VFS (currently in 5 filesystems) and just call new ->shutdown op for
> the filesystem abort handling itself. But that is kind of independent thing
> and this series is long enough as is.

Agreed - that can be done separately once we've sorted out the
little details of what a shutdown filesystem actually means and how
that gets reported consistently to userspace...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

