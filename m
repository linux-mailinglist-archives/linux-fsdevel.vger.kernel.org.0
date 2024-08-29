Return-Path: <linux-fsdevel+bounces-27846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2824D9646D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DA21F22CF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CB71AE024;
	Thu, 29 Aug 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="l89NXYYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F01A76CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938507; cv=none; b=Xb7xdcqGelwLcqq/GRgfnYZ0fM1DqIUGC+8DmXu4OneRBRZx+rqdT3QZ1L5y+8bavP2FbC6xD22Rn1L6NVdNDtD4kQaZgZfwETpKKdq96Jqajq9WMpbNGuh/R4WpbnOzEAfZoe5mNS3F7L28hR3jPtTqE+MM5T7AFc9LfB77NuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938507; c=relaxed/simple;
	bh=sTMFvNV06/zwz/V10/ORBXRQBHotCy5JRGNXWoNGqAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRtWHSVcar9lfwtKAZRmm8ImSJqVzISHsTXCaYJH1ceciU1oK6leyNiFOAYVq8/ueVn6n/x9bYnTP0gweWoXJ3E+Pz96U6CbooT/YsGxxomtZd0GKSizXn/0TSrgHbHM/oNbREQS686BqXlKx+4kq3Wkpq8ytL/G+xvoalnqq7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=l89NXYYV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4567dd6f77fso9865391cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724938505; x=1725543305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CtISLUO5EP2NsKvBcM5qfQlSfPZqpo47XVjo1uXCz4w=;
        b=l89NXYYVbd7je5pOC2+SIO1nQ9Kff65RpHofjvIKGnBcU2IU+p21PDoAdrD7yVJwsY
         RQXQLwfWLe4hZrPSxMOX0JhlGhI8DxDEae35pb/ab9awj+j0DWcTXGEIbWsBL7z0VMdO
         5mSnp3yE5/a7UAt6kC0mqv6QgLYQTY8NcPD4QgEnbIy/xguulxCLtiwuHj1wHAjsaufX
         nIwp8LR5K2M9ojFG8xH7/nIK/orLSnQeq0xnWtocsOB5gDoE1eLK04YQWdA5G+616pzS
         eQMv3ER5zMYZTbfO0tDQ2EVr2C4lSvnwhHsvv78fNyYDs0i4qYWBwA92tK3FhQa5tmjU
         IN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724938505; x=1725543305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtISLUO5EP2NsKvBcM5qfQlSfPZqpo47XVjo1uXCz4w=;
        b=H5wxqL3QTZ4HIjdwWnLes/aFuVmWRwP5F/6yV36KRwviHgmxy8Mh71kIoGNKUWzcDh
         Mbu5QqSa07jHEf5qTOLL9Z+MCay/3bs57GIrFcXBGFMp8f6IpXpJ86CJib8lF8KR+2Sz
         p5kJLN0yI5qtdsPwJZ6+qj4YAxB7NXCRUHIPR2BSc9Hx7ZnluxT/eNHdT89OKD+QN3aE
         t4u6oK/ra0ykv6XJTwxAtLmdL+W89bHzgPq2ENTy9y0GPMNReef89ZJ0Tkh0xzg9uHUt
         gROUfihY2kxQD+9rROJVDAUd7hXeCn17ET1zv1yy8qPcdMf8KnfB4oKv+8ZhHQna21cp
         ycng==
X-Forwarded-Encrypted: i=1; AJvYcCWTTsBibMJbbGaWUXbe1VjWqYaIH7NGf7KzFC3eHAsduvQysQPgTmIFfeHpdWE1x2caU4lgHhPXrENEX3OQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq7TiL5nKWPjDlE794GgIY2LniyqJVo6U2PHBRfom4yOqUwJvF
	2KTqY5rfeT8piRiR/B7w3Rwfj8hEsZTnKmNk1g5RfIYMhW/VEl9J3PPR8ky7YrPFm7TAHJ/I42h
	A
X-Google-Smtp-Source: AGHT+IHi0ePL4nHYzDmd8C6feL1XGdxlqeggsT/N5P+vvi4GErra6t4ye1NvvsSOEwWgVZFjJ3iRSQ==
X-Received: by 2002:a05:6a00:92a3:b0:714:228d:e9f2 with SMTP id d2e1a72fcca58-715e7819bf4mr3459352b3a.3.1724938493726;
        Thu, 29 Aug 2024 06:34:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9bd58asm1212974a12.72.2024.08.29.06.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:34:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjfIY-00GyD7-0H;
	Thu, 29 Aug 2024 23:34:50 +1000
Date: Thu, 29 Aug 2024 23:34:50 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>, viro@zeniv.linux.org.uk,
	gnoack@google.com, mic@digikod.net, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <ZtB4+sMr8Vbcs9VD@dread.disaster.area>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <20240827021300.GK6043@frogsfrogsfrogs>
 <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>
 <20240827053712.GL6043@frogsfrogsfrogs>
 <20240827-abmelden-erbarmen-775c12ce2ae5@brauner>
 <20240827171148.GN6043@frogsfrogsfrogs>
 <Zs636Wi+UKAEU2F4@dread.disaster.area>
 <20240828155528.77lz5l7pmwj5sgsc@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828155528.77lz5l7pmwj5sgsc@quack3>

On Wed, Aug 28, 2024 at 05:55:28PM +0200, Jan Kara wrote:
> On Wed 28-08-24 15:38:49, Dave Chinner wrote:
> > > instead of using name_to_handle_at, which is why it's dangerous to
> > > implement GETVERSION for everyone without checking if i_generation makes
> > > sense.
> > 
> > Yup. If you have predictable generation numbers then it's trivial to
> > guess filehandles once you know the inode number. Exposing
> > generation numbers to unprivileged users allows them to determine if
> > the generation numbers are predictable. Determining patterns is
> > often as simple as a loop doing open(create); get inode number +
> > generation; unlink().
> 
> As far as VFS goes, we have always assumed that a valid file handles can be
> easily forged by unpriviledged userspace and hence all syscalls taking file
> handle are gated by CAP_DAC_READ_SEARCH capability check. That means
> userspace can indeed create a valid file handle but unless the process has
> sufficient priviledges to crawl the whole filesystem, VFS will not allow it
> to do anything special with it.

Yup.

The issue that was raised back in ~2008 was to do with rogue
machines on the network being able to trivially spoof NFS
filehandles to bypass directory access permission checks on the
server side. Once the generation numbers are randomised, this sort
of attack is easily detected as the ESTALE counter on the server
side goes through the roof...

> I don't know what XFS interfaces use file handles and what are the
> permission requirements there but effectively relying on a 32-bit cookie
> value for security seems like a rather weak security these days to me...

It's always been CAP_SYS_ADMIN for local filehandle interfaces.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

