Return-Path: <linux-fsdevel+bounces-20380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9FB8D28B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 01:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515971C211B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 23:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4775913F43E;
	Tue, 28 May 2024 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XmKKgpEe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6055913EFE5
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716938754; cv=none; b=sXlkqyRJOVB4ZRqRalxgD0en9d94cJ+SR/LFBp/Ii5CAmKLsM3LhuGpHx5EZq3PnqftRTos+XipnItoQg8Dx2TOOaknjPkj/sh8RyDHhNnChAN5wQfL0fROA2sMgLRXSWjUlB7Sb2mGvhygf0rtA/EtRxAZGmet9I3d6sXubaJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716938754; c=relaxed/simple;
	bh=XkXbS1/SIQ5uVCoW76BxhGwPjalxquKHpRLo+Wtr2to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODvqmYM58/X/7XeRxlGkasEcncNusG2Fa7sA2ZJ8BvbAJ+ZOCfDK4foJDLGdR9gxYoLYggeTwaQ1YNt3sc9K+Nco9QI7nEx1Yq9veJ4dk5gXuJIpak4iKXuFvNPzzQlppfNDGPNFnQgpyHB3gidCgF5D7hXW/m5ODlsheQ0KCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XmKKgpEe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f47db642c2so11491955ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 16:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716938753; x=1717543553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R/Sgk1Yzp1sgcvMvS0zCkhtYU6du3DHWIlu0PixZMB8=;
        b=XmKKgpEeh7PjkhdCUkXTMYo4bOcoah4pKM0bExap0GRvt5Uk8jXm+zd+nIbkmJnV+C
         yt/8jw44FSFDocOSgJJczfeQPGNmHnha4ubpyX6AHjXyAYyI5KQQIUNFz6kEQZD6beWb
         Vd8OgYyaGG/TG6APDGpH3hqn6xHltlRp+cL0WXIJwLftqa3Un+idkSKBzK5fo9J3eXDk
         3dbJRJqpmtspweKjtkK0lHW2aDQt7bq7LT5+3Zhh6SIWsKFhs69kw5hJ49b1emUdpHn7
         aHdmwacH4FD/HvNUFWYfZlTzUuwKsXjxYm1VncXNsXMzb480KWFJi+EA2nUXcncqHLFk
         CSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716938753; x=1717543553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/Sgk1Yzp1sgcvMvS0zCkhtYU6du3DHWIlu0PixZMB8=;
        b=MwavLQ9AAu9bHUQryAMH+gGG2TRWZa3c86gjWnZmt29A+/d6j5pxfrk9OR9TkF9IuT
         WesbhhCrBKbE1wfPjVxhrOvGh9bXG8Ix/TblLLoiN9QyCDAxk0WEfXBp1ZfudNezVYVF
         fW2EI4A90v9EWMY8zw5s0KwbwmGuILv463r1ijeIL87taFzbbjWL/KPoHBS7WF/YGehy
         DsoM7zS4rLXIrM4HtRLFpH/sNF88rhzq/PXhenL2MNhNj26w8prVZ7KPASLy4BZf77Lx
         dveNTFEHsvw1glXTWb4jYtFK0AVo/waLwsivfABW62GTZvCDFyrnb/d5lCfxWDX6ijdJ
         h9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUSILaS1hiEuGgijpWQYetJRc6wcdPzQK3YbxuTFSrpJ8be5pPs/gtwdaidlutWuJCF4x+v4ZNI9Km8sEZl33/DQkvfPeWwR4rcr/zzwg==
X-Gm-Message-State: AOJu0Ywg7STIgc7D0gS68yKz93080Z1DR30ipM59teWgRIp2mRUoqeLk
	g3MkdgShKZKX9obmbiJnaehYPIvXYAETW2nZ733jsMbd6o+OV28fL2yHkn+X8EsgJjCjt5ni5H+
	z
X-Google-Smtp-Source: AGHT+IFvGxXkSZRiFaMmOXnG+Q4zsRIFB1iltGUHKeeZD+4PXkh7c9LGLmVlti4z7eKk5Q0uyyP8gA==
X-Received: by 2002:a17:902:e54e:b0:1f4:ac10:3ee3 with SMTP id d9443c01a7336-1f4ac10802amr60953545ad.20.1716938752369;
        Tue, 28 May 2024 16:25:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c997d0dsm86058635ad.199.2024.05.28.16.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:25:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sC6CT-00Dztd-1B;
	Wed, 29 May 2024 09:25:49 +1000
Date: Wed, 29 May 2024 09:25:49 +1000
From: Dave Chinner <david@fromorbit.com>
To: "hch@infradead.org" <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Trond Myklebust <trondmy@hammerspace.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>,
	"cyphar@cyphar.com" <cyphar@cyphar.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlZn/fcphsx8u/Ph@dread.disaster.area>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <30137c868039a3ae17f4ae74d07383099bfa4db8.camel@hammerspace.com>
 <ZlRzNquWNalhYtux@infradead.org>
 <86065f6a4f3d2f3d78f39e7a276a2d6e25bfbc9d.camel@hammerspace.com>
 <ZlS0_DWzGk24GYZA@infradead.org>
 <20240528101152.kyvtx623djnxwonm@quack3>
 <ZlW4a6Zdt9SPTt80@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlW4a6Zdt9SPTt80@infradead.org>

On Tue, May 28, 2024 at 03:56:43AM -0700, hch@infradead.org wrote:
> On Tue, May 28, 2024 at 12:11:52PM +0200, Jan Kara wrote:
> > So some fanotify users may use open_by_handle_at() and name_to_handle_at()
> > but we specifically designed fanotify to not depend on this mount id
> > feature of the API (because it wasn't really usable couple of years ago
> > when we were designing this with Amir). fanotify returns fsid + fhandle in
> > its events and userspace is expected to build a mapping of fsid ->
> > "whatever it needs to identify a filesystem" when placing fanotify marks.
> > If it wants to open file / directory where events happened, then this
> > usually means keeping fsid -> "some open fd on fs" mapping so that it can
> > then use open_by_handle_at() for opening.
> 
> Which seems like another argument for my version of the handles to
> include the fsid.  Although IIRC the fanotify fsid is only 64 bits which
> isn't really good entropy, so we might have to rev that as well.

I'm in agreement with Christoph that the filehandle needs to contain
the restricted scope information internally. I said that in response
to an earlier version of the patch here:

https://lore.kernel.org/linux-fsdevel/ZlPOd0p7AUn7JqLu@dread.disaster.area/

	"If filehandles are going to be restricted to a specific container
	(e.g. a single mount) so that less permissions are needed to open
	the filehandle, then the filehandle itself needs to encode those
	restrictions. Decoding the filehandle needs to ensure that the
	opening context has permission to access whatever the filehandle
	points to in a restricted environment. This will prevent existing
	persistent, global filehandles from being used as restricted
	filehandles and vice versa."

But no-one has bothered to reply or acknowledge my comments so I'll
point them out again and repeat: Filehandles generated by
the kernel for unprivileged use *must* be self describing and self
validating as the kernel must be able to detect and prevent
unprivelged users from generating custom filehandles that can be
used to access files outside the restricted scope of their
container.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

