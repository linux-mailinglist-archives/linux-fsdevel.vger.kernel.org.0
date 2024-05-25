Return-Path: <linux-fsdevel+bounces-20161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016CC8CF1EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 00:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB3E281BFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27D92555B;
	Sat, 25 May 2024 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="If8UsvQk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA703171CC
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716677692; cv=none; b=bcmj5G+vqNHEgg7xzVWtzaRPnGcL4DAVInOrjqun4QPHo5qGnLpRtTGEr9p5kRcZNdk4ABTgw/g31IyxhbiCB1wDC80GYvK94mxKkOj5EUjlneZxEPx+6x0v2A3t9IFJ9gsJvpQoz837YmoGg7WS1r8R3xj9vApzF9uRBYV/x4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716677692; c=relaxed/simple;
	bh=2So4wsJ4xPrDNuBQCitTz9SGIXIJfHFTKO8rs9jyN9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw+jAzAwe5EV9xXchvfNrKO2mjWp7Xhd6dBv8Tjf3/wOwAfy7Zsp72ZL2CMI6D4VXuh8pdw/If8qhIpbJyk7z4aQFzM8NoU8wrcUYnoCwKoPvOTp/x8aSw/RGlEM56yfcBlooPvaQ/5Y0ymBjfB+SBRzVyz4uTtl3bDpeBrBhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=If8UsvQk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2bf5e0de37bso1394017a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 15:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716677690; x=1717282490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=weBCb6P6ludBpc7zn9AlObj/fNR5H8QjdFVNqQ+luR8=;
        b=If8UsvQk26kOjKdU7XdTom9dZCnZ9j2CFGu3sBdr2T/gr0Euw5nW4J9PKYwA867Lk2
         7ksHMsWOcgq0Tc6eqxm5+sJKXiBgs20Bp1SdQhY97Zg4M1ttt8Yd6LYhKBF4mdchYPIq
         7K6s7tetggiDjGiakhRLjTjQQVrGg7hgTy5GiCdoHNPzD7/En1ukYKz3+fRchWQTQIsZ
         bBu1xeMwkFsDLj9phlLvnx3y3SlBEydjxZDzRsVfSMiuk2bhKGeVK59brUSzjs8ELEHg
         tfRggTYAS6rkncwS6FS1/xRpH1EKDoQQZkElJP9Nm6a9f2R5j5YER3y8n3qwg7nVw1Ao
         ILuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716677690; x=1717282490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weBCb6P6ludBpc7zn9AlObj/fNR5H8QjdFVNqQ+luR8=;
        b=Z7ldtulCRANnu/yEcTMlaDBM3HcTIwX5FWZFL8vDoOMMkZE4bhrpbt79+B2nGhDAcd
         sw3K272mm6JnFuQPrlqJrHVqqfIxHVQMPVSXEmss+KcEYB6JqQAA4161VChO7RGz+eJ2
         IowNPBG204g+BQV1/KW1y1ZvHAjLYC133GtfmdYV2jbuLKwRvZfYMN40f03bbFOjaG7j
         mlupWIeXr1gSX0xM5l1qkG4mqpjPDn/vbSoVv9vEYg9PRrYoICTSZHb7VQx3UPMfj7OB
         /Q9XAYithBh9N4gHd83G1WmflEmmMQDI0PTrJDWbiyzpwOH8PLBJBy2mzQTT2s5g4JIj
         I3aA==
X-Forwarded-Encrypted: i=1; AJvYcCWKJqzTo1LCZ/dXrjhS4Pxdl4/4Df/+dfLbW/F3TvPZtdscQf36Vr8ZcNFhFcqN4JAHo6d4cpnUR0f5qmnEY+TGFWz/EIA8bTjQAFrMIg==
X-Gm-Message-State: AOJu0Yw0cbYA53FQSNlB+wKULQa+OIIeepWVgm+nH5yk4YaL9i8LG9jr
	Rr80Vnk3dY6li5HpNqOnhXc9esOWvmq1nFuhpZuiSALQJFWm6PiCHd1EagKiP0I=
X-Google-Smtp-Source: AGHT+IG/lHGnCD9oi3Dn5lyNWSi2pcasUq9NKxmb3YkVSCkUNu19nH/tHbTv71gxdU7NicaDyWz0tQ==
X-Received: by 2002:a17:903:2447:b0:1f2:f8b7:60d4 with SMTP id d9443c01a7336-1f4497daf6cmr66964375ad.52.1716677689821;
        Sat, 25 May 2024 15:54:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967a62sm34768845ad.120.2024.05.25.15.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 15:54:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sB0Hm-00AU4L-21;
	Sun, 26 May 2024 08:54:46 +1000
Date: Sun, 26 May 2024 08:54:46 +1000
From: Dave Chinner <david@fromorbit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: John Groves <John@groves.net>, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
Message-ID: <ZlJsNir3mBUK0Ofb@dread.disaster.area>
References: <cover.1708709155.git.john@groves.net>
 <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
 <CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com>
 <CAOQ4uxg9WyQ_Ayh7Za_PJ2u_h-ncVUafm5NZqT_dt4oHBMkFQg@mail.gmail.com>
 <kejfka5wyedm76eofoziluzl7pq3prys2utvespsiqzs3uxgom@66z2vs4pe22v>
 <CAJfpegvQefgKOKMWC8qGTDAY=qRmxPvWkg2QKzNUiag1+q5L+Q@mail.gmail.com>
 <l2zbsuyxzwcozrozzk2ywem7beafmidzp545knnrnkxlqxd73u@itmqyy4ao43i>
 <CAJfpegsr-5MU-S4obTsu89=SazuG8zXmO6ymrjn5_BLofSRXdg@mail.gmail.com>
 <sq6fbx5jpzkjw43wyr7zmfnvcw45ah5f4vtz6wtanjai3t4cvk@awxlk72xzzkm>
 <CAJfpeguLoO9ZfmJyqSO-Bma+cTyLaz9rDLv-mtfeNa1qGBww+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguLoO9ZfmJyqSO-Bma+cTyLaz9rDLv-mtfeNa1qGBww+A@mail.gmail.com>

On Fri, May 24, 2024 at 09:55:48AM +0200, Miklos Szeredi wrote:
> On Fri, 24 May 2024 at 02:47, John Groves <John@groves.net> wrote:
> 
> > Apologies, but I'm short on time at the moment - going into a long holiday
> > weekend in the US with family plans. I should be focused again by middle of
> > next week.
> 
> NP.
> 
> Obviously I'll need to test it before anything is merged, other than
> that this is not urgent at all...
> 
> > But can you check /proc/cmdline to see of the memmap arg got through without
> > getting mangled? The '$' tends to get fubar'd. You might need \$, or I've seen
> > the need for \\\$. If it's un-mangled, there should be a dax device.
> 
> /proc/cmdline shows the option correctly:
> 
> root@kvm:~# cat /proc/cmdline
> root=/dev/vda console=hvc0 memmap=4G$4G
> 
> > If that doesn't work, it's worth trying '!' instead, which I think would give
> > you a pmem device - if the arg gets through (but ! is less likely to get
> > horked). That pmem device can be converted to devdax...
> 
> That doesn't work either.  No device created in /dev  (dax or pmem).

I think you need to do some ndctl magic to get the memory to be
namespaced correctly for the correct devices to appear.

https://docs.pmem.io/ndctl-user-guide/managing-namespaces

IIRC, need to set the type to pmem and the mode to fsdax, devdax or
raw to get the relevant device nodes to be created for the range..

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com

