Return-Path: <linux-fsdevel+bounces-27528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AFC961E4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 07:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67002B21BE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9F749641;
	Wed, 28 Aug 2024 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="qW0QMJZG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723821332A1
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724823535; cv=none; b=BrUxK30JRzdKuhplirjHRvVjmHyn7LC+JfFvDlrxc9iI+Pm/xQY07oiJbFjdzgX3AYJSUmrh8wlPlw7sveAT+rcwf5rmSz6FiH/BLDF9Hi4FFtpuFQleCPBoFhsH6IVcZ6iWq4yvURN1qSKpgBrWAFDWA4Xv1kWHkfSIFmputBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724823535; c=relaxed/simple;
	bh=H7r5FWPMCUc5oEJXU463isRkAlGFvMt935cX3Au7iYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxiGg2qVIkz3/3v1rn/uPCBYQ6yYcLyyXAuAw65N3/5PblOincRIdF5kh2IX2Fi5XHvxnohQKmF2ZxdO6JIm6ZVsodBEs1aqfeSnRteNLN2qtncnuhhkthnVgvUHm9XOpp/JTw+KvlwllYVYeXVRG8yp6lxJuXo4EYNnGGvQQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=qW0QMJZG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-714226888dfso5677735b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 22:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724823533; x=1725428333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mLyQ3qAoevQekgQ8bOf6mV7MxVHUVUaI8Mf3zMNoquw=;
        b=qW0QMJZG07f5cSxi72jChQSDvhj638MnQI9Y/w33mD0vk6xnPqPGL/2GIlyTNJDKGB
         n3yGkAfCcpfe6P0LXGvIPVLYBgaujAF7KGDZgvjMZkjTF3OyUPAlTEYXbstAsIXSNRsn
         ECunKF3Q8F856lOFks17EvCiSujaxKGE+30qOQIvSnkF56jVE+YYYrpnIe2bu0kly+G7
         dCC44pLQly4AnqQQ8jRRL0lSIMB9FQmlFVBVO0kHT2h2OAyYJAkCkaKGoSDxIUIP1dJ5
         KYWhQxFWZMw5q98gzcIEDlCAp/2SysYRK0RNahHhtSmRJlsLJoriHkRY+xWKddz3Ls5m
         EPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724823533; x=1725428333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLyQ3qAoevQekgQ8bOf6mV7MxVHUVUaI8Mf3zMNoquw=;
        b=up3isVZb1dLIfpZWUAZUueH9B2KIJJafycxLue/sfMntab8u6TiYsPE4Hi9OyvBOTd
         1/c5RvvTMrm49zKuDps1k8HsdbyCz/HNtSfSwq62c6QCypq3O6q8A9+1NJYMdkCzxfaT
         UsBqNTE8RzZV0rYMVi+LXtSkIuSqYeUgUEkrH6EiTCp+a0fuS+DgYISXS+ZgdjrkCG4Y
         HYlj2bquzWkb/on2XwwGUG79P69W5tAFfeitsV8rPVY1sefCuZj2h8iISCmQwg7no6so
         c3oOHaHSvTlsf3aiQD9Nag9CS8Qjr7RdVniK+Vamvhtkzd+uHHZ6+XNUYQkfm71Y/M1z
         kfBg==
X-Forwarded-Encrypted: i=1; AJvYcCUgM2diSA2BYhnCrjZwWfminuIfPMlAzyCH4GemI+Y9Tbxz6VZUxDsTCBXAPMoA6Vp2E8gqF7AxZ7sTSSI3@vger.kernel.org
X-Gm-Message-State: AOJu0YyWL+00epJjNs1W62WF8904CsyGsJQxBgXkakyvO32W3ukDGlp9
	9D+Y1HWL3uJrhqdeWIzMSZaJvJ9U/ZLdRi9PnxECrodPwlqW8T9V6KmLGpM+D48=
X-Google-Smtp-Source: AGHT+IGnfrz84P242OWlhNyx4D+U0UOVTCtjZYAQTtzwoKNYvjlYe88Io15LFksyT1cciS1kK+Z7Hg==
X-Received: by 2002:a05:6a21:3318:b0:1c4:7d53:bf76 with SMTP id adf61e73a8af0-1cc89ee965emr16298432637.38.1724823532717;
        Tue, 27 Aug 2024 22:38:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445f8dabsm632412a91.13.2024.08.27.22.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:38:52 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjBOL-00FOUt-2i;
	Wed, 28 Aug 2024 15:38:49 +1000
