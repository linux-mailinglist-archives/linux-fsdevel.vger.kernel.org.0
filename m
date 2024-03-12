Return-Path: <linux-fsdevel+bounces-14183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3E8878EF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 08:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB2E1C20F1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 07:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC01D69958;
	Tue, 12 Mar 2024 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZjrL+P11"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8976994F
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710226868; cv=none; b=S7NdEUkQvO9FYyPe+kED+tiL50VokQxNtldT1V+CyYgaXlx3mO6NdWM5snGk9cz1H4cN5Z/2UUFXvWcHqSYC+d+D94P3Y7wAr5u5demg4qVKVLEFZveEjTugKN8CUYpDYh/QSI/kBmChEhuk59wKiAltOLzK6TTw//Y9e7oPVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710226868; c=relaxed/simple;
	bh=tj8KK0D7LCHZt7E6i5hvVqiBxMjal+SFD/ZyzAWJDnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1ZYWsJtDYPAR/cqp8TKI90rYb+4mybzQSZxKzWjSu3MPmDzIlnv/Fb5+MZEj7y1FJOuiYhU60XtIktsdMhZM6H5D4Xik4MeulXKky/MNjybqxsyOrMccSGDDxWXhNxDlIxDsrGOcceev2FoK3mpKqT3GpnvtQcOwVf0DlFq+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ZjrL+P11; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd8dd198d0so16941135ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 00:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710226866; x=1710831666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJQ+LsA4njrwtFoiuWbZG6N6ucnCdblOdJQaovZ8ZEo=;
        b=ZjrL+P1190zsl03TFegsYfYK8jaXgqQs3TvfcoyrzY3CdGqAmoc+DX9OY5CDnylCAX
         cizkfTLvqVKvZnaj8lhjpeRqA/ErwSqSGkn9ndmL86T2ehUlmdgKyJ+Zs6CUzt1PV4E4
         Yh2tuCqgmld6p3hMJtRqT0D1Hq6QGue+DYWc5HQlWyK8ch80NQnHeJiymwiyvF6i0d3b
         2+Xjliipqi5mqXWAbQAF/LkySPPUW71S9nXDk+5l349KzMkL+x9+/Y004DTnCRqSUbU9
         BPuXxJCGli6peA+6x1xwHseDbZ4mHxLhGuepvnpAgbpu4OgW01ZOA1a1+XlIMSgxlUuN
         Si+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710226866; x=1710831666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJQ+LsA4njrwtFoiuWbZG6N6ucnCdblOdJQaovZ8ZEo=;
        b=DVgJsug1HFH3IuwusBo5GBMmzzC2VcYxDk9bygerQS3O58E54rbuwfhiEatM1Di72M
         WlrpBeNb/fLD5ONAlQoSZZlZhTsOuB219n3zdlwfMwHfsU171QTd142lTm6NhhUY/WcX
         Nwrdke3LjyyjpJQS+lR4I6fsZwQ99wruE/WjZxr/WDBUHPgODm5GhmjaOAkLwkgyCHWm
         /IyUm7sSVoTO//0CgSdNAxiLZOUYh1akv/Et9mDlvuSf68wt358UXzee9RnEchxfUE7n
         p4cU1yXM13GDvT26IyCmnmXy/vkvCQy9o6XtfAxm4oO1/WI0l5sqZ2SBqLJhTWogg6Yh
         1wxw==
X-Forwarded-Encrypted: i=1; AJvYcCXIFj/DKETvyG1I9v0d2VF5WNlsaGq2q2meKHeJSoBYyaBSid0XCcE3d8fB6307w8wW6zt6ITS072j2RMQDfX6J3WfhC6D9ZYajdcjAeA==
X-Gm-Message-State: AOJu0YwpV2kYfoHha9z8Tp3Dj5ZNio+IS8sDYBux1EilivAu/5DdcSFh
	ZF1TsXj+3Zu937vhbuJFxeK9iVWBlz3Uz1hPSO05NKoskSIyBJPYnkAmgJIYbKc=
X-Google-Smtp-Source: AGHT+IFfiBIZrzEHhDlB40WMpMIuhFhWXqA66uq2JH3j2quW4u+GTqwqvuflueaG7FnGq+PfIjC3uQ==
X-Received: by 2002:a17:903:94e:b0:1dd:bf6c:8973 with SMTP id ma14-20020a170903094e00b001ddbf6c8973mr193652plb.68.1710226865312;
        Tue, 12 Mar 2024 00:01:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902c40600b001dd247e87aesm5889367plk.235.2024.03.12.00.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 00:01:04 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rjw8D-000ngZ-2g;
	Tue, 12 Mar 2024 18:01:01 +1100
Date: Tue, 12 Mar 2024 18:01:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, ebiggers@kernel.org
Subject: Re: [PATCH v5 11/24] xfs: add XBF_VERITY_SEEN xfs_buf flag
Message-ID: <Ze/9rdVsnwyksHmi@dread.disaster.area>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-13-aalbersh@redhat.com>
 <20240307224654.GB1927156@frogsfrogsfrogs>
 <ZepxHObVLb3JLCl/@dread.disaster.area>
 <20240308033138.GN6184@frogsfrogsfrogs>
 <20240309162828.GQ1927156@frogsfrogsfrogs>
 <Ze5PsMopkWqZZ1NX@dread.disaster.area>
 <20240311152505.GR1927156@frogsfrogsfrogs>
 <20240312024507.GY1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312024507.GY1927156@frogsfrogsfrogs>

On Mon, Mar 11, 2024 at 07:45:07PM -0700, Darrick J. Wong wrote:
> On Mon, Mar 11, 2024 at 08:25:05AM -0700, Darrick J. Wong wrote:
> > > But, if a generic blob cache is what it takes to move this forwards,
> > > so be it.
> > 
> > Not necessarily. ;)
> 
> And here's today's branch, with xfs_blobcache.[ch] removed and a few
> more cleanups:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tag/?h=fsverity-cleanups-6.9_2024-03-11

Walking all the inodes counting all the verity blobs in the shrinker
is going to be -expensive-. Shrinkers are run very frequently and
with high concurrency under memory pressure by direct reclaim, and
every single shrinker execution is going to run that traversal even
if it is decided there is nothing that can be shrunk.

IMO, it would be better to keep a count of reclaimable objects
either on the inode itself (protected by the xa_lock when
adding/removing) to avoid needing to walk the xarray to count the
blocks on the inode. Even better would be a counter in the perag or
a global percpu counter in the mount of all caches objects. Both of
those pretty much remove all the shrinker side counting overhead.

Couple of other small things.

- verity shrinker belongs in xfs_verity.c, not xfs_icache.c. It
  really has nothing to do with the icache other than calling
  xfs_icwalk(). That gets rid of some of the config ifdefs.

- SHRINK_STOP is what should be returned by the scan when
  xfs_verity_shrinker_scan() wants the shrinker to immediately stop,
  not LONG_MAX.

- In xfs_verity_cache_shrink_scan(), the nr_to_scan is a count of
  how many object to try to free, not how many we must free. i.e.
  even if we can't free objects, they are still objects that got
  scanned and so should decement nr_to_scan...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

