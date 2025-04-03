Return-Path: <linux-fsdevel+bounces-45589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F75A799F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 04:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BC41893234
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 02:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C72155C87;
	Thu,  3 Apr 2025 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsYSPqcc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E0B666;
	Thu,  3 Apr 2025 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743647210; cv=none; b=tOmHDOZtfi7YqMUSVaP8JSBp0yDp4EAlToheleQZKGMNkW1KIKDRc8zH90xzLPsc/igjAARZEohW5iM4Fua5+1sEluBxwWhj76rKuim++HcDYgjIX+GnO3GFMsIOXbtAJLyYrdxtLPFlXE4UPwgYT3Caz+Gid3qkDLSNkKH6OAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743647210; c=relaxed/simple;
	bh=jf5394cTtk1PIpHuZAlODp4bGLs4NLhfBXw0lto4ohk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1kVRSfbafQjGo8XiXIpPMIPEymxEkMykYRdLK4ZmnjOoAUef8JwsLnkVoqtSli87QR1ZGbMR08tT+HHzXffu/eKlVVsx0Q5JNxPAGZ7WLgkUxZcCIjefWq6KQIyUHveka4YgO60d93q/klltjvwLF/LUaAW5Lnp05P4J1tuZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsYSPqcc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so2310045e9.2;
        Wed, 02 Apr 2025 19:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743647207; x=1744252007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JBjZbLzsmnZp0/BQM9ucFcge4aTiHA0nyPTk3HIziM=;
        b=JsYSPqccPI5xeGaXDZe7Tfkn1x6kjEIusoUhTMHoF4DKWFGMiHLgZSkSn8eaqk1OlG
         Y1rT6Rzsrrf9vD1YmvSQIjh9oU/eZr+VWJsys4dq6VIvJH/HD4eYRVuINI/iXTBoQ17x
         UDvA/9zAc/PMhVSnekn90N3l8L0+RYXg2ceyVjPNIhzaPvriQ7jbMQ2evM9ZAu345Ge9
         55jtoaKTtvh8AUnsvSpfa/CiEmOugGfyqYZGypv5y2yg3g1dj0D7j6iHrewHyb7HLGQS
         +gBedZQKjci4JLY+LYQmeyLRP2lc1zk4ZxWjQab5s5n54ab41Kz09shY5CbC+J1aIKL3
         TtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743647207; x=1744252007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JBjZbLzsmnZp0/BQM9ucFcge4aTiHA0nyPTk3HIziM=;
        b=ryqDN/xRA0KPL010xs2NZmeOQp+Amj6f3lVY/u8QqSz1ElgCzaCxsBpsuixaR8XrBZ
         NSO6v7ICMA1oDD98fTk0nu2RfLwy8XjK5HbTkxBK9YOjJOVWPM9fjthbGxUfpNFO+iOH
         cn66VsrTDn9uW11cGkSohrlQVgv2q8klG6u35Qlm/52ueRIwmhtCG1CPUhc++N+wYxI8
         KS5s78MuKDOJpqMPu8USU2jhfXTbheC/OwbtZcR6OLKRfMwm+sLjBV0zebddDAXUKbyp
         WKdrvrgxkEV3sCL5YLUxs2HPkTRJlb9G7Cq52ZNx7nsMgeDb+Dc0pZO3dAXKduggSI7f
         AKNw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ64mZZZEvSuF1w1OJ0bl/GCE7EorNQ6uYqZNDbZSuwK9MHpjCP4Cu13lw+foEytiPw1F3yoe1zvky/cQM@vger.kernel.org, AJvYcCXSA22Date4khnq6RvuNwaMzcMw1osNVLq5tqGoBXJqengLLmw0U8tQv1sRWlF0jBcd4AD+wa47u5BD6bHR@vger.kernel.org
X-Gm-Message-State: AOJu0YwjivLmeN8u+cpi9dvps+a5KtJC9uVRgho2UTSMNW8i5vd6O5s3
	nUl/rITpqF13/52xfUtsxINdOEZ2+AMZrcWVaxUXdPaQ16OwVGHd