Date: Wed, 28 Aug 2024 15:38:49 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>, jack@suse.cz,
	viro@zeniv.linux.org.uk, gnoack@google.com, mic@digikod.net,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <Zs636Wi+UKAEU2F4@dread.disaster.area>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <20240827021300.GK6043@frogsfrogsfrogs>
 <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>
 <20240827053712.GL6043@frogsfrogsfrogs>
 <20240827-abmelden-erbarmen-775c12ce2ae5@brauner>
 <20240827171148.GN6043@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827171148.GN6043@frogsfrogsfrogs>

On Tue, Aug 27, 2024 at 10:11:48AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 27, 2024 at 11:22:17AM +0200, Christian Brauner wrote:
> > On Mon, Aug 26, 2024 at 10:37:12PM GMT, Darrick J. Wong wrote:
> > > On Tue, Aug 27, 2024 at 10:32:38AM +0800, Hongbo Li wrote:
> > > > 
> > > > 
> > > > On 2024/8/27 10:13, Darrick J. Wong wrote:
> > > > > On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
> > > > > > Many mainstream file systems already support the GETVERSION ioctl,
> > > > > > and their implementations are completely the same, essentially
> > > > > > just obtain the value of i_generation. We think this ioctl can be
> > > > > > implemented at the VFS layer, so the file systems do not need to
> > > > > > implement it individually.
> > > > > 
> > > > > What if a filesystem never touches i_generation?  Is it ok to advertise
> > > > > a generation number of zero when that's really meaningless?  Or should
> > > > > we gate the generic ioctl on (say) whether or not the fs implements file
> > > > > handles and/or supports nfs?
> > > > 
> > > > This ioctl mainly returns the i_generation, and whether it has meaning is up
> > > > to the specific file system. Some tools will invoke IOC_GETVERSION, such as
> > > > `lsattr -v`(but if it's lattr, it won't), but users may not necessarily
> > > > actually use this value.
> > > 
> > > That's not how that works.  If the kernel starts exporting a datum,
> > > people will start using it, and then the expectation that it will
> > > *continue* to work becomes ingrained in the userspace ABI forever.
> > > Be careful about establishing new behaviors for vfat.
> > 
> > Is the meaning even the same across all filesystems? And what is the
> > meaning of this anyway? Is this described/defined for userspace
> > anywhere?
> 
> AFAICT there's no manpage so I guess we could return getrandom32() if we
> wanted to. ;)
> 
> But in seriousness, the usual four filesystems return i_generation.

We do? 

I thought we didn't expose it except via bulkstat (which requires
CAP_SYS_ADMIN in the initns).

/me goes looking

Ugh. Well, there you go. I've been living a lie for 20 years.

> That is changed every time an inumber gets reused so that anyone with an
> old file handle cannot accidentally open the wrong file.  In theory one
> could use GETVERSION to construct file handles

Not theory. We've been constructing XFS filehandles in -privileged-
userspace applications since the late 90s. Both DMAPI applications
(HSMs) and xfsdump do this in combination with bulkstat to retreive
the generation to enable full filesystem access without directory
traversal being necessary.

I was completely unaware that FS_IOC_GETVERSION was implemented by
XFS and so this information is available to unprivileged users...

> (if you do, UHLHAND!)

Not familiar with that acronym.

> instead of using name_to_handle_at, which is why it's dangerous to
> implement GETVERSION for everyone without checking if i_generation makes
> sense.

Yup. If you have predictable generation numbers then it's trivial to
guess filehandles once you know the inode number. Exposing
generation numbers to unprivileged users allows them to determine if
the generation numbers are predictable. Determining patterns is
often as simple as a loop doing open(create); get inode number +
generation; unlink().

That's one of the reasons we moved to randomised base generation
numbers in XFS back in 2008 - making NFS filehandles on XFS
filesystems less predictable and less prone to collisions.  Given
that we are actually exposing them to unprivileged users, we
probably also need to get rid of the monotonic increment when the
inode is freed and randomise that as well.

And now I see EXT4_IOC_SETVERSION, and I want to run screaming.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

