Return-Path: <linux-fsdevel+bounces-13022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB43986A3EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 00:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A00B249D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024B25645C;
	Tue, 27 Feb 2024 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="aOhuGBIQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA955E48
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 23:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709077572; cv=none; b=MuUluRIH65lPUWT8Z0NF8guiuPu0VuuKOaQeXTgnQYvU2mFLK8XoOZ99ma607S4Q2eVaf6sXyd7ebeIYxx5ZHoJ8EzW9tSEYdkuHS+1f8XoiUMrjQebh5W8ai7aBe4OoHpjt0c6BGDOWBnvqHP4fpEB1CUYDg6yJ++Lo2IZBkN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709077572; c=relaxed/simple;
	bh=05y20ylw63Jp1XqpyS0hDAMF7jD069gsedUHFYisPC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv1YeJYm/NB2psm9Ov5pnBvZw7JKOhqbDATTWWzda0/GOPvxNloYSrw2yEPMLt9aw2F6erYurX51fVRSNVb6Xgrb5/OpC5GlHt207nO326L2gLwMroUL/DGBhAg8sJSVLjuNyJpf/SRC0B71J2cYcjjgUVWT1xcsuLd0fyb3BMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=aOhuGBIQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dcafff3c50so19330295ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 15:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709077570; x=1709682370; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2J0nG5bx4RWetieNgdHsq0BhUr6Alc5BaFD0GmCSBJo=;
        b=aOhuGBIQuPV5Cs3yAMIKBc9OUtkAiAsR5pCdlixqbhqpC41z/FQFWVNeiKdqgE+wh/
         zBV+g2LLQ3AKHc1rC22P0KHdeXsi3thn7ao0Ns52kBne8HdPSYtm49dpA6V5SXBkTA7r
         RTgBdy5t4NT576MIMWKrRec2dNb1haedG4Qdg+EXuYKKfbFBOz2j37eyZUUkf0DMR/OK
         mKHY1gScrTrl48jSvFsXKtfUHrIvCCwtoiGQgrkmBiU0o1VtbVTcAhi1Q/qxy2E0S9YZ
         h1euWDL9YmdVh9/q0/sCHY7bOhOn0sJ58gy83KPABTXQANTwOvppoIHEsj4MpNYMvXAd
         I2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709077570; x=1709682370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2J0nG5bx4RWetieNgdHsq0BhUr6Alc5BaFD0GmCSBJo=;
        b=F6Xi+hBcRveUJBKJsCRaPLUbOCKH4INDL6R5KUBmNK8+Poa2y6wao6AUY7++E9DWyv
         x4Mq6e2e6PzLRAcK6H3e8Hwv+iKYei5O92RAjlrR8cSvsrzU6fQkrdFltFjAXLZJN+9a
         jcj0R7rad6V4PednGiDLo13UtZs3/yrCKEPNS4lxycmIouC6HHKr3nCGMDWSUsyQcQ9L
         q7FunI+D1XP3bw2hCwpOmPPFPYfM2oF1W694nUKeIdnPtO3/pwcxuSW/GFhqtuPwuA0I
         iVy7/YD2NbxsP66LcHql8uUNecNOLxOnojjwgaRwBWW7nJcmut9Y+Ym6DTDciY6Hcm3Q
         dAFA==
X-Forwarded-Encrypted: i=1; AJvYcCV2/ARt+jdGy/GsUQinyojorlJReHTqjUcqBAPphD9OJ2AjGE/R1sdmCiMSznsGv2sqbwsHSzfFh2xaUecOTjZ4AoojYl7FNzBYNM24UQ==
X-Gm-Message-State: AOJu0Yw4y9j4b1byn6RNxbNPouPrJGBRxaJviShJ2idSwo2H4Rw7RFVK
	GLIe5IBoIWceC1C0PcSv6TJUx9xBCfWUcWdrrfklSVdnYhEm2YDUF+gHjJGosUw=
X-Google-Smtp-Source: AGHT+IEQgyeIOKDvQf9gUz/EKh5crZ2gQ6znIYOA6BpSh1GdmClgFwwK28Z95oRnqBXCWyNwbsQk9Q==
X-Received: by 2002:a17:902:6806:b0:1dc:8508:8e35 with SMTP id h6-20020a170902680600b001dc85088e35mr665302plk.68.1709077570175;
        Tue, 27 Feb 2024 15:46:10 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id jg3-20020a17090326c300b001d9a41daf85sm2054477plb.256.2024.02.27.15.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:46:09 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rf79D-00CPwL-0R;
	Wed, 28 Feb 2024 10:46:07 +1100
Date: Wed, 28 Feb 2024 10:46:07 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	hch@lst.de
Subject: Re: [PATCHSET v29.4 03/13] xfs: atomic file content exchanges
Message-ID: <Zd50P9TH5TAdqFyU@dread.disaster.area>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
 <CAOQ4uxh-gKGuwrvuQnWKcKLKQe2j9s__Yx2T-gCrDJMUbm5ZYA@mail.gmail.com>
 <4e29a0395b3963e6a48f916baaf16394acd017ca.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e29a0395b3963e6a48f916baaf16394acd017ca.camel@kernel.org>

On Tue, Feb 27, 2024 at 05:53:46AM -0500, Jeff Layton wrote:
> On Tue, 2024-02-27 at 11:23 +0200, Amir Goldstein wrote:
> > On Tue, Feb 27, 2024 at 4:18 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > And for a new API, wouldn't it be better to use change_cookie (a.k.a i_version)?

Like xfs_fsr doing online defrag, we really only care about explicit
user data changes here, not internal layout and metadata changes to
the files...

> > Even if this API is designed to be hoisted out of XFS at some future time,
> > Is there a real need to support it on filesystems that do not support
> > i_version(?)
> > 
> > Not to mention the fact that POSIX does not explicitly define how ctime should
> > behave with changes to fiemap (uninitialized extent and all), so who knows
> > how other filesystems may update ctime in those cases.
> > 
> > I realize that STATX_CHANGE_COOKIE is currently kernel internal, but
> > it seems that XFS_IOC_EXCHANGE_RANGE is a case where userspace
> > really explicitly requests a bump of i_version on the next change.
> > 
> 
> 
> I agree. Using an opaque change cookie would be a lot nicer from an API
> standpoint, and shouldn't be subject to timestamp granularity issues.
> 
> That said, XFS's change cookie is currently broken. Dave C. said he had
> some patches in progress to fix that however.

By "fix", I meant "remove".

i.e. the patches I was proposing were to remove SB_I_VERSION support
from XFS so NFS just uses the ctime on XFS because the recent
changes to i_version make it a ctime change counter, not an inode
change counter.

Then patches were posted for finer grained inode timestamps to allow
everything to use ctime instead of i_version, and with that I
thought NFS was just going to change to ctime for everyone with that
the whole change cookie issue was going away.

It now sounds like that isn't happening, so I'll just ressurect the
patch to remove published SB_I_VERSION and STATX_CHANGE_COOKIE
support from XFS for now and us XFS people can just go back to
ignoring this problem again.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