X-Gm-Gg: ASbGnct4oOl1K/xVTp+BLBMFpFNCYWJ83h19zUGFax6qaB+JzRmpw657Lu9d+DwElL/
	fTKjvwRODrVfbVFnHIOD4acykQ2DTju4FxD8tf43nchx3mbTKSH3fFD7Ewo+NwL+kAv0eYcXltw
	uWClLIQs91ZFJ48ksSp9+1YgYCHbKGhrmt3ScDlTBKRgkdqwXFm9js1Z1CUV8HtbmZ7nKnRwbcu
	CBzkPTnnJXyy8nbaGIjI7uImqAMt7mW24IkHO0B0ujdVkmoR+e2w/SoiTQU+aSmCX1r+gHfTDDi
	UPcOsAipXpt8LJ0NS7Y+3JIRIIA8b++HPsjB3XV3bRIGO8xI/bQYHcw4lQ==
X-Google-Smtp-Source: AGHT+IGGA8Is0QPxIAtf3kKBf/xR13lX1p0OGcU7wtyCdZAj9+bpAsXN/Yir0OFSK3wXsbf/5cuPew==
X-Received: by 2002:a5d:64c3:0:b0:38f:2a32:abbb with SMTP id ffacd0b85a97d-39c120cb586mr12941403f8f.4.1743647206752;
        Wed, 02 Apr 2025 19:26:46 -0700 (PDT)
Received: from f (cst-prg-6-220.cust.vodafone.cz. [46.135.6.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d980sm435638f8f.61.2025.04.02.19.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 19:26:45 -0700 (PDT)
Date: Thu, 3 Apr 2025 04:26:37 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Penglei Jiang <superman.xpt@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] vfs: Fix anon_inode triggering VFS_BUG_ON_INODE in
 may_open()
Message-ID: <iufbqsvdp52sgpsjkyulfqgfpvksev3guds5hd556q7zxestgq@ixog46pumnry>
References: <20250403015946.5283-1-superman.xpt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403015946.5283-1-superman.xpt@gmail.com>

On Wed, Apr 02, 2025 at 06:59:46PM -0700, Penglei Jiang wrote:
> may_open()
> {
>         ...
>         switch (inode->i_mode & S_IFMT) {
>         case S_IFLNK:
>         case S_IFDIR:
>         case S_IFBLK:
>         case S_IFCHR:
>         case S_IFIFO:
>         case S_IFSOCK:
>         case S_IFREG:
>         default:
>                 VFS_BUG_ON_INODE(1, inode);
>         }
>         ...
> }
> 
> Since some anonymous inodes do not have S_IFLNK, S_IFDIR, S_IFBLK,
> S_IFCHR, S_IFIFO, S_IFSOCK, or S_IFREG flags set when created, they
> end up in the default case branch.
> 
> When creating some anon_inode instances, the i_mode in the switch
> statement is not properly set, which causes the open operation to
> follow the default branch when opening anon_inode.
> 
> We could check whether the inode is an anon_inode before VFS_BUG_ON_INODE
> and trigger the assertion only if it's not. However, a more reasonable
> approach might be to set a flag during creation in alloc_anon_inode(),
> such as inode->i_flags |= S_ANON, to explicitly mark anonymous inodes.
> 

I think this is the right step, but there is a missing bit.

The assert was added because of a prior bug report involving ntfs, where
a misconstructed inode did not have an i_mode and was passed to execve.
That eventually landed in may_open() which did not check for MAY_EXEC as
the inode did not fit any of the modes. It was only caught by a
hardening check later.

Note all other cases handle MAY_EXEC.

So I think the safest way forward has 2 steps in the default case:
- detect inodes which purposefully don't have a valid mode and elide the
  assert if so, for example like in your patch
- add the permission check:
	if (acc_mode & MAY_EXEC)
		return -EACCES;

The hardening check comes with a WARN_ON if the inode is not S_ISREG.

No need to hope none of the anon inodes reach it, this should just be
short-circuited.

