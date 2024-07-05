Return-Path: <linux-fsdevel+bounces-23179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED89F92813B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 06:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30DC286679
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 04:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D9F763EC;
	Fri,  5 Jul 2024 04:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2DmhlNE6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BBF1F94C
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jul 2024 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720153962; cv=none; b=Nvblp3UEnlUe6PIprYP9pHzqDk8891C6z6tPI0j1OwsLhz/ctExHEZoCvLNQrCmzQOvt6HIaMDdVbV+L6CNPreIK8je2ja5HTYVdHeO4uPCoyCBEog6Bt7CfZ3NFo/xSmKgk8GIiwX1dCC7AHcrm+F6lwLCpPlQ/U9wCnK5jero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720153962; c=relaxed/simple;
	bh=7zH4BhtmNC75bo3uUQp74pwP+kO9q4th0+RwpYErCt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HL5/9JJYPoNrcyA5CZmXCKpvTmuZFYIyAv+ySUGfSjmkx8JMlT1/jWpLp74MQS/KVm5Caq5PA4itGR+PG5N1ePfc3HdOHaWc5DHIjEm2Jb6f2v6d4G3rnc/QyKCx1hu3N4kvWYx5Vf2y3wXHFmAIlqAvw798ysV+hx8IKIqsXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2DmhlNE6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70af0684c2bso886313b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 21:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720153960; x=1720758760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JaNUdVKAXYAbRIpln8ABSTH2bFgFz52Xo4pVr+BWnIk=;
        b=2DmhlNE6waTrp1CxTfKmxrRnc1HIg5N06aEZIz1pcO9IE553AA751y/QERrZTohUIc
         fE1nYNXWYTYMDW+nhRrQf9J5uuWWilLJfKNWi1xWSs4dkOujNQUW+lxTltEWmyzMnLH0
         6A/jdd1vADBcLhcXFZIMA+c+GoYfftnbFYkIn34C1+zOhS7BdqZo8eO4o8+eSZCnSX3m
         4dgCncx0Vywm77ObFgIV/8sV4aZOPuMI50aX3fRFGaetM/de/tWvOYYvEH5+/tI27M3D
         4Ewf0m78SQftRMhZAsKH7z+Ghv8CIkfzir/U98aQMJ/om+vfaFbTbK3vdDA/qKOciDLO
         e2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720153960; x=1720758760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaNUdVKAXYAbRIpln8ABSTH2bFgFz52Xo4pVr+BWnIk=;
        b=Pzy5zddH7AaMRBhKp2CExabmejqv7BJrvQSS0afLjTjZTbJ2TpkJ+Bc+SwhXQyz7ZG
         iPlUTaYXGOqEpcWXqZInEQObQ1Qkx4QM4DrvzGQoemTCBfEsF1QAM/m9VeLZfzJ64zaX
         OMLo0KzqWvblPgf3Vm+jjSM/Clt5waiHlE5OjBu8XUUOss9fz6zkdAf/nHPJl/RwBdRr
         iZFqI8P1y0fzAWcDwvnDb48qdM0Cx0pjzNiJxbPQxJgvYWodUk476Xr27U4R+gnTOOSM
         kvuzWtJLasJ14io0JEnEzLUCxXg0UW6aUKNQT94i08FFgc0ywUBckA53fQVp9r61Dwdw
         IeXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaC939KyxB43TCunRidhDWbw4l256MZGf+OWYUrfwxzb5xF5qUNa5xlocIImA+rfGlWUdtNVZzLcOShUe9zSU2b2XERjDaLCyWQZj4lg==
X-Gm-Message-State: AOJu0Yy+PjPatdBnhaS6DZmxrsJIG+9pf4ZZTGfqOC50I2wHwM9Z8O/9
	/ktG/cLB2kCBV5wnRnvtaRu5eC86geX8Z1U8Ginvykdr//rpR0Gf8xYcU35UjE4=
X-Google-Smtp-Source: AGHT+IGNNipKdGsi4XWy+dedlny7ElaFdUH7HAl5rueUaHfHmRKLnG/xTRjlLs78fkLSEdOgSoy6rQ==
X-Received: by 2002:a05:6a00:4601:b0:705:cade:1f50 with SMTP id d2e1a72fcca58-70b00b0413bmr3372631b3a.34.1720153960020;
        Thu, 04 Jul 2024 21:32:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ae395sm13437861b3a.144.2024.07.04.21.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 21:32:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sPacf-004cOB-0b;
	Fri, 05 Jul 2024 14:32:37 +1000
Date: Fri, 5 Jul 2024 14:32:37 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	chandan.babu@oracle.com, djwong@kernel.org, brauner@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <Zod3ZQizBL7MyWEA@dread.disaster.area>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
 <Zoa9rQbEUam467-q@casper.infradead.org>
 <Zocc+6nIQzfUTPpd@dread.disaster.area>
 <Zoc2rCPC5thSIuoR@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zoc2rCPC5thSIuoR@casper.infradead.org>

On Fri, Jul 05, 2024 at 12:56:28AM +0100, Matthew Wilcox wrote:
> On Fri, Jul 05, 2024 at 08:06:51AM +1000, Dave Chinner wrote:
> > > > It seems strange to silently clamp these? Presumably for the bs>ps usecase,
> > > > whatever values are passed in are a hard requirement? So wouldn't want them to
> > > > be silently reduced. (Especially given the recent change to reduce the size of
> > > > MAX_PAGECACHE_ORDER to less then PMD size in some cases).
> > > 
> > > Hm, yes.  We should probably make this return an errno.  Including
> > > returning an errno for !IS_ENABLED() and min > 0.
> > 
> > What are callers supposed to do with an error? In the case of
> > setting up a newly allocated inode in XFS, the error would be
> > returned in the middle of a transaction and so this failure would
> > result in a filesystem shutdown.
> 
> I suggest you handle it better than this.  If the device is asking for a
> blocksize > PMD_SIZE, you should fail to mount it.

That's my point: we already do that.

The largest block size we support is 64kB and that's way smaller
than PMD_SIZE on all platforms and we always check for bs > ps 
support at mount time when the filesystem bs > ps.

Hence we're never going to set the min value to anything unsupported
unless someone makes a massive programming mistake. At which point,
we want a *hard, immediate fail* so the developer notices their
mistake immediately. All filesystems and block devices need to
behave this way so the limits should be encoded as asserts in the
function to trigger such behaviour.

> If the device is
> asking for a blocksize > PAGE_SIZE and CONFIG_TRANSPARENT_HUGEPAGE is
> not set, you should also decline to mount the filesystem.

What does CONFIG_TRANSPARENT_HUGEPAGE have to do with filesystems
being able to use large folios?

If that's an actual dependency of using large folios, then we're at
the point where the mm side of large folios needs to be divorced
from CONFIG_TRANSPARENT_HUGEPAGE and always supported.
Alternatively, CONFIG_TRANSPARENT_HUGEPAGE needs to selected by the
block layer and also every filesystem that wants to support
sector/blocks sizes larger than PAGE_SIZE.  IOWs, large folio
support needs to *always* be enabled on systems that say
CONFIG_BLOCK=y.

I'd much prefer the former occurs, because making the block layer
and filesystems dependent on an mm feature they don't actually use
is kinda weird...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

