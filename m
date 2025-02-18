Return-Path: <linux-fsdevel+bounces-42017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A60A3AC2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 23:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3055D7A5495
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 22:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CFB1DE2AD;
	Tue, 18 Feb 2025 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ML57H0ZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0E51DDC20
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919395; cv=none; b=tlGmwFcDT7KwcrwLNuVRiIZUPV87oGek+FuRsSKigQQZBMhyd2ynTirbAG3slCn2hxPDVBhc6DmZ2dlwHJiDhBkeIB+lMm4pxyWQua+lWiHjdFeqo1qppSiv5T5TL0rSS1mGlGWHoYaF0st5YC4tliBJIzCz4stztLyRmZl+N5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919395; c=relaxed/simple;
	bh=fVxPrj6+hYQCby6mCw3BdWYLLIhFV5a0roY1nnG1mjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM7WLYEfvFDAmuSyQbS2yMebLz60BA4/v0kFbWYY9B6sJKMOca92d7ApyjdAAImwX4VV7uO1WsgmHzyBzMsXkhK4rbMgAXM4ffPRVwdR3nqJArXZPx4+gcHyh+bh/op0ph++xvqpLVKnM4Xwu6ZE/tuDvy9OIBDuCzkEyMbS3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ML57H0ZS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-221050f3f00so69583295ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 14:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739919393; x=1740524193; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jOVGrwW7CiNLR2dUss7zOvX9uZEpJq6PAvR2PcA9dY8=;
        b=ML57H0ZSZIKh0NTFj/Hi4cwPTdM7DiQ7EsOi+TlZcfapBdS4AF5gDZ0FcOQBEGOIQt
         SAyE70RLfIzxbPi2a/WwrO9APgFDdg6bmPoCNoBNJB5IZzcmtxEK+K8+SfP652mSjNFE
         vDPw2MEcLJ/6a7/ATKS8yFK+1KCDOw63vWXG1gOiuXiCikObS2Qu82egYj7tMoJXpJqj
         woiX7fbDf4fvO2CETuVhgp7EyGTgn4wVCSpXdnfcoJpWEP5HzjEJNrGXSZ/k1+EEhUV4
         BnsuzlXcLXCgB7LHI0OEsDJTEbTuKqqe0fK1P1ADYR+lfg31c0Qbw+Y8JTWg4/7gmakX
         PuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739919393; x=1740524193;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOVGrwW7CiNLR2dUss7zOvX9uZEpJq6PAvR2PcA9dY8=;
        b=dpZUkWNe1aogXVetEEn+GOmUNPzpk0d15tGPHKEgYyi8yOZpXv271iqtNWeL37Ri9K
         KkD+dAdu6Gh0ifxzdmHgazGyg5v4YLwXf92gsRYRKj17OyzEUutbMfxsGmboQcYMtoUI
         IJrv4i6kBYUiuY4ub3/Oc9x6lmQEuzL/GlPsAjYk1yTXgEBrqN6NKrXnQc4Gl72vSNnL
         nmGiUaCyRRRe9l1Myz8gZ9CenvJxQ9QX7h8Bx7MF2D8ha57tb6+b2vHoZ67nbPgNn2Jt
         jM6okMXaUBEF8zyFCnZ58qYLwwFVXOQho6JLImiupP+5g6CLsPSpV8UhyUTPi5qAc9rn
         TOIg==
X-Forwarded-Encrypted: i=1; AJvYcCURhJeUDOHxMRIFmwZlSfRk7bFpAtbPTfdF5YxlRBliQIvdkAe+SH3nMUnGfnjXbByfcMNQDvLJj5CRACjY@vger.kernel.org
X-Gm-Message-State: AOJu0YzpEZGMPaIUNXWs2TdWHvye5QxYlwd6YSVc1l3xBQVwrXwZA/V8
	kprr/g+hzxs2rz83NyjPf9nBTAMMrxMjfIATHR+90QdbKDznmWZ++JWx1pjwmGc=
X-Gm-Gg: ASbGncviW4DBOnt+COybE41LtJSHV7RbRhPO/v1eikxtB+m+vTQk9jm4uTTnsRwES4b
	tVZtYdXcuGYAxq64xcUYd0ka0jQOfwMQFxi4hforaeNM/u3OaglhfOxoKWkOAUEFSwRgk+Lazu9
	ZNRIMJ1Zw896v8HR90hUk+8c/yE8Cr23LKkfiFCfJPC3S7PaRwCJ7oipir9oWjVfKgUI8ZamFMq
	590J7pHin2STEWd36HcR9S89vZue1TW0in5TtkrebD38ksjEiBeQ5BtsA7niSsxBYaFMxDDz1dv
	DdKYChcGcWqrTKuPJ6Nsv3HG1KF1mwNIbtXDWbPjLRJFIKtPChfgVO+9
X-Google-Smtp-Source: AGHT+IFNeXqjJ+MxQ2VULjeC3pvBgrgbvWZov0RSWVHhUVra12Eag2ZgbapyJo1xvpnq4PV+cNOtZA==
X-Received: by 2002:a05:6a00:929a:b0:732:a24:7351 with SMTP id d2e1a72fcca58-7326179d65bmr26282695b3a.6.1739919393107;
        Tue, 18 Feb 2025 14:56:33 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73274a11a0bsm5349794b3a.123.2025.02.18.14.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:56:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkWVw-00000002zlY-37rX;
	Wed, 19 Feb 2025 09:56:28 +1100
Date: Wed, 19 Feb 2025 09:56:28 +1100
From: Dave Chinner <david@fromorbit.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Eric Biggers <ebiggers@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
Message-ID: <Z7UQHL5odYOBqAvo@dread.disaster.area>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain>
 <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali>
 <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
 <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
 <20250218192701.4q22uaqdyjxfp4p3@pali>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218192701.4q22uaqdyjxfp4p3@pali>

On Tue, Feb 18, 2025 at 08:27:01PM +0100, Pali Rohár wrote:
> On Tuesday 18 February 2025 10:13:46 Amir Goldstein wrote:
> > > and there is no need for whacky field
> > > masks or anything like that. All it needs is a single bit to
> > > indicate if the windows attributes are supported, and they are all
> > > implemented as normal FS_XFLAG fields in the fsx_xflags field.
> > >
> 
> If MS adds 3 new attributes then we cannot add them to fsx_xflags
> because all bits of fsx_xflags would be exhausted.

And then we can discuss how to extend the fsxattr structure to
implement more flags.

In this scenario we'd also need another flag bit to indicate that
there is a second set of windows attributes that are supported...

i.e. this isn't a problem we need to solve right now.

> Just having only one FS_XFLAGS_HAS_WIN_ATTRS flag for determining windows
> attribute support is not enough, as it would not say anything useful for
> userspace.

IDGI.

That flag is only needed to tell userspace "this filesystem supports
windows attributes". Then GET will return the ones that are set,
and SET will return -EINVAL for those that it can't set (e.g.
compress, encrypt). What more does userspace actually need?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

