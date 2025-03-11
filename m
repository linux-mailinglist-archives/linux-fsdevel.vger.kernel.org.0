Return-Path: <linux-fsdevel+bounces-43683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7280A5B7FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 05:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85FFB7A5E40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 04:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3EB1EB18F;
	Tue, 11 Mar 2025 04:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YJ83Xb+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D738DDB
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 04:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741667086; cv=none; b=Widvb559VYgHZ/EJCpvzn4NacMZh1KUes7RCwHE3FbZru1/x8iQiLituomwBwMy0ww/SIlxq0OSdIUb6aU3yins4GchTROtR3KfTNU/K/KkMeyFd+gRJmPu3O86avOpzpptqIjLU814omiYhiiJwxfo+V6UusNQPtHeW+rq9uuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741667086; c=relaxed/simple;
	bh=j5z1fLpayUMlzlabBQ92aGfBlGRlGNR+1eQelo0TNaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlutQ/qzYw9shoDTjsISVbFm55FP5HezpPHCbrFqEfhS5JRnxkgDnvT0bHBDkVQP5fpuwmupRa4CJ1mVySsDoPbwjHVjGDiYJ/FNivvEcxOzkcv1DYrcYeirp/Y5uSYr6fBOTVSvUSLHJ9eFIc1d1bBG0ELXgEQJpuVuW1B9ryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YJ83Xb+X; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224341bbc1dso61117005ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 21:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741667084; x=1742271884; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jd9jbsqGomucBTWvUlBDrFAdf39fzaVwpxG2cHoLRTs=;
        b=YJ83Xb+XizHPNgnkUhouMtMd9onq+CjkoC4gk72FZC+1M5rgskeMB00fR/da03vDDr
         XOp44PGVyn5omrEyv/vZtcIqK18UreQn2/b33g3JYP8JqzeJi5e1TBCYfgX3YYYZy47D
         YdrjPXeiTsQEubpFmt+uKuv6rMzN3KeBt2mUdApwY8nCz22CKyWknqmgh2fr8zYF53Kf
         QInPGbpoFZ5/nK1gaFQ83S8kjgx/thOrQWLVdBT7IVwepTC/D3xXDMGSH7nY15oFjTKI
         vnnL6q3xP63SJGXxcUmHsppngDaJTAURzZDb2nEM0UqyqQ+NdoMMjE8XcH+VgGbBVgHp
         hkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741667084; x=1742271884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jd9jbsqGomucBTWvUlBDrFAdf39fzaVwpxG2cHoLRTs=;
        b=hklOgP3/5pMsmKpAM8kP0aMqbL2jl+DRtAtf8UkfyYZEnvfowy8yOqqOMjP+Z2EDt+
         z6QfRztQEMGWAcHhQfrrg+zdxgTBO9RA7e2MFTivEAvjt6MTIX1UpCW4LpH1Nlylx9Za
         v/H0ALDkx6yVrspzn4gG4/+3i3LiUWWtCWWtsITnm5eUogWdgKPw7Nz4CK0RZRgcnEAY
         oFO0V+rkVCyJ4aBJnBcKbD71NLa7jZF3Lp21odszWziDwhu8cDGBETGL1dzdb/0Hpogl
         qEgwg01sttEYbhuKaEoPbr03gjT7JkW/5mUBXL/l+bqqjv1jzj06H5/fsdHbFBijr3iz
         J3Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXggwup2n71cGRlDH29klIrBUvpdeRc4mKq2ZPuedsmNb7OJVDEMo1U9vuwCLc7FicbaJIWbcriLjPUUitN@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfF19UJZ1j5LmB0zpaA4/Qu+395Ppmlvws9g8lsmCiKMFMpUk
	N9uYaI5Zr2aH8e6ruUvXNykDv6+T1wl6FNhQJOtg3SK9g+8xBClILyW7C7fbQr0mk+VRIqUqxKP
	+
X-Gm-Gg: ASbGncuCbza8ktgjchOaTu9U6jcPb4w5jttqQmFbmT040kNzwNDeB3aiNloOlJqzgEZ
	62ucaNDZTYSWzuSvbfcElBlBN2BpjGuIaiEntq6wN6Jm4hzRD4iAmHKfv3eH9WU+vWkJLaG0NWF
	KqptfU0sLKCXcfwzA0znTor/B9Yycdz/eQ8w2RxV4coAY9SaPWPTyeYictDWWNG02uwiZAPPbPs
	swyEUXs7UFWNNGCDkv6jiQjMPSGG9/AVdLqZjWf1QWUfVViSxYu8VSv/MqrPaoFsB5tRNrIscEn
	QVAP33tnVT9kuQynIeOII3Xwr8qFG4AdRorPhZjHdIL3/QTN3H7zadNj+1QAwIuPGQ7xn/9abyq
	U4087hI3DoY66eAEHNmVr
X-Google-Smtp-Source: AGHT+IH1lEMca+e4bbQ8aq7gN4mYf2VrHtxSVKWBzsaz/yYrg5VAVA+Ej1hPzZHDLyLb/jbTzwoy0g==
X-Received: by 2002:a17:902:db06:b0:223:4d7e:e52c with SMTP id d9443c01a7336-22592e2014emr28779955ad.5.1741667084374;
        Mon, 10 Mar 2025 21:24:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e8617sm87332785ad.61.2025.03.10.21.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 21:24:43 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1trrAW-0000000Ba0u-39kB;
	Tue, 11 Mar 2025 15:24:40 +1100
