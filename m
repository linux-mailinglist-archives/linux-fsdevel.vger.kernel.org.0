Return-Path: <linux-fsdevel+bounces-45112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EBFA727DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 01:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4555A1736B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 00:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88025C133;
	Thu, 27 Mar 2025 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YzxnSyKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4A23CE
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743036564; cv=none; b=VJ1ZIzowwhhdJAkEFEpBN+pL/ppsWqb09yRF1OYU+ir5yyfrOdInIM2QcIA9dGilC38CSTGVX82S/F+Z/Yzkgb/vrAdalf47xdCMKLRqdP+jA24CS2oCccPXHxjHoTS+TkZ4gArPmxzNPfBcIWD/OSvfL1vJbxsNb44xcBx7/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743036564; c=relaxed/simple;
	bh=vas3lG2zNno1SckSd4WbKbyu5O+A37fZcy1pbm9gH3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evo0u3rVEx5cWA/RpfTS/oVnbS0fD5yVDRBmRZoSKVMYJMIhwc/eZUEyJSFwxGPTkHQm9/fiYRCU7kqXhAGUB9A8wPf1DoSQayexASdmW2/UwTCv/l1grK7mR+DoyrhTAfg+ftrayfGtM0aqoqYQZpxC9A0DIv1btzo/0oUihe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YzxnSyKm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2260c91576aso7894165ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 17:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743036562; x=1743641362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3ibaiMuu+COMl2CleDE3M0U3/NtyoxWAeWllDuQocU=;
        b=YzxnSyKmdSaV1poyNBEyI6UiHNoF7ftIb+lsNYesV3skiZ3zuhYmLnWlcrDmQSXNiJ
         Nz5kxCHlJ+ptIm99W8NuZsyJRMvFa08mDNdtmxCfosrC12NW01t5QGyW5jUlBldkobrR
         Pgcajrn+HP4G5P9pLrEFQKGaBzYxiqHwiuq7lshgjn3naALa6krCuwaIH9Kgx3WIUmGf
         HbqULy03IuRQtg7t+ehBdOZ1+jeYeXTEXjw5Eh3XOcCq0ZPcs/HePUHqjRwe/utKY7nc
         ltieODn9avUyZRgp3EYFxt/zN5t10cSom5Vf7Ch5FmhaJTdAkd8mhxcFhUJtKObf09eL
         xAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743036562; x=1743641362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3ibaiMuu+COMl2CleDE3M0U3/NtyoxWAeWllDuQocU=;
        b=B/9gL2na6K2M2yJoDp6IDKC3G6DgIX5+pzSuLQUGaRIHsquJ5LN9cLL5mFXqO9HzNT
         kbzAecmcyHtPm10D1JzNZzpkfsCOm7jAV/rprxIf7x9JBAhOazBSu+Wt+eV3i5QoZiin
         VvHxlUs8/GePpZHT0sfYkK4m8o3gOiWLPsjq8QGOg1RMyYjq1v/94ByDzs3wE4zXbYzT
         NeqOJr8JU6GFqbLPcNDXrQmCK6pTTj/5jEigG7jVaDEIQHFkpEJMEUeD353KAm6GF+iF
         th/3AgGOW/INNkN5nU281gIYqfLlC5QTnSIoBFI2cf3dyKq8BYKs4QsfBWK5oPvnw82H
         56yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrUJRyVCCdDQuR/jSBfI9IzfLTwwITAH69AdWEvnt3VIrTLiUb2z9WY1xMTvNjKCZp0tZHVQte6mXjjqtI@vger.kernel.org
X-Gm-Message-State: AOJu0YyMu4L0H6gpR8NwawGsXcqBE1kq3PYRmb0qp36WBAyB7brFagvP
	J8FTb1k+42HeoGmk7U8ECCW/hi6HfMzZWpZl3Dv603sB48xAxhaOBnAYQ0uNXLY=
