Return-Path: <linux-fsdevel+bounces-13144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8F86BC60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 00:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C249F289A08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 23:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2172932;
	Wed, 28 Feb 2024 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="a/3onSKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F59772935
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164528; cv=none; b=bBFHzga4r9bqtvHrk6KYNii6BA3gBIrQBV9FIM17YJ37U59CJt5Ng8oh46FemSa6Dqif/VoSiDqKGSFEwHu1Ypjst3qI07X/OvKuBTen7EFzALomd3NTIEn4nhFy8O67H1uqt4WFQHerwRig1aiot077vagrNDWn2MiSZakNH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164528; c=relaxed/simple;
	bh=+ic8jIhMpnFeyLYIMI7m+bwzlHsW6uhzNWQl2gvDD5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGGQ5KiH5tWFk05qIDcUDwaySeMVumQLnEUg2p4ieyiyF5ekHWOoeUWay1w1l45vgXb1iqFZ5dX5ung4zoOJivIwdQccutpuRDt7St5Eudj3GWcVOIuVZOPR5a8lxOxcPBcRwtTYR+AVJ70rKeiXW8HOJlqnf6mcicuzbN+L4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=a/3onSKF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e5760eeb7aso244066b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 15:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709164525; x=1709769325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9U6NaPE28mZH6SU63ea3EXHuOrr0bVVPLt1Ke52ONU=;
        b=a/3onSKFtCAVYDaaFAABLBGIU+fnbjISStwaLzXRiJoS+tuMAHG1zNrFV9wSi4IBqT
         zo59rUOms2dfTj+TsKbc0lBBd5n3Cjs2sHy2Fg3mFIoO6FPOwKPyyJU26a4DEGC2wVfU
         Z/CqGW0TYY1b3aenXtkkUnH1KZmwv7+AWPC8y//AqZvFDIpkveVsKVny03poH2tS0+i1
         lO5UPnI39B7V2X5iiHyMhAhQwZqjDT+Wuh4G6kXyRgk1ywetpGPX8JRfG1uGGlWsOGma
         CsJ2qtuUuthW8w3Cbrnv3gEWiRJczyLoOob50aWHnql0yAZgUKI+ND7y2mauhvDbRZ3G
         LhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164525; x=1709769325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9U6NaPE28mZH6SU63ea3EXHuOrr0bVVPLt1Ke52ONU=;
        b=VZ6aAx7QXIS+Q6BzHcec6NTnETeikXV6EPJ9zxuLVLoZYojr2/G6TyYVNsyPWvSulz
         t9UkroMBUc5weUvQfRPqGcNpgRbNMUAmB4/nJ20VqYpp3KrsQZjqFtD540uBRZAv2w2W
         CxcTWy8L3cHi2SvspdeWueQHoW6apzJm1Q4qKeBZqpdNUtPyPL+IqknxIGc6O2x+dBSI
         EqxAfEAUXBZtVfZECE+fj/FXd24G9EkNfcPrr/Dh3Z+IkwmUE2lLZIgK7fy870A9HLis
         xrHrk+I2iyGfEEror2j3YcOeVMrTDbMuNYNZI3hq/b8StUYMp/1YX7e0R1ujQc4pr5d4
         ubmw==
X-Forwarded-Encrypted: i=1; AJvYcCU1DNjioVeQ4hsBd0kDTyAmGaH9hfgGZUFMIRgP0+HSSkrQuZx6gr1t99YwY3no94es1xZcotfe7BA3FJ4CgKPHv4xKUPJuvO98pX+KQQ==
X-Gm-Message-State: AOJu0YxxGp7XGNnUSKixxiy1hCtVwqTe2m/HFrueeJL+szt75afKYYzu
	Q73ULOAE578KqGDj8Y8OC+Wxt8K56hY/E7GSm4DGUI/GN1ej8KQ5zN2jIPLt+zg=
X-Google-Smtp-Source: AGHT+IF43SvZvswOCVy0vOnsKZBZhkb7nurjYRAnvTxt/DureqGnjVRmTrz7JbsTpIT5oKeuwEIUzg==
X-Received: by 2002:a05:6a20:e68c:b0:19e:9966:228d with SMTP id mz12-20020a056a20e68c00b0019e9966228dmr920182pzb.20.1709164525476;
        Wed, 28 Feb 2024 15:55:25 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b001dbad2172cbsm36098plb.8.2024.02.28.15.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 15:55:25 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rfTli-00CsE0-0x;
	Thu, 29 Feb 2024 10:55:22 +1100
Date: Thu, 29 Feb 2024 10:55:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs: stop advertising SB_I_VERSION
Message-ID: <Zd/H6pf1YM0mTk1r@dread.disaster.area>
References: <20240228042859.841623-1-david@fromorbit.com>
 <20240228160848.GF1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228160848.GF1927156@frogsfrogsfrogs>

On Wed, Feb 28, 2024 at 08:08:48AM -0800, Darrick J. Wong wrote:
> On Wed, Feb 28, 2024 at 03:28:59PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > The redefinition of how NFS wants inode->i_version to be updated is
> > incomaptible with the XFS i_version mechanism. The VFS now wants
> > inode->i_version to only change when ctime changes (i.e. it has
> > become a ctime change counter, not an inode change counter). XFS has
> > fine grained timestamps, so it can just use ctime for the NFS change
> > cookie like it still does for V4 XFS filesystems.
> > 
> > We still want XFS to update the inode change counter as it currently
> > does, so convert all the code that checks SB_I_VERSION to check for
> > v5 format support. Then we can remove the SB_I_VERSION flag from the
> > VFS superblock to indicate that inode->i_version is not a valid
> > change counter and should not be used as such.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> 
> Seeing as NFS and XFS' definition of i_version have diverged, I suppose
> divorce is the only option.  But please, let's get rid of all the
> *iversion() calls in the codebase.
> 
> With my paranoia hat on: let's add an i_changecounter to xfs_inode and
> completely stop using the inode.i_version to prevent the vfs from
> messing with us.

Ok, I'll do that in a new patch rather than try to do everything in
a single complicated patch.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