Date: Tue, 11 Mar 2025 15:24:40 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	cve@kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: CVE-2025-21830: landlock: Handle weird files
Message-ID: <Z8-7CH7mwJtxpgyx@dread.disaster.area>
References: <2025030611-CVE-2025-21830-da64@gregkh>
 <20250310.ooshu9Cha2oo@digikod.net>
 <2025031034-savanna-debit-eb8e@gregkh>
 <Z8948cR5aka4Cc5g@dread.disaster.area>
 <33m2msv3elqbviurca3ayebwzfzzjenh472b246gf7hbkfjk25@sl7plpwvpxig>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33m2msv3elqbviurca3ayebwzfzzjenh472b246gf7hbkfjk25@sl7plpwvpxig>

On Mon, Mar 10, 2025 at 10:09:22PM -0400, Kent Overstreet wrote:
> On Tue, Mar 11, 2025 at 10:42:41AM +1100, Dave Chinner wrote:
> > [cc linux-fsdevel]
> > 
> > On Mon, Mar 10, 2025 at 03:36:04PM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Mar 10, 2025 at 01:00:50PM +0100, Mickaël Salaün wrote:
> > > > Hi Greg,
> > > > 
> > > > FYI, I don't think this patch fixes a security issue.  If attackers can
> > > > corrupt a filesystem, then they should already be able to harm the whole
> > > > system.
> > > > 
> > > > The commit description might be a bit confusing, but from an access
> > > > control point of view, the filesystem on which we spotted this issue
> > > > (bcachefs) does not allow to open weird files (but they are still
> > > > visible, hence this patch) and I guess it would be the same for other
> > > > filesystems, right?  I'm not sure how a weird file could be used by user
> > > > space.  See
> > > > https://lore.kernel.org/all/Zpc46HEacI%2Fwd7Rg@dread.disaster.area/
> > > > 
> > > > The goal of this fix was mainly to not warn about a bcachefs issue (and
> > > > avoid related syzkaller report for Landlock), and to harden Landlock in
> > > > case other filesystems have this kind of bug.
> > > 
> > > It was issue a CVE because the reviewers thought that it was a way to
> > > circumvent the landlock permission checks, based on the changelog text
> > > (note, creating a "corrupted filesystem" is quite easy to get many Linux
> > > systems to auto-mount it, so those types of issues do get assigned
> > > CVEs.)
> > 
> > That's an argument straight from the security theatre.
> > 
> > > If you all do not think this meets the definition of a vulnerability as
> > > defined by CVE.org as:
> > > 	An instance of one or more weaknesses in a Product that can be
> > > 	exploited, causing a negative impact to confidentiality, integrity, or
> > > 	availability; a set of conditions or behaviors that allows the
> > > 	violation of an explicit or implicit security policy.
> > 
> > Yes, so shall we follow this reasoning based on untrusted user
> > auto-mounts of untrusted devices to it's logical conclusion?
> > 
> > If an untrusted user is in control of the filesystem image, then
> > they don't need to corrupt the filesystem image to subvert the
> > system. They can just change the permissions on files, change ACLs,
> > change security xattrs (selinux, landlock, smack, etc),
> > replace the contents of file data (e.g. trojan executables), etc.
> 
> If user mounts are enabled, that comes with UID mapping, and device
> nodes disabled - no?

Not necessarily. Those security mechanisms are all optional mount
options under userspace control....

> Out of curiosity, what's keeping us from saying "user mounts are
> generally expected to be safe" for XFS?

What does "generally expected to be safe" actually mean?

If be "safe" you mean "won't crash the kernel if the structure has
been altered in detectable ways with", then we already largely tick
that box. However, there are whole classes of DOS attacks that are
very difficult to detect without rigorous, expensive runtime
checking (e.g. loops in btree pointers).

Hence while we catch almost all the the obvious out-of-bounds
corruptions within an object, detecting corruptions that require
spanning a largely unbound number of objects to detect are not
handled at all. I can corrupt a filesystem to induce an endless
btree search loop like this pretty easily with a little bit of
xfs_db magic. Yup, we even provide the tools to make doing stuff
like this easy...

If by "safe" you mean "can detect all cases where a metadata field
or file data has been tampered with", then XFS is completely unsafe
and should not be used.

We can't detect that a malicious actor has changed something like a
file permission field or the contents of a security xattr.  To do
that requires cryptographically secure signatures of metadata
objects and file data. We do not have that sort of feature in the
on-disk format. We expect users that need protection from such
tampering will use an envrypted block device to prevent malicious
actors from being able to mutate the filesystem structure in this
way.

> Obviously, that does expose a massive attack surface, so saying that for
> a C codebase that wasn't initially designed for it has a high pucker
> factor.
>
> But I've been impressed with syzbot's ability to find bugs, so barring
> architectural issues which I assume you'd know about it seems it's not
> nearly as crazy a thought as it used to be - for XFS, as you guys have
> been the most rigorous about hardening so I expect that's about as good
> as it's going to get until we start rewriting our filesystems in Rust.

The concerns I have about malicious actors are not mitigated by the
language the filesystem is implemented in.

It has everything to do with the fact that a filesystem like XFS or
ext4 cannot detect someone changing permissions on a file to, say,
add a setuid bit to the permissions field and then hide the
modification by recalculating the correct CRC for the metdata block.

Solving that problem requires a fundamentally different fs/device
trust model (i.e. the device is *never* trusted) and an on-disk
format that is based around "trust nothing" rather than "trust
everything".

-Dave.
-- 
Dave Chinner
david@fromorbit.com