X-Gm-Gg: ASbGncu3MhtJBkfTB77nugfgX8WNP6IhjkgyHLtFzU8p7chNPFUSybg8GEuLELTRfZp
	jL+KFWK7MNB5M8fwp47ivB9oUZ+aI5V+O8CkYEMM2K9yvfPSOMQqYcTDzBp9PJcy6437IkrGx1D
	W8yLtm4HdZUEGi4WJi13t9nUYwfXx6n0BqYw/MZmKGPyZTY+JLAJ6+x92RgWQZjPGIrBD1/wR7Q
	bEjViSmwXeaI40WsBHC99L6IkW8wWhdcA8R+Lzl1jtR479/pROxmmLlRNjqL98KFbXWBO/E3lA2
	uFXC+PEU54EF7XYr15HgWpZMg1OU9tHMqMgZGDexr8k39u6t8u+qHWeypdeqvSOjFIcMyVSMlQ9
	TzS+GIo4=
X-Google-Smtp-Source: AGHT+IFnAErnvRw6w6zYA8RwNXoDN/pZhTmE2gfdgW366+JFnzo8IFmWZzTDFcSClOKbvjQXE59Ogg==
X-Received: by 2002:a05:6a20:2d20:b0:1f0:e42e:fb1d with SMTP id adf61e73a8af0-1fea301bd45mr3128802637.36.1743036562470;
        Wed, 26 Mar 2025 17:49:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611c950sm13311890b3a.104.2025.03.26.17.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 17:49:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1txbQt-00000000kyo-0I5r;
	Thu, 27 Mar 2025 11:49:19 +1100
Date: Thu, 27 Mar 2025 11:49:19 +1100
From: Dave Chinner <david@fromorbit.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [LTP] [PATCH] ioctl_ficlone03: fix capabilities on immutable
 files
Message-ID: <Z-Sgj_XOVar8myLw@dread.disaster.area>
References: <20250326-fix_ioctl_ficlone03_32bit_bcachefs-v1-1-554a0315ebf5@suse.com>
 <20250326134749.GA45449@pevik>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326134749.GA45449@pevik>

On Wed, Mar 26, 2025 at 02:47:49PM +0100, Petr Vorel wrote:
> Hi all,
> 
> [ Cc Kent and other filesystem folks to be sure we don't hide a bug ]
> 
> > From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> > Make sure that capabilities requirements are satisfied when accessing
> > immutable files. On OpenSUSE Tumbleweed 32bit bcachefs fails with the
> > following error due to missing capabilities:
> 
> > tst_test.c:1833: TINFO: === Testing on bcachefs ===
> > ..
> > ioctl_ficlone03.c:74: TBROK: ioctl .. failed: ENOTTY (25)
> > ioctl_ficlone03.c:89: TWARN: ioctl ..  failed: ENOTTY (25)
> > ioctl_ficlone03.c:91: TWARN: ioctl ..  failed: ENOTTY (25)
> > ioctl_ficlone03.c:98: TWARN: close(-1) failed: EBADF (9)

None of these are -EPERM, so how is a missing capability that
results in -EPERM being returned cause -ENOTTY or -EBADF failures?

ohhhhh. ENOTTY is a result of a kernel side compat ioctl handling bug
w/ bcachefs.

bcachefs doesn't implement ->fileattr_set().

sys_compat_ioctl() does:

        case FS_IOC32_GETFLAGS:
        case FS_IOC32_SETFLAGS:
                cmd = (cmd == FS_IOC32_GETFLAGS) ?
                        FS_IOC_GETFLAGS : FS_IOC_SETFLAGS;

and then calls do_vfs_ioctl().

This then ends up in vfs_fileattr_set(), which does:

	if (!inode->i_op->fileattr_set)
                return -ENOIOCTLCMD;

which means sys_compat_ioctl() then falls back to calling
->compat_ioctl().

However, cmd has been overwritten to FS_IOC_SETFLAGS and
bch2_compat_fs_ioctl() looks for FS_IOC32_SETFLAGS, so it returns
-ENOIOCTLCMD as it doesn't handle the ioctl command passed in.

sys_compat_ioctl() then converts the -ENOIOCTLCMD to -ENOTTY, and
there's the error being reported.

OK, this is a bcachefs compat ioctl handling bug, triggered by not
implementing ->fileattr_set and implementing FS_IOC_SETFLAGS
directly itself via ->unlocked_ioctl.

Yeah, fixes to bcachefs needed here, not LTP.

> I wonder why it does not fail for generic VFS fs/ioctl.c used by Btrfs and XFS:

Because they implement ->fileattr_set() and so all the compat ioctl
FS_IOC32_SETFLAGS handling works as expected.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

